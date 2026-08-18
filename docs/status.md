# Implementation status

Updated: 2026-08-18.

## Verified now

- Pure core test: backend selection, structured errors, window configuration,
  geometry, and deterministic fixed-point vectors/colors.
- X11 test: AF_UNIX connection, protocol 11 setup, server metadata parsing,
  binary Xauthority parsing and MIT-MAGIC-COOKIE-1 authentication, XID
  allocation, atom interning, CreateWindow, title and WM_PROTOCOLS properties,
  MapWindow, active keyboard-map retrieval, portable KeySym translation,
  portable pointer buttons, wheel-to-scroll translation, signed pointer
  coordinates, ordered key-then-UTF-8 text events with shifted/caps and Unicode
  KeySym handling, synthetic keyboard/text/pointer/scroll round trips with raw
  diagnostic codes, event poll/decode, initially hidden windows, idempotent
  show/hide, runtime title changes, ConfigureWindow/ConfigureNotify resize with
  authoritative owned dimensions, fixed-size and undecorated WM hints,
  fullscreen EWMH state, explicit transparent-window rejection,
  WM_DELETE_WINDOW client-message round trip, DestroyWindow, and close, running
  against authenticated Xvfb without an Xlib/XCB/GLFW window-management layer.
- Vulkan test: loader version, instance, physical-adapter properties, graphics
  queue-family selection, logical device, host-visible coherent allocation,
  buffer binding, command pool/buffer, GPU fill, transfer-to-host barrier,
  queue submission/wait, mapping/readback, and reverse-order affine cleanup.
- Vulkan X11 surface test: required instance extensions, `VkXlibSurfaceKHR`
  creation for the direct Abla window, per-adapter graphics/presentation queue
  checks, surface capabilities/formats, a swapchain-enabled logical device,
  swapchain creation/image enumeration, semaphore-synchronized acquisition,
  image layout barriers, GPU clear, queue submission/presentation/wait, and
  affine reverse-order teardown.
- OpenGL test: EGL surfaceless display initialization, config/pbuffer/context
  creation with 4.6/4.5/3.3 negotiation, core version query, viewport/clear,
  RGBA8 readback, and affine EGL cleanup.
- Surfaced OpenGL test: direct Abla X11 window creation/title, an Abla-owned
  X11/EGL WSI bridge, window surface and core context creation, GLSL shader
  compile/link diagnostics, VAO/full-screen triangle draw, pixel readback,
  buffer swap, and reverse-order affine cleanup.
- Common application test: explicit OpenGL, explicit Vulkan, automatic Vulkan
  preference, automatic fallback to OpenGL, and explicit-unavailable rejection;
  successful paths create an affine application, report the selected adapter,
  convert a common fixed-point color to IEEE-754 bits in Abla, and present it
  under Xvfb/Lavapipe. The explicit OpenGL path additionally requests a resize,
  consumes its copied event, synchronizes viewport dimensions, and presents at
  the new window size. The explicit Vulkan path performs the same round trip,
  waits for the queue, drops presenter-before-swapchain, re-queries the surface,
  recreates the swapchain and persistent upload resources at 360x240, and
  presents again.
- Reusable RGBA8 pixel test: bounds-checked pixel/rectangle writes use affine
  native storage; surfaced OpenGL uploads it through one persistent
  nearest-filtered texture/shader program, while Vulkan uses a persistent
  coherent staging buffer, swapchain-format channel adaptation, image layout
  barriers, buffer-to-image copy, synchronized presentation, and persistent
  command-pool/command-buffer/semaphore resources across frames.
- Portable descriptor test: immutable buffer, texture, texture-view, and sampler
  descriptors validate usage flags, mapping constraints, dimensions, mip and
  multisample rules, format/view compatibility, subresource ranges, aspects,
  filters, comparison, LOD, and anisotropy with field-specific diagnostics.
- Common affine buffer test: one `BufferDescriptor` creates an OpenGL buffer or
  Vulkan buffer/allocation after one-time backend selection; both paths pass
  checked nonzero-offset 64-bit write/read, overflow-safe bounds rejection,
  invalid-descriptor errors, mapped-at-creation rejection, and deterministic
  destruction under the surfaced application test.
- Common buffer sample: one independently buildable Abla source creates and
  verifies the same 256-byte storage buffer under explicit OpenGL and Vulkan in
  the software-driver sample matrix.
- Common affine sampler test: one immutable descriptor creates and destroys an
  OpenGL sampler object or Vulkan `VkSampler` with repeat/mirror addressing,
  linear min/mag/mipmap filtering, LOD range, and comparison state. Anisotropy
  above one is rejected as an unsupported negotiated feature on both paths.
- Common affine texture/view test: one descriptor creates complete color mip
  chains and depth images as OpenGL 2D texture objects or bound Vulkan images.
  Omitted view counts resolve to all remaining subresources; full OpenGL views
  alias their texture while Vulkan creates and destroys `VkImageView` objects.
  Vulkan mutable-format images additionally verify compatible linear-to-sRGB
  views while OpenGL reports that operation as unsupported. Both paths verify
  color/depth aspects, invalid-range diagnostics, multisample feature
  rejection, and reverse-order affine cleanup. The
  independently buildable common-texture sample runs this slice under explicit
  OpenGL and Vulkan.
