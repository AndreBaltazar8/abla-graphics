# Abla Graphics

Abla Graphics is an Abla-only graphics and windowing framework targeting
OpenGL 4.6 and Vulkan 1.4. Framework, platform protocol, driver ABI layout,
resource ownership, and rendering policy are written in
[Abla](https://github.com/AndreBaltazar8/ablac). The repository contains no C,
C++, or Rust implementation source and no GLFW/SDL or Xlib/XCB window-management
layer.

The project is under active development. The current vertical slice already
proves the architecture rather than stopping at placeholder interfaces:

- a backend-neutral configuration, error, overflow-checked geometry, and native
  `f64` math core;
- an affine pure-Abla X11 window that opens the Unix socket, performs the X11
  authenticated handshake, honors visibility/size/decoration/fullscreen hints,
  reports screen dimensions/DPI/content scale, maps portable
  keyboard/pointer/scroll/UTF-8 text events, supports direct pointer warping
  and capture, serves asynchronous UTF-8 clipboard selections, and handles the
  WM_DELETE_WINDOW protocol before destroying it;
- a pure-Abla Vulkan loader/instance/adapter/logical-device implementation;
- a pure-Abla SPIR-V word validator and real Vulkan shader-module path;
- a Vulkan X11 surface with presentation support, capability/format queries,
  swapchain image enumeration, synchronized GPU clear, and queue presentation;
- pure-Abla Vulkan buffer allocation, command-pool/buffer recording,
  `vkCmdFillBuffer` submission, host synchronization, mapping, and readback;
- a pure-Abla EGL/OpenGL surfaceless context, version query, clear, and pixel
  readback;
- a surfaced EGL/OpenGL context on the direct X11 window, including shader
  compile/link diagnostics, a full-screen triangle, readback, and swap;
- an Abla-defined `$glsl`/`#$glsl` stage parser feeding that triangle;
- deterministic pure-Abla SPIR-V emission for strict no-op and observable
  single-member storage arithmetic compute subsets, with unsupported GLSL
  rejected rather than ignored;
- real Vulkan compute-pipeline creation and submitted dispatch from that
  Abla-emitted module;
- a backend-neutral affine `GraphicsApplication` that selects Vulkan/OpenGL
  once, rejects missing required features, reports the real API version and
  portable device limits, owns teardown, exposes copied events, and presents
  common clear colors;
- a backend-neutral affine headless application that selects a real Vulkan or
  surfaceless EGL/OpenGL device and probes it without connecting to a display;
- reusable affine RGBA8 pixel storage, a persistent nearest-filtered OpenGL
  upload path, and a configurable one-to-eight-frame Vulkan
  staging/copy/present path with per-image
  presentation semaphores, fence-guarded slot reuse, and bounded automatic
  swapchain recovery for software renderers;
- direct core-X11 cursor visibility and confined pointer capture without an
  Xlib/XCB/GLFW window-management layer;
- a nanosecond monotonic clock and configurable drift-corrected frame pacer
  whose reusable steady-state wait path performs no general allocation;
- immutable portable buffer/texture/view/sampler descriptors plus affine
  common buffers, textures, views, and samplers that create and drop real
  resources on either OpenGL or Vulkan, including queried 16x sampler
  anisotropy and checked buffer writes/readback;
- pure-Abla IEEE-754 binary64-to-binary32 rounding so native `f64` colors reach
  both drivers without a foreign shim;
- a pure-Abla, deterministic Khronos XML inventory generator with pinned and
  hash-verified Vulkan/OpenGL inputs plus honest unclassified coverage ledgers;
  and
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
nix-shell --run 'make test-registry'
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
- `examples/opengl-window`: surfaced shader-backed triangle;
- `examples/common-clear`: backend-neutral automatic selection and clear/present;
- `examples/common-buffer`: one affine descriptor/resource exercised unchanged
  on explicit OpenGL and Vulkan; and
- `examples/common-texture`: color mip chains and depth views exercised
  unchanged on explicit OpenGL and Vulkan; and
- `examples/common-compute`: one `$glsl` compute package compiled and dispatched
  unchanged on explicit OpenGL and Vulkan, including verified storage-buffer
  mutation and readback; and
- `examples/frame-pacing`: display-free high-resolution pacing with a live-memory
  assertion across the steady-state frame loop.

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

The companion [Abla Doom](https://github.com/AndreBaltazar8/abla-doom) project
is a complete all-Abla 2.5D raycasting homage built on this common pixel/input
API. Its repository contains the clean real-window screenshot, explicit
OpenGL/Vulkan smoke tests, and reproducible software-renderer frame benchmark.

See [the implementation plan](plan.md), [architecture](docs/architecture.md),
[current status](docs/status.md), and [toolchain prerequisites](docs/toolchain-prerequisites.md).

## License

Abla Graphics is licensed under the Mozilla Public License 2.0.
