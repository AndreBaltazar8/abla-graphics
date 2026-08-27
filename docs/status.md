# Implementation status

Updated: 2026-08-27.

## Verified now

- Nix-built application linkage: the development shell adds concrete Vulkan,
  X11, EGL, OpenGL, and Mesa library directories to each executable's RUNPATH
  instead of relying on mkShell's transient synthetic directory. The
  `test-runtime-linkage` gate clears `LD_LIBRARY_PATH` and all project graphics
  discovery overrides, proves zero unresolved shared libraries, and directly
  runs one freshly built Abla executable through both headless backends. The
  last complete 54-root no-cache sample matrix audited every then-canonical
  executable and ran its full live suite after unsetting `LD_LIBRARY_PATH`.
  The matrix now has 71 roots. Samples 65 through 68 cover deferred rendering,
  compute-to-render handoff, typed blending, and typed stencil masking. Sample
  69 is the complete `mini-breakout` 2D game: its independently built stripped-
  environment binary passed OpenGL, validation-enabled Vulkan, and automatic
  selection for 1,001 frames with zero live-byte growth. Sample 70 proves exact
  asymmetric top-left viewport/scissor output through the same three modes.
  Sample 71 resolves both generated raw loader paths and proves 1,000 checked
  indirect OpenGL `void()` calls with zero live-byte growth in normal and
  optimized builds; both binaries also pass stripped-environment linkage.
  These newer roots are
  queued for the next periodic complete matrix.
- Generated raw command ABI foundation: all 2,892 OpenGL and 842 Vulkan
  commands have deterministic normalized call shapes. Separately generated
  compact name/shape modules prevent full coverage/type reports from entering
  raw application builds. Full type metadata preserves underlying native
  declarations so 32-bit and 64-bit bitmasks cannot be conflated.
  `RawOpenGlApi` resolves through `eglGetProcAddress`
  with process-symbol fallback, `RawVulkanApi` resolves instance/device
  commands through the Vulkan loaders, and exact-shape checking enables the
  first allocation-stable OpenGL indirect call families. Generated ABI tags
  classify 49 `void()`, 146 `void(i32)`, and 157 `void(i32,i32)` entries as
  callable—352 total—and mark the other 2,540 OpenGL entries unsupported.
  Vulkan now assigns exact call ABIs to all 842 pinned commands, including
  explicit `i16`, platform-handle, pointer-return, and full-width result lanes;
  runtime callability still requires a nonzero platform/extension resolver.
  Affine typed builders now own exact zeroed native storage for event, fence,
  device-queue, and command-buffer-begin structures and are exercised by the
  live raw path. Registry-driven schema emission remains the next builder step.
  The live raw sample
  observes and restores scissor and
  pack-alignment state through 1,000 calls per scalar family with zero growth
  in normal and optimized builds. Its Vulkan path records 1,000 device-mask
  commands plus 1,000 stencil-reference commands, pairs an empty dynamic
  rendering begin with a raw end, submits and waits for the command buffer,
  observes exact successful `vkDeviceWaitIdle` status, queries physical-device
  features, and completes an event create/status/destroy lifecycle with exact
  `VK_EVENT_SET` after a raw synchronization2 `vkCmdSetEvent2`. It also creates
  a signaled fence, resets it through the
  counted-pointer family, observes exact `VK_NOT_READY`, and destroys it. It
  enumerates the physical-device list and resolves
  the application's exact queue through `vkGetDeviceQueue2`. It resets the
  pool through raw `vkBeginCommandBuffer`, queries nonzero physical-device
  format properties through the enum/output family, enumerates the three
  swapchain images, advances a timeline semaphore from 7 to 9, retains zero
  growth, and records validated event and query-pool resets before passing
  through raw timeline wait, synchronization2 reset/set/timestamp, and
  queue-submit calls. It additionally records raw `vkCmdUpdateBuffer`, a
  transfer barrier,
  raw `vkCmdCopyBuffer`, and raw `vkCmdFillBuffer`; host readback observes the
  exact updated and filled 64-bit words. Raw compute bind/dispatch, vertex
  buffer binding, legacy and synchronization2 timestamps, command-pool reset,
  memory unmap, line width, fence wait, and exact red image clear/readback
  execute in the same proof. Both timestamp queries return
  nonzero ticks before resources are released. Both build modes pass
  validation.
  Remaining signatures
  are still open and are not claimed by address or metadata presence.
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
  eight idle zero-timeout polls reusing one native poll block and canonical
  immutable no-event value with zero runtime live-byte growth,
  ConfigureWindow/ConfigureNotify
  resize with authoritative owned dimensions, fixed-size and undecorated WM
  hints,
  fullscreen EWMH state, setup-derived screen pixel/physical dimensions with
  DPI/content scale, asynchronous UTF8_STRING/TARGETS clipboard ownership and
  transfer between two direct clients, explicit transparent-window rejection,
  WM_DELETE_WINDOW client-message round trip, DestroyWindow, and close, running
  against authenticated Xvfb without an Xlib/XCB/GLFW window-management layer.
- Wayland window foundation test: direct AF_UNIX connection through the configured
  runtime/display path, optional inherited `WAYLAND_SOCKET` parsing, native
  two-word header and aligned string/new-id encoding, bounded message decode,
  dense client object allocation, `wl_display.get_registry`, registry
  global/global-remove discovery, fatal display/delete-id handling,
  synchronization callbacks, and version-capped `wl_registry.bind`. Synthetic
  malformed length/string/state-array cases fail deterministically. One live
  headless Weston probe discovers `wl_compositor`, `wl_shm`, and
  `xdg_wm_base`, binds the compositor at version four, and completes a second
  roundtrip. A second direct client binds stable xdg-shell version one, creates
  affine `wl_surface`, `xdg_surface`, and `xdg_toplevel` objects, sends title
  and application ID, commits the initial bufferless surface, consumes the
  toplevel size/state sequence, acknowledges the surface configure serial, and
  tears down in protocol order. A third client marshals Linux x86-64
  `sendmsg`/`SCM_RIGHTS`, creates and maps an affine close-on-exec `memfd`,
  creates one `wl_shm_pool` and up to three offset XRGB8888 `wl_buffer`
  objects, fills checked pixels through reusable rectangle writes,
  attaches/damages/commits them, and waits for real frame callbacks. Frame
  submission is one allocation-free 64-byte native write and routine events
  decode in reusable scratch storage. A 66-frame gate rotates all three slots
  with zero managed-live-byte growth after warm-up. A test-only 1024x768
  Pixman Weston run captures the visibly rendered window to
  `build/tests/wayland_pixels.png`.
  Ping/pong, buffer release, surface enter/leave, and close-intent dispatch are
  strict; the whole path uses no libwayland, GLFW, or SDL.
- Direct Wayland input binds `wl_seat` version seven and follows pointer and
  keyboard capability hot-plug with fresh protocol objects and versioned
  releases. A Linux `recvmsg` ancillary queue correctly preserves a keymap FD
  that arrives on an earlier batched stream read; the XKB v1 map is privately
  mapped, validated, copied into Abla ownership, unmapped, and closed. The
  portable event queue covers focus, evdev-to-Abla physical keys, repeat and
  modifier state, fixed-point pointer motion, five Linux buttons, and both
  scroll axes. A bounded pure-Abla XKB parser resolves group-one keycodes and
  primary/shifted symbols, including ASCII, Latin-1, and direct Unicode, into
  fixed 256-key tables and applies live Shift/Caps state. A nested Weston/Xvfb
  gate receives a real 65,553-byte keymap, parses 230 keys, and receives focus,
  pointer motion, W press/release, and lowercase/shifted uppercase text; exact
  BTN_LEFT wire packets prove button press/release decoding. Client-side repeat
  uses the live compositor rate/delay (40 Hz after 400 ms in the gate), caps the
  socket-poll deadline with allocation-free monotonic timing, emits a typed
  repeat plus text, and cancels on release/focus/capability loss. There is no
  libxkbcommon dependency.
- Direct Wayland cursor ownership creates a 16x24 pure-Abla ARGB8888 arrow in
  an affine `memfd` mapping, validates the cursor SHM/surface event streams, and
  uses the pointer-enter serial for visible/null `set_cursor` requests. The
  nested input gate begins hidden before focus, restores the cursor on enter,
  checks opaque and transparent mapped pixels, and proves repeated hide/show
  requests remain healthy. No cursor-theme or libwayland dependency is used.
- Direct Wayland multi-touch creates/releases `wl_touch` with seat capability
  changes and retains a bounded active-contact set with exact fixed-point
  position, contact shape, and orientation. Begin/move/end values are withheld
  until the protocol frame boundary; shape-only frames remain observable, and
  cancellation emits one final portable value per active contact. The current
  nested Weston seat has no touch device, so exact synthetic v7 down, shape,
  orientation, motion, frame, up, and cancel packets prove the strict handler
  and copied event API without claiming physical touchscreen coverage.
- Direct Wayland capture binds the version-one pointer-constraints and
  relative-pointer globals, owns persistent lock/relative objects, tracks
  requested versus compositor-activated state, accumulates 24.8 motion into
  virtual pointer coordinates, and retains accelerated/unaccelerated deltas.
  Nested Weston accepts the real request but, as the protocol permits, its X11
  backend does not activate it in this fixture; exact synthetic locked and
  fractional relative-motion packets then prove the strict handler, position
  hint, release, and retired-ID path without claiming a real activation.
- Direct Wayland confinement reuses the constraints manager without owning a
  relative-pointer object, rejects simultaneous lock ownership before writing
  to the compositor, and independently tracks requested and activated state.
  The nested gate sends the real persistent whole-surface request; where the
  X11-backed compositor defers activation, an exact synthetic confined event
  proves dispatch before release. Both current and retired confinement events
  remain valid until the compositor returns the object ID.
- Direct Wayland output discovery binds all initial `wl_output` version two
  through four globals and tracks signed position, physical size, transform,
  current/preferred mode, millihertz refresh, integer scale, stable name, and
  description in immutable values marked coherent by `done`. Surface
  enter/leave selects the primary output and emits copied monitor-change
  values. The nested Weston gate validates the real `screen0` output at 800x600
  scale one and observes its enter event. Registry add/remove handling binds
  fresh output objects or retires the matching snapshot, active-surface entry,
  and primary selection; a live remove/re-add gate changes object identifier
  `10` to `12`, emits disconnected/reconnected monitor values, and rebuilds the
  1024x768 snapshot. Optional `zxdg_output_manager_v1` objects merge logical
  position/size and fallback identity into each immutable snapshot using the
  version-correct atomic `done`; the live logical region is 0,0/1024x768.
  Teardown destroys xdg objects before versioned core-output release.
- Optional `wp_fractional_scale_manager_v1` support owns one preference object
  per surface, validates its numerator over 120, computes half-away rounded
  framebuffer extents, and emits copied framebuffer-resize events. The current
  Weston gate verifies the capability-missing path leaves the direct connection
  healthy; deterministic tests cover 1.5x and half-pixel rounding.
- Optional `wp_viewporter` support owns one viewport per surface and stages an
  exact 24.8 fixed-point source crop, a positive logical destination, or their
  exact protocol resets for the next surface commit. Whole-pixel source setup
  is a convenience over the exact fixed path. The headless-Weston gate enables
  the advertised extension, presents a 640x400 physical buffer at an initial
  320x200 logical size, applies a half-pixel source crop while updating the
  destination through a 1024x768 configure, rejects malformed reset/value
  tuples, then unsets and commits both states. Physical shared-buffer
  allocation/replacement remains explicit.
- Core Wayland surface state stages validated integer buffer scale and all
  eight output transforms directly. Rotated logical dimensions swap axes,
  shared-buffer presentation rejects non-divisible scale inputs locally, and
  the live Weston gate accepts scale-two/90-degree commits followed by an exact
  normal/scale-one restoration before content presentation.
- The window path now caps `wl_compositor` at version six and strictly handles
  core preferred-buffer scale/transform events on application and cursor
  surfaces. Preferred integer scale uses the portable framebuffer-resize
  event when fractional scale is inactive. The live gate records real Weston
  delivery separately and injects exact valid packets only for preferences
  omitted by the compositor fixture.
- Direct core `wl_region` ownership applies validated opaque rectangles and
  rectangular, empty, or default input policy using the protocol's copy
  semantics, then immediately destroys each temporary region. The same live
  gate proves every transition and restores default hit testing before input
  fixtures run.
- Optional `zxdg_decoration_manager_v1` support owns one decoration object
  before content attachment, distinguishes preferred from effective mode, and
  waits for both decoration and xdg-surface configure boundaries. The current
  headless-Weston environment verifies the capability-missing path remains
  healthy; deterministic packets cover creation/server preference and an exact
  synthetic configure proves effective-mode dispatch. Idempotent/invalid mode
  handling and decoration-before-toplevel teardown are also covered.
- Optional `zwp_idle_inhibit_manager_v1` support creates and destroys one
  surface inhibitor idempotently while retaining its manager for reuse. The
  current headless-Weston environment verifies the capability-missing path
  remains healthy before buffer attachment; deterministic wire coverage proves
  the exact inhibitor/surface creation request.
- Optional `wp_tearing_control_manager_v1` support owns a per-surface policy
  object and commits explicit vsync/async hints without claiming that the
  compositor honors them. Creation, idempotent transitions, disable/reuse,
  teardown order, and exact wire packets are covered. The current Weston
  fixture advertises the manager and accepts real async, restored-vsync, and
  object-disable transitions while keeping the connection healthy.
