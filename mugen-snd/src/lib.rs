pub mod decoder;
pub use decoder::Decoder;

#[derive(Debug, Clone, Copy, Eq, PartialEq)]
pub struct SampleId {
    pub group: u32,
    pub number: u32,
}

impl From<(u32, u32)> for SampleId {
    fn from((group, number): (u32, u32)) -> Self {
        SampleId { group, number }
    }
}

impl From<SampleId> for (u32, u32) {
    fn from(SampleId { group, number }: SampleId) -> Self {
        (group, number)
    }
}
