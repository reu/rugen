use std::{
    borrow::Cow,
    io::{self, Cursor, Seek, SeekFrom},
    str::{self, Utf8Error},
};

use byteorder::{LittleEndian, ReadBytesExt};

use crate::{PaletteKind, SpriteId, Version};

#[derive(Debug, Clone)]
pub struct Decoder<'a> {
    version: Version,
    groups_count: u32,
    images_count: u32,
    palette_kind: PaletteKind,
    comments: Comments<'a>,
    sprites: Vec<Sprite<'a>>,
}

#[derive(Debug)]
pub enum DecodeError {
    InvalidData(io::Error),
    InvalidSignature,
    UnsuporttedVersion(Version),
    InvalidPaletteKind,
    PreviousPaletteNotFound,
    LinkedSpriteNotFound {
        sprite_id: SpriteId,
        linked_index: u16,
    },
}

impl From<io::Error> for DecodeError {
    fn from(error: io::Error) -> Self {
        DecodeError::InvalidData(error)
    }
}

impl<'a> Decoder<'a> {
    pub fn decode(data: &'a [u8]) -> Result<Self, DecodeError> {
        if &data[0..12] != b"ElecbyteSpr\0" {
            return Err(DecodeError::InvalidSignature);
        }

        let mut bytes = Cursor::new(&data);
        bytes.set_position(12);

        let version_low3 = bytes.read_u8()?;
        let version_low2 = bytes.read_u8()?;
        let version_low1 = bytes.read_u8()?;
        let version_high = bytes.read_u8()?;
        let version = Version(version_high, version_low1, version_low2, version_low3);
        if version_high != 1 {
            return Err(DecodeError::UnsuporttedVersion(version));
        }

        let groups_count = bytes.read_u32::<LittleEndian>()?;
        let images_count = bytes.read_u32::<LittleEndian>()?;
        let first_subfile_offset = bytes.read_u32::<LittleEndian>()?;
        let subfile_header_size = bytes.read_u32::<LittleEndian>()?;
        let palette_kind = match bytes.read_u8()? {
            0 => PaletteKind::Individual,
            1 => PaletteKind::Shared,
            _ => return Err(DecodeError::InvalidPaletteKind),
        };

        let comments = Comments(&data[36..511]);

        let mut images: Vec<Sprite> = Vec::with_capacity(images_count as usize);
        let mut next_subfile_offset = Some(first_subfile_offset);
        let mut previous_palette_offset = None;
        let total_size = data.len() as u32;
        while let Some(offset) = next_subfile_offset.take() {
            bytes.set_position(offset.into());

            next_subfile_offset = bytes.read_u32::<LittleEndian>().ok().and_then(|n| match n {
                n if n > 0 && n + subfile_header_size <= total_size => Some(n),
                _ => None,
            });

            let size = bytes.read_u32::<LittleEndian>()? as usize;
            let x = bytes.read_i16::<LittleEndian>()?;
            let y = bytes.read_i16::<LittleEndian>()?;
            let group = bytes.read_u16::<LittleEndian>()?;
            let image = bytes.read_u16::<LittleEndian>()?;
            let linked_index = bytes.read_u16::<LittleEndian>()?;
            let use_previous_palette = bytes.read_u8()? != 0;

            bytes.seek(SeekFrom::Current(13))?;

            let sprite_id = SpriteId { group, image };
            let coordinates = Coordinates { x, y };

            let data_offset = bytes.position() as usize;
            let palette_size = 256 * 3;

            let (data_size, palette_offset) = match previous_palette_offset {
                None if use_previous_palette => return Err(DecodeError::PreviousPaletteNotFound),
                Some(offset) if use_previous_palette => (size, offset),
                _ => {
                    let offset = (data_offset + size) - palette_size;
                    previous_palette_offset = Some(offset);
                    (size - palette_size, offset)
                }
            };

            let sprite = if size == 0 {
                let linked_sprite =
                    images
                        .get(linked_index as usize)
                        .ok_or(DecodeError::LinkedSpriteNotFound {
                            sprite_id,
                            linked_index,
                        })?;

                Sprite {
                    id: sprite_id,
                    coordinates,
                    ..linked_sprite.clone()
                }
            } else {
                Sprite {
                    id: sprite_id,
                    data: Cow::Borrowed(&data[data_offset..data_offset + data_size]),
                    palette: Cow::Borrowed(&data[palette_offset..palette_offset + palette_size]),
                    coordinates,
                }
            };

            images.push(sprite);
        }

        Ok(Decoder {
            version,
            groups_count,
            images_count,
            palette_kind,
            comments,
            sprites: images,
        })
    }