- Optional `wp_content_type_manager_v1` support owns an independent surface
  classification and commits none/photo/video/game hints idempotently. Exact
  creation/game packets, invalid values, transitions, disable/reuse, and
  ordered teardown are covered; the live Weston gate distinguishes advertised
  capability from the clean default-only fallback.
- Stable `wp_presentation` v2 support owns the compositor clock and one
  outstanding feedback object, classifies presented versus discarded frames,
  and preserves exact split timestamp/sequence words, refresh prediction,
  synchronized output, and all four quality flags. Feedback is sampled
  explicitly before a commit, leaving ordinary allocation-stable frame
  submission unchanged. Deterministic request coverage and the live Weston
  gate verify the actual clock and one-shot completion path.
- Direct Wayland clipboard support binds `wl_data_device_manager` version three,
  records real input serials, owns bounded UTF-8/plain-text sources, tracks
  immutable compositor offers, and transfers at most 1 MiB through close-on-exec
  pipes passed by `SCM_RIGHTS`. A deterministic pipe gate and two independent
  clients under nested Weston verify the exact 26-byte Unicode selection.
  xdg-toplevel controls request fullscreen, maximize, minimize, fixed/resizable
  constraints, and local close; headless Weston verifies fullscreen configure,
  ack, dimensions, and return to windowed state.
- The published sibling `AndreBaltazar8/abla-doom` is a playable original
  all-Abla raycasting homage using this framework. Its current smoke gate
  renders and presents through both OpenGL and Vulkan, and its committed
  320x200 proof image is regenerated from the exact game window.
- Common headless test: with `DISPLAY` removed, explicit surfaceless EGL/OpenGL
  clears and reads a pbuffer while explicit Vulkan creates a logical device,
  submits a buffer fill, synchronizes, and reads the result back. Both paths
  require and verify the common compute/storage/texture/anisotropy feature set
  and real queried limits; both production paths require and provide compatible
  view-format reinterpretation. An unknown feature bit is rejected before
  application use.
- Vulkan test: loader version, instance, physical-adapter API version, queried
  2D texture/storage/compute limits and portable feature mask, graphics
  queue-family selection, logical device, host-visible coherent allocation,
  buffer binding, command pool/buffer, GPU fill, transfer-to-host barrier,
  queue submission/wait, mapping/readback, queried/enabled Vulkan 1.2 timeline
  semaphores with allocation-free counter/signal/wait operations, queried and
  enabled Vulkan 1.3 synchronization2, real `vkQueueSubmit2` transfer work,
  zero-allocation `vkCmdPipelineBarrier2` memory/image transitions,
  device-owned timeline completion without queue-wide idle, exact submission
  and barrier-path verification, and reverse-order affine cleanup.
- Vulkan X11 surface test: required instance extensions, `VkXlibSurfaceKHR`
  creation for the direct Abla window, per-adapter graphics/presentation queue
  checks, surface capabilities/formats, a swapchain-enabled logical device,
  swapchain creation/image enumeration, surfaced-device timeline and
  synchronization2/dynamic-rendering enablement, semaphore-synchronized
  acquisition, render-pass-free surfaced pipeline creation, repeated dynamic
  color/depth rendering with explicit image transitions, GPU clear, queue
  submission/presentation/wait, and
  affine reverse-order teardown.
- Common triangle render test/sample: one strict `$glsl` vertex/fragment
  package creates an affine OpenGL program/VAO or Abla-emitted Vulkan shader
  modules, pipeline layout, graphics pipeline, and swapchain image views.
  Vulkan dynamically records begin-rendering, viewport/scissor, bind,
  three-vertex draw, end-rendering, submit, and present into the existing
  fence-guarded application frame slots. Explicit OpenGL and Vulkan each draw
  four warmed frames with stable program/pipeline/framebuffer/command handles
  and zero runtime live-byte growth. Vulkan validation is silent.
- Common multi-attribute triangle: `VertexBufferLayout` validates an interleaved
  28-byte record containing reflected location-zero `vec2` position,
  location-one `vec4` tint, and location-two `uint` tag inputs. Reusable
  `BufferBytes.storeF32`/`storeU32` encode three colored vertices in Abla and
  upload them to the common affine buffer. The
  strict pure-Abla `$glsl` emitter passes the color through a location-zero
  varying while retaining the unused integer input in the exact SPIR-V entry
  interface. OpenGL configures floating attributes with `glVertexAttribPointer`
  and the integer attribute with `glVertexAttribIPointer`; Vulkan creates the
  matching `R32_UINT` binding/attribute pipeline state and records
  `vkCmdBindVertexBuffers`. Explicit OpenGL and Lavapipe Vulkan runs preserve
  buffer/pipeline/command handles and live bytes across four warmed draws; the
  Vulkan run is also clean with `VK_LAYER_KHRONOS_validation` forced on.
- Common indexed triangle: checked `BufferBytes.storeU32` creates a reusable
  three-element index buffer with common index/copy-destination usage. The same
  application call dispatches `glDrawElements` or Vulkan index binding plus
  `vkCmdDrawIndexed`; a count exceeding the buffer is rejected before either
  driver. Explicit software OpenGL and validation-enabled Lavapipe runs keep
  vertex/index/pipeline/command handles and live bytes stable across four draws.
- Common instanced submission: vertex and indexed presentation accept a checked
  positive instance count. The sample submits two instances through core
  OpenGL instanced drawing or Vulkan's native draw-indexed instance field;
  zero is rejected before dispatch. Four repeated software-backend frames
  preserve handles and live bytes, with Vulkan validation enabled.
- Common immutable raster state: pipeline creation validates point/line/
  triangle list-or-strip topology, no/front/back culling, front-face winding,
  independent color/alpha blend factors and operations, and channel write
  masks, top-left viewport/depth-range state, and top-left scissoring. The
  standard alpha preset remains available. OpenGL reapplies the
  complete state before every draw; Vulkan bakes matching input-assembly,
  rasterization, viewport, scissor, and color-blend structures. The retained state packs the blend
  recipe into one integer to stay beneath Abla's allocation-free aggregate ABI.
  `examples/color-blending` verifies exact permitted one-LSB backend results,
  validation silence, invalid-state rejection, and zero growth through 1,001
  renders. `examples/viewport-scissor` adds five exact asymmetric pixel probes,
  invalid extent rejection, validation silence, and zero growth through 1,001
  renders on OpenGL, Vulkan, and automatic selection.
- Render-pipeline resize recovery: an affine pipeline retains its immutable
  shader/layout/raster recipe. Vulkan resize events defer recreation until a
  render presentation can wait, destroy framebuffer/image-view/pipeline state,
  then drop and recreate presenter/swapchain state in dependency order before
  rebuilding the pipeline. Extent/format mismatch and classified suboptimal/
  out-of-date results share this path; a failed presentation is retried once.
  The common sample resizes 800x600 to 640x480 and presents again with matching
  swapchain/pipeline/framebuffer state under validation. OpenGL updates its
  viewport while retaining the original program and VAO.
- Common depth testing/writes: `DepthStencilState` validates enable/write and
  all eight portable compare operations. EGL requests a real 24-bit default
  depth buffer and OpenGL reapplies depth enable, mask, function, and clear.
  Vulkan creates a D32 image, device memory allocation, and depth view for each
  swapchain image, packs a two-attachment render pass/framebuffer, configures
  depth test/write/compare state, and records a depth clear in reusable frame
  scratch. Four instanced indexed frames preserve every depth handle and live
  byte; resize rebuilds the per-image set at 640x480. The complete path is clean
  under `VK_LAYER_KHRONOS_validation` after an explicit 36-byte
  `VkAttachmentDescription` array-stride regression check.
- Common stencil state: `depthStencilState(stencil = ...)` packs independent
  front/back compare, fail, depth-fail, and pass operations plus shared 8-bit
  read/write masks and reference into the fourth retained scalar. OpenGL uses
  the combined depth/stencil attachment and separate face state; Vulkan creates
  a combined-aspect view, persists stencil through compatible pass load/store,
  and writes both native face structures. `examples/stencil-masking` proves
  exact clear/replace/reject/accept behavior through 3,003 pass executions per
  run on OpenGL, Vulkan, and auto with validation silence and zero live growth.
- General bind groups: `GraphicsBindGroup` accepts up to 16 unique set-zero
  entries spanning sampled textures, storage textures, uniform buffers, and
  storage buffers with
  explicit vertex/fragment/compute visibility. Pipeline reflection matches the
  complete entry shape, including exact 2D, array, cube, or 3D sampled-texture
  dimension. Entries can select checked uniform/storage subranges. OpenGL uses
  target-inherent texture-unit binding and prepares sampler/UBO/SSBO slot,
  offset, and size arrays, keeps
  whole resources on `glBindBufferBase`, and uses `glBindBufferRange` only for
  real ranges. Vulkan owns per-texture views plus an aggregated descriptor
  pool, layout, and set with exact descriptor offsets/ranges. Both backends
  query and expose their uniform/storage offset alignment; misaligned and
  crossing ranges are rejected before driver work. Application tests create a
  three-entry group on both backends and reject duplicate bindings and usage
  mismatches before driver work. The strict
  textured triangle and texture-plus-uniform cube remain allocation-free and
  preserve descriptor handles through repeated frames and resize recovery.
- Indirect rendering: common vertex and `uint32` indexed paths accept
  GPU-readable indirect command buffers after ownership, usage, and minimum-size
  validation. OpenGL uses core indirect draws; Vulkan records the matching
  indirect commands. The common triangle warms both variants, rejects a buffer
  without indirect usage, then renders four indexed indirect frames and resize
  recovery with stable handles and zero live-byte growth on both backends.
- Indexed textured cube sample: one strict `vec3` position/`vec2` UV shader,
  24 interleaved face vertices, 36 reusable `uint32` indices, a four-quadrant
  atlas, a vertex-visible std140 64-byte MVP uniform suballocated from one
  device-local pool, and enabled less/depth-write state render unchanged
  through OpenGL and Vulkan. A prefix allocation forces a nonzero ranged bind
  at each backend's queried alignment (16 bytes on the tested OpenGL path and
  64 bytes on Vulkan). Four warmed frames stage asynchronous transform updates
  while preserving pool, transfer, binding, and pipeline handles with zero live
  growth; the Vulkan run is validation-clean.
- Whole-buffer update optimization: `GraphicsBuffer.writeAllBytes` dispatches
  directly to allocation-free OpenGL `glBufferSubData` or mapped Vulkan copy
  paths instead of constructing a default copy descriptor per update. The cube
  regression caught and removed a repeatable 128-byte-per-frame live delta.
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
  sampler anisotropy and view-format reinterpretation,
  then verifies the reported API version and driver limits. It rejects a
  storage buffer one byte above the reported range and a 2D texture one texel
  above the reported dimension before allocation;
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
- Reusable common clear test/sample: surfaced OpenGL stores float color ABI data
  in a context-owned 16-byte block; Vulkan records clear/layout commands in the
  same configured fence-guarded slots used for pixel presentation instead of
  constructing pools and semaphores per call. Four explicit OpenGL and Vulkan
  clears preserve command/context handles and produce zero runtime live-byte
  growth.
- Reusable RGBA8 pixel test: bounds-checked pixel/rectangle writes use affine
  native storage; surfaced OpenGL uploads it through one persistent
  nearest-filtered texture/shader program, while Vulkan uses a configured
  three-slot set of coherent staging buffers, swapchain-format channel adaptation,
  image layout barriers, buffer-to-image copy, synchronized presentation,
  per-slot command pools/pointer cells/160-byte ABI scratch blocks/acquire
  semaphores/fences, and render-finished semaphores owned per swapchain image.
  Packed scalar outcomes avoid frame-local heap result objects. Four consecutive
  uploads exercise all three slots and fence-guarded reuse without a per-frame
  queue-wide idle, preserve every OpenGL/Vulkan native handle, and produce zero
  runtime live-byte growth. The public one-to-eight-slot setting survives both
  clear and pixel swapchain recovery; its default remains two.
- Portable descriptor test: immutable buffer, texture, texture-view, and sampler
  descriptors validate usage flags, mapping constraints, dimensions, mip and
  multisample rules, format/view compatibility, subresource ranges, aspects,
  filters, comparison, LOD, and anisotropy with field-specific diagnostics.
- Wider portable texture contract: 2D-array, cube, and 3D descriptors distinguish
  constant array layers from shrinking physical depth, cube faces from general
  arrays, and inherited versus explicit view dimensions. `TextureRegion`
  validates mip/layer/depth selections and compressed edge blocks;
  `TextureDataLayout` resolves tight or explicit row/image pitches and computes
  an overflow-checked byte footprint. BC1 RGBA UNORM/sRGB supplies the first
  4x4/eight-byte compressed block family and compatible view pair. A dedicated
  pure-Abla gate covers valid array/cube/volume shapes, invalid view and crossing
  ranges, exact tight/pitched footprints, short storage, block misalignment,
  forbidden compressed attachment usage, and 64-bit footprint overflow.
  OpenGL and Vulkan report live 1D/2D/3D/cube and array-layer limits and create
  matching native wider images and views, including BC1 storage.
