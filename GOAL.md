# Abla Graphics continuation goal

Updated: 2026-08-24 (Europe/Lisbon).

This is the operational handoff for the next person continuing Abla Graphics.
Read this file first, then `plan.md`, `docs/status.md`, and `docs/api.md`. The
repository contains many working vertical slices, but the framework is not
finished and must not be presented as complete.

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
- verified implementation checkpoint:
  `8990ca4dce2a4884603ba285cd37430ed3805746`
- local `HEAD` and `origin/main` matched at that commit before this handoff was
  committed; after the handoff commit, use the commands below as authoritative
- no uncommitted implementation work should remain; expect a clean synchronized
  tree after this document is published

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

The last implementation commit is `8990ca4` (`Add pooled offscreen draw
ranges`). It extends the previously published surfaced draw-range support to
all sixteen offscreen target/pass forms.

Published behavior:

- all 16 ordinary/push target/pass vertex, indexed, vertex-indirect, and
  indexed-indirect methods accept source-compatible optional checked byte
  ranges;
- `src/pool_render_target.ab` exposes 16 generation-checked helpers in addition
  to the eight surfaced helpers in `src/pool_render.ab`;
- OpenGL sums vertex bases into attribute pointers and uses index/indirect draw
  pointers; Vulkan records equivalent direct range binds and command offsets;
- indexed-indirect `firstIndex` is absolute to the complete backing index
  buffer on both backends because OpenGL has no separate indirect index-base
  argument. Vulkan binds index byte zero for indexed-indirect calls. A pooled
  `uint32` index allocation at byte 48 therefore stores `firstIndex = 12`;
- `tests/pool/main.ab` runs all eight surfaced and all sixteen offscreen helpers
  from one device-local pool at `16/48/64/80`, verifies an exact red target
  pixel, rejects seven malformed/short/stale cases, preserves native handles,
  and reports zero live growth on OpenGL, Vulkan, and auto selection;
- `examples/render-to-texture` uses the pooled ordinary pass forms with depth,
  multisample resolve, sampling, exact output, and zero-growth repeats;
- `examples/push-color` uses pooled push target/pass/present forms with exact
  changing values and zero-growth repeats;
- The strict registry coverage remains 97 OpenGL plus 113 Vulkan common
  commands, 210 total.

The following gates passed on the final published source on 2026-08-24:

```bash
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

Those results apply to the final source in `8990ca4`. `../ablac` was not changed.

Earlier published foundations include explicit device-local buffer placement,
fixed-metadata buffer suballocation, generation-checked async slice transfer,
aligned uniform/storage range bindings, fixed-slot asynchronous upload and
readback queues, persistent mapping/rings, common OpenGL/Vulkan resources,
offscreen targets/passes, push values, compute, X11/Wayland/headless platform
paths, and the currently documented strict `$glsl` subset. Consult
`docs/status.md` for claim-level detail and evidence.

## Recommended next checkpoint: asynchronous texture transfers

The next high-value performance slice is fixed-slot asynchronous texture upload
and readback. Buffer queues are already allocation-free and well tested, while
texture operations remain synchronous. This slice should make real progress
toward streaming assets and later texture suballocation without pretending that
OpenGL and Vulkan expose identical memory models.

Start with a design/source audit of `src/texture.ab`, `src/transfer.ab`,
`src/driver/opengl_transfer.ab`, `src/driver/vulkan_transfer.ab`, the synchronous
image paths in `src/driver/opengl.ab` and `src/driver/vulkan.ab`, and the texture
coverage in `tests/application/main.ab`/`examples/common-texture`.

Required shape for a coherent checkpoint:

1. Add a bounded descriptor for upload or readback, fixed slot count/capacity,
   pixel layout, mip, origin, and extent. Validate overflow-safe row/layer byte
   sizes, format compatibility, usage, ownership, sample count, and subresource
   bounds before submission.
2. Reuse one mapped staging allocation and fixed native state per slot. Enqueue
   must return immediately with a generation-checked ticket and must not wait or
   allocate in the hot path.
3. OpenGL should use fence-backed completion around real texture transfer work;
   Vulkan should use reusable per-slot command/fence state and explicit image
   layout/access transitions without queue/device-wide idle.
4. Preserve the buffer queue's poll/wait/stale-ticket semantics where they are
   genuinely portable. Do not force an abstraction that loses row pitch,
   subresource, or layout information needed by either backend.
5. Add focused positive and negative live tests on explicit OpenGL, explicit
   Vulkan, and auto selection: multiple operations in flight before waits,
   exact partial-mip bytes, stale tickets, invalid/crossing layouts, stable
   staging/command handles, and zero live growth across slot reuse.
6. Add a small independently buildable streaming-texture sample or evolve
   `examples/common-texture` only if it remains concise. Update audit evidence,
   API/status/plan documentation, and the complete sample matrix.
7. Run the focused gates, `make update-registry test-registry`, `make all`, and
   `make test-samples`; publish only after all final-source gates pass.

Device-local texture memory suballocation remains the next separate allocator
design problem. OpenGL generally owns opaque texture storage while Vulkan
exposes image-memory binding, so first define the portable application intent
(atlas/array/subresource pooling versus native memory suballocation) and keep
backend-specific optimization behind that contract.

## Files to care about

Primary implementation and composition:

- `src/texture.ab` — portable descriptors, checked texture byte operations,
  layouts, and ownership;
- `src/transfer.ab` — established ticket, slot, generation, poll, and wait API;
- `src/driver/opengl_transfer.ab` and `src/driver/vulkan_transfer.ab` — reusable
  buffer transfer slot implementations to extend or factor carefully;
- `src/driver/opengl.ab` and `src/driver/vulkan.ab` — existing synchronous image
  copy/layout/barrier machinery;
- `src/resources.ab` and `src/graphics.ab` — public descriptor/composition
  surfaces if a new texture-transfer module is added.

Live evidence and samples:

- `tests/application/main.ab` — existing broad texture validation/output proof;
- `tests/transfer/main.ab` and `tools/test-transfer.sh` — established queue
  invariants and output conventions;
- add a focused texture-transfer test rather than overgrowing either broad
  source if compilation memory materially increases;
- `examples/common-texture/main.ab` and a possible concise streaming-texture
  example;
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
nix-shell --run 'make test-core test-transfer'
nix-shell --run 'make test-application'
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

`make all` includes the Abla-only audit and the core, platform, OpenGL, Vulkan,
window, `$glsl`, application, transfer, pool, debug, and registry tests. Do not
replace it with only focused checks before publication. `make test-samples`
performs the independent no-cache sample build/live matrix and is also required.

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

- device-local texture suballocation, asynchronous image transfer, reusable
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
