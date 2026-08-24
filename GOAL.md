# Abla Graphics goal and continuation handoff

Updated: 2026-08-24 (Europe/Lisbon).

This is the operational handoff for the next person continuing Abla Graphics.
Read this file first, then `plan.md`, `docs/status.md`, and `docs/api.md`.

The framework is a large, active work in progress. It has many verified vertical
slices, but it is not feature-complete and must not be described or released as
such. The persistent goal remains active until the complete definition of done
in `plan.md` is satisfied.

## The goal

Build and publish `AndreBaltazar8/abla-graphics`, the native graphics and
windowing framework for the Abla ecosystem. It must eventually provide:

- a small, idiomatic common Abla API suitable for real applications;
- optimized OpenGL 4.6 core and Vulkan 1.4 backends without hiding the native
  capabilities advanced applications need;
- the native window, input, event, surface, context, monitor, clipboard, cursor,
  DPI, and fullscreen facilities on which a GLFW-like library would normally
  rely;
- generated and audited raw OpenGL and Vulkan APIs with broad, ultimately
  classified specification coverage;
- an Abla `$glsl` subparser with deterministic OpenGL GLSL and Vulkan SPIR-V
  generation, reflection, interface validation, and source-accurate errors;
- explicit affine ownership, predictable cleanup, structured errors, queried
  capabilities, and zero general heap allocation in steady-state hot paths;
- a broad catalog of independently buildable examples, golden-output tests,
  performance gates, validation jobs, cross-platform support, and reproducible
  releases.

`plan.md` is the authoritative implementation contract and full roadmap. A
milestone is complete only when its implementation, tests, samples,
documentation, and relevant performance/validation gates all pass.

## Non-negotiable constraints

- All framework, platform/window, graphics-backend, shader, ABI-layout, test,
  and sample implementation source is Abla. Do not add C, C++, Rust, or a
  generated-C fallback.
- Do not use GLFW, SDL, Xlib/XCB implementation code, `libwayland-client`, or a
  similar native shim. Abla must call the OS, compositor, and graphics-driver
  ABIs directly.
- Direct native ABI declarations and calls from Abla are allowed and expected.
  This is how the implementation reaches X11, Wayland, Win32, Cocoa, OpenGL,
  and Vulkan while remaining Abla-only.
- Use Abla's advanced language facilities when they improve correctness or the
  API: affine `resource class` ownership, deterministic and idempotent cleanup,
  subparsers, compile-time/reflection facilities, and checked native layouts.
- Keep backend selection out of hot loops. Repeated frame, transfer, and command
  paths should keep native handles stable and allocate no general heap memory.
- A generated declaration is not feature support. A supported command family
  needs a loader path, correct ABI, positive live evidence, and rejection or
  unsupported-path evidence.
- Generated registry files are reproducible output. Change an audit manifest or
  generator and run `make update-registry`; never hand-edit coverage reports or
  `src/raw/*_registry.ab`.
- `../ablac` may be changed only when a real compiler/language need is proven.
  Preserve unrelated changes, test it, commit and push its narrowly scoped
  change first, and only then publish dependent `abla-graphics` work.
- Preserve unrelated worktrees. Stage explicit paths, inspect the staged diff,
  and confirm local/upstream commit IDs after pushing.

## Current repository state

### `abla-graphics`

- Path: `/home/andre/Desktop/projects/abla-graphics`
- Remote: `git@github.com:AndreBaltazar8/abla-graphics.git`
- Branch: `main`
- Current implementation checkpoint:
  `569107ea280198f08c116d164cbdd4fb1a491754`
  (`Add pitched wider texture transfers`)
- Previous native wider-resource checkpoint:
  `24fa2967e6c7a77f6cbcbd1e13c95487a6488a3c`
- This document is committed as a handoff-only successor to `569107e`, so use
  `git rev-parse HEAD` rather than embedding its self-referential commit here.
- The implementation and handoff commits are intended to be pushed together.
  The worktree should be clean and synchronized after publication; recheck it
  before continuing because the filesystem and remote are authoritative.

### `ablac`

- Path: `/home/andre/Desktop/projects/ablac`
- Remote: `git@github.com:AndreBaltazar8/ablac.git`
- Branch: `master`
- Local/upstream tip at this handoff:
  `359749679844b1f3325512ea369aa46bd716b01e`
- It is clean and synchronized. The current graphics slice required no compiler
  change.

Verify rather than assuming these snapshots are still current:

```bash
git status --short --branch
git rev-parse HEAD
git rev-parse origin/main
git -C ../ablac status --short --branch
git -C ../ablac rev-parse HEAD
git -C ../ablac rev-parse '@{upstream}'
```

## Previous native wider-resource baseline

The latest published texture checkpoint, `24fa296`, carries the portable wider
texture model through native allocation and view ownership:

