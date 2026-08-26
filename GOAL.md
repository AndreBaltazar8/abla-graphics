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
- Published tip before the render-push checkpoint:
  `5a9bda60bee797f5e8bfb371192055fb1db0b133`
  (`Update graphics continuation handoff`).
- Render-push implementation commit:
  `c78b5d7e7158b10cf1647f879dca5602377e256f`
  (`Snapshot recorded render push values`).
- Procedural-depth implementation commit:
  `38c99cc908e2fff49b93273f9379b50bc9ff7b46`
  (`Record procedural graph depth rendering`).
- Buffered-depth implementation commit:
  `caf5712cdfad28841acdc6f35ff645b255bb6911`
  (`Support depth across recorded draw forms`).
- Recorded-resolve implementation commit:
  `b7c8a35bf2e6f004ddf352ed9fa58a4b3a15a079`
  (`Record multisample graph resolves`).
- Recorded-MRT implementation commit:
  `12ed3138edb421c4fa23d3672f9d3755df0d5f68`
  (`Record generalized MRT attachments`).
- Buffered-MRT implementation commit:
  `c3125a41fbe95a00414e9c904af8e142e33b0fce`
  (`Compose buffered draws with MRT attachments`).
- Published tip before the recorded-subpass checkpoint:
  `1a231b41c11bf92ca3c676f0334d6bef6d2dc3ff`
  (`Update graphics continuation handoff`).
- Recorded-subpass implementation commit:
  `f69c0ba12b6f756bbdb7a7c2bb6941df9d25bddc`
  (`Record graph subpass sequences`).
- Published tip before the reflected-subpass checkpoint:
  `b6b7d82644fa155fc161d8d2da20ef4620441d9f`
  (`Update graphics continuation handoff`).
- Reflected-subpass implementation commit:
  `c5f777fa2f854f9a454c4202df81e54660890935`
  (`Snapshot recorded subpass values`).
- Published tip before the indirect-render checkpoint:
  `dbfe351beac81c3ced54198791f643db565e61a2`
  (`Update graphics continuation handoff`).
- Indirect-render implementation commit:
  `27b91f31ca853e0ca4a4af869b5db68bf2191423`
  (`Record indirect graph rendering`).
- Published tip before the buffered-render checkpoint:
  `39b54a776703666ac21d528c3cb09909c8a519ec`
  (`Update graphics continuation handoff`).
- Buffered-render implementation commit:
  `c527dc9bc49fcf676f9873903d890639d7fe809a`
  (`Record buffered graph rendering`).
- Published tip before the multi-binding/transient-buffer checkpoint:
  `29a7be7dd17bd3eedeaf3d9797d8a6220523bf28`
  (`Update graphics continuation handoff`).
- Multi-binding/transient-buffer implementation commit:
  `d5adb4aa8776cebb742b1dabe14e96eace4389cb`
  (`Add transient graph compute bindings`).
- Published and synchronized recorded-compute/direct-linkage implementation:
  `57492c65287bfba25da8c3b7d938dbb0bd26d2b0`.
- Earlier bounded-command implementation checkpoint:
  `08d481ad5105c03b4858d341ffed31d606ce09cc`.
- Relevant published implementation commits are `deecaa3` (`Execute render
  graph barriers`), `6ba1ec5` (`Compile render graph barrier schedules`),
  `08d481a` (`Record bounded render graph commands`), and `d38676f`
  (`Consolidate recorded graph rendering`), `57492c6` (`Record graph compute
  and fix direct launches`), and `f9609a5` (`Record planner buffers and compute
  push data`).
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
- HEAD remains synchronized, but the worktree currently contains substantial
  unrelated in-progress compiler/parser/LLVM/MMIO changes. Preserve them and
  stage nothing in `../ablac` for this graphics checkpoint. The recorded
  subpass implementation itself required no compiler source change.
