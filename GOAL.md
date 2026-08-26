# Abla Graphics goal and continuation handoff

Updated: 2026-08-26 (Europe/Lisbon).

This file is the operational handoff for the next person continuing the goal.
Read it before changing code, then read `plan.md`, `docs/status.md`,
`docs/api.md`, and the documentation for the subsystem being changed.

Abla Graphics is an active, incomplete framework. A succession of working
vertical slices is published, but the long-term goal is not complete and must
not be marked complete until every exit condition in `plan.md` is satisfied.

## Mission

Build and publish `AndreBaltazar8/abla-graphics` as the native graphics and
windowing foundation for the Abla ecosystem. It should make ordinary graphics
applications simple while retaining enough explicit control and predictable
performance for advanced OpenGL and Vulkan applications.

The finished framework must provide:

- an idiomatic common Abla API for windows, input, resources, shaders,
  rendering, compute, synchronization, presentation, and diagnostics;
- optimized OpenGL 4.6 core and Vulkan 1.4 backends, with capability-gated
  advanced features and audited raw escape hatches;
- the native window, event, input, monitor, clipboard, cursor, DPI, surface,
  context, and fullscreen implementation that GLFW-like libraries ordinarily
  hide;
- a native Abla `$glsl` subparser with source-accurate diagnostics,
  reflection, interface validation, deterministic OpenGL GLSL and Vulkan
  SPIR-V, and caching;
- explicit affine ownership and deterministic cleanup for every native
  resource;
- zero general heap allocation in measured steady-state frame paths, stable
  native resources, bounded reusable storage, and repeatable performance
  evidence;
- broad specification coverage, many independently buildable samples,
  golden-output and validation tests, cross-platform CI, and reproducible
  source releases.

`plan.md` is the authoritative roadmap and definition of done. A checkpoint is
publishable only when its implementation, tests, live samples, public claims,
and relevant validation/performance evidence agree.

## Non-negotiable constraints

- All framework, platform, backend, shader, ABI-layout, test, and sample
  implementation source must be Abla.
- Do not add C, C++, Rust, generated-C output, or a native shim.
- Do not use GLFW, SDL, Xlib/XCB implementation libraries,
  `libwayland-client`, or a similar windowing abstraction. Implement the
  underlying platform behavior in Abla.
- Direct native ABI declarations and calls from Abla are allowed and expected.
  This is how Abla reaches OS, compositor, OpenGL, and Vulkan interfaces while
  remaining Abla-only.
- Use Abla's advanced features where they improve the design: affine
  `resource class` ownership, deterministic cleanup, compile-time facilities,
  subparsers, reflection, and checked native layouts.
- Keep backend selection and avoidable allocation out of hot loops. Prefer
  retained handles, fixed-capacity state, and scalar hot-path operations.
- A declaration, token, or generated registry row is not feature support.
  Support requires a loader/ABI path, capability handling, positive live
  evidence, and rejection or unsupported-path evidence.
- Preserve existing direct APIs when adding higher-level graph or scheduling
  layers. Do not force every application through the render graph.
- Preserve unrelated worktree changes. Stage explicit paths, inspect the
  staged diff, and verify local/upstream commit IDs after publication.

The mandatory source audit is:

```bash
nix-shell --run 'make check-abla-only'
```

## Repository and publication state

### `abla-graphics`

- Path: `/home/andre/Desktop/projects/abla-graphics`
- GitHub: `AndreBaltazar8/abla-graphics`
- Remote: `git@github.com:AndreBaltazar8/abla-graphics.git`
- Branch: `main`
- Published implementation tip immediately before this handoff document:
  `57492c65287bfba25da8c3b7d938dbb0bd26d2b0`
  (`Record graph compute and fix direct launches`).
- Published and synchronized recorded-compute/direct-linkage implementation:
  `57492c65287bfba25da8c3b7d938dbb0bd26d2b0`.
- Earlier bounded-command implementation checkpoint:
  `08d481ad5105c03b4858d341ffed31d606ce09cc`.
- Relevant published implementation commits are `deecaa3` (`Execute render
  graph barriers`), `6ba1ec5` (`Compile render graph barrier schedules`),
  `08d481a` (`Record bounded render graph commands`), and `d38676f`
  (`Consolidate recorded graph rendering`), and `57492c6` (`Record graph
  compute and fix direct launches`).
- Before committing this handoff only `GOAL.md` is modified. No implementation
  delta is intentionally left uncommitted.
