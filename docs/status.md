# Implementation status

Updated: 2026-08-19.

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
  24-byte record containing reflected location-zero `vec2` position and
  location-one `vec4` tint inputs. Reusable `BufferBytes.storeF32` encodes three
  colored vertices in Abla and uploads them to the common affine buffer. The
  strict pure-Abla `$glsl` emitter passes the color through a location-zero
  varying. OpenGL configures both attributes and draws from that buffer; Vulkan
  creates matching binding/attribute pipeline state and records
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
  and standard source-alpha blending. OpenGL reapplies the complete state before
  every draw; Vulkan bakes matching input-assembly, rasterization, and color-
  blend structures. The sample presents both blended triangle-list and
  line-strip/front-cull/clockwise pipelines under software OpenGL and
  validation-enabled Lavapipe, rejects an invalid topology before driver work,
  and retains the repeated-draw no-growth gate.
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
- General bind groups: `GraphicsBindGroup` accepts up to 16 unique set-zero
  entries spanning sampled textures, uniform buffers, and storage buffers with
  explicit vertex/fragment/compute visibility. Pipeline reflection matches the
  complete entry shape. OpenGL prepares texture/sampler/UBO/SSBO slot arrays;
  Vulkan owns per-texture views plus an aggregated descriptor pool, layout, and
  set. Application tests create a three-entry group on both backends and reject
  duplicate bindings and usage mismatches before driver work. The strict
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
  atlas, a vertex-visible std140 64-byte MVP uniform, and enabled less/depth-
  write state render unchanged through OpenGL and Vulkan. Four warmed frames
  update and upload the transform while preserving binding/pipeline handles
  with zero live-byte growth; the Lavapipe run is validation-clean.
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
  sampler anisotropy,
  then verifies the reported API version and driver limits. It rejects a
  storage buffer one byte above the reported range and a 2D texture one texel
  above the reported dimension before allocation. Explicit Vulkan
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
- Common affine buffer test: one `BufferDescriptor` creates an OpenGL buffer or
  Vulkan buffer/allocation after one-time backend selection; both paths pass
  checked nonzero-offset 64-bit write/read plus a 19-byte upload/readback between
  different CPU/GPU offsets. Pure tests cover default remaining-source size,
  zero size, and crossing source/destination bounds; application tests reject
  missing copy usage and an overflowing range. OpenGL uses direct buffer-subdata
  calls. Vulkan maps coherent memory from aligned offset zero and uses one
  buffer-owned output cell plus the Abla compiler's LLVM copy intrinsic, so
  repeated range transfers allocate no general memory. Four repeated
  upload/readback pairs on each backend produce zero Abla runtime live-byte
  growth. Invalid descriptors, mapped-at-creation rejection, and deterministic
  destruction also pass.
- Common GPU buffer-copy test: `GraphicsApplication.copyBuffer` validates
  distinct same-backend resources, source/destination copy usages, and both
  ranges before dispatch. A partial 31-byte copy between different offsets is
  read back exactly on OpenGL and Vulkan; crossing bounds and missing usages are
  rejected. OpenGL uses `glCopyBufferSubData`. Vulkan reuses one device-owned
  transfer pool, command buffer, and scratch ABI block, records
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
  buffer plus GPU copy/fill/readback under explicit OpenGL and Vulkan in the
  software-driver sample matrix. Four repeated upload, copy, fill, and readback
  cycles produce zero Abla runtime live-byte growth on both backends.
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
  constants, unary arity, and increment/decrement rejection. The bounded
  postfix form emits deterministic typed SSA operations plus `OpSelect`; a live
  override in an arithmetic/comparison/logical/select chain produces checked
  buffer output on OpenGL and Vulkan rather than merely proving pipeline
  creation. Integer conditions, Boolean branches, raw Boolean assignment, and
  mismatched logical operands are checked failures.
  Literal `true`/`false` and a single reflected Boolean specialization constant
  are first-class condition values. Deterministic modules use typed Boolean
  constant/spec-constant instructions; a default-false specialization overridden
  to true selects the checked result `7` after real OpenGL and Vulkan dispatch.
  Boolean arithmetic remains a checked type failure.
  All ten integer compound-assignment operators lower through the same typed
  token program. Tests prove `value += 2u` is byte-identical to its expanded
  form and cover shift/bitwise compound opcodes; increment/decrement and logical
  assignment remain rejected.
  A storage `main` now accepts a bounded sequence of up to 64 member assignments.
  Store tokens consume each typed postfix result before the next statement,
  retaining byte-identical output for every previous one-statement module. A
  three-statement unit shader emits three ordered stores. The live shader writes
  `tail = 6`, reads it in the following conditional, writes `output = 7`, and
  returns the exact packed high/low pair on both real drivers while preserving
  the separate initialized prefix.
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
  A strict audit join currently classifies 18 Vulkan and 15 OpenGL commands as
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

