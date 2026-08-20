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
- a direct pure-Abla Wayland transport that resolves the configured compositor
  socket, encodes/decodes aligned wire messages, discovers registry globals,
  performs synchronization barriers, binds version-capped globals, and owns a
  stable xdg-shell toplevel from `wl_surface` creation through configure/ack,
  title/application ID, ping/pong, close intent, Linux `SCM_RIGHTS` descriptor
  transfer, affine `memfd`-backed XRGB shared pixels, reusable triple
  buffering, allocation-stable frame callbacks, capability-driven seat,
  pointer, keyboard, and framed multi-touch objects, ancillary XKB keymap
  receipt, pure-Abla group-1
  symbol/text parsing, deadline-driven keyboard repeat, a direct ARGB cursor
  surface with serial-correct visibility control, mutually exclusive native
  pointer lock/confinement and fixed-point relative motion, hotplug-aware atomic
  output snapshots with optional xdg logical geometry and surface enter/leave
  tracking, direct integer buffer scale/transform with compositor preferences,
  copied opaque/input regions, optional per-surface fractional-scale preferences,
  optional per-surface viewport source crops and destinations for presenting
  independently sized high-resolution buffers at the xdg-shell logical size,
  compositor-mediated UTF-8
  clipboard ownership/offers with bounded descriptor transfers, xdg
  fullscreen/maximize/minimize/fixed-size controls, explicit compositor/client
  decoration negotiation, direct idle inhibition, optional tearing policy,
  compositor content classification and presentation timing, and ordered teardown
  without `libwayland-client` or `libxkbcommon`;
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
- an Abla-defined `$glsl`/`#$glsl` stage parser with reflected named/nested
  structures, recursively checked interface-location ranges, and a shared
  pure-Abla GLSL lexer with exact byte/line/column spans;
- a deterministic pure-Abla render-graph planner with explicit dependencies,
  read/write hazard ordering, transient lifetimes, cycle rejection, and
  compatible allocation-slot aliasing plus pruned synchronization records;
- deterministic pure-Abla SPIR-V emission for strict no-op and observable
  single-member storage arithmetic compute subsets plus fixed, interleaved
  position/color, and sampled-texture vertex/fragment triangle subsets, with
  composable typed scalar/workgroup specialization constants, observable
  shared-token precedence-parsed signed/unsigned arithmetic, shift, bitwise,
  relational, Boolean/logical, unary, and integer ternary expressions over
  checked multi-member storage blocks, including declaration-before-use typed
  scalar locals and reassignment lowered as zero-storage SSA bindings with
  typed selection-merge and loop-carried phis, plus signed/unsigned `min`,
  `max`, and `clamp`, and nested structured
  `if`/`else if`/`else` branches and `while` loops with nearest-loop `break`
  and `continue` plus void early `return` over buffer updates, with unsupported
  GLSL rejected rather than ignored;
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
- deterministic Wayland wire tests plus live direct-client registry/bind and
  stable xdg-shell configure/ack probes, a real `wl_shm` pixel frame, and a
  captured 1024x768 Pixman compositor screenshot against headless Weston, plus
  a real two-client selection transfer through nested Weston;
- a real Vulkan 1.4 instance/device/GPU-command/readback test;
- headless and surfaced EGL/OpenGL draw/readback tests; and
- runtime/frozen GLSL subparser structure and invalid-stage diagnostics.

The Vulkan and OpenGL tests use the stock compiler from `../ablac/build/ablac`.
CI pins Mesa's Lavapipe and software OpenGL paths so the complete backend matrix
also runs on clean GitHub-hosted machines without physical GPUs.

## Samples

- `examples/x11-window`: direct X11 window/event loop;
- `examples/wayland-info`: direct Wayland socket, registry, and global report;
- `examples/wayland-window`: direct stable xdg-shell toplevel construction and
  initial configure/ack handshake plus optional decoration and viewport setup;
- `examples/wayland-pixels`: direct affine XRGB shared-memory buffer fill,
  attach, damage, commit, and frame completion;
- `examples/wayland-animation`: allocation-stable triple-buffered XRGB
  animation paced by compositor frame callbacks;
- `examples/wayland-input`: direct seat capability, pointer, keyboard, cursor,
  and keymap report using the portable window-event vocabulary;
- `examples/wayland-output`: direct output name, current mode, physical size,
  and integer scale report;
- `examples/wayland-clipboard`: direct data-device UTF-8 copy/paste using C and
  V after the compositor supplies a real input serial;
