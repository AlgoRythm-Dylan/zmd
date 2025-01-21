const state = @import("./sharedstate.zig");
const std = @import("std");
const handler = @import("./lexerstatehandler.zig");

const HANDLERS = [_]handler.LexerStateHandler {
    @import("./lexerstatehandlers/generic.zig").exported_handler
};

pub const Lexer = struct {
    shared_state: *state.SharedStateStack = undefined,
    allocator: std.mem.Allocator,

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