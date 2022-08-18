use std::str::FromStr;

use nom::{
    bytes::complete::tag_no_case,
    character::complete::{char, digit1, i32, line_ending, multispace0, space0, space1},
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
    let (i, (group, image, x, y, ticks)) = tuple((
        terminated(delimited(space0, i32, space0), char(',')),
        terminated(delimited(space0, i32, space0), char(',')),
        terminated(delimited(space0, i32, space0), char(',')),
        terminated(delimited(space0, i32, space0), char(',')),
        delimited(space0, i32, space0),
    ))(i)?;

    let elem = AnimationElement {
        group,
        image,
        x,
        y,
        ticks,
    };

    Ok((i, elem))
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
}