- At the 2026-08-26 subpass verification, the concurrently replaced
  `build/ablac.bin` recognized `type` as a reserved token while checked-in
  compiler/GLSL parser sources still used `type` as an identifier. For the
  focused build only, a clean `git archive HEAD` sysroot plus the older
  pure-Abla `build/ablac-pure-self` artifact was used inside `nix-shell`.
  Recheck the active compiler before the next build; do not overwrite or
  revert the unrelated compiler work. That historical compiler needs the Nix
  shell for `libssl.so.3`, while the produced graphics sample itself passed
  `ldd` with `LD_LIBRARY_PATH` removed.

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

## Published checkpoint: recorded vertex and indexed rendering

Implementation commit `c527dc9bc49fcf676f9873903d890639d7fe809a`
adds `recordRenderVertices(...)` and `recordRenderIndexed(...)` without changing
the low-level drivers. Each record moves its target, pipeline, and
planner-declared imported vertex/index buffers into one affine
`GraphicsGraphRenderResources` group. The containing pass must declare buffer
reads and target writes; exact descriptors, usage bits, aligned byte ranges,
counts, native identities, and draw form participate in validation and the
sealed fingerprint.

OpenGL replay calls the retained scalar render encoder directly. Vulkan records
the same buffer handles, counts, instances, and offsets into the graph's one
consolidated command buffer. An initial convenience-API replay allocated one
temporary `Color` per execution; the focused no-growth test exposed it, and
the final scalar replay removes that allocation.

Focused evidence on the published implementation source:

- `make test-graph-commands` passes OpenGL, Vulkan, and automatic selection;
- the new proof produces exact vertex and indexed center pixels `4294281759`,
  rejects a sealed native vertex-buffer handle mutation before execution,
  performs 1,001 successful replays, uses zero/1,001 OpenGL/Vulkan submissions,
  and reports `live=0`;
- forced `VK_LAYER_KHRONOS_validation` replay returns the same evidence without
  a validation message;
- `make check-abla-only` passes; and
- `examples/recorded-graph-buffered-render` builds with its own native-library
  manifest, has no unresolved `ldd` dependency with `LD_LIBRARY_PATH` removed,
  and runs both explicit backends with exact output and `live=0`.

Important paths are `src/graph_commands.ab`,
`tests/graph_commands/main.ab`, `tools/test-graph-commands.sh`,
`examples/recorded-graph-buffered-render/`, `tools/test-samples.sh`, and the
render-graph API/status/architecture documentation. The complete sample list
now contains 45 roots, but the full matrix has not been rerun for this focused
slice. Continue using the efficient validation policy below: review and publish
future focused checkpoints with targeted evidence, beginning with reflected
push render records. No `../ablac` change has been required.

## Published checkpoint: recorded indirect rendering

Implementation commit `27b91f31ca853e0ca4a4af869b5db68bf2191423`
adds `recordRenderVerticesIndirect(...)` and
`recordRenderIndexedIndirect(...)`. Their affine resource groups own the exact
planner-declared 16-byte draw or 20-byte indexed-draw command buffer in
addition to vertex/index storage. Pass read access, usage, aligned ranges,
native identities, offsets, and indirect form are validated and sealed.

OpenGL replays `glDrawArraysIndirect` or `glDrawElementsIndirect` through the
existing scalar encoder. Vulkan records `vkCmdDrawIndirect` or
`vkCmdDrawIndexedIndirect` into the same consolidated command buffer. Explicit
form validators replace a generic resource loop that incorrectly rejected the
third indexed-indirect buffer; this keeps each supported ownership shape exact
and auditable.

Focused evidence on the published implementation source:

- `make test-graph-commands` passes OpenGL, Vulkan, and automatic selection;
- both indirect forms produce exact center pixel `4294281759`, reject sealed
  indirect-buffer handle mutation, replay 1,001 times with `live=0`, and report
  zero/1,001 OpenGL/Vulkan submissions; and
- `examples/recorded-graph-indirect-render` has its own native-library manifest,
  passes `ldd` with `LD_LIBRARY_PATH` removed, and runs both explicit backends
  with forms `3/4`, exact output, stable counters, and no live growth.

Important paths are `src/graph_commands.ab`,
`tests/graph_commands/main.ab`, `examples/recorded-graph-indirect-render/`,
`tools/test-samples.sh`, and the public graph documentation. The sample list
now contains 46 roots; the full matrix is intentionally reserved for the next
broad/sample-infrastructure coverage checkpoint. Continue with recorded
reflected push values. No `../ablac` change was required.

