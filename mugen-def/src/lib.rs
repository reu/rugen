use std::{borrow::Cow, collections::HashMap, iter, str::FromStr};

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
pub struct Def(Vec<(String, Vec<(String, String)>)>);

impl Def {
    pub fn get(&self, section: &str, prop: &str) -> Option<&str> {
        self.0
            .iter()
            .find(|(s, _)| s == section)
            .map(|(_, props)| props)
            .and_then(|props| props.iter().find(|(k, _)| k == prop))
            .map(|(_, v)| v.as_str())
    }

    pub fn get_all(&self, section: &str, prop: &str) -> Option<Vec<&str>> {
        self.0
            .iter()
            .find(|(s, _)| s == section)
            .map(|(_, props)| props)
            .map(|props| {
                props
                    .iter()
                    .filter_map(|(k, v)| if k == prop { Some(v.as_str()) } else { None })
                    .collect()
            })
    }

    pub fn to_map(&self) -> DefMap {
        self.into()
    }
}

impl IntoIterator for Def {
    type Item = (String, Vec<(String, String)>);
    type IntoIter = std::vec::IntoIter<Self::Item>;

    fn into_iter(self) -> Self::IntoIter {
        self.0.into_iter()
    }
}

#[derive(Debug, Clone)]
enum DefVal<'a> {
    // Since it is rather unusual for a property to be repeated more than 3 times, we spare some
    // heap allocations here
    One([Cow<'a, str>; 1]),
    Two([Cow<'a, str>; 2]),
    Three([Cow<'a, str>; 3]),
    Many(Vec<Cow<'a, str>>),
}

impl<'a> DefVal<'a> {
    fn new(val: &'a str) -> Self {
        Self::One([Cow::Borrowed(val)])
    }

    fn append(&mut self, val: Cow<'a, str>) {
        match self {
            DefVal::One([v]) => {
                *self = DefVal::Two([v.clone(), val]);
            }
            DefVal::Two([v1, v2]) => {
                *self = DefVal::Three([v1.clone(), v2.clone(), val]);
            }
            DefVal::Three([v1, v2, v3]) => {
                *self = DefVal::Many([v1.clone(), v2.clone(), v3.clone(), val].into());
            }
            DefVal::Many(vals) => {
                vals.push(val);
            }
        }
    }

    fn to_owned(&self) -> DefVal<'static> {
        match self {
            Self::One([v]) => DefVal::One([v.to_string().into()]),
            Self::Two([v1, v2]) => DefVal::Two([v1.to_string().into(), v2.to_string().into()]),
            Self::Three([v1, v2, v3]) => DefVal::Three([
                v1.to_string().into(),
                v2.to_string().into(),
                v3.to_string().into(),
            ]),
            Self::Many(vals) => DefVal::Many(vals.iter().map(|v| v.to_string().into()).collect()),
        }
    }
}

pub struct DefMap<'a>(HashMap<Cow<'a, str>, HashMap<Cow<'a, str>, DefVal<'a>>>);

impl<'a> From<&'a Def> for DefMap<'a> {
    fn from(def: &'a Def) -> Self {
        let mut map: HashMap<Cow<str>, HashMap<Cow<str>, DefVal>> = HashMap::new();

        for (section, props) in def.0.iter() {
            map.entry(section.as_str().into())
                .and_modify(|sec| {
                    for (prop, val) in props {
                        sec.entry(prop.into())
                            .and_modify(|prop| prop.append(Cow::Borrowed(val)))
                            .or_insert_with(|| DefVal::new(val));
                    }
                })
                .or_insert({
                    let mut sec: HashMap<Cow<str>, DefVal> = HashMap::new();
                    for (prop, val) in props.iter() {
                        sec.entry(prop.as_str().into())
                            .and_modify(|prop| prop.append(Cow::Borrowed(val)))
                            .or_insert_with(|| DefVal::new(val));
                    }
                    sec
                });
        }
        DefMap(map)
    }
}

impl<'a> DefMap<'a> {
    pub fn get(&self, section: &str, prop: &str) -> Option<&str> {
        self.0
            .get(section)
            .and_then(|props| props.get(prop))
            .map(|val| match val {
                DefVal::One([val]) => val.as_ref(),
                DefVal::Two([val, ..]) => val.as_ref(),
                DefVal::Three([val, ..]) => val.as_ref(),
                DefVal::Many(vals) => vals[0].as_ref(),
            })
    }

    pub fn get_all(&'a self, section: &str, prop: &str) -> Box<dyn Iterator<Item = &'a str> + 'a> {
        self.0
            .get(section)
            .and_then(|props| props.get(prop))
            .map(|val| -> Box<dyn Iterator<Item = &str>> {
                match val {
                    DefVal::One(val) => Box::new(val.iter().map(|a| a.as_ref())),
                    DefVal::Two(val) => Box::new(val.iter().map(|a| a.as_ref())),
                    DefVal::Three(val) => Box::new(val.iter().map(|a| a.as_ref())),
                    DefVal::Many(val) => Box::new(val.iter().map(|a| a.as_ref())),
                }
            })
            .unwrap_or_else(|| Box::new(iter::empty()))
    }

    pub fn to_owned(&self) -> DefMap<'static> {
        DefMap(
            self.0
                .iter()
                .map(|(name, section)| {
                    (
                        name.to_string().into(),
                        section
                            .iter()
                            .map(|(prop, val)| (prop.to_string().into(), val.to_owned()))
                            .collect(),
                    )
                })
                .collect(),
        )
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

    let sections = sections.into_iter().map(|(name, props)| {
        (
            name.to_string(),
            props
                .into_iter()
                .map(|(k, v)| (k.to_string(), v.to_string()))
                .collect(),
        )
    });

    Ok((i, Def(sections.collect())))
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
    fn it_parses_sections_with_the_same_name() {
        let text = indoc! {"
            [section]
            prop = val
            [section]
            prop = val
        "};
        let def = text.parse::<Def>();
        assert!(def.is_ok());
        let sections = def.unwrap().into_iter().collect::<Vec<_>>();
        assert_eq!(sections.len(), 2);
        assert_eq!(sections[0].0, "section");
        assert_eq!(sections[0].1, &[("prop".into(), "val".into())]);
        assert_eq!(sections[1].0, "section");
        assert_eq!(sections[1].1, &[("prop".into(), "val".into())]);
    }

    #[test]
    fn it_parses_properties_with_the_same_name() {
        let text = indoc! {"
            [section]
            prop = val1
            prop = val2
        "};
        let def = text.parse::<Def>();
        assert!(def.is_ok());
        let def = def.unwrap();
        assert_eq!(def.get_all("section", "prop"), Some(vec!["val1", "val2"]));
        assert_eq!(def.get("section", "prop"), Some("val1"));
    }

    #[test]
    fn it_parses_empty_sections() {
        let text = indoc! {"
            [section]

            [section2]
            [section3]
            prop = val
        "};
        let def = text.parse::<Def>();
        assert!(def.is_ok());
        let def = def.unwrap();
        assert_eq!(def.get_all("section", "prop"), Some(vec![]));
        assert_eq!(def.get_all("section2", "prop"), Some(vec![]));
        assert_eq!(def.get_all("section3", "prop"), Some(vec!["val"]));
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

    #[test]
    fn it_converts_to_map_and_merge_sections() {
        let text = indoc! {"
            [section]
            prop = 1
            prop = 2
            prop2 = val

            [section]
            prop = 3
            prop2 = val
            prop3 = val3
        "};
        let def = text.parse::<Def>().unwrap();
        let def = def.to_map();
        assert_eq!(def.get("section", "prop"), Some("1"));
        assert_eq!(def.get("section", "prop2"), Some("val"));
        assert_eq!(
            def.get_all("section", "prop").collect::<Vec<_>>(),
            ["1", "2", "3"]
        );
        assert_eq!(
            def.get_all("section", "prop2").collect::<Vec<_>>(),
            ["val", "val"]
        );
        assert_eq!(
            def.get_all("section", "prop3").collect::<Vec<_>>(),
            ["val3"]
        );
    }

    #[test]
    fn it_converts_to_map_and_merge_props() {
        let text = indoc! {"
            [section]
            prop = val1
            prop = val2

            [section2]
            prop = val
        "};
        let def = text.parse::<Def>().unwrap();
        let def = def.to_map();
        assert_eq!(def.get("section", "prop"), Some("val1"));
        assert_eq!(
            def.get_all("section", "prop").collect::<Vec<_>>(),
            ["val1", "val2"]
        );
        assert_eq!(def.get_all("section3", "prop").count(), 0);
    }

    #[test]
    fn it_map_can_be_owned() {
        let text = indoc! {"
            [section]
            prop = val1
            prop = val2

            [section2]
            prop = val
        "};
        let def = text.parse::<Def>().unwrap().to_map().to_owned();

        assert_eq!(def.get("section", "prop"), Some("val1"));
        assert_eq!(
            def.get_all("section", "prop").collect::<Vec<_>>(),
            ["val1", "val2"]
        );
        assert_eq!(def.get_all("section3", "prop").count(), 0);
    }
}