- Common affine buffer test: one `BufferDescriptor` creates an OpenGL buffer or
  Vulkan buffer/allocation after one-time backend selection; both paths pass
  checked nonzero-offset 64-bit write/read plus a 19-byte upload/readback between
  different CPU/GPU offsets. Pure tests cover default remaining-source size,
  zero size, and crossing source/destination bounds; application tests reject
  missing copy usage and an overflowing range. OpenGL uses direct buffer-subdata
  calls. Vulkan maps coherent memory from aligned offset zero and uses one
  buffer-owned output cell plus the Abla compiler's LLVM copy intrinsic, so
  repeated range transfers allocate no general memory. Map-write/copy-source
  descriptors may now start mapped; checked partial writes target that live
  range, normal CPU and GPU operations reject it until explicit one-shot
  `unmap()`, and affine destruction unmaps any still-active range. Both drivers
  then support checked post-creation map-write and map-read subranges. OpenGL
  maps the requested native range; Vulkan maps coherent memory from offset zero
  while Abla enforces the identical logical range. Four repeated
  map-write/write/unmap/GPU-copy/map-read/read/unmap cycles on each backend
  preserve both native buffer handles and produce zero Abla runtime live-byte
  growth. Invalid mapped usage, access mode, logical range, nested map,
  repeated unmap, mapped GPU use, and deterministic destruction also pass.
  A separate capability-gated persistent mapping mode keeps either a coherent
  map-write/copy-source upload or map-read/copy-destination readback buffer
  mapped through synchronous GPU copies.
  OpenGL 4.4+ uses immutable `glBufferStorage`, persistent/coherent map flags,
  a client-mapped barrier, and a targeted fence/client wait; Vulkan uses
  coherent host memory and waits for transfer submission. Four repeated
  write/copy/readback cycles preserve all handles and live bytes. Because copy
  completion is genuinely synchronous, each range is safe to overwrite after
  return; asynchronous ring ownership is not claimed.
  `GraphicsBufferUploadRing` and `GraphicsBufferReadbackRing` own one mapping in
  each direction and provide aligned, bounded, wrap-counted staging through
  descriptor and primitive-range APIs. Five live sample operations per ring
  force two wraps; four application-gate operations force one wrap. Both
  backends preserve both staging handles, reject invalid ranges without
  advancing state, read back exact bytes, and add zero live bytes in the
  measured loops.
- Common GPU buffer-copy test: `GraphicsApplication.copyBuffer` validates
  distinct same-backend resources, source/destination copy usages, and both
  ranges before dispatch. A partial 31-byte copy between different offsets is
  read back exactly on OpenGL and Vulkan; crossing bounds and missing usages are
  rejected. OpenGL uses `glCopyBufferSubData` and waits on an explicit
  copy-local sync object instead of calling `glFinish`. Vulkan reuses one
  device-owned transfer pool, command buffer, and scratch ABI block, records
  `vkCmdCopyBuffer` plus a transfer-to-host barrier, and preserves native handles
  across repeated copies. Khronos validation is silent on the Lavapipe path.
- Common GPU buffer-fill test: `GraphicsApplication.fillBuffer` validates
  application ownership, copy-destination usage, unsigned 32-bit pattern,
  four-byte alignment, and an overflow-safe destination range. A 20-byte fill
  beginning at byte 12 preserves both neighboring bytes and repeats the exact
  little-endian pattern on OpenGL and Vulkan; missing usage and unaligned ranges
  are rejected. OpenGL uses `glClearBufferSubData` with buffer-owned scratch.
  Vulkan reuses the device transfer command to record `vkCmdFillBuffer` plus a
  transfer-to-host barrier. Repeated fills show zero live-byte growth and silent
  Khronos validation on Lavapipe.
- Common buffer sample: one independently buildable Abla source creates and
  verifies the same partial reusable-byte upload/readback on a 256-byte storage
  buffer plus mapped-at-creation upload/unmap, post-creation write/read maps,
  coherent persistent transfers, 32-byte aligned upload and readback rings each
  forced through two wraps, and GPU copy/fill/readback under explicit OpenGL and
  Vulkan in the software-driver sample matrix. Four complete mapped transfer
  cycles preserve all mapped buffer handles and produce zero Abla runtime
  live-byte growth on both backends.
- Common asynchronous buffer transfers: a direction-specific affine queue owns
  one coherent persistent staging allocation split into one to eight fixed
  aligned slots. Compact integer tickets carry slot generations without heap
  allocation. OpenGL owns a `GLsync` per slot and polls it with zero-timeout
  `glClientWaitSync`; Vulkan owns a reusable command pool, command buffer,
  fence, and ABI scratch block per slot and polls with `vkGetFenceStatus`.
  Targeted waits use only the selected sync/fence, never `glFinish`,
  `vkQueueWaitIdle`, or `vkDeviceWaitIdle`. The separate live transfer gate and
  `examples/async-buffer` submit three uploads and three readbacks before
  waiting, recover exact bytes on explicit OpenGL and Vulkan, reject stale and
  invalid tickets, preserve native handles, and report zero live-byte growth in
  repeated operations. Auto selection is covered by the focused gate.
- Common asynchronous texture transfers: a direction-specific affine queue
  reuses the same bounded slot/generation/ticket model with persistent mapped
  staging. RGBA8/BGRA8 `PixelBuffer` convenience remains available, while raw
  `BufferBytes` calls cover pitched 1D, 2D, array, cube, physical 3D, and BC1
  selections. Slots contain tight active bytes; enqueue gathers pitched uploads
  and readback resolution scatters active rows without touching caller padding.
  Descriptor convenience calls cover selection/layout setup while primitive
  `...BytesRange` calls keep streaming loops allocation-free.
  OpenGL submits pixel unpack/pack buffer operations and one `GLsync` per slot;
  Vulkan records buffer/image copies, per-mip/per-array-layer layout transitions,
  a readback host barrier, and one fence-backed command buffer per slot. The
  RGBA gate submits two operations before waiting. The wider gate submits four
  array/cube/volume/BC1 uploads and readbacks before waiting and proves exact
  pitched results, padding preservation, capacity/layout rejection,
  stale-ticket rejection, stable handles, and zero repeated live-byte growth
  on explicit OpenGL, explicit Vulkan, and auto selection.
  `examples/async-texture` and `examples/async-wider-texture` independently
  demonstrate both public forms on the production backends.
- Explicit buffer memory placement: `BufferDescriptor.memory` accepts automatic,
  host-visible, or device-local policy. Device-local descriptors reject CPU
  mapping and direct byte access. Vulkan selects a compatible memory type with
  the device-local bit and prefers non-host-visible memory; OpenGL enforces the
  portable access boundary while leaving residency to its driver. The live
  transfer gate stages three uploads and readbacks through a device-local
  destination on explicit OpenGL, explicit Vulkan, and auto selection, rejects
  direct CPU access, recovers exact bytes, and retains zero live-byte growth.
- Device-local buffer suballocation: `GraphicsBufferPool` owns one real
  device-local buffer plus fixed allocator metadata. Descriptors bound capacity
  to one GiB, require power-of-two blocks and both GPU copy directions, and
  support at most 65,536 blocks and 1,024 live allocations. Compact
  slot/generation tokens reject stale reuse; aligned first-fit allocation,
  release, validation, and counter updates allocate no general memory. The
  focused pool gate proves exact aligned offsets, fragmentation rejection,
  same-slot generation reuse, stale-token and crossing-range rejection,
  explicitly device-local CPU-access rejection, exact asynchronous slice
  upload/readback, stable backing handles, and zero live-byte change across
  1,000 allocate/release cycles on OpenGL, Vulkan, and auto selection. The
  independently buildable `examples/buffer-pool` repeats the public workflow
  on both explicit backends. Uniform/storage range binding is verified by the
  focused gate and indexed cube. The surfaced and offscreen target/pass
  direct/indexed and vertex-/indexed-indirect APIs accept checked byte ranges,
  with generation-checked pool helpers for their ordinary and push-value forms.
  The focused gate populates nonzero offsets 16/48/64/80 in one device-local
  backing buffer, executes all eight surfaced plus all sixteen target/pass
  helpers on OpenGL, Vulkan, and auto selection, verifies an exact red target
  pixel, rejects misaligned/short/stale ranges, preserves native handles, and
  reports zero live-byte growth. `render-to-texture` repeats the four ordinary
  pass forms from the pooled backing; `push-color` repeats all pooled push
  target/pass/present forms. Indexed-indirect `firstIndex` is absolute to the
  complete index backing buffer on both backends, matching OpenGL's native
  command semantics; Vulkan binds byte zero for this form.
- Portable texture-object reuse: `GraphicsTexturePool` eagerly owns one to 64
  homogeneous real textures and lends compact slot/generation leases while
  retaining affine ownership. OpenGL reuses complete immutable texture
  objects; Vulkan reuses complete images, dedicated bound memory, transfer
  state, and layout tracking. Capacity exhaustion, stale access, and double
  release fail without driver work. The focused gate proves deterministic
  first-free reuse, exact synchronous and asynchronous byte upload/readback, a
  sampled offscreen pixel, stable native handles, and zero live-byte change
  across 1,000 warmed acquire/release cycles on OpenGL, Vulkan, and auto
  selection. `examples/texture-pool` repeats the public sampled workflow on
  both explicit backends. Backend-private Vulkan heap suballocation remains
  open and is not claimed by this contract.
- Typed render-graph texture materialization:
  `GraphicsMaterializedRenderGraph` preserves the deterministic pure planner
  and adds complete texture declarations, exact storage-size/descriptor
  checks, one retained pool lease per physical slot, caller-owned imported
  resources, scheduled pass/generation guards, and checked upload, readback,
  copy, and sampled-binding operations by logical ID. The focused gate proves
  exact alias/non-alias identities and transfers, rejection paths, one retained
  native object and pool acquisition per slot, stable handles, and zero
  live-byte growth through 1,000 executions on OpenGL, Vulkan, and auto
  selection. The independent
  `examples/materialized-render-graph` performs four live sampled frames on
  both explicit backends.
- Ordered render-graph barrier execution: pass entry validates exact plan order
  and generation, combines every incoming logical dependency, and emits one
  conservative OpenGL memory barrier or Vulkan memory barrier batch before
  direct pass work. Vulkan uses the retained transfer command state,
  synchronization2 when available, and the legacy pipeline-barrier fallback.
  The focused four-pass gate performs transient upload, a real sampled draw
  into an imported offscreen target, a post-pass copy into another transient,
  and exact 16x16 readback. OpenGL, Vulkan, and auto selection each report the
  exact pixel `4281541137`, 3,003 logical/backend barriers over 1,001
  executions, stable handles, one pool acquisition per transient, and zero
  live-byte growth. A second live graph reports two incoming logical barriers
  and one backend call, proving per-destination batching on OpenGL, Vulkan, and
  auto selection. Materialization compiles exact per-pass barrier counts and
  access unions into bounded primitive arrays, and warmed entry indexes that
  schedule without rescanning planner barriers. `examples/graph-post-process`
  repeats the public workflow on both explicit backends.
- Bounded render-graph command recording: an affine fixed-capacity list records
  exact ordered pass markers, same-format transient texture-copy ranges, a
  typed procedural, direct/indexed, and vertex-/indexed-indirect offscreen
  renders with snapshotted reflected push values, and
  planner-visible imported or graph-owned multi-buffer compute dispatches into
  preallocated storage. It affinely owns render resources and imported
  render/compute buffers, pipelines, and bind groups while borrowing transient
  buffers from the graph, and seals
  with full access/descriptor/range
  validation, binds imported descriptor fingerprints plus graph-owned physical
  identities, and rejects incompatible graphs/resources or post-seal mutation
  before opening an execution. Eligible Vulkan streams record their barriers,
  dimension-aware copy, render, and compute work into a bounded
  `framesInFlight` command ring and submit once per replay without waiting after
  queue acceptance. Per-slot timeline values gate reuse; callers explicitly
  retire pending values under the graph-outlives-list-and-work contract. OpenGL
  uses ordered direct operations. The
  combined six-command
  OpenGL/Vulkan/auto gate proves center pixel `4294281759`, copied RGBA
  `4280427042`, 1,001 successful list executions, 1,003 completed graph
  executions, 4,012 logical barriers, 3,009 batched backend barrier calls,
  exactly 1,001 Vulkan submissions or zero on OpenGL, stable graph/render native
  handles, one pool acquisition per transient physical texture, and zero
  live-byte growth. Vulkan validation is silent. `examples/recorded-graph-copy`,
  `examples/recorded-graph-render`, `examples/recorded-graph-compute`, and
  `examples/recorded-graph-transient-compute`, and
  `examples/recorded-graph-buffered-render`, and
  `examples/recorded-graph-indirect-render`, and
  `examples/recorded-graph-push-render`, and
  `examples/recorded-graph-depth-render` repeat the public paths on both
  backends. `examples/recorded-graph-resolve-render` adds planner-visible 4x
  multisample source and single-sample resolve identities, exact output,
  sealed-ID tamper rejection, and zero-growth replay on both backends.
  `examples/recorded-graph-mrt-render` extends this to a buffered vertex draw
  over two 4x colors, two resolves, and depth with exact red/green output and
  ordered planner IDs. The matching focused push proof uses indexed-indirect.
  `examples/recorded-graph-subpasses` owns a compatible render pass, target,
  and ordered two-stage procedural sequence in one graph record. OpenGL replays
  both stages directly; Vulkan records both native subpasses inside the graph's
  retained command buffer. Its reflected form snapshots one bounded aggregate
  and selects each stage's stored range during replay. Its 1,001 exact replays
  have zero live growth and zero/1,001 OpenGL/Vulkan submissions, and the
  focused gates reject sealed depth-ID, cached Vulkan sequence-handle, and push
  metadata mutation while preserving source-mutation-independent output.
  `examples/recorded-graph-binding-subpasses` adds two planner-declared std140
  transform buffers and maps each retained subpass bind group to its exact
  affine buffer. The focused gate rejects a sealed stage-map mutation and both
  backends preserve exact output, zero live growth, and zero/1,001 submissions.
  `examples/recorded-graph-texture-subpasses` extends the same affine table to
  imported sampled textures and samplers. Two stages select different exact
  resources; the gate rejects sealed map mutation and preserves exact output,
  zero growth, and zero/1,001 submissions on OpenGL/Vulkan/auto.
  The same focused gate also owns imported parent textures plus affine native
  views and samplers, rejects encoded view-map mutation, and retains the same
  exact output and replay evidence on all three backend selections.
  `examples/recorded-graph-transient-texture-subpasses` binds a prebuilt
  descriptor to the graph's retained one-slot texture lease. Initialization and
  1,001 replays preserve one physical identity, one pool acquisition, exact
  output, zero growth, and zero/1,001 submissions.
  The first compute proof declares an imported
  logical buffer, copies a reflected add-one push value into bounded command
  storage, mutates the source after sealing, and reaches exact storage value
  `1001` through 1,001 replays. Its read/write-to-read planner hazard produces
  exact barrier counts `1/1001/1001`; transient and size-mismatched buffer
  declarations, wrong native binding, and post-seal handle mutation reject.
  Oversized post-seal push-size mutation is bounded and rejects before
  fingerprinting.
  Every procedural, direct, indexed, and indirect depth record binds a second
  planner-visible imported attachment, requires exact color/depth descriptors
  and pass writes, and requires enabled depth state. The direct plus
  indexed-indirect-push boundary gate rejects sealed depth-ID mutation and
  retains exact snapshotted output through 1,001 zero-growth replays.
  Owned buffer/pipeline handles stay stable with zero growth and zero/1,001
  OpenGL/Vulkan submissions. The multi-binding proofs reach exact `5007/5`
  destination/source values for imported buffers and exact `5007` for
  graph-owned transient buffers. Three logical transients map to slots `0/1/0`
  and two retained physical pools, with one allocation each, stable alias
  identities, one barrier per replay, one consolidated Vulkan submission, and
  zero growth. Sealed logical/bind-group identity and transient backing-usage
  tampering reject before execution. Planner-visible uniform/storage buffers
  and full sampled textures/samplers are delivered for subpass bind groups;
  compute sampled/image bindings are also delivered. Broader command forms
  remain open.
