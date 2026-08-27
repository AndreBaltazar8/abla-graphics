# Abla Graphics goal and continuation handoff

Updated: 2026-08-27 (Europe/Lisbon).

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
- Published and synchronized ordinary recorded-render binding implementation:
  `748160757a5d972b260b921857f586858e1098b0`
  (`Retain bindings for recorded renders`).
- Published and synchronized recorded sampled-compute implementation:
  `9395497a9c998e7466a05beb134b781730eb6bc5`
  (`Record sampled compute bindings`).
- Published and synchronized recorded storage-image implementation:
  `fb6cead83378687fc912cafb10ec0911cc2e7e5c`
  (`Add recorded storage image compute`).
- Published and synchronized storage-image-view/read-write implementation:
  `27358b310ddaf4f3977bd7065c892d3f3c954e80`
  (`Add read-write storage image views`).
- Published and synchronized extended-format/fragment-image implementation:
  `37b2bea591135c3bb13cf627fecea147767b0bed`
  (`Add extended fragment storage images`).
- Published and synchronized layered storage-image implementation:
  `1dc051f41700c9c1e8f96a7057d64c0e735f9d9d`
  (`Add layered storage images`).
- Published and synchronized full storage-dimension implementation:
  `79a27e52d19a9399823622a695ce6ab0dc42619f`
  (`Complete storage image dimensions`).
- Published and synchronized generated pushed-image implementation:
  `8d00c94744b0223f63f52f3ee75a9df11cae1fd7`
  (`Generate pushed storage image writes`).
- Published and synchronized generated image-arithmetic implementation:
  `1608cc9f94db8a8a588de0fa9f012bdc76150cef`
  (`Generate storage image read arithmetic`).
- Published and synchronized layered retained-copy implementation:
  `28fc5b4250a2c3a0c503706ca40833e3ca4749ce`
  (`Consolidate layered graph copies`).
- Published and synchronized storage-image SSA implementation:
  `a770a257819893f0a478871541451fdc100826c1`
  (`Compose storage image SSA locals`).
- Published and synchronized storage-image expression-program implementation:
  `19b8965231bbb7f851f1fcb813c20b61fd59f51c`
  (`Parse storage image expression programs`).
- Published and synchronized storage-image builtin implementation:
  `b1bc3302277d5c872e4b58e97066186fc5f8696c`
  (`Emit storage image constructors and builtins`).
- Published and synchronized computed image-coordinate implementation:
  `330a43ee754b442c306741e1f653177cfda33cb9`
  (`Generate computed storage image coordinates`).
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
  `4924bb782bc621cd3cd8a89d3216c51269550650`
  (`Add pointer scalar native void calls`).
- HEAD is synchronized with `origin/master` and the worktree is clean. The
  concurrent scalar-global/export program-build work was independently
  published first as `e40193b6a1a6d022d07dc5fb70eeaa9eb7ac6a85`;
  this checkpoint then published only its owned native-call paths in
  `e584ad0f58ec877e05fba9c6d10e8106f8468a9e`,
  `d30a3fe5e28c2b6de5fe6fe73685321aec7a8f89`, and
  `4924bb782bc621cd3cd8a89d3216c51269550650`.
- At the 2026-08-26 subpass verification, the concurrently replaced
  `build/ablac.bin` recognized `type` as a reserved token while checked-in
  compiler/GLSL parser sources still used `type` as an identifier. For the
  focused build only, a clean `git archive HEAD` sysroot plus the older
  pure-Abla `build/ablac-pure-self` artifact was used inside `nix-shell`.
  Recheck the active compiler before the next build; do not overwrite or
  revert the unrelated compiler work. That historical compiler needs the Nix
  shell for `libssl.so.3`, while the produced graphics sample itself passed
  `ldd` with `LD_LIBRARY_PATH` removed.
- During the ordinary-render checkpoint, concurrent compiler work removed the
  historical `build/ablac-pure-self` artifact. The final gate successfully
  used the current pure-Abla `build/ablac` launcher. Those historical compiler
  paths remained untouched by this graphics work.

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

At that historical checkpoint the render record was intentionally narrow:
exactly one single-sample
color attachment, no depth or resolves, procedural vertices, no bind group, and
no push constants. Consolidated copies were 2D with `z = 0` and `depth = 1`;
the later `28fc5b4` checkpoint removes that copy restriction. Compute, broader
render records, asynchronous submission,
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

1. Introduce GPU-completion-aware resource retention and bounded frames in
   flight, replacing synchronous per-replay waiting without weakening affine
   ownership.
2. Extend storage-image programs with mutable statements/control flow and
   additional typed image operations without regressing to fixed templates.
3. Add independent generalized-render and deferred-rendering samples with exact
   outputs, stable resources, native submission counts, validation silence,
   and frame-rate/memory evidence.
4. Continue the larger milestone/coverage/platform work in `plan.md`; do not
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
bringing the sample matrix to 52 roots. Sampled textures remain follow-up work.
No graphics implementation uses C, GLFW, SDL, or a native shim.

Focused validation used the pinned pure-Abla compiler and clean sysroot because
the concurrent `../ablac/build/ablac.bin` currently reserves `type`. The graph
command executable passed OpenGL, Vulkan, and automatic selection. The sample
passed both explicit backends for 1,001 replays, and its direct `ldd` audit with
`LD_LIBRARY_PATH` removed found no unresolved library. `make check-abla-only`
and `git diff --check` passed. The unrelated dirty `../ablac` worktree was not
staged, changed, or committed by this checkpoint.

### Combined retained buffers and push snapshots

Implementation commit `07fdb8eeaa33b5e34efb71ae4499ecc6dd1df9d3`
adds this composition.
`recordRenderBindingPushSubpasses(...)` composes the planner-visible affine
buffer table with the bounded command-owned per-stage push snapshot. A shared
uniform buffer may feed multiple stages while every stage retains its own
descriptor set and push range. Direct OpenGL replay binds both resources before
each draw; Vulkan records both descriptor and `vkCmdPushConstants` operations
inside the graph's single retained command buffer.

The focused test mutates the source push aggregate after sealing, rejects a
sealed logical buffer-ID mutation, and keeps exact RGBA8 `4294281759` through
1,001 OpenGL, Vulkan, and automatic-selection replays with `live=0` and
zero/1,001 submissions. No new sample root or compiler change was needed.

### Planner-visible sampled textures and samplers

Implementation commit `6eb6c55f086f88545be50d8a28eaad2e66309ff1`
adds this resource form.
The binding resource table now composes imported buffers, full sampled
textures, and affine samplers. `graphSubpassTextureResources(...)` is the
texture-only convenience factory; `graphSubpassBindingResources(...)` accepts
mixed typed tables. Per-stage indices resolve against the table implied by each
reflected bind-group entry. Record, seal, replay, and fingerprint validation
cover logical IDs, exact descriptors, read access, sampled usage, native
texture/sampler identities, stage maps, and attachment alias rejection.

The strict `$glsl` translator now includes a procedural textured vertex form
with constant position/UV arrays and a real location-zero varying. The focused
gate selects two different 1x1 sampled resources across two recorded stages,
rejects sealed map mutation, and preserves exact RGBA8 `4294281759` through
1,001 OpenGL, Vulkan, and automatic-selection replays with `live=0` and
zero/1,001 submissions. `examples/recorded-graph-texture-subpasses` repeats the
public path, passes both explicit backends, and has no unresolved direct `ldd`
entry with `LD_LIBRARY_PATH` removed. The sample matrix now has 53 roots.

Graph-owned transient sampled textures remain the next binding-resource
extension. No C, GLFW, SDL, or native shim is used.

### Imported sampled texture views

Implementation commit `b2dfdc198fe2f8d77909361846d29d0d7bbf7cb5`
adds affine view ownership.
`graphSubpassTextureViewResources(...)` takes affine ownership of each imported
parent texture, native view, and sampler. Its stage mapping is encoded into the
same sealed kind-specific table, while exact parent descriptors, graph reads,
sampled usage, native texture/view/sampler identities, attachment separation,
and every mapping participate in record, replay, and fingerprint validation.

The focused gate uses two different native views, rejects sealed view-map
mutation, and preserves exact RGBA8 `4294281759` through 1,001 OpenGL, Vulkan,
and automatic-selection replays with `live=0` and zero/1,001 submissions. No
new sample root or compiler change was needed. Graph-owned transient sampled
textures are now the remaining sampled subpass ownership form.

