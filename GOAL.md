# Abla Graphics continuation goal

Updated: 2026-08-24 (Europe/Lisbon).

This is the operational handoff for the next person continuing Abla Graphics.
Read this file first, then `plan.md`, `docs/status.md`, and `docs/api.md`. The
repository contains many working vertical slices, but the framework is not
finished and must not be presented as complete.

The persistent goal is active. Its objective is to complete every item in
`plan.md`, not merely the next checkpoint. This handoff was refreshed before
any wider-texture implementation edit was made, so the next person can begin
from a clean published tree.

## Product goal

Build and publish `AndreBaltazar8/abla-graphics`: the Abla ecosystem's native
graphics and windowing framework. It must provide:

- a small, idiomatic common Abla API for real applications;
- optimized OpenGL 4.6 core and Vulkan 1.4 backends without hiding capabilities
  needed for high-performance or advanced rendering;
- direct Abla implementations of native window creation, events, surfaces,
  contexts, and lifetime management—the facilities on which GLFW-like
  libraries rely;
- generated raw OpenGL/Vulkan declarations and an audited path to broad or full
  specification coverage;
- an Abla `$glsl` subparser, deterministic shader generation, reflection, and
  precise source diagnostics;
- extensive examples, conformance tests, performance gates, and reproducible
  releases on supported platforms.

The exact implementation contract and definition of done are in `plan.md`.
This is a persistent goal: continue through coherent, tested, reviewable
slices. Do not mark it complete while any item in that definition remains open.

The `abla-doom` homage side quest is already complete and published. Its clean
proof screenshot is `../abla-doom/screenshots/abla-doom.png`; do not modify that
project unless a later request expands its scope.

## Absolute constraints

- All framework, window/platform, backend, shader, ABI-layout, and sample
  implementation code must be Abla. No C, C++, Rust, or generated-C fallback.
- Do not use GLFW, SDL, Xlib/XCB implementation code, `libwayland-client`, or
  another native shim. Direct calls from Abla to OS/compositor/driver ABIs are
  allowed and expected.
- Use Abla's advanced features where they improve the design: affine
  `resource class` ownership, deterministic/idempotent cleanup, subparsers,
  comptime/reflection facilities, and checked native ABI declarations.
- Keep backend selection outside hot paths. Repeated frame, transfer, and
  command loops should preserve native handles and allocate no general heap
  memory.
- A generated token/declaration is not feature support. Supported command
  families require a loader/ABI path, positive live evidence, and validation or
  unsupported-path evidence.
- Generated registry files are reproducible outputs. Edit their audit manifests
  or generators, then run `make update-registry`; do not hand-edit generated raw
  bindings or coverage reports.
- `../ablac` may be changed when the language/compiler genuinely requires it.
  Preserve unrelated work, test and commit it independently, push it first,
  then publish the dependent graphics change.
- Preserve unrelated worktrees. Stage explicit paths, inspect the staged diff,
  and verify the local and remote commit IDs after every push.

## Repository state at handoff

Graphics repository:

- path: `/home/andre/Desktop/projects/abla-graphics`
- remote: `git@github.com:AndreBaltazar8/abla-graphics.git`
- branch: `main`
- synchronized published base when this refresh began:
  `c092194a2fbadca0cba3985b1a653da90a10b8eb`
- last implementation checkpoint:
  `a99cf7af8faf7fb4e021cdda629d4b98a9ca9ce5`
- `c092194` changes only the previous handoff; there are no later implementation
  edits
- the tree was clean and synchronized immediately before this refresh; the
  refresh commit will naturally be a handoff-only successor, so use the commands
  below for the current commit instead of embedding a self-referential hash here

Compiler repository:

- path: `/home/andre/Desktop/projects/ablac`
- remote: `git@github.com:AndreBaltazar8/ablac.git`
- branch: `master`
- local/upstream commit:
  `359749679844b1f3325512ea369aa46bd716b01e`
- clean at handoff; no compiler change is currently needed or authorized by an
  observed compiler defect

Recheck all of this rather than assuming it is still current:

```bash
git status --short
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git -C ../ablac status --short
git -C ../ablac rev-parse HEAD
git -C ../ablac rev-parse '@{upstream}'
```

## Last published checkpoint

