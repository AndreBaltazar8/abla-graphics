# Abla Graphics implementation plan

Status: active implementation contract, 2026-08-26.

Abla Graphics is the graphics and windowing framework for the Abla ecosystem.
It targets OpenGL 4.6 core and Vulkan 1.4, with an idiomatic common API for
applications and generated raw APIs for features that cannot or should not be
hidden behind a common abstraction.

The plan is ordered. A milestone is complete only when its implementation,
tests, samples, documentation, and relevant performance/validation gates pass.

Current verified checkpoint: the Abla-only direct X11 foundation, surfaced and
headless OpenGL/Vulkan selection, common buffers/textures/views/samplers,
mapped-at-creation and checked post-creation buffer range mapping,
coherent persistent upload/readback mapping, bounded aligned transfer rings,
fixed-slot asynchronous buffer upload/readback queues, explicit host-visible
and device-local buffer placement, fixed-slot asynchronous RGBA/BGRA pixel and
pitched raw 1D/2D/array/cube/3D/BC1 texture upload/readback queues with
allocation-free primitive range calls,
portable 2D-array/cube/3D descriptors with dimension-resolved views,
overflow-checked pitched `TextureRegion`/`TextureDataLayout` footprints, BC1
RGBA linear/sRGB block metadata, live 1D/2D/3D/array/cube limit queries, native
wider image/view ownership, exact synchronous pitched raw upload/readback, and
same-format layered or physical-volume subresource copies,
target-aware full-resource `sampler2DArray`/`samplerCube`/`sampler3D` bindings
with matching strict deterministic SPIR-V and exact dual-backend sampling,
plus borrowed explicit sampled subresource/view bindings with exact selected
array-layer, cube-face, and volume-view evidence,
fixed-metadata device-local buffer
suballocation with generation-checked slice transfers and aligned
uniform/storage range binding plus generation-checked nonzero-offset surfaced
and offscreen target/pass vertex/index/direct-indirect pool rendering,
including reflected push-value forms, reusable
copies/fills/pixel
presentation, compute pipelines, strict initial
`$glsl`-to-SPIR-V subsets, and the first procedural, common-vertex-buffer, and
multi-attribute vertex, `uint32` indexed, and instanced render paths with
immutable topology, culling, winding, and alpha-blend state plus
dependency-ordered Vulkan resize recovery and per-swapchain-image depth
testing/writes plus general sampled-texture/uniform/storage bind groups and an
allocation-free transform-uniform indexed textured/depth cube sample plus
GPU-buffer-driven direct/indexed indirect draws and affine color render-target
ownership with allocation-free clear/readback plus procedural, direct,
indexed, instanced, bind-group, and GPU-indirect offscreen draws and sampled
fullscreen post-processing passes plus affine depth attachment ownership and
depth-tested offscreen pipelines plus reflected two-to-eight color render
targets combinable with depth and reusable per-attachment clear passes with
procedural, direct, indexed, and GPU-indirect encoding plus allocation-free
exact-output validation and portable per-attachment clear/load/discard and
store/discard operations plus render-attachment-only multisampled color/depth
texture and matching pipeline foundations plus allocation-free explicit
per-color resolve of single and multiple render targets into owned
single-sample textures plus affine target-owned automatic post-pass resolves
using reusable OpenGL blits or native Vulkan subpass resolve attachments plus
allocation-free GPU mip-chain generation with per-level Vulkan barriers plus
affine two-to-eight-stage procedural subpass sequences using native Vulkan
subpasses and explicit dependencies or ordered OpenGL FBO draws are
implemented, together with queried and explicitly enabled Vulkan 1.2 timeline
semaphores and allocation-free counter/signal/wait operations plus queried and
enabled Vulkan 1.3 synchronization2 with real `vkQueueSubmit2` transfer
submission and device-owned timeline completion instead of queue-wide transfer
idle plus zero-allocation `vkCmdPipelineBarrier2` memory and image transitions
on that reusable path, plus feature-gated surfaced dynamic rendering without
render-pass/framebuffer objects and with a legacy fallback, plus reusable
reflected push values wired to strict compute storage mutation and raster
procedural/vertex/indexed/direct-indirect/indexed-indirect offscreen and
presented commands plus matching reusable render-pass attachment operations on
both backends, including affine reflected per-pipeline values across native
Vulkan or ordered OpenGL procedural subpass sequences and a vertex-visible
push-offset transform plus a shared vertex/fragment offset-and-tint block with
exact shifted-position and color proof, backed by allocation-free typed
name/component/array-index writes plus reflected float/double matrix-coordinate
writes for ordinary and subpass values, and a typed bounded fragment
`vec4`/scalar expression IR emitting mixed reflected push layouts, typed
push/input loads and literals, location-based fragment interfaces, and
precedence-ordered equal-type or vector-times-scalar floating operations plus
exact vector/scalar division, including input-free/push-free constant fragments,
typed unary signs, and deduplicated scalar-splat `vec4` constructors without
fixed SPIR-V templates, plus one-to-eight independently typed fragment output
writes, exact-bit module-wide float constant interning, and storage-free ordered
immutable or SSA-rebound mutable scalar/vector locals with typed floating
compound assignment, standalone prefix/postfix updates, left-to-right comma
declarators, typed single-component vector selection, four-component vector
permutation, runtime one-/four-scalar `vec4` construction, typed vector dot
products, and conditionally imported floating `min`/`max`/`clamp` plus unary
`abs`/`floor`/`ceil`/`sqrt`/`inversesqrt` and `mix`/`step`/`smoothstep`.
Rounding, fraction/sign, angle/trigonometric, inverse/hyperbolic, exponential/
logarithmic, unary/binary `atan`, `pow`, and `fma` share that typed path. Vector
geometry `length`/`distance`/`normalize`/`faceforward`/`reflect`/`refract` calls
use exact scalar/vector result and operand rules; scalar/vector floating `mod`
emits core `OpFMod` with vector/scalar divisor splatting. `min`/`max` and `clamp`
also support exact vector/scalar overloads through typed splats, as do
scalar-factor/edge `mix`/`step`/`smoothstep` forms. Core fragment
`dFdx`/`dFdy`/`fwidth` derivatives preserve scalar/vector types; fine/coarse
variants conditionally declare `DerivativeControl`. Repeated clear, pixel,
transfer, compute, event-poll, and triangle hot paths have stable native
handles and zero runtime live-byte growth. The remaining milestone work below
is intentionally still open.

