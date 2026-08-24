# Abla Graphics continuation goal

Updated: 2026-08-20 (Europe/Lisbon).

This file is the operational handoff for the next person continuing the active
Abla Graphics goal. Read this file first, then `plan.md`, `docs/status.md`, and
`docs/api.md`. Do not treat the current repository as finished merely because
individual vertical slices work.

## Goal

Complete the framework described in `plan.md`: an idiomatic Abla graphics and
windowing package with production OpenGL 4.6 and Vulkan 1.4 backends, broad
portable coverage, generated raw specification bindings and audited coverage,
an Abla `$glsl` subparser and deterministic shader pipeline, extensive samples,
validation/performance gates, and reproducible releases at
`AndreBaltazar8/abla-graphics`.

The definition of done is the one in `plan.md`: the common API must be pleasant
for ordinary applications; both backends must pass the shared conformance and
sample suite; the pinned OpenGL/Vulkan coverage ledgers must contain no
unclassified entries; `$glsl` must provide source-accurate deterministic shader
builds; performance gates must pass; and clean source releases must be
reproducible on every supported platform.

This is a persistent goal. Continue through safe, verified, reviewable slices.
Do not mark it complete while any part of that definition remains open.

## Non-negotiable constraints

- All framework, platform, backend, ABI layout, command construction, shader,
  and application implementation code must be Abla.
- Do not add C, C++, Rust, GLFW, SDL, Xlib/XCB window-management code,
  `libwayland-client`, or another implementation shim.
- Calling the operating system, compositor, OpenGL driver, Vulkan loader/driver,
  and test tools through direct Abla ABI declarations is allowed and expected.
- Implement the facilities on which GLFW-like libraries rely: direct platform
  protocols, native windows, events, surfaces, contexts, and lifetime handling.
- Use Abla ownership features deliberately. GPU/window/native handles should be
  affine `resource class` values with deterministic, idempotent cleanup.
- Keep backend selection outside hot paths. Steady-state frame/transfer loops
  must not allocate general heap memory.
- Never claim feature support because a token or generated declaration exists.
  A supported command/family needs a loader/ABI path, positive evidence, and an
  unsupported/error-path test.
- Generated raw registries are reproducible outputs. Edit audit manifests or
  generators, then run `make update-registry`; do not hand-edit generated raw
  files.
- Changes to `../ablac` are authorized when the language/compiler genuinely
  needs them. Preserve unrelated work, test the compiler independently, and
  commit/push `ablac` separately from `abla-graphics`.
- Preserve unrelated worktrees. Stage explicit paths, inspect the staged diff,
  commit only the verified slice, push, and confirm local `HEAD` equals the
  remote branch.

## Repositories and checkpoint base

- Graphics: `/home/andre/Desktop/projects/abla-graphics`
  - remote: `git@github.com:AndreBaltazar8/abla-graphics.git`
  - branch: `main`
  - asynchronous-transfer slice base:
    `08fee6537413f835317ab0cbb5a616125bb4e53c`
  - resolve the current state with `git rev-parse HEAD`,
    `git rev-parse origin/main`, and `git status --short`; those commands remain
    authoritative after this handoff itself is committed.
- Compiler/language: `/home/andre/Desktop/projects/ablac`
  - remote: `git@github.com:AndreBaltazar8/ablac.git`
  - branch: `master`
  - currently clean and synchronized at `3597496` (`Document setup-abla for
    GitHub Actions`). No compiler edits are part of the current dirty slice.
- Doom side quest: `/home/andre/Desktop/projects/abla-doom`
  - remote: `git@github.com:AndreBaltazar8/abla-doom.git`
  - branch: `main`
  - clean and synchronized at `4b64253` (`Capture the exact Doom proof window`)
  - proof screenshot: `screenshots/abla-doom.png`
  - screenshot helper: `tools/screenshot.sh`
  - this side quest is already complete and published; do not rebuild or alter
    it unless a later goal explicitly requires that.

Recent published graphics checkpoints:

- `5ceb5d1` - explicit device-local buffer placement;
- `e37385d` - allocation-free asynchronous buffer transfers;
- `08fee65` - allocation-free coherent buffer readback rings;
- `e4d8784` - explicit OpenGL fence completion for synchronous copies;
- `d1c5be4` - allocation-free coherent buffer upload rings;
- `b28ba41` - coherent persistent uploads;
- `b744c19` - reusable buffer range mappings;
- `a4e27ac` - mapped-at-creation buffers.

At `08fee65`, the full release gate and the full no-cache sample matrix passed on
OpenGL and Vulkan. The common-buffer sample proved persistent upload/readback,
forced ring wraps, stable native handles, exact bytes, and zero live-memory
growth on both backends.

## Asynchronous buffer-transfer checkpoint

This checkpoint implements true fixed-slot asynchronous buffer transfers. It
was built on the base above and verified completely on 2026-08-20. If these
files are dirty, finish the publication checklist below. If the tree is clean
and synchronized, this checkpoint is already published and the next person can
continue with the major remaining framework work.

Files changed by this checkpoint:

- `Makefile`
  - adds `test-transfer` and includes it in `make test`.
- `src/graphics.ab`
  - imports the new `transfer.ab` composition module.
- `tests/core.ab`
  - adds upload/readback queue descriptor, stride, slot-count, alignment, and
    total-capacity validation coverage.
- `tools/test-application.sh`
  - scopes this unusually broad composition/conformance build to a 6144-MiB
    compiler address-space guard; the project-wide default remains 4096 MiB.
- `registry/audit/opengl.tsv` and `registry/audit/vulkan.tsv`
  - add asynchronous queue evidence to the copy/synchronization commands and
    classify `vkGetFenceStatus` as a common command.
- `registry/coverage/opengl.md`, `registry/coverage/vulkan.md`, and
  `src/raw/vulkan_registry.ab`
  - regenerated outputs; the common command total is now 209 (96 OpenGL plus
    113 Vulkan), and `make update-registry test-registry` passes.
- `README.md`, `docs/api.md`, `docs/status.md`, and `plan.md`
  - distinguish synchronous rings from the verified fixed-slot asynchronous
    queues and document the public ticket/poll/wait/readback API.
- `tools/test-samples.sh`
  - compiles and runs the new async-buffer example on both backends.

Files added by this checkpoint:

- `src/driver/opengl_transfer.ab`
  - one reusable OpenGL slot per in-flight operation;
  - submits `glCopyBufferSubData`, places the coherent mapped-buffer barrier,
    creates a `GLsync`, polls with zero timeout, waits only when asked, and
    deletes the sync deterministically.
- `src/driver/vulkan_transfer.ab`
  - one reusable command pool, command buffer, fence, and ABI scratch block per
    slot;
  - declares and uses `vkGetFenceStatus` for non-blocking polling;
  - records a buffer copy and transfer-to-host or transfer-to-all-commands
    barrier, submits with the slot fence, and resets only a completed slot.
- `src/transfer.ab`
  - `BufferTransferQueueDescriptor`, upload/readback directions, one-to-eight
    fixed slots, aligned per-slot capacity, checked one-GiB total bound;
  - affine `GraphicsBufferTransferQueue` with one coherent mapped staging
    buffer, backend-native slot arrays, generation counters, completion
    counters, non-blocking `poll`, explicit `wait`, and `waitAll`;
  - compact integer transfer tickets prevent stale slot reuse by generation;
  - non-blocking enqueue APIs for upload and readback plus `resolveReadback` and
    blocking-with-timeout `waitReadback`;
  - enqueue returns an invalid ticket rather than waiting when its selected slot
    is still busy; failed validation must not advance queue state.
- `tests/transfer/abla.toml` and `tests/transfer/main.ab`
  - a separate live queue gate to keep the already huge application test from
    growing further and to isolate transfer failures;
  - three simultaneous native upload slots and three readback slots;
  - explicit waits, exact bytes, stale-ticket rejection, invalid-range state
    preservation, stable Vulkan command pools/buffers, stable staging handles,
    and repeated zero-live-growth checks.
