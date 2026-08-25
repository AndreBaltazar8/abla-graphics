# Bounded render-graph command lists

The reusable render-graph command slice records ordered pass entry,
graph-owned transient texture copies, and a typed procedural offscreen render
into fixed-capacity affine storage. It is an optional layer over the existing
direct APIs and materialized graph executor; it does not replace either one.

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

The current command kinds are deliberately limited to:

- an ordered materialized-pass marker, including its compiled backend memory
  dependency;
- a same-format, single-sample transient texture range copy through the
  existing common texture-copy path; and
- one procedural draw to one single-sample color target, with no depth,
  resolves, vertex buffer, bind group, or push constants.

General render commands, compute dispatches, buffers, queries, debug groups,
and presentation are not recordable in this slice. Applications continue to
use their existing direct calls for those operations.

## Sealing, identity, and ownership

`seal(graph)` validates the entire stream once. Every planned pass must appear
exactly once and in order; every copy and render must remain legal in its
containing pass; and at least the pass markers must fit. A successful seal
stores a primitive fingerprint of all used command fields and resource
descriptors.

Execution rejects the list before opening a graph execution when:

- the backend, pass order, logical resource IDs, physical slots, native
  identities, or storage descriptors differ from the graph used at creation;
- command storage was changed after sealing;
- the graph is already executing; or
- an execution/failure counter cannot advance safely.

The command list is an affine `resource class`. It borrows the materialized
graph and its physical resources, while its affine arrays own every recorded
render target and pipeline. The graph must outlive the list and every GPU use
initiated by replay; moving the render resources into the list prevents their
premature destruction. The exposed arrays are diagnostic storage; applications
must treat them as inspection-only after sealing. Accidental mutation is
rejected by the seal fingerprint rather than replayed.

## Replay and failure

`executeGraphCommands` validates the sealed fingerprint and exact graph binding,
opens one graph generation, and walks the fixed records. Pass markers preserve
the compiled incoming barrier count/access unions and strict pass order. Copy
records use the scalar pool-lease range path and do not construct a
`TextureCopyDescriptor` during replay. Render records use the list-owned native
target and pipeline.

OpenGL replays the same operations directly. When every Vulkan command is
eligible, graph barriers, 2D copies with `z = 0` and `depth = 1`, and the render
are recorded into the device's retained transfer command buffer and submitted
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
exhaustion cannot be discovered after earlier commands have submitted.

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

`examples/recorded-graph-copy` and `examples/recorded-graph-render` are
independently buildable and repeat the public initialization, seal, replay,
exact output, stable-identity, barrier/submission, and no-growth workflows on
both explicit backends. The Vulkan-focused gate also runs with
`VK_LAYER_KHRONOS_validation` and requires a silent validation log.

```bash
nix-shell --run 'make test-graph-commands'
nix-shell --run 'make test-samples'
```

General render/compute recording, bind groups, push constants, depth/resolves,
broader consolidated texture copies, frames in flight, and
GPU-completion-aware retention remain milestone 5 work.
