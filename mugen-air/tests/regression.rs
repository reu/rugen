use mugen_air::parse_air;

macro_rules! test_air_file {
    ($air:expr) => {
        let air = parse_air(include_str!($air));
        if let Err(ref err) = air {
            assert!(air.is_ok(), "{:?}", err);
        }
    };
}

#[test]
fn test_chris() {
    test_air_file!("examples/chris.air");
}

#[test]
fn test_joe() {
    test_air_file!("examples/joe.air");
}

#[test]
fn test_neokyo() {
    test_air_file!("examples/neokyo.air");
}

#[test]
fn test_rock() {
    test_air_file!("examples/rock.air");
}

#[test]
fn test_ryusf3() {
    test_air_file!("examples/ryusf3.air");
}

#[test]
fn test_shermie() {
    test_air_file!("examples/shermie.air");
}

#[test]
fn test_shingo() {
    test_air_file!("examples/shingo.air");
}