- Abla `$glsl` subparser test: runtime and frozen `#$glsl` packages, raster and
  compute stage blocks, balanced nested scopes, comment preservation, typed
  stage lookup, explicit input/output location reflection, descriptor set and
  binding reflection including declaration types/names, duplicate location and
  binding rejection, cross-stage binding compatibility, adjacent raster-stage
  missing/type-mismatched interface rejection, fixed/unsized declaration array
  extents, checked compute workgroup sizes/defaults, and compile-time rejection
  of invalid stage names. The surfaced triangle is compiled from this package
  rather than opaque strings.
- Pure-Abla SPIR-V/Vulkan shader-module test: immutable copied words validate
  the SPIR-V 1.0-1.6 header, unsigned word domain, and every instruction
  boundary before little-endian packing. A minimal valid compute module creates
  and affinely destroys a real `VkShaderModule`; a zero-word-count instruction
  is rejected before reaching the driver.
- Deterministic `$glsl` emission test: a strictly parsed compute shader with a
  Vulkan-capable version, reflected `(8, 4, 1)` local size, and empty `main`
  emits SPIR-V entirely in Abla. Repeated emissions are word-identical and the
  result creates a real Lavapipe shader module. Statements and unsupported GLSL
  versions fail explicitly instead of being omitted from the module.
- Vulkan compute execution test: the Abla-emitted module creates an empty
  pipeline layout and real compute pipeline, records bind/dispatch into a
  persistent command buffer, submits workgroups, waits for completion, and
  resets for reuse. Repeated dispatch preserves command-pool/buffer handles;
  teardown destroys pipeline, pool, then layout. A zero-group dispatch is
  rejected before command recording.
- Common compute test/sample: the same `$glsl` package creates an OpenGL 4.5
  compute program or the Vulkan SPIR-V/module/pipeline chain after one-time
  backend selection. Explicit OpenGL/Vulkan plus automatic/fallback paths
  dispatch repeatedly; zero-sized dispatch is rejected on both backends.
  OpenGL does not force `glFinish` after dispatch.
  Unsupported compute statements return the same common feature error before
  either OpenGL or Vulkan pipeline creation.
- Observable storage compute test/sample: a reflected binding-zero `std430`
  block is emitted as SPIR-V `BufferBlock`/descriptor decorations and a real
  access-chain/store. The grammar accepts both an unsigned constant assignment
  and self-plus/self-times-unsigned assignments; the latter forms emit
  `OpLoad`, `OpIAdd` or `OpIMul`, and `OpStore`. OpenGL binds an SSBO; Vulkan
  creates and binds descriptor
  layout/pool/set state. Explicit and automatic/fallback paths dispatch the
  same multiplication package and common buffer readback returns exactly `6`;
  the raw Vulkan variant multiplies twice and returns `18`, proving repeated
  commands operate on observable persistent storage.
- Project tree inspection finds no C/C++/Rust source and no GLFW/SDL dependency.
- The required general `ablac` `nativeLibraries` contract is integrated in
  compiler commit `116090f`; graphics tests use the stock sibling compiler.
- GitHub CI bootstraps `ablac` from its pinned seed and runs the complete
  Abla-only, core, authenticated X11, GLSL, Vulkan, OpenGL, and sample matrix
  against pinned Mesa Lavapipe/software rendering on every push and pull
  request.

The full `nix-shell --run 'make test'` matrix passes on a host with an RTX
4090, Intel UHD 770, NVIDIA Vulkan 1.4 driver, Mesa Vulkan/OpenGL, and no active
desktop display.

GitHub Actions runs through `32080086836` verify the complete matrix, including
the common facade and OpenGL/Vulkan software-frame presentation, from clean
checkouts against the pinned software drivers. Newer commits retain the same
local full-matrix gate before publication and receive their own hosted run.

The current compiler also lacks usable source-level floating literals and
floating arithmetic/ABI conformance. Graphics math is temporarily fixed-point;
the public 0.1 math and color surface will not freeze until the general compiler
capability lands.

## Not yet claimed

- Vulkan frames-in-flight without per-frame queue idle, automatic recovery from
  acquire/present out-of-date results that arrive without a resize event,
  render pipelines, synchronization2, and dynamic rendering.
- Wayland, Windows, or macOS platform modules.
- X11 compose/dead-key sequences, input methods, and additional XKB groups.
- Broad OpenGL buffer/texture/framebuffer/compute and extension coverage.
- Full GLSL 4.60 grammar validation/reflection or SPIR-V emission. The current
  subparser owns stage structure/source preservation plus the initial explicit
  location/set/binding declaration and cross-stage compatibility slice,
  deliberately rejects quoted includes, and does not yet parse block members,
  general declarations, or expressions. SPIR-V emission currently covers the
  strict no-op and single-member storage-assignment compute subsets described
  above, not
  general shaders.
- Generated Khronos registry bindings and complete coverage ledgers.
- Texture uploads/copies/render-pass use, mapped/general buffer ranges, queued
  uploads, device-local suballocation policy, command encoders/render graph,
  asset formats, or framework-wide performance gates. Common buffers,
  textures, views, samplers, and immutable structural descriptors are present;
  the wider resource surface is not yet claimed.
- The complete sample catalog, driver/platform CI matrix, or tagged release.

These remain milestones in [the implementation plan](../plan.md); they are not
represented as delivered.
