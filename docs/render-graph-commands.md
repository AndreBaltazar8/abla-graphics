# Bounded render-graph command lists

The first reusable render-graph command slice records ordered pass entry and
graph-owned transient texture copies into fixed-capacity affine storage. It is
an optional layer over the existing direct APIs and materialized graph
executor; it does not replace either one.

```abla
val commands = app.graphCommandList(graph, 4)

commands.recordPass(graph, 10)
commands.recordPass(graph, 20)
commands.recordTextureCopy(graph, sourceId, destinationId)
commands.recordPass(graph, 30)

if (!commands.seal(graph)) {
    // The complete stream failed structural or texture-range validation.
}

app.executeGraphCommands(graph, commands)
```

## Capacity and recording

`graphCommandList` requires a valid materialized graph containing only
transient textures. Capacity must contain at least one marker for every planned
pass and may not exceed `graphicsMaximumGraphCommands` (4,096). Creation copies
the scheduled pass order and every logical resource's physical slot/native
identity, then preallocates exact-capacity primitive arrays. Recording never
grows those arrays.

`recordPass` accepts only the next exact ID in `graph.plan.order`.
`recordTextureCopyRange` belongs to the most recently recorded pass and accepts
only distinct graph-owned physical slots for which that pass declares source
read and destination write access. It validates both complete texture
descriptors and the mip/origin/extent range. `recordTextureCopy` is the concise
whole-2D-texture form.

The current command kinds are deliberately limited to:

- an ordered materialized-pass marker, including its compiled backend memory
  dependency; and
- a same-format, single-sample transient texture range copy through the
  existing common texture-copy path.

Imported textures, render commands, compute dispatches, buffers, queries,
debug groups, and presentation are not recordable in this slice. Applications
continue to use their existing direct calls for those operations.

## Sealing, identity, and ownership

`seal(graph)` validates the entire stream once. Every planned pass must appear
exactly once and in order, every copy must remain legal in its containing pass,
and at least the pass markers must fit. A successful seal stores a primitive
fingerprint of all used command fields.

Execution rejects the list before opening a graph execution when:

- the backend, pass order, logical resource IDs, physical slots, or native
  identities differ from the graph used at creation;
- command storage was changed after sealing;
- the graph is already executing; or
- an execution/failure counter cannot advance safely.

The command list is an affine `resource class`, but it borrows the materialized
graph and its physical resources. The graph must outlive the list and every GPU
use initiated by replay. The exposed primitive arrays are diagnostic storage;
applications must treat them as inspection-only after sealing. Accidental
mutation is rejected by the seal fingerprint rather than replayed.

## Replay and failure

`executeGraphCommands` validates the sealed fingerprint and exact graph binding,
opens one graph generation, and walks the fixed records. Pass markers use
`beginMaterializedRenderGraphPass`, so the already compiled incoming barrier
count/access unions and strict pass order remain authoritative. Copy records use
the scalar pool-lease range path and do not construct a `TextureCopyDescriptor`
during replay.

A successful walk completes the graph generation and increments
`commands.executions`. A failure after execution begins calls
`graph.abortExecution(token)`, restoring the graph to a non-executing state and
incrementing `abortedExecutions`; every rejected or failed replay increments
`commands.failedExecutions` while representable. An abort does not count as a
completed execution and does not overwrite the last completed barrier count.

The warmed replay path performs no descriptor construction or general heap
allocation. It still performs bounded identity/fingerprint checks and the
native operations themselves. OpenGL issues direct memory-barrier and texture
copy calls. Vulkan currently submits and waits through retained transfer state
for each barrier-bearing pass and copy, so this is reusable recording—not yet a
single batched GPU submission or a frames-in-flight encoder.

## Evidence

`tests/graph_commands/main.ab` runs explicit OpenGL, explicit Vulkan, and
automatic backend selection. It proves exact pass/copy/access rejection,
same-shaped different-graph rejection, post-seal mutation rejection, abort and
recovery, exact RGBA word `4280427042`, stable native identities, one retained
pool acquisition per physical texture, 2,006 logical/backend barriers across
1,003 completed graph executions, 1,001 successful list replays, and zero live
memory growth over the 1,000-replay warmed loop.

`examples/recorded-graph-copy` is independently buildable and repeats the
public initialization, seal, replay, exact readback, stable-identity, barrier,
and no-growth workflow on both explicit backends. The Vulkan-focused gate also
runs with `VK_LAYER_KHRONOS_validation` and requires a silent validation log.

```bash
nix-shell --run 'make test-graph-commands'
nix-shell --run 'make test-samples'
```

General render/compute recording, imported-resource retention, folding graph
barriers and copies into one Vulkan command buffer, batched submission, frames
in flight, and GPU-completion-aware borrowing remain milestone 5 work.
