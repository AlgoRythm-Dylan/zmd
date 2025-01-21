const Lexer = @import("./lexer.zig").Lexer;
const LexerState = @import("./lexerstate.zig").LexerState;

pub const Parser = struct {
    lexer: Lexer = undefined
};