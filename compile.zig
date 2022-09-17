// this file is an example of what a build file using zig-fetch might look like
// make sure the parent import directory matches what is passed into fetchAndBuild

const std = @import("std");
const apple_pie = @import("zig-deps/apple_pie/src/apple_pie.zig");

pub fn build(builder: *std.build.Builder) !void {
    std.log.info("Successfully imported {}!", .{apple_pie});

    const example_step = builder.step("example-step", "test passing a step through build.zig");
    example_step.dependOn(&(try ExampleStep.init(builder)).step);

    const example_option = builder.option(
        bool,
        "example-option",
        "test passing an option through build.zig",
    );
    std.log.info("example-option: {}", .{example_option});
}

const ExampleStep = struct {
    step: std.build.Step,

    pub fn init(builder: *std.build.Builder) !*ExampleStep {
        var example = try builder.allocator.create(ExampleStep);
        example.* = .{
            .step = std.build.Step.init(.custom, "example", builder.allocator, make),
        };
        return example;
    }

    pub fn make(_: *std.build.Step) !void {
        std.log.info("Running example step!", .{});
    }
};
