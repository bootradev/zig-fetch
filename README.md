# zig-fetch
simple dependency management for zig projects!

## intro
zig-fetch is a way to handle fetching dependencies for your project with:
* no installation required
* no submodules
* no package config files

the goal is to implement some basic package management without having to change anything about your zig workflow.

for library developers, there are only a few changes needed to set up this workflow

for library users, no change is needed - zig build will work just like normal!

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
```

`fetchAndBuild` takes 4 arguments:
1. the builder
2. the name of the directory where dependencies are fetched to
3. array of dependencies to fetch
4. the name of the build file to call after fetching is complete

## other notes

you can pass `-Dfetch-skip=true` to skip fetching dependencies

see `build.zig` and `compile.zig` in this repo for an example of the workflow

## credits

thanks to https://github.com/desttinghim for coming up with idea for a separate build file!