- Recheck `git status` and commit IDs before release work. A commit hash in
  this file is a snapshot, not proof of current synchronization.

### `ablac`

- Path: `/home/andre/Desktop/projects/ablac`
- GitHub: `AndreBaltazar8/ablac`
- Remote: `git@github.com:AndreBaltazar8/ablac.git`
- Branch: `master`
- Local/upstream tip at this handoff:
  `82a66da3a978d63adbe49922f74eebc76eea892a`
  (`Export lifted functions from independent modules`)
- It is currently clean and synchronized. The recorded-compute/direct-linkage
  checkpoint did not require a compiler change.

Changes to `../ablac` are authorized when a real language/compiler capability
is required. Keep them minimal, test them in `ablac`, commit and push that repo
first, then commit the dependent `abla-graphics` change. Do not add a C
fallback to avoid a compiler limitation.

Always recheck these snapshots:

```bash
git status --short --branch
git rev-parse HEAD
git rev-parse origin/main
git -C ../ablac status --short --branch
git -C ../ablac rev-parse HEAD
git -C ../ablac rev-parse '@{upstream}'
```

## Published checkpoint: bounded render-graph commands

The first bounded graph-command-recording slice is implemented and verified.
It deliberately delivers a narrow command list:

- an affine `GraphicsGraphCommandList` with fixed capacity and preallocated
  primitive parallel arrays;
- ordered pass-marker records and transient texture-copy records;
- one-time `seal()` validation followed by repeatable descriptor-free replay;
- graph execution abort/recovery on a failed replay;
- scalar texture-pool and graph texture-copy entry points that avoid descriptor
  construction on the warmed path;
- exact output, rejection, stable-handle, barrier-count, and 1,000-replay
  no-live-growth tests on OpenGL, Vulkan, and automatic backend selection.

The implementation closes the review points recorded by the previous handoff:
failure accounting saturates safely; full validation requires distinct valid
physical slots; creation captures exact logical IDs, physical slots, and native
identities for every all-transient resource; seal fingerprints used command
fields; replay rejects a different same-shaped graph and post-seal mutation
before opening an execution; and the borrowed graph lifetime and diagnostic
array policy are documented. The focused script is executable and integrated
into `make test`.

Verified focused accounting in `tests/graph_commands/main.ab` is one explicit
abort, 1,003 completed graph executions, 1,001 successful command-list
executions, two rejected replays (different graph and post-seal mutation), two
barriers per completed graph execution, 2,006 total/backend barriers, exact
RGBA word `4280427042`, one pool acquisition for each of two physical textures,
stable native identities, and zero warmed-loop live-byte growth.

Verification completed on 2026-08-25:

```bash
nix-shell --run 'make check-abla-only test-core test-graph-texture test-graph-execute test-graph-commands'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

The focused test passed explicit OpenGL, explicit Vulkan, and auto. A dedicated
Vulkan run with `VK_LAYER_KHRONOS_validation` produced a zero-line validation
log and the same exact output/counter/stability/no-growth evidence. The full
aggregate gate passed. The sample gate independently rebuilt all 41 example
roots with `--no-cache` and ran the complete live matrix; the new
`examples/recorded-graph-copy` reported `4/4` commands, exact copy,
`1001/1003` command/graph executions, `2/2006/2006` barriers, stable handles,
and `live=0` on both explicit backends.

No `../ablac` change was needed. It remained clean and synchronized at
`82a66da3a978d63adbe49922f74eebc76eea892a` after the release gates.

This historical first texture-copy slice did not deliver render/compute or
consolidated submission. The following `d38676f` checkpoint adds the first
narrow recorded render and eligible single-submission Vulkan replay; compute,
frames in flight, and GPU-completion retention remain later milestone-5 work.

## Published checkpoint: recorded render and one Vulkan submission

Implementation commit `d38676f` delivers the next bounded milestone-5 slice:

- `GraphicsGraphCommandList.recordRenderTarget(...)` records one procedural
  offscreen draw and moves its affine `GraphicsRenderTarget` and
  `GraphicsRenderPipeline` into command-list ownership;
- imported render resources are accepted only with declared write access and
  an exact storage-descriptor match; descriptor sealing deliberately excludes
  labels;
- eligible Vulkan streams encode graph memory barriers, a 2D transient texture
  copy, and the render into one retained command buffer and make exactly one
  queue submission per complete replay;
- OpenGL keeps ordered direct replay, and unsupported-but-valid Vulkan copy
  shapes retain the direct fallback;
- direct copy/render APIs remain validated begin/record/submit wrappers;
- Vulkan separately tracks transfer health and queue-submission acceptance.
  Failures before acceptance restore provisional layout tracking. Accepted work
  remains reflected in layout/submission bookkeeping even if completion wait
  fails, while the graph does not claim completion and the device becomes
  unhealthy;
- counter additions and direct submission requirements are checked before
  partial work, and invalid direct rendering is rejected before beginning a
  command buffer.

The current render record is intentionally narrow: exactly one single-sample
color attachment, no depth or resolves, procedural vertices, no bind group, and
no push constants. Consolidated copies are currently 2D with `z = 0` and
`depth = 1`. Compute, broader render/copy records, asynchronous submission,
GPU-completion-aware retention, and frames in flight remain open.

### Verified evidence

The combined proof stream contains four pass markers, one transient texture
copy, and one render. Across explicit OpenGL, explicit Vulkan, and automatic
selection it reports:

- six of six commands and exact center pixel `4294281759`;
- exact copied RGBA word `4280427042`;
- all three rejection checks passing: invalid direct render, incompatible
  record, and incompatible replay;
- 1,001 successful list replays and 1,003 completed graph executions;
- four barriers in the last execution, 4,012 logical barriers total, and 3,009
  batched backend barrier calls;
- zero Vulkan submissions on OpenGL and exactly 1,001 on Vulkan;
- stable graph texture, render target, and pipeline handles with zero warmed
  live-byte growth.

Verification completed on 2026-08-25:

```bash
nix-shell --run 'make check-abla-only test-core test-vulkan test-graph-commands'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

