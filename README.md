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
  WM_DELETE_WINDOW protocol before destroying it; idle event polling reuses a
  window-owned native descriptor and canonical immutable no-event value;
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
  single-member storage arithmetic compute subsets plus fixed, interleaved
  position/color, and sampled-texture vertex/fragment triangle subsets, with
  typed scalar and workgroup specialization constants and unsupported GLSL
  rejected rather than ignored;
- real Vulkan compute-pipeline creation and submitted dispatch from that
  Abla-emitted module;
- one backend-neutral affine triangle render pipeline: the same `$glsl`
  package compiles to an OpenGL program or deterministic Abla-emitted SPIR-V,
  accepts procedural vertices or checked interleaved multi-attribute common
  vertex buffers with optional `uint32` common indices plus direct, instanced,
  and GPU-buffer-driven indirect submission,
  then records
  point/line/triangle topology, culling/front-face state, and standard alpha
  blending plus checked depth testing/writes before presenting a real Vulkan
  render pass or OpenGL draw without steady-state runtime allocation; affine
  multi-entry bind groups feed sampled textures plus uniform/storage buffers to
  strict reflected shaders
  and survives ordered Vulkan pipeline/swapchain/depth rebuilding after a
  window resize;
- a backend-neutral affine `GraphicsApplication` that selects Vulkan/OpenGL
  once, rejects missing required features, reports the real API version and
  portable device limits, rejects oversized resources/work before driver calls,
  owns teardown, exposes copied events, and presents common clear colors;
  repeated clear presentation reuses backend-native state without live-memory
  growth on both backends;
- a backend-neutral affine headless application that selects a real Vulkan or
  surfaceless EGL/OpenGL device and probes it without connecting to a display;
- reusable affine RGBA8 pixel storage, a persistent nearest-filtered OpenGL
  allocation-free repeated upload path, and a configurable one-to-eight-frame
  allocation-free repeated Vulkan
  staging/copy/present path with per-image
  presentation semaphores, fence-guarded slot reuse, and bounded automatic
  swapchain recovery for software renderers;
- direct core-X11 cursor visibility and confined pointer capture without an
  Xlib/XCB/GLFW window-management layer;
- a nanosecond monotonic clock and configurable drift-corrected frame pacer
  whose reusable steady-state wait path performs no general allocation;
- immutable portable buffer/texture/view/sampler descriptors plus affine
  common buffers, textures, views, samplers, and bind groups that create and
  drop real resources on either OpenGL or Vulkan, including allocation-free
  repeated partial mip-level RGBA/BGRA upload/readback, queried 16x sampler anisotropy,
  and allocation-free checked buffer subrange upload/readback, GPU fills, and
  GPU buffer/texture copies, allocation-free GPU mip-chain generation,
  render-attachment-only 2x/4x/8x/16x multisampled color/depth textures, plus
  allocation-free repeated compute dispatch;
- affine color render targets that own completeness-checked OpenGL FBOs or
  Vulkan image views/render passes/framebuffers and support allocation-free
  validated clear/readback plus procedural, direct, indexed, instanced, bind-
  group, and GPU-indirect offscreen draws, with optional affine depth-texture
  ownership and depth-tested/written target pipelines, plus two-to-eight affine
  color attachments driven by reflected fragment-output locations, combinable
  with depth and reusable per-attachment clear/load/discard and store/discard
  passes; matching-sample multisampled target pipelines render on both drivers,
  and explicit allocation-free per-color resolves copy single- or multiple-
  color multisampled targets into application-owned single-sample textures for
  sampling or readback; target constructors can instead take affine ownership
  of one resolve texture per color and update them automatically after every
  clear or draw pass through native Vulkan subpass resolve attachments or a
  reusable OpenGL resolve FBO; prepared two-to-eight-stage procedural subpass
  sequences bind one affine pipeline per stage, map to native Vulkan subpasses
  with explicit dependencies, and retain an allocation-free ordered OpenGL
  fallback;
- pure-Abla IEEE-754 binary64-to-binary32 rounding so native `f64` colors reach
  both drivers without a foreign shim;
- an allocation-free portable idle boundary backed directly by `glFinish` or
  `vkDeviceWaitIdle` for diagnostics and lifecycle synchronization;
