const std = @import("std");
const CircularBuffer = @import("./circularbuffer.zig").CircularBuffer;
const lexertoken = @import("./lexertoken.zig");

const LexerBuffer = CircularBuffer(lexertoken.LexerToken, 16);

pub const Lexer = struct {
    allocator: std.mem.Allocator,
    token_buffer: LexerBuffer = LexerBuffer.init(),
    text_buffer: ?std.ArrayList(u8) = null,

    pub fn init(allocator: std.mem.Allocator) Lexer {
        return Lexer { .allocator = allocator };
    }

    pub fn read(self: *@This(), char: u8) !void {
        const token_type = getCharacterTokenType(char);
        if(token_type == .text){
            try self.addToTextBuffer(char);
        }
    }

    fn initTextBuffer(self: *@This()) void {
        self.text_buffer = std.ArrayList(u8).init(self.allocator);
    }

    fn addToTextBuffer(self: *@This(), char: u8) !void {
        if(self.text_buffer) |*tb| {
            try tb.append(char);
        }
        else {
            self.initTextBuffer();
            try self.text_buffer.?.append(char);
        }
    }

};

fn getCharacterTokenType(char: u8) lexertoken.LexerTokenType {
    return switch(char){
        0 => lexertoken.LexerTokenType.end,
        '\n' => lexertoken.LexerTokenType.newline,
        ' ' => lexertoken.LexerTokenType.whitespace,
        '#' => lexertoken.LexerTokenType.punctuation,
        else => lexertoken.LexerTokenType.text
    };
}