The final focused gate passed after the submission-acceptance bookkeeping
review. A dedicated `VK_LAYER_KHRONOS_validation` replay of the final binary
returned the expected status and produced a zero-line validation log. The full
aggregate `make all` gate passed. The no-cache sample gate rebuilt all 42
example roots and ran the full OpenGL/Vulkan live matrix. The new
`examples/recorded-graph-render` reported `6/6`, exact render/copy output,
`1001/1003` list/graph executions, `4/4012/3009` barriers,
`submissions=0` on OpenGL or `1001` on Vulkan, stable handles, and `live=0`.

No `../ablac` change was needed. It remained clean and synchronized at
`82a66da3a978d63adbe49922f74eebc76eea892a`.

### Immediate continuation sequence

1. Generalize planner-visible buffers from the delivered imported single-
   binding form to multiple compute bindings and bounded transient-buffer
   pooling/aliasing without warmed allocation.
2. Generalize render records to buffered/indexed/indirect forms, bind groups,
   push constants, depth, resolves, MRT, and subpasses without unbounded command
   variants or warmed allocation.
3. Generalize consolidated Vulkan texture copies beyond the current 2D slice
   while preserving per-mip/layer layout rollback and accepted-submission
   semantics.
4. Introduce GPU-completion-aware resource retention and bounded frames in
   flight, replacing synchronous per-replay waiting without weakening affine
   ownership.
5. Add independent compute/render and deferred-rendering samples with exact
   outputs, stable resources, native submission counts, validation silence, and
   frame-rate/memory evidence.
6. Continue the larger milestone/coverage/platform work in `plan.md`; do not
   mark the persistent goal complete after this checkpoint.

## Current checkpoint: planner buffers and sealed compute push data

This working checkpoint generalizes typed graph materialization with
`GraphicsGraphBufferDeclaration` and
`GraphicsApplication.materializeRenderGraphResources(...)`. Exactly one
exclusive texture or buffer declaration is required per logical resource.
Buffers are imported-only in this slice: their descriptor size must match the
planner resource size, while transient buffer declarations reject before pool
creation.

Recorded compute now names that logical buffer and requires the current pass to
declare exact `graphAccessReadWrite`. The moved buffer descriptor and the
pipeline's retained native binding must agree, so ordinary planner hazards can
drive backend barriers without claiming transient buffer pooling. The new
`recordComputeStoragePush(...)` copies reflected push bytes into preallocated
128-byte-per-command native storage. Push size and bytes join the sealed
fingerprint, so changing the source constants after recording cannot alter
replay. `GraphicsComputePipeline.dispatchRaw(...)` is the checked internal
bridge used by direct OpenGL replay; consolidated Vulkan records the same bytes
without an extra submission.