Width-aware raster local vectors now conditionally emit `vec2` and `vec3` types
without perturbing established `vec4` modules. Their exact-width and scalar-splat
constructors, equal-width arithmetic and dot products, scalar mixed operations,
derivatives, checked components, width-preserving extended operations, and
`vec3`-only `cross` compose into existing `vec4` outputs. Narrow fragment
push members preserve reflected alignment and feed typed loads; the live
`push-color` proof uses `vec3` plus scalar data across all 16 render forms.
Fragment location inputs now emit width-specific `vec2`/`vec3`/`vec4` pointer,
variable, and load types, including mixed-width modules. The live
`narrow-input` sample proves interpolated `vec2` data on both backends; fragment
color outputs remain `vec4`.

Raster selectors now emit width-matched `vec2`, `vec3`, or `vec4`
`OpVectorShuffle` results for two- to four-component selectors. Source-width
checks reject invalid lanes while permitting repetition; the live narrow-input
sample executes `.yx` without changing its dual-backend proof.

Fragment color outputs now emit width-specific `vec2`, `vec3`, or `vec4`
Output pointer, variable, and store types, including mixed narrow MRT modules
and exact expression-width rejection. Native attachment semantics for omitted
components are verified by the live `vec3` output proof on both backends: RGBA8
receives RGB and a zero alpha component.

