const handler = @import("../lexerstatehandler.zig");
const lexer = @import("../lexer.zig");

fn newlineScan(l: *lexer.Lexer) bool {
    _ = l;
    return true;
}

pub var exported_handler: handler.LexerStateHandler = handler.LexerStateHandler {
    .scan = newlineScan
};