The focused compute proof uses two passes over one imported logical buffer. Its
read/write-to-read dependency derives exactly one barrier per replay. It rejects
transient and size-mismatched buffer declarations, a pipeline bound to a
different native buffer, and post-seal handle mutation. It also rejects an
oversized post-seal push-size mutation before fingerprinting. After sealing
add-one, it changes the source constant to seven yet reaches exact value `1001`
over 1,001 replays with exact barrier counts `1/1001/1001`, stable buffer/
pipeline/command-pool identities, zero warmed live-byte growth, zero OpenGL
Vulkan submissions, and exactly 1,001 Vulkan submissions. The independent
sample seals add-three, changes its source value to nine, and reaches exact
value `3003` with the same barrier, identity, allocation, and submission
guarantees.

Verified on the working source on 2026-08-26:

- `make test-core test-graph-texture test-graph-commands` passed;
- the independent sample passed both explicit backends after a direct
  unresolved-library audit with `LD_LIBRARY_PATH` removed;
- forced `VK_LAYER_KHRONOS_validation` replay returned the expected status and
  produced a zero-line validation log;
- the complete `make all` aggregate passed, including the Abla-only audit and
  direct runtime-linkage gate with `unresolved=0`; and
- the final 43-root no-cache `make test-samples` matrix rebuilt every sample,
  audited every canonical executable with `LD_LIBRARY_PATH` removed and found
  zero unresolved libraries, then passed the complete live OpenGL/Vulkan
  matrix. The modified sample retained exact `3003`, `snapshot=true`,
  `1/1001/1001` barriers, zero/1,001 submissions, stable handles, and `live=0`.

After final review added the bounded push-metadata rejection, the focused gate,
zero-line Vulkan validation replay, complete `make all`, and complete 43-root
no-cache build/link/live matrix were all rerun successfully on that exact final
source. The focused result reports `tamper=true/true` on every backend
selection.

Current intended checkpoint paths are `src/compute.ab`,
`src/graph_texture.ab`, `src/graph_commands.ab`,
`tests/graph_commands/main.ab`, `examples/recorded-graph-compute/main.ab`,
`README.md`, `docs/api.md`, `docs/architecture.md`,
`docs/render-graph-textures.md`, `docs/render-graph-commands.md`,
`docs/status.md`, `plan.md`, and this handoff. No `../ablac` change is needed
so far; verify its clean state again before publication.

## Published checkpoint: recorded storage compute and direct launches

Implementation commit `57492c65287bfba25da8c3b7d938dbb0bd26d2b0`
adds `GraphicsGraphCommandList.recordComputeStorage(...)`.
It moves one binding-zero storage buffer and the exact pipeline created against
that native buffer into affine command-list ownership, seals workgroup counts
and concrete native identities, rejects a mismatched bound buffer and post-seal
pipeline-handle mutation, and replays without warmed allocation. OpenGL uses
the existing direct dispatch and memory barrier. Eligible Vulkan lists record
the dispatch into the retained device command buffer and submit once.

`VulkanComputePipeline.recordDispatch(...)` is the non-submitting primitive;
the existing direct `dispatch(...)` remains its wrapper. The pipeline now
retains the bound storage handle and tracks health plus queue-submission
acceptance so direct-fallback failure accounting does not confuse accepted work
with completed work.

The first form deliberately has one storage binding and no push constants. Its
buffer is not yet a logical planner resource, so general buffer hazards and
sharing one affine buffer across multiple records remain open.

Published implementation files are `src/compute.ab`, `src/driver/vulkan.ab`,
`src/graph_commands.ab`, `tests/graph_commands/main.ab`,
`examples/recorded-graph-compute/`, `tools/test-samples.sh`, `README.md`,
`docs/api.md`, `docs/architecture.md`, `docs/render-graph-commands.md`,
`docs/status.md`, `plan.md`, `shell.nix`, `Makefile`,
`tools/test-runtime-linkage.sh`, and this handoff.

This checkpoint also fixes direct launch of Nix-built applications. The old
executables retained only mkShell's transient synthetic RUNPATH, so Vulkan,
X11, EGL, and OpenGL were unresolved after leaving the shell. `shell.nix` now
adds the concrete loader directories, and `make test-runtime-linkage` builds a
combined headless application, clears `LD_LIBRARY_PATH` and project discovery
overrides, audits its dependencies, and launches it directly. Keep this gate in
the aggregate suite; a sample that runs only while inheriting the development
shell is not distributable evidence.