- Common affine sampler test: one immutable descriptor creates and destroys an
  OpenGL sampler object or Vulkan `VkSampler` with repeat/mirror addressing,
  linear min/mag/mipmap filtering, LOD range, comparison state, and 16x
  anisotropy. OpenGL queries the ARB/EXT extension and maximum before using the
  float-vector parameter ABI. Vulkan queries the physical-device feature and
  float limit, zero-initializes the entire enabled-feature structure, enables
  only the advertised sampler bit, and records the anisotropic sampler state.
  Pure capability tests reject a request above the reported limit and a request
  on a device without the feature.
- Common affine texture/view tests: descriptors create complete 1D, 2D,
  2D-array, cube, and 3D color mip chains plus 2D depth images as immutable
  OpenGL texture storage or bound Vulkan images. OpenGL selects the exact target;
  Vulkan selects the exact image type, physical depth or array layers, and cube
  compatibility. BC1 UNORM/sRGB allocation is live on both. Omitted view counts
  resolve to all remaining subresources; full OpenGL views alias their texture,
  while partial layer/mip and compatible-format views own independent
  `glTextureView` names. Vulkan creates and destroys `VkImageView` objects.
  Both mutable Vulkan images and immutable OpenGL storage verify compatible
  linear-to-sRGB views. The focused wider-resource gate runs 1D, array, cube,
  volume, BC1, alias, owned-view, and parent-survival checks on explicit OpenGL,
  explicit Vulkan, and automatic selection. Both paths verify
  color/depth aspects, invalid-range diagnostics, rejection of multisampled
  sampled/copy usage, and reverse-order affine cleanup. A partial 2x2 RGBA upload into
  mip two is read back exactly, updated a second time to prove Vulkan's
  per-mip old-layout tracking, and rejected when its region crosses the mip
  boundary. A separate BGRA texture round-trips the original logical RGBA value
  on both drivers. Vulkan reuses a texture-owned coherent staging buffer,
  command pool, command pointer cell, and scratch ABI block for explicit
  buffer/image copies and layout transitions; OpenGL uses `glTexSubImage2D` and
  exact `glGetTextureSubImage` readback into texture-owned scratch. Direct
  transfer validation plus four repeated upload/readback cycles preserve native
  handles and show zero live-byte growth on both backends. The independently
  buildable common-texture sample runs this slice under explicit OpenGL and
  Vulkan.
- Common wider texture byte transfer: `GraphicsTexture.writeBytes` and
  `readBytes` accept a checked `TextureRegion`, `TextureDataLayout`, and reusable
  `BufferBytes`; primitive range forms avoid immutable descriptor copies in hot
  loops. Exact live round trips cover uncompressed 1D, pitched R8 2D, RGBA
  arrays, cube faces, physical 3D volumes, BC1 2D, and two-layer BC1 arrays.
  Readback preserves caller offset/row/image padding. OpenGL scopes and restores
  pack/unpack alignment, row length, image height, and compressed block state
  around DSA subimage/readback calls. Vulkan repacks into one tight coherent
  texture-owned staging allocation, tracks layout by mip and array layer,
  distinguishes array layers from physical 3D z/depth, and inserts host-read
  visibility. `copyTextureRange` performs checked same-format subresource copies
  across array layers or physical volume slices. Short/crossing ranges reject;
  four repeated upload/readback/copy cycles keep image, staging, command-pool,
  and command-buffer handles stable with zero live-byte growth on explicit
  OpenGL, explicit Vulkan, and automatic selection. The independently buildable
  wider-texture sample repeats the exact pitched array path on both backends.
- Common wider texture sampling: reflected `sampler2DArray`, `samplerCube`, and
  `sampler3D` bindings require matching texture dimensions before driver work.
  The strict pure-Abla SPIR-V path emits the corresponding image dimension,
  arrayed flag, and vec3 coordinate type; OpenGL uses the same GLSL source with
  target-inherent direct-state-access texture-unit binding. The independently
  buildable wider-sampling sample uploads distinct array layers, cube faces,
  and volume slices, then verifies exact selected pixels on explicit OpenGL,
  explicit Vulkan, and automatic selection. A deliberate array/cube mismatch
  rejects, while four repeated frames retain pipeline, descriptor, view, and
  resource handles with zero live-byte growth. `sampledTextureViewEntry` and
  its concise bind-group helpers also borrow explicit validated views. The live
  gate samples a narrowed array layer, cube face, and volume view exactly;
  OpenGL binds each view name directly and Vulkan consumes the caller-owned
  `VkImageView` without creating or destroying a hidden replacement.
- Common GPU texture-copy test: `GraphicsApplication.copyTexture` validates
  distinct application-owned color textures, exact format, copy usages, source
  and destination mip levels/origins, and a shared 2D extent. A 2x2 region moves
  between different mip levels and origins and reads back both corner pixels
  exactly on OpenGL and Vulkan; same-resource and crossing-range copies are
  rejected. OpenGL uses `glCopyImageSubData`. Vulkan uses `vkCmdCopyImage`,
  explicit source/destination layout barriers, initialized native per-mip layout
  tracking, and the reusable device transfer pool, command buffer, and scratch
  block. Repeated copies preserve the transfer handles and live-memory level;
  Khronos validation is silent on Lavapipe.
- Common mipmap generation: `GraphicsTexture.generateMipmaps` validates a
  single-sample 2D RGBA8/BGRA8 chain with copy-source/copy-destination usage.
  OpenGL uses `glGenerateTextureMipmap`; Vulkan records adjacent-level linear
  `vkCmdBlitImage` operations with explicit per-mip barriers in the texture-
  owned reusable command buffer. Exact first/final-level readback and four
  repeats preserve all native handles with zero live-memory growth on both
  drivers; depth and single-level textures are rejected.
- Common color render targets: `app.renderTarget(move(texture))` takes affine
  ownership of a 2D color texture with render-attachment usage.
  OpenGL owns and completeness-checks an FBO; Vulkan owns a compatible image
  view, render pass, and framebuffer. A real target clear round-trips the exact
  RGBA8 result on both drivers. Four repeated clears preserve every target and
  transfer-command handle with zero live-byte growth under Vulkan validation.
  Compatible procedural and vertex-buffer pipelines then render without taking
  ownership of the attachments. Direct/indexed, instanced, bind-group, and
  GPU-indirect commands share the surface-rendering validation and encoding
  model.
- Owned target depth: `app.renderTargetWithDepth(move(color), move(depth))`
  validates same-size, matching-sample color/depth attachments and owns both
  textures. OpenGL attaches and clears the depth texture in the FBO. Vulkan
  owns the compatible depth view and two-attachment render pass/framebuffer,
  records depth clears, and tracks the depth-optimal layout. Depth-enabled
  target pipelines borrow those attachments; mismatched depth state is
  rejected.
- Multisampled target foundation: render-attachment-only 2x/4x/8x/16x color
  and depth textures allocate `GL_TEXTURE_2D_MULTISAMPLE` objects or Vulkan
  images with matching attachment and pipeline sample state. A real 4x
  color/depth target renders and automatically resolves into a target-owned
  single-sample texture with exact readback, stable native handles, and zero
  live-memory growth on explicit/automatic OpenGL and Vulkan. OpenGL reuses a
  target-owned resolve FBO; Vulkan encodes owned resolve views in the framebuffer
  and native subpass resolve-reference arrays for default and specialized
  render passes. Explicit Vulkan resolves reuse device transfer state and image
  barriers. `resolveRenderTargetColor` selects and verifies individual
  MRT colors. Target constructors optionally own exactly one resolve texture
  per color and automatically update them after every clear or draw, including
  all MRT command forms. Multisampled sampled usage is rejected.
- Multiple color attachments: `renderTargetWithColors` and
  `renderTargetWithColorsAndDepth` take affine ownership of two to eight
  same-size render textures, optionally plus depth, while preserving attachment
  zero as the compatibility-facing `target.texture`. Reflected fragment outputs
  must be contiguous and exactly match the target count. OpenGL configures FBO
  draw buffers; Vulkan generates the complete attachment/reference/view/
  framebuffer and blend-state arrays.
- Reusable attachment-operation passes: `RenderPassClearValues` owns a stable
  native block containing one color per attachment plus depth/stencil, while
  `RenderPassOperations` selects clear/load/discard and store/discard per color
  and depth attachment. `GraphicsRenderPass` validates and binds both to a
  target once. Vulkan owns a compatible specialized render pass; OpenGL maps
  the operations to selective clears and framebuffer invalidation. The MRT
  sample proves attachment-zero load preservation (blue), an independent
  attachment-one clear (cyan), exact red/green shader output, and discard
  execution with a depth attachment. Four repeated three-pass sequences
  preserve handles with zero live-memory growth on both backends.
- Ordered procedural subpasses: one affine pass owns two through eight native
  Vulkan subpass descriptions and explicit by-region color-output dependencies;
  `renderPassPipeline` binds a pipeline to each index and
  `GraphicsSubpassPipelineSequence` precomputes the handles and descriptor sets
  used by one allocation-free `vkCmdNextSubpass` command sequence. OpenGL maps
  the same portable contract to ordered FBO draws with boundary-only attachment
  operations. Integration and sample tests make the first stage fail depth,
  prove the second stage's exact pixel output, repeat five times with stable
  handles and zero live-memory growth, and pass with Vulkan validation enabled.
- Render-to-texture/post-process sample: a 256x256 target receives a procedural
  and buffered scene pass, becomes a sampled-texture bind-group entry, and is
  drawn through a fullscreen surface pass unchanged on OpenGL and Vulkan. The
  reusable target-bound pass covers direct, indexed, and both indirect commands
  with depth testing and writes. Exact center-pixel readback verifies the
  result; four repeated command sequences preserve target, pipeline,
  descriptor, pass-clear storage, and transfer-command handles with zero live
  growth.
- Abla `$glsl` subparser test: runtime and frozen `#$glsl` packages, raster and
  compute stage blocks, balanced nested scopes, comment preservation, typed
  stage lookup, quoted/system include preservation and dependency reflection,
  explicit input/output location reflection, descriptor set and
  binding reflection including declaration types/names, ranged location
  overlap rejection, compatible descriptor aliases, cross-stage binding
  compatibility, adjacent raster-stage
  missing/type-mismatched interface rejection, fixed/unsized declaration array
  extents, ordered interface-block members including comma-separated member
  declarators and their rejection cases, checked push-constant blocks,
  typed scalar specialization constants, checked compute workgroup
  sizes/defaults and specialized dimension IDs, and compile-time rejection of
  invalid stage names. The surfaced triangle is compiled from this package
  rather than opaque strings.
- Pure-Abla SPIR-V/Vulkan shader-module test: immutable copied words validate
  the SPIR-V 1.0-1.6 header, unsigned word domain, and every instruction
  boundary before little-endian packing. A minimal valid compute module creates
  and affinely destroys a real `VkShaderModule`; the strict fixed triangle
  subset additionally emits deterministic vertex and fragment modules and
  creates both on Lavapipe. A zero-word-count instruction is rejected before
  reaching the driver.
