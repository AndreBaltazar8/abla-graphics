# Implementation status

Updated: 2026-08-18.

## Verified now

- Pure core test: requirement-aware backend selection/fallback, explicit and
  automatic unsupported-feature errors, capability masks and limit validity,
  structured errors, window configuration,
  signed-extreme checked geometry/area/volume, native `f64` vectors/matrix
  composition/colors, exact binary32 rounding, and deterministic nanosecond
  frame-period distribution, overflow handling, and late-frame resynchronizing.
- X11 test: AF_UNIX connection, protocol 11 setup, server metadata parsing,
  binary Xauthority parsing and MIT-MAGIC-COOKIE-1 authentication, XID
  allocation, atom interning, CreateWindow, title and WM_PROTOCOLS properties,
  MapWindow, active keyboard-map retrieval, portable KeySym translation,
  portable pointer buttons, wheel-to-scroll translation, signed pointer
  coordinates, ordered key-then-UTF-8 text events with shifted/caps and Unicode
  KeySym handling, synthetic keyboard/text/pointer/scroll round trips with raw
  diagnostic codes, event poll/decode, initially hidden windows, idempotent
  show/hide, runtime title changes, direct WarpPointer with a MotionNotify round
  trip, an Abla-created transparent core cursor with synchronized idempotent
  visibility changes and teardown, idempotent confined pointer grab/release,
  ConfigureWindow/ConfigureNotify
  resize with authoritative owned dimensions, fixed-size and undecorated WM
  hints,
  fullscreen EWMH state, setup-derived screen pixel/physical dimensions with
  DPI/content scale, asynchronous UTF8_STRING/TARGETS clipboard ownership and
  transfer between two direct clients, explicit transparent-window rejection,
  WM_DELETE_WINDOW client-message round trip, DestroyWindow, and close, running
  against authenticated Xvfb without an Xlib/XCB/GLFW window-management layer.
- Common headless test: with `DISPLAY` removed, explicit surfaceless EGL/OpenGL
  clears and reads a pbuffer while explicit Vulkan creates a logical device,
  submits a buffer fill, synchronizes, and reads the result back. Both paths
  require and verify the common compute/storage/texture/anisotropy feature set
  and real queried limits; Vulkan additionally requires format
  reinterpretation, while an explicit OpenGL request for it is rejected before
  application use.
- Vulkan test: loader version, instance, physical-adapter API version, queried
  2D texture/storage/compute limits and portable feature mask, graphics
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
  creation with 4.6/4.5/3.3 negotiation, core version plus legal version-gated
  2D texture/storage/compute limit queries and portable feature mask,
  viewport/clear, RGBA8 readback, and affine EGL cleanup.
- Surfaced OpenGL test: direct Abla X11 window creation/title, an Abla-owned
  X11/EGL WSI bridge, window surface and core context creation, GLSL shader
  compile/link diagnostics, VAO/full-screen triangle draw, pixel readback,
  buffer swap, and reverse-order affine cleanup.
- Common application test: explicit OpenGL, explicit Vulkan, automatic Vulkan
  preference, automatic fallback to OpenGL, explicit-unavailable rejection,
  and explicit unsupported-feature rejection. Every successful path requires
  compute, storage buffers, sampled/depth textures, comparison samplers, and
  sampler anisotropy,
  then verifies the reported API version and driver limits. Explicit Vulkan
  additionally requires the implemented view-format reinterpretation feature;
  successful paths create an affine application, report the selected adapter,
  round a common native `f64` color to IEEE-754 binary32 in Abla, and present it
  under Xvfb/Lavapipe. The explicit OpenGL path additionally requests a resize,
  consumes its copied event, synchronizes viewport dimensions, and presents at
  the new window size. The explicit Vulkan path performs the same round trip,
  waits for the queue, drops presenter-before-swapchain, re-queries the surface,
  recreates the swapchain and persistent upload resources at 360x240, and
  presents again. A second surfaced outcome-handler probe deliberately requests
  resizes without common application polling, supplies the classified
  `VK_ERROR_OUT_OF_DATE_KHR` outcome to the same handlers used in production,
  and proves that both clear and pixel paths rebuild real swapchain resources
  once, synchronize owned extents, retry, and present successfully. The pure
  status test separately covers success, suboptimal, out-of-date, and unrelated
  failure classification.
