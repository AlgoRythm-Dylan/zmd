const lexer = @import("./lexer.zig");
const std = @import("std");
const Allocator = std.mem.Allocator;

pub const MarkdownGenerator = struct {

    lexer: lexer.Lexer,
    allocator: Allocator,

    pub fn init(allocator: Allocator) MarkdownGenerator {
        return MarkdownGenerator {
            .allocator = allocator,
            .lexer = lexer.Lexer.init(allocator)
        };
    }

    pub fn read(self: *@This(), char: u8) !void {
        try self.lexer.read(char);
    }

};