The last implementation commit is `a99cf7a` (`Add fixed-slot async texture
transfers`). It adds allocation-free streaming paths for portable RGBA8/BGRA8
2D texture upload and readback on both production backends.

Published behavior:

- `src/texture_transfer.ab` exposes fixed-capacity one-to-eight-slot upload or
  readback queues, generation tickets, poll/wait/wait-all, immutable descriptor
  conveniences, and primitive `...TextureRange` hot paths;
- each queue reuses one coherent persistent mapped staging allocation and the
  existing per-slot OpenGL sync or Vulkan command-pool/command-buffer/fence
  state; enqueue never waits for a busy selected slot;
- OpenGL performs real pixel unpack/pack buffer transfers and `GLsync`
  completion; Vulkan records buffer/image copies, per-mip layout transitions,
  a transfer-to-host readback barrier, and fence-backed completion without
  queue/device-wide idle;
- CPU `PixelBuffer` data remains RGBA while mapped staging uses native RGBA or
  BGRA channel order. Upload and readback both preserve exact pixels;
- descriptor overloads are concise for setup. Primitive range overloads avoid
  Abla immutable-class value-copy allocation and are the explicit streaming
  path; repeated measured loops report zero live-byte growth;
- `tests/texture_transfer/main.ab` submits two operations before waits, checks
  exact RGBA and BGRA regions, capacity rejection, stale generations, stable
  staging/command handles, and zero live growth on OpenGL, Vulkan, and auto;
- `examples/async-texture` submits three complete frames before waiting,
  reads the final BGRA image back exactly, performs 12 allocation-free repeated
  uploads, and runs under both explicit backends in the sample matrix;
- the pre-existing asynchronous buffer queue regression still passes exact,
  stable, zero-growth behavior after the Vulkan slot scratch expansion;
- The strict registry coverage remains 97 OpenGL plus 113 Vulkan common
  commands, 210 total.

The following gates passed on the final published source on 2026-08-24:

