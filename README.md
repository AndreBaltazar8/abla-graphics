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
  compatible allocation-slot aliasing plus pruned synchronization records,
  together with affine typed texture/buffer materialization that maps scheduled
  logical IDs to stable pooled OpenGL/Vulkan objects, retains caller-owned
  imports, rejects stale/access/descriptor/cross-kind mismatches, and submits combined
  conservative backend memory dependencies at ordered pass entry, plus a
  fixed-capacity affine command list that owns recorded render resources,
  seals and repeatedly replays exact pass markers, all-transient texture
  copies, typed procedural, direct/indexed, and vertex-/indexed-indirect
  offscreen renders with optional snapshotted reflected push values, and imported or graph-owned
  multi-buffer compute dispatches with sealed reflected push bytes, without
  warmed descriptor construction or live-memory growth; eligible Vulkan
  streams record their barriers and work into one command buffer and submit
  once;
- deterministic pure-Abla SPIR-V emission for strict no-op and observable
  single-member storage arithmetic compute subsets plus fixed, interleaved
  position/color, and sampled-texture vertex/fragment triangle subsets for
  `sampler2D`, `sampler2DArray`, `samplerCube`, and `sampler3D`, with
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
  multi-entry bind groups feed sampled textures or explicit subresource views
  plus uniform/storage buffers to
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
  repeated partial mip-level RGBA/BGRA upload/readback; the portable texture
  contract additionally creates 1D images, 2D arrays, cube maps, 3D volumes,
  inherited and sliced views, and BC1 linear/sRGB storage on both backends,
  with exact synchronous pitched byte upload/readback and same-format
  subresource copies across layers or physical depth; queried
  16x sampler anisotropy and allocation-free checked buffer subrange
  upload/readback, GPU fills, and
  GPU buffer/texture copies, fixed-slot asynchronous texture upload and
  readback queues for RGBA/BGRA pixels plus pitched raw 1D/2D/array/cube/3D
  and BC1 selections, fixed-metadata device-local buffer suballocation
  with generation-checked slice transfers, aligned uniform/storage ranges,
  and nonzero-offset surfaced and offscreen target/pass
  vertex/index/direct-indirect draws (including reflected push values),
  allocation-free GPU mip-chain generation,
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

Executables built in that Nix environment retain the concrete Vulkan, X11,
EGL, and OpenGL loader locations. They can therefore be launched directly
after the build; inheriting the development shell's `LD_LIBRARY_PATH` is not a
runtime requirement. `make test-runtime-linkage` rebuilds a combined headless
application, verifies that `ldd` reports no unresolved dependency, clears the
shell-only graphics environment, and runs both backends.

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
  pipeline plus an interleaved `vec2` position/`vec4` color/`uint` tag vertex
  buffer and common index buffer rendered unchanged on explicit OpenGL and
  Vulkan, with repeated no-growth and stable-handle assertions; its reflected location-zero
  `vec4` fragment input is loaded by the typed raster IR rather than a fixed
  SPIR-V fragment table;
- `examples/common-buffer`: affine buffers with reusable byte ranges,
  mapped-at-creation upload, post-creation write/read remapping, coherent
  persistent transfers, bounded aligned upload/readback rings, GPU copies, and
  stable zero-allocation repeats on explicit OpenGL and Vulkan;
- `examples/async-buffer`: three-slot fixed-capacity upload and readback queues
  that stage through an explicitly device-local destination, submit work before
  targeted waits, recover exact bytes, and reuse their native synchronization
  state with zero live-byte growth on explicit OpenGL and Vulkan; and
- `examples/async-texture`: three in-flight fixed-slot BGRA texture uploads,
  exact asynchronous RGBA readback, and allocation-free repeated streaming on
  explicit OpenGL and Vulkan;
- `examples/async-wider-texture`: pitched two-layer array upload/readback through
  fixed native slots, caller-padding preservation, and allocation-free scalar
  streaming on explicit OpenGL and Vulkan;
- `examples/buffer-pool`: aligned fixed-block suballocation from one
  device-local backing buffer, checked slice upload/readback, nonzero-offset
  direct/indexed/vertex-indirect/indexed-indirect rendering, stale and invalid
  range rejection, stable handles, and 1,000 allocation/release cycles with
  zero live-byte growth on explicit OpenGL and Vulkan;
