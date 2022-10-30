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

    const oxygen = findnum(lines.items, 1);
    std.debug.print("{}\n", .{oxygen});
    const co2 = findnum(lines.items, 0);

    std.debug.print("{}, {}\n", .{oxygen, co2});
    std.debug.print("{}\n", .{oxygen * co2});
}

fn findnum(lines: [][]u1, want: u1) u32 {
    var notmem: [1000]bool = [_]bool{false} ** 1000;
    var not = notmem[0..lines.len];
    var nfree: usize = lines.len;

    var bit: usize = 0;

    while (nfree > 1) : (bit += 1) {
        var count: usize = 0;
        for (lines) |l,i| {
            if (not[i]) continue;
            if (l[bit] == 1) count += 1;
        }

        var mywant = if (count >= nfree-count) want else 1-want;

        for (lines) |l,i| {
            if (not[i]) continue;
            if (l[bit] != mywant) {
                not[i] = true;
                nfree -= 1;
            }
        }
    }

    for (lines) |l,i| {
        if (not[i]) continue;
        var answer: u32 = 0;
        for (l) |v| {
            answer *= 2;
            if (v == 1) answer += 1;
        }
        return answer;
    }

    unreachable;
}
