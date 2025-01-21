const state = @import("./sharedstate.zig");
const lexer = @import("./lexer.zig");
const parser = @import("./parser.zig");
const std = @import("std");
const Allocator = std.mem.Allocator;

pub const MarkdownGenerator = struct {

    lexer: lexer.Lexer,
    state: state.SharedStateStack,
    allocator: Allocator,

    pub fn init(allocator: Allocator) MarkdownGenerator {
        var mdg: MarkdownGenerator = .{
            .allocator = allocator,
            .state = state.SharedStateStack.init(),
            .lexer = lexer.Lexer.init(allocator)
        };
        mdg.lexer.shared_state = &mdg.state;
        return mdg;
    }

};