Verified on the final source: focused OpenGL/Vulkan/auto graph-command tests produce exact
storage value `1001` through 1,001 replays, zero/1,001 Vulkan submissions,
stable buffer/pipeline/command-pool handles, mismatch/tamper rejection, and
`live=0`; the independent sample passes both explicit backends; Vulkan
validation is silent with a zero-line log; and the final `make all` passes. The
complete 43-root no-cache sample matrix builds every sample, audits every
canonical executable with `LD_LIBRARY_PATH` removed, then passes the complete
live OpenGL/Vulkan matrix in that stripped environment. The direct-linkage gate
also clears all project graphics discovery overrides and starts both headless
backends. No `../ablac` change was required; it remained clean and synchronized
at `82a66da3a978d63adbe49922f74eebc76eea892a`.

## Published typed materialization foundation

The published tip includes typed render-graph texture materialization from
commit `b7d09cd` and its handoff commit `cdde6a1`.

That checkpoint turns the pure planner's logical transient slots into retained
native textures:

- `GraphicsMaterializedRenderGraph` owns one capacity-one
  `GraphicsTexturePool` and one live lease per physical graph slot;
- compatible resources with non-overlapping lifetimes reuse one stable native
  texture, while overlapping or incompatible resources do not alias;
- complete texture descriptors are rechecked above the planner's integer
  compatibility class;
- execution tokens enforce strict `plan.order` and declared resource access;
- transient upload/readback/copy/sampling and caller-owned imported textures
  are supported without transferring imported ownership;
- 1,000 warmed executions retain stable native identities and zero live-byte
  growth.

Its focused test, validation-layer run, full `make all`, and 39-sample matrix
passed before publication. `docs/render-graph-textures.md` is the detailed
contract.

## Verified checkpoint: ordered render-graph memory barriers

Implementation commit `deecaa3` adds conservative backend memory dependency
execution before each ordered materialized graph pass.

### Intended public behavior

- Start an execution with `graph.beginExecution()`.
- Enter every planned pass using
  `app.beginMaterializedRenderGraphPass(graph, token, passId)`.
- The application call validates the exact next `plan.order` entry, combines
  all logical barriers targeting that pass, executes one backend memory
  barrier when needed, and advances the logical pass only after native success.
- Perform the existing direct render, compute, copy, upload, or readback work
  for that pass.
- Finish with `graph.completeExecution(token)`.

`graph.beginPass()` remains the planner's logical-only primitive. It does not
execute a native barrier and must not be used as the physical execution entry
point by barrier-aware applications.

### Current backend mapping

- OpenGL makes the retained context current and calls `glMemoryBarrier` with a
  conservative combination of all relevant lower barrier bits.
- Vulkan maps graph read/write access to conservative memory read/write masks,
  uses the all-commands stage, records a memory barrier through the device's
  retained transfer command state, and submits through its existing
  synchronization2/fallback path.
- The graph layer does not duplicate image-layout transitions. Existing
  texture/render/copy operations still own exact Vulkan layout transitions.
- The current Vulkan graph-barrier path is synchronous because it builds on the
  existing direct-submission architecture. This is a correct first execution
  layer, not the final high-throughput frame encoder.
- Counters distinguish logical barriers from backend barrier calls:
  `currentExecutionBarriers`, `lastExecutionBarriers`,
  `totalExecutedBarriers`, and `backendBarrierCalls`.

### Files delivered

Core and backends:

- `src/graph_execute.ab` — barrier intent mapping, per-pass aggregation, strict
  ordered entry, native dispatch, and counters;
- `src/graph_texture.ab` — execution barrier observability;
- `src/graphics.ab` — public composition of graph execution;
- `src/driver/opengl.ab` — retained-context `glMemoryBarrier` call;
- `src/driver/vulkan.ab` — retained-command memory barrier submission.

Tests and samples:

- `tests/graph_execute/main.ab`, `tests/graph_execute/abla.toml` — sampled
  upload to imported offscreen target, post copy, exact full readback, ordering
  rejection, barrier counts, stable identities, and 1,000 warmed executions;
- `tools/test-graph-execute.sh` and `Makefile` — focused gate and aggregate
  integration;
- `tests/graph_texture/main.ab` — existing typed graph coverage now enters
  passes through the barrier-aware API;
- `examples/graph-post-process/main.ab` and its `abla.toml` — independent
  upload/render/copy/readback graph workflow;
- `examples/materialized-render-graph/main.ab` — existing sample migrated to
  the barrier-aware entry point;
