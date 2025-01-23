const std = @import("std");

pub const LexerTokenType = enum {
    text,
    punctuation,
    whitespace,
    newline,
    end
};

pub const LexerToken = union(LexerTokenType) {
    text: std.ArrayList(u8),
    punctuation: u8,
    whitespace: void,
    newline: void,
    end: void
};