## Published checkpoint: recorded reflected render push values

Implementation commit `c78b5d7e7158b10cf1647f879dca5602377e256f`
adds a separate bounded render-push arena and matching `Push` APIs for
procedural, direct, indexed, vertex-indirect, and indexed-indirect graph render
records. Recording requires an exact reflected layout and copies at most 128
bytes per command. Push size and every copied byte join the sealed fingerprint;
replay reads only command-owned native storage.

The focused proof records the two extreme forms (procedural and
indexed-indirect) with a red reflected tint, mutates the source values to green,
and still renders exact red RGBA8 word `4278190335`. Oversized sealed metadata
rejects before execution. OpenGL, Vulkan, and auto each complete 1,001 replays
with exact output and `live=0`; Vulkan submits once per replay.

`examples/recorded-graph-push-render` independently builds with its
native-library manifest, has no unresolved dependency with `LD_LIBRARY_PATH`
removed, and reports the same snapshot/exact/submission/no-growth evidence on
both explicit backends. The sample list now contains 47 roots. Important paths
are `src/graph_commands.ab`, `tests/graph_commands/main.ab`, the new sample,
`tools/test-samples.sh`, and the graph API/status/architecture documentation.
No `../ablac` change is required; preserve its unrelated LLVM/MMIO work.

## Published checkpoint: multi-binding compute and transient graph buffers

Implementation commit `d5adb4aa8776cebb742b1dabe14e96eace4389cb`
generalizes `GraphicsComputePipeline` to retain an affine
`GraphicsBindGroup`. `computeBindingPipeline(...)` validates the exact
reflected resources, required capabilities, portable pure-Abla SPIR-V
emission, and workgroup limits. OpenGL dispatch uses precomputed bind arrays;
Vulkan uses the retained descriptor-set layout/set without transferring layout
ownership to the pipeline. The strict portable dual-storage shader proof
performs `destination.value += sourceData.value` with writable binding zero
and readonly binding one. Existing empty and binding-zero storage pipeline
forms remain source-compatible.

Recorded graph compute now supports one to 16 imported buffer bindings through
`recordComputeBindings(...)` and graph-owned transient bindings through
`recordTransientComputeBindings(...)`, with matching push forms. Sealing binds
every logical resource, caller/native buffer identity, retained bind-group
identity, descriptor, access, workgroup, and push byte. Caller-owned arrays move
into affine resource groups. Transient records borrow exact buffer-pool ranges
from the graph and reject duplicate logical IDs or aliased physical slots in
one dispatch.

Materialized graphs now own separate texture and buffer pool maps. A transient
buffer must be device-local, unmapped, no larger than one GiB, and compatible
in complete logical storage descriptor with anything reusing its planner slot.
Pool block size/capacity are chosen without overflow and stay within 65,536
blocks. Compatible disjoint lifetimes reuse one native buffer; overlaps,
cross-kind aliases, descriptor mismatches, and usage absent from the retained
backing reject. `storageGraphBufferEntry(...)` and
`uniformGraphBufferEntry(...)` expose the exact retained range.

The Vulkan consolidated recorder now permits a pending per-execution barrier
count while command recording is active; completed totals are still updated
only after queue submission is accepted. This fixes the previously latent case
where a barrier followed by another pass invalidated the graph before submit.
The active count is bounded by the compiled plan barrier count.

Verified evidence on the published implementation source:

- `make test-glsl test-application` proves direct two-buffer compute on explicit
  OpenGL, explicit Vulkan, auto Vulkan, and fallback OpenGL with exact values
  `7/27/5` and zero warmed live-byte growth;
- `make test-graph-commands` proves imported values `5007/5`, transient slot
  mapping `0/1/0`, exact transient result `5007`, one barrier per replay,
  zero/1,001 OpenGL/Vulkan submissions, stable native identities, one retained
  allocation per physical pool, sealed identity/backing tamper rejection, and
  zero live growth through 1,001 replays on OpenGL/Vulkan/auto;
- `make test-graph-texture` passes unchanged texture ownership, aliasing, and
  execution regression evidence;
