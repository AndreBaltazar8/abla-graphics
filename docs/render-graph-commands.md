# Bounded render-graph command lists

The reusable render-graph command slice records ordered pass entry,
graph-owned transient texture copies, typed procedural, direct/indexed, and
vertex-/indexed-indirect offscreen renders with reflected push snapshots, and
planner-visible imported or graph-owned buffer
compute dispatches into
fixed-capacity affine storage. It is an optional layer over the existing direct
APIs and materialized graph executor; it does not replace either one.

```abla
val commands = app.graphCommandList(graph, 6)

commands.recordPass(graph, 10)
commands.recordPass(graph, 20)
commands.recordTextureCopy(graph, sourceId, destinationId)
commands.recordPass(graph, 30)
commands.recordRenderTarget(
    graph,
    importedTargetId,
    move(target),
    move(pipeline),
    Color(0.01, 0.02, 0.03)
)
commands.recordPass(graph, 40)

if (!commands.seal(graph)) {
    // The complete stream failed structural or texture-range validation.
}

app.executeGraphCommands(graph, commands)
```

## Capacity and recording

`graphCommandList` requires a valid materialized graph. Capacity must contain at
least one marker for every planned pass and may not exceed
`graphicsMaximumGraphCommands` (4,096). Creation copies the scheduled pass
order and every logical resource's physical slot, native identity, and exact
storage-descriptor fingerprint, then preallocates exact-capacity primitive and
affine resource arrays. Recording never grows those arrays.

`recordPass` accepts only the next exact ID in `graph.plan.order`.
`recordTextureCopyRange` belongs to the most recently recorded pass and accepts
only distinct graph-owned physical slots for which that pass declares source
read and destination write access. It validates both complete texture
descriptors and the mip/origin/extent range. `recordTextureCopy` is the concise
whole-2D-texture form.

`recordRenderTarget` belongs to the most recently recorded pass and accepts an
imported logical texture for which that pass declares write access. It moves
one application-owned `GraphicsRenderTarget` and its compatible
`GraphicsRenderPipeline` into the command list. The imported graph declaration
must exactly match the target texture's storage descriptor; labels are not part
of storage compatibility.

`recordRenderVertices` additionally moves one exact planner-declared vertex
buffer into the list. `recordRenderIndexed` moves distinct vertex and `uint32`
index buffers. Their logical resources must be imported buffers with current
pass read access, exact storage descriptors, the appropriate usage bit, and
checked aligned byte ranges. Vertex/index counts and instance count are sealed
alongside every native buffer identity. Both forms retain the current narrow
single-color, single-sample, no-depth/no-resolve/no-bind-group/no-push target
contract.

`recordRenderVerticesIndirect` adds a distinct 16-byte draw-command buffer;
`recordRenderIndexedIndirect` adds distinct vertex, index, and 20-byte indexed
draw-command buffers. The indirect ranges and usage are checked exactly, and
their logical/native identities and offsets are sealed. OpenGL binds the
retained draw buffer for `glDrawArraysIndirect`/`glDrawElementsIndirect`;
Vulkan records `vkCmdDrawIndirect`/`vkCmdDrawIndexedIndirect` into the same
consolidated graph command buffer.

`recordRenderTargetPush`, `recordRenderVerticesPush`,
`recordRenderIndexedPush`, `recordRenderVerticesIndirectPush`, and
`recordRenderIndexedIndirectPush` mirror every render form. They require an
exact matching reflected layout and copy at most 128 bytes into a separate
preallocated render-push arena. Source mutation after recording cannot affect
replay; size and every copied byte participate in the sealed fingerprint.

`recordComputeStorage` names an imported logical buffer resource, then moves one
storage buffer and the `GraphicsComputePipeline` created against that exact
native buffer into the list. The current pass must declare that resource as
`graphAccessReadWrite`, and its `GraphicsGraphBufferDeclaration` must exactly
match the moved buffer's size, usage, mapping, and memory-placement fields.
Positive workgroup counts remain checked against the device limits.

