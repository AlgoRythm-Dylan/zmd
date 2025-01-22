const LexerStateEntry = @import("./lexerstate.zig").LexerStateEntry;
const std = @import("std");
const handler = @import("./lexerstatehandler.zig");

const HANDLERS = [_]handler.LexerStateHandler {
    @import("./lexerstatehandlers/generic.zig").exported_handler
};

const STATE_STACK_SIZE = 32;

pub const Lexer = struct {
    allocator: std.mem.Allocator,
    state_stack: [STATE_STACK_SIZE]LexerStateEntry = undefined,

    pub fn init(allocator: std.mem.Allocator) Lexer {
        return Lexer { .allocator = allocator };
    }

    /// Read a char and returns whether or not
    /// the character was consumed
    pub fn read(self: *@This(), char: u8) bool {
        _ = self;
        _ = char;
        return true;
    }
};