- `tools/test-transfer.sh`
  - no-cache build and Xvfb execution for explicit OpenGL, explicit Vulkan, and
    auto selection.
  - the file is executable (`0755`) and builds the focused source directly; the
    adjacent manifest supplies the native libraries.
- `examples/async-buffer/abla.toml` and `examples/async-buffer/main.ab`
  - concise user-facing three-slot upload/readback example;
  - passes explicit OpenGL and Vulkan with exact bytes and `live=0` in its
    repeated upload loop.

`tests/application/main.ab` remains at its published content and has no diff. An
earlier attempt to put the new live proof into that already very large source
exhausted the generic 4-GiB compiler address-space guard and terminated with an
apparent illegal-instruction report. The separate focused transfer gate is the
permanent structure. Importing the larger public composition root makes the
existing 83-KiB application source require a scoped 6144-MiB limit; all six
application modes pass with that limit: explicit OpenGL, explicit Vulkan, auto,
fallback OpenGL, unavailable, and unsupported.

The following focused command passes:

```bash
nix-shell --run 'make test-core test-transfer'
```

Its live output proves explicit OpenGL, explicit Vulkan, and Vulkan-selected
auto queues. Each backend submits three uploads and three readbacks before
waiting, recovers exact bytes, rejects stale and invalid tickets, preserves the
staging and Vulkan command handles, and reports `live=0/0` over six repeated
upload/readback cycles. Treat those focused claims as verified.

The complete final-source verification also passes:

```bash
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

`make all` covers the Abla-only audit plus every core, X11, Wayland, headless,
OpenGL, Vulkan, surfaced-window, `$glsl`, application, asynchronous-transfer,
debug, and registry gate. The no-cache sample matrix builds every example and
runs the platform/headless examples plus every common example on explicit
OpenGL and Vulkan. The corrected async-buffer sample reports
`queued=9/3 completed=9/3 exact=true live=0` on both backends.

## Follow-up checkpoint: explicit buffer memory placement

This follow-up is built on published commit `e37385d`. It adds
`bufferMemoryAutomatic`, `bufferMemoryHostVisible`, and
`bufferMemoryDeviceLocal` to `BufferDescriptor`; tracks Vulkan memory-property
flags on affine buffers; ranks compatible native memory types; rejects mapping
and direct CPU byte access for device-local buffers; and explicitly keeps async
queue staging host-visible. The async test and sample now use a device-local
destination and cross the CPU/GPU boundary only through the queue.

The implementation touches `src/resources.ab`, `src/buffer.ab`,
`src/driver/vulkan.ab`, and `src/transfer.ab`. Evidence lives in
`tests/core.ab`, `tests/transfer/main.ab`, `examples/async-buffer/main.ab`, the
Vulkan audit/coverage ledger, and the public documentation. `tools/test-core.sh`
uses a scoped 6144-MiB compiler limit because that exceptionally broad source
crossed the generic 4096-MiB guard after the descriptor grew. The X11,
headless, transfer, pool, and complete sample gates now use the same scoped
6144-MiB ceiling because they import the expanded public composition root.

The final verification passes:

```bash
nix-shell --run 'make test-core test-transfer'
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

The focused gate reports `deviceLocal=true`, `cpuRejected=true`, exact staged
upload/readback, stable handles, and `live=0/0` on explicit OpenGL, explicit
Vulkan, and auto selection. The final async-buffer sample reports
`deviceLocal=true queued=9/3 completed=9/3 exact=true live=0` on both backends.
If this follow-up is dirty, publish it with the same explicit-scope discipline
as the asynchronous checkpoint; if clean and synchronized, continue to actual
device-local buffer suballocation pools.

## Current checkpoint: device-local buffer suballocation

This verified checkpoint adds one useful allocator that is connected to real GPU
work rather than being a detached planning utility. `src/pool.ab` defines
`BufferPoolDescriptor` and affine `GraphicsBufferPool`: one explicitly
device-local backing buffer, fixed block/allocation metadata constructed once,
bounded aligned first-fit allocation, compact slot/generation tokens, stale
reuse rejection, exact reserved-byte accounting, and allocation-free
allocate/release operations. Pool-relative async upload/readback wrappers feed
checked absolute offsets into the already verified fixed-slot OpenGL/Vulkan
transfer paths.

