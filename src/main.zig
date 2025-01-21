const std = @import("std");
const markdown = @import("./markdown.zig");

pub fn main() !void {
    convertMarkdownToHTML();
}

fn convertMarkdownToHTML() void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    _ = markdown.MarkdownGenerator.init(allocator);
}