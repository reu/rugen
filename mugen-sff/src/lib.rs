pub mod decoder;

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub enum PaletteKind {
    Individual = 0,
    Shared = 1,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Version(u8, u8, u8, u8);

impl From<Version> for (u8, u8, u8, u8) {
    fn from(v: Version) -> Self {
        (v.0, v.1, v.2, v.3)
    }
}