`recordComputeStoragePush` adds reflected `GraphicsPushConstants`. Recording
copies the exact bytes into the command list's preallocated 128-byte-per-command
native storage. The source value may therefore be changed or dropped after a
successful record without changing replay. The size, bytes, logical resource
ID, descriptor, native buffer/pipeline identities, and workgroups all
participate in seal validation and fingerprinting.

`recordComputeBindings` and `recordComputeBindingsPush` generalize imported
compute to the exact reflected bind-group entries retained by
`computeBindingPipeline`. Recording moves one caller-owned buffer for every
logical ID and requires each binding kind, descriptor, range, native identity,
and declared read/write access to agree. The arrays are moved into one affine
resource group rather than flattened into copyable handles.

`recordTransientComputeBindings` and its push form target graph-owned transient
buffers. The pipeline's retained entries must refer to the graph pool backing
objects and exact allocation ranges produced by `storageGraphBufferEntry` or
`uniformGraphBufferEntry`. Every logical ID and physical slot in one dispatch
must be unique. This prevents two disjoint logical aliases of one native buffer
from being bound simultaneously.

The current command kinds are deliberately limited to:

- an ordered materialized-pass marker, including its compiled backend memory
  dependency;
- a same-format, single-sample transient texture range copy through the
  existing common texture-copy path; and
- one procedural, direct/indexed, or vertex-/indexed-indirect draw to ordered
  color attachments with optional resolves/depth and one optional reflected
  push block, but no bind group; and
- one ordered two-to-eight-stage procedural subpass sequence over
  planner-visible color, resolve, and optional depth attachments; and
- imported single- or multi-buffer compute and graph-owned transient
  multi-buffer compute dispatches, optionally with one reflected push-constant
  block of at most 128 bytes.

The common executable shader subset currently proves one two-storage form
(`destination.value += sourceData.value`) in addition to the general
single-block scalar emitter. Sampled textures/images in compute, queries, debug
groups, presentation, and arbitrary subpass attachment routing
are not recordable in this slice. Applications continue to use their existing
direct calls for those operations.

## Sealing, identity, and ownership

`seal(graph)` validates the entire stream once. Every planned pass must appear
exactly once and in order; every copy, render, and compute dispatch must remain legal in its
containing pass; and at least the pass markers must fit. A successful seal
stores a primitive fingerprint of all used command fields, resource
descriptors, and copied push bytes.
Per-command push sizes are bounded before fingerprinting, so mutation of the
exposed diagnostic arrays cannot turn rejection into an unbounded byte scan.

Execution rejects the list before opening a graph execution when:

- the backend, pass order, logical resource IDs, physical slots, native
  identities, or storage descriptors differ from the graph used at creation;
- command storage was changed after sealing;
- the graph is already executing; or
- an execution/failure counter cannot advance safely.

The command list is an affine `resource class`. It borrows the materialized
graph and its physical resources, while its affine arrays own every recorded
render target/pipeline, imported vertex/index/compute buffer, compute pipeline,
and retained bind group. Transient compute records own logical-ID arrays but borrow their
buffers from the graph. The graph must outlive the list and every GPU use
initiated by replay; moving caller resources into the list prevents their
premature destruction. The exposed arrays are diagnostic storage; applications
must treat them as inspection-only after sealing. Accidental mutation is
rejected by the seal fingerprint rather than replayed.

## Replay and failure

`executeGraphCommands` validates the sealed fingerprint and exact graph binding,
opens one graph generation, and walks the fixed records. Pass markers preserve
the compiled incoming barrier count/access unions and strict pass order. Copy
records use the scalar pool-lease range path and do not construct a
`TextureCopyDescriptor` during replay. Render and compute records use their
list-owned native resources.

OpenGL replays the same operations directly. When every Vulkan command is
eligible, graph barriers, 2D copies with `z = 0` and `depth = 1`, render, and
compute dispatch are recorded into the device's retained command buffer and submitted
once for the complete list. Other valid copy shapes retain the direct path.
The public direct copy/render entry points remain begin/record/submit wrappers
around the same validated non-submitting driver helpers.

