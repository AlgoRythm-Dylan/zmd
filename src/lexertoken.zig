const ArrayList = @import("std").ArrayList;

pub const LexerTokenType = enum {
    text,
    punctuation,
    whitespace,
    newline
};

pub const LexerToken = union(LexerTokenType) {
    text: ArrayList(u8),
    punctuation: u8,
    whitespace: void,
    newline: void
};