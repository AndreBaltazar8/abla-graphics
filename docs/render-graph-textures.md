# Materialized render-graph resources

`graphicsRenderGraph` remains a pure deterministic planner. Physical texture
creation is a separate opt-in step:

```abla
val graph = app.materializeRenderGraphTextures(
    resources,
    passes,
    [
        GraphicsGraphTextureDeclaration(0, firstDescriptor),
        GraphicsGraphTextureDeclaration(1, secondDescriptor)
    ]
)
```

Every logical resource has exactly one typed declaration. A transient
resource's declared byte size must equal `textureDescriptorStorageBytes` for
the complete mip chain, layer/depth count, format blocks, and sample count.
The planner's integer `compatibility` remains an application-defined coarse
class. Materialization always compares complete storage descriptors before
sharing an object, so equal integers can never make different extents,
dimensions, mip counts, sample counts, formats, or usage flags alias.
Diagnostic labels do not affect compatibility.

The generalized entry point also accepts buffer declarations:

```abla
val graph = app.materializeRenderGraphResources(
    resources,
    passes,
    textureDeclarations,
    [GraphicsGraphBufferDeclaration(bufferId, bufferDescriptor)]
)
```

A logical resource must have exactly one exclusive texture or buffer
declaration. Buffer descriptors must match the planner byte size. Imported
buffers remain descriptor-only declarations. A transient buffer must be
device-local, unmapped, free of map usage, and no larger than the bounded
one-GiB graph-pool limit. Its complete storage descriptor must agree with every
logical resource assigned to the same planner slot.

## Physical ownership

The materialized graph is affine. Each planner allocation slot becomes exactly
one physical kind. Texture slots own one capacity-one `GraphicsTexturePool`
and retained lease. Buffer slots own one `GraphicsBufferPool` with one retained
allocation. The slot-to-pool maps keep texture and buffer pool indices separate,
so adding buffers does not change existing texture pool indexing. All logical
resources mapped to a slot resolve to the same stable native object:

- compatible resources whose scheduled lifetimes do not overlap reuse one
  complete OpenGL texture/buffer or Vulkan image/buffer;
- overlapping resources occupy different pools;
- different compatibility classes occupy different pools; and
- an exact-descriptor mismatch inside one opaque class rejects
  materialization before creating any pool; and
- a planner slot can never alias a texture with a buffer.

This is portable whole-object reuse, not a claim that OpenGL exposes Vulkan
heap offsets. Vulkan currently retains the image, its dedicated bound memory,
transfer state, and layout tracking. A backend-private Vulkan heap allocator
can later replace that storage strategy without changing graph identities.

Transient buffer capacity is rounded to the smallest compatible block geometry
within 65,536 blocks and one GiB. The logical allocation keeps its exact byte
range even when the backing capacity is rounded. Oversized descriptors reject
before native allocation.

The graph keeps every lease/allocation for its entire lifetime. Execution reset
therefore does not release or reacquire resources and performs no driver or
managed allocation. Structural destruction drops the pools and their affine
textures/buffers.

## Checked execution

`beginExecution()` returns a monotonically increasing token. Passes must then
be entered in `plan.order` with `beginPass(token, passId)`. The token and the
current pass declaration guard every operation:

- `writeGraphTextureBytes` requires a transient write use;
- `readGraphTextureBytes` requires a transient read use;
- `copyGraphTexture` requires active transient source-read and
  destination-write uses backed by different physical slots;
- `sampledGraphTextureEntry` requires an active transient read use; and
- `completeExecution` succeeds only after the final scheduled pass.

Unknown IDs, skipped/out-of-order passes, stale execution tokens, wrong access
modes, imported resources passed to transient helpers, and copies between an
aliased object are rejected before backend work. A sampled entry snapshots the
native handle, so the materialized graph must outlive bind groups made from it.

The graph does not allocate or release objects at a pass boundary. Entering a
pass through `app.beginMaterializedRenderGraphPass` now submits the planner's
conservative cross-submission memory dependencies before direct work begins;
existing common rendering and transfer operations retain their exact image
layout-transition contracts. Direct raw users that bypass this entry API remain
responsible for equivalent dependencies and for GPU completion before
destroying the graph. `GraphicsApplication.waitIdle()` is available for
diagnostic and final lifecycle boundaries, not required by
`completeExecution()` on every frame. See `docs/render-graph-execution.md`.

## Imported textures and buffers

Imported logical resources have no pool or lease and remain caller-owned.
Their typed declaration still defines the exact descriptor expected at a pass.
The caller supplies the real `GraphicsTexture` to
`matchesImportedGraphTexture`, `sampledImportedGraphTextureEntry`,
`copyImportedToGraphTexture`, or `copyGraphTextureToImported`. Each helper
checks application ownership, complete descriptor compatibility, the current
execution token, the current pass, and read/write access before borrowing it.
The graph never moves or destroys that texture.

Imported logical buffers likewise have no pool or lease. The graph retains only
their typed descriptor. A recorded compute command names the logical ID and
moves the real buffer plus its exact bound pipeline into command-list ownership;
the direct materialized graph does not borrow or destroy a buffer by itself.

Transient logical buffers are graph-owned. `storageGraphBufferEntry` and
`uniformGraphBufferEntry` create checked bind-group entries for their exact
retained allocation range. A compute pipeline made with
`computeBindingPipeline` may then be moved into a transient compute record.
Recording requires each reflected buffer binding to name one unique active
logical resource and one unique physical slot, preventing simultaneous aliases
from entering the same dispatch.

## Evidence

`tests/graph_texture/main.ab` runs on explicit OpenGL, explicit Vulkan, and
automatic selection. It proves:

- exact typed size accounting, slot count, and logical-to-physical mapping;
- same-handle reuse for non-overlapping compatible resources;
- distinct handles for overlapping and incompatible resources;
- exact upload, imported-to-transient copy, transient-to-transient copy,
  transient-to-imported copy, readback, and sampled-binding creation;
- imported ownership/descriptor rejection, stale token and access rejection,
  opaque-compatibility mismatch rejection, and size/declaration rejection;
- one retained pool acquisition per physical slot; and
- stable handles and zero `runtimeMemoryLiveBytes()` growth across 1,000
  warmed executions.

`tests/graph_commands/main.ab` adds the transient-buffer proof. Three logical
device-local buffers map to physical slots `0/1/0`; the first and third have
disjoint lifetimes and the same descriptor, while the source overlaps them.
Two graph-owned storage bindings execute exact `destination += source` through
1,001 replays, reaching `5007` with one barrier per replay, stable native
identities, one allocation per physical pool, one consolidated Vulkan
submission per replay, and zero warmed live-byte growth. It also proves the
one-GiB bound rejects before allocation.

`examples/materialized-render-graph` independently draws four live frames on
both backends. Two logical atlases with disjoint lifetimes reuse one physical
texture; the sample overwrites it between scheduled passes, renders both
contents, then completes 1,000 allocation-free executions while retaining the
same native handle.

`tests/graph_execute/main.ab` and `examples/graph-post-process` add real
barrier-ordered execution: transient upload, sampled draw into an imported
offscreen target, post-pass copy into a transient, exact output readback, and
3,003 zero-growth logical/backend barriers across 1,001 executions. The
focused test also proves that two logical hazards entering one destination
pass become one backend barrier call.
