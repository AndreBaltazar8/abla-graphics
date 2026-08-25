# Materialized render-graph textures

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

## Physical ownership

The materialized graph is affine. It owns one capacity-one
`GraphicsTexturePool` and one retained lease for every planner allocation
slot. All logical resources mapped to a slot therefore resolve to the same
stable native texture:

- compatible resources whose scheduled lifetimes do not overlap reuse one
  complete OpenGL texture or Vulkan image;
- overlapping resources occupy different pools;
- different compatibility classes occupy different pools; and
- an exact-descriptor mismatch inside one opaque class rejects
  materialization before creating any pool.

This is portable whole-object reuse, not a claim that OpenGL exposes Vulkan
heap offsets. Vulkan currently retains the image, its dedicated bound memory,
transfer state, and layout tracking. A backend-private Vulkan heap allocator
can later replace that storage strategy without changing graph identities.

The graph keeps every lease for its entire lifetime. Execution reset therefore
does not release or reacquire resources and performs no driver or managed
allocation. Structural destruction drops the pools and their affine textures.

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

## Imported textures

Imported logical resources have no pool or lease and remain caller-owned.
Their typed declaration still defines the exact descriptor expected at a pass.
The caller supplies the real `GraphicsTexture` to
`matchesImportedGraphTexture`, `sampledImportedGraphTextureEntry`,
`copyImportedToGraphTexture`, or `copyGraphTextureToImported`. Each helper
checks application ownership, complete descriptor compatibility, the current
execution token, the current pass, and read/write access before borrowing it.
The graph never moves or destroys that texture.

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
