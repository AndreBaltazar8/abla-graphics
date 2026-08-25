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
configure, and destroys that tree in protocol order. The first content path
marshals Linux x86-64 `sendmsg`/`SCM_RIGHTS` in Abla, maps an affine
`memfd_create` allocation, creates `wl_shm_pool`/`wl_buffer` objects, and uses
buffer-coordinate damage plus frame callbacks. A bounded one-to-three-buffer
ring uses one mapping and fixed frame offsets. The hot path batches frame,
attach, damage, and commit requests into one 64-byte native write and decodes
routine callback/release traffic in reusable scratch storage, so steady-state
animation has no managed-allocation growth. The input path binds `wl_seat`
version seven and creates or releases pointer/keyboard objects as capabilities
change. Its direct `recvmsg` transport queues an `SCM_RIGHTS` descriptor across
intervening stream messages until the logical keyboard-keymap event consumes
it, then maps the XKB v1 text privately and copies it into owned Abla memory.
Portable raw key, focus, pointer, button, and scroll events share the X11
`WindowEvent` vocabulary. A bounded pure-Abla parser resolves numeric keycodes
and group-one symbols into fixed lookup tables, applies live Shift/Caps state,
and emits copied ASCII, Latin-1, or direct-Unicode UTF-8 text after key presses.
One reusable clock block drives compositor-configured keyboard repeat by
shortening the existing socket-poll deadline; late consumers resynchronize
instead of accumulating repeat bursts.
The capability-driven `wl_touch` object retains a bounded active-contact set
with exact 24.8 positions, ellipse axes, and orientation. Begin, move, end, and
cancel values enter the portable event queue only at the compositor's frame
boundary; shape-only frames still publish an update, and cancellation discards
superseded staged values before finalizing every active contact.
The cursor path procedurally fills an owned ARGB8888 `wl_shm` mapping and keeps
its role surface distinct from the application surface; visibility requests
retain and use only the pointer-enter serial required by the protocol. The
capture path combines a persistent pointer lock with a seat-relative pointer,
accumulates fractional accelerated motion into virtual coordinates, and
retains unaccelerated deltas without manufacturing raw-device claims. Surface
confinement shares the constraints manager but never creates a relative
pointer. Lock and confinement are mutually exclusive protocol roles; each
keeps requested state separate from compositor activation, and retired objects
continue accepting terminal events until `wl_display.delete_id` makes their
numeric identifiers reusable. The data-device path binds the seat's
selection device, tracks immutable MIME offers and serial-gated owned sources,
and transfers bounded UTF-8 through close-on-exec pipes carried with
`SCM_RIGHTS`. Output snapshots and surface membership use the same direct
object model. Higher XKB groups/compose and driver presentation remain later
slices. No `libwayland-client` or `libxkbcommon` ABI participates in this path.