### Graph-owned transient sampled textures

Implementation commit `dce5189586770002b9a193423b81241e13115d27`
adds retained transient sampling.
`sampledRetainedGraphTextureEntry(...)` builds a bind-group entry against the
materialized graph's stable one-slot texture-pool lease before command
recording. `graphSubpassTransientTextureResources(...)` owns the sampler,
captures the logical resource and physical identity, and maps stage entries
into the same sealed binding table without taking ownership away from the
graph. Record and replay require a transient sampled color declaration, exact
pass read access, a valid retained lease, matching descriptor and native
identity, and attachment separation.

The focused gate initializes the transient resource through the public graph
write API, rejects sealed map mutation, and preserves one pool acquisition,
one physical identity, exact RGBA8 `4294281759`, and `live=0` through 1,001
OpenGL/Vulkan/auto replays with zero/1,001 submissions.
`examples/recorded-graph-transient-texture-subpasses` independently repeats the
public workflow, passes both explicit backends, and has no unresolved direct
`ldd` entry with `LD_LIBRARY_PATH` removed. The sample matrix now has 54 roots.

### Ordinary recorded render bindings

The command recorder now accepts one typed planner-visible binding-resource
table alongside any existing procedural, direct, indexed, direct-indirect, or
indexed-indirect draw form through `recordRenderBindingAttachments(...)` and
`recordRenderBindingAttachmentsPush(...)`. This closes the ordinary-render
ownership gap without adding texture-specific methods for every draw form.
Imported buffers, full sampled textures, explicit views, graph-owned transient
sampled textures, and samplers use the same logical/native validation as
recorded subpasses. The command seal fingerprints the bind group, retained
owners, logical IDs, and one-stage mapping; replay checks active graph
resources without constructing temporary attachment arrays.

`examples/recorded-graph-texture-render/` brings the sample matrix to 55 roots.
Its focused gate compiled with the current pure-Abla compiler and launched with
`LD_LIBRARY_PATH` removed. OpenGL, Vulkan, and automatic selection all rendered
exact RGBA8 `4294281759`, rejected a post-seal stage-map mutation, completed
1,001 successful replays with zero warmed live-byte growth, and reported
zero/1,001 Vulkan submissions. A first OpenGL measurement exposed 72 bytes of
growth per replay from temporary validation arrays; the final implementation
removes those allocations rather than weakening the performance proof.

### Recorded sampled compute bindings

The same typed retained table now drives recorded compute through
`recordComputeBindingResources(...)` and its push form. Imported buffers, full
sampled textures, explicit views, graph-owned transient sampled textures, and
samplers use one stage map and one seal/replay ownership contract. The Abla
`$glsl` translator gained a deterministic compute-visible `sampler2D` plus
storage-buffer subset; its Vulkan SPIR-V is valid and byte-stable while OpenGL
executes the same source directly.

`examples/recorded-graph-texture-compute/` brings the sample matrix to 56 roots.
Its focused direct-link gate passed OpenGL, Vulkan, and automatic selection,
rejected post-seal map mutation, accumulated exact value `1001` across 1,001
successful replays, reported zero/1,001 Vulkan submissions, and retained
`live=0`. Storage-image bindings are not claimed by this checkpoint: their
OpenGL image-unit ABI, Vulkan storage-image descriptor/layout path, reflection,
and `imageLoad`/`imageStore` lowering remain the immediate continuation.
Buffer, imported texture, imported view, and transient-texture recorded subpass
forms are now covered; no C, GLFW, SDL, or native shim is used.

### Recorded storage-image compute

Implementation commit `fb6cead83378687fc912cafb10ec0911cc2e7e5c`
is published on `origin/main`.

The next binding family is now implemented end to end. The common capability
and affine bind-group API expose an explicit storage-texture kind and
read-only/write-only/read-write access values; the currently reflected `$glsl`
subset deliberately accepts write-only RGBA8 `image2D`. OpenGL binds the image
unit directly and emits the shader-image barrier bit. Vulkan creates descriptor
type 3, uses `GENERAL`, and performs a one-time all-subresource transition
before the retained pipeline is created.

`graphSubpassStorageTextureResources(...)` owns imported textures without fake
samplers. Record, seal, and replay validate graph access, usage, exact
descriptor/native identity, entry access, stage mapping, activity, and the
storage texture fingerprint. The deterministic pure-Abla translator lowers
the exact red `imageStore` program to valid byte-stable SPIR-V.

`examples/recorded-graph-storage-image-compute/` brings the sample matrix to 57
roots. Its focused binary had no unresolved `ldd` entries with
`LD_LIBRARY_PATH` removed. OpenGL, Vulkan, and automatic selection all produced
RGBA8 `4278190335`, rejected post-seal map mutation, completed 1,001 successful
replays with zero warmed live-byte growth, and reported zero/1,001 Vulkan
submissions. `make check-abla-only test-core test-glsl test-graph-commands`
passed. No `../ablac` source change was required. Broader storage-image
formats/dimensions and fragment-stage images remain follow-up work; do not mark
the persistent goal complete.

### Published checkpoint: storage-image views and read-write lowering

Implementation commit `27358b310ddaf4f3977bd7065c892d3f3c954e80`
is published on `origin/main`.

Image reflection now retains `rgba8` plus `readonly`/`writeonly`/unqualified
access, and bind-group matching rejects format or access mismatch before driver
pipeline work. The deterministic pure-Abla emitter supports a read-write
`image2D` program that loads one texel and stores its red/green channels swapped.

`storageTextureViewEntry(...)` accepts an affine parent plus exact one-mip,
one-layer 2D view. OpenGL binds the re-indexed view object; Vulkan uses the
caller-owned image view and transitions only its selected parent subresources
to `GENERAL`. `graphSubpassStorageTextureViewResources(...)` owns the parent and
view, encodes view indices internally, and validates/fingerprints graph access,
descriptor, native identities, access, and stage mapping.

`examples/recorded-graph-storage-image-view-compute/` brings the sample matrix
to 58 roots. The focused stripped-linkage gate passed OpenGL, Vulkan, and auto
with exact green RGBA8 `4278255360`, sealed-map tamper rejection, 1,001
successful replays, zero warmed live-byte growth, and zero/1,001 Vulkan
submissions. An initial correct-output run exposed 416 bytes of live growth per
replay from redundant descriptor validation; the retained validator now uses
scalar creation-time-validated state and passes `live=0`.
`make check-abla-only`, `make test-application test-headless test-glsl
test-graph-commands`, and the prior write-only storage-image sample all passed.
No `../ablac` source change was required.

### Published checkpoint: extended-format and fragment storage images

Implementation commit `37b2bea591135c3bb13cf627fecea147767b0bed`
is published on `origin/main`.

The portable feature mask now distinguishes base storage images,
fragment-stage stores, and extended shader-image formats. Vulkan queries and
enables `fragmentStoresAndAtomics` and `shaderStorageImageExtendedFormats`;
OpenGL advertises both on the framework's 4.3+ execution path. Entry creation
rejects vertex-stage storage images or a fragment/extended-format request whose
capability was not actually enabled.

Reflection and exact bind-group matching cover R8/RG8/RGBA8 unorm plus
R16/RG16/RGBA16/R32/RG32/RGBA32 float 2D images. The deterministic pure-Abla
emitter adds exact R32F compute and RGBA8 fragment store programs. OpenGL emits
the image/storage barrier after render writes; Vulkan tracks shader read/write
access for storage images resting in `GENERAL` before transfer readback.

`examples/recorded-graph-storage-image-r32f-compute/` and
`examples/fragment-storage-image/` bring the sample matrix to 60 roots. Their
stripped-linkage OpenGL/Vulkan/auto runs passed with exact IEEE `1.0f`, exact
green storage output, exact red color output, 1,001 repetitions, sealed-map
rejection for retained compute, zero/1,001 Vulkan graph submissions, and
`live=0`. The enlarged composition root crosses the historical 6 GiB compiler
guard, so the isolated no-cache sample gate now uses 8 GiB; no `../ablac`
source change was required. `make check-abla-only test-core test-glsl
test-application test-headless` passed, as did optimized no-cache builds and
stripped-link live runs of the two new samples plus fast no-cache regressions
of both prior storage-image samples. Broader image dimensions and general
expression lowering remain follow-up work.

### Published checkpoint: layered array and volume storage images