- `examples/texture-pool`: generation-checked leases over three eagerly warmed
  homogeneous textures, pooled upload and sampled rendering, stable native
  objects, and 1,000 allocation-free acquire/release cycles on explicit OpenGL
  and Vulkan;
- `examples/materialized-render-graph`: two scheduled logical atlases reuse one
  typed physical texture, render four live sampled frames, and retain one
  stable native handle through 1,000 allocation-free graph executions on
  explicit OpenGL and Vulkan;
- `examples/graph-post-process`: graph-ordered transient upload, sampled
  offscreen rendering into a caller-owned imported target, post-pass copy into
  another transient, exact 16x16 readback, and 3,003 allocation-free backend
  barrier calls on explicit OpenGL and Vulkan;
- `examples/recorded-graph-copy`: a sealed four-record pass/copy stream with
  exact 2x2 readback, 1,001 reusable executions, stable graph-owned textures,
  2,006 barrier calls, and zero warmed live-memory growth on explicit OpenGL
  and Vulkan;
- `examples/recorded-graph-render`: a sealed six-record stream combining four
  graph passes, a transient texture copy, and an owned procedural offscreen
  render; it proves exact copy/render output, 1,001 allocation-free replays,
  stable native resources, and one Vulkan submission per complete replay;
- `examples/recorded-graph-compute`: an affine three-record two-pass compute
  stream that owns its planner-declared storage buffer and pipeline, snapshots
  a reflected push constant, reaches exact value `3003` through 1,001
  allocation-free replays, derives one buffer barrier per replay, and uses one
  Vulkan submission per replay or direct ordered OpenGL dispatch;
- `examples/recorded-graph-transient-compute`: three logical device-local
  buffers reuse two physical graph pools at slots `0/1/0`; a retained
  two-storage bind group reaches exact value `5007` through 1,001
  allocation-free replays with one barrier and one Vulkan submission per
  replay or ordered OpenGL dispatch;
- `examples/recorded-graph-texture-compute`: one retained sampled texture and
  one planner-visible storage buffer execute deterministic `$glsl` compute,
  reject sealed-map mutation, and accumulate exact value `1001` through 1,001
  allocation-free OpenGL/Vulkan/auto replays;
- `examples/recorded-graph-storage-image-compute`: one planner-visible affine
  RGBA8 storage texture executes deterministic `$glsl` `imageStore`, rejects
  sealed-map mutation, and preserves exact red through 1,001 allocation-free
  OpenGL/Vulkan/auto replays;
- `examples/recorded-graph-storage-image-view-compute`: an affine mip view
  executes reflected read-write `imageLoad`/`imageStore`, swaps exact red to
  green over 1,001 allocation-free OpenGL/Vulkan/auto graph replays, and
  rejects sealed-map mutation;
- `examples/recorded-graph-storage-image-r32f-compute`: an extended-format
  R32F storage image executes retained `$glsl` compute, preserves exact IEEE
  `1.0f` through 1,001 allocation-free dual-backend replays, and rejects sealed
  stage-map mutation;
- `examples/recorded-graph-layered-storage-images`: one retained dispatch owns
  a 2D-array image and a 3D volume, writes exact green to layer two and exact
  blue to slice one, rejects a swapped sealed resource map, and reads both
  subresources back after 1,001 allocation-free OpenGL/Vulkan/auto replays;
- `examples/fragment-storage-image`: a fragment-stage `imageStore` writes exact
  green to a separate RGBA8 image while the same draw writes exact red to its
  color attachment through 1,001 allocation-free OpenGL/Vulkan/auto renders;
- `examples/recorded-graph-buffered-render`: one sealed four-record stream owns
  separate planner-declared vertex and indexed draws, produces exact pixels
  through 1,001 allocation-free replays, and uses one Vulkan submission per
  replay or scalar OpenGL replay;
- `examples/recorded-graph-indirect-render`: separate planner-declared draw and
  indexed-draw command buffers drive two exact offscreen triangles through
  1,001 allocation-free replays and one consolidated Vulkan submission;
- `examples/recorded-graph-push-render`: procedural and indexed-indirect records
  snapshot reflected red tint data before its source is changed to green, then
  preserve exact red output through 1,001 allocation-free dual-backend replays;
