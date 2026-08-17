# Abla Graphics

Abla Graphics is an Abla-only graphics and windowing framework targeting
OpenGL 4.6 and Vulkan 1.4. Framework, platform protocol, driver ABI layout,
resource ownership, and rendering policy are written in
[Abla](https://github.com/AndreBaltazar8/ablac). The repository contains no C,
C++, or Rust implementation source and no GLFW/SDL or Xlib/XCB window-management
layer.

The project is under active development. The current vertical slice already
proves the architecture rather than stopping at placeholder interfaces:

- a backend-neutral configuration, error, geometry, and fixed-point math core;
- an affine pure-Abla X11 window that opens the Unix socket, performs the X11
  authenticated handshake, creates/titles/maps a window, decodes events, and
  handles the WM_DELETE_WINDOW protocol before destroying it;
- a pure-Abla Vulkan loader/instance/adapter/logical-device implementation;
- a Vulkan X11 surface with presentation support, capability/format queries,
  swapchain image enumeration, synchronized GPU clear, and queue presentation;
- pure-Abla Vulkan buffer allocation, command-pool/buffer recording,
  `vkCmdFillBuffer` submission, host synchronization, mapping, and readback;
- a pure-Abla EGL/OpenGL surfaceless context, version query, clear, and pixel
  readback;
- a surfaced EGL/OpenGL context on the direct X11 window, including shader
  compile/link diagnostics, a full-screen triangle, readback, and swap;
- an Abla-defined `$glsl`/`#$glsl` stage parser feeding that triangle; and
- a backend-neutral affine `GraphicsApplication` that selects Vulkan/OpenGL
  once, owns teardown, exposes copied events, and presents common clear colors;
- reusable affine RGBA8 pixel storage, a persistent nearest-filtered OpenGL
  upload path, and a Vulkan staging/copy/present path for software renderers;
- integer-only IEEE-754 color encoding so common colors reach both drivers
  without a foreign shim or source-level float ABI; and
- the general `ablac` `nativeLibraries` manifest contract, used to link
  installed driver loaders without a graphics-specific compiler exception.

The installed Vulkan/EGL/OpenGL loaders and GPU drivers are external because
they implement the Khronos driver specifications. All application-side calls,
layouts, loading policy, and ownership are Abla.

## Build and test

The framework is developed alongside `../ablac`. On NixOS:

```sh
nix-shell --run 'make test'
nix-shell --run 'make test-toolchain'
```

Applications that open a portable surface declare the installed loader boundary
in their root manifest:

```toml
nativeLibraries = ["vulkan", "X11", "EGL", "GL"]
```

This runs:

- pure Abla core behavior;
- the direct X11 protocol test under Xvfb;
- a real Vulkan 1.4 instance/device/GPU-command/readback test;
- headless and surfaced EGL/OpenGL draw/readback tests; and
- runtime/frozen GLSL subparser structure and invalid-stage diagnostics.

The Vulkan and OpenGL tests use the stock compiler from `../ablac/build/ablac`.
CI pins Mesa's Lavapipe and software OpenGL paths so the complete backend matrix
also runs on clean GitHub-hosted machines without physical GPUs.

## Samples

- `examples/x11-window`: direct X11 window/event loop;
- `examples/vulkan-info`: loader and physical-adapter report;
- `examples/vulkan-surface`: X11 WSI adapter/capability selection;
- `examples/headless-opengl`: surfaceless context and framebuffer clear; and
- `examples/opengl-window`: surfaced shader-backed triangle.
- `examples/common-clear`: backend-neutral automatic selection and clear/present.

Run the sample smoke matrix with:

```sh
nix-shell --run 'make test-samples'
```

## API direction

Normal applications will use the backend-neutral `graphicsApplication`,
resource descriptors, encoders, and render/compute passes described in
[the API contract](docs/api.md). Complete generated escape hatches will live
under `graphics/raw/opengl` and `graphics/raw/vulkan`.

GPU/window resources are affine Abla `resource class` values. Frame command
data will use reusable arenas and backend selection is kept out of inner draw
loops. `$glsl` will be an Abla-defined compile-time subparser with source-span
diagnostics and deterministic OpenGL GLSL/Vulkan SPIR-V output.

See [the implementation plan](plan.md), [architecture](docs/architecture.md),
[current status](docs/status.md), and [toolchain prerequisites](docs/toolchain-prerequisites.md).

## License

Abla Graphics is licensed under the Mozilla Public License 2.0.