A successful completed submission and walk completes the graph generation and
increments `commands.executions`. A failure after execution begins calls
`graph.abortExecution(token)`, restoring the graph to a non-executing state and
incrementing `abortedExecutions`; every rejected or failed replay increments
`commands.failedExecutions` while representable. An abort does not count as a
completed execution and does not overwrite the last completed barrier count.

Vulkan distinguishes submission acceptance from completion. Before an accepted
submission, replay restores the recorded image-layout bookkeeping on failure.
Once the queue accepts work, layout and submission counters reflect that work
even if the completion wait fails; the graph does not claim a completed
execution and the transfer device becomes unhealthy, preventing unsafe reuse.
Direct-fallback submission counts and all counter additions are preflighted so
exhaustion cannot be discovered after earlier commands have submitted. The
Vulkan compute pipeline applies the same accepted-versus-completed distinction
to its private direct fallback and becomes unhealthy after a native failure.

The warmed replay path performs no descriptor construction or general heap
allocation. It still performs bounded identity/fingerprint checks and the
native operations themselves. Submission remains synchronous: the consolidated
Vulkan path waits for completion and is not yet a frames-in-flight encoder.

## Evidence

`tests/graph_commands/main.ab` runs explicit OpenGL, explicit Vulkan, and
automatic backend selection. The combined six-command proof covers four pass
markers, one copy, and one render. It rejects an invalid direct Vulkan render
before command-buffer begin, an incompatible target record, and an incompatible
graph replay. It verifies center pixel `4294281759`, copied RGBA word
`4280427042`, stable graph/target/pipeline native identities, one retained pool
acquisition per transient physical texture, 4,012 logical barriers and 3,009
batched backend barrier calls across 1,003 completed graph executions, 1,001
successful list replays, and zero live-memory growth over the 1,000-replay
warmed loop. OpenGL reports zero Vulkan submissions; Vulkan reports exactly
1,001, one for each complete replay.

Its three-command, two-pass compute proof rejects transient and size-mismatched
buffer declarations plus a pipeline bound to a different storage buffer. It
records an add-one push constant, mutates the source value after sealing, then
increments the owned buffer to exact value `1001` through 1,001 replays. The
planner derives one read/write-to-read buffer hazard, producing exact barrier
counts `1/1001/1001`. Buffer, pipeline, and Vulkan command-pool handles remain
stable with zero live growth; OpenGL reports zero Vulkan submissions and Vulkan
exactly 1,001. Native resource identities and copied push bytes participate in
the seal fingerprint.

The multi-binding imported proof retains two buffers and reaches exact
destination/source values `5007/5` through 1,001 replays. Mutating one sealed
logical identity or retained native bind-group identity rejects before
execution. The transient proof maps three
logical buffers to slots `0/1/0`, retains only two physical buffer pools, and
runs the same exact arithmetic against two graph-owned bindings. It verifies
one retained allocation per pool, stable aliased/native identities, one
barrier per replay, zero/1,001 OpenGL/Vulkan submissions, and zero warmed live
growth. A barrier before a later pass specifically guards Vulkan's valid
recording state before its consolidated submission. Mutating a transient
descriptor to request usage absent from its backing pool also invalidates the
graph and rejects before execution.

The buffered-render proof owns one vertex draw and one indexed draw against
five planner-visible imported resources. Both exact center pixels are
`4294281759` on OpenGL, Vulkan, and automatic selection. Mutating a sealed
native vertex-buffer identity rejects before graph execution. After restoring
it, 1,001 replays retain exact output and native identities with zero live
growth; OpenGL reports zero Vulkan submissions and Vulkan exactly 1,001.

The adjacent indirect proof owns separate portable draw-command buffers for
one vertex-indirect and one indexed-indirect record. It produces the same two
exact pixels, rejects sealed indirect-buffer identity mutation, retains zero
live growth through 1,001 replays, and preserves the zero/1,001 OpenGL/Vulkan
submission counts.