- queried and explicitly enabled Vulkan 1.2 timeline semaphores with affine
  ownership plus allocation-free counter, monotonic host-signal, and bounded
  wait operations on both headless and surfaced logical devices; Vulkan 1.3
  synchronization2 is independently queried/enabled and the reusable transfer
  boundary submits through `vkQueueSubmit2`, signals a device-owned timeline,
  records memory/image transitions through `vkCmdPipelineBarrier2`, and waits
  only for that completion value, with a legacy fallback; surfaced pipelines
  use feature-gated `vkCmdBeginRendering`/`vkCmdEndRendering` without native
  render-pass/framebuffer objects, while offscreen/subpass paths retain them;
- a pure-Abla, deterministic Khronos XML inventory generator with pinned and
  hash-verified Vulkan/OpenGL inputs plus strict, evidence-backed coverage
  audits, 6,271 generated OpenGL constants, 5,633 selected Vulkan constants,
  43 desktop OpenGL type records, 2,497 selected Vulkan type records, and
  structured ABI signatures for 9,526 OpenGL and 2,845 Vulkan command
  parameters, plus declaration-ordered metadata for 1,450 Vulkan aggregates
  and 7,413 members; the independently compiled raw metadata modules leave
  every unaudited row visibly unclassified;
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
- `examples/common-triangle`: one `$glsl` vertex/fragment package and affine
  pipeline plus an interleaved `vec2` position/`vec4` color vertex buffer and
  common index buffer rendered unchanged on explicit OpenGL and Vulkan, with
  repeated no-growth and stable-handle assertions;
- `examples/common-buffer`: one affine descriptor/resource plus reusable byte
  ranges and GPU copies exercised unchanged on explicit OpenGL and Vulkan; and
- `examples/common-texture`: color mip chains and depth views exercised
  unchanged on explicit OpenGL and Vulkan, including partial mip upload and
  exact readback plus cross-mip GPU copies; and
- `examples/common-textured`: an uploaded 2x2 atlas, explicit affine bind group,
  reflected texture shader, and indexed textured triangle exercised unchanged
  on explicit OpenGL and Vulkan, including no-growth repeated draws and resize;
- `examples/indexed-textured-cube`: 24 interleaved position/UV vertices, 36
  reusable indices, a four-color atlas, a 64-byte transform uniform, and depth-
  tested cube faces rendered unchanged on explicit OpenGL and Vulkan;
- `examples/render-to-texture`: direct, indexed, and GPU-indirect vertex-buffer
  scene draws render with depth into a 4x multisampled 256x256 affine
  color/depth target with an owned single-sample resolve texture, then a
  fullscreen textured pass samples the automatically resolved output into the
  window;
  one reusable target-bound pass supplies all four offscreen command forms for
  four allocation-free frames on both backends;
- `examples/multiple-render-targets`: one pure-Abla `$glsl` fragment stage
  writes exact red and green results to two 4x multisampled affine color
  attachments over a blue attachment loaded from the prior pass and a
  separately cleared cyan attachment, then automatically resolves both owned
  colors independently,
  while also exercising discard operations and depth for four allocation-free
  frames on both backends;
- `examples/common-compute`: one `$glsl` compute package compiled and dispatched
  unchanged on explicit OpenGL and Vulkan, including verified storage-buffer
  mutation and readback;
- `examples/gpu-timestamp`: one affine timestamp query measures four submitted
  frames on explicit OpenGL and Vulkan, including counter-period conversion,
  stable native handles, and zero steady-state live-memory growth; and
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
loops. The optional `src/debug.ab` facade exposes one affine, allocation-free
debug messenger over the native OpenGL and Vulkan callbacks. `$glsl` will be
an Abla-defined compile-time subparser with source-span diagnostics and
deterministic OpenGL GLSL/Vulkan SPIR-V output.

The companion [Abla Doom](https://github.com/AndreBaltazar8/abla-doom) project
is a complete all-Abla 2.5D raycasting homage built on this common pixel/input
API. Its repository contains the clean real-window screenshot, explicit
OpenGL/Vulkan smoke tests, and reproducible software-renderer frame benchmark.

See [the implementation plan](plan.md), [architecture](docs/architecture.md),
[current status](docs/status.md), and [toolchain prerequisites](docs/toolchain-prerequisites.md).

## License

Abla Graphics is licensed under the Mozilla Public License 2.0.
