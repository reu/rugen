use std::{env, error::Error, fs, path::Path};

use image::{ImageFormat, RgbaImage};

fn main() -> Result<(), Box<dyn Error>> {
    let args = env::args().collect::<Vec<_>>();

    let sff_path = Path::new(args.get(1).expect("No SFF file informed"));

    let output_path = args
        .get(2)
        .map(Path::new)
        .map(|path| path.to_path_buf())
        .unwrap_or_else(|| match sff_path.extension() {
            Some(_) => sff_path.with_extension(""),
            _ => sff_path.with_extension("sprites"),
        });

    let sff = fs::read(sff_path).expect("Failed to read SFF file");
    let sff = mugen_sff::Decoder::decode(&sff)?;

    fs::create_dir_all(&output_path)?;

    for sprite in sff {
        let mut pcx = pcx::Reader::new(sprite.raw_data())?;

        let width = pcx.width() as usize;
        let height = pcx.height() as usize;

        let palette = sprite
            .palette()
            .chunks_exact(3)
            .map(|i| [i[0], i[1], i[2], 255])
            .collect::<Vec<_>>();

        let mut data = vec![0; width * height];
        for row in 0..height {
            pcx.next_row_paletted(&mut data[row * width..row * width + width])?;
        }

        let rgba = data
            .into_iter()
            .flat_map(|i| match i as usize {
                0 => [0, 0, 0, 0],
                i => palette[i],
            })
            .collect::<Vec<_>>();

        let img = RgbaImage::from_raw(width as u32, height as u32, rgba).ok_or("invalid sprite")?;

        let file_name = format!("{}-{}.png", sprite.id().group, sprite.id().image);
        img.save_with_format(output_path.join(file_name), ImageFormat::Png)?;
    }

    Ok(())
}