The push proof records one procedural and one indexed-indirect form with red
reflected values, mutates the source to green after sealing, and still produces
exact red RGBA8 word `4278190335`. Oversized sealed push metadata rejects
before execution; 1,001 valid replays retain zero live growth and the same
zero/1,001 OpenGL/Vulkan submission counts.

Procedural depth records use `recordRenderTargetDepth(...)` or
`recordRenderTargetDepthPush(...)`. The command owns the complete color/depth
target and pipeline, while the graph makes both imported attachment identities,
descriptors, and pass writes explicit. Depth presence must exactly match an
enabled pipeline. Direct, indexed, and both indirect buffered methods expose
the same contract through a final optional depth resource ID, including every
`Push` form. The focused boundary proof executes direct vertices and
indexed-indirect push records. It rejects a mutated sealed depth ID,
preserves its recorded red value after source mutation, renders exact RGBA8
`4278190335`, and completes 1,001 replays with zero live growth and zero/1,001
OpenGL/Vulkan submissions.

Single-color multisample records use `recordRenderTargetResolve(...)` or its
`Push` form. The graph declares both the multisample source and single-sample
resolve output as imported pass writes. Exact descriptors, active resources,
and the sealed resolve identity are checked before replay. The focused proof
resolves exact red RGBA8 `4278190335`, rejects ID mutation, preserves copied
push bytes, and completes 1,001 zero-growth replays with zero/1,001
OpenGL/Vulkan submissions.

`examples/recorded-graph-copy`, `examples/recorded-graph-render`,
`examples/recorded-graph-compute`, and
`examples/recorded-graph-transient-compute`, and
`examples/recorded-graph-texture-compute`, and
`examples/recorded-graph-storage-image-compute`, and
`examples/recorded-graph-storage-image-view-compute`, and
`examples/recorded-graph-buffered-render`, and
`examples/recorded-graph-indirect-render`, and
`examples/recorded-graph-push-render`, and
`examples/recorded-graph-depth-render`, and
`examples/recorded-graph-resolve-render`, and
`examples/recorded-graph-mrt-render`, and
`examples/recorded-graph-subpasses`, and
`examples/recorded-graph-binding-subpasses`, and
`examples/recorded-graph-texture-render`, and
`examples/recorded-graph-texture-subpasses`, and
`examples/recorded-graph-transient-texture-subpasses` are
independently buildable and repeat the public initialization, seal, replay,
exact output, stable-identity, barrier/submission, and no-growth workflows on
both explicit backends. The Vulkan-focused gate also runs with
`VK_LAYER_KHRONOS_validation` and requires a silent validation log.

```bash
nix-shell --run 'make test-graph-commands'
nix-shell --run 'make test-samples'
```

Generalized attachment records accept two to eight ordered colors,
zero resolves or one per color, and optional depth. The focused 4x MRT proof
resolves exact red/green `4278190335/4278255360`, rejects sealed additional
resolve mutation, and replays 1,001 times with zero growth and one Vulkan
submission. Buffered callers compose one of four affine draw-resource factories
with `recordRenderAttachments(...)` or its `Push` form; the proof uses
indexed-indirect push and the sample uses direct vertices.

Ordinary retained-bind-group draws use
`recordRenderBindingAttachments(...)` or its `Push` form. They compose one
typed binding table with any existing draw-resource form instead of exposing a
texture-specific method for every procedural/direct/indexed/indirect variant.
Imported buffers, full sampled textures, explicit views, and graph-owned
transient sampled textures share the same planner validation and affine
retention rules as recorded subpasses. The one-stage resource map, bind-group
native handles, owners, and logical IDs participate in the seal fingerprint.
The independent textured procedural proof rejects a post-seal map mutation,
then renders exact RGBA8 `4294281759` through 1,001 OpenGL, Vulkan, and
automatic-selection executions with zero warmed live-byte growth.

