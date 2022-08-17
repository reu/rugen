use std::io::{self, Cursor, Read, Seek, SeekFrom};

use byteorder::{LittleEndian, ReadBytesExt};

use crate::{PaletteKind, Version};

#[derive(Debug, Clone)]
pub struct Decoder {
    pub version: Version,
    pub groups_count: u32,
    pub images_count: u32,
    pub palette_kind: PaletteKind,
    pub first_subfile_offset: u32,
    pub subfile_header_size: u32,
    pub comments: [u8; 476],
    pub sprites: Vec<Sprite>,
}

#[derive(Debug)]
pub enum DecodeError {
    InvalidData(io::Error),
    InvalidSignature,
    UnsuporttedVersion(Version),
    InvalidPaletteKind,
    PreviousPaletteNotFound,
}

impl From<io::Error> for DecodeError {
    fn from(error: io::Error) -> Self {
        DecodeError::InvalidData(error)
    }
}

impl Decoder {
    pub fn decode(data: &[u8]) -> Result<Self, DecodeError> {
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

        bytes.set_position(36);
        let mut comments = [0; 476];
        bytes.read_exact(&mut comments)?;

        let mut images: Vec<Sprite> = Vec::with_capacity(images_count as usize);
        let mut next_subfile_offset = Some(first_subfile_offset);
        let mut previous_palette: Option<Vec<u8>> = None;
        let total_size = data.len() as u32;
        while let Some(offset) = next_subfile_offset.take() {
            bytes.set_position(offset.into());

            next_subfile_offset = bytes.read_u32::<LittleEndian>().ok().and_then(|n| match n {
                n if n > 0 && n + subfile_header_size <= total_size => Some(n),
                _ => None,
            });

            let size = bytes.read_u32::<LittleEndian>()?;
            let x = bytes.read_i16::<LittleEndian>()?;
            let y = bytes.read_i16::<LittleEndian>()?;
            let group = bytes.read_u16::<LittleEndian>()?;
            let image = bytes.read_u16::<LittleEndian>()?;
            // TODO: add support for linked sprites
            let _linked_index = bytes.read_u16::<LittleEndian>()?;
            let use_previous_palette = bytes.read_u8()? != 0;

            bytes.seek(SeekFrom::Current(13))?;

            let palette = match previous_palette {
                None if use_previous_palette => return Err(DecodeError::PreviousPaletteNotFound),
                Some(ref palette) if use_previous_palette => palette.clone(),
                _ => {
                    let position = bytes.position();

                    let mut palette_data = Vec::new();
                    palette_data.resize(256 * 3, 0);
                    bytes.read_exact(&mut palette_data)?;
                    previous_palette = Some(palette_data.clone());

                    bytes.set_position(position);

                    palette_data
                }
            };

            let mut sprite = Vec::new();
            sprite.resize(size as usize, 0);
            bytes.read_exact(&mut sprite)?;

            images.push(Sprite {
                data: sprite,
                palette,
                coordinates: (x, y),
                group,
                image,
            });
        }

        Ok(Decoder {
            version,
            groups_count,
            images_count,
            palette_kind,
            first_subfile_offset,
            subfile_header_size,
            comments,
            sprites: images,
        })
    }
}

#[derive(Debug, Clone)]
pub struct Sprite {
    pub data: Vec<u8>,
    pub palette: Vec<u8>,
    pub coordinates: (i16, i16),
    pub group: u16,
    pub image: u16,
}

#[cfg(test)]
mod tests {
    use crate::{decoder::Decoder, PaletteKind, Version};

    #[test]
    fn decode_headers() {
        let sff = include_bytes!("../tests/samples/sample/sample.sff");
        let sff = Decoder::decode(sff).unwrap();

        assert_eq!(Version(1, 0, 1, 0), sff.version);
        assert_eq!(4, sff.groups_count);
        assert_eq!(8, sff.images_count);
        assert_eq!(PaletteKind::Shared, sff.palette_kind);
        assert_eq!(
            Ok("Some comment"),
            std::str::from_utf8(&sff.comments).map(|c| c.trim_end_matches('\u{0}'))
        );
    }

    #[test]
    fn decode_sprites() {
        let sff = include_bytes!("../tests/samples/sample/sample.sff");
        let sff = Decoder::decode(sff).unwrap();

        assert_eq!(8, sff.sprites.len());
        assert_eq!(
            [&sff.sprites[0].data[..], &sff.sprites[0].palette[..]].concat(),
            include_bytes!("../tests/samples/sample/sample-0-0.pcx")
        );
    }
}
