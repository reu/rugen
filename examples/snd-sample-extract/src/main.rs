use std::{env, error::Error, fs, path::Path};

fn main() -> Result<(), Box<dyn Error>> {
    let args = env::args().collect::<Vec<_>>();

    let snd_path = Path::new(args.get(1).expect("No SND file informed"));

    let output_path = args
        .get(2)
        .map(Path::new)
        .map(|path| path.to_path_buf())
        .unwrap_or_else(|| match snd_path.extension() {
            Some(_) => snd_path.with_extension(""),
            _ => snd_path.with_extension("sounds"),
        });

    let snd = fs::read(snd_path).expect("Failed to read SND file");
    let snd = mugen_snd::Decoder::decode(&snd)?;

    fs::create_dir_all(&output_path)?;

    for sample in snd {
        let file_name = format!("{}-{}.wav", sample.id().group, sample.id().number);
        fs::write(output_path.join(file_name), sample.raw_data())?;
    }

    Ok(())
}