The optional materialized render graph now also has a bounded reusable command
slice. An affine fixed-capacity list records exact scheduled pass markers,
graph-owned transient texture copies, typed procedural, direct/indexed, and
vertex-/indexed-indirect offscreen renders, depth targets across every form,
single-color multisample resolve targets with planner-visible source/output,
procedural and buffered two-to-eight-color targets with ordered resolves and
optional depth,
procedural subpass targets with owned compatible passes and ordered affine
pipeline sequences,
planner-visible color/depth identities, and planner-visible imported or
graph-owned multi-buffer compute dispatches, all with copied reflected push
bytes in preallocated storage. It affinely owns render and compute resources,
validates and fingerprints the whole stream at seal, and binds imported typed
texture/buffer descriptors plus physical identities. The logical buffer's
read/write-to-read use derives a real backend barrier. Eligible Vulkan streams
encode their barriers, copy, render, and compute work in a bounded
`framesInFlight` ring and submit once per complete replay without waiting after
queue acceptance; exact timeline values guard slot reuse and command-list
retirement under the graph-outlives-list-and-pending-work ownership contract.
OpenGL preserves ordered direct replay. Exact
OpenGL/Vulkan/auto tests cover incompatible resource/graph and post-seal
mutation rejection, abort/recovery, 1,001 successful allocation-free replays,
stable native objects, exact render/copy/storage output, submission counts, and
silent Vulkan validation. Portable R8/RG8/RGBA8, 16-bit float, and 32-bit float
Storage images are format- and dimension-reflected across 1D, 2D, 2D-array,
3D, and cube bindings, including validated explicit one-mip views. Retained
R32F compute and RGBA8 write-only/read-write compute execute through native
OpenGL image units and Vulkan storage-image descriptors in `GENERAL`;
fragment-stage RGBA8 stores are independently live. Exact 2D-array and 3D
stores plus exact 1D and cube stores have dual-backend retained replay and
subresource-readback evidence. Cube-storage capability is separately queried
and enabled on Vulkan. A generated typed push-expression form derives signed
coordinate width from every supported image dimension, consumes reflected
layout offsets/names, and writes a runtime `vec4` value. Generated read/write
composition additionally seeds `imageLoad` into the shared typed expression IR
and lowers precedence-aware, parenthesized vector add/subtract/multiply/divide
through as many as fifteen further named SSA locals into `imageStore`. The same
emitter handles scalar/`vec4` literals and constructors, components, vec4
swizzles, dot products, and typed extended builtins with vector/scalar splats.
Load/store coordinates use a separate signed integer postfix IR with scalar or
dimension-matched vector locals, constructors, components, unary signs, and
precedence-aware arithmetic. Broader expression grammar, bind-group subpass
records, and broader compute forms remain milestone 5 work.

## Non-negotiable design rules

1. Application state, rendering policy, resource ownership, shader declarations,
   and command construction are Abla code.
2. Framework and platform implementation is Abla-only. There is no C/C++/Rust
   shim and no GLFW/SDL dependency. Abla marshals operating-system and graphics
   driver ABI layouts directly through typed unsafe platform modules.
3. Every GPU/window object has explicit ownership. Abla `resource class` values
   perform deterministic destruction and cannot be copied accidentally.
4. Backend dispatch occurs outside hot draw loops. Backend-specific command
   encoders may specialize the common API after device creation.
5. A successful call is not assumed. Fallible operations return structured
   results, and optional functionality is guarded by queried capabilities.
6. The steady-state frame path performs no general heap allocation. Frame-local
   command data comes from reusable arenas and bounded pools.
7. The common API covers portable intent. `graphics/raw/opengl` and
   `graphics/raw/vulkan` expose specification-level escape hatches.
8. Generated registry files are reproducible, version-stamped, reviewed through
   compact manifests, and never edited by hand.
9. Debug builds favor validation and precise errors. Release builds remove
   validation branches that are proven redundant without changing semantics.
10. Claims require evidence: compiler tests, native tests, API validation,
    rendered-output checks, and repeatable benchmarks where applicable.

## Milestone 0 - repository and contracts

- Establish the MPL-2.0 package, source-only Git hygiene, CI skeleton, pinned
  Nix development environment, contributor guide, security policy, and version
  policy.
