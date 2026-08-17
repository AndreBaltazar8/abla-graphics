# Implementation status

Updated: 2026-08-17.

## Verified now

- Pure core test: backend selection, structured errors, window configuration,
  geometry, and deterministic fixed-point vectors/colors.
- X11 test: AF_UNIX connection, protocol 11 setup, server metadata parsing,
  binary Xauthority parsing and MIT-MAGIC-COOKIE-1 authentication, XID
  allocation, atom interning, CreateWindow, title and WM_PROTOCOLS properties,
  MapWindow, event poll/decode, WM_DELETE_WINDOW client-message round trip,
  DestroyWindow, and close, running against authenticated Xvfb without an
  Xlib/XCB/GLFW window-management layer.
- Vulkan test: loader version, instance, physical-adapter properties, graphics
  queue-family selection, logical device, host-visible coherent allocation,
  buffer binding, command pool/buffer, GPU fill, transfer-to-host barrier,
  queue submission/wait, mapping/readback, and reverse-order affine cleanup.
- Vulkan X11 surface test: required instance extensions, `VkXlibSurfaceKHR`
  creation for the direct Abla window, per-adapter graphics/presentation queue
  checks, surface capabilities/formats, a swapchain-enabled logical device,
  swapchain creation and image enumeration, and affine reverse-order teardown.
  Image acquisition, rendering, and presentation are not claimed yet.
- OpenGL test: EGL surfaceless display initialization, config/pbuffer/context
  creation with 4.6/4.5/3.3 negotiation, core version query, viewport/clear,
  RGBA8 readback, and affine EGL cleanup.
- Surfaced OpenGL test: direct Abla X11 window creation/title, an Abla-owned
  X11/EGL WSI bridge, window surface and core context creation, GLSL shader
  compile/link diagnostics, VAO/full-screen triangle draw, pixel readback,
  buffer swap, and reverse-order affine cleanup.
- Abla `$glsl` subparser test: runtime and frozen `#$glsl` packages, raster and
  compute stage blocks, balanced nested scopes, comment preservation, typed
  stage lookup, and compile-time rejection of invalid stage names. The
  surfaced triangle is compiled from this package rather than opaque strings.
- Project tree inspection finds no C/C++/Rust source and no GLFW/SDL dependency.
- GitHub CI bootstraps `ablac` from its pinned seed and runs the Abla-only,
  core, authenticated X11, and GLSL subparser gates on every push and pull
  request. Driver-backed jobs remain local until the native-library compiler
  change is integrated upstream and software ICD selection is pinned.

The full `nix-shell --run 'make test'` matrix passes on a host with an RTX
4090, Intel UHD 770, NVIDIA Vulkan 1.4 driver, Mesa Vulkan/OpenGL, and no active
desktop display.

## Toolchain dependency

`../ablac/src/toolchain.ab` has an uncommitted general implementation for a
bounded root-manifest `nativeLibraries` array. Abla Graphics builds and tests
that change as an isolated compiler candidate. Its focused linked-dependency
and unsafe-name rejection test passes, as does the compiler's byte-identical
pure-Abla O2 self-rebuild. It still needs review and integration before
consumers can use the stock compiler.

The current compiler also lacks usable source-level floating literals and
floating arithmetic/ABI conformance. Graphics math is temporarily fixed-point;
the public 0.1 math and color surface will not freeze until the general compiler
capability lands.

## Not yet claimed

- Vulkan image acquisition, rendering, synchronization, and queue presentation
  into the direct X11 window.
- Wayland, Windows, or macOS platform modules.
- Broad OpenGL buffer/texture/framebuffer/compute and extension coverage.
- Vulkan swapchains, images, descriptors, pipelines, synchronization2, dynamic
  rendering, compute, or advanced extension families.
- Full GLSL 4.60 grammar validation, reflection, or SPIR-V emission. The
  current subparser owns stage structure/source preservation but deliberately
  rejects quoted includes and does not yet parse declarations or expressions.
- Generated Khronos registry bindings and complete coverage ledgers.
- Portable command encoders/render graph, asset formats, or performance gates.
- The complete sample catalog, driver/platform CI matrix, or tagged release.

These remain milestones in [the implementation plan](../plan.md); they are not
represented as delivered.