- Portable specialization test: typed values validate against reflected IDs and
  scalar types, duplicate/unknown/type-mismatched values fail before driver
  creation, and zero/oversized workgroup overrides fail the effective device
  limits. A specialized no-op compute package emits deterministic SPIR-V 1.0
  `WorkgroupSize` for OpenGL and SPIR-V 1.2 `LocalSizeId` for Vulkan, then
  creates and dispatches successfully on both installed drivers. Vulkan packs
  `VkSpecializationInfo` and OpenGL calls `glShaderBinary` plus
  `glSpecializeShader`, all from Abla-owned storage. Fixed-workgroup no-op
  shaders additionally emit reflected scalar `bool`, `int`, `uint`, `float`,
  and `double` specialization constants with deterministic default bits. The
  32-bit subset creates and dispatches on both installed drivers; Vulkan's ABI
  packer also carries 64-bit double overrides, which OpenGL rejects explicitly.
  Scalar and workgroup specialization coexistence is word-repeatable and also
  creates and dispatches on both drivers. A reflected signed or unsigned integer
  constant can additionally feed a precedence-parsed executable storage
  expression with repeated member loads, typed literals, nested parentheses,
  arithmetic, shifts, relational/equality comparisons, bitwise AND/XOR/OR,
  Boolean AND/XOR/OR, unary plus, signed negation, integer complement, Boolean
  negation, and right-associative integer ternary selection. Tests prove the
  GLSL precedence order,
  signed-arithmetic versus unsigned-logical right shift, direct negative-literal
  constants, unary arity, and side-effecting increment/decrement expression
  rejection. The bounded
  postfix form emits deterministic typed SSA operations plus `OpSelect`; a live
  override in an arithmetic/comparison/logical/select chain produces checked
  buffer output on OpenGL and Vulkan rather than merely proving pipeline
  creation. Integer conditions, Boolean branches, raw Boolean assignment, and
  mismatched logical operands are checked failures.
  Scalar integer `min`, `max`, and `clamp` calls parse as nested primaries. The
  emitter imports `GLSL.std.450` exactly once and emits the Khronos-defined
  unsigned instructions 38/41/44 or signed instructions 39/42/45. Signed and
  unsigned tests validate every instruction, deterministic repeat emission,
  arity rejection, and Boolean-operand rejection. The live shader exercises all
  three calls unchanged through real OpenGL and Vulkan dispatch.
  Literal `true`/`false` and a single reflected Boolean specialization constant
  are first-class condition values. Deterministic modules use typed Boolean
  constant/spec-constant instructions; a default-false specialization overridden
  to true selects the checked result `7` after real OpenGL and Vulkan dispatch.
  Boolean arithmetic remains a checked type failure.
  All ten integer compound-assignment operators lower through the same typed
  token program. Tests prove `value += 2u` is byte-identical to its expanded
  form and cover shift/bitwise compound opcodes. Standalone prefix and postfix
  `++`/`--` statements on block members lower to the same add/subtract-by-one
  chain and are byte-identical to each other and their expanded forms; logical
  assignment remains rejected.
  A storage `main` now accepts a bounded sequence of up to 64 member assignments.
  Store tokens consume each typed postfix result before the next statement,
  retaining byte-identical output for every previous one-statement module. A
  three-statement unit shader emits three ordered stores. The live shader
  performs ordered loop/member updates, reads the result in the following
  conditional, writes `output = 7`, and returns the exact packed high/low pair
  on both real drivers while preserving the separate initialized prefix.
  Compute `main` also accepts declaration-before-use `int`, `uint`, and `bool`
  locals within the same 64-statement bound, with an optional `const` qualifier.
  Integer declarations must match the homogeneous block signedness; names are
  unique and initializers are type checked. Simple reassignment rebinds a mutable
  local. Integer locals support all ten compound assignments plus standalone
  prefix/postfix increment/decrement. Local stores capture or replace an SSA
  result ID and local loads reuse it, so no SPIR-V function variable or memory
  instruction is emitted. Tests prove a
  single-use local is byte-identical to its inlined expression, a captured
  member retains its value after a later buffer store, and three locals still
  produce only the one requested GPU store. A local followed by `*=` is also
  byte-identical to its fully inlined form. Comma-separated same-type
  declarators are initialized and exposed left to right, capped at 64 total
  locals, and emit byte-identical output to separate declaration statements.
  Mutable preexisting locals may now be rebound inside selections. Each
  selection snapshots incoming local IDs, preserves actual predecessors across
  nesting, resets IDs for the else arm, and emits typed `OpPhi` values directly
  after the merge label only where incoming IDs differ. No function variable,
  local load, or local store is introduced. Tests cover no-else, else, nested,
  repeat-identical, integer and Boolean phis, const mutation, and type mismatch.
  Loop-carried mutable locals use the same zero-storage contract. A bounded
  pre-emission scan marks only locals stored within the loop, emits typed header
  phis for those locals, and patches their forward continue-edge values at loop
  close. Tests cover deterministic integer and Boolean loop phis, nested loops,
  const mutation, and type mismatch; unmodified locals add no phi.
  Nearest-loop `break` and `continue` now preserve that contract across nested
  selections. Selection merges retain only reachable arms, early edges retain
  their local IDs and actual predecessor blocks, distinct continue values merge
  before the single header back edge, and break values merge with the
  condition-false path after the loop. Tests cover deterministic output,
  integer and Boolean locals, nested-loop targeting, multiple early edges,
  malformed/out-of-loop jumps, and statements after an unconditional jump.
  Void early `return;` emits `OpReturn` from function or nested control depth.
  Selection reachability omits exited arms from local phis and seals a merge
  reached by no arm with `OpUnreachable`, avoiding unterminated dead blocks.
  Tests cover repeat-identical output, one-arm and both-arm returns, a return
  nested in a loop, rejected return values, and rejected following statements.
  Missing initializers, forward references, duplicate names,
  signedness mismatch, Boolean/integer reassignment, Boolean compound assignment,
  every simple/compound/prefix/postfix mutation of a const local, and local-only
  programs are checked failures. The live specialized shader now captures
  left-to-right immutable intermediates, computes signedness-correct bounds with
  `min`/`max`/`clamp`, prefix-increments and rebinds mutable integer/Boolean
  intermediates, then produces the checked `tail = 8` and `output = 7` on
  OpenGL and Vulkan.
  Brace-delimited structured `if`/`else` now lowers to deterministic
  `OpSelectionMerge`, `OpBranchConditional`, `OpBranch`, and label sequences.
  Unit coverage verifies no-else, else, multi-arm `else if`, nested,
  repeat-identical, malformed-else, and non-Boolean-condition cases. An
  `else if` chain is represented as nested structured selections in the
  preceding else arm. Branch arms may read and rebind preexisting SSA locals or
  update storage members; declarations inside arms remain rejected. The live
  specialized shader rebinds one result local across an `else if` arm containing
  a nested branch, then performs a single merged buffer store. Both real
  backends return the checked `tail = 8`, `output = 7` result.
  Brace-delimited `while` loops lower to deterministic structured SPIR-V with
  explicit header, body, continue, and merge blocks plus `OpLoopMerge`.
  Conditions execute in the header and therefore reload storage members after
  every back edge. Unit coverage verifies repeat-identical, nested-loop,
  loop-containing-selection, non-Boolean-condition, and missing-brace cases.
  The live shader advances a zero-storage `iterations` local through two static
  continue edges, then takes one of two static break edges, folds the merged
  result into one final `tail = 8` buffer write, and returns the exact packed
  value `34359738375` through both OpenGL and Vulkan. A final selection takes
  an actual early-return path after the checked output; its alternate arm writes
  a failure sentinel and also returns, so both drivers validate a fully
  terminating selection and unreachable structural merge.
  The storage block may contain up to 64 homogeneous signed or unsigned scalar
  members. Block, instance, and target-member names come from the parsed source
  rather than a naming convention. The selected LHS member receives a
  deterministic four-byte `std430` offset and access-chain index. Expressions
  may read any declared homogeneous member; only referenced foreign members get
  additional constant/access-chain IDs. Real-driver tests combine the first two
  members to update the third while preserving the initialized 64-bit prefix.
  Mixed member types, unknown members, and mismatched instances are rejected.
  Storage emission now consumes the shared source-spanned lexer end to end via
  immutable next-index parse results and one precedence-climbing expression
  parser. Version/layout qualifiers, optional specialization, storage members,
  entry point, assignment, and expression all use the same tokens. A
  comment-heavy declaration/expression form produces byte-identical SPIR-V to
  compact source, while lexer-level longest matching distinguishes logical,
  increment/decrement, and compound-assignment tokens from bitwise/arithmetic
  operators. The former private character expression parser and
  strict storage declaration scanner have been removed.
  Failed compute-storage grammar matches now preserve the current token's
  original one-based line and column in `GlslSpirvResult.error`. Regressions
  cover malformed built-in arity and a foreign storage instance on line two.
  The typed postfix tokens now retain spans for literals, loads, unary/binary/
  select/extended operations, and local or buffer stores. The storage emitter
  returns a typed words/error result, and regressions prove line-two semantic
  locations for bad built-in operands, Boolean arithmetic, non-Boolean ternary
  conditions, and mismatched local initializers.
  Strict raster templates now also match the shared lexer stream instead of a
  private character/subsequence scanner. Compute-storage and every delivered
  raster template accept both GLSL 4.50 and 4.60; equivalent 450/460 storage and
  procedural vertex/fragment packages are regression-tested byte-identical.
  An optional same-line `core` profile is accepted without changing output;
  misplaced or compatibility profiles are checked failures.
- Deterministic `$glsl` emission test: a strictly parsed compute shader with a
  Vulkan-capable version, reflected `(8, 4, 1)` local size, and empty `main`
  emits SPIR-V entirely in Abla. Repeated emissions are word-identical and the
  result creates a real Lavapipe shader module. Specialized axes additionally
  emit deterministic SPIR-V 1.2 `LocalSizeId` with `SpecId`-decorated unsigned
  defaults. The resulting module creates a real Vulkan 1.4 compute pipeline and
  dispatches under the Khronos validation layer without diagnostics. Statements
  and unsupported GLSL versions fail explicitly instead of being omitted from
  the module.
- Vulkan compute execution test: the Abla-emitted module creates an empty
  pipeline layout and real compute pipeline, records bind/dispatch into a
  persistent command buffer, submits workgroups, waits for completion, and
  resets for reuse. Pipeline-owned command-pointer and 72-byte ABI scratch
  storage make repeated dispatch allocation-free while preserving
  command-pool/buffer handles; teardown destroys pipeline, pool, then layout.
  A zero-group dispatch is rejected before command recording.
- Common compute test/sample: the same `$glsl` package creates an OpenGL 4.5
  compute program or the Vulkan SPIR-V/module/pipeline chain after one-time
  backend selection. Explicit OpenGL/Vulkan plus automatic/fallback paths
  dispatch repeatedly; zero-sized and over-limit X/Y/Z dispatch is rejected on
  both backends. Pipeline creation rejects local dimensions above the reported
  X/Y/Z limits and a legal per-axis layout whose product exceeds the maximum
  invocation count, all before driver calls.
  Four additional empty and storage-bound dispatches on each backend preserve
  native handles and leave runtime live bytes unchanged. OpenGL does not force
  `glFinish` after dispatch.
  Unsupported compute statements return the same common feature error before
  either OpenGL or Vulkan pipeline creation.
- Observable storage compute test/sample: a reflected binding-zero `std430`
  block is emitted as SPIR-V `BufferBlock`/descriptor decorations and a real
  access-chain/store. The grammar accepts both an unsigned constant assignment
  and self-plus/self-times-unsigned assignments; the latter forms emit
  `OpLoad`, `OpIAdd` or `OpIMul`, and `OpStore`. OpenGL binds an SSBO; Vulkan
  creates and binds descriptor
  layout/pool/set state. Explicit and automatic/fallback paths dispatch the
  same typed comparison/logical/ternary package five times and common buffer
  readback returns exactly `161`, with no live-memory growth across the four
  repeated calls;
  the raw Vulkan variant multiplies twice and returns `18`, proving repeated
  commands operate on observable persistent storage.
- Project tree inspection finds no C/C++/Rust source and no GLFW/SDL dependency.
- Monotonic frame-pacing sample: a reusable affine clock owns its syscall
  buffers, four 240 fps waits advance real `CLOCK_MONOTONIC` time, and runtime
  live-memory accounting is unchanged across the steady-state loop.
- Portable idle synchronization: `GraphicsApplication.waitIdle()` makes the
  OpenGL context current and calls `glFinish`, or waits with
  `vkDeviceWaitIdle`. Four repeated waits on both backends preserve runtime
  live bytes; an invalid application rejects the operation before a driver
  call.
- Portable GPU timestamps: one affine query owns an OpenGL timer-query object
  or a Vulkan timestamp query pool plus dedicated reusable command state.
  Vulkan reads the queue-family timestamp width and device period; common
  elapsed-time conversion handles counter wrap. Four monotonic application
  samples and the dedicated profiler sample preserve native handles and report
  zero live-memory growth on both backends. Invalid applications reject query
  creation and sampling before driver calls.
