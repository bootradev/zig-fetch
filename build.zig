// this file is an example of what a build.zig file using zig-fetch might look like

const fetch = @import("fetch.zig");
const std = @import("std");

const deps = [_]fetch.Dependency{
    .{
        .name = "zig-fetch-example",
        .vcs = .{
            .git = .{
                .url = "https://github.com/bootradev/zig-fetch-example",
                .commit = "88548fb9f4ed307abd78d8d45bf590dcf9da17ed",
                .recursive = true,
            },
        },
    },
};

pub fn build(builder: *std.build.Builder) !void {
    fetch.addStep(builder, "example-step", "Test passing a step through build.zig");
    fetch.addOption(builder, bool, "example-option", "Test passing an option through build.zig");
    try fetch.fetchAndBuild(builder, "zig-deps", &deps, "compile.zig");
}