Implementation commit `1dc051f41700c9c1e8f96a7057d64c0e735f9d9d`
is published and synchronized on `origin/main`.

Storage binding/reflection now maps `image1D`, `image2D`, `image2DArray`,
`image3D`, and `imageCube`, including signed and unsigned forms, to the exact
portable texture dimension. Whole textures and one-mip affine views share that
validation. OpenGL retains the required `glBindImageTexture` layered flag for
array, 3D, and cube entries; Vulkan retains the matching image or view type.
The sealed graph fingerprint checks this dimension-derived native identity.
OpenGL 3D texture views now correctly expose the selected mip's physical depth.

The pure-Abla deterministic `$glsl` path adds one exact compute program with a
write-only RGBA8 `image2DArray` and RGBA8 `image3D`. The new
`examples/recorded-graph-layered-storage-images/` sample brings the matrix to
61 roots. It rejects a sealed stage-map swap between the two differently
dimensioned resources, replays 1,001 times, then reads exact green
`4278255360` from array layer two and blue `4294901760` from volume slice one.
Optimized no-cache OpenGL, Vulkan, and automatic-selection runs passed with
`LD_LIBRARY_PATH` removed, no unresolved `ldd` entry, zero warmed live-byte
growth, and zero/1,001 Vulkan submissions. `make check-abla-only`, the core
suite, and the isolated GLSL subparser build/run also passed. The new GLSL
assertions are grouped under one named Boolean because extending the already
very deep final test conjunction directly exposed a compiler expression-depth
crash; no `../ablac` change was needed.

The next storage-image slice was deterministic 1D/cube emission, now published
below. General image coordinate/value expression lowering remains. Keep the
next gate similarly focused unless shared sample infrastructure or linkage
changes.

### Published checkpoint: complete storage-image dimensions

Implementation commit `79a27e52d19a9399823622a695ce6ab0dc42619f`
is published and synchronized on `origin/main`.

The deterministic pure-Abla translator now also emits one exact RGBA8
`image1D` plus RGBA8 `imageCube` compute program. Cube storage has its own
portable `graphicsFeatureCubeStorageTextures` bit: OpenGL 4.3+ advertises it,
while Vulkan reports it only when `VkPhysicalDeviceFeatures.imageCubeArray` is
available and enables that exact feature before the SPIR-V `ImageCubeArray`
capability reaches pipeline creation. Binding and compute-pipeline feature
checks propagate the requirement, so unsupported devices reject early.

`examples/recorded-graph-storage-image-dimensions/` brings the matrix to 62
roots. Its OpenGL, Vulkan, and automatic-selection runs reject a sealed map
swap, replay 1,001 times, and read exact red `4278190335` from the 1D image and
magenta `4294902015` from cube face four, with zero warmed live-byte growth and
zero/1,001 Vulkan submissions. The optimized no-cache executable had no
unresolved `ldd` entry and ran with `LD_LIBRARY_PATH` removed. The core suite,
isolated GLSL subparser build/run, Abla-only audit, and independent Khronos
`spirv-val --target-env vulkan1.0` validation of the emitted reference module
passed. No compiler source or dirty `../ablac` path was changed.

All five portable storage-image dimensions now have live driver evidence. The
next shader slice began replacing exact coordinate/color recognition with
typed runtime values and is published below.

### Published checkpoint: generated runtime storage-image values

Implementation commit `8d00c94744b0223f63f52f3ee75a9df11cae1fd7`
is published and synchronized on `origin/main`.

The translator now has a generated storage-image path rather than another
precompiled word array. It reflects arbitrary image, push-block, instance, and
member names; derives `int`/`ivec2`/`ivec3` coordinate width and SPIR-V image
dimension from `image1D`, `image2D`, `image2DArray`, `image3D`, or `imageCube`;
uses the real binding and push member offsets; adds the cube capability only
when needed; and emits the load/access-chain/`OpImageWrite` program in Abla.
The accepted initial typed expression is one signed coordinate push member and
one `vec4` value member. Arithmetic, `imageLoad`, and local composition remain
explicitly unfinished.

`examples/recorded-graph-storage-image-push/` brings the sample matrix to 63
roots. Its retained push record snapshots array layer two and yellow before
the host mutates the original coordinate and color. OpenGL, Vulkan, and
automatic selection reject a sealed resource-map mutation, replay 1,001 times,
and read exact yellow `4278255615` with zero warmed live-byte growth and
zero/1,001 Vulkan submissions. The optimized no-cache executable has no
unresolved `ldd` entry and runs with `LD_LIBRARY_PATH` removed.

The main `$glsl` subparser test and a new independently compiled five-dimension
generated-module test both pass. The dimension matrix lives in its own root
because appending it to the historical mega-test reproduced the compiler's
deep composition-root crash; `tools/test-glsl.sh` still runs both, preserving
one public gate while making future shader coverage faster and safer. The
Abla-only audit passes, and no `../ablac` source or dirty path was changed.

### Published checkpoint: generated image read arithmetic

Implementation commit `1608cc9f94db8a8a588de0fa9f012bdc76150cef`
is published and synchronized on `origin/main`.

The generated read/write form now accepts an unqualified RGBA8 storage image,
loads it through `imageLoad` into one arbitrarily named `vec4` local, combines
that local with the reflected runtime value through `+`, `-`, `*`, or `/`, and
feeds the typed result to `imageStore`. Abla emission adds `OpImageRead` and
the selected vector arithmetic instruction; `%` is explicitly rejected. The
independent generated-module root covers every storage-image dimension plus
all four operations without enlarging the historical mega-test again.

`examples/recorded-graph-storage-image-read-add/` brings the sample matrix to
64 roots. It initializes array layer one to blue, snapshots a green runtime
delta, then mutates the host delta to red after sealing. OpenGL, Vulkan, and
automatic selection reject resource-map tampering, replay 1,001 times, and
read exact saturated cyan `4294967040` with zero warmed live-byte growth and
zero/1,001 Vulkan submissions. The optimized no-cache executable has no
unresolved `ldd` entry and runs with `LD_LIBRARY_PATH` removed. The focused
generated-module gate and Abla-only audit pass. No `../ablac` change was made;
that repository independently became clean and synchronized at
`8b6c6e5305049e2e1e2669556909286384eaa009` during this checkpoint.

The next expression slice is broader nesting, multiple locals/statements,
coordinate arithmetic, and typed builtins. Do not claim general GLSL image
expression completion from this bounded but generated read/arithmetic form.

### Published checkpoint: layered and volume retained graph copies

Implementation commit `28fc5b4250a2c3a0c503706ca40833e3ca4749ce`
is published and synchronized on `origin/main`.

`GraphicsGraphCommandList` now keeps every valid recorded texture dimension in
the eligible single-submission Vulkan stream instead of falling back whenever
`z` or `depth` describes more than one 2D slice. Array and cube ranges encode
base layer plus layer count; 3D ranges encode physical source/destination slice
offsets plus depth. Replay forwards the already sealed values rather than
hard-coded zero/one values.

Provisional Vulkan layout tracking verifies a common pre-copy layout across
every affected array layer before recording. If work is not submitted, reverse
rollback restores every affected source and destination layer, not only layer
zero. The existing descriptor/range validation and command fingerprint cover
all mip, origin, and extent fields.

`examples/recorded-graph-copy/` is now a five-record dual proof. In one stream
it copies two 2D-array layers and two physical 3D slices, rejects a valid-looking
sealed depth mutation, reads both destination ranges exactly, and completes
1,001 warmed replays. Explicit OpenGL reports zero submissions; Vulkan reports
exactly 1,001 consolidated submissions. Both report `4/4012/2006` logical
barrier totals/calls, stable native identities, and `live=0`.

Verification completed with:

```bash
nix-shell --run 'make check-abla-only'
nix-shell --run 'make test-graph-commands'
```

The sample was also independently rebuilt with `--no-cache --fast`; `ldd` with
`LD_LIBRARY_PATH` removed reported no unresolved dependency. It ran on both
explicit backends under Xvfb, and the Vulkan run with
`VK_LAYER_KHRONOS_validation` emitted no validation message. No `../ablac`
change was needed for this slice. At handoff, `../ablac` remains at published
commit `8b6c6e5305049e2e1e2669556909286384eaa009` but contains independent uncommitted
changes in `docs/performance.md`, `src/backend/llvm/functions.ab`,
`src/backend/llvm/runtime.ab`, `src/toolchain.ab`, and
`tools/test-import-aliases.sh`; do not stage them as graphics work.