- Pure-Abla Khronos inventory generation: exact official Vulkan and OpenGL
  registry commits and SHA-256 digests are pinned in one manifest; the generator
  filters Vulkan SC, OpenGL ES, and compatibility-only requirement branches,
  resolves selected command references against definitions, merges API
  variants, follows the selected internal Vulkan base/compute/graphics groups,
  byte-sorts output, and produces committed coverage ledgers for 842 Vulkan
  commands/5 public core versions/473 extensions and 2,892 OpenGL commands/19
  core versions/623 extensions. Offline fixtures prove API filtering, internal
  dependency collection, aliases, exact output, and repeated-run determinism.
  A strict audit join currently classifies 113 Vulkan and 108 OpenGL commands as
  `common`, with separate loader, ABI, positive-test, and unsupported-path
  evidence. Duplicate, incomplete, invalid-status, and registry-unknown audit
  rows are rejected. Every other row remains explicitly `unclassified`, so
  inventory presence is not represented as backend support.
  The same deterministic pass generates independently importable raw Abla
  modules containing the pinned revision/hash and all sorted command names,
  forms, core features, extensions, and joined statuses. Exact fixture bytes
  are compared across two runs, and the full 2,892-command OpenGL plus
  842-command Vulkan modules compile together behind stable raw facades. The
  OpenGL facade also contains 6,271 exact generated `GL_*` values. Fixtures
  prove desktop-over-GLES collision selection and reject unknown expressions;
  compiler tests verify representative 32-bit, 64-bit-all-ones, and overridden
  values.
- The required general `ablac` `nativeLibraries` contract is integrated in
  compiler commit `116090f`; graphics tests use the stock sibling compiler.
- The loop regression exposed excessive recursive compile-time evaluation of
  long logical chains. Sibling compiler commit `4ec5cd9` flattens homogeneous
  `&&`/`||` trees while preserving left-to-right short-circuit evaluation; its
  128-term conjunction/disjunction regression, 73-test suite, and pure
  self-rebuild pass.
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

Compiler commit `f8a0a09` normalizes named arguments on overloaded extension
calls, including omitted defaults and affine results. Its focused regression,
73-test conformance suite, compact value-ABI check, and byte-identical
pure-Abla self-rebuild passed before the dynamic-rendering fallback test used
`preferDynamicRendering = false`.

Compiler commits `bb5f101`, `bf994ea`, and `894ebea` add fixed-signature native
extension calls, precisely scoped process-visible executable exports,
initialized immutable globals for exported adapters, and monotonic atomic
`i64` counters. Their focused ABI
regressions, 73-test conformance suites, compact value-ABI checks, and
byte-identical pure-Abla self-rebuilds passed before the Vulkan debug callback
was enabled.

Compiler commit `fd1c74e` isolates those new intrinsics in the optional
`abla/unsafe/native` module so the prior `v0.2.4` release can still bootstrap a
clean current checkout. The exact old-seed build, 73-test suite, compact ABI
check, and byte-identical self-rebuild pass with that boundary.

The optional Vulkan debug-utils module discovers `VK_EXT_debug_utils`, while
common headless and X11 configuration controls whether instances enable it.
Importing `driver/vulkan_debug.ab` adds the process callback, resolves
create/destroy/submit entry points through `vkGetInstanceProcAddr`, and owns the
messenger, atomic counters, and reusable 4 KiB callback scratch in Abla. The
validation test submits all four severity
classes and all three message types through the real loader callback, verifies
exact accounting and invalid-mask rejection, preserves the native handle, and
shows zero steady-state live-byte growth. An explicitly disabled instance
proves the unsupported path.

The validation-enabled full suite also corrected three packed Vulkan ABI and
ownership defects it exposed: 2D mip blits now set both second Z offsets to
one, the final 28-byte subpass dependency has valid writable storage, and each
compatible render pass owns a framebuffer created against that exact pass.
The full test matrix and all 18 sample applications then passed with no Vulkan
validation errors, warnings, or VUID diagnostics.

The optional OpenGL debug module now owns synchronous OpenGL 4.3 core debug
output with a process-resolved Abla callback, atomic severity/type counters,
and reusable message storage. Its direct headless test drives real
`glDebugMessageInsert` callbacks across all four severities, checks exact
counter deltas, rejects invalid input, proves an explicitly disabled path, and
retains zero steady-state live-byte growth. The linked executable exposes only
the requested callback symbol.

The optional common `debug.ab` facade now specializes once to either backend
for surfaced or headless applications. It normalizes four severity classes,
retains the backend-specific affine owner, reports structured unsupported
errors, and keeps repeated submissions allocation-free. Its headless
conformance test exercises both real driver callbacks, exact normalized counter
deltas, explicit destruction, and Vulkan's validation-disabled rejection. The
combined executable exports precisely the two requested Abla callback symbols.

GLSL binding reflection now parses non-empty uniform/storage interface blocks,
including qualified scalar/vector/matrix members, fixed or unsized member
arrays, block instance names, instance arrays, and leading member layout
qualifiers. Member reflection retains explicit offsets, power-of-two
alignments, and row/column-major selection. It rejects malformed,
duplicate-name, duplicate-layout-key, and conflicting-major member declarations
and compares the complete ordered member structure and layout metadata when a
descriptor slot is shared across stages. Positive and negative subparser cases
preserve deterministic existing SPIR-V output.

Top-level named GLSL structures are now reflected as ordered, stage-tagged
`ShaderStructure` definitions. Members can nest previously declared structures;
duplicate names, unknown/forward/self-referential types, unsized members, and
structure-member layout qualifiers are rejected. Inline comma-separated
instances and their fixed-array extents are retained. Later uninitialized
top-level declarations using the named type extend the same instance list;
functions returning that type are excluded. Malformed lists and duplicate
stage-global names fail, and interface blocks remain single-instance. Explicit
interface locations retain their recursively computed slot count, so nested
members, arrays, matrices, and wide double vectors participate in overlap
checks. Adjacent raster stages compare complete nested definitions rather than
accepting an equal outer type name with incompatible contents. Interface-block
locations also retain their ordered members and computed ranges.

GLSL reflection now also owns explicit `layout(push_constant)` uniform blocks
and scalar `layout(constant_id=N) const` declarations. Push constants retain
stage, block/instance names, and ordered member structure; each stage permits
one block and shared blocks must agree structurally. Specialization constants
retain stage, ID, scalar type, name, and exact default literal across bool,
signed/unsigned integer, float, and double forms. Duplicate IDs, repeated
recognized layout keys, incompatible qualifier combinations, malformed typed
literals, and cross-stage push-block mismatches are regression-tested failures.
Specialized compute workgroup axes retain `local_size_x/y/z_id` alongside the
resolved default or concrete dimension. Compatible declarations merge, while
conflicting repeated values, cross-axis repeated IDs, ID-only workgroups, and
collisions with explicit specialization constants are rejected.

The embedded subparser now preserves quoted text and recognizes both
`#include "path"` and `#include <path>` as ordered stage dependencies. Empty or
malformed includes invalidate runtime packages, and unterminated quoted text is
a compile-time `E_SUBPARSER_FAILURE` with its original extension-expression
span. The supporting `ablac` diagnostic path is regression-tested through a
pure self-rebuild and the complete 73-test compiler suite.
An explicit pure-Abla `GlslModule` table now resolves local/system includes
recursively without ambient filesystem access. Expanded stages are reparsed for
their complete reflection. Missing and duplicate modules, empty identities,
cycles, and recursion beyond 64 modules are checked failures; nested positive
coverage leaves no unresolved `ShaderInclude` entries.

Embedded stage values now retain their canonical Abla source identity and
exact body byte range through `$glsl`, `#$glsl`, and hermetic module expansion.
Runtime-created packages deliberately report no source span. The compiler's
raw cursor API and `source[subparser]` diagnostic location are covered by its
generated-subparser suite, all 73 compiler tests, and a byte-identical pure
self-rebuild.

`$glsl` and `#$glsl` now accept safe typed Abla interpolation for signed
integers, checked non-negative integers, and Booleans. Comments and quoted text
remain inert, string values fail semantic typing rather than becoming shader
source, and unsupported float interpolation has a precise subparser diagnostic
instead of exposing an IEEE-bit integer. Runtime/frozen positive cases and all
three rejection paths are executable tests.

GLSL reflection now begins with one shared pure-Abla lexer rather than relying
only on declaration-specific character scans. Tokens retain exact byte ranges
and one-based line/column origins across comments, CRLF, and line continuations;
operators use longest matching and decimal, hexadecimal, exponent, and suffix
forms are classified explicitly. Standalone tests cover span round-tripping,
malformed tokens, quoted continuations, and the operator inventory. Package
integration rejects an invalid source byte with its exact `2:28` location. The
existing `$glsl`, SPIR-V, and live application paths all consume this lexical
validity gate unchanged.

## Not yet claimed

- General render-graph command encoding with per-subpass input/preserve
  attachment lists, arbitrary attachment routing and dependency masks,
  complete synchronization2
  barrier/event migration, and offscreen/MRT dynamic rendering. The delivered
  pure-Abla graph planner validates stable explicit dependencies, derives
  declaration-order read/write hazards, rejects cycles, computes scheduled
  lifetimes, emits pruned resource-specific barrier records, and aliases
  compatible non-overlapping transient allocations. Its typed texture layer
  now materializes those allocation slots as retained cross-backend texture
  pools with checked logical-resource operations. Ordered direct pass entry
  submits conservative derived memory barriers. The bounded reusable slice
  records ordered pass markers, transient texture copies, owned
  procedural/vertex/indexed offscreen renders, and affine procedural subpass
  sequences, and consolidates an eligible
  Vulkan stream into one submission. Imported uniform/storage buffers can now
  be mapped to retained bind groups for every recorded stage. It does not yet
  record arbitrary per-subpass input/preserve attachment routing,
  broader sampled/image command forms, or
  a complete asynchronous frame stream.
  Surfaced pipelines already use feature-gated dynamic rendering while the
  portable sequence currently gives every stage the target's complete
  color/depth/resolve attachment set and inserts
  fixed color-output dependencies. The initial raster pipeline,
  reusable clear, and pixel-upload paths honor the configured one-to-eight
  fence-guarded slots and have no per-frame queue-wide idle. Clear and pixel
  and render presentation recover once from suboptimal/out-of-date swapchains;
  render recovery rebuilds surface-dependent pipeline objects automatically.
- Wayland higher XKB groups/levels, dead-key compose, input methods, automatic
  fractional-scale shared-buffer replacement, and Vulkan/EGL presentation
  integration. The current stable xdg-shell/xdg-output/viewporter slice has
  reusable one-to-three-buffer XRGB8888 presentation, compositor-ownership
  tracking, allocation-stable hot-path wire I/O, continuous callback-driven
  frames, and raw portable keyboard/pointer events. Windows and macOS platform
  modules.
- X11 compose/dead-key sequences, input methods, and additional XKB groups.
- Broad OpenGL buffer/texture/framebuffer/compute and extension coverage.
- Complete Vulkan feature-structure and OpenGL extension negotiation, optional
  feature preferences, broader per-stage limits, and typed extension objects.
  The current common capability report covers twelve portable feature bits and
  the directly queried limits documented in the API contract.
