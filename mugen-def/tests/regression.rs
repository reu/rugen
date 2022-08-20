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
fn test_chris_cmd() {
    test_def_file!("examples/chris.cmd");
}

#[test]
fn test_chris_cns() {
    test_def_file!("examples/chris.cns");
}

#[test]
fn test_chris_def() {
    test_def_file!("examples/chris.def");
}

#[test]
fn test_joe_cmd() {
    test_def_file!("examples/joe.cmd");
}

#[test]
fn test_joe_cns() {
    test_def_file!("examples/joe.cns");
}

#[test]
fn test_joe_def() {
    test_def_file!("examples/joe.def");
}

#[test]
fn test_rock_cmd() {
    test_def_file!("examples/rock.cmd");
}

#[test]
fn test_rock_cns() {
    test_def_file!("examples/rock.cns");
}

#[test]
fn test_rock_def() {
    test_def_file!("examples/rock.def");
}