- Render-graph execution with per-subpass input/preserve attachment lists,
  arbitrary attachment routing and dependency masks, complete synchronization2
  barrier/event migration, and offscreen/MRT dynamic rendering. The delivered
  pure-Abla graph planner validates stable explicit dependencies, derives
  declaration-order read/write hazards, rejects cycles, computes scheduled
  lifetimes, emits pruned resource-specific barrier records, and aliases
  compatible non-overlapping transient allocations; it does not yet record
  backend commands or materialize those barriers/pools.
  Surfaced pipelines already use feature-gated dynamic rendering while the
  portable sequence currently gives every stage the target's complete
  color/depth/resolve attachment set and inserts
  fixed color-output dependencies. The initial raster pipeline,
  reusable clear, and pixel-upload paths honor the configured one-to-eight
  fence-guarded slots and have no per-frame queue-wide idle. Clear and pixel
  and render presentation recover once from suboptimal/out-of-date swapchains;
  render recovery rebuilds surface-dependent pipeline objects automatically.
- Wayland, Windows, or macOS platform modules.
- X11 compose/dead-key sequences, input methods, and additional XKB groups.
- Broad OpenGL buffer/texture/framebuffer/compute and extension coverage.
- Complete Vulkan feature-structure and OpenGL extension negotiation, optional
  feature preferences, broader per-stage limits, and typed extension objects.
  The current common capability report covers the initial seven-feature mask
  and ten directly queried limits documented in the API contract.
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
  metadata is reflected but not yet converted into compiler-verified host
  structure offsets.
  Reflected push constants are not yet wired into backend pipeline creation.
  Specialized compute workgroup IDs and fixed-workgroup scalar constants are
  wired through the portable descriptor on both backends. SPIR-V emission
  currently covers the strict no-op and precedence-parsed homogeneous scalar
  storage-block expression compute subsets plus fixed, interleaved position/color,
  and sampled-texture triangle vertex/fragment subsets described above, not
  general shaders.
- Callable generated bindings, compiler-verified host offsets, and fully
  classified coverage ledgers. The pinned deterministic inventory, strict
  evidence join, compiled raw metadata modules, complete selected OpenGL and
  Vulkan constant output, command signatures, and Vulkan aggregate declarations
  exist, with the initial 50 exercised common commands classified; all other
  rows deliberately remain `unclassified` until equivalent evidence is
  attached.
- General texture byte uploads/format-converting copies/render-pass use,
  persistent mapped-at-creation
  buffer ranges, queued uploads, device-local suballocation policy, command
  encoders/render
  graph,
  asset formats, or framework-wide performance gates. Partial RGBA/BGRA
  `PixelBuffer` uploads and synchronous diagnostic readback are present;
  general byte layouts, asynchronous image copies, and streaming are not.
  Same-format synchronous 2D image copies are present. General reusable buffer
  byte-range upload/readback is present, including
  distinct source and destination offsets; synchronous GPU buffer copies and
  aligned 32-bit pattern fills reuse backend command state. Persistent mapping
  and asynchronous transfers are not. Common buffers, textures, views,
  samplers, and immutable structural
  descriptors are present;
  the wider resource surface is not yet claimed.
- The complete sample catalog, driver/platform CI matrix, or tagged release.

These remain milestones in [the implementation plan](../plan.md); they are not
represented as delivered.
