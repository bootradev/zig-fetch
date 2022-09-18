// this file is an example of what a build.zig file using zig-fetch might look like

const fetch = @import("fetch.zig");
const std = @import("std");

const deps = [_]fetch.Dependency{
    .{
        .name = "zig-fetch-example",
        .vcs = .{
            .git = .{
                .url = "https://github.com/bootradev/zig-fetch-example",
                .commit = "b64ecf93ce86163d609afd5498eda5b86bb34eb6",
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