- `examples/vulkan-info`: loader and physical-adapter report;
- `examples/vulkan-surface`: X11 WSI adapter/capability selection;
- `examples/headless-opengl`: surfaceless context and framebuffer clear; and
- `examples/opengl-window`: surfaced shader-backed triangle;
- `examples/common-clear`: backend-neutral automatic selection and clear/present;
- `examples/common-triangle`: one `$glsl` vertex/fragment package and affine
  pipeline plus an interleaved `vec2` position/`vec4` color vertex buffer and
  common index buffer rendered unchanged on explicit OpenGL and Vulkan, with
  repeated no-growth and stable-handle assertions; its reflected location-zero
  `vec4` fragment input is loaded by the typed raster IR rather than a fixed
  SPIR-V fragment table;
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
  uses two typed raster output expressions to write exact red and green results
  to two 4x multisampled affine color
  attachments over a blue attachment loaded from the prior pass and a
  separately cleared cyan attachment, then automatically resolves both owned
  colors independently,
  while also exercising discard operations and depth for four allocation-free
  frames on both backends;
- `examples/common-compute`: one `$glsl` compute package compiled and dispatched
  unchanged on explicit OpenGL and Vulkan, including verified storage-buffer
  comparison/logical/ternary mutation and readback plus reusable reflected push
  constants with exact output, stable handles, and zero-growth repeated
  dispatch;
- `examples/push-color`: one reflected `vec4` push block drives the same
  procedural or buffered triangle through all sixteen portable direct,
  indexed, GPU-indirect, reusable attachment-pass, offscreen, and window
  presentation forms plus an affine two-subpass sequence on OpenGL and Vulkan,
  with exact pixel proof, persistent native handles, changing values, and
  zero-growth repeated frames;
- `examples/push-transform`: one vertex-visible `vec4` push block translates a
  procedural triangle while its constant-only fragment is generated by the
  typed raster IR from a deduplicated `vec4(1.0)` scalar splat, proving exact
  centered and shifted-off-center pixels,
  missing-value rejection, persistent native handles, and zero-growth repeated
  frames on both backends;
- `examples/push-draw`: one shared 32-byte vertex/fragment push block controls
  procedural geometry and tint together, proving combined stage masks, exact
  shifted and recolored pixels, stable handles, and zero-growth repeated frames
  on both backends;
- `examples/push-expression`: a typed fragment expression combines two
  reflected `vec4` push members with a reflected scalar gain and
  comma-declared mutable scalar locals updated with prefix/postfix `++`/`--`,
  including reflected `.w` extraction and `.bgra` permutation, plus vector
  locals including a runtime scalar-splat `vec4` denominator and `+=`
  rebinding in storage-free SSA form, a typed `dot` product clamped through
  nested `abs`/`sqrt`/`smoothstep`/`step`/`mix` `GLSL.std.450` calls, vector
  negation, and
  precedence-ordered vector/scalar division plus addition,
  producing exact alternating red/green pixels with stable handles and
  zero-growth repeated frames on both backends;
- `examples/gpu-timestamp`: one affine timestamp query measures four submitted
  frames on explicit OpenGL and Vulkan, including counter-period conversion,
  stable native handles, and zero steady-state live-memory growth; and
- `examples/frame-pacing`: display-free high-resolution pacing with a live-memory
  assertion across the steady-state frame loop; and
- `examples/render-graph`: display-free dependency planning with deterministic
  pass order, transient lifetime aliasing, imported resources, and inspected
  synchronization records.

Run the sample smoke matrix with:

```sh
nix-shell --run 'make test-samples'
```

The sibling [Abla Doom](https://github.com/AndreBaltazar8/abla-doom) project is
a playable original 2.5D raycasting homage built entirely in Abla on this
framework. It renders and presents the same procedural framebuffer through
OpenGL and Vulkan and publishes a reproducible window-only proof screenshot.

## API direction

Normal applications will use the backend-neutral `graphicsApplication`,
resource descriptors, encoders, and render/compute passes described in
[the API contract](docs/api.md). Complete generated escape hatches will live
under `graphics/raw/opengl` and `graphics/raw/vulkan`.

GPU/window resources are affine Abla `resource class` values. Frame command
data will use reusable arenas and backend selection is kept out of inner draw
loops. The optional `src/debug.ab` facade exposes one affine, allocation-free
debug messenger over the native OpenGL and Vulkan callbacks. `$glsl` is an
Abla-defined compile-time subparser with source-span diagnostics and
deterministic OpenGL GLSL/Vulkan SPIR-V output.

The companion [Abla Doom](https://github.com/AndreBaltazar8/abla-doom) project
is a complete all-Abla 2.5D raycasting homage built on this common pixel/input
API. Its repository contains the clean real-window screenshot, explicit
OpenGL/Vulkan smoke tests, and reproducible software-renderer frame benchmark.

See [the implementation plan](plan.md), [architecture](docs/architecture.md),
[current status](docs/status.md), and [toolchain prerequisites](docs/toolchain-prerequisites.md).

## License

Abla Graphics is licensed under the Mozilla Public License 2.0.