Continue with broader generated GLSL expression composition, query/debug
records, asynchronous GPU-completion retention, and frames in flight. Keep
using independently compiled shader roots and focused live samples so coverage
can expand without repeatedly rebuilding the entire sample matrix.

### Published checkpoint: storage-image SSA result locals

Implementation commit `a770a257819893f0a478871541451fdc100826c1`
is published and synchronized on `origin/main`.

Generated read/write storage-image programs may now assign the typed
`imageLoad` arithmetic result to a second arbitrarily named `vec4` local and
pass that name to `imageStore`. The pure-Abla emitter keeps both locals in SSA,
so the broader source form adds no runtime storage or allocation. Exact token
validation ties the result to the declared load local and rejects an undeclared
source name as well as the existing unsupported-operator case.

The independent `tests/glsl_storage_image_push.ab` root proves the new staged
form emits `OpImageRead`, typed `OpFAdd`, and the resulting image write, while
both invalid forms reject. `examples/recorded-graph-storage-image-read-add/`
now uses two named locals and retains exact cyan `4294967040`, sealed snapshot
and resource-map rejection, 1,001 zero-growth replays, and zero/1,001
OpenGL/Vulkan submissions across explicit OpenGL, explicit validation-enabled
Vulkan, and automatic selection.

The focused optimized no-cache compiler test returned 42, the independently
rebuilt live sample had no unresolved clean-environment `ldd` entry, Vulkan
validation emitted no message, and `make check-abla-only` passed. No `../ablac`
files were modified or staged by this work.

The following `19b8965` checkpoint replaces the bounded two-local recognition
with a typed statement/expression program. Continue from that representation
rather than restoring fixed source templates.

### Published checkpoint: parsed storage-image expression programs

Implementation commit `19b8965231bbb7f851f1fcb813c20b61fd59f51c`
is published and synchronized on `origin/main`.

The read/write image path now lexes and validates its declarations and complete
`main` body, seeds `imageLoad` as a typed `vec4` value in the existing raster
postfix expression IR, and parses as many as fifteen further named `vec4` SSA
locals. Local and final-store expressions preserve parentheses and arithmetic
precedence across arbitrary `+`, `-`, `*`, and `/` chains. Duplicate names,
undeclared references, type mismatches, excess locals, unsupported tokens, and
unconsumed trailing source reject before emission.

The pure-Abla SPIR-V emitter now evaluates the bounded postfix stream with a
checked value stack and dynamically assigned result IDs/bound instead of
selecting one hard-coded arithmetic opcode. The old one-/two-local source
template recognizers were removed. The write-only pushed-image form remains a
separate concise path.

The independent shader test covers every image dimension and single operator,
then proves a parenthesized three-local/four-operation 3D chain with exact
`OpImageRead`, `OpFAdd`, `OpFMul`, `OpFSub`, `OpFDiv`, final store, and module
bound. Invalid operator and undeclared-local programs reject. The live retained
sample uses load plus three named locals and still reports exact cyan
`4294967040`, snapshot/resource-map rejection, 1,001 executions, zero growth,
and zero/1,001 OpenGL/Vulkan submissions across OpenGL, validation-enabled
Vulkan, and automatic selection.

`make check-abla-only test-glsl` passed during the implementation; the final
optimized no-cache focused root returned 42 after obsolete matcher removal.
The rebuilt sample had no unresolved clean-environment `ldd` entry and Vulkan
validation emitted no message. No `../ablac` file was modified or staged.

The following `b1bc330` checkpoint teaches this IR/emitter constructors and
builtins. Continue by generalizing the coordinate operand beyond a direct
reflected push member. Do not regress to source-shape enumeration.

### Published checkpoint: storage-image constructors and builtins

Implementation commit `b1bc3302277d5c872e4b58e97066186fc5f8696c`
is published and synchronized on `origin/main`.

Storage-image value programs now emit scalar and `vec4` constants, scalar-splat
and four-scalar constructors, checked scalar components, four-component
swizzles, dot products, vector/scalar multiply and divide overloads, and the
shared typed extended-builtin set. Extended instructions receive a real
`GLSL.std.450` import, checked arity/result types, and the same explicit scalar
splat rules as raster expressions.

The independent proof composes a full swizzle, component-based constructor,
literal vectors, `clamp`, and `max`; it checks the import/instructions and a
valid dynamic module bound. The retained live sample uses literal lower/upper
vectors and `clamp`/`max` around its existing add/multiply chain while
preserving exact cyan `4294967040`, rejection checks, 1,001 executions,
zero/1,001 submissions, and zero growth.

The first validation-enabled Vulkan run caught an invalid placement of
`OpConstantComposite` inside the function. The emitter was corrected to use
function-body `OpCompositeConstruct`; the rebuilt Vulkan run then completed
1,001 exact replays with no validation message. Explicit OpenGL also completed
the same exact proof. `make check-abla-only test-glsl` passed, the optimized
no-cache executable had no unresolved clean-environment dependency, and no
`../ablac` file was modified or staged.

The following `330a43e` checkpoint replaces the direct coordinate requirement
with a typed signed-integer IR. Continue from that path rather than restoring
verbatim push-member matching.

### Published checkpoint: computed storage-image coordinates

Implementation commit `330a43ee754b442c306741e1f653177cfda33cb9`
is published and synchronized on `origin/main`.

Image load and store coordinates now use an independent signed-integer postfix
IR. It parses bounded `int` plus dimension-matched `ivec2`/`ivec3` locals,
matching-width constructors, checked components, unary signs, parentheses, and
precedence-aware add/subtract/multiply/divide. Vector/scalar multiply and divide
explicitly splat the scalar. Load and store expressions are typed and emitted
independently; the image dimension requires width one, two, or three exactly.

Pure-Abla SPIR-V generation predeclares deduplicated signed constants and emits
checked integer composite/arithmetic operations before passing the resulting
IDs to `OpImageRead` and `OpImageWrite`. Direct reflected coordinates still
take the zero-extra-instruction path. Cross-width local declarations and final
coordinates reject before backend pipeline creation.

The independent test covers computed coordinates for image1D, image2D,
image2DArray, image3D, and imageCube, verifies integer add/multiply plus scalar
subtraction, and rejects `ivec3` for image2D. The retained live array sample
computes a selected `ivec3` through scalar/vector locals and uses separately
emitted load and store expressions. OpenGL, validation-enabled Vulkan, and
automatic selection preserve exact cyan `4294967040`, rejection checks, 1,001
executions, zero/1,001 submissions, and zero warmed growth.

`make check-abla-only test-glsl` passed. The optimized no-cache executable had
no unresolved dependency with `LD_LIBRARY_PATH` removed, and the final Vulkan
run emitted no validation message. No `../ablac` file was modified or staged.

Shift the next broad implementation round to GPU-completion-aware command
retention and bounded frames in flight. Return to shader mutable/control-flow
statements afterward, using these typed value and coordinate IRs as the base.

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

### Published checkpoint: bounded asynchronous graph submissions

Implementation commit:
`477799a1cc1ab1f133fc28ba4a1dc13354924665`
(`Submit recorded graphs across frame slots`).

Eligible consolidated Vulkan graph replay now returns after `vkQueueSubmit2`
acceptance instead of waiting after every replay. The Vulkan device allocates a
fixed eight-command-buffer reserve from its existing transfer pool; each list
activates exactly its configured `framesInFlight` count, retains timeline values
in bounded scalar metadata, waits only on a reused slot, and offers explicit
poll/drain methods. A synchronous transfer drains device slots before resetting
the shared pool. OpenGL remains direct and ordered. No C/C++/Rust shim or GLFW/
SDL dependency was introduced.

`examples/recorded-graph-copy` configures three frames in flight. Its optimized
standalone binary passed explicit OpenGL with `retained=0/0->0` and validation-
layer Vulkan with `submissions=1001 retained=3/3->0`; array and volume output
were exact, `stable=true`, and warmed live-byte growth was zero. Vulkan emitted
no validation diagnostics. `make check-abla-only` passed, and `ldd` reported no
unresolved dependency with `LD_LIBRARY_PATH` removed. Build inside `nix-shell`:
a direct host `make test-graph-commands` cannot find `-lvulkan`, `-lX11`,
`-lEGL`, or `-lGL`, while Nix-built binaries contain the project shell's rpaths
and launch with `LD_LIBRARY_PATH` removed.