- `tools/test-samples.sh` — new sample in the explicit OpenGL/Vulkan matrix.

Documentation:

- `docs/render-graph-execution.md` — detailed execution contract;
- `docs/render-graph-textures.md`, `docs/api.md`, `docs/architecture.md`,
  `docs/status.md`, and `README.md` — updated public claims and navigation.

### Verified evidence

The following focused runs passed during development:

```bash
./tools/test-core.sh
nix-shell --run 'make test-graph-texture'
nix-shell --run 'make test-graph-execute'
```

Observed results include:

- explicit OpenGL, explicit Vulkan, and automatic backend selection;
- exact rendered and copied RGBA value `4281541137` across the complete 16x16
  readback in `graph-execute`;
- strict out-of-order rejection without a backend barrier call;
- `graph-execute`: 3 barriers in the primary execution and 3,003 logical
  barriers/backend calls after 1,001 executions;
- a second live two-resource graph reports 2 incoming logical barriers and
  exactly 1 backend barrier call, proving destination-pass batching;
- `graph-texture`: 4,004 logical barriers/backend calls after 1,001
  executions;
- stable native texture identities and one retained pool acquisition per graph
  slot;
- zero `runtimeMemoryLiveBytes()` growth across the warmed loops;
- synchronization2 counter growth on the Vulkan path;
- both `examples/materialized-render-graph` and
  `examples/graph-post-process` passed direct OpenGL and Vulkan runs.

The combined source audit, core test, graph-texture test, graph-execute test,
and Vulkan validation-layer run also completed successfully while this handoff
was being written. `build/tests/graph-execute-validation.log` contained zero
lines, and the validation run returned the same exact pixel, copy, 3/3,003
barrier, 2/1 batching, stable-handle, 1,001-execution, and `live=0` evidence.
The final implementation tree passed:

```bash
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

The no-cache sample gate rebuilt all 40 example roots independently and ran its
complete Wayland/headless plus explicit OpenGL/Vulkan matrix. Both graph
samples passed on both backends. `graph-post-process` reported the exact
16x16 output, `3/3003/3003` barriers, 1,001 executions, stable handles, and
`live=0`. The older materialization sample reported `2002/2002` barriers,
one retained pool acquisition, a stable native handle, and `live=0`.

Follow-up implementation commit `6ba1ec5` compiles per-pass barrier counts and
source/destination access unions into bounded primitive arrays, and pass entry
indexes those arrays instead of rescanning every planner barrier. Focused core,
graph-texture, and graph-execute gates pass with exact `0/1/1/1` and `0/2`
schedules on OpenGL, Vulkan, and auto. Its full `make all` and 40-root no-cache
`make test-samples` gates pass. A dedicated Vulkan validation run produced zero
validation-log lines and retained exact output, `3/3003/3003` barrier counts,
`2/1` batching, stable handles, and `live=0`.

No `ablac` source change was needed for this checkpoint. Recheck the sibling
repository is still clean and synchronized before beginning compiler-dependent
work.

Suggested focused validation command:

```bash
nix-shell --run 'make check-abla-only test-core test-graph-texture test-graph-execute'
validation_log=build/tests/graph-execute-validation.log
validation_out=build/tests/graph-execute-validation.out
: > "$validation_log"
set +e
VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
  xvfb-run -a -s "-screen 0 800x600x24" \
  build/tests/graph-execute vulkan \
  >"$validation_out" 2>"$validation_log"
status=$?
set -e
test "$status" -eq 42
! rg -q 'Validation Error|VUID-|ERROR' "$validation_log"
wc -l "$validation_log"
cat "$validation_out"
```

Mandatory final gates for this checkpoint:

```bash
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

There are 40 independently rebuilt example directories at this checkpoint.
The sample count in older commits or handoffs may be lower; the filesystem and
`tools/test-samples.sh` are authoritative.

## Milestone 5 direction after the published recorded-render slice

Pass markers, transient 2D copies, a narrow owned procedural render, and one
submission for an eligible Vulkan replay are published. Submission is still
synchronous, while compute and most render resource/command forms remain direct.

The later layers should:

1. Add typed compute, broader render/copy, query, and debug command records
   without turning the bounded slice into an unbounded variant type.
2. Record a complete graph/frame without managed allocation after warm-up.
3. Preserve exact image-layout responsibility without double transitions as
   more copy/render forms join the consolidated command stream.
4. Support frames in flight and retain every
   borrowed resource until GPU completion.
