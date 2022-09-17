// this file is an example of how the import works with zig-fetch
// just make sure the parent import directory matches what is passed into fetchAndBuild

const std = @import("std");
const apple_pie = @import("zig-deps/apple_pie/build.zig");

pub fn build(_: *std.build.Builder) !void {
    std.log.info("Successfully imported apple_pie! {}", .{apple_pie});
}
