# Architecture

Abla Graphics separates policy from unavoidable platform ABI mechanics.

```text
Application and samples (Abla)
              |
       graphics facade
              |
  backend-neutral descriptors and encoders (Abla)
       /                              \
OpenGL 4.6 backend (Abla)      Vulkan 1.4 backend (Abla)
       \                              /
 generated raw APIs + Abla platform/driver ABI modules
              |
 window system, OpenGL driver, Vulkan loader
```

## Abla-only platform boundary

The repository contains no C, C++, Rust, GLFW, or SDL implementation layer.
Window systems are implemented in Abla at their operating-system protocol
boundary: Linux uses Abla syscall/socket modules for X11 and Wayland, while the
Windows and macOS ports use direct platform ABI modules written in Abla.
The current Wayland layer owns the AF_UNIX transport, core wire codec, display
registry bootstrap, synchronization, and global binding directly. It also
constructs an affine `wl_surface`/stable `xdg_surface`/`xdg_toplevel` object
tree, handles the version-one shell event set, acknowledges the initial
configure, and destroys that tree in protocol order. Shared pixel buffers,
input, clipboard, outputs, and driver presentation build on this object
foundation in later slices. No `libwayland-client` ABI participates in this
path.

Vulkan and OpenGL are driver specifications, so their installed system/driver
entry points remain external by definition. All loading, structure layout,
pointer storage, feature negotiation, object ownership, and command policy on
the application side is Abla. Versioned structures are built in bounded Abla
native buffers through `abla/unsafe/memory`; no project shim marshals them.

## API layers

`src/graphics.ab` is the package facade. It exposes windowing, adapters/devices,
portable resource descriptors, command encoders, render/compute passes, shader
modules, surfaces, and structured results.

`src/window.ab` owns platform-neutral window and event behavior. Events are
polled into Abla values; the platform never retains an Abla closure.

`src/opengl/` and `src/vulkan/` implement the portable contracts. Backend
selection is performed once. Backend objects store the specialized operations
needed by their command path, avoiding a backend branch per vertex or resource.

`src/raw/opengl/` and `src/raw/vulkan/` are deterministic registry-generated
surfaces. They are explicit escape hatches, not implementation details of the
common API. Native handles require importing an unsafe/raw module.

`src/shader/` contains the `$glsl` parser, reflection model, and target emitters.
The parser is an ordinary Abla compile-time subparser registered through
`abla/compiler/parser` and returns normal typed Abla expressions.

`src/platform/` contains Abla-only operating-system protocol implementations.
`src/driver/` contains Abla-only dynamic loader and driver ABI layouts. Unsafe
operations stay inside these trusted modules and return owned or copied values
to the rest of the framework.

## Ownership and errors

Native GPU/window objects are represented by Abla `resource class` values.
Their `drop()` methods enqueue or perform the correct backend destruction once.
Child resources retain explicit device identity, and debug validation rejects
cross-device or use-after-parent operations before reaching a driver.

Creation APIs return result values containing either a resource or a structured
`GraphicsError`. Frame operations that can recover return a status such as
`ready`, `resized`, `occluded`, `surfaceLost`, or `deviceLost`. Programmer
contract violations are diagnostics in debug builds; environmental failures
are values.

## Performance model

- Immutable creation descriptors are optimized away from steady-state work.
- Frame-local commands and small payloads use resettable arenas.
- Uploads use persistently mapped/staging rings where supported.
- Vulkan records into per-frame/per-thread pools and uses synchronization2.
- OpenGL uses direct-state access and measured state filtering.
- Pipeline/shader caches use full content and device/driver identities.
- Destruction may be deferred behind GPU completion but remains owned by the
  originating resource lifetime.
- Validation, metrics, and labels are selectable without changing API shape.

The render graph is optional. It can derive barriers, transient lifetimes, and
aliasing, but direct command encoders remain first-class for exact control.

## Specification coverage

The common API aims at portable graphics and compute concepts, not a lossy union
of two APIs. Generated raw APIs target the complete pinned Khronos registries.
A coverage ledger classifies every core command and extension as common, raw,
intentionally unsupported, or platform-inapplicable, with evidence for supported
families.

The initial baselines are OpenGL 4.6 core/GLSL 4.60 and Vulkan 1.4. Registry
patch revisions are pinned by the generator manifest and updated deliberately.
