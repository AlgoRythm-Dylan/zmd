const std = @import("std");
const markdown = @import("./markdown.zig");

pub fn main() !void {
    try convertMarkdownToHTML();
}

fn convertMarkdownToHTML() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    var generator = markdown.MarkdownGenerator.init(allocator);

    try generator.read('a');
    try generator.read('b');

    std.debug.print("{s}\n", .{ generator.lexer.text_buffer.?.items });
}