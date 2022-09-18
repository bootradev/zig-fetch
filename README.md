# zig-fetch
simple dependency management for zig projects!

## intro
zig-fetch is a way to handle fetching dependencies for your project with:
* no installation required
* no submodules
* no package config files

the goal is to add some basic package management without having to change much about your zig workflow.

for library developers, there are only a few changes needed to set up this workflow

for library users, no change is needed - zig build will work just like normal!

## features
zig-fetch provides the following features:

* fetch and cache git repo dependencies
* recursive fetch support - dependencies using zig-fetch will automatically fetch their dependencies recursively
* add build steps and build options which get passed through to your build file

## getting started
there are three simple steps to use zig-fetch

1. copy `fetch.zig` into your project folder
2. rename your `build.zig` to something different, like `compile.zig`
3. add a new `build.zig` where you define your project dependencies and call fetchAndBuild

here's an example of a `build.zig` file:

```
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

```

`fetchAndBuild` takes 4 arguments:
1. the builder
2. the name of the directory where dependencies are fetched to
3. array of dependencies to fetch
4. the name of the build file to call after fetching is complete

## build options
(use `zig build --help` to see all available build options)

* `fetch-skip` - Skip fetching dependencies entirely
* `fetch-only` - Only fetch dependencies, do not build
* `fetch-force` - Force fetch dependencies, even if already cached
* `--verbose` - not a zig-fetch specific option, but this will add additional logging during the build

## additional notes

see `build.zig` and `compile.zig` in this repo for an example of the workflow

you can also check out https://github.com/bootradev/zig-fetch-example as additional reference

## credits

thanks to https://github.com/desttinghim for coming up with idea for a separate build file!
