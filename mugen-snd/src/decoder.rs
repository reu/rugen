use std::{
    borrow::Cow,
    error::Error,
    fmt::Display,
    io::{self, Cursor},
    str::{self, Utf8Error},
};

use byteorder::{LittleEndian, ReadBytesExt};

use crate::SampleId;

#[derive(Debug, Clone)]
pub struct Decoder<'a> {
    samples_count: u32,
    comments: Comments<'a>,
    samples: Vec<Sample<'a>>,
}

#[derive(Debug)]
pub enum DecodeError {
    InvalidData(io::Error),
    InvalidSignature,
    SampleCountMismatch {
        expected_count: u32,
        found_count: u32,
    },
}

impl Display for DecodeError {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            DecodeError::InvalidData(err) => err.fmt(f),
            DecodeError::InvalidSignature => write!(f, "invalid signature"),
            DecodeError::SampleCountMismatch {
                expected_count,
                found_count,
            } => write!(f, "expected {expected_count} samples, found {found_count}"),
        }
    }
}

impl Error for DecodeError {
    fn source(&self) -> Option<&(dyn Error + 'static)> {
        match self {
            DecodeError::InvalidData(ref err) => Some(err),
            _ => None,
        }
    }
}

impl From<io::Error> for DecodeError {
    fn from(error: io::Error) -> Self {
        DecodeError::InvalidData(error)
    }
}

impl<'a> Decoder<'a> {
    pub fn decode(data: &'a [u8]) -> Result<Self, DecodeError> {
        if &data[0..12] != b"ElecbyteSnd\0" {
            return Err(DecodeError::InvalidSignature);
        }

        let mut bytes = Cursor::new(&data);
        bytes.set_position(16);

        let samples_count = bytes.read_u32::<LittleEndian>()?;
        let first_subfile_offset = bytes.read_u32::<LittleEndian>()?;
        let subfile_header_size = 15;
        let comments = Comments(&data[24..511]);

        let mut samples = Vec::with_capacity(samples_count as usize);
        let mut next_subfile_offset = Some(first_subfile_offset);
        let total_size = data.len() as u32;
        while let Some(offset) = next_subfile_offset.take() {
            bytes.set_position(offset.into());

            next_subfile_offset = bytes.read_u32::<LittleEndian>().ok().and_then(|n| match n {
                n if n > 0 && n + subfile_header_size <= total_size => Some(n),
                _ => None,
            });

            let size = bytes.read_u32::<LittleEndian>()? as usize;
            let group = bytes.read_u32::<LittleEndian>()?;
            let number = bytes.read_u32::<LittleEndian>()?;

            let data_offset = bytes.position() as usize;

            samples.push(Sample {
                id: SampleId { group, number },
                data: Cow::Borrowed(&data[data_offset..data_offset + size]),
            });
        }

        if samples.len() != samples_count as usize {
            return Err(DecodeError::SampleCountMismatch {
                expected_count: samples_count,
                found_count: samples.len() as u32,
            });
        }

        Ok(Decoder {
            samples_count,
            comments,
            samples,
        })
    }

    pub fn comments(&self) -> &Comments {
        &self.comments
    }

    pub fn samples_count(&self) -> u32 {
        self.samples_count
    }

    pub fn samples(&self) -> impl Iterator<Item = &Sample> {
        self.samples.iter()
    }
}

impl<'a> IntoIterator for Decoder<'a> {
    type Item = Sample<'a>;
    type IntoIter = std::vec::IntoIter<Self::Item>;

    fn into_iter(self) -> Self::IntoIter {
        self.samples.into_iter()
    }
}

#[derive(Debug, Clone)]
pub struct Sample<'a> {
    id: SampleId,
    data: Cow<'a, [u8]>,
}

impl<'a> Sample<'a> {
    pub fn id(&self) -> SampleId {
        self.id
    }

    pub fn raw_data(&self) -> &[u8] {
        &self.data
    }

    pub fn to_owned(&self) -> Sample<'static> {
        Sample {
            id: self.id,
            data: Cow::Owned(self.raw_data().to_owned()),
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
