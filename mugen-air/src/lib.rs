use std::str::FromStr;

use nom::{
    branch::alt,
    bytes::complete::tag_no_case,
    character::complete::{char, digit1, i32, line_ending, multispace0, space0, space1},
    combinator::{map_res, opt, success},
    multi::many1,
    sequence::{delimited, terminated, tuple},
    Finish, IResult,
};
use nom_locate::LocatedSpan;

type Span<'a> = LocatedSpan<&'a str>;
type ParseResult<'a, T> = IResult<Span<'a>, T>;

#[derive(Debug)]
pub struct Action {
    pub name: String,
    pub elements: Vec<AnimationElement>,
}

#[derive(Debug)]
pub struct AnimationElement {
    pub group: i32,
    pub image: i32,
    pub x: i32,
    pub y: i32,
    pub ticks: i32,
    pub flip: Flip,
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Flip {
    NoFlip,
    Horizontal,
    Vertical,
    Both,
}

#[derive(Debug)]
pub struct ParseError {
    pub line: u32,
    pub column: usize,
    pub offset: usize,
}

impl FromStr for Action {
    type Err = ParseError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match action(s.into()).finish() {
            Ok((_, action)) => Ok(action),
            Err(err) => Err(ParseError {
                line: err.input.location_line(),
                column: err.input.get_utf8_column(),
                offset: err.input.location_offset(),
            }),
        }
    }
}

fn action(i: Span) -> ParseResult<Action> {
    let (i, name) = terminated(begin_action, line_ending)(i)?;
    let (i, elements) = many1(delimited(multispace0, animation_element, multispace0))(i)?;
    let name = name.to_string();
    Ok((i, Action { name, elements }))
}

fn begin_action(i: Span) -> ParseResult<&str> {
    delimited(char('['), delimited(space0, action_name, space0), char(']'))(i)
}

fn action_name(i: Span) -> ParseResult<&str> {
    let (i, _) = tag_no_case("begin")(i)?;
    let (i, _) = space1(i)?;
    let (i, _) = tag_no_case("action")(i)?;
    let (i, _) = space1(i)?;
    let (i, name) = digit1(i)?;
    Ok((i, &name))
}

fn animation_element(i: Span) -> ParseResult<AnimationElement> {
    let (i, (group, image, x, y, ticks, flip)) = tuple((
        terminated(delimited(space0, i32, space0), char(',')),
        terminated(delimited(space0, i32, space0), char(',')),
        terminated(delimited(space0, i32, space0), char(',')),
        terminated(delimited(space0, i32, space0), char(',')),
        delimited(space0, i32, space0),
        alt((
            delimited(
                delimited(space0, char(','), space0),
                opt(element_flip),
                space0,
            ),
            success(None),
        )),
    ))(i)?;

    let elem = AnimationElement {
        group,
        image,
        x,
        y,
        ticks,
        flip: flip.unwrap_or(Flip::NoFlip),
    };

    Ok((i, elem))
}

fn element_flip(i: Span) -> ParseResult<Flip> {
    let flip = alt((
        tag_no_case("VH"),
        tag_no_case("HV"),
        tag_no_case("V"),
        tag_no_case("H"),
    ));

    map_res(flip, |flip: Span| {
        match flip.to_ascii_uppercase().as_str() {
            "VH" | "HV" => Ok(Flip::Both),
            "H" => Ok(Flip::Horizontal),
            "V" => Ok(Flip::Vertical),
            _ => Err("Invalid flip"),
        }
    })(i)
}

#[cfg(test)]
mod tests {
    use indoc::indoc;

    use super::*;

    #[test]
    fn it_shows_location_of_the_error() {
        let text = "[begin action invalid]";
        let error = text.parse::<Action>().err().unwrap();
        assert_eq!(error.line, 1);
        assert_eq!(error.column, 15);
        assert_eq!(error.offset, 14);
    }

    #[test]
    fn it_parses_action_name() {
        let text = indoc! {"
            [begin action 001]
            200, 20, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.name, "001");

        let text = indoc! {"
            [  begin   action  001  ]
            200, 20, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.name, "001");
    }

    #[test]
    fn it_parses_animation_elements() {
        let text = indoc! {"
            [begin action 001]
            200, 20, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.elements.len(), 1);
        let element = &action.elements[0];
        assert_eq!(element.group, 200);
        assert_eq!(element.image, 20);
        assert_eq!(element.x, 30);
        assert_eq!(element.y, 40);
        assert_eq!(element.ticks, 50);
    }

    #[test]
    fn it_parses_animation_element_flip() {
        let text = indoc! {"
            [begin action 001]
            200, 20, 30, 40, 50
            200, 20, 30, 40, 50,
            200, 20, 30, 40, 50, V
            200, 20, 30, 40, 50, H
            200, 20, 30, 40, 50, VH
            200, 20, 30, 40, 50, HV
        "};
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.elements[0].flip, Flip::NoFlip);
        assert_eq!(action.elements[1].flip, Flip::NoFlip);
        assert_eq!(action.elements[2].flip, Flip::Vertical);
        assert_eq!(action.elements[3].flip, Flip::Horizontal);
        assert_eq!(action.elements[4].flip, Flip::Both);
        assert_eq!(action.elements[5].flip, Flip::Both);
    }
}
