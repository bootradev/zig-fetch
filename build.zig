// this file is an example of what a build.zig file using zig-fetch would look like

const fetch = @import("fetch.zig");
const std = @import("std");

const deps = [_]fetch.Dependency{
    .{
        .git = .{
            .name = "apple_pie",
            .url = "https://github.com/Luukdegram/apple_pie",
            .commit = "5eaaabdced4f9b8d6cee947b465e7ea16ea61f42",
        },
    },
};

pub fn build(builder: *std.build.Builder) !void {
    try fetch.fetchAndBuild(builder, "zig-deps", &deps, "compile.zig");
}
