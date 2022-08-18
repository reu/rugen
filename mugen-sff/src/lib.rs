pub mod decoder;
pub use decoder::Decoder;

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub struct SpriteId {
    pub group: u16,
    pub image: u16,
}

impl From<(u16, u16)> for SpriteId {
    fn from((group, image): (u16, u16)) -> Self {
        SpriteId { group, image }
    }
}

impl From<SpriteId> for (u16, u16) {
    fn from(SpriteId { group, image }: SpriteId) -> Self {
        (group, image)
    }
}

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