- Full GLSL 4.60 grammar validation/reflection or SPIR-V emission. The current
  subparser and shared source-spanned lexer own stage structure/source
  preservation plus the initial explicit
  location/set/binding declaration, interface-block member subset, and
  cross-stage compatibility slice, named/nested structure reflection,
  push-constant reflection, and scalar specialization-constant reflection. It
  does not yet discover modules from
  filesystem/package search paths or parse general declarations, structure
  instance initializers, composite constants, or expressions. Explicit member
  layout
  metadata is reflected and push-constant scalar/vector/matrix/fixed-array
  blocks now convert into a deterministic standard-layout byte contract with
  combined stage masks, offsets, sizes, alignments, and array/matrix strides.
  A reusable affine `GraphicsPushConstants` value provides exact member writes,
  typed name/component/array-index scalar and vector writes, reflected
  row/column-major float/double matrix-coordinate writes, plus checked raw
  byte-offset hot paths without per-frame allocation. The same typed API is
  available per subpass from one contiguous aggregate; byte-exact tests cover
  32-bit and 64-bit families, both matrix orders, and strided arrays.
  General uniform/storage host-structure offsets remain unverified. Reflected
  compute push constants are wired to native Vulkan pipeline ranges and command
  recording plus persistent OpenGL UBO emulation for the strict observable
  storage-add shader slice. Raster fragment `vec4` push color is wired through
  procedural, vertex, indexed, vertex-indirect, and indexed-indirect offscreen
  and presented commands plus matching reusable render-pass attachment
  operation commands on both backends. Affine two-to-eight-stage procedural
  subpass sequences now own one contiguous reflected value block; OpenGL binds
  each persistent program UBO and Vulkan records each native subpass range
  after its pipeline bind. Exact pixels, missing-value rejection, stable
  handles, and zero-growth repeated values are verified on both backends.
  A vertex-only `vec4` offset subset additionally performs real position
  addition, with exact centered/shifted pixels and the same allocation and
  handle proofs. A shared 32-byte vertex/fragment block combines that offset
  with a fragment tint under stage mask 17, proving independent exact geometry
  and color updates from one value block on both drivers. A bounded typed
  raster postfix IR now emits fragment `vec4`/`float` push-member and literal
  expressions with parenthesized multiplication, division, addition, and
  subtraction directly to deterministic SPIR-V, including mixed-type push
  structures, scalar/vector loads, both operand orders of
  `OpVectorTimesScalar`, equal-type division, and exact `vec4 / float` lowering
  through a runtime splat plus vector `OpFDiv`; fixed fragment push word tables
  have been removed. Typed
  mismatch/array and `float / vec4` rejection, 48-byte reflected offsets,
  precedence, repeat-emission, exact real-driver pixels, stable handles, and
  zero-growth frames are verified. The same IR now accepts up to eight
  reflected location-based `vec4` fragment inputs with or without a push block,
  emits entry-point interfaces/decorations/variables/loads, and replaces the
  former fixed interpolated-color fragment table. Single-input real-driver and
  multiple-input deterministic tests pass. Other interface types, functions,
  and control flow remain upcoming. Constant-only `vec4` expressions now use
  the same emitter with no input or fragment push interface, including when a
  different stage owns the package push block; the fixed solid-color fragment
  table has been removed. Arbitrary literals, cross-stage regression, exact
  real-driver pixels, stable handles, and zero-growth frames are verified.
  Bounded prefix `+`/`-` now applies to scalar and `vec4` primaries; plus is an
  IR identity while minus emits typed `OpFNegate`. Precedence, nested scalar
  negation, identity byte equality, malformed-operand rejection, and exact
  negative-vector real-driver output are verified.
  One-argument scalar `vec4` splats now share a single generated float constant
  across all four lanes. Signed splat equivalence to the explicit constructor,
  deterministic 70-word output, malformed-arity rejection, and exact white
  real-driver pixels with stable zero-growth frames are verified.
  One to eight reflected `vec4` outputs now have independently flattened typed
  expressions, entry-point variables/decorations, and stores. Ordered-write and
  missing/type failure remain strict. The former fixed MRT fragment table is
  removed; independent add/subtract tests and the two-output 4x multisampled
  real-driver sample prove deterministic exact output, stable handles, and zero
  steady-state growth. Stage-local fragments no longer emit stray metadata for
  push blocks owned only by another stage.
  Exact-bit float constant interning is shared across every typed output stack,
  vector component, and scalar literal. The MRT module drops from 117 to 93
  words with two constants, while vector/scalar reuse, deterministic bytes, all
  exact pixels, stable handles, and zero-growth behavior remain verified.
  Up to eight ordered `float`/`vec4` locals, optionally `const`, now expand into
  the typed postfix IR without function storage across at most 32 local
  statements. Mutable reassignment replaces the current SSA expression while
  preserving the declared type. The four floating compound forms `+=`, `-=`,
  `*=`, and `/=` combine that expression with a typed right operand and rebind
  it under the same scalar/vector rules, still without local storage. Scalar
  and vector standalone prefix/postfix `++`/`--` likewise append typed one and
  add/subtract before rebinding. Compound and update programs are byte-identical
  to their fully inlined forms. Comma-separated same-type declarators share
  mutability, expose initializers left to right, consume one statement, and
  individually obey the eight-local cap; their output is also byte-identical to
  separate inline expressions. Const mutation, type changes, undeclared
  assignment/update, unsupported `%=`, malformed updates, duplicate/forward
  comma names, and a ninth declarator reject. Namespace-collision and exact
  32-statement boundary coverage remain. Single-component `.xyzw`, `rgba`, and
  `stpq` selectors now lower vector inputs, push members, locals, literals, and
  parenthesized expressions to scalar `OpCompositeExtract`. Alias forms are
  byte-identical. Four-component permutations from one `xyzw`, `rgba`, or
  `stpq` naming family now lower the same source kinds to `OpVectorShuffle`;
  `.bgra` emits selectors 2/1/0/3 and is byte-identical to `.zyxw`. Two- and
  three-component selectors now produce `vec2` and `vec3` with width-specific
  shuffle instructions, including repetition from narrow sources. Scalar bases,
  unknown or mixed-family selectors, and source-out-of-range components reject.
  The live narrow-input path executes `.yx` with its exact dual-backend proof.
  One- and four-scalar runtime `vec4` constructors now consume arbitrary
  supported scalar expressions and emit `OpCompositeConstruct`, with a single
  scalar ID reused across all splat lanes. Signed constant constructors retain
  byte-identical interned constant composites. Dynamic push/component/local
  forms validate; two, three, five, or vector arguments reject. Typed
  `dot(vec4, vec4)` now lowers push, input, local, literal, and nested operands
  to scalar `OpDot`; scalar operands and wrong arity reject. Scalar/vector
  `min`, `max`, and `clamp` emit `GLSL.std.450` `FMin`, `FMax`, and `FClamp`
  through one conditional import. Their GLSL `vec4,float` and
  `vec4,float,float` overloads materialize operand splats; reverse ordering,
  partially mixed clamp bounds, and wrong arities reject. Nested calls and
  push/input/local operands validate; shaders not using them retain
  byte-identical import-free modules. Homogeneous scalar/vector
  `abs`, `floor`, `ceil`, `sqrt`, and `inversesqrt` share that import and retain
  their operand type; nested instruction-number coverage and arity rejection
  pass. Scalar/vector `mix`, `step`, and `smoothstep` share the same import and
  typed emission. Their vector-result overloads accept, respectively, a scalar
  factor, scalar edge, or two scalar edges and materialize typed splats;
  reversed value typing, partially mixed edges, and wrong arities reject. The
  reflected `.w`/`.bgra`, interpolated `sqrt(abs(dot(...)))` projection,
  runtime-denominator, comma-local postfix-`--`, prefix-`++`, and `+=` push-
  expression sample retains exact OpenGL/Vulkan pixels, stable handles, and
  zero-growth repeated frames. The same table now covers scalar/vector
  rounding/fraction/sign, angle/trigonometric, inverse/hyperbolic, exponential/
  logarithmic functions, homogeneous `pow`, and `fma`; every mapped instruction
  number has positive module-validity coverage, with vector typing and arity/
  mismatch rejection.
  Floating `mod` now accepts scalar/scalar, vector/vector, and vector/scalar
  signatures and emits core `OpFMod` instruction 141, including the required
  divisor splat for vector/scalar input. Push/input/local operands, exact opcode
  counts, scalar/vector mismatch, and wrong arities are covered; `%` and `%=`
  remain correctly reserved to unsupported integer raster expressions. The
  live sample executes scalar and vector/scalar forms with unchanged pixels,
  handles, frame count, and allocation proof, then clamps the vector result
  through scalar bounds with the same proof.
  Unary `atan(x)` now coexists with homogeneous scalar/vector `atan(y, x)`.
  A bounded top-level call scan resolves the latter to `Atan2` instruction 25
  while ignoring separators inside nested calls; mixed types and third
  arguments reject, and the live phase executes the scalar overload on both
  backends without changing its exact output.
  Core fragment derivatives `dFdx`, `dFdy`, and `fwidth` now preserve scalar or
  vector operand type and emit opcodes 207-209 without an extended-instruction
  import. Nested scalar/vector, push, input, and local paths plus exact arity
  rejection pass. Fine/coarse variants emit opcodes 210-215 and conditionally
  declare `DerivativeControl`; ordinary modules remain capability-free and
  byte-stable. The live phase adds `fwidthFine(vec2(0)).x` with unchanged
  dual-backend pixels, handles, frame count, and allocation behavior.
  Width-aware local raster vectors now cover `vec2`, `vec3`, and `vec4`
  scalar-splat and width-exact construction, equal-width arithmetic and dot,
  vector/scalar multiply, divide, and floating mod, width-checked component
  extraction, derivatives, and width-preserving extended math/interpolation/
  geometry operations. `cross` is restricted to equal `vec3` operands and emits
  `GLSL.std.450` instruction 68; its result composes into a `vec4` output.
  Narrow type declarations are conditional, so
  existing `vec4` modules retain their established IDs and bytes. Module-valid
  positive coverage includes both narrow widths, while out-of-range components
  and mixed-width arithmetic reject. Reflected raster push blocks now accept
  scalar, `vec2`, `vec3`, and `vec4` members with their existing checked layout.
  A mixed narrow block validates byte offsets and typed SPIR-V loads. The live
  `push-color` sample uses `vec3 tint` at byte 0 plus `float alpha` at byte 12
  across all 16 OpenGL/Vulkan render forms, retaining exact pixels, four frames,
  stable handles, and zero live-byte growth. Fragment location inputs now accept
  `vec2`, `vec3`, and `vec4` with width-specific pointer, variable, and load
  emission; mixed narrow inputs validate as one module. The `narrow-input`
  sample interpolates `vec2` into a composed `vec4` color with the same exact
  dual-backend pixel, four-frame, stable-handle, and zero-growth proof.
  Fragment color outputs now emit deterministic `vec2`, `vec3`, or `vec4`
  Output pointer, variable, and store types. Mixed narrow MRT modules validate,
  and expression widths must match exactly. Native missing-component attachment
  semantics are live-verified: `vec3` writes RGB with zero alpha to RGBA8 on
  both backends (`pixel=255`), with four frames, stable handles, and zero growth.
  The live source-vector path also executes scalar-factor `mix` before its
  downstream SSA expansion and retains the exact dual-backend proof.
  Vector geometry built-ins now carry their non-homogeneous signatures through
  validation and emission: `length`/`distance` return scalars, while
  `normalize`/`faceforward`/`reflect`/`refract` return vectors and `refract`
  alone requires a scalar third operand. Instruction numbers 66, 67, and
  69-72, push/input/local operands, every result shape, wrong arity, and mixed
  operand rejection are covered. Its input/local proof uses a matching
  vertex-to-fragment interface. The live sample normalizes its alpha axis;
  scalar-returning `length` remains module-validated. Both live backends retain
  the exact pixel, stable handles, four frames, and zero live-byte growth.
  Specialized compute workgroup IDs and fixed-workgroup scalar constants are
  wired through the portable descriptor on both backends. SPIR-V emission
  currently covers the strict no-op and precedence-parsed homogeneous scalar
  storage-block expression compute subsets plus fixed, interleaved
  position/color, and sampled-texture triangle vertex/fragment subsets for 2D,
  2D-array, cube, and 3D textures described above, not general shaders.
- Callable generated bindings, compiler-verified host offsets, and fully
  classified coverage ledgers. The pinned deterministic inventory, strict
  evidence join, compiled raw metadata modules, complete selected OpenGL and
  Vulkan constant output, command signatures, and Vulkan aggregate declarations
  exist, with 222 exercised common commands classified; all other
  rows deliberately remain `unclassified` until equivalent evidence is
  attached.
- Format-converting texture copies/render-pass byte use and
  device-local texture suballocation pools,
  command encoders/render graph,
  asset formats, or framework-wide performance gates. Partial logical RGBA/BGRA
  `PixelBuffer` uploads, synchronous diagnostic readback, and exact pitched
  `BufferBytes` transfer for single-sample color/compressed 1D, 2D, array, cube,
  and 3D selections are present; raw depth/stencil transfer is not. The same
  wider color/compressed selections are supported by fixed-slot asynchronous
  queues. Same-format synchronous subresource copies are present.
  General reusable buffer
  byte-range upload/readback is present, including
  distinct source and destination offsets; synchronous GPU buffer copies and
  aligned 32-bit pattern fills reuse backend command state. Synchronous
  coherent persistent transfers, bounded aligned synchronous buffer rings, and
  fixed-slot asynchronous buffer and texture upload/readback queues are present
  for RGBA8/BGRA8 pixels and pitched raw color/compressed selections;
  asynchronous depth/stencil image transfer is not.
  Common buffers, textures, views,
  samplers, and immutable structural
  descriptors, the synchronous wider resource/transfer surface, and
  full-resource and explicit-view wider sampled bindings are present.
- The complete sample catalog, driver/platform CI matrix, or tagged release.

### Recorded ordinary render bindings

Ordinary recorded renders now compose the existing procedural/direct/indexed/
indirect draw-resource forms with the typed planner-visible binding table.
`recordRenderBindingAttachments(...)` and its push form retain imported
buffers, full sampled textures, explicit texture views, graph-owned transient
sampled textures, and their affine samplers without multiplying public methods
per draw form. Record, seal, and replay check declared access, usage,
descriptors, attachment separation, native identities, and the one-stage entry
map. The seal also fingerprints the render bind group and retained owners.

`examples/recorded-graph-texture-render` is the 55th independent sample root.
Its focused stripped-`LD_LIBRARY_PATH` gate passed OpenGL, Vulkan, and automatic
selection with exact RGBA8 `4294281759`, post-seal map-tamper rejection, 1,001
successful executions, zero/1,001 Vulkan submissions, and zero warmed
live-byte growth. The complete 55-root matrix remains scheduled for the next
broad sample-infrastructure gate.

### Recorded sampled compute bindings

Recorded compute now shares the typed retained binding-resource table used by
ordinary renders and subpasses. Imported uniform/storage buffers, full sampled
textures, explicit views, graph-owned transient sampled textures, and samplers
flow through one `recordComputeBindingResources(...)` API plus its push form.
Logical access, descriptors, native owners, stage mapping, activity, and seal
fingerprints are checked without warmed allocation.

The deterministic Abla `$glsl` translator now supports one compute-visible
`sampler2D` plus storage-buffer program and emits valid byte-stable Vulkan
SPIR-V; OpenGL executes the same source. The 56th independent sample,
`recorded-graph-texture-compute`, passed stripped-`LD_LIBRARY_PATH` launches on
OpenGL, Vulkan, and automatic selection with exact value `1001`, post-seal map
tamper rejection, zero/1,001 Vulkan submissions, and `live=0`.

### Recorded storage-image compute

