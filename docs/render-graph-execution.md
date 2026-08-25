# Render-graph barrier execution

The pure planner, typed texture owner, and backend executor remain separate
layers. Applications open a materialized execution as before, but enter each
scheduled pass through the application:

```abla
val execution = graph.beginExecution()

app.beginMaterializedRenderGraphPass(graph, execution, passId)
// Execute the pass's direct render, compute, copy, or transfer calls here.

graph.completeExecution(execution)
```

`beginMaterializedRenderGraphPass` first checks the execution generation and
the next exact ID in `plan.order`. It gathers every `GraphicsGraphBarrier`
whose destination is that pass, converts the read/write pair into conservative
portable memory intent, submits one combined backend dependency, and advances
the logical pass only when submission succeeds. A skipped/out-of-order/stale
entry performs no backend work and does not increment counters.

## Backend mapping

The planner currently describes resource access but not shader stages or
backend layouts. The executor therefore uses a deliberately conservative map:

- OpenGL emits one `glMemoryBarrier` with all relevant OpenGL 4.x barrier bits
  combined for a destination pass;
- Vulkan maps graph reads to `VK_ACCESS_MEMORY_READ_BIT`, writes to
  `VK_ACCESS_MEMORY_WRITE_BIT`, and uses `VK_PIPELINE_STAGE_ALL_COMMANDS_BIT`
  on both sides;
- synchronization2 devices record `VkMemoryBarrier2` and
  `vkCmdPipelineBarrier2` in the device's retained transfer command buffer;
- other Vulkan devices use `VkMemoryBarrier` and `vkCmdPipelineBarrier`; and
- one destination pass with several logical barriers still makes one backend
  barrier submission.

The Vulkan path submits on the selected graphics/transfer queue and waits for
its retained timeline value, or uses the existing queue-idle fallback. It
allocates no command pool, command buffer, scratch storage, semaphore, or
general memory per pass. This synchronous first executor is correct for the
framework's current direct submission model. Folding the dependency into a
future multi-command frame encoder will remove the inter-submission wait
without changing planner or texture identities.

Image layouts are not duplicated here. Existing texture copy/transfer/render
operations already own exact per-mip/per-layer layout state and transitions.
The graph executor supplies the cross-submission memory dependency; the direct
operation supplies the resource-specific layout transition. OpenGL likewise
retains the existing direct call's framebuffer/texture behavior.

## Ownership and observability

`GraphicsMaterializedRenderGraph` remains the affine execution owner and now
records:

- `currentExecutionBarriers`;
- `lastExecutionBarriers`;
- `totalExecutedBarriers`; and
- `backendBarrierCalls`.

These are exact monotonic diagnostics, not estimates. Execution reset clears
only the current logical count; physical pool leases and backend objects stay
live. `completeExecution` records the final logical count and still does not
inject a per-frame `waitIdle` call.

The pass body deliberately uses the existing direct APIs. This preserves exact
control and avoids storing borrowed affine pipelines, targets, buffers, or
imported textures in an unbounded callback list. A future reusable command
encoder can retain a bounded typed command representation above this same pass
entry/barrier contract.

## Evidence

`tests/graph_execute/main.ab` creates a four-pass graph:

1. upload a graph-owned transient sampled atlas;
2. sample it in a real fullscreen draw into a caller-owned imported render
   target;
3. copy that rendered target into a second graph-owned transient; and
4. read back every output texel.

The exact RGBA8 value `4281541137` is verified both at the offscreen target's
center and throughout the copied 16x16 output. The focused gate runs explicit
OpenGL, explicit Vulkan, and automatic selection and reports three planned
barriers, 3,003 logical barriers/backend calls after 1,001 executions, exact
synchronization2 counter growth on Vulkan, stable native handles, one pool
acquisition per transient object, and zero `runtimeMemoryLiveBytes()` growth.
An additional live two-resource graph writes both textures in one pass and
reads both in the next. It reports two incoming logical barriers but exactly
one backend barrier call, proving per-destination batching on OpenGL, Vulkan,
and automatic selection.

`examples/graph-post-process` independently performs the same upload, sampled
offscreen render, imported-to-transient post copy, exact readback, and warmed
barrier loop on both explicit backends.