The previously recorded combined-gate trap is resolved in the following
checkpoint. It was not a compiler failure: the storage-image expression parser
was speculatively entered for an ordinary storage-buffer/push-constant compute
shader and indexed image-only reflection members before establishing that the
binding was an image. Image lowering now has an explicit reflected-image gate
and guarded member access, with an ordinary storage-push regression. Vulkan
synchronous host reads and writes also wait for accepted asynchronous graph
work before mapping coherent memory. The optimized `make test-glsl
test-graph-commands` gate passes OpenGL, Vulkan, and automatic selection. No
`../ablac` source was changed, and its pre-existing dirty files remain
untouched.

Correctness follow-up commit
`e9463d37e61f88b2433e272426261cd868823dd2`
(`Synchronize asynchronous graph readback`) is published and synchronized on
`origin/main`.

### Mutable storage-image value statements

Implementation commit `05a78dc9c95cf8c3cb6edf0df2994e4c01ca1197`
(`Add mutable storage image locals`) is published and synchronized on
`origin/main`.

The next shader slice extends the generated read/write RGBA8 image program with
typed mutable `vec4` locals. Direct assignment and `+=`, `-=`, `*=`, `/=` reuse
the bounded raster-expression postfix IR and are folded into SSA expressions;
no native shim, source template, runtime local allocation, or compiler change
is involved. The focused GLSL suite covers chained updates and `%=` rejection.
`recorded-graph-storage-image-read-add` now exercises one mutable initialization
plus five updates and retains exact cyan `4294967040`, tamper rejection, 1,001
successful replays, zero warmed live-byte growth, and zero/1,001 Vulkan
submissions on explicit OpenGL, explicit Vulkan, and automatic selection.

### Conditional storage-image value flow

Implementation commit `6d99e2badad7bee9702b402d9243be67da6e2463`
(`Lower conditional storage image values`) is published and synchronized on
`origin/main`.

This checkpoint adds the first structured image value flow. Scalar
floating expressions support all six comparisons in a bounded `if` with an
optional `else`; both branches assign the same mutable `vec4`, and a missing
branch retains the prior SSA value. Vulkan emits scalar/vector boolean types,
an ordered float comparison, the required four-lane condition splat, and
`OpSelect`; OpenGL consumes the original GLSL. Different branch targets and
vector conditions reject. The retained read/add sample now runs a
component `>` if/else and preserves its exact OpenGL/Vulkan/auto result, replay,
submission, tamper, and zero-growth evidence. Nested/general control flow is
still open.

### Verified checkpoint: recorded deferred rendering

Implementation commit `4b350d15cbbf76a07caf21e10b5dea2bac8fa245`
(`Record deferred attachment sampling`) is published and synchronized on
`origin/main`.

Recorded draw resources now compose with
`graphRenderPriorAttachmentResources(...)`. The wrapper keeps sampler ownership
affine while borrowing one to eight color textures from earlier render records
already owned by the same command list. Recording proves each logical read ID
and native binding maps to an earlier primary/additional attachment; activity
checks and the seal fingerprint cover the retained metadata and sampler
identities. Arbitrary external raw-handle borrowing is not accepted.

The pure-Abla deterministic shader translator adds a two-`sampler2D` fragment
form that samples set 0 bindings 0 and 1 and adds their `vec4` values. The 65th
independent sample, `examples/deferred-renderer`, records a buffered fullscreen
MRT geometry pass followed by a sampled lighting pass. OpenGL, Vulkan, and
automatic selection all produced exact red/green G-buffer words
`4278190335/4278255360` and exact yellow lighting `4278255615`, rejected a
post-seal logical-ID mutation, completed 1,001 replays with zero warmed
live-byte growth, and reported zero/1,001 Vulkan submissions. Its executable
also has no unresolved dependency with `LD_LIBRARY_PATH` removed.

### Verified checkpoint: recorded compute-to-render handoff

Implementation commit `dbe20e44c59ffadb0eb1174c31ff6a637731256c`
is published on `origin/main`.

`graphRenderPriorTextureResources(...)` generalizes the list-owned borrow to a
full storage texture retained by an earlier compute binding. Vulkan sampled
entries now snapshot the tracked image layout, allowing a storage+sampled image
to remain in `GENERAL`; the graph's derived write-to-read barrier supplies the
required visibility without a second submission or duplicate owner.

The 66th independent sample, `examples/recorded-compute-render`, writes exact
red in compute and samples it in a later render pass. OpenGL, Vulkan, and
automatic selection each produced the exact compute/render result, rejected a
post-seal ID mutation, completed 1,001 replays with zero warmed live-byte
growth, and reported zero/1,001 Vulkan submissions. The explicit validation-
layer run was silent and the executable has no unresolved dependency with
`LD_LIBRARY_PATH` removed.

### Verified checkpoint: generalized color blending

Implementation commit `c00794414d574da3ffdc8ca9ec146f40d52544c3`
is published on `origin/main`.

The common raster API now has typed source/destination factors, independent
color and alpha add/subtract/reverse/minimum/maximum operations, and RGBA write
masks. `rasterPipelineState(blend = ...)` packs the setup descriptor into the
four-scalar retained raster value; `alphaBlend = true` remains the concise
standard preset. OpenGL maps and restores the full state around each draw,
while Vulkan writes the exact `VkPipelineColorBlendAttachmentState` fields.

The 67th independent sample, `examples/color-blending`, blends half-alpha red
over blue while preserving destination alpha through an RGB-only write mask.
OpenGL produces exact permitted RGBA8 `0xFF7F0080`; Vulkan and automatic
selection produce `0xFF80007F`, a documented one-LSB UNORM rounding difference.
All execute 1,001 renders with zero warmed live-byte growth, invalid state is
rejected, the explicit Khronos validation-layer run is silent, and the binary
launches with `LD_LIBRARY_PATH` removed and no unresolved dependency.

### Verified checkpoint: typed stencil masking

Implementation commit `303b29db71276af654b2b1c1bd19bb1c74a57165`
is published on `origin/main`.

`depthStencilState(stencil = ...)` adds independent front/back compare, fail,
depth-fail, and pass operations plus shared 8-bit read/write masks and reference.
The setup descriptor packs into the fourth retained depth-state scalar. OpenGL
now attaches and clears combined depth/stencil textures, applies separate face
state, and restores masks; Vulkan creates a combined-aspect image view, carries
stencil through compatible render-pass load/store operations, and fills both
native face structures. The framework-local pointer memcpy intrinsic was also
renamed to avoid a latent collision with the newer standard-library intrinsic.

The 68th independent sample, `examples/stencil-masking`, clears stencil to zero,
replaces the drawn triangle with reference one, proves reference-zero rejection,
then proves reference-one acceptance with exact green output over a preserved
blue background. OpenGL, Vulkan, and automatic selection each complete 1,001
three-pass sequences with zero warmed live-byte growth. The forced Khronos
validation-layer run is silent, and the executable resolves every shared
library with `LD_LIBRARY_PATH` removed.

### Verified checkpoint: allocation-free 2D canvas and complete game

Implementation commit `a384f64c0338142e94535fe5053b3f4006b004ac`
is published on `origin/main`.

`PixelBuffer` now provides clipped rectangle fills, rectangle strokes, integer
Bresenham lines, and filled integer circles on its existing affine RGBA8 native
storage. Bounds, dimensions, and channels are checked; invalid geometry cannot
overflow intermediate arithmetic. The methods create no managed frame values.
The graphics-local pointer-copy spelling is now an ordinary pure-Abla adapter
over the compiler-supported standard intrinsic, fixing the previously
unresolved `graphicsUnsafeCopyMemory` symbol in direct `ablac --fast` builds
without changing `../ablac`.

The 69th independent sample, `examples/mini-breakout`, completes plan catalog
item 18. It is a playable fixed-step Breakout game with portable arrows/A/D,
Escape, and Space/Enter controls; bricks, collision, score, lives, latched
win/loss, and reset states; deterministic automated paddle control and explicit
simulation-transition checks; and a single reusable software frame presented
unchanged through OpenGL or Vulkan. Its independently built normal release path
completed 1,001 frames at the observed 4,322 FPS on OpenGL, 1,780 FPS on
validation-enabled Vulkan, and 1,860 FPS under automatic selection on the
current machine. Every run reported exact simulation success and zero
managed-live-byte growth. A separate no-cache `--fast` build also linked and
passed all three modes; its timing is a compiler-mode compatibility result, not
the retained performance benchmark.