Procedural subpass records use `recordRenderSubpasses(...)`,
`recordRenderPushSubpasses(...)`, or
`recordRenderBindingSubpasses(...)`. The command owns the target, compatible
render pass, and ordered affine pipeline sequence; the graph names every
ordered color/resolve attachment and optional depth write. The push form copies
the complete reflected two-to-eight-stage value aggregate into bounded
command-owned storage before sealing. The binding form also owns flattened
tables of imported graph buffers, sampled textures or views, parent textures,
and their samplers, and
maps every stage binding entry to its kind-specific table index. Uniform
entries require declared read access; storage entries require declared access;
sampled entries require imported single-sample color declarations with read
access and sampled usage. View entries retain the parent texture and use an
encoded negative table index internally. Transient sampled entries borrow the
graph's retained one-slot texture-pool lease while the command owns their
sampler; descriptors are created once before recording. Exact descriptors,
byte ranges, usage, native texture/view/sampler/lease identities, and attachment
alias rejection run at record, seal, and replay. One affine resource may be
shared by stages.
`recordRenderBindingPushSubpasses(...)` composes both contracts: it owns the
same binding table and snapshots the complete reflected per-stage push aggregate
before sealing.
OpenGL replays the stages in order. Vulkan records the entire native subpass
sequence inside the graph's retained command buffer and preserves one submit
per complete replay. The focused proof rejects sealed depth-ID and cached
Vulkan sequence-handle mutation, then replays exact RGBA8 `4294281759` 1,001
times with zero live growth.

Recorded compute bind groups use `recordComputeBindingResources(...)` or its
push form. They reuse the render/subpass typed resource table, one-stage entry
mapping, affine owners, graph access checks, and seal fingerprint. The first
deterministic `$glsl` compute sampling subset reads a `sampler2D` at a fixed
coordinate and accumulates the channel into a storage buffer. Its independent
proof rejects a sealed map mutation, reaches exact `1001` through 1,001
OpenGL/Vulkan/automatic-selection replays, and retains zero warmed live growth.

`graphSubpassStorageTextureResources(...)` retains imported single-mip 2D
storage textures without artificial samplers. Its explicit read/write access
must agree with the graph use and binding entry. The first `$glsl` form lowers
write-only `image2D` `imageStore`; OpenGL binds an image unit and emits the
image-access barrier bit, while Vulkan uses a storage-image descriptor and a
one-time `GENERAL` transition. The independent proof preserves exact red,
rejects a sealed stage-map mutation, and completes 1,001 OpenGL/Vulkan/auto
replays with zero warmed growth and zero/1,001 Vulkan submissions.

`graphSubpassStorageTextureViewResources(...)` extends the same contract to an
exact affine parent/view pair. The reflection now fingerprints and matches
`rgba8` plus read/write qualification. Its live proof targets mip one, loads
red, stores swapped green, and reaches exact `4278255360` after 1,001 replays
on OpenGL, Vulkan, and automatic selection with `live=0`.

`recorded-graph-storage-image-r32f-compute` proves the extended-format path:
reflected `r32f` must match an R32F entry, Vulkan must have enabled
`shaderStorageImageExtendedFormats`, and exact IEEE `1.0f` survives 1,001
retained replays with sealed-map rejection and `live=0`. The independent
`fragment-storage-image` proof requires the fragment-storage feature, writes
exact green through `imageStore` while its color attachment becomes exact red,
and repeats 1,001 times without managed growth on both backends.

`recorded-graph-layered-storage-images` retains one 2D-array image and one 3D
volume in the same dispatch. Dimension matching is sealed into the resource
table; swapping their stage indices is rejected. OpenGL binds both as layered
image units and Vulkan uses their exact storage-image views. After 1,001
replays, explicit subresource readback observes green `4278255360` at array
layer two and blue `4294901760` at volume slice one, with `live=0` and
zero/1,001 Vulkan submissions.

Deterministic 1D/cube programs and general image-expression lowering,
broader copy/dispatch forms, frames in flight, and
GPU-completion-aware retention remain milestone 5 work.