- Publish the architecture and public API contract before expanding the code.
- Add a Khronos registry importer design with pinned OpenGL/Vulkan registry
  revisions and deterministic output checks.
- Add test/build entry points that work from this checkout with `../ablac`.
- Ensure executables built in the pinned Nix environment retain their concrete
  loader-library locations and launch directly without the development shell's
  `LD_LIBRARY_PATH`; gate this with an unresolved-dependency audit and a live
  combined-backend executable.

Exit gate: a clean checkout can run the pure Abla contract and platform ABI
suites; repository metadata contains no non-Abla implementation source or
generated binaries.

## Milestone 1 - core, windowing, and headless execution

- Implement scalar/vector/matrix/color/rectangle primitives and overflow-safe
  size/range helpers.
- Implement `GraphicsConfig`, backend selection, adapters, feature/limit queries,
  structured errors, logging, and debug labels.
- Implement `Window`, event polling/waiting, keyboard, text, pointer, scroll,
  resize, focus, close, clipboard, cursor, monitor, DPI, fullscreen, and timing.
- Implement Linux X11 and Wayland wire protocols, event queues, and surfaces in
  Abla over OS sockets/syscalls; add equivalent Win32 and Cocoa platform modules
  in Abla. Headless surfaces are first-class for tests and servers.
- Implement deterministic resource IDs, parent/child lifetime validation, and
  debug leak reporting.

Exit gate: window/event samples pass under a real session and Xvfb; a headless
probe runs without a display; continuous create/destroy stress is leak-free.

## Milestone 2 - OpenGL 4.6 core backend

- Load core/extension entry points per context and expose exact capability data.
- Implement contexts, swap interval, debug callbacks, buffers, textures,
  samplers, shaders/programs, vertex input, framebuffers, renderbuffers, queries,
  synchronization, compute, image load/store, indirect draws, transform feedback,
  tessellation, geometry shaders, sparse/bindless/vendor features when present,
  and robust context reset handling.
- Use direct-state-access paths where supported and cache only state that avoids
  measured driver calls without making external raw calls incorrect.
- Generate `graphics/raw/opengl` from the official registry, including extension
  constants, layouts, and commands supported by the Abla driver ABI modules.

Exit gate: the common sample suite renders on OpenGL, Khronos validation/debug
output is clean, and raw coverage matches the pinned registry manifest.

## Milestone 3 - Vulkan 1.4 backend

- Implement loader/instance/device selection, queue planning, surfaces,
  swapchains, synchronization2, timeline semaphores, dynamic rendering, command
  pools/buffers, descriptors, pipeline layouts/caches, buffers/images/views,
  memory allocation, transfers, queries, compute, indirect work, and debug utils.
- Implement frames-in-flight, swapchain recreation, staging rings, transient
  pools, dedicated allocations, memory-budget reporting, and device-loss errors.
- Cover Vulkan 1.4 core, promoted features, and extension negotiation without
  silently enabling unsupported behavior.
- Generate `graphics/raw/vulkan` from `vk.xml`, including types, flags, structure
  builders, commands, feature chains, and extension metadata.

Exit gate: headless and surfaced Vulkan samples pass with validation enabled;
the common golden-image suite matches OpenGL within documented tolerances; raw
coverage matches the pinned Vulkan registry manifest.

## Milestone 4 - shaders as an Abla language feature

- Implement an Abla-defined `$glsl` subparser supporting GLSL 4.60 syntax,
  stages, includes/modules, source spans, diagnostics, and safe Abla constant
  interpolation.
- Reflect vertex inputs, descriptor/binding declarations, push constants,
  uniforms, fragment outputs, specialization constants, and workgroup sizes.
- Validate reflected interfaces against Abla pipeline descriptions at compile
  time when static and at creation time otherwise.
- Produce OpenGL GLSL and Vulkan SPIR-V deterministically. Cache by compiler,
  target, source, defines, include graph, and optimization/debug profile.
- Preserve `ShaderSource` and raw SPIR-V entry points for generated or external
  shader toolchains.