Focused evidence passed:

```bash
nix-shell --run 'make check-abla-only test-core'
# independent no-cache builds in both normal and --fast compiler modes
# OpenGL, Vulkan, and auto: 1,001 frames, repeatNoGrowth=true, liveDelta=0
# Vulkan: VK_LAYER_KHRONOS_validation with an empty diagnostic log
# env -u LD_LIBRARY_PATH ldd: no unresolved shared library
```

`tools/test-samples.sh` now independently builds the game and runs it on both
explicit backends. The full 69-root no-cache matrix was deliberately not
repeated for this focused API/sample checkpoint. At this handoff `../ablac`
briefly contained unstaged `src/ir.ab` and
`tests/cases/modules/nested-if-expression.ab` changes outside this checkpoint;
they were not touched here and were subsequently resolved outside this work.
The sibling is clean and synchronized at the current handoff. No compiler
change was needed for this work.

### Verified checkpoint: typed viewport and scissor state

Implementation commit `f337c2be002ae370008b8994a8e946fb14473bd8`
is published on `origin/main`.

`GraphicsViewport` and `GraphicsScissor` are immutable, typed, top-left raster
descriptors with strict dimensions and target-fit validation. Viewports include
portable `[0, 1]` minimum/maximum depth. Their disabled defaults resolve to the
complete pipeline target. `RasterPipelineState` retains both recipes, so the
same state follows direct surface, offscreen target, subpass, and recorded
pipeline use without adding commands or frame allocation.

OpenGL converts top-left Y to its framebuffer convention, applies viewport,
depth range, and scissor immediately before drawing, disables scissoring around
clears, and restores it after drawing. Vulkan writes exact static `VkViewport`
and `VkRect2D` structures during pipeline creation. The pipeline ABI corrected
the packed `flags`/`viewportCount` pair; the forced validation run is empty.
Existing native-order `GraphicsTexture.rgba8` remains compatible, while the new
allocation-free `rgba8TopLeft` inspection form normalizes OpenGL/Vulkan row
conventions for common rendered-texture tests.

The 70th independent sample, `examples/viewport-scissor`, draws the canonical
triangle through an asymmetric viewport/scissor intersection and verifies one
exact red interior plus four exact blue exterior probes. OpenGL, Vulkan, and
automatic selection each complete 1,001 frames with `live=0`; invalid depth,
zero extent, and out-of-target rectangles are rejected before driver creation.
The normal and direct `--fast` compiler paths both build the sample, its binary
has no unresolved dependency with `LD_LIBRARY_PATH` removed, and Vulkan is
silent with `VK_LAYER_KHRONOS_validation` forced.

Focused and shared evidence passed:

```bash
nix-shell --run 'make check-abla-only test-core test-application'
# independent viewport-scissor builds: --no-cache and --no-cache --fast
# OpenGL, Vulkan, auto: exact pixels, 1,001 frames, live=0
# Vulkan validation log: 0 bytes
# stripped-environment ldd missing list: 0 bytes
```

The broad application gate additionally retained default full-target raster
behavior across surfaced/offscreen rendering, resize recovery, depth,
multisampling, MRT, and subpasses. `tools/test-samples.sh` includes the new root
for the next periodic full 70-sample matrix; that expensive matrix was not
repeated here. Continue with another distinct plan capability rather than
retesting this published state.

## Milestone 5 direction after bounded asynchronous replay

Pass markers, dimension-aware copies, the retained render/subpass forms, and
typed compute/image forms are published. Eligible Vulkan replay now uses a
bounded frames-in-flight ring; broader command forms and presentation scheduling
remain open.

The later layers should:

1. Add typed compute, broader render/copy, query, and debug command records
   without turning the bounded slice into an unbounded variant type.
2. Record a complete graph/frame without managed allocation after warm-up.
3. Preserve exact image-layout responsibility without double transitions as
   more copy/render forms join the consolidated command stream.
4. Extend completion-aware retention from the graph ring into presentation and
   broader encoders while preserving explicit owner lifetimes.
5. Keep direct encoders and raw escape hatches available.
6. Prove exact multi-pass output, native barrier/submission counts, stable
   command resources, Vulkan validation silence, and zero steady-state live
   allocation on OpenGL and Vulkan.
7. Expand the delivered deferred-rendering proof into compute/render and
   presentation-scheduled samples using the real recorded command path.

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
- reusable command encoders, presentation scheduling, descriptor reuse,
  backend-private heap allocation/suballocation, persistent
  pipeline caches, and device-loss/context-reset recovery;
- geometry/tessellation, mesh/task, ray tracing, acceleration structures,
  multiview, variable-rate shading, sparse/external resources, video, device
  groups, protected work, calibrated timestamps, shader objects, and vendor
  extensions behind queried capabilities;
- Linux/Windows/macOS CI, golden image comparison, validation jobs, fuzzing,
  repeatable startup/resource/transfer/submission/frame/memory benchmarks, and
  reproducible signed releases;
- the planned learning/sample catalog: camera/mesh/material/glTF, particles,
  shadows, HDR/PBR, UI/text, multi-window/monitor,
  profiler, raw backend labs, stress benchmark, complete 3D
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
  consolidated frames-in-flight replay, completion polling/draining, submission
  accounting, and diagnostics.

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
- `examples/deferred-renderer/` — independently buildable two-pass MRT and
  prior-attachment sampling proof;
- `examples/recorded-compute-render/` — independently buildable compute-write
  to sampled-render handoff proof;
- `examples/color-blending/` — independently buildable typed blend-state and
  channel-write-mask proof;
- `examples/stencil-masking/` — independently buildable depth/stencil
  clear/load/store and front/back operation proof;
- `examples/mini-breakout/` — complete allocation-free software 2D game and
  dual-backend pixel-presentation proof;
- `examples/viewport-scissor/` — exact typed viewport/depth-range/scissor and
  portable top-left texture-inspection proof;
- `tools/test-samples.sh` — independent `--no-cache` sample build/live matrix;
- `Makefile` — authoritative gate aggregation;
- `registry/audit/*.tsv` — reviewed coverage inputs;
- `tools/update-registry.sh` — deterministic registry generation;
- `registry/coverage/*.md`, `src/raw/*_registry.ab` — generated outputs;
- `README.md`, `docs/api.md`, `docs/architecture.md`, `docs/status.md`,
  `docs/render-graph-commands.md`, `docs/specification-baseline.md`, `plan.md`,
  and this file — public contract and claim surface;
- `tools/check-abla-only.sh` — mandatory no-C implementation audit.

## Current verified checkpoint: generated raw command calls

Published compiler dependency
`37a5e4458cbc7f5be1a474e1f51ee00c011cc306` and graphics implementation
`2dc0e7f956dd598671cedf85e950b9c145c13ebe` are synchronized with their
upstreams. This checkpoint turns the raw registry from report-only metadata
into an executable foundation without claiming that every signature is
callable:

- the generator normalizes an exact call shape for all 2,892 pinned OpenGL and
  842 pinned Vulkan commands and retains those shapes in the full audit modules;
- separate generated `src/raw/opengl_calls.ab` and
  `src/raw/vulkan_calls.ab` modules contain only names and call shapes, reducing
  callable metadata to about 295 KiB total and keeping the full 3.9 MiB
  audit/type reports out of application imports;
- `GraphicsApplication.rawOpenGlApi()` resolves known commands through
  `eglGetProcAddress` with process-symbol fallback;
  `GraphicsApplication.rawVulkanApi()` resolves instance and device commands
  through `vkGetInstanceProcAddr` and `vkGetDeviceProcAddr`;
- `RawNativeCommand` retains the resolved name, normalized shape, address, and
  owning context/dispatch handle, rejects unknown or cross-context commands,
  and separates one-time lookup from steady-state calls;
- the first executable family accepts only exact `void()` OpenGL commands. It
  uses the new general `abla/unsafe/native.callNativeVoid0` compiler primitive,
  makes the borrowed EGL context current, and rejects mismatched signatures
  before calling the driver; and
- the 71st independent sample, `examples/raw-command-addresses`, proves both
  loader paths. Normal and `--fast` binaries resolve with `LD_LIBRARY_PATH`
  removed, Vulkan resolves live instance/device functions, and OpenGL executes
  1,000 indirect `glFinish` calls with zero live-byte growth while rejecting
  `glClear` and an unknown name.