```bash
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

Those results apply to the final source in `a99cf7a`. `../ablac` was not changed.

Earlier published foundations include explicit device-local buffer placement,
fixed-metadata buffer suballocation, generation-checked async slice transfer,
aligned uniform/storage range bindings, fixed-slot asynchronous upload and
readback queues, persistent mapping/rings, common OpenGL/Vulkan resources,
offscreen targets/passes, push values, compute, X11/Wayland/headless platform
paths, and the currently documented strict `$glsl` subset. Consult
`docs/status.md` for claim-level detail and evidence.

## Recommended next checkpoint: wider texture subresources

The next coherent slice should expand the texture model beyond single-layer 2D
RGBA8/BGRA8. Prioritize 2D arrays, cube maps, and 3D textures with explicit
layer/depth origins and extents, row/image pitch, and the first compressed
format family. Carry that shape through creation, views, synchronous copies,
asynchronous queues, bind groups, `$glsl` reflection, and both native backends.

Do not merely add enum values. Required evidence includes overflow-safe
descriptor validation, backend limit/capability checks, OpenGL target and pixel
store handling, Vulkan image/view types and buffer-image-copy layouts,
per-subresource Vulkan layout tracking, exact positive readback where portable,
negative crossing/pitch/format cases, stable handles, zero-growth repeated
range operations, and independently buildable array/cube or volume samples.

Device-local texture memory suballocation remains a separate allocator design
problem. OpenGL generally owns opaque texture storage while Vulkan exposes
image-memory binding, so define portable application intent (atlas, array,
transient aliasing, or native memory suballocation) before choosing an API.

## Exact continuation point

Implementation is paused before the wider-texture slice. No source file has
been edited for it. The initial read-only audit established the following
current assumptions and pressure points:

- `TextureDescriptor` and `TextureViewDescriptor` already contain dimension,
  depth/layer, mip, and view-range fields, but `GraphicsApplication.texture`
  rejects every dimension except 2D and the transfer/copy descriptors expose
  only `x`, `y`, `width`, and `height`;
- `Extent3D.depth` can remain the public third extent, but its meaning must be
  explicit: physical depth for 3D textures and array-layer count for 2D arrays
  and cube textures. Mip reduction applies to physical 3D depth, never to array
  layer count;
- default views currently assume 2D. They need to resolve their dimension from
  the parent texture, validate compatible 2D/2D-array/cube/3D combinations, and
  distinguish a 3D depth slice from an array layer;
- the OpenGL backend creates and binds only `GL_TEXTURE_2D` or multisample 2D,
  writes only with `glTexSubImage2D`, and aliases full views. Wider support needs
  audited 3D/array/cube targets, immutable storage, real owned texture views,
  correct pixel-store state, and target-aware bind-group application;
- the Vulkan backend currently creates one-layer images/views, records 2D
  buffer-image regions, and stores one layout per mip. Arrays and cubes require
  correct image flags/view types/layer counts and layout tracking per mip and
  array layer; 3D textures keep one array layer and a shrinking depth extent;
- `GraphicsLimits` only exposes the 2D texture limit. Query and publish the 1D,
  3D, cube, and array-layer limits on both backends before accepting the new
  descriptors;
- sampled binding reflection treats only `sampler2D` as a texture. It must
  distinguish and validate `sampler2D`, `sampler2DArray`, `samplerCube`, and
  `sampler3D`, then carry the correct target/type through OpenGL and Vulkan;
- the current async texture queues are deliberately RGBA/BGRA 2D. Preserve
  those convenience calls, tickets, fixed slot storage, stable handles, and
  zero-growth primitive paths while adding a raw byte/layout/region path;
- generated raw declarations do not count as backend support. Any newly used
  OpenGL entry point must be added through `registry/audit/opengl.tsv`, tested,
  regenerated, and reflected in the coverage ledger.

The provisional portable API shape from the audit is:

- add explicit 2D-array and cube dimensions while retaining 1D, 2D, and 3D;
- add a texture subresource region containing mip, `x/y/z`, and
  `width/height/depth`, plus a data layout containing byte offset,
  `bytesPerRow`, and `rowsPerImage`;
- keep `PixelBuffer` as the ergonomic uncompressed 2D RGBA convenience and use
  `BufferBytes` for pitched, layered, volume, and compressed transfers;
- introduce BC1 RGBA UNORM and sRGB as the first compressed family, together
  with format block-width, block-height, bytes-per-block, and overflow-safe
  footprint helpers;
- use immutable OpenGL texture storage so real `glTextureView` objects and
  compressed allocation share one correct storage model;
- make primitive region/layout overloads the measured hot path; descriptor
  wrappers may remain setup conveniences.

These are design conclusions, not implemented promises. Before coding, verify
the exact Khronos constants and entry-point requirements from the pinned
registry, settle descriptor names in `src/resources.ab`, and write core
positive/negative validation cases. Then implement in this order:

1. portable dimensions, format/block helpers, regions, layouts, view rules,
   limits, and overflow-safe tests;
2. OpenGL/Vulkan creation and view ownership, followed by synchronous raw
   upload/readback/copy paths and exact live tests;
3. target/type-aware bind groups and `$glsl` reflection/SPIR-V support for
   array, cube, and 3D sampling;
4. fixed-slot asynchronous raw transfers without regressing the existing 2D
   convenience or allocation behavior;
5. independently buildable array/cube/volume samples, documentation, registry
   regeneration, and the complete publication gates.

Do not quietly reduce this checkpoint to creation-only enums. If the whole
slice becomes too large for one reviewable commit, split it at the numbered
boundaries and keep each published commit truthful about what is live-tested.

## Files to care about

Primary implementation and composition:

- `src/texture.ab` — portable descriptors, checked texture byte operations,
  layouts, and ownership;
- `src/texture_transfer.ab` — delivered async queue surface and native-order
  staging conversion; extend without regressing primitive range allocation;
- `src/transfer.ab` — established ticket, slot, generation, poll, and wait API;
- `src/driver/opengl_transfer.ab` and `src/driver/vulkan_transfer.ab` — reusable
  buffer transfer slot implementations to extend or factor carefully;
- `src/driver/opengl.ab` and `src/driver/vulkan.ab` — existing synchronous image
  copy/layout/barrier machinery;
- `src/resources.ab` — current texture descriptors, dimensions, formats, view
  rules, and transfer/copy validation; start the portable design here;
- `src/core.ab` — portable limits and the backend capability contract;
- `src/binding.ab` — reflected sampled-texture compatibility and bind-group
  payloads;
- `src/shader/glsl.ab` and `src/shader/glsl_spirv.ab` — sampler reflection and
  deterministic SPIR-V image/sampling types;
- `src/graphics.ab` — public module composition when surfaces change.

Live evidence and samples:

- `tests/application/main.ab` — existing broad texture validation/output proof;
- `tests/transfer/main.ab` and `tools/test-transfer.sh` — established queue
  invariants and output conventions;
- `tests/texture_transfer/main.ab` and `tools/test-texture-transfer.sh` — exact
  async RGBA/BGRA, generation, stable-handle, and zero-growth proof;
- `examples/common-texture/main.ab` and `examples/async-texture/main.ab`;
- `tools/test-samples.sh` and each affected example's `abla.toml`.

Public claims and generated coverage:

- `README.md`, `docs/api.md`, `docs/status.md`, `plan.md`, `GOAL.md`;
- `registry/audit/opengl.tsv`, `registry/audit/vulkan.tsv`;
- `registry/coverage/opengl.md`, `registry/coverage/vulkan.md` and generated
  `src/raw/*_registry.ab` outputs.

Build discipline:

- `Makefile` is the authoritative gate map;
- `tools/check-abla-only.sh` must continue to prove the no-C constraint;
- do not add build/cache artifacts to Git.

## Verification commands

Use the repository's Nix environment. Start focused, then run the complete
release and independent-sample gates:

```bash
nix-shell --run 'make test-core test-transfer test-texture-transfer'
nix-shell --run 'make test-application'
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

`make all` includes the Abla-only audit and the core, platform, OpenGL, Vulkan,
window, `$glsl`, application, buffer-transfer, texture-transfer, pool, debug,
and registry tests. Do not replace it with only focused checks before
publication. `make test-samples` performs the independent no-cache sample
build/live matrix and is also required.

Before committing:

```bash
git status --short
git diff --check
git diff --stat
git diff -- <explicit paths>
git add <explicit paths>
git diff --cached --check
git diff --cached --stat
git diff --cached -- <explicit paths>
```

After pushing:

```bash
git fetch origin main
git rev-parse HEAD
git rev-parse origin/main
git status --short
```

## Major remaining framework work

`plan.md` remains authoritative. The largest open areas are:

- device-local texture suballocation, wider asynchronous image transfer, reusable
  command encoders, transient resources, descriptor reuse, render-graph
  scheduling/barriers/aliasing, and persistent pipeline caches;
- fuller texture formats/layouts/conversion, query resolution, advanced
  render/compute pass combinations, and device-loss/context-reset recovery;
- the remaining GLSL 4.60 grammar/stages/modules/includes, diagnostics,
  reflection/interface validation, deterministic OpenGL GLSL/Vulkan SPIR-V,
  and shader caching;
- generated callable raw bindings and classification of every pinned OpenGL and
  Vulkan core/extension entry, with capability-gated advanced families;
- pure-Abla Win32 and Cocoa platform/window/surface backends and real Linux,
  Windows, and macOS CI;
- advanced geometry/tessellation, mesh/task, ray tracing, multiview, VRS,
  sparse/external resources, video, device-group/protected work, calibrated
  timestamps, shader objects, and relevant vendor extensions;
- the planned sample catalog: glTF/materials/camera, post-processing,
  particles, shadows/HDR/PBR, deferred rendering, UI/text, multi-window,
  profiler, raw backend labs, stress benchmarks, complete 2D/3D apps, and
  Abla Mobile/native-surface proof;
- repeatable performance thresholds for startup, shader compilation, resource
  creation, transfer/submission, frame pacing, GPU time, and memory, plus
  fuzzing, validation jobs, and reproducible signed releases.

## Publication rule

The GitHub repository receives verified incremental checkpoints, but it must not
be called feature-complete until `plan.md`'s full definition of done passes.
Each published slice should contain its implementation, positive and negative
tests, live OpenGL/Vulkan evidence, registry evidence where applicable,
documentation, and a clean synchronized remote state.

If an `ablac` change becomes necessary, prove the compiler issue first. Then
test, explicitly stage, commit, and push only the compiler-owned change before
publishing the dependent `abla-graphics` commit.