Exit gate: valid multi-stage shaders compile for both backends; malformed syntax
and interface mismatches report original Abla spans; repeated builds are byte
identical.

## Milestone 5 - portable rendering API and performance layer

- Implement immutable descriptors plus resource classes for buffers, textures,
  samplers, bind groups, shader modules, pipelines, surfaces, and query sets.
- Implement render/compute passes, copies, barriers, indirect commands, instancing,
  multiple render targets, depth/stencil, blending, multisampling, mip generation,
  timestamps, and debug groups.
- Add streaming upload/readback rings, transient render targets, pipeline cache
  persistence, texture/buffer suballocation, descriptor reuse, and frame pacing.
- Add an optional render graph that derives lifetimes/barriers/aliasing while
  preserving direct encoders for applications that need exact ordering.
- Make backend-native handles available only through explicit unsafe/raw modules.

Exit gate: zero steady-state general allocations in representative scenes;
submission scales with command count; CPU/GPU timing and memory metrics are
reported by repeatable benchmarks.

## Milestone 6 - advanced specification coverage

- Add geometry/tessellation, mesh/task when exposed, ray tracing, acceleration
  structures, variable-rate shading, multiview, sparse resources, external
  memory/semaphores, video queues, protected content, device groups, calibrated
  timestamps, shader objects, and vendor extensions behind capability types.
- Maintain a generated coverage ledger mapping every pinned core command and
  extension to common, raw, intentionally unsupported, or platform-inapplicable.
- Never claim support solely because a token exists; each supported family needs
  a loader path, ABI path, positive test, and unsupported-path test.

Exit gate: there are no unclassified items in either registry coverage ledger.

## Milestone 7 - samples and learning path

Every sample is small, documented, independently buildable, and runs on both
backends unless it demonstrates a backend-specific feature:

1. window and input inspector;
2. clear color and animated triangle;
3. indexed textured cube with depth;
4. camera, meshes, materials, and glTF scene;
5. instancing and indirect drawing;
6. render-to-texture and post-processing;
7. compute particles;
8. shadow mapping and HDR/PBR lighting;
9. deferred renderer/render graph;
10. UI overlay and text rendering;
11. multi-window and multi-monitor;
12. headless image generation;
13. GPU queries/profiler;
14. raw OpenGL feature lab;
15. raw Vulkan feature lab;
16. ray tracing when available;
17. boids/particle stress benchmark;
18. complete small 2D game;
19. complete small 3D application;
20. Abla Mobile/native surface integration proof.

Exit gate: sample matrix builds in CI, smoke samples run headlessly, surfaced
samples have local test scripts, and golden outputs are versioned intentionally.

## Milestone 8 - optimization, portability, and releases

- Benchmark startup, shader compilation, resource creation, upload bandwidth,
  draw/dispatch submission, frame pacing, and memory on discrete/integrated/CPU
  adapters where available.
- Profile before changing hot paths; retain benchmark evidence and regression
  thresholds. Use batched ABI calls only where measurements justify them.
- Add Linux, Windows, and macOS CI/builds; document OpenGL/Vulkan availability
  and portability extensions rather than pretending every backend exists equally.
- Verify release artifacts on clean runner environments, including direct
  executable launch and complete shared-library/driver-loader discovery rather
  than accepting binaries that only run inside a development shell.
- Fuzz shader parsing, descriptors, events, registry generation, and driver ABI
  boundaries. Run sanitizers and Vulkan validation in dedicated jobs.
- Publish packages and signed source releases only after API compatibility,
  license, generated-source, and clean-tree checks pass.

Exit gate: versioned release checklist passes and the GitHub repository is
published at `AndreBaltazar8/abla-graphics` with reproducible source artifacts.

## Definition of done

The long-term goal is complete when the common API is pleasant for ordinary
applications, both production backends pass the shared conformance/sample suite,
the raw coverage ledger classifies the complete pinned specifications, `$glsl`
provides source-accurate deterministic shader builds, performance gates pass,
and clean source releases are reproducible on every supported platform.
