const std = @import("std");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn main () !void {
    var stream = std.io.getStdIn().reader();
    var buffer: [1000]u8 = undefined;
    var lines = std.ArrayList([]u1).init(allocator);

    while (true) {
        var line = stream.readUntilDelimiter(buffer[0..], '\n') catch break;

        var p = try allocator.alloc(u1, line.len);
        for (line) |c,i| {
            p[i] = switch(c) {
                '0' => 0,
                '1' => 1,
                else => unreachable,
            };
        }
        try lines.append(p);
    }

    var countmem: [20]u32 = [_]u32{0} ** 20;
    var count = countmem[0..lines.items[0].len];

    for (lines.items) |l| {
        for (l) |c,i| {
            if (c == 1) {
                count[i] += 1;
            }
        }
    }

    var gamma: u32 = 0;
    var epsilon: u32 = 0;
    for (count) |c| {
        gamma *= 2;
        epsilon *= 2;
        if (c > lines.items.len/2) {
            gamma += 1;
        } else {
            epsilon += 1;
        }
    }

    std.debug.print("{}\n", .{gamma * epsilon});
}
