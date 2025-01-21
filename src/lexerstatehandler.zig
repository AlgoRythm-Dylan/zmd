const lexer = @import("./lexer.zig");

pub const LexerStateHandler = struct {
    scan: *const fn(lexer: *lexer.Lexer) bool
};