- Reusable RGBA8 pixel test: bounds-checked pixel/rectangle writes use affine
  native storage; surfaced OpenGL uploads it through one persistent
  nearest-filtered texture/shader program, while Vulkan uses a configured
  three-slot set of coherent staging buffers, swapchain-format channel adaptation,
  image layout barriers, buffer-to-image copy, synchronized presentation,
  per-slot command pools/buffers/acquire semaphores/fences, and render-finished
  semaphores owned per swapchain image. Four consecutive uploads exercise all
  three slots and fence-guarded reuse without a per-frame queue-wide idle. The
  public one-to-eight-slot setting survives both clear and pixel swapchain
  recovery; its default remains two.
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
  linear min/mag/mipmap filtering, LOD range, comparison state, and 16x
  anisotropy. OpenGL queries the ARB/EXT extension and maximum before using the
  float-vector parameter ABI. Vulkan queries the physical-device feature and
  float limit, zero-initializes the entire enabled-feature structure, enables
  only the advertised sampler bit, and records the anisotropic sampler state.
  Pure capability tests reject a request above the reported limit and a request
  on a device without the feature.
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
- Monotonic frame-pacing sample: a reusable affine clock owns its syscall
  buffers, four 240 fps waits advance real `CLOCK_MONOTONIC` time, and runtime
  live-memory accounting is unchanged across the steady-state loop.
- Pure-Abla Khronos inventory generation: exact official Vulkan and OpenGL
  registry commits and SHA-256 digests are pinned in one manifest; the generator
  filters Vulkan SC, OpenGL ES, and compatibility-only requirement branches,
  resolves selected command references against definitions, merges API
  variants, byte-sorts output, and produces committed coverage ledgers for 608
  Vulkan commands/5 core versions/473 extensions and 2,892 OpenGL commands/19
  core versions/623 extensions. Offline fixtures prove API filtering, aliases,
  exact output, and repeated-run determinism. Every row remains explicitly
  `unclassified`, so inventory presence is not represented as backend support.
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

Compiler commits `9581d03`, `db72fbf`, and `a38bca7` now provide runtime `f64`
literals, arithmetic, comparisons, direct/native/export/boxing ABI coverage,
exact bit-representation helpers, and explicit signed `int` conversion. The
public math, color, and DPI surface uses native `f64`; OpenGL/Vulkan ABI fields
receive deterministic binary32 rounding in pure Abla. Compile-time floating
evaluation and explicit language-level `f32` conversion remain future toolchain
work.

Compiler commit `2b376c3` adds the reusable affine nanosecond process clock used
by the allocation-free frame pacer; its complete 73-test conformance suite and
byte-identical pure-Abla self-rebuild passed before this framework slice.

## Not yet claimed

- General Vulkan frames-in-flight for clear and future render-pipeline paths,
  render pipelines, synchronization2, and dynamic rendering. The reusable
  pixel-upload path honors the configured one-to-eight fence-guarded slots and
  has no per-frame queue-wide idle; clear and pixel presentation now recover
  once from suboptimal or out-of-date swapchains.
- Wayland, Windows, or macOS platform modules.
- X11 compose/dead-key sequences, input methods, and additional XKB groups.
- Broad OpenGL buffer/texture/framebuffer/compute and extension coverage.
- Complete Vulkan feature-structure and OpenGL extension negotiation, optional
  feature preferences, per-dimension/per-stage limits, and typed extension
  objects. The current common capability report covers the initial
  seven-feature mask and six directly queried limits documented in the API
  contract.
- Full GLSL 4.60 grammar validation/reflection or SPIR-V emission. The current
  subparser owns stage structure/source preservation plus the initial explicit
  location/set/binding declaration and cross-stage compatibility slice,
  deliberately rejects quoted includes, and does not yet parse block members,
  general declarations, or expressions. SPIR-V emission currently covers the
  strict no-op and single-member storage-assignment compute subsets described
  above, not
  general shaders.
- Generated Khronos ABI bindings and fully classified coverage ledgers. The
  pinned, deterministic inventory ledgers exist, but all rows deliberately
  remain `unclassified` until loader/ABI and positive/negative test evidence is
  attached.
- Texture uploads/copies/render-pass use, mapped/general buffer ranges, queued
  uploads, device-local suballocation policy, command encoders/render graph,
  asset formats, or framework-wide performance gates. Common buffers,
  textures, views, samplers, and immutable structural descriptors are present;
  the wider resource surface is not yet claimed.
- The complete sample catalog, driver/platform CI matrix, or tagged release.

These remain milestones in [the implementation plan](../plan.md); they are not
represented as delivered.