    pub fn comments(&self) -> &Comments {
        &self.comments
    }

    pub fn palette_kind(&self) -> PaletteKind {
        self.palette_kind
    }

    pub fn version(&self) -> Version {
        self.version
    }

    pub fn groups_count(&self) -> u32 {
        self.groups_count
    }

    pub fn images_count(&self) -> u32 {
        self.images_count
    }

    pub fn sprites(&self) -> impl Iterator<Item = Sprite> {
        self.sprites.iter().cloned()
    }
}

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub struct Coordinates {
    pub x: i16,
    pub y: i16,
}

impl From<(i16, i16)> for Coordinates {
    fn from((x, y): (i16, i16)) -> Self {
        Self { x, y }
    }
}

impl From<Coordinates> for (i16, i16) {
    fn from(Coordinates { x, y }: Coordinates) -> Self {
        (x, y)
    }
}

#[derive(Debug, Clone)]
pub struct Sprite<'a> {
    id: SpriteId,
    data: Cow<'a, [u8]>,
    palette: Cow<'a, [u8]>,
    coordinates: Coordinates,
}

impl<'a> Sprite<'a> {
    pub fn id(&self) -> SpriteId {
        self.id
    }

    pub fn coordinates(&self) -> Coordinates {
        self.coordinates
    }

    pub fn raw_data(&self) -> &[u8] {
        &self.data
    }

    pub fn palette(&self) -> &[u8] {
        &self.palette
    }

    pub fn to_owned(&self) -> Sprite<'static> {
        Sprite {
            id: self.id,
            data: Cow::Owned(self.raw_data().to_owned()),
            palette: Cow::Owned(self.palette().to_owned()),
            coordinates: self.coordinates,
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Comments<'a>(&'a [u8]);

impl<'a> Comments<'a> {
    pub fn as_str(&self) -> Result<&str, Utf8Error> {
        Ok(str::from_utf8(self.0)?.trim_end_matches('\u{0}'))
    }
}

#[cfg(test)]
mod tests {
    use crate::{decoder::Decoder, PaletteKind, Version};

    #[test]
    fn decode_headers() {
        let sff = include_bytes!("../tests/samples/sample/sample.sff");
        let sff = Decoder::decode(sff).unwrap();

        assert_eq!(Version(1, 0, 1, 0), sff.version());
        assert_eq!(4, sff.groups_count());
        assert_eq!(8, sff.images_count());
        assert_eq!(PaletteKind::Shared, sff.palette_kind());
        assert_eq!(Ok("Some comment"), sff.comments().as_str());
    }