Evidence and user surface for this checkpoint:

- `tests/pool/main.ab` and `tools/test-pool.sh` cover descriptor rejection,
  aligned/fragmented placement, slot generation reuse, stale and crossing-range
  rejection, device-local CPU-access rejection, exact asynchronous slice
  transfers, stable backing handles, and zero live-byte change across 1,000
  allocate/release cycles on OpenGL, Vulkan, and auto selection;
- `examples/buffer-pool/main.ab` is the independently buildable public sample
  and is part of the complete sample matrix on both explicit backends;
- `src/graphics.ab`, `Makefile`, `README.md`, `docs/api.md`, `docs/status.md`,
  and `plan.md` expose, gate, and document the slice.

The pool does not yet claim offset-aware vertex/index/uniform/storage binding.
Its public `backing` field is an advanced escape hatch, while safe render and
binding integration remains the next buffer-pool slice. A slice must not be
released until every command or transfer borrowing it has completed. Texture
suballocation remains separate future work.

Final-source verification passed on 2026-08-24:

```bash
nix-shell --run 'make test-core test-transfer test-pool check-abla-only'
nix-shell --run 'make test-application'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

The focused pool gate reports `deviceLocal=true layout=true reuse=true
exact=true live=0 stable=true active=2 used=64/128` for explicit OpenGL,
explicit Vulkan, and Vulkan-selected auto. The public sample reports
`deviceLocal=true offsets=0/512 exact=true live=0 active=2 peak=768` on both
explicit backends. `make all` and the complete independently compiled sample
matrix pass after scoping public-composition builds to the established 6144-MiB
compiler address-space ceiling.

## Immediate continuation checklist

1. If this checkpoint is still dirty, inspect all files and run
   `git diff --check`.
2. After any transfer/pool implementation or test edits, rerun the focused
   compiler and live gates:

   ```bash
   nix-shell --run 'make test-core test-transfer test-pool'
   ```

3. Diagnose failures rather than weakening assertions. In particular preserve:
   - all three slots report native in-flight state immediately after enqueue;
   - OpenGL waits on the slot sync, not `glFinish`;
   - Vulkan waits on the slot fence, not `vkQueueWaitIdle` or
     `vkDeviceWaitIdle`;
   - readback bytes are touched only after completion;
   - generation-reused tickets reject the old ticket;
   - repeated hot paths preserve staging/command handles and show zero runtime
     live-byte growth.
4. Rerun the pre-existing application gate with its now-scoped default to prove
   the new composition import does not regress it:

   ```bash
   nix-shell --run 'make test-application'
   ```

5. After any registry-evidence edits, regenerate and recheck the raw outputs:

   ```bash
   nix-shell --run 'make update-registry test-registry'
   ```

6. After any implementation change, rerun the complete release gate:

   ```bash
   nix-shell --run 'make test-registry test-glsl test-core test-vulkan \
     test-vulkan-window test-opengl test-application test-transfer \
     test-pool check-abla-only'
   ```

7. After any sample or public-composition change, rerun the complete no-cache
   sample matrix:

   ```bash
   nix-shell --run 'make test-samples'
   ```

8. If not yet published, review scope, stage explicit paths only, inspect
   `git diff --cached`, commit the coherent buffer-pool slice, push
   `main`, and verify:

    ```bash
    git rev-parse HEAD
    git rev-parse origin/main
    git status --short
    ```

Do not include build artifacts. `tools/check-abla-only.sh` must continue to prove
that framework/platform/backend implementation source is Abla-only.

## Known design points to review in the current slice

- OpenGL polling uses `glClientWaitSync(sync, GL_SYNC_FLUSH_COMMANDS_BIT, 0)`;
  explicit waits use the caller timeout and delete the sync only after a
  signaled/satisfied result.
- Vulkan uses one command pool/buffer/fence per queue slot. This is intentionally
  separate from the device's older synchronous transfer command state so no
  command pool is reset while work is in flight.
- The Vulkan upload barrier currently uses transfer-write to all-commands
  memory read/write; readback uses transfer-write to host-read. Confirm these
  stage/access masks under validation.
- A failed Vulkan submit after fence reset leaves `submitted = false` and the
  fence unsignaled, but drop destroys the fence without waiting. Verify every
  partial-failure cleanup path remains legal and idempotent.
- `GraphicsBufferTransferQueue.valid()` checks arrays and backend slots on every
  operation. Measure this before optimizing it away; correctness comes first.
- Transfer tickets are compact positive integers containing slot and generation;
  size remains in fixed queue metadata so enqueue does not allocate. Cross-queue
  misuse is rejected only indirectly by generation/size state; add an opaque
  queue identity if live negative testing demonstrates a collision.
- Queue state counters must advance only after successful submission and only
  once when a native in-flight slot transitions to completed.
- The current queue is buffer-only. Asynchronous texture/image transfers remain
  later work and must not be implied by this API.
- Pool tokens are compact slot/generation integers. Cross-pool misuse can
  collide when two pools have matching metadata state; add an opaque pool
  identity if negative live testing requires hard cross-pool rejection.
- The block allocator intentionally trades bounded metadata and predictable hot
  paths for internal fragmentation. Benchmark first-fit scan cost before adding
  size classes or free lists.
- The current pool wrappers cover asynchronous upload/readback. Complete GPU
  work before release; offset-aware vertex/index/uniform/storage/indirect
  binding is the immediate integration target.

## Major remaining framework work after this slice

The detailed source of truth is `plan.md`; `docs/status.md` distinguishes proven
features from open work. Major remaining areas include:

- explicit device-local buffer placement and the first allocation-free buffer
  suballocation/transfer pool are implemented; finish offset-aware buffer
  binding/render integration, device-local texture suballocation, reusable
  command encoders, transient resources, descriptor
  reuse, pipeline-cache persistence, and framework-wide performance gates;
- expand general texture byte layouts, format conversion, asynchronous image
  copies, render-graph execution/barriers/aliasing, and asset pipelines;
- broaden the portable rendering surface: general render/compute encoders,
  complete barriers, query resolution, advanced pass/resource combinations,
  and robust device-loss/context-reset behavior;
- implement the remaining `$glsl` language rather than only the currently
  proven strict subsets: GLSL 4.60 syntax/stages/modules/includes, precise
  diagnostics, reflection, interface validation, deterministic OpenGL GLSL and
  Vulkan SPIR-V, and shader caching;
- complete generated callable raw bindings and classify every pinned OpenGL and
  Vulkan core/extension row. The current status documents 209 exercised common
  commands; all other rows intentionally remain unclassified;
- implement Win32 and Cocoa platform/window/surface layers in Abla and add real
  Linux, Windows, and macOS CI. Linux X11/Wayland is substantial but does not
  satisfy cross-platform completion alone;
- cover advanced specification families behind queried capability types:
  geometry/tessellation, mesh/task, ray tracing/acceleration structures,
  variable-rate shading, multiview, sparse resources, external memory and
  semaphores, video, protected/device-group work, calibrated timestamps, shader
  objects, and applicable vendor extensions;
- complete the planned learning/sample catalog: textured cube, glTF scene,
  materials/camera, post-processing, particles, shadow/HDR/PBR, deferred
  renderer, UI/text, multi-window, profiler, raw backend labs, stress benchmark,
  complete 2D/3D apps, and Abla Mobile/native-surface proof;
- build reproducible benchmark thresholds for startup, shader compile, resource
  creation, transfers, command submission, frame pacing, GPU time, and memory;
  add fuzzing/validation jobs and reproducible signed source releases.

## Publication discipline

The GitHub repository already exists and receives verified checkpoints, but the
framework must not be called complete or released as complete until the full
definition of done passes. Prefer small commits that each include implementation,
positive and negative tests, live backend evidence, registry evidence when
applicable, documentation, and clean synchronization with the remote.

If `ablac` needs a change, finish its tests, stage only compiler-owned paths,
commit and push that repository first, confirm it is clean/synchronized, then
finish and publish the dependent `abla-graphics` checkpoint.