- `examples/recorded-graph-depth-render`: a planner-visible color/depth pair
  drives an owned depth-tested buffered target through 1,001 exact,
  allocation-free replays and one Vulkan submission per replay;
- `examples/recorded-graph-resolve-render`: a planner-visible 4x multisample
  color/resolve pair produces exact resolved output through 1,001 zero-growth
  replays and one Vulkan submission per replay;
- `examples/recorded-graph-mrt-render`: a buffered draw owns vertices plus two
  4x colors, two resolves, and depth, producing exact red/green output through
  1,001 allocation-free replays;
- `examples/recorded-graph-subpasses`: one graph record owns a compatible pass,
  target, ordered two-stage procedural sequence, and snapshotted reflected
  values, producing exact output through 1,001 allocation-free replays and one
  Vulkan submission per replay;
- `examples/recorded-graph-binding-subpasses`: two planner-declared uniform
  buffers feed distinct stages of one owned subpass sequence, producing exact
  output through 1,001 allocation-free OpenGL/Vulkan replays;
- `examples/recorded-graph-texture-render`: one composable ordinary recorded
  draw retains its sampled texture and sampler, rejects sealed-map mutation,
  and produces exact output through 1,001 allocation-free OpenGL/Vulkan/auto
  replays;
- `examples/recorded-graph-texture-subpasses`: two planner-declared sampled
  textures and affine samplers feed distinct recorded stages with exact output,
  zero warmed growth, and one Vulkan submission per replay;
- `examples/recorded-graph-transient-texture-subpasses`: a graph-owned sampled
  texture keeps one physical pool lease and one prebuilt descriptor across
  1,001 exact allocation-free recorded subpass replays;
- `examples/common-texture`: color mip chains and depth views exercised
  unchanged on explicit OpenGL and Vulkan, including partial mip upload and
  exact readback plus cross-mip GPU copies;
- `examples/wider-texture`: pitched RGBA array upload, layered GPU copy, exact
  readback with padding preservation, array/cube/volume/BC1 resource views, and
  allocation-free repeated primitive transfers on explicit OpenGL and Vulkan;
- `examples/wider-sampling`: exact 2D-array layer, cube face, and 3D volume
  sampling through reflected target-aware bind groups and deterministic
  pure-Abla SPIR-V, including explicit narrowed array-layer/cube-face/volume
  views, mismatch rejection, stable native handles, and zero live-byte growth
  on explicit OpenGL and Vulkan;
- `examples/common-textured`: an uploaded 2x2 atlas, explicit affine bind group,
  reflected texture shader, and indexed textured triangle exercised unchanged
  on explicit OpenGL and Vulkan, including no-growth repeated draws and resize;
- `examples/indexed-textured-cube`: 24 interleaved position/UV vertices, 36
  reusable indices, a four-color atlas, a 64-byte transform uniform, and depth-
  tested cube faces rendered unchanged on explicit OpenGL and Vulkan;
- `examples/render-to-texture`: direct, indexed, and GPU-indirect vertex-buffer
  scene draws from one device-local pool at nonzero offsets render with depth
  into a 4x multisampled 256x256 affine
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
- `examples/narrow-input`: one interleaved `vec2` vertex attribute is
  interpolated through a typed `vec2` fragment location, permuted through `.yx`,
  and composed into a `vec3` color output, proving exact pixels, stable handles,
  and zero-growth repeated offscreen and presented frames on OpenGL and Vulkan;
- `examples/push-color`: one reflected 16-byte `vec3` tint plus scalar alpha
  push block drives the same
  procedural or device-local pooled triangle through all sixteen portable
  direct, indexed, GPU-indirect, reusable attachment-pass, offscreen, and
  window presentation forms plus an affine two-subpass sequence on OpenGL and
  Vulkan, with exact pixel proof, persistent native handles, changing values,
  and zero-growth repeated frames;
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
  rebinding in storage-free SSA form, a typed `dot` product against a
  `normalize`d alpha axis clamped through nested
  `abs`/`sqrt`/`smoothstep`/`step`/`mix` `GLSL.std.450` calls, vector negation,
  a `cos(atan(y, x)) + fwidthFine(vec2(...)).x` phase, and precedence-ordered
  vector/scalar division, scalar and vector/scalar `mod`, vector clamp with
  scalar bounds, scalar-factor vector `mix`, plus addition,
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