- portable 1D, 2D, 2D-array, cube, and 3D dimensions;
- explicit physical depth versus array-layer semantics;
- dimension-aware mip and device-limit validation;
- `TextureRegion` and `TextureDataLayout` with checked pitched/block footprints;
- BC1 RGBA UNORM and sRGB block metadata and validation;
- OpenGL immutable `glTexStorage1D/2D/3D` allocation and exact targets;
- Vulkan image type, view type, cube/mutable flags, depth/layer counts, and
  per-mip/per-layer layout storage;
- aliased full OpenGL views and owned partial/reinterpreted `glTextureView`
  names with deterministic deletion;
- live creation and view-lifetime evidence on explicit OpenGL, explicit Vulkan,
  and automatic backend selection.

Its final source passed:

```bash
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

That published sample matrix independently rebuilt and ran 35 examples. The
strict published registry ledger classified 101 OpenGL and 113 Vulkan commands,
214 total.

Earlier published work includes direct X11 and Wayland foundations, surfaced
and headless backend selection, common resource ownership, bind groups,
render/compute passes, offscreen and multisampled targets, resolves, mip
generation, multiple render targets and subpasses, buffer pools and mappings,
fixed-slot asynchronous buffer and 2D RGBA/BGRA texture transfers, timeline and
synchronization2 Vulkan paths, dynamic-rendering fallback selection, reflected
push values, indirect rendering, profiler queries, and the currently documented
strict `$glsl` subset. `docs/status.md` contains the claim-by-claim evidence.

## Current published checkpoint: pitched wider texture transfer and copy

Implementation commit `569107e` completes this slice. It includes common API,
both native backends, positive and negative tests, an independently buildable
sample, public documentation, and regenerated registry evidence.

### Portable/common API

`src/resources.ab` adds scalar, allocation-free validation and footprint helpers
for hot paths:

- `textureRegionRangeValid`;
- `textureDataRequiredBytesRange`;
- `textureDataLayoutRangeValid`;
- `textureCopyRangeValid`.

`src/texture.ab` adds:

- descriptor conveniences `GraphicsTexture.writeBytes` and `readBytes` using
  `BufferBytes`, `TextureRegion`, and `TextureDataLayout`;
- primitive `writeBytesRange` and `readBytesRange` overloads for measured hot
  paths without immutable descriptor copies;
- `GraphicsApplication.copyTextureRange` for exact subresource copies with
  source/destination mip and xyz coordinates plus width/height/depth;
- checked usage, bounds, pitch, block alignment, ownership, sample count,
  dimension, and format compatibility before backend dispatch.

Depth/stencil raw byte transfer is deliberately rejected for now. The new path
supports color and compressed formats; `PixelBuffer` remains the ergonomic
uncompressed 2D RGBA convenience.

### OpenGL backend

`src/driver/opengl.ab` now uses direct-state-access byte transfer calls:

- `glTextureSubImage1D/2D/3D`;
- `glCompressedTextureSubImage2D/3D` on the live claimed BC1 paths;
- `glGetTextureSubImage` and `glGetCompressedTextureSubImage`;
- scoped `glPixelStorei` pack/unpack row length, image height, alignment, and
  compressed-block state, restored after each operation;
- `glCopyImageSubData` for general region copies.

Compressed `imageSize` is the active tight block-data byte count, while caller
memory can still use a larger validated pitch. Do not replace it with the full
pitched footprint: the driver rejects that interpretation.

There is a declaration/dispatch branch for compressed 1D upload, but the live
OpenGL driver rejected BC1 1D storage. Therefore it is not included in the
common registry audit and must not be claimed without positive portable
evidence.

### Vulkan backend

`src/driver/vulkan.ab` now:

- indexes tracked image layout by mip and array layer;
- distinguishes 3D physical z/depth from array base-layer/layer-count;
- repacks arbitrary caller row/image pitch into tight texture-owned coherent
  staging for upload and scatters tight readback back into the caller pitch;
- emits correct `VkBufferImageCopy` and `VkImageCopy` layouts;
- transitions every selected subresource and restores its normalized resting
  layout;
- inserts transfer-write-to-host-read visibility for mapped readback;
- reuses existing texture/device staging, command-pool, command-buffer, and
  transfer state in primitive repeated paths.

Abla does not overload methods by arity, so the per-subresource layout writer is
named `storeSubresourceLayout`; do not collapse it back into the existing
legacy `storeLayout` name.

### Verified evidence

`tests/wider_texture/main.ab` now covers exact pitched byte round trips for:

- uncompressed 1D;
- raw R8 2D;
- RGBA 2D arrays with offset, row pitch, and image pitch;
- individual cube faces;
- physical 3D volumes;
- BC1 2D and BC1 arrays;
- layered array copies and physical-volume copies;
- short-buffer, crossing-range, and invalid-copy rejection;
- preservation of caller padding;
- stable native resources and zero runtime live-byte growth across repeated
  primitive upload/readback/copy operations.

The focused wider run passed all three selections:

```bash
nix-shell --run 'make test-wider-texture'
```

The OpenGL, Vulkan, and auto reports all had `resources=true`, `views=true`,
`transfers=true`, `copies=true`, `bc1=true`, `repeated=true`, stable handles,
zero live-byte growth, valid rejection checks, and clean affine drops.

The generated ledger reports 108 classified OpenGL and 113 Vulkan commands,
221 total. Its deterministic regeneration, strict evidence join, and raw-module
compile gate pass.

`examples/wider-texture` independently demonstrates pitched RGBA array upload,
layered GPU copy, exact readback with padding preservation, wider resource/view
creation, stable image handles, and zero-growth repeated primitive operations.
It runs under both explicit backends in the sample matrix.

The final source in `569107e` passed on 2026-08-24:

```bash
nix-shell --run 'make update-registry test-registry test-texture-contract test-wider-texture test-application test-texture-transfer'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

