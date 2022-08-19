use std::{collections::VecDeque, fmt::Display, str::FromStr};

use nom::{
    branch::alt,
    bytes::complete::{is_not, tag, tag_no_case},
    character::complete::{
        char, digit1, i32, line_ending, multispace0, one_of, space0, space1, u32,
    },
    combinator::{map, map_res, opt, success},
    multi::{many0, many1, separated_list1},
    sequence::{delimited, preceded, terminated, tuple},
    Finish, IResult,
};
use nom_locate::LocatedSpan;

type Span<'a> = LocatedSpan<&'a str>;
type ParseResult<'a, T> = IResult<Span<'a>, T>;

#[derive(Debug)]
pub struct Action {
    pub name: String,
    pub elements: Vec<Frame>,
    pub loop_start: usize,
}

#[derive(Debug)]
enum Element {
    Frame(Frame),
    LoopStart,
    HurtBoxes {
        default: bool,
        boxes: Vec<CollisionBox>,
    },
    HitBoxes {
        default: bool,
        boxes: Vec<CollisionBox>,
    },
}

#[derive(Debug)]
pub struct Frame {
    pub group: i32,
    pub image: i32,
    pub x: i32,
    pub y: i32,
    pub ticks: i32,
    pub flip: Flip,
    pub blend: Option<Blend>,
    pub hit_boxes: Vec<CollisionBox>,
    pub hurt_boxes: Vec<CollisionBox>,
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Flip {
    NoFlip,
    Horizontal,
    Vertical,
    Both,
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub enum Blend {
    Add { src: u32, dst: u32 },
    Sub,
}

#[derive(Debug, PartialEq, Eq, Clone, Copy)]
pub struct CollisionBox(i32, i32, i32, i32);

impl CollisionBox {
    pub fn x(&self) -> i32 {
        self.0
    }

    pub fn y(&self) -> i32 {
        self.1
    }

    pub fn width(&self) -> i32 {
        self.2 - self.0
    }

    pub fn height(&self) -> i32 {
        self.3 - self.1
    }
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

pub fn parse_air(air: &str) -> Result<Vec<Action>, ParseError> {
    match actions(air.into()).finish() {
        Ok((_, actions)) => Ok(actions),
        Err(err) => Err(ParseError {
            line: err.input.location_line(),
            column: err.input.get_utf8_column(),
            offset: err.input.location_offset(),
        }),
    }
}

fn actions(i: Span) -> ParseResult<Vec<Action>> {
    many1(delimited(
        tuple((multispace0, many0(comment_or_eol), multispace0)),
        action,
        tuple((multispace0, many0(comment_or_eol), multispace0)),
    ))(i)
}

fn action(i: Span) -> ParseResult<Action> {
    let (i, name) = terminated(begin_action, tuple((space0, comment_or_eol)))(i)?;

    let (i, elements) = many1(delimited(
        tuple((multispace0, many0(comment_or_eol), multispace0)),
        animation_element,
        tuple((multispace0, many0(comment_or_eol), multispace0)),
    ))(i)?;

    let mut elements: VecDeque<_> = elements.into();
    let mut frames = Vec::with_capacity(elements.len());
    let mut loop_start = 0;
    let mut time = 0;
    let mut hit_boxes: (bool, Option<Vec<CollisionBox>>) = Default::default();
    let mut hurt_boxes: (bool, Option<Vec<CollisionBox>>) = Default::default();

    while let Some(elem) = elements.pop_front() {
        match elem {
            Element::Frame(frame) => {
                let frame = Frame {
                    hit_boxes: match hit_boxes {
                        (true, ref boxes) => boxes.clone().unwrap_or_default(),
                        (false, ref mut boxes) => boxes.take().unwrap_or_default(),
                    },
                    hurt_boxes: match hurt_boxes {
                        (true, ref boxes) => boxes.clone().unwrap_or_default(),
                        (false, ref mut boxes) => boxes.take().unwrap_or_default(),
                    },
                    ..frame
                };
                if frame.ticks >= 0 {
                    time += frame.ticks;
                    frames.push(frame);
                } else {
                    frames.push(frame);
                    break;
                }
            }
            Element::LoopStart => loop_start = time,
            Element::HurtBoxes { default, boxes } => {
                hurt_boxes = (default, Some(boxes));
            }
            Element::HitBoxes { default, boxes } => {
                hit_boxes = (default, Some(boxes));
            }
        }
    }

    Ok((
        i,
        Action {
            name: name.to_string(),
            elements: frames,
            loop_start: loop_start as usize,
        },
    ))
}

fn comment(i: Span) -> ParseResult<LocatedSpan<&str>> {
    preceded(tag(";"), is_not("\n"))(i)
}

fn comment_or_eol(i: Span) -> ParseResult<LocatedSpan<&str>> {
    alt((comment, line_ending))(i)
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

fn animation_element(i: Span) -> ParseResult<Element> {
    let frame = map(animation_frame, Element::Frame);
    let loop_start = map(tag_no_case("loopstart"), |_| Element::LoopStart);
    alt((
        terminated(frame, tuple((space0, comment_or_eol))),
        terminated(loop_start, tuple((space0, comment_or_eol))),
        clsn_boxes,
    ))(i)
}

fn animation_frame(i: Span) -> ParseResult<Frame> {
    let (i, (group, image, x, y, ticks, flip, blend)) = tuple((
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
        alt((
            delimited(
                delimited(space0, char(','), space0),
                opt(element_blend),
                space0,
            ),
            success(None),
        )),
    ))(i)?;

    let elem = Frame {
        group,
        image,
        x,
        y,
        ticks,
        flip: flip.unwrap_or(Flip::NoFlip),
        blend,
        hit_boxes: Vec::new(),
        hurt_boxes: Vec::new(),
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

fn element_blend(i: Span) -> ParseResult<Blend> {
    fn add_blend(i: Span) -> ParseResult<Blend> {
        alt((full_add_blend, short_add_blend))(i)
    }

    fn short_add_blend(i: Span) -> ParseResult<Blend> {
        let (i, _) = tag_no_case("A")(i)?;
        let (i, dst) = opt(u32)(i)?;
        let dst = match dst {
            Some(n) => 256 / 2_u32.pow(n),
            _ => 256,
        };

        Ok((i, Blend::Add { src: 256, dst }))
    }

    fn full_add_blend(i: Span) -> ParseResult<Blend> {
        let (i, _) = tag_no_case("AS")(i)?;
        let (i, src) = u32(i)?;
        let (i, _) = tag_no_case("D")(i)?;
        let (i, dst) = u32(i)?;

        Ok((i, Blend::Add { src, dst }))
    }

    fn sub_blend(i: Span) -> ParseResult<Blend> {
        let (i, _) = tag_no_case("S")(i)?;
        Ok((i, Blend::Sub))
    }

    alt((add_blend, sub_blend))(i)
}

fn clsn_boxes(i: Span) -> ParseResult<Element> {
    #[derive(Debug, PartialEq, Eq, Clone, Copy)]
    enum ClsnBoxKind {
        Hit,
        Hurt,
    }

    impl Display for ClsnBoxKind {
        fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            match self {
                ClsnBoxKind::Hit => write!(f, "1"),
                ClsnBoxKind::Hurt => write!(f, "2"),
            }
        }
    }

    fn clsn_box_kind(i: Span) -> ParseResult<ClsnBoxKind> {
        map_res(one_of("12"), |k| match k {
            '1' => Ok(ClsnBoxKind::Hit),
            '2' => Ok(ClsnBoxKind::Hurt),
            k => Err(format!("Invalid collision box kind: {k}")),
        })(i)
    }

    fn clsn_box(expected_kind: ClsnBoxKind) -> impl Fn(Span) -> ParseResult<CollisionBox> {
        move |i| {
            let (i, _) = tag_no_case("Clsn")(i)?;
            let (i, _) = map_res(clsn_box_kind, |found_kind| {
                if expected_kind == found_kind {
                    Ok(found_kind)
                } else {
                    Err(format!(
                        "Expecting collision box kind {expected_kind} found: {found_kind}"
                    ))
                }
            })(i)?;
            let (i, _n) = delimited(tag("["), delimited(space0, u32, space0), tag("]"))(i)?;
            let (i, _) = preceded(space0, tag("="))(i)?;
            let (i, coords) = map_res(
                separated_list1(tag(","), delimited(space0, i32, space0)),
                |coords| {
                    if coords.len() == 4 {
                        Ok(coords)
                    } else {
                        Err("Invalid collision box")
                    }
                },
            )(i)?;

            Ok((i, CollisionBox(coords[0], coords[1], coords[2], coords[3])))
        }
    }

    let (i, _) = tag_no_case("Clsn")(i)?;
    let (i, kind) = clsn_box_kind(i)?;
    let (i, def) = opt(tag_no_case("default"))(i)?;
    let (i, _) = preceded(space0, tag(":"))(i)?;

    let (i, count) = preceded(space0, u32)(i)?;

    let (i, boxes) = map_res(
        many1(delimited(
            tuple((multispace0, many0(comment_or_eol), multispace0)),
            clsn_box(kind),
            tuple((multispace0, many0(comment_or_eol), multispace0)),
        )),
        |boxes| {
            if count as usize == boxes.len() {
                Ok(boxes)
            } else {
                Err(format!(
                    "Expecting {count} collision boxes, found: {}",
                    boxes.len()
                ))
            }
        },
    )(i)?;

    let element = match kind {
        ClsnBoxKind::Hit => Element::HitBoxes {
            default: def.is_some(),
            boxes,
        },
        ClsnBoxKind::Hurt => Element::HurtBoxes {
            default: def.is_some(),
            boxes,
        },
    };
    Ok((i, element))
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
    fn it_parses_air_file() {
        let text = indoc! {"
            [begin action 001]
            200, 20, 30, 40, 50

            [begin action 002]
            200, 20, 30, 40, 50

            ; Action 3
            [begin action 003]
            200, 20, 30, 40, 50

        "};
        let actions = parse_air(text).unwrap();
        assert_eq!(actions.len(), 3);
        assert_eq!(actions[0].name, "001");
        assert_eq!(actions[1].name, "002");
        assert_eq!(actions[2].name, "003");
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

    #[test]
    fn it_parses_animation_element_blend() {
        let text = indoc! {"
            [begin action 001]
            200, 20, 30, 40, 50
            200, 20, 30, 40, 50, , A
            200, 20, 30, 40, 50, , S
            200, 20, 30, 40, 50, , A1
            200, 20, 30, 40, 50, , A2
            200, 20, 30, 40, 50, , A3
            200, 20, 30, 40, 50, , AS33D44
        "};
        let action = text.parse::<Action>().unwrap();
        let elems = &action.elements;
        assert_eq!(elems[0].blend, None);
        assert_eq!(elems[1].blend, Some(Blend::Add { src: 256, dst: 256 }));
        assert_eq!(elems[2].blend, Some(Blend::Sub));
        assert_eq!(elems[3].blend, Some(Blend::Add { src: 256, dst: 128 }));
        assert_eq!(elems[4].blend, Some(Blend::Add { src: 256, dst: 64 }));
        assert_eq!(elems[5].blend, Some(Blend::Add { src: 256, dst: 32 }));
        assert_eq!(elems[6].blend, Some(Blend::Add { src: 33, dst: 44 }));
    }

    #[test]
    fn it_parses_loop_start() {
        let text = indoc! {"
            [begin action 001]
            200, 10, 30, 40, 50
            200, 20, 30, 40, 50
             loopstart
            200, 30, 30, 40, 50
            200, 40, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.loop_start, 100);
    }

    #[test]
    fn it_parses_collision_boxes() {
        let text = indoc! {"
            [begin action 001]
            Clsn2: 2
             Clsn2[0] =  15, -1,-24,-72
             Clsn2[1] = -12,-84, 11,-61
            200, 20, 30, 40, 50
            200, 30, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        let frames = &action.elements;
        assert!(frames[0].hit_boxes.is_empty());
        assert_eq!(frames[0].hurt_boxes.len(), 2);
        assert_eq!(frames[0].hurt_boxes[0], CollisionBox(15, -1, -24, -72));
        assert_eq!(frames[0].hurt_boxes[1], CollisionBox(-12, -84, 11, -61));
        assert!(frames[1].hit_boxes.is_empty());
        assert!(frames[1].hurt_boxes.is_empty());

        let text = indoc! {"
            [begin action 001]
            Clsn1: 2
             Clsn1[0] =  15, -1,-24,-72
             Clsn1[1] = -12,-84, 11,-61
            200, 20, 30, 40, 50
            200, 30, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        let frames = &action.elements;
        assert!(frames[0].hurt_boxes.is_empty());
        assert_eq!(frames[0].hit_boxes.len(), 2);
        assert_eq!(frames[0].hit_boxes[0], CollisionBox(15, -1, -24, -72));
        assert_eq!(frames[0].hit_boxes[1], CollisionBox(-12, -84, 11, -61));
        assert!(frames[1].hurt_boxes.is_empty());
        assert!(frames[1].hit_boxes.is_empty());
    }

    #[test]
    fn it_parses_collision_boxes_defaults() {
        let text = indoc! {"
            [begin action 001]
            clsn2default: 1
             clsn2[0] =  15, -1,-24,-72
            200, 20, 30, 40, 50
            200, 40, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        let frames = &action.elements;
        assert!(frames[0].hit_boxes.is_empty());
        assert_eq!(frames[0].hurt_boxes.len(), 1);
        assert_eq!(frames[0].hurt_boxes[0], CollisionBox(15, -1, -24, -72));
        assert!(frames[1].hit_boxes.is_empty());
        assert_eq!(frames[1].hurt_boxes[0], CollisionBox(15, -1, -24, -72));

        let text = indoc! {"
            [begin action 001]
            Clsn1default: 1
             Clsn1[0] =  15, -1,-24,-72
            200, 20, 30, 40, 50
            200, 40, 30, 40, 50
        "};
        let action = text.parse::<Action>().unwrap();
        let frames = &action.elements;
        assert!(frames[0].hurt_boxes.is_empty());
        assert_eq!(frames[0].hit_boxes.len(), 1);
        assert_eq!(frames[0].hit_boxes[0], CollisionBox(15, -1, -24, -72));
        assert!(frames[1].hurt_boxes.is_empty());
        assert_eq!(frames[1].hit_boxes[0], CollisionBox(15, -1, -24, -72));
    }

    #[test]
    fn it_rejects_collision_boxes_with_unmatched_kind() {
        let text = indoc! {"
            [begin action 001]
            Clsn2: 1
             clsn1[0] =  15, -1,-24,-72
            200, 20, 30, 40, 50
        "};
        assert!(text.parse::<Action>().is_err());

        let text = indoc! {"
            [begin action 001]
            Clsn1: 1
             clsn2[0] =  15, -1,-24,-72
            200, 20, 30, 40, 50
        "};
        assert!(text.parse::<Action>().is_err());
    }

    #[test]
    fn it_rejects_collision_boxes_with_unmatched_count() {
        let text = indoc! {"
            [begin action 001]
            Clsn2: 2
             clsn2[0] =  15, -1,-24,-72
            200, 20, 30, 40, 50
        "};
        assert!(text.parse::<Action>().is_err());

        let text = indoc! {"
            [begin action 001]
            Clsn1: 2
             clsn1[0] =  15, -1,-24,-72
            200, 20, 30, 40, 50
        "};
        assert!(text.parse::<Action>().is_err());
    }
    #[test]
    fn it_ignores_comments() {
        let text = indoc! {"
            [begin action 001] ; Comment
            200, 20, 30, 40, 50 ; Comment
            200, 20, 30, 40, 50; Comment
        "};
        assert!(text.parse::<Action>().is_ok());
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.elements.len(), 2);

        let text = indoc! {"
            [begin action 001]
            200, 20, 30, 40, 50 ; Comment
        "};
        assert!(text.parse::<Action>().is_ok());
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.elements.len(), 1);

        let text = indoc! {"
            [begin action 001]
            ; Comment
            ; Comment

            ; Comment
            200, 20, 30, 40, 50
        "};
        assert!(text.parse::<Action>().is_ok());
        let action = text.parse::<Action>().unwrap();
        assert_eq!(action.elements.len(), 1);

        let text = indoc! {"
            [begin action 001]
            ; Comment
            ; Comment
            ; Comment
            Clsn1default: 1; Comment
            ; Comment
            ; Comment

            ; Comment
             Clsn1[0] =  15, -1,-24,-72 ; Comment
            ; Comment
            ; Comment
            200, 20, 30, 40, 50
            Clsn1: 2 ; Comment
             Clsn1[0] =  16, -1,-24,-72 ; Comment
            ; Comment

            ; Comment

             Clsn1[1] = -12,-84, 11,-61 ; Comment
            ; Comment
            200, 40, 30, 40, 50
        "};
        assert!(text.parse::<Action>().is_ok());
        let action = text.parse::<Action>().unwrap();
        assert_eq!(
            action.elements[0].hit_boxes[0],
            CollisionBox(15, -1, -24, -72)
        );
        assert_eq!(
            action.elements[1].hit_boxes[0],
            CollisionBox(16, -1, -24, -72)
        );
        assert_eq!(
            action.elements[1].hit_boxes[1],
            CollisionBox(-12, -84, 11, -61)
        );
    }
}