- `make check-abla-only test-runtime-linkage` passes with
  `runtime-linkage direct=true unresolved=0`; and
- `examples/recorded-graph-transient-compute` independently builds and runs
  both explicit backends with `LD_LIBRARY_PATH` removed, no unresolved shared
  libraries, exact `5007`, slots `0/1/0`, stable handles, and `live=0`.

The uninterrupted `make all` release gate passed on 2026-08-26. It includes
the Abla-only source audit, all core/window/backend/transfer/pool/graph tests,
the direct runtime-linkage audit, debug checks, and registry generation. Four
broad compiler invocations (`test-core`, `test-headless`,
`test-wider-texture`, and `test-wider-sampling`) now use an isolated 8 GiB
default ceiling after the expanded source exceeded their old 6 GiB ceiling;
the ordinary compiler limit is unchanged. A forced
`VK_LAYER_KHRONOS_validation` graph replay produced no validation messages.

The changed sample was then re-audited and run directly with the inherited
`LD_LIBRARY_PATH` removed. `ldd` reported no `not found` dependencies and both
OpenGL and Vulkan runs reported four of four commands, exact result `5007`,
slots `0/1/0`, `1/1001/1001` barriers, stable handles, and `live=0`.

Important paths are `src/compute.ab`, `src/driver/opengl.ab`,
`src/driver/vulkan.ab`, `src/shader/glsl_spirv.ab`, `src/graph_texture.ab`,
`src/graph_commands.ab`, `tests/application/main.ab`,
`tests/glsl_subparser.ab`, `tests/graph_commands/main.ab`,
`examples/recorded-graph-compute/`,
`examples/recorded-graph-transient-compute/`, `tools/test-samples.sh`, and the
public documentation. No `../ablac` change has been required; it remains clean
and synchronized at `82a66da3a978d63adbe49922f74eebc76eea892a`.

The complete 44-root no-cache sample rebuild was deliberately not repeated
after this already-complete aggregate gate: only the new sample/build manifest
changed, and that executable received the stricter focused direct-link and
dual-backend live check above. `tools/test-samples.sh` includes it in the next
scheduled complete sample matrix. Do not mark the persistent goal complete.

### Efficient validation policy

Keep implementation moving with change-driven gates. While developing, run
the smallest focused test that executes the changed path, plus the affected
backend when backend code changes. Run `make all` once at a publication
checkpoint, not after each edit. Run the full no-cache sample matrix when
sample infrastructure, shared-library embedding, broad public interfaces, or
window/platform behavior changes, and at periodic coverage checkpoints; do not
rerun it merely to duplicate an unchanged aggregate gate. For a direct-launch
regression, prioritize `make test-runtime-linkage`, `ldd` with
`LD_LIBRARY_PATH` removed, and an actual clean-environment launch of the
affected executable.

### Immediate continuation sequence

1. Generalize render records to bind groups without unbounded command variants
   or warmed allocation.
2. Generalize consolidated Vulkan texture copies beyond the current 2D slice
   while preserving per-mip/layer layout rollback and accepted-submission
   semantics.
3. Introduce GPU-completion-aware resource retention and bounded frames in
   flight, replacing synchronous per-replay waiting without weakening affine
   ownership.
4. Add independent generalized-render and deferred-rendering samples with exact
   outputs, stable resources, native submission counts, validation silence,
   and frame-rate/memory evidence.
5. Continue the larger milestone/coverage/platform work in `plan.md`; do not
   mark the persistent goal complete after this checkpoint.

## Published checkpoint: procedural graph depth

Recorded procedural renders now accept an owned depth-capable target through
`recordRenderTargetDepth(...)` and `recordRenderTargetDepthPush(...)`. Both
color and depth are explicit imported graph resources: their exact descriptors
must match the owned attachments, and the active pass must declare write access
to both. Depth presence must also match enabled pipeline depth state. The depth
identity participates in the sealed fingerprint and replay validation.