`make all` includes the Abla-only audit and every core, platform, backend,
window, shader, application, transfer, pool, debug, and registry gate. The
independent no-cache sample matrix built all 36 examples and ran its complete
Wayland/headless/X11 plus explicit OpenGL/Vulkan execution matrix. The new
wider sample reported `exact=true`, `repeated=true`, stable handles, and
`live=0` on both backends. `../ablac` was not changed.

## Immediate continuation checklist

The next coherent checkpoint is target-aware sampled binding and shader support
for arrays, cubes, and volumes:

1. Audit the existing `sampler2D` reflection, bind-group validation, OpenGL
   target binding, Vulkan descriptor/view handling, and strict raster SPIR-V
   image/sampling emitter before changing the public surface.
2. Define one portable reflected texture-dimension contract for `sampler2D`,
   `sampler2DArray`, `samplerCube`, and `sampler3D`. Reject a shader/bound-view
   dimension mismatch before command recording.
3. Preserve existing 2D APIs and exact shader bytes where a module does not use
   wider samplers. Backend selection and dimension dispatch must remain outside
   repeated draw loops.
4. Extend OpenGL to bind the correct texture/view target and Vulkan to use the
   matching owned view type without rebuilding descriptors per draw.
5. Extend deterministic `$glsl` reflection and SPIR-V image types, coordinates,
   and sampling instructions for the wider sampler families. Add malformed and
   interface-mismatch compiler tests with original source spans.
6. Add exact live array, cube, and 3D sampling output tests and one concise
   independently buildable sample. Prove stable native handles and zero runtime
   live-byte growth on both backends.
7. Regenerate any newly used raw commands through the audit manifests, update
   public claims, run focused gates, then run `make all` and
   `make test-samples` before an explicit-path commit and push.

After that, extend fixed-slot asynchronous texture queues to raw wider and
compressed transfers without regressing the existing 2D convenience, tickets,
stable resources, or zero-growth hot paths. Decide and document portable
application intent before designing Vulkan device-local texture-memory
suballocation; OpenGL texture storage is opaque, so native allocation mechanics
alone are not a useful common abstraction. Then continue through all remaining
milestones in `plan.md`.

## Major remaining framework work

The project is far from its final definition of done. Important open areas
include:

- complete native window/input/monitor/clipboard/cursor/fullscreen behavior and
  pure-Abla Win32 and Cocoa platform/surface backends;
- broader OpenGL 4.6 and Vulkan 1.4 core/extension command families, callable
  generated raw bindings, capability negotiation, and complete coverage-ledger
  classification;
- the remaining GLSL 4.60 grammar, stages, includes/modules, diagnostics,
  reflection, specialization constants, interface validation, deterministic
  dual-backend generation, and shader/pipeline caches;
- reusable command encoders, transient resource pools, texture allocation
  strategy, descriptor reuse, frame pacing, render-graph scheduling, barriers,
  aliasing, and device-loss/context-reset recovery;
- geometry/tessellation, mesh/task, ray tracing, acceleration structures,
  multiview, variable-rate shading, sparse/external resources, video, device
  groups, protected work, calibrated timestamps, shader objects, and vendor
  extensions behind queried capability types;
- real Linux/Windows/macOS CI with validation and golden output, fuzzing,
  repeatable startup/resource/transfer/submission/frame/memory benchmarks, and
  reproducible signed releases;
- the planned sample catalog: camera/mesh/material/glTF, particles, shadows,
  HDR/PBR, deferred/render graph, UI/text, multi-window/monitor, profiler, raw
  backend labs, stress benchmark, complete 2D game, complete 3D application,
  and Abla Mobile/native-surface proof.

Do not substitute a large enum/token surface for these implementation and
evidence requirements.