The initially combined full-registry import produced 109 MiB of LLVM IR. The
compact split reduced the same combined sample to 20 MiB, which is the intended
build-time architecture for adding more signature families quickly.

Verified gates: cache-independent compiler unsafe-boundary positive/negative
tests; deterministic registry generation and offline full-metadata builds;
normal and optimized raw loader/call samples on live OpenGL and Vulkan;
stripped-environment `ldd`; the repository-wide Abla-only audit; pure core; and
the full common application gate on explicit OpenGL, explicit Vulkan,
automatic selection/fallback, unavailable Vulkan, and unsupported-feature
rejection. Vulkan selected API 1.4.312 on the local RTX 4090; software OpenGL
reported 4.5.0. The full 71-root matrix was deliberately not repeated.

The sibling compiler paths owned by this checkpoint are
`src/backend/llvm/analysis.ab`, `src/backend/llvm/functions.ab`,
`stdlib/abla/unsafe/native/entry.ab`,
`tests/cases/bootstrap/invalid-unsafe-call.ab`,
`tests/cases/modules/unsafe-boundary.ab`, and
`tools/test-unsafe-boundary.sh`. The negative unsafe test now bypasses caches
and directly tests `nativeStackAllocate`; its old allocation-wrapper fixture
had stopped being a raw extern on 2026-08-17, and cached objects concealed the
stale assertion. At this handoff `../ablac` also contains concurrent unrelated
export/program-build work, including a C caller fixture. Preserve it and never
stage it with this graphics dependency. There is no C/C++/Rust implementation
source in `abla-graphics`.

Remaining raw work is substantial: add compiler-backed checked call families
for the other normalized signatures; generate typed OpenGL/Vulkan values,
flags, handles, structures, and Vulkan feature chains; attach capability and
extension ownership to commands; exercise representative positive and
unsupported paths for every supported family; finish both raw feature-lab
samples; and classify the remaining coverage ledger. The full 71-root sample
matrix is queued for a periodic coverage checkpoint rather than this focused
raw ABI slice. Do not mark the persistent goal complete.

Focused commands for this checkpoint:

```bash
../ablac/tools/test-unsafe-boundary.sh ../ablac/build/ablac
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make test-raw-commands'
nix-shell --run 'make check-abla-only test-core test-application'
```

### Current checkpoint: one- and two-scalar raw OpenGL calls

Published compiler commits `e584ad0f58ec877e05fba9c6d10e8106f8468a9e`
and `d30a3fe5e28c2b6de5fe6fe73685321aec7a8f89`, plus graphics implementation
`3cb9067c90cf59ebcf92157fd18215eb46683088`, are synchronized with their
upstreams. This checkpoint adds exact LLVM indirect-call lowering and trusted
standard-library wrappers for `void(i32)` and `void(i32,i32)`. The registry
generator now emits a
separate canonical ABI-family tag alongside every normalized specification
shape. It recognizes only verified 32-bit OpenGL scalar typedefs and leaves
unhandled parameter/return layouts explicitly `unsupported`.

The pinned OpenGL registry now classifies 49 `void()`, 146 `void(i32)`, and 157
`void(i32,i32)` commands as callable: 352 of 2,892 entries. The remaining
2,540 OpenGL entries and all 842 Vulkan entries stay unsupported. Do not infer
callability from a resolved address or a normalized specification shape.

`RawNativeCommand.callAbi` is resolved once with the command. The allocation-
stable `RawOpenGlApi.callVoidI32` and `callVoidI32I32` methods require an exact
ABI tag and the originating context before dispatch. The normal and optimized
raw sample each execute 1,000 loops that call `glFinish`, enable and observe
scissoring, disable and observe it again, set and query pack alignment through
the two-scalar path, and restore the caller's original states. Both modes
reported `live=0`; Vulkan address resolution remained valid without claiming a
call family.

The compiler boundary test calls exported pure-Abla `void(i32)` and
`void(i32,i32)` functions through their dynamic addresses and verifies each
argument independently, including full unsigned 32-bit bit patterns that
truncate to `-1`, `-2`, and `-2147483648` in signed target parameters. Verified
gates were the compiler self-rebuild, cache-independent unsafe-boundary test,
deterministic update/registry test, normal and optimized live raw-command test,
stripped-environment linkage audit inside that test, Abla-only audit, and pure
core test. The broad common-application and full 71-root matrices were not
repeated because this slice changes only opt-in raw APIs and their exact
compiler intrinsics. No C/C++/Rust implementation or shim was introduced.

Remaining raw priorities after this slice are pointer/handle plus scalar
families (which dominate Vulkan), typed return families, generated native
types/flags/structure builders, command ownership/capability metadata, feature
chains, and representative live positive/unsupported tests for each enabled
family. Keep the full goal active.

### Published checkpoint: first callable Vulkan command family

Compiler dependency `4924bb782bc621cd3cd8a89d3216c51269550650` and
graphics implementation `6fc50494684f8fc7330505d4f53fee1e7a6dff7a`
are synchronized with their upstreams. The compiler adds exact
`void(pointer,i32)` indirect-call lowering while retaining an Abla `int` at the
safe wrapper boundary so every unsigned 32-bit bit pattern reaches the native
call. The compiler boundary test passes a real non-null pointer plus
`4294967295` and observes `-1` in the target's signed `i32` parameter.

The generator recognizes only `VkCommandBuffer` followed by `VkBool32`,
`uint32_t`, or `int32_t`. This classifies 35 of 842 pinned Vulkan commands as
`void(pointer,i32)` and leaves the other 807 explicitly unsupported. The
deterministic fixture contains a positive pointer-scalar command, while the
full registry test proves `vkCmdSetDeviceMask` has the exact normalized shape
and ABI family.

`RawVulkanApi.callVoidPointerI32` requires a device-resolved command, matching
device owner, exact ABI tag, and non-null dispatchable handle. The sample waits
for the application queue, resets and begins one presenter command buffer,
records 1,000 `vkCmdSetDeviceMask(command, 1)` calls without live-byte growth,
ends/submits/waits it, and resets the pool for the application's later use. It
also rejects `vkDeviceWaitIdle` through the wrong family and rejects a null
command buffer before driver dispatch. Normal and optimized builds both report
`calls=1000 live=0 stable=true`; their Vulkan validation logs contain no
`Validation Error`, `VUID-`, or `ERROR` records.

Verified gates were the compiler self-rebuild and cache-independent unsafe
boundary test; deterministic five-command fixture and full pinned-registry
test; normal and optimized raw builds with stripped-environment linkage; live
OpenGL and validation-enabled Vulkan runs; two exactly empty Vulkan validation
logs; the repository-wide Abla-only audit; and the pure core test. The broad
common-application and full 71-root matrices were not repeated because this
slice changes only opt-in raw modules and their exact compiler intrinsic.

This is the first executable Vulkan raw family, not general Vulkan call
coverage. Next priorities are dispatchable pointer-only calls with a legally
paired operation, pointer-plus-multiple-scalars, pointer/structure families,
typed `VkResult` returns, command feature/extension ownership, and generated
types/flags/builders/feature chains. Keep the full goal active.

### Published checkpoint: batched Vulkan pointer and status families

Compiler dependency `9b0c1b8568684ad2c5f0b869a1a455e387f645b9`
adds three exact native indirect-call families in one compiler round:
`void(pointer)`, `void(pointer,i32,i32)`, and `i32(pointer)`. Together with the
previous `void(pointer,i32)` family, the generated raw Vulkan surface now marks
49 of 842 pinned commands callable: 8, 35, 4, and 2 entries respectively. The
remaining 793 commands stay explicitly `unsupported`; no signature is inferred
from address presence alone.

Graphics implementation `8d55f814691f91f40ad6822f0b49418dd12f062d`
contains the generated registry, raw API, live proof, tests, and public contract
updates for this batch.

`RawVulkanApi` checks device ownership, exact generated ABI tags, and non-null
dispatch/output pointers before calling. The status-return family writes the
complete signed 32-bit value to caller-owned native storage and returns whether
dispatch occurred, preserving every native result without allocating or
reserving a sentinel. The registry fixture proves all four Vulkan ABI tags and
the full registry test checks `vkCmdEndRendering`, `vkCmdSetDeviceMask`,
`vkCmdSetStencilReference`, and `vkDeviceWaitIdle` exact shapes.

