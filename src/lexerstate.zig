pub const LexerState = enum {
    begin_line
};

pub const LexerStateEntry = union(LexerState) {
    begin_line: void
};