The focused OpenGL/Vulkan/auto graph gate rejects depth-ID mutation, preserves
snapshotted push values, renders exact red RGBA8 `4278190335`, and completes
1,001 replays with `live=0`; Vulkan remains one submission per replay.
`examples/recorded-graph-depth-render` independently exercises the non-push
API. Its no-cache executable has no unresolved `ldd` entries with
`LD_LIBRARY_PATH` removed and passes both explicit backends with exact output,
zero growth, and zero/1,001 OpenGL/Vulkan submissions. The explicit sample
matrix now contains 48 roots. No `../ablac` change was required; preserve its
unrelated LLVM/MMIO work.

## Published checkpoint: buffered graph depth

The four buffered render methods and all four matching `Push` forms now accept
one final optional depth resource ID. A nonnegative ID reuses the same exact
imported descriptor, pass-write, enabled-pipeline, sealed-fingerprint, and
active-resource checks as procedural depth without creating eight new methods.
Existing calls remain source-compatible through the default `-1` value.

The focused boundary proof records direct vertices and indexed-indirect push
with separate planner-visible depth attachments. OpenGL, Vulkan, and auto each
reject depth-ID mutation, preserve snapshotted red output, render exact RGBA8
`4278190335`, and complete 1,001 replays with `live=0`; Vulkan remains one
submission per replay. The existing depth sample now demonstrates the buffered
public call, rebuilds without unresolved shared libraries when
`LD_LIBRARY_PATH` is removed, and passes both explicit backends. No `../ablac`
change was required.

## Published checkpoint: recorded MSAA resolve

`recordRenderTargetResolve(...)` and `recordRenderTargetResolvePush(...)` now
own and replay a single-color multisample target while naming both its imported
multisample source and single-sample resolve output in the graph. Exact
descriptors, pass writes, activity, and sealed identities are validated before
execution. The push proof rejects resolve-ID mutation, preserves copied red
values, and resolves exact RGBA8 `4278190335` through 1,001 OpenGL/Vulkan/auto
replays with `live=0` and zero/1,001 submissions.

`examples/recorded-graph-resolve-render` independently exercises the non-push
API. Its no-cache executable has no unresolved `ldd` entries with
`LD_LIBRARY_PATH` removed and passes both explicit backends; forced Vulkan
validation is silent. The sample matrix now contains 49 roots. No `../ablac`
change was required.

## Published checkpoint: recorded MRT attachments

`recordRenderTargetAttachments(...)` and its `Push` form record two to eight
ordered imported colors, zero resolves or one resolve per color, and optional
depth. Bounded per-render arrays extend the existing primary attachment IDs.
Every attachment must be distinct, active, declared for pass write,
descriptor-compatible with the owned target, and unchanged after sealing.

The focused proof combines two 4x colors, two single-sample resolves, depth,
and copied push data. OpenGL, Vulkan, and auto resolve exact red/green RGBA8
`4278190335/4278255360`, reject additional-resolve mutation, and complete 1,001
replays with `live=0`; Vulkan stays at one submission. The independent MRT
sample has no missing `ldd` dependency without `LD_LIBRARY_PATH` and passes
OpenGL plus silent validation-layer Vulkan. The matrix now contains 50 roots.
No `../ablac` change was required.

## Published checkpoint: buffered recorded MRT

Four affine factories now build typed direct, indexed, vertex-indirect, or
indexed-indirect `GraphicsGraphRenderResources`. The generalized
`recordRenderAttachments(...)` and `recordRenderAttachmentsPush(...)` methods
compose one such owned draw with the published color/resolve/depth attachment
set. This covers every buffered form without adding eight attachment-specific
method variants; the older convenience methods remain source-compatible.

The focused MRT gate now uses indexed-indirect push and preserves its exact
red/green resolved output, snapshot, tamper rejection, `live=0`, and
zero/1,001 submission evidence on OpenGL/Vulkan/auto. The existing independent
MRT sample now uses the direct-vertex factory and passes its no-cache stripped-
`LD_LIBRARY_PATH` build plus OpenGL and validation-layer Vulkan launches. No
new sample root or `../ablac` change was required.

## Published checkpoint: recorded graph subpasses

