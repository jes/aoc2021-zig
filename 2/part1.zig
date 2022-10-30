const std = @import("std");

pub fn main () !void {
    var stream = std.io.getStdIn().reader();
    var buffer: [1000]u8 = undefined;

    var x: i64 = 0;
    var y: i64 = 0;

    while (true) {
        var line = stream.readUntilDelimiter(buffer[0..], '\n') catch break;
        var dir = line[0];
        var dist = line[line.len-1] - '0';
        switch (dir) {
            'f' => x += dist,
            'd' => y += dist,
            'u' => y -= dist,
            else => unreachable,
        }
    }
    std.debug.print("{}\n", .{x*y});
}
