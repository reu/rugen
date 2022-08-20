use std::{collections::HashMap, str::FromStr};

use nom::{
    bytes::complete::{tag, take_while},
    character::complete::{char, line_ending, multispace0, space0},
    combinator::{eof, map},
    multi::many0,
    sequence::{delimited, preceded, terminated, tuple},
    Finish, IResult,
};
use nom_locate::LocatedSpan;

type Span<'a> = LocatedSpan<&'a str>;
type ParseResult<'a, T> = IResult<Span<'a>, T>;

#[derive(Debug, Clone)]
pub struct Def(HashMap<String, HashMap<String, String>>);

impl Def {
    pub fn get(&self, section: &str, prop: &str) -> Option<&str> {
        self.0
            .get(section)
            .and_then(|s| s.get(prop).map(|s| s.as_str()))
    }
}

impl From<Def> for HashMap<String, HashMap<String, String>> {
    fn from(def: Def) -> Self {
        def.0
    }
}

#[derive(Debug)]
pub struct ParseError {
    pub line: u32,
}

impl FromStr for Def {
    type Err = ParseError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match sections(s.into()).finish() {
            Ok((_, action)) => Ok(action),
            Err(err) => Err(ParseError {
                line: err.input.location_line(),
            }),
        }
    }
}

fn sections(i: Span) -> ParseResult<Def> {
    let (i, sections) = terminated(many0(section), eof)(i)?;

    let mut def = HashMap::new();

    for (name, section) in sections {
        def.insert(
            name.to_string(),
            section
                .into_iter()
                .map(|(k, v)| (k.to_string(), v.to_string()))
                .collect(),
        );
    }

    Ok((i, Def(def)))
}

fn section(i: Span) -> ParseResult<(Span, Vec<(Span, Span)>)> {
    let (i, name) = terminated(section_name, tuple((space0, line_ending)))(i)?;
    let (i, kvs) = many0(delimited(multispace0, key_val, multispace0))(i)?;
    Ok((i, (name, kvs)))
}

fn section_name(i: Span) -> ParseResult<Span> {
    delimited(char('['), take_while(|c| c != ']' && c != '\n'), char(']'))(i)
}

fn key_val(i: Span) -> ParseResult<(Span, Span)> {
    let (i, key) = map(take_while(|c| c != '=' && c != '\n'), |s: Span| {
        s.trim().into()
    })(i)?;
    let (i, _) = preceded(space0, tag("="))(i)?;
    let (i, val) = map(take_while(|c| c != '\n'), |s: Span| s.trim().into())(i)?;
    Ok((i, (key, val)))
}

#[cfg(test)]
mod tests {
    use indoc::indoc;

    use super::*;

    #[test]
    fn it_shows_location_of_the_error() {
        let text = "invalid";
        let error = text.parse::<Def>().err().unwrap();
        assert_eq!(error.line, 1);

        let text = indoc! {"
            [section]
            prop = val
            invalid
        "};
        let error = text.parse::<Def>().err().unwrap();
        assert_eq!(error.line, 3);

        let text = indoc! {"
            [section1]
            prop = val

            [section2]
            prop = val

            [section3]
            prop = val
            prop

            [section4]
            prop = val
        "};
        let error = text.parse::<Def>().err().unwrap();
        assert_eq!(error.line, 9);
    }

    #[test]
    fn it_parses_sections() {
        let text = indoc! {"
            [section]
            prop1 = val1
            prop2 = val2
        "};
        let def = text.parse::<Def>();
        assert!(def.is_ok());
        let def = def.unwrap();
        assert_eq!(def.get("section", "prop1"), Some("val1"));
        assert_eq!(def.get("section", "prop2"), Some("val2"));

        let text = indoc! {"
            [section1]
            prop1 = val1
            prop2 = val2

            [section2]
            prop3 = val3
        "};
        let def = dbg!(text.parse::<Def>());
        assert!(def.is_ok());
        let def = def.unwrap();
        assert_eq!(def.get("section1", "prop1"), Some("val1"));
        assert_eq!(def.get("section1", "prop2"), Some("val2"));
        assert_eq!(def.get("section2", "prop3"), Some("val3"));
    }
}