`recordRenderSubpasses(...)` records one ordered two-to-eight-stage procedural
sequence while taking affine ownership of its target, compatible render pass,
and pipelines. Ordered color/resolve IDs plus optional depth remain visible to
the graph planner, exact descriptor and pass-write checks run at record, seal,
and replay, and all native identities participate in the sealed fingerprint.
OpenGL executes stages in order. Vulkan records the native render pass and all
subpasses into the graph's retained command buffer, preserving one submission
per complete replay.

The focused gate rejects sealed depth-ID and cached Vulkan sequence-handle
mutation, then produces exact RGBA8 `4294281759` through 1,001 OpenGL/Vulkan
replays with `live=0` and zero/1,001 submissions.
`recordRenderPushSubpasses(...)` adds a bounded 1,024-byte command-owned copy of
the reflected per-stage aggregate. The focused proof mutates its source after
sealing, rejects sealed size metadata mutation, and keeps the exact result with
the same replay/submission evidence.
`examples/recorded-graph-subpasses` independently repeats the reflected public
workflow; its no-cache executable has no unresolved `ldd` entry with
`LD_LIBRARY_PATH` removed and passes both backends. The sample matrix remains
51 roots. No graphics implementation uses C, GLFW, SDL, or a native shim.

## Current checkpoint: planner-visible recorded subpass buffers

Implementation commit `746c144632cd2d328e54eb31d1a8f39cd61dc3f9`
adds this slice.
`recordRenderBindingSubpasses(...)` owns the compatible target, render pass,
ordered pipeline sequence, and a `graphSubpassBufferResources(...)` table.
Every per-stage bind-group entry maps to one unique imported graph buffer; the
same affine buffer may be shared across stages. Record, seal, and replay check
the graph declaration, pass access, usage, byte range, backend handle, stage
map, and sealed fingerprint. OpenGL replays in order and Vulkan retains one
command buffer and one submission per complete graph replay.

The strict `$glsl` path now lowers the procedural std140 `mat4` transform
vertex form to embedded validated SPIR-V in Abla. The focused test consumes two
different GPU uniform buffers, rejects sealed stage-map mutation, and produces
exact RGBA8 `4294281759` across 1,001 OpenGL, Vulkan, and automatic-selection
replays with `live=0` and zero/1,001 submissions.
`examples/recorded-graph-binding-subpasses` is the independent public proof,
bringing the sample matrix to 52 roots. Sampled textures and combined push plus
bind-group subpasses remain follow-up work. No graphics implementation uses C,
GLFW, SDL, or a native shim.

Focused validation used the pinned pure-Abla compiler and clean sysroot because
the concurrent `../ablac/build/ablac.bin` currently reserves `type`. The graph
command executable passed OpenGL, Vulkan, and automatic selection. The sample
passed both explicit backends for 1,001 replays, and its direct `ldd` audit with
`LD_LIBRARY_PATH` removed found no unresolved library. `make check-abla-only`
and `git diff --check` passed. The unrelated dirty `../ablac` worktree was not
staged, changed, or committed by this checkpoint.

## Published checkpoint: planner buffers and sealed compute push data

Implementation commit `f9609a5485d0ec9f178e85a9517532270d27ce96`
generalizes typed graph materialization with
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

Published checkpoint paths are `src/compute.ab`,
`src/graph_texture.ab`, `src/graph_commands.ab`,
`tests/graph_commands/main.ab`, `examples/recorded-graph-compute/main.ab`,
`README.md`, `docs/api.md`, `docs/architecture.md`,
`docs/render-graph-textures.md`, `docs/render-graph-commands.md`,
`docs/status.md`, `plan.md`, and this handoff. No `../ablac` change was needed;
it remained clean and synchronized at
`82a66da3a978d63adbe49922f74eebc76eea892a`.

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
- A transient buffer slot retains one bounded buffer-pool allocation for the
  graph lifetime. Keep texture/buffer pool maps distinct and reject cross-kind
  aliasing before native allocation.
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
- Every independently buildable native sample needs an `abla.toml`
  `nativeLibraries` manifest. Keep `make test-runtime-linkage` and the sample
  matrix's stripped-`LD_LIBRARY_PATH` `ldd`/launch audit: building only inside
  the Nix shell is not proof that users can launch the executable directly.

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
