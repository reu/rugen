use std::io::{self, Cursor, Read};

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
}

#[derive(Debug)]
pub enum DecodeError {
    InvalidData(io::Error),
    InvalidSignature,
    UnsuporttedVersion(Version),
    InvalidPaletteKind,
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

        Ok(Decoder {
            version,
            groups_count,
            images_count,
            palette_kind,
            first_subfile_offset,
            subfile_header_size,
            comments,
        })
    }
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
}