5. Keep direct encoders and raw escape hatches available.
6. Prove exact multi-pass output, native barrier/submission counts, stable
   command resources, Vulkan validation silence, and zero steady-state live
   allocation on OpenGL and Vulkan.
7. Deliver independently buildable deferred-rendering and compute/render
   samples using the real recorded command path.

## Major remaining work from `plan.md`

The project remains far from its final definition of done. Major open areas
include:

- complete window/input/monitor/clipboard/cursor/DPI/fullscreen behavior and
  pure-Abla Win32 and Cocoa platform/surface implementations;
- broader OpenGL 4.6 and Vulkan 1.4 core/extension implementation, callable
  generated raw APIs, feature-chain/capability negotiation, and fully
  classified coverage ledgers;
- the remaining GLSL 4.60 grammar and stages, includes/modules, precise source
  spans, reflection, specialization constants, interface validation,
  deterministic dual-backend generation, and shader/pipeline caches;
- reusable command encoders, frames in flight, presentation scheduling,
  descriptor reuse, backend-private heap allocation/suballocation, persistent
  pipeline caches, and device-loss/context-reset recovery;
- geometry/tessellation, mesh/task, ray tracing, acceleration structures,
  multiview, variable-rate shading, sparse/external resources, video, device
  groups, protected work, calibrated timestamps, shader objects, and vendor
  extensions behind queried capabilities;
- Linux/Windows/macOS CI, golden image comparison, validation jobs, fuzzing,
  repeatable startup/resource/transfer/submission/frame/memory benchmarks, and
  reproducible signed releases;
- the planned learning/sample catalog: camera/mesh/material/glTF, particles,
  shadows, HDR/PBR, deferred rendering, UI/text, multi-window/monitor,
  profiler, raw backend labs, stress benchmark, complete 2D game, complete 3D
  application, and Abla Mobile/native-surface proof.

Do not treat a wide enum or raw-token surface as completion of any of these
areas.

## Files to care about

Public/common implementation:

- `src/graphics.ab` — public module composition;
- `src/core.ab` — configuration, adapters, limits, features, errors;
- `src/application.ab` — backend selection and application ownership;
- `src/resources.ab` — portable descriptors and validation;
- `src/buffer.ab`, `src/texture.ab`, `src/binding.ab`, `src/render.ab`, and
  `src/compute.ab` — common GPU resources and render/compute contracts;
- `src/transfer.ab`, `src/texture_transfer.ab` — fixed-slot asynchronous
  transfers;
- `src/pool.ab`, `src/texture_pool.ab` — bounded retained reuse;
- `src/graph.ab` — pure dependency/lifetime/barrier/alias planner;
- `src/graph_texture.ab` — typed physical texture materialization and ordered
  execution tokens;
- `src/graph_execute.ab` — direct and non-submitting Vulkan graph memory-barrier
  execution.
- `src/graph_commands.ab` — verified bounded pass/copy/render recording,
  affine render ownership, sealing, graph/descriptor binding, direct and
  consolidated replay, submission accounting, and diagnostics.

Native/platform implementation:

- `src/driver/opengl.ab`, `src/driver/vulkan.ab` — primary backend resource,
  command, synchronization, and presentation paths;
- `src/driver/opengl_transfer.ab`, `src/driver/vulkan_transfer.ab` — retained
  transfer-slot patterns worth following;
- `src/platform/x11.ab`, `src/platform/wayland.ab` and neighboring platform
  modules — direct native windowing/event implementation;
- `src/raw/` — generated/audited raw declarations; do not hand-edit generated
  registry modules.

Shaders:

- `src/shader/glsl.ab` — `$glsl` parser, reflection, and OpenGL source;
- `src/shader/glsl_spirv.ab` — deterministic Vulkan SPIR-V generation;
- `tests/glsl_subparser.ab`, `tools/test-glsl.sh` — compiler-facing shader
  evidence.

Tests, samples, and public claims:

- `tests/graph_texture/`, `tools/test-graph-texture.sh`;
- `tests/graph_execute/`, `tools/test-graph-execute.sh`;
- `tests/graph_commands/`, `tools/test-graph-commands.sh` — focused
  recording/replay/rejection/abort/no-growth evidence;
