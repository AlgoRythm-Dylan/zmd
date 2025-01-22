# Statial-reasoning
*A completely invented term where I write out*
*the responsibilities and reasoning behind each state*

Items marked with an asterisk are the default state.

This document is living and may not cover every markdown
case possible yet. It may also contain my own syntax rules.

## Lexing states
The lexer itself is a state machine. Here are all possible
states and what they mean.

### `begin_line`*
Lots of information in Markdown is determined at the start
of a line of text. This state ONLY considers *new* lines
as the lexing rules can be different for a continuing line.

There is syntax at the beginning of a line that will indicate
the formatting that the author wants.

```
>    Blockquote
#    Heading 
```

There is some syntax which is ambiguous

```
`    Multi-line code block or inline code block?
*    Horizontal rule or emphasis?
```

#### Heading
Headings are lines in Markdown that start with a `#` character
and may have as many as 6 consecutive `#` characters, each
subsequent character increasing the level of the heading.
Headings do not continue on the next line and are always
terminated by a newline.

If a heading is encountered, the state should transition to
`heading` and a `heading` type token should be emitted. The
parser is responsible for counting these tokens. New lines starting
with a `#` will always be a heading. Heading lines are never
continued on the next line and therefore once a newline is
encountered, the state is transitioned to `new_line` rather than
`continue_line`.

#### Blockquote
If a blockquote is encountered, the state will not be changed, but
a `blockquote` should be emitted.

### `continue_line`
The `continue_line` state is a state that follows any
non-empty line.

### `heading`
The heading state simply emits `heading` type tokens while
`#` characters are read from the input. If any other type
of character is found, the state transitions to `paragraph`
and the character is NOT consumed.

### `paragraph`
The `paragraph` state is responsible for parsing plain
text until a newline is encountered. Ambiguous syntax of
images and links makes this a very difficult state to lex,
so all punctuation is emitted as a token and then the parser
gets the honor of deciding if it's a link/image or text.

Characters emitted as tokens:

```
`    Code
*    Emphasis
=    Highlight
!    Image
[    Opening square bracket
]    Closing square bracket
(    Opening parenthesis
)    Closing parenthesis
     Whitespace
```

When a newline is encountered, the token is emitted
and the state is set to `continue_line`