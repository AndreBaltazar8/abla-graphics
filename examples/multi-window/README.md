# Multi-window and monitor inventory

This sample keeps two independent surfaced applications alive at once. It
renames both windows, resizes only the second, alternates 64 presentations
between their retained backend objects, and verifies that their native
OpenGL contexts or Vulkan instances remain distinct and stable with no
steady-state live-memory growth.

The common `monitorCount()` and `monitor(index)` API exposes immutable X11
setup-screen snapshots without allocating during lookup. The focused gate runs
against a two-screen Xvfb server and proves both 800x600 and 1024x768 monitors
are discovered by both windows.

```sh
nix-shell shell.nix --run 'ablac build --project examples/multi-window -o build/multi-window'
build/multi-window opengl
build/multi-window vulkan
```

Run `make test-multi-window` for direct-linkage checks, software OpenGL, and
validation-enabled Vulkan on the deterministic two-screen server.