- `examples/materialized-render-graph/`;
- `examples/graph-post-process/`;
- `examples/recorded-graph-copy/` — independently buildable sealed-copy proof;
- `tools/test-samples.sh` — independent `--no-cache` sample build/live matrix;
- `Makefile` — authoritative gate aggregation;
- `registry/audit/*.tsv` — reviewed coverage inputs;
- `tools/update-registry.sh` — deterministic registry generation;
- `registry/coverage/*.md`, `src/raw/*_registry.ab` — generated outputs;
- `README.md`, `docs/api.md`, `docs/architecture.md`, `docs/status.md`,
  `docs/render-graph-commands.md`, `docs/specification-baseline.md`, `plan.md`,
  and this file — public contract and claim surface;
- `tools/check-abla-only.sh` — mandatory no-C implementation audit.

## Working commands

Use the repository Nix environment and the sibling compiler. Start focused,
but never publish from focused tests alone.

Useful commands:

```bash
nix-shell --run 'make check-abla-only test-core'
nix-shell --run 'make test-graph-texture test-graph-execute test-graph-commands'
nix-shell --run 'make test-glsl test-application'
nix-shell --run 'make test-runtime-linkage'
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make all'
nix-shell --run 'make test-samples'
```

After the focused graph-command binary has built, run Vulkan validation against
the exact binary that `tools/test-graph-commands.sh` produces:

```bash
validation_log=build/tests/graph-commands-validation.log
validation_out=build/tests/graph-commands-validation.out
: > "$validation_log"
set +e
VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
  xvfb-run -a -s "-screen 0 800x600x24" \
  build/tests/graph-commands vulkan \
  >"$validation_out" 2>"$validation_log"
status=$?
set -e
test "$status" -eq 42
! rg -q 'Validation Error|VUID-|ERROR' "$validation_log"
test ! -s "$validation_log"
cat "$validation_out"
```

Review and publish with explicit paths:

```bash
git status --short --branch
git diff --check
git diff --stat
git diff -- <explicit paths>
git add <explicit paths>
git diff --cached --check
git diff --cached --stat
git diff --cached -- <explicit paths>
git commit -m '<checkpoint message>'
git push origin main
git fetch origin main
git rev-parse HEAD
git rev-parse origin/main
git status --short --branch
```

If `../ablac` changes, use the same explicit-path discipline there and publish
that dependency first.

## Design cautions worth preserving

- Immutable class copies can allocate in current Abla. Descriptor/object APIs
  are ergonomic setup paths; warmed loops should use scalar state and retained
  resources.
- Never allocate `GraphicsGraphBarrierIntent` per logical barrier in the hot
  executor. It is useful as an inspection value, not as the execution record.
- A materialized graph retains one capacity-one texture-pool lease per physical
  slot for its entire life. Do not introduce per-pass acquire/release churn.
- Planner compatibility classes are opaque hints. Physical materialization
  must continue to recheck the complete texture descriptor before aliasing.
- Imported textures are borrowed. The graph must never move or destroy them.
- Sampled binding entries snapshot native handles. Keep the graph or imported
  owner alive until derived bind groups and submitted work are complete.
- Vulkan 3D textures use physical z/depth in one array subresource; 2D arrays
  and cubes use array layers. Layout state is tracked per mip/layer.
- Caller padding must remain untouched on readback. Queue capacity refers to
  tight active bytes, while caller footprints are validated independently.
- The graph memory barrier is a visibility dependency, not an image-layout
  transition. Do not double-transition images already managed by concrete
  texture/render/copy operations.
- `completeExecution()` intentionally does not call `waitIdle()` per frame.
  Resource retention and eventual submission completion must stay explicit.
- Generated coverage files are reproducible output. Change audit manifests or
  generators and run `make update-registry`; never edit generated ledgers by
  hand.

## `abla-doom` side quest

The homage project is already implemented and published separately. Its clean
proof screenshot is:

```text
/home/andre/Desktop/projects/abla-doom/screenshots/abla-doom.png
```

Do not modify or republish `abla-doom` unless the user explicitly reopens that
scope. If it is reopened, keep its implementation Abla-only and retain a clean
repository screenshot showing only the Doom window as proof.

## Completion rule

Continue through verified, reviewable checkpoints and publish them as the
framework grows. Do not mark the persistent goal complete merely because a
checkpoint compiles, passes focused tests, broadens a declaration surface, or
renders one sample.

The goal is complete only when every milestone and the definition of done in
`plan.md` are genuinely satisfied: pleasant common APIs, complete supported
platform behavior, working OpenGL and Vulkan backends, classified raw
specification coverage, source-accurate deterministic shader tooling,
validated advanced features, extensive live samples, measured performance,
portable CI, reproducible releases, and a clean synchronized published state.