The common feature mask and bind-group API now expose storage textures.
`storageTextureEntry(...)` validates an owned single-mip RGBA8 2D texture and
explicit access. OpenGL applies `glBindImageTexture` and the shader-image
barrier bit. Vulkan creates descriptor type 3 with `GENERAL` layout and
performs the initial layout transition once, outside warmed replay.

The deterministic `$glsl` subset recognizes one exact write-only `image2D`
`imageStore` program and emits valid byte-stable SPIR-V entirely from Abla.
`graphSubpassStorageTextureResources(...)` retains the affine texture plus
logical ID/access and validates graph use, descriptor, native identity, stage
map, activity, and seal fingerprint. The 57th sample,
`recorded-graph-storage-image-compute`, passed stripped-`LD_LIBRARY_PATH`
OpenGL, Vulkan, and auto launches with exact red `4278190335`, sealed-map
tamper rejection, 1,001 successful replays, zero/1,001 Vulkan submissions,
and `live=0`. Broader formats/dimensions and fragment-stage images were the
next checkpoint.

### Storage-image views and read-write lowering

Shader binding reflection now retains image access qualification and the
`rgba8` layout format. Pipeline matching rejects an access or format mismatch;
unqualified `image2D` maps to explicit read-write access. The pure-Abla SPIR-V
translator adds a deterministic `imageLoad` plus channel-swapping `imageStore`
program alongside the earlier write-only form.

`storageTextureViewEntry(...)` binds one affine mip/layer view. Vulkan performs
a one-time transition only for its selected parent range and uses the existing
view directly; OpenGL binds the re-indexed view object. The retained graph table
owns and fingerprints parent, view descriptor/native identity, logical ID,
access, and encoded stage map. The 58th independent sample,
`recorded-graph-storage-image-view-compute`, passed stripped-`LD_LIBRARY_PATH`
OpenGL/Vulkan/auto launches with exact green `4278255360`, 1,001 replays,
post-seal tamper rejection, zero/1,001 submissions, and `live=0`. Its first
performance run exposed and then removed a 416-byte-per-replay descriptor
validation allocation from the warmed path.

### Extended-format and fragment storage images

The common capability mask now distinguishes storage images, fragment-stage
stores, and Vulkan's extended shader-image formats. Vulkan queries and enables
`fragmentStoresAndAtomics` and `shaderStorageImageExtendedFormats`; OpenGL 4.3+
advertises both portable capabilities. Entry creation rejects vertex-stage
storage images and rejects a fragment or extended-format entry when its
specific capability was not enabled.

Reflection and bind-group matching cover R8/RG8/RGBA8 unorm and R16/RG16/
RGBA16/R32/RG32/RGBA32 float layout formats. The pure-Abla emitter adds an
exact R32F compute store and an exact fragment RGBA8 store. OpenGL render paths
now issue storage/image barriers after draw writes, while Vulkan's `GENERAL`
resting access includes shader reads and writes before transfer readback.

The 59th sample, `recorded-graph-storage-image-r32f-compute`, preserves exact
IEEE `1.0f`, rejects sealed-map mutation, and completes 1,001 OpenGL/Vulkan/auto
replays with zero/1,001 submissions and `live=0`. The 60th sample,
`fragment-storage-image`, writes exact green to its storage image and exact red
to its color attachment through 1,001 allocation-free renders on both
backends. Both executables pass stripped-`LD_LIBRARY_PATH` linkage. Broader
image dimensions and general image-expression lowering remain open.

### Bounded asynchronous Vulkan graph replay

Eligible retained graph streams now use the configured `framesInFlight` count
as a fixed Vulkan command-pool/buffer ring. `vkQueueSubmit2` signals the shared
transfer timeline and returns after queue acceptance; reuse waits only on the
selected slot. Command-list polling/wait APIs retire slots without allocation.
A conflicting direct transfer drains the shared device ring
before command-pool reset, and device teardown waits idle before final pool
destruction. Callers retain the graph and list until explicit retirement.
Synchronous non-persistent Vulkan buffer reads and writes wait for accepted
queue work before mapping, so an immediate readback after asynchronous replay
cannot observe stale data. Persistent mapped ranges remain explicitly
caller-synchronized. The shader dispatcher now establishes a reflected RGBA8
storage-image shape before entering image-expression lowering; an ordinary
storage-buffer plus push-constant regression prevents speculative image-member
access from returning.

`recorded-graph-copy` configures three slots and, after 1,001 exact replays,
observes `retained=3/3->0`, zero warmed live-byte growth, and exact array/volume
readback. Its executable has no unresolved dependency with `LD_LIBRARY_PATH`
removed, passes explicit OpenGL, and passes Vulkan with the Khronos validation
layer enabled and no validation output.

### Mutable and conditional storage-image value statements

The generated read/write RGBA8 image subset now accepts mutable `vec4` locals
with direct and `+=`, `-=`, `*=`, `/=` assignments. Each update is type checked
and folded into the existing bounded postfix SSA expression, preserving pure-
Abla deterministic emission without function-local storage or source templates.
The focused GLSL gate accepts chained direct/add/subtract/multiply/divide
updates and rejects unsupported `%=`. The retained array-image sample now uses
one mutable initialization plus five updates and still reaches exact cyan
`4294967040` through 1,001 OpenGL, Vulkan, and automatic-selection replays with
zero warmed live-byte growth and zero/1,001 Vulkan submissions.

Scalar component/literal expressions now support all six ordered floating
comparisons as conditions for a bounded `if` with optional `else`. Each branch
contains one direct assignment to the same mutable `vec4`; missing `else` keeps
the prior SSA value. Vulkan emission declares scalar/vector boolean types,
splats the scalar condition to the selected `vec4` width, and emits the
comparison plus `OpSelect`, while OpenGL consumes the original GLSL. Focused
tests cover every comparison, present/missing `else`, mismatched branch targets,
and vector-condition rejection. The retained sample executes the `>`/`else`
form on both production backends with the same exact output and replay evidence.

### Recorded deferred rendering

`graphRenderPriorAttachmentResources(...)` lets any recorded procedural or
buffered draw sample one to eight color attachments from earlier render records
in the same sealed list. The command list remains the sole affine owner of the
textures; the wrapper owns samplers and records planner IDs. Recording verifies
the exact earlier target/native binding relationship, while activity checks and
seal fingerprints reject stale or mutated metadata.

The deterministic `$glsl` path now includes a dual-`sampler2D` add fragment
form with exact Vulkan set 0 bindings 0 and 1. The 65th sample,
`examples/deferred-renderer`, writes red/green albedo/normal MRT attachments and
samples both in a lighting pass to exact yellow `4278255615`. Explicit OpenGL,
explicit Vulkan, and automatic selection each reject post-seal ID mutation and
complete 1,001 successful replays with `live=0`; submission counts are
zero/1,001. Its embedded Nix rpaths also pass the stripped-`LD_LIBRARY_PATH`
dependency audit.

### Recorded compute-to-render handoff

The prior-texture wrapper now accepts a full storage texture owned by an earlier
recorded compute binding, while retaining the same exact logical-ID/native-
identity proof used for render attachments. Vulkan sampled bind-group entries
snapshot the tracked image layout; a storage+sampled texture prepared in
`GENERAL` stays there for fragment sampling, and the graph's write-to-read
memory barrier supplies visibility without another submission.

The 66th sample, `examples/recorded-compute-render`, writes exact red from
compute and samples it in a later render pass. OpenGL, Vulkan, and automatic
selection each reject sealed-ID mutation and complete 1,001 replays with
`live=0`; Vulkan uses exactly 1,001 submissions and passes the Khronos
validation layer with empty stderr. The executable also resolves every shared
dependency with `LD_LIBRARY_PATH` removed.

Later milestones remain tracked in [the implementation plan](../plan.md); only
the checkpoints described above are represented as delivered.

### Registry-generated Vulkan structure layouts

The pinned Vulkan registry now generates hosted native layout schemas for all
1,209 structures whose members are fully described by known scalar or pointer
ABI rules. The compact output covers 5,832 members with deterministic type
size/alignment, `sType`, member kind, and member offset data. Arrays, nested
aggregates, unions, and bitfields are deliberately excluded until their ABI
rules are modeled rather than guessed.

The pure-Abla affine runtime exposes a generic checked structure builder and
routes the existing event, fence, queue-info, and command-buffer-begin typed
builders through the generated schema. The live raw Vulkan proof passes in
normal and optimized modes with exact resolver/device/image/event/fence results,
stable handles, and `loopLive=0`. The schema is encoded as two cold-path strings
instead of thousands of array literals after the array representation exceeded
the compiler's focused-gate time budget.
The builder module is opt-in rather than re-exported by `raw/vulkan.ab`, so
ordinary applications and the runtime-linkage probe do not pay its compile-time
cost. The live builder proof imports it explicitly.

### Recursive Vulkan layouts and affine feature chains

Generated hosted layout coverage now reaches 1,395 Vulkan structures and 7,103
members. Iterative dependency resolution adds by-value nested structures,
unions, multidimensional fixed arrays, and symbolic array extents resolved from
the pinned registry constants. Exact regression layouts cover the 240-byte
`VkPhysicalDeviceFeatures2`, 16-byte `VkClearValue`, 48-byte
`VkTransformMatrixKHR`, and 80-byte `VkImageBlit`. Bitfield packing and any
remaining unresolved platform aggregate rules remain open.

The generator also retains each structure's `structextends` list. A new affine
chain validates root compatibility and duplicate node types, lays all nodes out
in one aligned zeroed allocation, initializes `sType`, and links internal
`pNext` pointers. Deterministic tests prove exact links, setters, drop
invalidation, duplicate rejection, and incompatible-root rejection. The normal
and optimized live raw runs query timeline semaphore and synchronization2
features through a generated `VkPhysicalDeviceFeatures2` root and two-node
chain, observe `features=1/1`, retain `loopLive=0`, and remain stable.

### Near-complete generated Vulkan aggregate ABI

Exact hosted bitfield storage-unit packing plus checked byte, 16-bit,
binary32-bit, binary64-bit, and bitfield setters raise generated coverage to
1,448 of 1,450 Vulkan aggregates and 7,406 members. Consecutive 32-bit
bitfields share little-endian storage units with generated offsets and widths.
The canonical 64-byte acceleration instance proves 24/8 packing at byte 48
and its second pair at byte 52, including overflow rejection.

Declarator parsing now ignores bracketed or colon text inside XML comments,
restoring the common 64-byte `VkWriteDescriptorSet`. Explicit hosted width
mappings cover Xlib/XCB, 64-bit Win32, Fuchsia, Metal, and StdVideo external
enums; Xlib/XCB/Win32 surface-create layouts are 40 bytes. Only the two GGP
aggregates remain unsupported because `vk.xml` does not define their external
native token widths.

### Generated layouts in production device and descriptor paths

A compact manifest-selected schema now brings registry-derived layouts into
the production Vulkan driver without importing the complete opt-in raw schema.
It contains 16 device/feature/descriptor structures and 189 members. Missing or
duplicate manifest entries fail generation, and the offline fixture proves
byte-identical output across two runs.

Both headless and surfaced device creation use generated feature, queue, and
device layouts. Compute and general bind-group descriptor layout, pool,
allocation, image/buffer payload, pipeline-layout, push-range, and write paths
use generated member stores, including exact array strides. This replaces the
old 224-byte feature padding and 16-byte push-range padding with exact 220-byte
and 12-byte registry layouts. Named access fixed an incorrect legacy offset
for `shaderStorageImageExtendedFormats`, which had read and enabled the next
field instead.

Deterministic registry tests, headless and X11 Vulkan, normal and optimized raw
execution, Abla-only, core, and stripped-environment runtime linkage pass.
Runtime linkage resolves OpenGL and Vulkan directly with zero unresolved
dependencies.

### Allocation-free generated submission layouts

The production subset now contains 32 Vulkan structures and 275 members.
Alongside the cold inspection schema, generation emits direct numeric size,
structure-type, and member-offset constants. Typed pool/allocation/begin,
fence/semaphore/timeline, query, legacy submit, synchronization2 submit, and
memory-barrier builders use those constants without runtime schema parsing or
handwritten ABI offsets.

Timestamp queries, compute dispatch, texture and device transfer machinery,
asynchronous buffer/texture slots, pixel frames, and surfaced presentation now
share these builders. A first correct-output run exposed 19,584 warmed bytes
from generic string parsing; the direct generated form restores `live=0/0` for
OpenGL, Vulkan, and automatic buffer and texture transfer matrices while
retaining exact readback and stable handles.

The three compiler-heavy transfer gates use the established 8 GiB address-
space guard after the expanded source crossed their former 6 GiB limit.
Registry determinism, headless/X11 Vulkan, normal/optimized raw execution,
Abla-only, core, and stripped runtime linkage pass with zero unresolved shared
dependencies.

### Generated nested image transfer layouts

The production subset now contains 43 Vulkan structures and 335 members.
Generated nested writers compose image subresource ranges/layers, 3D offsets
and extents into exact image barriers, buffer-image regions, image copies,
blits, and resolves. Both legacy and synchronization2 barriers and every shared
buffer/image transfer path use direct generated constants and caller-owned
scratch storage, preserving allocation-free warmed execution.

The consolidated registry, buffer/texture/wider transfer, graph-command,
headless Vulkan, X11 Vulkan, normal/optimized raw-command, Abla-only, core, and
runtime-linkage gate passes. Buffer and texture matrices remain exact and
stable at `live=0/0`; 1,001-frame Vulkan graph loops remain `live=0`, and
runtime linkage reports `direct=true unresolved=0`.
