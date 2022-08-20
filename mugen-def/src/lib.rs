use std::{collections::HashMap, str::FromStr};

use nom::{
    branch::alt,
    bytes::complete::{is_not, tag, take_while},
    character::complete::{char, line_ending, multispace0, space0},
    combinator::{eof, map, value},
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
    let (i, sections) = terminated(many0(section), ending)(i)?;

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
    let (i, name) = delimited(
        tuple((multispace0, many0(comment_or_eol), multispace0)),
        section_name,
        tuple((space0, comment_or_eol)),
    )(i)?;
    let (i, kvs) = many0(preceded(
        tuple((multispace0, many0(comment_or_eol), multispace0)),
        key_val,
    ))(i)?;
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

fn comment(i: Span) -> ParseResult<LocatedSpan<&str>> {
    preceded(tag(";"), is_not("\n"))(i)
}

fn comment_or_eol(i: Span) -> ParseResult<LocatedSpan<&str>> {
    alt((comment, line_ending, eof))(i)
}

fn ending(i: Span) -> ParseResult<Span> {
    alt((
        eof,
        value("".into(), tuple((multispace0, eof))),
        value(
            "".into(),
            tuple((multispace0, many0(comment_or_eol), multispace0, eof)),
        ),
    ))(i)
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

    #[test]
    fn it_parses_empty_vals() {
        let text = indoc! {"
            [section]
            prop1 = val1
            prop2 =
            prop3 = val3
        "};
        let def = text.parse::<Def>();
        assert!(def.is_ok());
        let def = def.unwrap();
        assert_eq!(def.get("section", "prop1"), Some("val1"));
        assert_eq!(def.get("section", "prop2"), Some(""));
        assert_eq!(def.get("section", "prop3"), Some("val3"));
    }

    #[test]
    fn it_ignores_comments() {
        let text = indoc! {"
            [section] ; Comment
            prop1 = val1; Comment
            prop2 =; Comment
            prop3 = val3 ; Comment
        "};
        assert!(text.parse::<Def>().is_ok());

        let text = indoc! {"
            [section]
            ; Comment
            prop1 = val1
            ; Comment
            prop2 =
            ; Comment
            prop3 = val3
        "};
        assert!(text.parse::<Def>().is_ok());

        let text = indoc! {"
            ; Comment
            [section]
            prop1 = val1
            prop2 =
            prop3 = val3
        "};
        assert!(text.parse::<Def>().is_ok());

        let text = indoc! {"
            ; Comment
            [section]
            prop1 = val1
            prop2 =
            prop3 = val3

            ; Comment

            ; Comment
            [section]
            ; Comment
            prop1 = val1
            prop2 =
            ; Comment
            prop3 = val3
        "};
        assert!(text.parse::<Def>().is_ok());
    }
}