## Files to care about

Core public surface and implementation:

- `src/graphics.ab` — public module composition;
- `src/core.ab` — configuration, features, limits, errors, and capability
  contract;
- `src/resources.ab` — descriptors, dimensions, formats, views, regions,
  layouts, and portable validation;
- `src/texture.ab` — affine common texture ownership and synchronous dispatch;
- `src/texture_transfer.ab` — fixed-slot asynchronous texture API;
- `src/transfer.ab` — tickets, slots, generations, polling, and waits;
- `src/binding.ab` — bind-group validation and sampled texture compatibility;
- `src/driver/opengl.ab`, `src/driver/vulkan.ab` — backend image allocation,
  transfer, copy, synchronization, and layout state;
- `src/driver/opengl_transfer.ab`, `src/driver/vulkan_transfer.ab` — reusable
  buffer-transfer slot patterns;
- `src/shader/glsl.ab`, `src/shader/glsl_spirv.ab` — `$glsl` parsing,
  reflection, typing, and deterministic SPIR-V generation.

Tests and samples:

- `tests/texture_contract.ab`, `tools/test-texture-contract.sh`;
- `tests/wider_texture/main.ab`, `tools/test-wider-texture.sh`;
- `tests/application/main.ab`;
- `tests/texture_transfer/main.ab`, `tools/test-texture-transfer.sh`;
- `tests/transfer/main.ab`, `tools/test-transfer.sh`;
- `examples/common-texture/main.ab` and `examples/async-texture/main.ab`;
- `tools/test-samples.sh` — independent no-cache build and live backend matrix;
- `Makefile` — authoritative gate map.

Registry and public claims:

- `registry/audit/opengl.tsv`, `registry/audit/vulkan.tsv` — reviewed evidence
  inputs;
- `tools/update-registry.sh` and the registry importer sources;
- `registry/coverage/*.md` and `src/raw/*_registry.ab` — generated outputs;
- `README.md`, `docs/api.md`, `docs/status.md`,
  `docs/specification-baseline.md`, `plan.md`, and this file;
- `tools/check-abla-only.sh` — mandatory proof of the no-C implementation rule.

## Working and publication commands

Use the repository's Nix environment. Start focused, but never publish a slice
on focused tests alone.

Useful focused commands:

```bash
nix-shell --run 'make test-core test-texture-contract test-wider-texture'
nix-shell --run 'make test-application test-transfer test-texture-transfer'
nix-shell --run 'make update-registry test-registry'
```

Mandatory final gates:

```bash
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

Review before committing:

```bash
git status --short --branch
git diff --check
git diff --stat
git diff -- <explicit paths>
git add <explicit paths>
git diff --cached --check
git diff --cached --stat
git diff --cached -- <explicit paths>
```

Verify after pushing:

```bash
git fetch origin main
git rev-parse HEAD
git rev-parse origin/main
git status --short --branch
git -C ../ablac status --short --branch
git -C ../ablac rev-parse HEAD
git -C ../ablac rev-parse '@{upstream}'
```

## Known design and implementation cautions

- Descriptor overloads are for convenient setup. Primitive scalar range calls
  are the measured allocation-free streaming path because immutable class value
  copies can allocate in current Abla.
- Vulkan 3D textures use one array subresource with physical z/depth; 2D arrays
  and cubes use array layers. Do not apply one interpretation to both.
- Vulkan layout state is per mip and per array layer. Whole-texture state updates
  are insufficient for partial wider operations.
- OpenGL compressed pixel-store state selects blocks from pitched caller memory,
  but the compressed upload `imageSize` is the tight active selection size.
- Caller padding must remain untouched on readback; only active texel/block bytes
  are semantically transferred.
- The existing asynchronous texture queues intentionally remain RGBA8/BGRA8 2D
  until the raw wider async design is implemented and tested.
- Keep the existing legacy 2D `PixelBuffer`, texture-copy, and layout methods
  working while extending the wider API.
- Large texture-owned staging is currently bounded by the existing backend
  design. Do not promise arbitrary-size staging or device-local texture
  suballocation without a separate validated design.

## `abla-doom` side quest

The homage project is already complete and published separately. Its clean
proof screenshot is:

```text
/home/andre/Desktop/projects/abla-doom/screenshots/abla-doom.png
```

Do not modify or republish `abla-doom` unless a later request explicitly
expands that scope.

## Completion and publication rule

Verified incremental commits may be pushed to the GitHub repository as the
framework grows. The persistent goal itself is complete only when every exit
gate and the full definition of done in `plan.md` is genuinely satisfied.

Do not mark the goal complete because one checkpoint passes, because the token
surface is broad, or because a backend compiles. Completion requires working
Abla-only implementation, tests, samples, documentation, live backend evidence,
performance evidence where promised, complete platform/release work, and a
clean synchronized published state.