Initial output discovery binds every `wl_output` v2-v4 global. Geometry, modes,
scale, and v4 identity strings replace immutable Abla snapshots until the
protocol's atomic `done`; surface enter/leave keeps a bounded active-output set
and emits the portable monitor-change value. The current direct layer exposes
hardware-pixel/physical metadata and integer scale without pretending that
deprecated core-output coordinates are xdg-output logical geometry. Registry
add/remove events bind fresh output objects or release and remove the matching
snapshot, surface membership, and primary selection; a real compositor gate
proves removal and rebinding use distinct protocol identifiers. The optional
xdg-output manager attaches logical position/size and versioned atomic completion
to each core object, keeping compositor coordinates separate from pixel modes.
The independent fractional-scale object reports a per-surface numerator over
120 and emits the preferred framebuffer extent without changing buffers behind
the application's back. The independent viewporter object stages an exact
24.8 fixed-point source crop and logical destination for the next surface
commit, allowing a differently sized physical buffer to be cropped and scaled
without conflating xdg-shell coordinates and pixels. Applications retain
explicit ownership of buffer creation and replacement. The optional
xdg-decoration object is created before content attachment and keeps requested
policy separate from the compositor's configured client/server mode; its
configure is paired with the following xdg-surface serial before the method
returns.
Core `wl_surface` scale and transform remain separate from both extensions.
Validated versioned requests stage a positive integer scale and one of the
eight output transforms for the next commit; transformed buffer dimensions
are exposed explicitly, and attachment rejects dimensions that the compositor
would reject for not being integer multiples of the active scale.
The version-six core surface preference events provide the inverse signal:
validated compositor-preferred integer scale and transform are retained per
application surface, while the cursor role's independent event stream cannot
overwrite them. Fractional-scale preference takes precedence for framebuffer
resize events when its optional object is active.
Short-lived core `wl_region` objects define opaque rectangles and default,
empty, or rectangular input policy. The surface copies each region before the
object is destroyed and the state is committed, so no extra long-lived native
object or per-frame allocation is retained.
The idle-inhibit manager similarly owns a replaceable per-surface inhibitor,
keeping application policy explicit without background services.
The optional tearing-control object keeps synchronized versus low-latency
asynchronous presentation as an explicit application hint. Its state is
committed with the surface, never treated as a guarantee, and is destroyed
before its reusable manager and the core surface.
The adjacent optional content-type object classifies none, photo, video, or
game content as another explicitly non-binding compositor optimization hint.
It shares the same double-buffered state and ordered object/manager teardown
model without coupling content policy to the rendering backend.
The stable presentation-time object is an opt-in measurement path. One-shot
feedback is requested only for sampled commits and records the compositor's
clock domain, presented or discarded outcome, split 64-bit timestamp/sequence,
refresh prediction, synchronized output, and reliability flags without adding
work to ordinary frame submissions.

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
- Portable texture pools reuse complete warmed native objects; Vulkan heap
  suballocation may remain a private backend optimization.
- Vulkan records into per-frame/per-thread pools and uses synchronization2.
- OpenGL uses direct-state access and measured state filtering.
- Pipeline/shader caches use full content and device/driver identities.
- Destruction may be deferred behind GPU completion but remains owned by the
  originating resource lifetime.
- Validation, metrics, and labels are selectable without changing API shape.

The render graph is optional. It can derive barriers, transient lifetimes, and
aliasing, but direct command encoders remain first-class for exact control.
Its typed texture materializer is also optional: it retains one homogeneous
texture-pool lease per planned slot, maps logical IDs through pass/generation
checks, and borrows imported textures from their caller. The planner remains
pure, while physical ownership remains affine and backend-neutral. Scheduled
pass entry now combines incoming hazards into one conservative backend memory
dependency before the pass's direct work. Resource-specific Vulkan layout
transitions remain owned by the direct texture/render operation. Barrier counts
and access unions are compiled once into bounded primitive arrays indexed by
scheduled pass position, avoiding a planner-barrier scan during repeated entry.
The optional affine command list preallocates primitive records for exact pass
markers, all-transient texture copies, and a narrow typed procedural offscreen
render. It affinely owns each recorded target/pipeline, binds imported texture
descriptors and graph-owned physical identities at seal, and replays without
descriptor construction or live-memory growth. OpenGL uses the existing direct
operations. An eligible Vulkan stream records graph memory dependencies, the
2D texture copy, and the render into one retained command buffer, then submits
once; direct APIs remain unchanged. Later slices must add compute, broader
render/copy forms, frames in flight, and GPU-completion-aware retention.

## Specification coverage

The common API aims at portable graphics and compute concepts, not a lossy union
of two APIs. Generated raw APIs target the complete pinned Khronos registries.
A coverage ledger classifies every core command and extension as common, raw,
intentionally unsupported, or platform-inapplicable, with evidence for supported
families.

The initial baselines are OpenGL 4.6 core/GLSL 4.60 and Vulkan 1.4. Registry
patch revisions are pinned by the generator manifest and updated deliberately.
