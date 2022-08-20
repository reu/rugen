use mugen_def::Def;

macro_rules! test_def_file {
    ($air:expr) => {
        let air = include_str!($air).parse::<Def>();
        if let Err(ref err) = air {
            assert!(air.is_ok(), "{:?}", err);
        }
    };
}

#[test]
fn test_rock_def() {
    test_def_file!("examples/rock.def");
}
