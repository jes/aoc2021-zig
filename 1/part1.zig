const std = @import("std");

pub fn main() !void {
    var stream = std.io.getStdIn().reader();
    var buffer: [1000]u8 = undefined;

    var last: usize = 100000;
    var count: usize = 0;
    while (true) {
        var line = stream.readUntilDelimiter(buffer[0..], '\n') catch break;
        var n = try std.fmt.parseInt(usize, line, 10);
        if (n > last) {
            count += 1;
        }
        last = n;
    }
    std.debug.print("{}\n", .{count});
}