The one live Vulkan sample now pairs direct `vkCmdBeginRendering` with raw
`vkCmdEndRendering`, records 1,000 raw device-mask and 1,000 raw
stencil-reference commands, submits once, and obtains exact success from raw
`vkDeviceWaitIdle`. Wrong-family, null dispatchable, and null output calls are
rejected before driver dispatch. Normal and optimized builds both report
`calls=1000 status=0 live=0 stable=true`; validation scanning is clean in both
modes. The same bundled gate passed deterministic registry generation,
stripped-environment linkage, OpenGL raw execution, the Abla-only audit, and
the pure core suite.

This checkpoint deliberately batched three ABI families into one compiler
rebuild, one registry refresh, one live sample, and one consolidated graphics
gate. Continue that cadence. The next high-yield groups are dispatchable plus
three/four scalars, 64-bit handles and offsets, pointer/structure inputs, and
additional typed return shapes, followed by generated types, flags, structure
builders, feature chains, and ownership/capability metadata. The full goal
remains active.

### Published checkpoint: source-accurate resource and query batch

Compiler dependency `183fe426cef916cbacfa376fdc8f59e5069271e2`
adds exact `i32(pointer,i64)` and `void(pointer,pointer)` lowering. Existing
four-pointer status-return and pointer/64-bit-handle/pointer void lowerings are
now surfaced through the raw Vulkan API as part of the same batch.

Graphics implementation `8fb67d3c6012fe495fcadfe14c6908e83ab7d348`
contains the API-aware registry fix, regenerated metadata, four raw API
families, live event lifecycle, focused tests, and public contract updates.

The pure-Abla registry parser now selects command definitions by target API.
This prevents Vulkan-SC definitions from appending duplicate parameters to
Vulkan commands: the pinned Vulkan parameter total is corrected from 2,845 to
2,809, and `vkCreateDevice` now has its exact four parameters rather than eight.
The deterministic fixture includes a same-name Vulkan-SC definition and proves
that it does not affect Vulkan shapes.

Generated callable coverage rises from 49 to 309 of 842 Vulkan commands. The
new exact families contribute 81
`i32(pointer,pointer,pointer,pointer)` creation calls, 62
`void(pointer,i64,pointer)` destruction calls, 13 `i32(pointer,i64)` handle
status calls, and 104 `void(pointer,pointer)` query/command calls. Together
with the prior 49 entries, this leaves 533 explicitly `unsupported`.

The live raw sample uses those four new families to query
`vkGetPhysicalDeviceFeatures2`, create a real `VkEvent`, observe exact
`VK_EVENT_RESET`, and destroy the event. It rejects null required pointers,
zero handles, wrong families, and null result storage before dispatch. Normal
and optimized Vulkan runs both report the non-zero event handle,
`eventStatus=4`, `calls=1000`, `status=0`, `live=0`, and `stable=true`; both
validation scans are clean. The deterministic/full registry tests, stripped
runtime-linkage checks, OpenGL raw runs, Abla-only audit, pure core test,
compiler fixed point, and unsafe native boundary also pass.

This batch moved 260 commands into executable raw coverage with one registry
regeneration and one live lifecycle. Continue batching around exact layouts.
The next high-yield families are scalar/64-bit-handle mixtures used by buffer
copies and synchronization, three/four-scalar command-buffer calls tied to a
real pipeline, additional typed returns, and generated flags/structures with
feature/extension ownership metadata. The full goal remains active.

### Published checkpoint: three-pointer enumeration and query batch

Compiler dependency `359573a88006ee14d2c5a0b9be0d391ed7957f5d`
adds shared exact lowering for `i32(pointer,pointer,pointer)` and
`void(pointer,pointer,pointer)`. The unsafe boundary proves the signed return
and void paths with three real non-null pointers while the result-returning raw
wrapper deliberately permits a null final native argument for Vulkan's
count-only enumeration convention.

Graphics implementation `0a7b9467dd2f4ee229370ad4b0d99ea50009331a`
contains the generated classification, raw wrappers, deterministic/full tests,
live enumeration/queue proof, and public contract updates.

The generator classifies exactly 61 result-returning and 47 void three-pointer
commands. Total executable Vulkan raw coverage rises from 309 to 417 of 842,
leaving 425 explicit `unsupported` entries. Deterministic fixture commands
prove both ABI tags, and the full registry test checks the exact
`vkEnumeratePhysicalDevices` and `vkGetDeviceQueue2` normalized shapes.

The live sample first performs count-only physical-device enumeration, then
fills caller-owned storage and observes five devices. It packs a real
`VkDeviceQueueInfo2`, calls raw `vkGetDeviceQueue2`, and verifies the returned
pointer is the application's exact queue. Normal and optimized Vulkan runs
retain the earlier event lifecycle and recorded command proof and report
`devices=5`, a non-zero queue, `eventStatus=4`, `calls=1000`, `status=0`,
`live=0`, and `stable=true`. Both validation scans are clean. Compiler fixed
point, unsafe boundary, deterministic/full registry, stripped linkage,
OpenGL/Vulkan raw runs, Abla-only audit, and core tests pass.

This batch moved another 108 commands into executable coverage with one shared
lowering and one live query proof. Next prioritize exact scalar/64-bit-handle
mixtures used by buffer transfer and synchronization, pipeline-backed
three/four-scalar commands, wider typed returns, and generated
flags/structures with extension/feature ownership metadata. The full goal
remains active.

### Published checkpoint: counted pointer and legacy queue batch

Compiler dependency `f73b8a311b2f8f1895c6436637a75ee80645c233`
adds the exact `i32(pointer,i32,pointer)` indirect-call intrinsic and LLVM
lowering. Its unsafe boundary proves `i32` argument truncation and signed
return extension with real non-null pointers. The pure-Abla compiler fixed
point and native boundary test pass.

Graphics implementation `896616b9717777d1ce90a149ad8a4cdc915baa65`
contains the registry classification, checked raw wrappers, deterministic
fixture coverage, full-registry assertions, live Vulkan proof, and public
contract updates.

The generator classifies exactly 13 `i32(pointer,i32,pointer)` commands and 17
`void(pointer,i32,i32,pointer)` commands. Total executable Vulkan raw coverage
rises from 417 to 447 of 842 commands, leaving 395 explicit `unsupported`
entries. The fixture and pinned full registry prove the exact `vkResetFences`
and `vkGetDeviceQueue` shapes and ABI tags.

The live sample resolves `vkGetDeviceQueue` and verifies that the legacy query
returns the application's exact queue already observed through
`vkGetDeviceQueue2`. It creates a signaled fence, observes success, resets the
one-element fence array through the counted-pointer family, observes exact
`VK_NOT_READY`, and destroys the fence. Normal and optimized Vulkan runs both
report five devices, matching non-zero queue handles, `fenceStatus=1`,
`reset=0`, `calls=1000`, `status=0`, `live=0`, and `stable=true`; OpenGL also
reports `live=0` and `stable=true`, and both validation scans are clean.

Compiler fixed point and unsafe boundary, deterministic/full registry, normal
and optimized raw runs, Abla-only audit, and core tests pass. The 71-sample
application matrix was not rerun because this checkpoint changes only opt-in
raw ABI classification, exact compiler lowering, and its focused live sample.

This batch moved another 30 commands into executable coverage with one new
compiler primitive and reused the existing scalar/scalar/output lowering.
Continue batching remaining exact ABI families around real resource,
synchronization, transfer, and pipeline operations. The full goal remains
active.

## Working commands

Use the repository Nix environment and the sibling compiler. Start focused,
then record the relevant broad-gate result or independently reproduced baseline
failure before publication.

On NixOS, do not build native gates with bare `make`: the host linker may report
missing Vulkan/X11/EGL/GL libraries. Enter through `nix-shell --run ...`; the
shell also embeds absolute rpaths so the produced executable can subsequently
launch with `LD_LIBRARY_PATH` removed.

Useful commands:

```bash
nix-shell --run 'make check-abla-only test-core'
nix-shell --run 'make test-graph-texture test-graph-execute test-graph-commands'
nix-shell --run 'make test-glsl test-application'
nix-shell --run 'make test-runtime-linkage'
nix-shell --run 'make update-registry test-registry'
nix-shell --run 'make test-raw-commands'
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