    #[test]
    fn decode_sprites() {
        let sff = include_bytes!("../tests/samples/sample/sample.sff");
        let sff = Decoder::decode(sff).unwrap();

        let sprites = sff.sprites().collect::<Vec<_>>();

        assert_eq!(8, sprites.len());

        assert_eq!(sprites[0].id, (0, 0).into());
        assert_eq!(sprites[0].coordinates, (0, 0).into());
        assert_eq!(
            [sprites[0].raw_data(), sprites[0].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-0-0.pcx")
        );

        assert_eq!(sprites[1].id, (0, 1).into());
        assert_eq!(sprites[1].coordinates, (-50, -50).into());
        assert_eq!(
            [sprites[1].raw_data(), sprites[1].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-0-1.pcx")
        );

        assert_eq!(sprites[2].id, (1, 0).into());
        assert_eq!(sprites[2].coordinates, (-50, -50).into());
        assert_eq!(
            [sprites[2].raw_data(), sprites[2].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-1-0.pcx")
        );

        assert_eq!(sprites[3].id, (1, 1).into());
        assert_eq!(sprites[3].coordinates, (0, 0).into());
        assert_eq!(
            [sprites[3].raw_data(), sprites[3].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-1-1.pcx")
        );

        assert_eq!(sprites[4].id, (10, 10).into());
        assert_eq!(sprites[4].coordinates, (0, 0).into());
        assert_eq!(
            [sprites[4].raw_data(), sprites[4].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-10-10.pcx")
        );

        assert_eq!(sprites[5].id, (10, 20).into());
        assert_eq!(sprites[5].coordinates, (-100, -100).into());
        assert_eq!(
            [sprites[5].raw_data(), sprites[5].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-10-20.pcx")
        );

        assert_eq!(sprites[6].id, (50, 0).into());
        assert_eq!(sprites[6].coordinates, (-200, -200).into());
        assert_eq!(
            [sprites[6].raw_data(), sprites[6].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-50-0.pcx")
        );

        assert_eq!(sprites[7].id, (50, 5).into());
        assert_eq!(sprites[7].coordinates, (-200, -200).into());
        assert_eq!(
            [sprites[7].raw_data(), sprites[7].palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-50-5.pcx")
        );
    }

    #[test]
    fn decode_linked_sprites() {
        let sff = include_bytes!("../tests/samples/sample/linked.sff");
        let sff = Decoder::decode(sff).unwrap();

        let sprites = sff.sprites().collect::<Vec<_>>();

        assert_eq!(8, sprites.len());

        assert_eq!(sprites[0].id, (0, 0).into());
        assert_eq!(sprites[0].coordinates, (0, 0).into());
        assert_eq!(
            [sprites[0].raw_data(), sprites[0].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-0.pcx")
        );

        assert_eq!(sprites[1].id, (0, 1).into());
        assert_eq!(sprites[1].coordinates, (-50, -50).into());
        assert_eq!(
            [sprites[1].raw_data(), sprites[1].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-0.pcx")
        );

        assert_eq!(sprites[2].id, (1, 0).into());
        assert_eq!(sprites[2].coordinates, (-50, -50).into());
        assert_eq!(
            [sprites[2].raw_data(), sprites[2].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-0.pcx")
        );

        assert_eq!(sprites[3].id, (1, 1).into());
        assert_eq!(sprites[3].coordinates, (0, 0).into());
        assert_eq!(
            [sprites[3].raw_data(), sprites[3].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-0.pcx")
        );

        assert_eq!(sprites[4].id, (10, 10).into());
        assert_eq!(sprites[4].coordinates, (0, 0).into());
        assert_eq!(
            [sprites[4].raw_data(), sprites[4].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-1.pcx")
        );

        assert_eq!(sprites[5].id, (10, 20).into());
        assert_eq!(sprites[5].coordinates, (-100, -100).into());
        assert_eq!(
            [sprites[5].raw_data(), sprites[5].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-1.pcx")
        );

        assert_eq!(sprites[6].id, (50, 0).into());
        assert_eq!(sprites[6].coordinates, (-200, -200).into());
        assert_eq!(
            [sprites[6].raw_data(), sprites[6].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-2.pcx")
        );

        assert_eq!(sprites[7].id, (50, 5).into());
        assert_eq!(sprites[7].coordinates, (-200, -200).into());
        assert_eq!(
            [sprites[7].raw_data(), sprites[7].palette()].concat(),
            include_bytes!("../tests/samples/sample/linked-2.pcx")
        );
    }

    #[test]
    fn sprite_can_be_owned() {
        let sff = include_bytes!("../tests/samples/sample/sample.sff");
        let sff = Decoder::decode(sff).unwrap();

        let sprite = sff.sprites().next().unwrap();
        let sprite = sprite.to_owned();

        drop(sff);

        assert_eq!(
            [sprite.raw_data(), sprite.palette()].concat(),
            include_bytes!("../tests/samples/sample/sample-0-0.pcx")
        );
    }
}
