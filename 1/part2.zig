const std = @import("std");

pub fn main() !void {
    var stream = std.io.getStdIn().reader();
    var buffer: [1000]u8 = undefined;

    var a: usize = 10000;
    var b: usize = 10000;
    var c: usize = 10000;
    var count: usize = 0;
    while (true) {
        var line = stream.readUntilDelimiter(buffer[0..], '\n') catch break;
        var n = try std.fmt.parseInt(usize, line, 10);
        if (b + c + n > a + b + c) {
            count += 1;
        }
        a = b;
        b = c;
        c = n;
    }
    std.debug.print("{}\n", .{count});
}
