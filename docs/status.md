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
  coordinates, synthetic keyboard/pointer/scroll round trips with raw diagnostic
  codes, event poll/decode, initially hidden windows, idempotent show/hide,
  runtime title changes, fixed-size and undecorated WM hints, fullscreen EWMH
  state, explicit transparent-window rejection, WM_DELETE_WINDOW client-message
  round trip, DestroyWindow, and close, running against authenticated Xvfb
  without an Xlib/XCB/GLFW window-management layer.
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
  under Xvfb/Lavapipe.
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
- Abla `$glsl` subparser test: runtime and frozen `#$glsl` packages, raster and
  compute stage blocks, balanced nested scopes, comment preservation, typed
  stage lookup, and compile-time rejection of invalid stage names. The
  surfaced triangle is compiled from this package rather than opaque strings.
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

- Vulkan frames-in-flight without per-frame queue idle, swapchain recreation,
  render pipelines, driver-backed common descriptors/images/views,
  synchronization2, and dynamic rendering.
- Wayland, Windows, or macOS platform modules.
- Broad OpenGL buffer/texture/framebuffer/compute and extension coverage.
- Full GLSL 4.60 grammar validation, reflection, or SPIR-V emission. The
  current subparser owns stage structure/source preservation but deliberately
  rejects quoted includes and does not yet parse declarations or expressions.
- Generated Khronos registry bindings and complete coverage ledgers.
- Affine portable GPU resource creation, command encoders/render graph, asset
  formats, or framework-wide performance gates. Immutable structural
  descriptors are present, but they are not yet driver-backed common resources.
- The complete sample catalog, driver/platform CI matrix, or tagged release.

These remain milestones in [the implementation plan](../plan.md); they are not
represented as delivered.
