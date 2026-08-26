# Public API contract

This document fixes the intended API shape. Names may be refined before 0.1,
but the ownership and performance contracts are not optional.

## Available application slice

The current compiler-checked facade already performs one-time backend selection,
owns the platform/backend resources, polls copied events, and presents a common
native `f64` clear color:

```abla
val app = graphicsApplication(
    GraphicsConfig(
        backend = graphicsBackendAuto,
        framesInFlight = 3,
        requiredFeatures = graphicsFeatureCompute |
            graphicsFeatureStorageBuffers
    ),
    WindowConfig(title = "Abla clear", width = 1280, height = 720)
)
if (app.valid()) {
    app.presentClear(Color(0.15, 0.45, 0.85))
}
```

OpenGL stores clear-color ABI data in a context-owned 16-byte native block.
Vulkan clear presentation shares the configured fence-guarded frame slots,
command pointers, scratch blocks, and semaphores with pixel presentation; it
does not create command pools or synchronization objects per clear. Four
repeated clears preserve native handles and runtime live bytes on both
backends.

Advanced Vulkan code can use an explicitly enabled timeline semaphore through
the selected device:

```abla
val timeline = app.vulkanDevice.timelineSemaphore(3)
timeline.signal(4)
timeline.wait(4, 1000000000)
val completed = timeline.currentValue()
```

This is intentionally a Vulkan-specific primitive rather than a false portable
wrapper. Device creation queries `VkPhysicalDeviceVulkan12Features` and
`VkPhysicalDeviceVulkan13Features` through `vkGetPhysicalDeviceFeatures2`, then
enables only `timelineSemaphore`, `synchronization2`, and `dynamicRendering`
when the adapter reports them. `VulkanTimelineSemaphore` owns the native handle
and one reusable ABI block; counter queries, strictly monotonic host signals,
and waits perform no general heap allocation. Negative initial/counter values,
non-increasing signals, and negative timeouts are rejected before driver calls.
When synchronization2 is enabled, the device's reusable transfer command path
encodes `VkCommandBufferSubmitInfo` and `VkSubmitInfo2` into its existing scratch
block, signals a device-owned timeline semaphore, calls `vkQueueSubmit2`, and
waits for only that transfer's monotonic completion value. The command buffer,
semaphore, scratch storage, and counter survive repeated work without general
allocation or queue-wide idle. Memory and image transitions on this path encode
`VkDependencyInfo`, `VkMemoryBarrier2`, and `VkImageMemoryBarrier2` in the same
scratch block and record `vkCmdPipelineBarrier2`; older devices retain the
checked legacy barrier, submit, and queue-wait encoding.
`transferCompletedValue()` exposes the observed driver counter and
`transferBarrier2Count` proves advanced barrier recording in diagnostics.

Surfaced `VulkanRenderPipeline` creation uses dynamic rendering when the
negotiated feature is enabled. The pipeline chains a packed
`VkPipelineRenderingCreateInfo`, owns image/depth views but no render-pass or
framebuffer handles, and records explicit attachment transitions around packed
`VkRenderingInfo`/`VkRenderingAttachmentInfo` commands. Offscreen targets and
multi-subpass sequences retain compatible render-pass/framebuffer objects;
devices without dynamic rendering use that same checked legacy path.

The first portable raster pipeline uses the same embedded shader package on
both backends:

```abla
val shader = $glsl {
    vertex {
        #version 450
        const vec2 positions[3] = vec2[3](
            vec2(-0.75, -0.65),
            vec2(0.75, -0.65),
            vec2(0.0, 0.75)
        );
        void main() {
            gl_Position = vec4(positions[gl_VertexID], 0.0, 1.0);
        }
    }
    fragment {
        #version 450
        layout(location = 0) out vec4 color;
        void main() { color = vec4(0.12, 0.54, 0.96, 1.0); }
    }
}
val pipeline = app.renderPipeline(shader)
val clear = Color(0.02, 0.03, 0.05)
app.presentRender(pipeline, clear)
```

`GraphicsRenderPipeline` is affine. OpenGL owns one linked program and vertex
array. Vulkan owns the pipeline layout, render pass, graphics pipeline, and one
image view/framebuffer per swapchain image; shader modules are released after
pipeline creation. Presentation reuses the application's configured command
slots, semaphores, fences, command buffers, and native scratch. Repeated calls
with a reused `Color` perform no general allocation and preserve native
handles. This initial pipeline is surface-dependent: after a Vulkan swapchain
resize, the common presentation path releases framebuffer/image-view state,
recreates the swapchain, recompiles the immutable pipeline recipe, and retries
when the original presentation did not succeed.

Portable vertex layouts support up to 16 explicitly located interleaved
attributes. The current formats are scalar/2/3/4-component `float32` and scalar
`uint32`; locations must be unique, offsets must fit the stride, and shader
reflection must match every location and GLSL type. Omitting the attribute list
retains the concise legacy location-zero `vec2` layout. `storeF32` performs
deterministic IEEE-754 binary32 encoding from Abla's native `f64` without a
foreign helper:

```abla
val layout = VertexBufferLayout(stride = 24, attributes = [
    VertexAttribute(0, 0, vertexFormatFloat32x2),
    VertexAttribute(1, 8, vertexFormatFloat32x4)
])
val data = bufferBytes(72)
data.storeF32(-0.75, 0)
data.storeF32(-0.65, 4)
data.storeF32(1.0, 8)
data.storeF32(0.2, 12)
data.storeF32(0.1, 16)
data.storeF32(0.8, 20)
// Store two more position/color records at byte offsets 24 through 71.
val vertices = app.buffer(BufferDescriptor(
    size = 72,
    usage = bufferUsageVertex | bufferUsageCopyDestination
))
vertices.writeAllBytes(data)

val pipeline = app.renderPipeline(shader, layout)
app.presentRenderVertices(pipeline, vertices, 3, clear)
```

Pipeline creation rejects a layout whose reflected vertex input does not match
the declaration. Presentation checks application ownership, vertex usage,
positive count, and `count * stride` bounds before dispatch. OpenGL binds the
buffer and configures every floating or integer attribute in the pipeline VAO;
Vulkan packs the matching binding/attribute descriptions into pipeline state
and records `vkCmdBindVertexBuffers`.
Repeated draws preserve the vertex buffer and command/pipeline handles with
zero runtime live-byte growth.

Reusable `uint32` indices use the same common buffer path:

```abla
val indexData = bufferBytes(12)
indexData.storeU32(0, 0)
indexData.storeU32(1, 4)
indexData.storeU32(2, 8)
val indices = app.buffer(BufferDescriptor(
    size = 12,
    usage = bufferUsageIndex | bufferUsageCopyDestination
))
indices.writeAllBytes(indexData)
app.presentRenderIndexed(
    pipeline,
    vertices,
    indices,
    3,
    clear,
    instanceCount = 2
)
```

The indexed path validates ownership, usage, positive count, and available
four-byte index storage before dispatch. It maps to `glDrawElements` with
`GL_UNSIGNED_INT` and Vulkan `vkCmdBindIndexBuffer`/`vkCmdDrawIndexed`.
Vertex and indexed presentation accept a positive `instanceCount` (one by
default), selecting core OpenGL instanced draw calls and the Vulkan draw
command's native instance field. Zero instances are rejected before dispatch.
Vertex/index buffers and backend command state remain stable with zero live-byte
growth across the repeated sample draw loop.

Unsigned integer vertex inputs use `vertexFormatUint32` in the same reflected
layout. They map to `glVertexAttribIPointer` on OpenGL and `R32_UINT` pipeline
attributes on Vulkan; the common-triangle sample proves an interleaved
`vec2`/`vec4`/`uint` record without backend-specific shader or buffer code.

GPU-authored draw parameters use buffers created with `bufferUsageIndirect`:

```abla
app.presentRenderVerticesIndirect(pipeline, vertices, commands, clear)
app.presentRenderIndexedIndirect(
    pipeline,
    vertices,
    indices,
    indexedCommands,
    clear
)
```

The first command begins at byte zero. A non-indexed command uses the standard
16-byte `vertexCount`, `instanceCount`, `firstVertex`, `firstInstance` ABI; an
indexed command uses the standard 20-byte layout. OpenGL binds
`GL_DRAW_INDIRECT_BUFFER` and calls the corresponding core indirect draw.
Vulkan records `vkCmdDrawIndirect` or `vkCmdDrawIndexedIndirect`. The framework
validates ownership, vertex/index/indirect usage, and minimum storage, while
command values intentionally remain GPU-readable rather than CPU-inspected.

Bind groups are affine and pipeline-owned. Entries carry an explicit binding
number, shader-stage visibility, and resource kind:

```abla
val texture = app.texture(TextureDescriptor(
    size = Extent3D(2, 2),
    format = textureFormatRgba8Unorm,
    usage = textureUsageSampled | textureUsageCopyDestination
))
texture.writePixels(pixels, TextureWriteDescriptor())
val sampler = app.sampler()
val binding = app.bindGroup([
    app.sampledTextureEntry(
        0,
        shaderVisibilityFragment,
        texture,
        sampler
    )
])
val pipeline = app.renderPipeline(
    shader,
    vertexLayout,
    RasterPipelineState(),
    DepthStencilState(),
    move(binding)
)
```

`sampledTextureEntry`, `storageTextureEntry`, `uniformBufferEntry`, and
`storageBufferEntry` may be
combined in one group with unique bindings from 0 through 31. Their
`uniformBufferRangeEntry` and `storageBufferRangeEntry` counterparts bind a
checked byte range rather than the whole resource. Groups currently
accept up to 16 entries in descriptor set zero and one resource per entry.
Visibility can combine `shaderVisibilityVertex`, `shaderVisibilityFragment`,
and `shaderVisibilityCompute`. Pipeline creation structurally matches every
reflected shader binding before driver work, rejecting missing, extra,
wrong-stage, wrong-kind, nonzero-set, or array bindings.

Sampled texture reflection is dimension-aware. `sampler2D`,
`sampler2DArray`, `samplerCube`, and `sampler3D` require matching 2D, array,
cube, and 3D texture descriptors respectively; a mismatched texture is rejected
before either backend creates a pipeline. Other GLSL sampler families remain
recognized as sampled resources but are rejected until their corresponding
portable texture dimensions are available.

`storageTextureEntry(binding, visibility, texture, access)` accepts an owned
single-mip, single-sample 1D, 2D, 2D-array, 3D, or cube texture with
`textureUsageStorage`; its dimension must exactly match reflected `image1D`,
`image2D`, `image2DArray`, `image3D`, or `imageCube` (and signed/unsigned
forms).
Portable image formats are R8/RG8/RGBA8 unorm, R16/RG16/RGBA16 float, and
R32/RG32/RGBA32 float. `rgba32f` is the baseline Vulkan shader-image format;
the other formats require
`graphicsFeatureStorageTextureExtendedFormats`. Compute visibility is portable,
fragment visibility additionally requires
`graphicsFeatureFragmentStorageTextures`, and vertex visibility remains
rejected. Cube entries additionally require
`graphicsFeatureCubeStorageTextures`; Vulkan exposes it only when the required
`imageCubeArray` device feature was queried and enabled. OpenGL precomputes the
image unit, internal format, access, and layered flag for
`glBindImageTexture`; Vulkan creates a matching storage-image view and
descriptor, transitions
every selected subresource to `GENERAL` once before use, and keeps that resting
layout across dispatch, rendering, and readback.

`storageTextureViewEntry(binding, visibility, texture, view, access)` selects
one validated mip and its dimension-valid layer or depth range without giving
ownership to the bind group.
It requires the parent and view to belong to the application and agree on the
complete parent descriptor. OpenGL binds mip zero of the re-indexed texture-view
object. Vulkan uses the caller-owned `VkImageView` and transitions only the
selected parent subresource range. Reflection carries `readonly`, `writeonly`,
or unqualified read-write access plus `r8`, `rg8`, `rgba8`, `r16f`, `rg16f`,
`rgba16f`, `r32f`, `rg32f`, or `rgba32f`, so access or format mismatches fail
before pipeline creation.

`sampledTextureViewEntry` binds an existing `GraphicsTextureView` instead of a
texture's default view. Its resolved format, dimension, mip range, layer range,
aspect, sample count, application ownership, and sampled usage are checked
before backend descriptor work. The concise `textureViewBinding` and
`textureViewUniformBinding` helpers mirror their whole-texture counterparts.
The parent texture and view are borrowed and must both outlive the resulting
pipeline; declare them before the bind group or pipeline.

OpenGL maps sampled entries to the matching texture/sampler unit and buffer
entries to the matching UBO or SSBO slot, reapplying the group before each draw.
Target-inherent direct-state-access binding lets the same path bind 2D, array,
cube, and 3D texture objects.
Whole resources retain `glBindBufferBase`; real subranges use
`glBindBufferRange` with a typed pointer-sized offset and size.
Vulkan creates one compatible set layout, aggregated descriptor pool, descriptor
set, exact `VkDescriptorBufferInfo` offsets/ranges, and a full image view for
each sampled entry; every draw records
`vkCmdBindDescriptorSets`. These resources survive swapchain and graphics-
pipeline recreation. The entry arrays and backend binding arrays are prepared
once, so drawing does not allocate or rebuild descriptors.

The source texture and sampler are borrowed when the binding is created and
must outlive the pipeline. Declare them before the binding/pipeline so Abla's
reverse affine destruction order enforces that lifetime naturally. Repeated
indexed draws reuse every binding handle with zero live-byte growth.

`app.textureBinding(texture, sampler)` and
`app.textureUniformBinding(texture, sampler, uniform)` remain concise wrappers
for the common binding-zero fragment texture and binding-one vertex uniform
layouts. The indexed cube uses the latter with a std140 `Transform` block
containing one `mat4 mvp`. Buffers must declare the matching
`bufferUsageUniform` or `bufferUsageStorage` flag and outlive the pipeline.
Every ranged offset must be a multiple of the active device's queried
`minimumUniformBufferOffsetAlignment` or
`minimumStorageBufferOffsetAlignment`; misaligned and crossing ranges are
rejected before driver work.

Pool slices have direct helpers:

```abla
val entry = app.uniformBufferPoolEntry(
    1,
    shaderVisibilityVertex,
    pool,
    allocation
)
```

The helper validates the generation token and slice-relative subrange, then
uses its checked absolute backing-buffer offset. The indexed cube forces the
uniform away from offset zero, asynchronously uploads its 64-byte transform,
and renders four allocation-stable frames from offset 16 on the tested OpenGL
driver and offset 64 on Vulkan. A released/stale allocation cannot create a
valid entry. Complete all GPU work before releasing the slice.

Portable fixed raster state is immutable and supplied when creating the
pipeline:

```abla
val raster = RasterPipelineState(
    topology = primitiveTopologyTriangleList,
    cullMode = cullModeBack,
    frontFace = frontFaceCounterClockwise,
    alphaBlend = true
)
val pipeline = app.renderPipeline(
    shader,
    VertexBufferLayout(stride = 8),
    raster
)
```

The initial state surface covers point/line/triangle lists and strips, no/front/
back culling, clockwise/counter-clockwise winding, and disabled or standard
source-alpha blending. OpenGL applies the complete state before each draw so
external raw calls cannot silently poison the common path. Vulkan bakes the
same topology, cull mode, front face, and blend factors into the graphics
pipeline. Invalid enum values are rejected before backend driver creation.
The sample creates and presents both a blended triangle-list pipeline and an
alternate line-strip/front-cull/clockwise pipeline on both backends.

Depth is an independent immutable pipeline component:

```abla
val depth = DepthStencilState(
    enabled = true,
    write = true,
    compare = compareFunctionLess
)
val pipeline = app.renderPipeline(shader, layout, raster, depth)
```

Depth writes require depth testing, and the compare operation must be one of
never, less, equal, less-equal, greater, not-equal, greater-equal, or always.
The surfaced EGL configuration requests a real 24-bit default depth buffer;
OpenGL reapplies enable/write/compare state and clears depth to one before the
draw. Vulkan bakes matching test/write/compare state, adds a D32 attachment to
the render pass, and owns one allocated depth image/view per swapchain image so
frames in flight never race on depth storage. Depth clear values reuse the
existing frame scratch. Repeated draws preserve every depth image/view handle
and runtime live bytes.

`GraphicsRenderPipeline` retains its immutable shader, vertex layout, and
raster recipe. A copied Vulkan resize event updates the desired surface extent
but deliberately defers swapchain recreation until presentation, when the
pipeline can first release every framebuffer, color view, and depth image/view
that belongs to the old extent. `presentRender`, `presentRenderVertices`, and
`presentRenderIndexed` detect an extent/format mismatch or classified
suboptimal/out-of-date result, rebuild in dependency order, and retry a failed
presentation once. The common-triangle sample resizes from 800x600 to 640x480
and requires the rebuilt swapchain, pipeline extent, framebuffer count, and
per-image depth resources to match before succeeding. OpenGL keeps the same
pipeline and updates its viewport from the copied resize event.

The owning `GraphicsApplication` is affine and specializes to Vulkan or OpenGL
before frame work. Its destructor waits/destroys swapchain and device resources,
then surface/instance/context, then the direct Abla window. A root application
using this surfaced facade currently declares
`nativeLibraries = ["vulkan", "X11", "EGL", "GL"]` because the application,
not a dependency package, chooses its installed native loader boundary.

Display-free work uses the same one-time specialization policy:

```abla
val headless = graphicsHeadlessApplication(
    GraphicsConfig(backend = graphicsBackendAuto),
    64,
    64
)
if (headless.valid()) headless.probe()
```

`graphicsBackendAuto` and `graphicsBackendHeadless` both select the best
available headless driver, preferring Vulkan; explicit Vulkan/OpenGL requests
never silently cross over. No X11 connection is opened on this path.

Vectors and matrices use native `f64` values. `Mat4` names elements row-first
(`m23` is row 2, column 3) and transforms column vectors. Composition is
explicit: `left.multiplied(right)` applies `right` before `left`.

```abla
val model = mat4Translation(Vec3(3.0, 5.0, 7.0)).multiplied(
    mat4Scaling(Vec3(2.0, 3.0, 4.0))
)
val worldPoint = model.transformPoint(Vec3(1.0, 1.0, 1.0))
```

Integer extents never silently wrap: `areaChecked()`/`volumeChecked()` return a
`GraphicsIntResult`, while the convenience `area()`/`volume()` return zero for
invalid or overflowing dimensions. `Rect2D.contains` rejects bounds whose
exclusive endpoint cannot be represented.

`app.primaryMonitor()` reports the X11 setup screen's pixel and physical
dimensions plus derived DPI/content scale. A server that omits physical size
uses the portable 96 DPI baseline rather than returning zero or dividing by it.
`app.setPointerPosition(x, y)` emits a direct core X11 `WarpPointer` request;
the resulting motion is delivered through the same copied event queue.
`app.setPointerCaptured(true)` performs an idempotent core pointer grab confined
to the mapped window; release and application teardown explicitly ungrab it.
Clipboard reads follow X11's asynchronous ownership model:

```abla
app.setClipboard("copied from Abla")
app.requestClipboardFormats()
val event = app.pollEvent(100)
if (event.clipboardSucceeded() && event.clipboardTextAvailable()) {
    app.requestClipboard()
}
```

The owning window answers `UTF8_STRING` and `TARGETS` selection requests during
event polling. A successful text request produces another clipboard event whose
`clipboardText()` contains copied UTF-8. Replies that arrive among unrelated
input events preserve those events in order for subsequent polls.

High-resolution animation and simulation timing uses the monotonic clock rather
than wall time:

```abla
val pacer = graphicsFramePacer(60)
while (running) {
    update()
    render()
    running = pacer.wait()
}
```

`graphicsMonotonicNanoseconds()` exposes the raw monotonic value and
`graphicsMonotonicSeconds()` provides an `f64` convenience view. A
`GraphicsFramePacer` owns reusable syscall buffers, accepts 1 through 1,000
frames per second, and distributes indivisible nanoseconds across deadlines so
60 consecutive periods do not accumulate integer-division drift. Late frames
resynchronize instead of triggering a catch-up burst. Once constructed, its
`wait()` path performs no general heap allocation.

OpenGL applications may also keep one reusable software frame and upload it
without rebuilding shaders, textures, or general heap values per frame:

```abla
val pixels = pixelBuffer(320, 200)
pixels.clearRgba8(18, 35, 64)
pixels.fillRectRgba8(80, 50, 160, 100, 204, 64, 32)
app.presentPixels(pixels)
```

`PixelBuffer` bounds-checks dimensions, rectangles, channels, and pixel access.
Its native storage is affine and released deterministically. OpenGL uploads it
through a persistent nearest-filtered texture. Vulkan keeps a host-visible
staging buffer, adapts RGBA/BGRA order for the selected swapchain format, and
copies into the acquired image before presentation. Its command pool, command
pointer cell, 160-byte native ABI scratch block, and acquire/render semaphores
are created once with the application and reused after each completed
submission. Presentation outcomes are packed scalar values rather than
frame-local heap objects. `GraphicsConfig.framesInFlight` selects one through
eight independently fenced Vulkan pixel-upload slots (two by default), and the
same count is preserved when a stale swapchain is rebuilt. Four repeated
uploads on each backend preserve native handles and produce zero runtime
live-byte growth. Pixel coordinate `(0, 0)` is the top-left; the OpenGL
presenter flips the texture coordinate once in its full-screen shader.

The first immutable GPU descriptors are also compiler checked. Buffer usages
compose with `|`; structural validation rejects empty/unknown bits and enforces
portable mapping combinations before any driver call:

```abla
val vertices = BufferDescriptor(
    label = "vertices",
    size = 3 * 2 * 4,
    usage = bufferUsageVertex | bufferUsageCopyDestination
)
val color = TextureDescriptor(
    label = "color",
    size = Extent3D(1280, 720),
    mipLevels = 11,
    format = textureFormatRgba8UnormSrgb,
    usage = textureUsageSampled | textureUsageCopyDestination
)
```

`BufferDescriptor`, `TextureDescriptor`, `TextureViewDescriptor`, and
`SamplerDescriptor` separate backend-independent structural validity from
device-limit/feature validation, which will occur when the affine resource is
created. Texture checks cover dimensionality, mip and multisample constraints,
format/view compatibility, subresource ranges, and color/depth/stencil aspects.
Sampler checks cover address/filter/LOD/comparison/anisotropy domains. A failed
`validation()` identifies the precise field and a stable diagnostic message.
Texture views inherit their source texture format by default; an explicit
linear/sRGB reinterpretation is accepted only for the matching channel layout.
Omitted mip-level and array-layer counts select all remaining subresources from
their base indices.

Buffers are the first driver-backed common resource:

```abla
val storage = app.buffer(BufferDescriptor(
    label = "simulation",
    size = 4096,
    usage = bufferUsageStorage | bufferUsageCopySource |
        bufferUsageCopyDestination
))
val upload = bufferBytes(256)
upload.storeI64(42, 16)
storage.writeBytes(upload, BufferCopyDescriptor(
    sourceOffset = 8,
    destinationOffset = 128,
    size = 64
))

val readback = bufferBytes(64)
storage.readBytes(readback, BufferCopyDescriptor(
    sourceOffset = 128,
    destinationOffset = 0,
    size = 64
))

val destination = app.buffer(BufferDescriptor(
    size = 4096,
    usage = bufferUsageCopySource | bufferUsageCopyDestination
))
app.copyBuffer(storage, destination, BufferCopyDescriptor(
    sourceOffset = 128,
    destinationOffset = 512,
    size = 64
))

val fill = BufferFillDescriptor(
    value = 0xff336699,
    offset = 1024,
    size = 256
)
app.fillBuffer(destination, fill)
```

`GraphicsBuffer` is affine, dispatches outside the read/write hot operation,
and owns either an OpenGL buffer object or a Vulkan buffer/allocation. Creation
maps portable usage flags to Vulkan usage bits and returns a structured error
for invalid descriptors or driver failure. Bounds checks use subtraction rather
than overflow-prone `offset + length`. A storage buffer larger than
`maximumStorageBufferBytes` returns `graphicsErrorLimitExceeded` before a
driver allocation. `BufferBytes` is reusable contiguous Abla-owned storage with
checked byte and 64-bit access. `BufferCopyDescriptor` validates positive size,
source and destination offsets, and both ends of the range with subtraction;
its default `size = -1` selects all bytes remaining after `sourceOffset`.
Uploads require map-write or copy-destination usage, while readback requires
map-read or copy-source usage. `writeAllBytes` and `readAllBytes` are convenient
whole-range operations; performance-sensitive loops should construct one
`BufferCopyDescriptor` and reuse it with `writeBytes`/`readBytes`.

Buffers that should stay on the GPU can request device-local placement:

```abla
val geometry = app.buffer(BufferDescriptor(
    label = "device-geometry",
    size = 1048576,
    usage = bufferUsageVertex | bufferUsageCopySource |
        bufferUsageCopyDestination,
    memory = bufferMemoryDeviceLocal
))
```

`bufferMemoryAutomatic` preserves the general compatible allocation policy;
`bufferMemoryHostVisible` explicitly requests CPU-visible coherent memory; and
`bufferMemoryDeviceLocal` rejects map-read/map-write usage and all direct CPU
`writeBytes`/`readBytes` operations. Upload and readback queues are the portable
way across that boundary. Vulkan requires the device-local memory-property bit
and prefers a compatible type without host-visible/coherent flags. OpenGL owns
the same portable CPU-access boundary while physical residency remains under
the OpenGL driver. `deviceLocal()` reports that the requested policy was
realized; on Vulkan it also checks the selected native memory flags.

Many device-local buffers can share one real driver allocation through
`GraphicsBufferPool`:

```abla
val pool = app.bufferPool(BufferPoolDescriptor(
    capacity = 16777216,
    blockSize = 256,
    maximumAllocations = 1024,
    usage = bufferUsageCopySource | bufferUsageCopyDestination |
        bufferUsageVertex | bufferUsageIndex | bufferUsageUniform |
        bufferUsageIndirect
))

val vertices = pool.allocate(65536, 16)
val indices = pool.allocate(12288, 4)
val indirect = pool.allocate(20, 4)
val uniforms = pool.allocate(256, 256)
val uploads = app.bufferTransferQueue(BufferTransferQueueDescriptor(
    direction = bufferTransferDirectionUpload,
    slotCapacity = 256
))
val frameBytes = bufferBytes(256)
val ticket = app.enqueueUploadBufferPoolRange(
    uploads, frameBytes, pool, uniforms, 0, 0, frameBytes.size
)
uploads.wait(ticket)

val rendered = app.presentRenderBufferPoolIndexedIndirect(
    pipeline,
    pool,
    vertices,
    indices,
    indirect,
    Color(0.02, 0.03, 0.05)
)
```

The pool owns one explicitly device-local `GraphicsBuffer` and fixed arrays for
at most 65,536 blocks and 1,024 live allocations. Creation performs all general
metadata allocation. `allocate` uses a bounded first-fit scan and returns one
compact positive integer containing a metadata slot and generation; `release`
mutates the existing arrays. Neither operation allocates general memory, and a
token becomes invalid as soon as its slot is released or reused. Requested
alignment is a checked power of two; capacity and block size are bounded to one
GiB, block size must divide capacity, and accounting records reserved block
bytes rather than requested payload bytes.

`allocationOffset`, `allocationSize`, and `allocationValid` expose checked
slice metadata. `enqueueUploadBufferPoolRange` and
`enqueueReadbackBufferPoolRange` translate a slice-relative range into the
existing fixed-slot GL/Vulkan transfer machinery, so the backing allocation
remains inaccessible to direct CPU reads and writes. Invalid and stale ranges
return an invalid transfer ticket without changing queue state. Applications
must complete every transfer or command that borrows a slice before releasing
it. `backing` remains an explicit low-level escape hatch. Uniform/storage
binding uses the checked helpers above. Twenty-four draw helpers cover the eight
surfaced and sixteen offscreen target/pass direct, indexed,
vertex-indirect, and indexed-indirect forms, with or without push values. They
validate every generation token before forwarding the single backing buffer and
its absolute ranges. The offscreen families are named consistently, for example
`renderBufferPoolIndexedToTarget`,
`renderPassBufferPoolIndexedIndirectToTarget`, and
`renderPushPassBufferPoolVerticesToTarget`.

The corresponding ordinary surfaced methods accept optional byte ranges after
their existing arguments. Vertex, `uint32` index, and indirect offsets must be
four-byte aligned; the vertex range must contain the requested vertices, the
index range must contain `indexCount * 4` bytes, and indirect ranges must contain
at least 16 bytes for direct or 20 bytes for indexed commands. OpenGL sums the
vertex base into every attribute pointer and passes the index/indirect byte
offset as the command pointer. Vulkan records the matching direct offsets in
`vkCmdBindVertexBuffers`, `vkCmdBindIndexBuffer`, `vkCmdDrawIndirect`, or
`vkCmdDrawIndexedIndirect`. For indexed-indirect commands, portable
`firstIndex` is absolute to the complete index backing buffer because OpenGL has
no separate index-buffer base for an indirect draw; `indexOffset`/`indexSize`
identify the validated allocation range and are not added to `firstIndex`.
Vulkan therefore binds the whole index buffer for indexed-indirect calls. A
pool command targeting an index slice at byte 48 stores `firstIndex = 12` for
`uint32` indices. Invalid, crossing, short, misaligned, or stale pool ranges
return `false` before driver work. Complete GPU work before releasing or
reusing any borrowed allocation.

Textures that are repeatedly repurposed can reuse complete native objects
through `GraphicsTexturePool`:

```abla
val pool = app.texturePool(TexturePoolDescriptor(
    texture = TextureDescriptor(
        size = Extent3D(1024, 1024),
        format = textureFormatRgba8Unorm,
        usage = textureUsageSampled | textureUsageCopySource |
            textureUsageCopyDestination
    ),
    capacity = 3
))
val atlas = pool.acquire()
val uploaded = app.writeTexturePoolBytes(pool, atlas, pixels)
val entry = app.sampledTexturePoolEntry(
    0, shaderVisibilityFragment, pool, atlas, sampler
)
```

Construction eagerly creates between one and 64 homogeneous textures. The
pool keeps affine ownership and `acquire` returns a compact slot/generation
lease rather than moving a dynamically indexed resource out of its owner.
`release` invalidates that generation immediately. Exhaustion, stale access,
and double release return `0` or `false` without driver work. Once warmed,
acquire/release mutates only fixed integer/boolean arrays and performs no
managed or driver allocation. Tokens are scoped to their issuing pool; fixed
homogeneous slots have no external fragmentation.

`writeTexturePoolBytes`, `readTexturePoolBytes`, `texturePoolRgba8`,
`generateTexturePoolMipmaps`, `copyTexturePoolLease`, the asynchronous
`enqueueUploadTexturePoolBytes`/`enqueueReadbackTexturePoolBytes` pair, and
`sampledTexturePoolEntry` validate a live lease before borrowing the retained
texture. Complete transfers and drop bind groups made from a lease before
releasing it. OpenGL reuses immutable texture objects; Vulkan reuses complete
images, bound device memory, transfer state, and layouts. The common contract
does not expose Vulkan heap offsets. `docs/texture-pooling.md` records the
portability rationale and future render-graph materialization boundary.
The retained `textures` array is a borrowed low-level escape hatch; direct use
bypasses lease validation but cannot transfer the pool's ownership.

A map-write/copy-source buffer may start mapped without an intermediate upload:

```abla
val staging = app.buffer(BufferDescriptor(
    size = 4096,
    usage = bufferUsageMapWrite | bufferUsageCopySource,
    mappedAtCreation = true
))
val initial = bufferBytes(256)
// Fill initial once, then copy any checked subrange into the live mapping.
staging.writeMappedBytes(initial, BufferCopyDescriptor(
    sourceOffset = 0,
    destinationOffset = 128,
    size = 256
))
staging.unmap()
```

`mapped()` exposes the lifecycle state. Normal CPU transfers and every common
GPU operation reject the buffer while it is mapped. `unmap()` is explicit and
one-shot; afterward the buffer is a normal copy source. Dropping a still-mapped
buffer unmaps it before native destruction. Vulkan uses host-coherent memory,
so the portable unmap boundary also makes the written bytes visible without a
backend-specific flush call.

Map-read and map-write buffers may also map checked subranges after creation:

```abla
val range = BufferMapDescriptor(offset = 128, size = 256)
staging.mapWrite(range)
staging.writeMappedBytes(initial, BufferCopyDescriptor(
    sourceOffset = 0,
    destinationOffset = 128,
    size = 256
))
staging.unmap()

readback.mapRead(BufferMapDescriptor(offset = 512, size = 256))
readback.readMappedBytes(cpuBytes, BufferCopyDescriptor(
    sourceOffset = 512,
    destinationOffset = 0,
    size = 256
))
readback.unmap()
```

The descriptor API is intended for ordinary application code. Allocation-
critical loops can call `mapWriteRange`/`mapReadRange` and
`writeMappedRange`/`readMappedRange` with primitive offsets and sizes; these
have identical checks without promoting descriptor aggregates across call
boundaries. The common-buffer sample reuses both mappings for four complete
write-map/unmap/GPU-copy/read-map/unmap cycles with stable native handles and
zero live-byte growth. OpenGL maps the exact native range. Vulkan maps its
host-coherent allocation from alignment-safe offset zero and enforces the same
logical subrange in Abla.

For synchronous streaming transfers, `persistentMapping = true` keeps either a
coherent map-write/copy-source upload buffer or a map-read/copy-destination
readback buffer mapped while `copyBuffer` consumes it:

```abla
val upload = app.buffer(BufferDescriptor(
    size = 65536,
    usage = bufferUsageMapWrite | bufferUsageCopySource,
    mappedAtCreation = true,
    persistentMapping = true
))

upload.writeMappedRange(frameBytes, 0, 0, frameBytes.size)
app.copyBuffer(upload, deviceBuffer, copy)
```

`graphicsFeaturePersistentMapping` advertises this path. OpenGL requires core
4.4, allocates immutable storage with `glBufferStorage`, maps it persistent and
coherent, and issues the client-mapped visibility barrier before upload copies
or after readback copies.
Vulkan uses its host-visible coherent allocation and alignment-safe whole-memory
map. OpenGL fences each copy and waits only for that fence; Vulkan waits for its
transfer submission. The current `copyBuffer` therefore completes before the
method returns on both backends, and the application may safely overwrite the
upload range or read the completed download range. A persistently mapped buffer
remains restricted to exactly one portable direction: map-write plus
copy-source, or map-read plus copy-destination. It cannot silently enter vertex,
index, uniform, or storage work. `unmap()` ends the persistent lifecycle
explicitly, and affine drop does so automatically.

`GraphicsBufferUploadRing` packages that mechanism into one affine staging
resource:

```abla
val uploads = app.bufferUploadRing(BufferUploadRingDescriptor(
    capacity = 1048576,
    alignment = 256
))

app.uploadBufferRange(
    uploads,
    frameBytes,
    deviceBuffer,
    0,
    destinationOffset,
    frameBytes.size
)
```

Each successful upload aligns the next staging offset, wraps to zero when the
tail no longer fits, writes the coherent mapping, and completes the GPU copy
before advancing `cursor`, `uploadCount`, and `wrapCount`. Invalid input changes
none of that state. `uploadBuffer` is the descriptor convenience API;
`uploadBufferRange` is its allocation-free primitive hot path. `rewind()` is
safe because all current copies finish before returning. The ring owns and
drops its staging buffer, and `graphicsFeaturePersistentMapping` gates creation.
This is synchronous streaming with bounded reusable storage, not an in-flight
asynchronous ownership scheme.

`GraphicsBufferReadbackRing` is the matching download path:

```abla
val downloads = app.bufferReadbackRing(BufferReadbackRingDescriptor(
    capacity = 1048576,
    alignment = 256
))

app.downloadBufferRange(
    downloads,
    deviceBuffer,
    resultBytes,
    sourceOffset,
    0,
    resultBytes.size
)
```

It copies a checked GPU source range into the next aligned persistent map-read
slice, waits for the same backend completion boundary, then copies directly
into caller-owned `BufferBytes`. Descriptor and primitive APIs mirror uploads.
Failed copy or read validation leaves `cursor`, `downloadCount`, and `wrapCount`
unchanged. Repeated wrapped downloads preserve the staging handle and allocate
no live Abla memory.

For work that must remain in flight, `GraphicsBufferTransferQueue` owns a fixed
set of reusable staging slots and returns compact integer tickets:

```abla
val uploads = app.bufferTransferQueue(BufferTransferQueueDescriptor(
    direction = bufferTransferDirectionUpload,
    slotCapacity = 65536,
    slotCount = 3,
    alignment = 256
))

val ticket = app.enqueueUploadBufferRange(
    uploads,
    frameBytes,
    deviceBuffer,
    0,
    destinationOffset,
    frameBytes.size
)
if (bufferTransferTicketValid(ticket)) {
    // Do independent CPU work before waiting for this specific copy.
    uploads.wait(ticket)
}
```

A queue has one to eight slots and one persistent coherent staging buffer split
into aligned, fixed-capacity ranges. Enqueue submits immediately and never waits
for a busy selected slot; it returns zero on validation, submission, or
availability failure without advancing queue state. `poll(ticket)` is a
zero-timeout query, `wait(ticket, timeoutNanoseconds)` waits only for that
operation, and `waitAll()` is an explicit queue-wide convenience. Tickets pack
the slot and generation into an `int`, so enqueue, poll, and wait allocate no
Abla heap memory and an old ticket is rejected after its slot is reused.

OpenGL owns one `GLsync` per slot and uses zero-timeout `glClientWaitSync` for
polling. Vulkan owns one command pool, command buffer, fence, and ABI scratch
block per slot and polls with `vkGetFenceStatus`. Neither backend calls
`glFinish`, `vkQueueWaitIdle`, or `vkDeviceWaitIdle` for these queue operations.

Readback uses a separate direction so a slot never changes mapping semantics:

```abla
val downloads = app.bufferTransferQueue(BufferTransferQueueDescriptor(
    direction = bufferTransferDirectionReadback,
    slotCapacity = 65536,
    slotCount = 3,
    alignment = 256
))
val ticket = app.enqueueReadbackBufferRange(
    downloads,
    deviceBuffer,
    sourceOffset,
    resultBytes.size
)

// resolveReadback is non-blocking; waitReadback waits only for this ticket.
if (!app.resolveReadback(downloads, ticket, resultBytes)) {
    app.waitReadback(downloads, ticket, resultBytes)
}
```

CPU readback bytes are copied only after native completion. The async-buffer
sample submits three uploads and three downloads before their waits, checks the
exact bytes on both backends, and reports zero live-byte growth in repeated
upload operations. The focused transfer gate additionally proves that staging,
Vulkan command-pool, and Vulkan command-buffer handles remain stable.

Textures use the same fixed-slot ticket model. The concise `PixelBuffer` path
accepts RGBA8 data, checked mip/origin/extent regions, and native RGBA/BGRA
channel order:

```abla
val uploads = app.textureTransferQueue(TextureTransferQueueDescriptor(
    direction = textureTransferDirectionUpload,
    slotCapacity = 4194304,
    slotCount = 3,
    alignment = 256
))
val upload = app.enqueueUploadTextureRange(
    uploads,
    pixels,
    texture,
    mipLevel,
    textureX,
    textureY
)

val downloads = app.textureTransferQueue(TextureTransferQueueDescriptor(
    direction = textureTransferDirectionReadback,
    slotCapacity = 4194304,
    slotCount = 3,
    alignment = 256
))
val download = app.enqueueReadbackTextureRange(
    downloads,
    texture,
    mipLevel,
    textureX,
    textureY,
    width,
    height
)
app.waitTextureReadback(downloads, download, resultPixels)
```

`enqueueUploadTexture` and `enqueueReadbackTexture` accept immutable
`TextureWriteDescriptor` and `TextureReadDescriptor` values for concise setup
code. Their `...Range` counterparts pass only scalars and are the intended
allocation-free streaming path. Every queue owns one persistent staging buffer
and one native completion slot per configured entry. OpenGL uses pixel
unpack/pack buffer offsets plus `GLsync`; Vulkan records buffer/image copies,
per-mip layout transitions, a transfer-to-host barrier for readback, and one
fence-backed command buffer per slot. Enqueue never waits for a busy selected
slot. Textures must remain alive and externally unsynchronized until their
ticket completes.

The focused texture-transfer gate submits multiple operations before waiting,
checks exact RGBA and BGRA regions, slot-generation reuse, invalid capacity,
stable native handles, and zero live-byte growth on OpenGL, Vulkan, and auto
selection. `examples/async-texture` demonstrates three in-flight frames and
allocation-free repeated texture streaming.

Raw `BufferBytes` queues extend the same contract to single-sample color and
compressed 1D, 2D, 2D-array, cube, and 3D selections:

```abla
val upload = app.enqueueUploadTextureBytes(
    uploads,
    sourceBytes,
    arrayTexture,
    TextureRegion(
        mipLevel = 1,
        x = 1, y = 1, z = 1,
        width = 3, height = 2, depth = 2
    ),
    TextureDataLayout(
        offset = 16,
        bytesPerRow = 20,
        rowsPerImage = 4
    )
)
uploads.wait(upload)

val download = app.enqueueReadbackTextureBytesRange(
    downloads,
    arrayTexture,
    1, 1, 1, 1,
    3, 2, 2,
    16, 20, 4
)
app.waitTextureBytesReadback(downloads, download, resultBytes)
```

Each slot stores tight native bytes. Upload enqueue repacks a caller's pitched
layout into that bounded slot; readback resolution scatters active rows back
into the requested layout without modifying offset, row, or image padding.
Slot capacity therefore bounds the active texture bytes, while source and
destination footprints are validated independently. Array/cube `z` selects
layers; 3D `z` selects physical depth. Descriptor calls are convenient setup
forms, while `enqueueUploadTextureBytesRange` and
`enqueueReadbackTextureBytesRange` are the measured allocation-free streaming
forms. Raw depth/stencil and multisampled transfers are rejected.

The wider asynchronous gate queues array, cube, volume, and BC1 operations
before waiting, checks exact bytes, untouched padding, capacity/layout
rejection, stale tickets, stable backend slot resources, and zero live-memory
growth on OpenGL, Vulkan, and automatic selection.

OpenGL range operations call `glBufferSubData`/`glGetBufferSubData` directly.
Vulkan buffers use host-visible coherent memory, map from aligned offset zero,
and copy through the compiler's LLVM memory-copy intrinsic. Each Vulkan buffer
owns its map output cell, so repeated `writeBytes`/`readBytes` calls allocate no
general memory. The common-buffer sample checks this with four repeated pairs
and requires zero Abla runtime live-byte growth. Checked 64-bit probes remain
available for small diagnostics.

`app.copyBuffer(source, destination, descriptor)` performs a GPU-side copy
between distinct buffers owned by the same application. Source and destination
copy usages are mandatory, and the same overflow-safe descriptor validates both
ranges. `copyBufferRange` exposes the identical primitive-offset operation for
allocation-critical loops. OpenGL binds copy-read/copy-write targets and calls
`glCopyBufferSubData`, then uses `glFenceSync`/`glClientWaitSync`/`glDeleteSync`
as an explicit completion point instead of calling `glFinish`. Vulkan owns one
transfer command pool, command buffer, and scratch ABI block with the device,
resets and reuses them, emits
`vkCmdCopyBuffer` plus a transfer-to-host barrier, and waits for queue completion.
Repeated copies preserve those handles and show zero Abla runtime live-byte
growth. This initial operation is deliberately synchronous; it establishes the
copy semantics and reusable command state needed by future queued transfer
rings.

`app.fillBuffer(buffer, descriptor)` writes one unsigned 32-bit pattern across
a four-byte-aligned GPU buffer range. The destination requires copy-destination
usage; the descriptor rejects out-of-range patterns, unaligned offsets/sizes,
empty fills, and crossing ranges before dispatch. OpenGL uses
`glClearBufferSubData` with an eight-byte buffer-owned native scratch cell.
Vulkan records `vkCmdFillBuffer` and a transfer-to-host barrier in the same
device-owned reusable transfer command state used by copies. The descriptor is
explicit so performance-sensitive loops can construct it once and avoid
per-call descriptor allocation. Repeated fills preserve native handles and
produce zero runtime live-byte growth in the common-buffer sample.

Fixed-slot asynchronous RGBA8/BGRA8 `PixelBuffer` and raw pitched
`BufferBytes` texture upload/readback are available through
`GraphicsTextureTransferQueue`. Complete texture-object reuse is exposed by
`GraphicsTexturePool`; physical device-memory suballocation is not exposed.
An application must let child buffers drop before its device/context.

Textures and views use the same backend-neutral ownership rule:

```abla
val color = app.texture(TextureDescriptor(
    size = Extent3D(1024, 1024),
    mipLevels = 11,
    format = textureFormatRgba8UnormSrgb,
    usage = textureUsageSampled | textureUsageCopySource |
        textureUsageCopyDestination
))
val fullView = color.view()
```

The portable descriptor vocabulary also defines `textureDimension2DArray`,
`textureDimensionCube`, and `textureDimension3D`. `Extent3D.depth` is physical
depth for a 3D texture and array-layer count for a 2D array or cube; a cube is
square and has exactly six layers. Array layers do not shrink across mip levels,
while 3D depth does. A default `TextureViewDescriptor` inherits its parent's
dimension. A 2D-array view may select the full array or one layer as 2D; a cube
view selects all six faces, while individual faces may be viewed as 2D.

`TextureRegion(mipLevel, x, y, z, width, height, depth)` expresses a checked
subresource selection. `-1` extents select the remaining mip range. Its
validation uses subtraction-based bounds checks, distinguishes physical depth
from array layers, and requires compressed origins/extents to align to format
blocks except at a mip edge. `TextureDataLayout(offset, bytesPerRow,
rowsPerImage)` describes byte storage; zero pitches mean tightly packed. It
computes the exact last-byte footprint with checked products/additions and
rejects short buffers, invalid pitches, block misalignment, and integer
overflow. `textureFormatBc1RgbaUnorm` and
`textureFormatBc1RgbaUnormSrgb` establish the first eight-byte 4x4 compressed
block family and compatible linear/sRGB views.

These wider descriptors, pure validation, native allocation, view ownership,
and synchronous byte transfers are delivered. OpenGL uses immutable
1D/2D/3D/array/cube storage and Vulkan uses the matching image type, physical
depth or array layers, and cube-compatible flag. BC1 allocation and pitched
transfer are live on both. `PixelBuffer` transfer methods intentionally remain
the convenient logical-RGBA 2D surface.

`BufferBytes` transfers expose the exact storage representation and do not
perform logical RGBA conversion. Uncompressed bytes follow the declared
texture format's component order (`R`, `RG`, `RGBA`, or `BGRA`) and scalar
representation; BC1 data uses consecutive standard eight-byte 4x4 blocks.
Only active texel or block bytes are copied. Offset, end-of-row padding, and
end-of-image padding in a readback buffer remain untouched:

```abla
val region = TextureRegion(
    mipLevel = 1,
    x = 1,
    y = 1,
    z = 1,
    width = 3,
    height = 2,
    depth = 2
)
val layout = TextureDataLayout(
    offset = 16,
    bytesPerRow = 20,
    rowsPerImage = 4
)
val source = bufferBytes(160)
arrayTexture.writeBytes(source, region, layout)

val destination = app.texture(arrayTexture.descriptor)
app.copyTextureRange(
    arrayTexture,
    destination,
    1, 1, 1, 1,
    1, 4, 1, 0,
    3, 2, 2
)
val readback = bufferBytes(160)
destination.readBytes(
    readback,
    TextureRegion(
        mipLevel = 1,
        x = 4,
        y = 1,
        z = 0,
        width = 3,
        height = 2,
        depth = 2
    ),
    layout
)
```

`writeBytes` requires `textureUsageCopyDestination`; `readBytes` requires
`textureUsageCopySource`. Both calls are synchronous. They support
single-sample color and compressed 1D, 2D, 2D-array, cube, and 3D selections,
subject to each format/dimension's native support. Depth/stencil raw transfer
is rejected in this slice. `copyTextureRange` requires distinct
application-owned, same-dimension, same-format, single-sample color textures
with matching copy usages and validates both mip/xyz ranges and compressed
block rules.

For allocation-critical loops, `writeBytesRange` and `readBytesRange` accept
the same mip/xyz/extent/layout fields as primitive scalars. Reusing those calls
and `copyTextureRange` preserves native image, staging, command-pool, and
command-buffer handles and produces zero Abla runtime live-byte growth in the
focused gate and `examples/wider-texture`.

Full-resource sampled bindings also accept 2D-array, cube, and 3D textures.
The strict `$glsl` subset emits matching Vulkan image dimensions and vec3
texture coordinates for `sampler2DArray`, `samplerCube`, and `sampler3D`, while
OpenGL compiles the same source directly. `examples/wider-sampling` uploads
distinct array layers, cube faces, and volume slices, selects one of each, and
checks the exact rendered center pixel on both backends. The same sample binds
narrowed one-layer array and cube-face views plus an explicit volume view. It
checks the same exact pixels without hidden replacement views: OpenGL binds the
view object directly, while Vulkan borrows the existing `VkImageView` and only
destroys default views that the bind group created itself.

`GraphicsTexture` owns an allocated OpenGL texture or Vulkan image plus bound
device memory. A full matching OpenGL view is a non-owning alias; subresource
and compatible-format views own independent `glTextureView` names. Vulkan
views own `VkImageView` objects. Both paths support single-sample 1D, 2D,
2D-array, cube, and 3D color resources, 2D depth resources, complete mip
allocation, and validated color/depth/stencil aspect ranges. They also create
2x, 4x, 8x, and 16x multisampled 2D color/depth textures when usage is exactly
`textureUsageRenderAttachment`; sampled/copy usage remains rejected, so an
application resolves into a separate single-sample resource, either owned by
the target or supplied explicitly. Compatible linear/sRGB reinterpretation
uses mutable-format Vulkan images or immutable OpenGL storage. Extents or array
layers above the selected dimension-specific device limit return
`graphicsErrorLimitExceeded` before image creation.

RGBA8 pixel storage can update a validated region of any mip in an RGBA8/BGRA8
texture carrying `textureUsageCopyDestination`:

```abla
val pixels = pixelBuffer(64, 64)
pixels.clearRgba8(23, 47, 89, 255)
texture.writePixels(pixels, TextureWriteDescriptor(
    mipLevel = 2,
    x = 8,
    y = 4
))

val copied = app.texture(TextureDescriptor(
    size = Extent3D(1024, 1024),
    mipLevels = 11,
    format = textureFormatRgba8UnormSrgb,
    usage = textureUsageSampled | textureUsageCopySource |
        textureUsageCopyDestination
))
app.copyTexture(color, copied, TextureCopyDescriptor(
    sourceMipLevel = 2,
    sourceX = 8,
    sourceY = 4,
    destinationMipLevel = 1,
    destinationX = 32,
    destinationY = 16,
    width = 64,
    height = 64
))
```

`TextureWriteDescriptor` checks mip range, nonnegative origin, overflow-safe
region bounds, format, and declared copy usage before a driver call.
`texture.rgba8(x, y, mipLevel)` provides synchronous diagnostic readback when
`textureUsageCopySource` was declared. OpenGL uses direct subimage upload and
exact `glGetTextureSubImage` readback into texture-owned scratch. Vulkan owns a
reusable coherent staging buffer, command pool, command pointer cell, and
scratch ABI block with the texture, tracks every mip layout independently,
performs explicit transfer/shader-read transitions, and converts RGBA/BGRA byte
order. Texture-transfer validation is a direct non-allocating predicate, and
the write descriptor is explicit so applications can reuse it. Four repeated
upload/readback/copy cycles preserve native handles and show zero runtime
live-byte growth on both backends. Synchronization is currently queue-idle and
therefore intended for asset upload and verification, not streaming every
frame.

`app.copyTexture(source, destination, descriptor)` copies a checked 2D region
between distinct same-format, single-sample color textures owned by the
application.
The descriptor validates both usage flags, mip levels, origins, and resolved
extent without overflow-prone end arithmetic. OpenGL calls
`glCopyImageSubData`. Vulkan records `vkCmdCopyImage` between explicit transfer
layouts, restores the source layout, selects the destination resting layout,
and keeps per-mip layout state in initialized native storage. It reuses the
device transfer pool, command buffer, and scratch block established for buffer
copies; repeated image copies preserve those handles and general live memory.
The current operation waits for queue completion. Multisample image copies,
1D/array/cube/3D copies, format-converting copies, and general byte layouts are
not yet part of this common slice. The separate fixed-slot queue supports
RGBA8/BGRA8 2D upload/readback, but not the wider `TextureDataLayout` contract.
Views must
drop before their parent texture, and textures must drop before the application
device/context.

`texture.generateMipmaps()` generates every level after level zero for a
single-sample 2D RGBA8/BGRA8 texture declaring both copy usages and at least two
levels. OpenGL calls `glGenerateTextureMipmap`. Vulkan records linear
`vkCmdBlitImage` operations between adjacent mip levels, transitions every
subresource explicitly, and restores all levels to the sampled/general resting
layout in the texture-owned reusable command buffer. Four repeated generations
preserve image, pool, and command handles with zero live-byte growth; exact
solid-color readback verifies both the first generated level and the final 1x1
level. Depth, multisampled, single-level, and missing-usage inputs are rejected
before a driver call. Like synchronous copies, the Vulkan path currently waits
for queue completion.

A single-sample 2D color texture with `textureUsageRenderAttachment` can be
transferred into an affine render target:

```abla
val color = app.texture(TextureDescriptor(
    size = Extent3D(640, 360),
    usage = textureUsageRenderAttachment |
        textureUsageSampled | textureUsageCopySource
))
val target = app.renderTarget(move(color))
app.clearRenderTarget(target, Color(0.25, 0.5, 0.75))
```

An explicitly owned, same-size depth attachment is added without hidden target
allocations:

```abla
val depthColor = app.texture(TextureDescriptor(
    size = Extent3D(640, 360),
    usage = textureUsageRenderAttachment | textureUsageSampled
))
val depth = app.texture(TextureDescriptor(
    size = Extent3D(640, 360),
    format = textureFormatDepth32Float,
    usage = textureUsageRenderAttachment
))
val depthTarget = app.renderTargetWithDepth(move(depthColor), move(depth))
```

Color and depth sample counts must match. A render-attachment-only multisampled
target uses the same ownership and pipeline API:

```abla
val msaaColor = app.texture(TextureDescriptor(
    size = Extent3D(640, 360),
    samples = 4,
    usage = textureUsageRenderAttachment
))
val msaaDepth = app.texture(TextureDescriptor(
    size = Extent3D(640, 360),
    samples = 4,
    format = textureFormatDepth32Float,
    usage = textureUsageRenderAttachment
))
val resolved = app.texture(TextureDescriptor(
    size = Extent3D(640, 360),
    usage = textureUsageRenderAttachment | textureUsageSampled |
        textureUsageCopyDestination | textureUsageCopySource
))
val msaaTarget = app.renderTargetWithDepth(
    move(msaaColor),
    move(msaaDepth),
    [move(resolved)]
)

app.renderPassToTarget(msaaTarget, pipeline, pass)
val output = msaaTarget.resolveTextures[0]
```

OpenGL allocates `GL_TEXTURE_2D_MULTISAMPLE` attachments and Vulkan records the
same sample count in image, attachment, compatible-pass, and raster pipeline
state. The optional final constructor argument transfers affine ownership of
exactly one matching single-sample resolve texture per color. Each resolve
texture must declare `textureUsageRenderAttachment` and
`textureUsageCopyDestination`; every successful target clear or draw updates
all owned resolves before returning. Explicit
`resolveRenderTarget` requires a single-color multisampled source and an
application-owned, same-size, same-format single-sample destination declaring
`textureUsageCopyDestination`. OpenGL reuses a target-owned resolve FBO and
`glBlitFramebuffer`. Vulkan target-owned outputs are image views in the target
framebuffer and native `pResolveAttachments` references in both default and
operation-specialized compatible render passes. Separately owned explicit
resolves reuse device transfer state, record `vkCmdResolveImage`, and restore
tracked image layouts. Repeated render/resolve cycles preserve native handles
and show zero runtime live-byte growth.

Two to eight same-size color attachments use the same affine ownership model.
Attachment zero remains `target.texture`; subsequent attachments are held in
`target.additionalTextures`:

```abla
val target = app.renderTargetWithColors(
    move(albedo),
    [move(normal), move(material)]
)

// Alternative when the target also needs a depth attachment:
val targetWithDepth = app.renderTargetWithColorsAndDepth(
    move(depthAlbedo),
    [move(depthNormal), move(depthMaterial)],
    move(depthAttachment),
    [move(resolvedAlbedo), move(resolvedNormal), move(resolvedMaterial)]
)

val resolvedAlbedoOutput = targetWithDepth.resolveTextures[0]
val resolvedNormalOutput = targetWithDepth.resolveTextures[1]
```

The fragment shader must declare contiguous outputs beginning at location zero,
with exactly `target.colorCount()` outputs. OpenGL attaches each texture and
selects all draw buffers. Vulkan creates matching attachment descriptions,
references, image views, framebuffer entries, clear values, and pipeline blend
states. The common API rejects mismatched shader-output counts before native
pipeline creation.

The target owns the texture, ensuring the backend attachment dies before its
image. OpenGL owns and completeness-checks a framebuffer object. Vulkan owns a
compatible full image view, render pass, and framebuffer, with a sampled target
ending in shader-read layout. `clearRenderTarget` records a real Vulkan render
pass through the reusable device transfer command or binds and clears the
OpenGL FBO. Repeated clears allocate nothing and preserve all attachment and
command handles.

Distinct attachment clears are prepared once as an affine resource and bound
to the exact target shape through an affine render pass:

```abla
val clears = renderPassClearValues(
    Color(0.0, 0.0, 1.0, 1.0),
    [Color(1.0, 1.0, 0.0, 1.0)],
    0.75
)
val pass = app.renderPass(target, move(clears))
app.renderPassToTarget(target, pipeline, pass)
```

`RenderPassClearValues` owns a stable native clear-value block, and
`GraphicsRenderPass` validates the target identity, dimensions, color count,
depth presence, and backend once. Reusing that pass performs no general heap
allocation on either backend. The scalar-clear `renderToTarget` form remains a
compact shorthand and applies the same color to every color attachment.

Portable attachment operations are immutable pass-creation data. Each color
and the optional depth attachment selects clear, load, or discard on entry and
store or discard on exit:

```abla
val mixedPass = app.renderPass(
    target,
    move(mixedClears),
    RenderPassOperations(
        color = RenderAttachmentOperations(
            load = attachmentLoadOperationLoad,
            store = attachmentStoreOperationStore
        ),
        additionalColors = [RenderAttachmentOperations(
            load = attachmentLoadOperationClear,
            store = attachmentStoreOperationDiscard
        )],
        depth = RenderAttachmentOperations(
            load = attachmentLoadOperationClear,
            store = attachmentStoreOperationStore
        )
    )
)
```

An empty `additionalColors` array applies `color` to every color attachment;
otherwise it must contain exactly one operation for each additional attachment.
Vulkan creates an owned render pass compatible with the target framebuffer and
pipeline, with explicit initial/final layouts. OpenGL performs selective
`glClearBufferfv` calls and maps discard intent to
`glInvalidateFramebuffer` before or after the draw. Both mappings are prepared
once and add no steady-state allocation. OpenGL discard passes require core
version 4.3 or newer and fail as unsupported on an older context. Invalid
operation values, attachment counts, and target/pass mismatches are rejected
before encoding.

An ordered procedural subpass sequence is prepared against one pass and target:

```abla
val pass = app.renderPass(
    target,
    move(clears),
    RenderPassOperations(),
    2
)
val first = app.renderPassPipeline(target, pass, 0, firstShader)
val second = app.renderPassPipeline(target, pass, 1, secondShader)
val sequence = app.subpassPipelines(
    target,
    pass,
    [move(first), move(second)]
)
app.renderSubpassesToTarget(target, sequence, pass)
```

The pass and sequence support two through eight stages. Each stage writes the
target's complete color set and uses the same optional depth and resolve
attachments; its pipeline may independently select raster, depth, and bind-group
state. Vulkan creates one native subpass description per stage, inserts
by-region color-output dependencies, and records `vkCmdNextSubpass` in one
render pass. OpenGL preserves the same ordered semantics with successive FBO
draws, applying load operations only before the first and store/discard
operations only after the final stage. Pipeline handles and Vulkan binding
arrays are prepared once, so repeated sequence execution performs no general
heap allocation. The `subpasses` sample makes its first depth test reject every
fragment and verifies that the second stage alone produces the exact output on
both backends.

The same pass resource drives every buffered command form without rebuilding
or repacking its attachment clears:

```abla
app.renderPassVerticesToTarget(target, pipeline, pass, vertices, 3)
app.renderPassIndexedToTarget(target, pipeline, pass, vertices, indices, 3)
app.renderPassVerticesIndirectToTarget(
    target, pipeline, pass, vertices, drawCommand
)
app.renderPassIndexedIndirectToTarget(
    target, pipeline, pass, vertices, indices, indexedDrawCommand
)
```

Direct variants accept an optional instance count. The common validation rejects
a pass created for another target even when its attachment dimensions happen
to match. All four methods, their scalar-clear target counterparts, and all
eight push-aware target/pass forms accept the same optional checked vertex,
index, and indirect byte ranges as surfaced rendering. Pool users normally call
the generation-checked `renderPassBufferPool*ToTarget`,
`renderBufferPool*ToTarget`, `renderPushPassBufferPool*ToTarget`, and
`renderPushBufferPool*ToTarget` families instead.

`app.renderTargetPipeline(target, shader, vertexLayout, raster, depth, binding)`
compiles a raster pipeline against the target format. Procedural pipelines use
`renderToTarget`, or `renderPassToTarget` with prepared attachment values;
buffered pipelines use the matching `renderPass*ToTarget` family above or the
scalar-clear `renderVerticesToTarget`/`renderIndexedToTarget` forms. Indirect
counterparts consume one portable OpenGL/Vulkan indirect command from a buffer,
and every direct form accepts an instance count. Bind groups are applied exactly
as they are for a surface pipeline. Vulkan borrows the target render pass and
framebuffer through explicit non-owning pipeline flags; OpenGL binds the target
FBO. A target
declaring sampled usage can then feed an ordinary bind group and surface
pipeline. A depth-enabled pipeline must target a depth-attached target; color-
only/depth-state mismatches are rejected. The `render-to-texture` sample
suballocates vertices, indices, and both indirect commands from one explicitly
device-local backing buffer at byte offsets 16/48/64/80, exercises all four
pass-bound command forms against a 4x color/depth target, automatically resolves
its owned output, then samples it, with exact center-pixel verification, stable
native handles, and zero live-byte growth. The same
command forms operate on multiple color attachments and honor the same
per-attachment operations. `resolveRenderTargetColor` validates an attachment
index and resolves any color of a multisampled MRT into its matching owned
single-sample texture; `resolveRenderTarget` is the concise single-color form.
When `target.resolveTextures` is populated by a target constructor, completion
performs those resolves automatically.

Samplers are also driver-backed affine resources:

```abla
val linear = app.sampler(SamplerDescriptor(
    addressU = samplerAddressRepeat,
    magFilter = samplerFilterLinear,
    minFilter = samplerFilterLinear,
    mipmapFilter = samplerFilterLinear
))
```

The common descriptor maps address, magnification/minification/mipmap filters,
integer LOD bounds, and optional comparison state to OpenGL sampler objects and
`VkSampler` values. Abla rounds the API's native `f64` values to the required
IEEE-754 binary32 representation in pure Abla. Anisotropy above one is accepted
only when `graphicsFeatureSamplerAnisotropy` is present and the requested
integer value does not exceed `maximumSamplerAnisotropy`; otherwise creation
returns `graphicsErrorUnsupportedFeature`. OpenGL discovers the registered
ARB/EXT extension and sets `GL_TEXTURE_MAX_ANISOTROPY` through a float-vector
parameter. Vulkan queries and explicitly enables `samplerAnisotropy`, then sets
both `anisotropyEnable` and `maxAnisotropy` in `VkSamplerCreateInfo`.

## Small application

The descriptor/encoder form below is the target surface being implemented on
top of the available application slice:

```abla
import github("AndreBaltazar8/abla-graphics")

fun main: int = graphicsApplication(
    GraphicsConfig(
        backend = GraphicsBackend.auto,
        validation = true
    ),
    WindowConfig(
        title = "Abla triangle",
        width = 1280,
        height = 720
    )
) { app ->
    val shader = app.device.shader(#$glsl {
        vertex {
            layout(location = 0) in vec2 position;
            void main() { gl_Position = vec4(position, 0.0, 1.0); }
        }
        fragment {
            layout(location = 0) out vec4 color;
            void main() { color = vec4(0.12, 0.54, 0.96, 1.0); }
        }
    })

    val pipeline = app.device.renderPipeline(RenderPipelineDescriptor(
        shader = shader,
        colorFormat = app.surface.format
    ))

    app.frames { frame ->
        frame.render(RenderPassDescriptor(
            color = frame.color.clear(Color(0.02, 0.03, 0.05, 1.0))
        )) { pass ->
            pass.pipeline(pipeline)
            pass.draw(vertices = 3)
        }
    }
}
```

The final syntax will be kept within capabilities implemented by `../ablac`.
Named/default arguments, trailing lambdas, resource classes, compile-time `#`,
and Abla-defined subparsers are deliberate language features used here.

## Backend selection

`graphicsBackendAuto` prefers Vulkan when the requested features and surface
are supported, otherwise OpenGL. `graphicsBackendVulkan`,
`graphicsBackendOpenGl`, and `graphicsBackendHeadless` are explicit choices.
Selection is performed once and never becomes a silent per-frame fallback.

`GraphicsConfig.requiredFeatures` is a bit mask of
`graphicsFeatureCompute`, `graphicsFeatureStorageBuffers`,
`graphicsFeatureSampledTextures`, `graphicsFeatureDepthTextures`,
`graphicsFeatureComparisonSamplers`,
`graphicsFeatureViewFormatReinterpretation`,
`graphicsFeatureSamplerAnisotropy`, `graphicsFeatureTimestampQueries`,
`graphicsFeaturePersistentMapping`, `graphicsFeatureStorageTextures`,
`graphicsFeatureFragmentStorageTextures`, and
`graphicsFeatureStorageTextureExtendedFormats`, and
`graphicsFeatureCubeStorageTextures`.
Creation fails with
`graphicsErrorUnsupportedFeature` when an installed requested backend cannot
provide every required bit. Automatic selection may skip such a backend and
select the next capable one.

After successful creation, `app.capabilities` reports the selected driver's
feature mask, `GraphicsVersion`, maximum 1D/2D/3D/cube texture dimensions,
maximum texture-array layers, maximum storage buffer byte range, maximum
compute workgroups in X, maximum compute workgroup size in X, maximum compute
invocations, and maximum integer sampler anisotropy.
The corresponding Y/Z workgroup-count and local-size limits are also reported.
These values come from
`glGet*` on the current OpenGL context or `vkGetPhysicalDeviceProperties` and
the selected Vulkan queue family. OpenGL 4.3+ advertises view-format
reinterpretation through immutable texture storage and owned `glTextureView`
resources; Vulkan advertises it through the implemented mutable-format
image-view path. Unknown requirement bits are an invalid configuration.

OpenGL 4.3 advertises fragment storage images and the portable extended format
family directly. Vulkan reports and enables the corresponding
`fragmentStoresAndAtomics` and `shaderStorageImageExtendedFormats` feature bits;
automatic selection therefore cannot choose a backend that merely accepts the
descriptor while lacking the shader-stage capability.

This is the delivered portable capability subset, not a claim of complete
extension/feature-chain negotiation. Optional feature preferences and typed
extension objects remain planned API work.

### OpenGL and Vulkan debug utilities

Applications that import the optional `debug.ab` module can use one normalized
interface after backend selection:

```abla
val debug = app.debugMessenger()
if (debug.valid()) {
    debug.submit(graphicsDebugSeverityInfo, "loading scene")
    val counts = debug.counts()
}
```

`GraphicsDebugMessenger` is affine and works with surfaced and headless
applications. It maps verbose, info, warning, and error intent to the selected
backend once, preserves backend-specific callback ownership internally, and
performs no allocation on repeated `submit` calls. It must be dropped before
the application. If validation was disabled for a Vulkan application, creation
returns `graphicsErrorUnsupportedFeature` instead of silently enabling the
extension.

OpenGL 4.3 or newer exposes an affine debug messenger after importing the
optional `driver/opengl_debug.ab` module and calling
`context.debugMessenger()`. The messenger enables synchronous core debug
output, registers a process-resolved `@export` Abla callback, and accepts
allocation-free application messages through `submit(type, severity,
message)`. `counts()` reports atomic totals for all four severities and the
error, deprecated-behavior, undefined-behavior, portability, performance,
marker, and other message classes. Pass `false` to `debugMessenger(false)` for
an explicitly disabled object. The messenger must be dropped before its OpenGL
context.

`vulkanInstance()` and `vulkanX11Instance()` discover and enable
`VK_EXT_debug_utils` by default when the loader advertises it. Pass
`enableDebugUtils = false` for an explicit unsupported path. The resulting
instance exposes the negotiated state through `debugUtils` and creates an
affine messenger with `instance.debugMessenger()` after importing the optional
`driver/vulkan_debug.ab` module. `GraphicsConfig.validation` controls instance
extension negotiation in the common surfaced and headless constructors; a
caller that wants message capture owns the explicit messenger and must drop it
before the application or instance.

The default messenger accepts verbose, info, warning, and error severities and
general, validation, and performance message types. Its callback is an
`@export` Abla function resolved from the process image; create, destroy, and
submit entry points are loaded with `vkGetInstanceProcAddr` and invoked through
fixed-signature unsafe operations. No framework C shim is involved.

`messenger.counts()` returns atomic totals per severity and type.
`messenger.submit(severity, types, message)` synchronously exercises the same
driver callback, rejects unknown masks, and accepts messages up to 4,095 bytes.
After construction it reuses one owned scratch block, so repeated submissions
preserve both the messenger handle and Abla live-byte count. Dropping the
messenger destroys the Vulkan object exactly once before releasing its counter
and scratch storage.

Applications that need a coarse synchronization boundary can wait for every
submitted command on the selected backend:

```abla
if (!app.waitIdle()) {
    // The application/backend was invalid or the Vulkan driver wait failed.
}
```

This makes the OpenGL context current and calls `glFinish`, or calls
`vkDeviceWaitIdle` for Vulkan. It is intended for diagnostics and lifecycle
boundaries, not per-frame pacing. Repeated waits allocate no general memory and
retain all native handles.

## Resource surface

The common device creates:

- buffers, textures, texture views, and samplers;
- bind-group layouts, bind groups, and pipeline layouts;
- shader modules and render/compute pipelines;
- query sets and timestamp helpers; and
- command encoders with render/compute/copy/debug operations.

Creation descriptors are immutable values; the initial buffer, texture, view,
and sampler descriptor slice described above is available now. Common buffers,
textures, views, and samplers are affine resources; remaining resource
implementations will follow the same ownership rule.
Borrowing a resource for encoding does not transfer it. Explicit `move` is used
only when ownership actually changes.

`graphicsRenderGraph(resources, passes)` builds a deterministic common planning
value before any backend command is recorded. Resources have stable IDs,
transient/imported ownership, byte sizes, and an application-defined
compatibility class. Passes declare one read, write, or read/write use per
resource plus optional `after` dependencies by pass ID. The planner adds
declaration-order edges for read/write hazards, performs a stable topological
sort, rejects unknown dependencies and cycles, and reports every used
resource's first and last scheduled pass.

`plan.barriers` contains declaration-order read/write transitions pruned when
an intervening access already supplies the dependency path. Each record carries
the resource ID, source/destination pass IDs, and both access masks. Explicit
ordering edges do not fabricate resource barriers. These backend-neutral
records are the input to the delivered ordered OpenGL memory-barrier and Vulkan
synchronization2/fallback executor described below.

Transient resources with disjoint lifetimes and the same compatibility class
share the lowest available `GraphicsGraphAllocation` slot. Slot capacity grows
to the largest aliased resource, while overlapping or incompatible lifetimes
remain separate. Imported resources receive no allocation slot.

`app.materializeRenderGraphTextures(resources, passes, declarations)` turns
that plan into an affine, typed owner. Every transient logical resource has a
complete `TextureDescriptor`; its computed storage size must equal the planner
resource size. Equal opaque compatibility integers are insufficient on their
own: extent, dimension, mips, samples, format, and usage are compared before
sharing. One retained capacity-one `GraphicsTexturePool` backs each physical
slot, so compatible non-overlapping resources resolve to one stable OpenGL
texture or Vulkan image while overlapping/incompatible resources do not.

`app.materializeRenderGraphResources(resources, passes, textureDeclarations,
bufferDeclarations)` additionally accepts exactly one typed declaration per
logical resource. Imported buffers retain only their checked descriptor.
Transient buffers must be device-local and unmapped; compatible non-overlapping
lifetimes reuse one retained `GraphicsBufferPool` backing allocation, while
overlaps, descriptor mismatches, and texture/buffer cross-kind aliasing do not.
Pool geometry remains bounded to 65,536 blocks and one GiB, and oversize
requests reject before native allocation. `storageGraphBufferEntry` and
`uniformGraphBufferEntry` bind the exact retained range into an affine compute
pipeline.

Execution uses generation tokens and scheduled pass entry. Upload, readback,
transient/imported copy, and sampled-entry helpers require the logical resource
ID and verify its declared access in the current pass. Imported resources
remain caller-owned and are borrowed only after application ownership and exact
descriptor checks. Execution reset retains every lease and native object, so a
warmed pass walk allocates nothing.

`app.beginMaterializedRenderGraphPass(graph, token, passId)` is the ordered
backend entry. It validates the next planned pass, combines every incoming
logical barrier, emits one conservative `glMemoryBarrier` or Vulkan memory
barrier batch, and advances only after successful submission. Vulkan uses the
retained transfer command state and synchronization2 when available, with its
existing legacy fallback. Direct render/compute/copy calls then form the pass
body and continue to own exact image-layout transitions. The command-list path
may instead use the internal non-submitting Vulkan pass recorder so a complete
eligible stream submits once. Barrier counts and backend calls are observable
and allocation-free in warmed execution. Reusable
primitive barrier counts and source/destination access unions are compiled once
per scheduled pass during materialization, so repeated entry does not rescan
the planner's barrier list. The complete contracts are in
`docs/render-graph-textures.md` and `docs/render-graph-execution.md`.

The bounded reusable recording slice is available for materialized graphs:

```abla
val commands = app.graphCommandList(graph, 7)
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

// Buffered draws move their planner-declared input buffers into the list.
commands.recordRenderVertices(
    graph,
    importedVertexTargetId,
    vertexResourceId,
    move(vertexTarget),
    move(vertexPipeline),
    move(vertexBuffer),
    3
)
commands.recordRenderIndexed(
    graph,
    importedIndexedTargetId,
    indexedVertexResourceId,
    indexResourceId,
    move(indexedTarget),
    move(indexedPipeline),
    move(indexedVertexBuffer),
    move(indexBuffer),
    3
)
commands.recordRenderVerticesIndirect(
    graph,
    importedIndirectTargetId,
    indirectVertexResourceId,
    drawResourceId,
    move(indirectTarget),
    move(indirectPipeline),
    move(indirectVertices),
    move(drawCommand)
)
commands.recordRenderIndexedIndirect(
    graph,
    importedIndexedIndirectTargetId,
    indexedIndirectVertexResourceId,
    indexResourceId,
    indexedDrawResourceId,
    move(indexedIndirectTarget),
    move(indexedIndirectPipeline),
    move(indexedIndirectVertices),
    move(indexBuffer),
    move(indexedDrawCommand)
)

// Every render form has a Push suffix that snapshots reflected bytes.
commands.recordRenderTargetPush(
    graph,
    importedPushTargetId,
    move(pushTarget),
    move(pushPipeline),
    pushValues
)

// A depth target declares and records both imported attachment identities.
commands.recordRenderTargetDepth(
    graph,
    importedColorId,
    importedDepthId,
    move(depthTarget),
    move(depthPipeline)
)
// recordRenderTargetDepthPush(...) also snapshots reflected push bytes.
commands.recordRenderTargetResolve(
    graph,
    importedMultisampleColorId,
    importedSingleSampleResolveId,
    move(resolveTarget),
    move(resolvePipeline)
)
// recordRenderTargetResolvePush(...) snapshots reflected push bytes.
commands.recordRenderTargetAttachments(
    graph,
    [firstColorId, secondColorId],
    [firstResolveId, secondResolveId],
    depthId,
    move(mrtTarget),
    move(mrtPipeline)
)
// recordRenderTargetAttachmentsPush(...) snapshots reflected push bytes.
val draw = graphRenderVerticesResources(vertexId, move(vertices), 3)
commands.recordRenderAttachments(
    graph,
    [firstColorId, secondColorId],
    [firstResolveId, secondResolveId],
    depthId,
    move(mrtTarget),
    move(mrtPipeline),
    move(draw)
)
// recordRenderAttachmentsPush(...) accepts the same affine draw plus values.
val texturedDraw = graphRenderProceduralResources()
val renderTextures = graphSubpassTextureResources(
    [atlasId], [move(atlas)], [move(atlasSampler)], [[0]]
)
commands.recordRenderBindingAttachments(
    graph,
    [colorId],
    [],
    -1,
    move(texturedTarget),
    move(texturedPipeline),
    move(texturedDraw),
    move(renderTextures)
)
// recordRenderBindingAttachmentsPush(...) composes the same retained binding
// table with a copied GraphicsPushConstants snapshot.
commands.recordRenderSubpasses(
    graph,
    [firstColorId, secondColorId],
    [firstResolveId, secondResolveId],
    depthId,
    move(subpassTarget),
    move(compatiblePass),
    move(subpassSequence)
)
// recordRenderPushSubpasses(...) accepts the same affine resources plus one
// reflected GraphicsSubpassPushConstants aggregate and snapshots its bytes.
val subpassBuffers = graphSubpassBufferResources(
    [firstUniformId, secondUniformId],
    [move(firstUniform), move(secondUniform)],
    [[0], [1]]
)
val subpassTextures = graphSubpassTextureResources(
    [firstAtlasId, secondAtlasId],
    [move(firstAtlas), move(secondAtlas)],
    [move(firstSampler), move(secondSampler)],
    [[0], [1]]
)
val subpassViews = graphSubpassTextureViewResources(
    [firstAtlasId, secondAtlasId],
    [move(firstAtlas), move(secondAtlas)],
    [move(firstView), move(secondView)],
    [move(firstSampler), move(secondSampler)],
    [[0], [1]]
)
val retainedEntry = app.sampledRetainedGraphTextureEntry(
    0, shaderVisibilityFragment, graph, transientAtlasId, sampler
)
val transientTextures = graphSubpassTransientTextureResources(
    graph, [transientAtlasId], [move(sampler)], [[0], [0]]
)
// graphSubpassBindingResources(...) composes buffer and texture tables for
// mixed bind groups. Each stage index addresses the table selected by the
// reflected entry kind.
commands.recordRenderBindingSubpasses(
    graph,
    [firstColorId, secondColorId],
    [firstResolveId, secondResolveId],
    depthId,
    move(bindingTarget),
    move(bindingPass),
    move(bindingSequence),
    move(subpassBuffers)
)
// recordRenderBindingPushSubpasses(...) accepts the same owned buffer table
// plus one reflected GraphicsSubpassPushConstants aggregate and snapshots it.
commands.recordPass(graph, 40)

// A storage pipeline must have been created against this exact buffer.
commands.recordComputeStoragePush(
    graph,
    storageResourceId,
    move(storage),
    move(computePipeline),
    computePushValues,
    1
)

if (commands.seal(graph)) {
    app.executeGraphCommands(graph, commands)
}
```

Creation preallocates capacity for at most 4,096 primitive records and captures
the exact pass order, logical resources, physical slots, native identities, and
storage descriptors. Recording accepts ordered pass markers, graph-owned
transient texture range copies, procedural/direct/indexed/indirect offscreen
renders to imported targets, and planner-visible imported or graph-owned buffer compute
dispatches. Every render form has a matching `Push` method that copies one
exact reflected block into bounded command-owned storage. Later source mutation
or destruction cannot affect replay. Buffered render records require exact imported buffer declarations
with pass read access, checked byte ranges, and vertex/index usage. The command
list also accepts procedural depth targets through `recordRenderTargetDepth`
and `recordRenderTargetDepthPush`. Every buffered render method, including its
`Push` form, accepts a final optional `depthResourceId`; a nonnegative value
enables the same depth contract without multiplying draw-form APIs. Both color
and depth must be imported texture resources with exact descriptors and write
access in the active pass. The command
list takes affine ownership of render targets, pipelines, caller render/compute
buffers, and retained bind groups; transient buffers stay owned by the graph.
Single-buffer compatibility APIs remain, while
`recordComputeBindings` and `recordTransientComputeBindings` validate every
logical ID, binding kind/range, descriptor, access, physical slot, and native
identity. The push forms copy at most 128 reflected bytes into preallocated
command storage; later source mutation cannot affect the sealed record.
Sealing performs complete descriptor/access/range validation and
fingerprints all used scalar fields. Replay rejects a different graph,
incompatible imported storage, or post-seal mutation before opening an
execution, then reuses scalar operations without descriptor construction. The
list borrows the graph, which must outlive it and submitted work. Eligible
Vulkan 2D-copy/render/compute streams submit once per complete replay; OpenGL and
unsupported copy shapes use the direct paths. A failed partial replay aborts
the graph generation so it can be used again. See
`docs/render-graph-commands.md` for the complete ownership, failure, performance,
and current-limit contract. A single-color multisample target uses
`recordRenderTargetResolve` or its `Push` form; both multisample source and
single-sample resolve output are exact imported pass writes and sealed
identities. `recordRenderTargetAttachments` and its `Push` form accept two to
eight ordered colors, no resolves or one resolve per color, and optional depth;
every attachment is descriptor/access checked and sealed. Buffered callers
compose one of the four `graphRender*Resources` affine factories with
`recordRenderAttachments` or its `Push` form. Ordinary recorded draws with
bind groups use `recordRenderBindingAttachments` or its `Push` form. One API
accepts procedural, direct, indexed, direct-indirect, or indexed-indirect draw
resources and the same typed buffer/texture/view/transient-texture table used
by subpass recording. The command retains every affine owner, seals logical
and native identities plus the one-stage mapping, and performs no allocation
in warmed replay. `recordRenderSubpasses` takes
affine ownership of one target, compatible pass, and two-to-eight-stage
procedural sequence. It binds ordered imported color IDs, zero or one resolve
ID per color, and optional depth to exact pass writes and descriptors. OpenGL
executes the stages in order; eligible Vulkan graph streams record the native
sequence into the same retained command buffer and submit once. Buffer-backed
bind-group subpasses use `recordRenderBindingSubpasses` as described below.
Compute sampled/image bindings, broader copy/dispatch forms, frames in flight,
and asynchronous submission
remain future work.

`recordRenderPushSubpasses` applies the same attachment contract and copies the
complete reflected per-stage aggregate into command-owned storage, bounded at
1,024 bytes. Later source mutation cannot affect replay. OpenGL binds each
stage's stored range through its persistent push UBO; Vulkan records matching
`vkCmdPushConstants` ranges inside the same consolidated graph submission.

`recordRenderBindingSubpasses` accepts pipelines with retained bind groups.
`graphSubpassBufferResources`, `graphSubpassTextureResources`,
`graphSubpassTextureViewResources`, `graphSubpassTransientTextureResources`,
and `graphSubpassBindingResources` take affine ownership of unique flattened
imported-resource tables and a per-stage array mapping each bind-group entry to
its kind-specific table. Buffer entries validate exact declarations, pass
access, ranges, usage flags, and backend identities. Sampled entries validate
single-sample color descriptors, sampled usage, pass reads, texture and sampler
identities, and reject attachment aliasing. View resources additionally retain
their parent texture and fingerprint the native view. Transient entries use
`sampledRetainedGraphTextureEntry` to build a descriptor against the graph's
stable one-slot pool lease; the command owns the sampler and seals the logical
ID, physical slot, native identity, and lease validity without owning the graph
texture. Every field participates in record, seal, replay, and fingerprint
checks. OpenGL performs ordered stage draws;
Vulkan records all descriptor-set binds and subpasses into the graph's one
retained command buffer. `recordRenderBindingPushSubpasses` composes this
ownership with the 1,024-byte snapshotted push aggregate, retaining descriptor
binds and push commands in the same ordered OpenGL replay or consolidated
Vulkan command buffer.

The delivered timestamp-query resource owns all result and command scratch at
creation. Sampling returns the backend counter without allocating:

```abla
val query = app.timestampQuery()
val begin = query.sampleTicks()
app.presentRender(pipeline, clear)
val end = query.sampleTicks()
val gpuNanoseconds = query.elapsedNanoseconds(begin, end)
```

OpenGL uses core timer-query objects and their nanosecond counter. Vulkan owns a
query pool and dedicated reusable command pool/buffer, reads the selected queue
family's timestamp-valid width, and converts ticks using the device's
`timestampPeriod`. Counter wrap is handled within the usable width (capped at
63 bits because Abla's public integer is signed).
Sampling is synchronous in this first profiler slice; render-pass-integrated
query resolves will make multi-frame profiling asynchronous.

## Window and events

The first direct Wayland layer is available through `waylandConnection()`. It
connects to an inherited `WAYLAND_SOCKET`, an absolute `WAYLAND_DISPLAY`, or
`$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY` (defaulting to `wayland-0`) using an Abla
AF_UNIX syscall path. `WaylandConnection` owns the descriptor, dense client
object IDs, the singleton display/registry bootstrap, and copied
`WaylandGlobal` values. `roundtrip()` emits `wl_display.sync` and consumes
registry global/global-remove, callback, delete-id, and fatal display events;
`bind(interfaceName, maximumVersion)` clamps the requested version to the
advertised global and emits the untyped registry bind signature directly.
`read()`, `send()`, and `dispatchCore()` are the bounded base for typed object
dispatch.

The wire codec uses native-order 32-bit words, validates the two-word header,
message byte bounds/alignment, null-terminated padded strings, and complete
registry payloads. `waylandXdgWindow(title, appId, width, height)` binds
`wl_compositor` up to version six and stable `xdg_wm_base`, allocates dense IDs
for one `wl_surface`, `xdg_surface`, and `xdg_toplevel`, sends title/application ID and
the required initial bufferless commit, then waits for and acknowledges the
first configure sequence. The shell binding is deliberately capped at version
one, so dispatch strictly covers ping/pong, toplevel size/state configure,
surface serial configure/ack, and close intent. `setTitle()`, `setAppId()`, and
`commit()` remain available after construction; callers can feed subsequent
`connection.read()` values through `dispatch()`.

`WaylandXdgWindow` is affine. Its drop path destroys owned data, scale,
viewport, output, input, and shared-buffer objects before the toplevel role,
xdg surface, core surface, shell binding, and connection. Deterministic codec
tests cover strings, object-ID pairs, state arrays, and malformed inputs. Live
headless-Weston gates separately prove registry binding, the real xdg-shell
configure/ack handshake, input, clipboard, output discovery, pixel
presentation, and ordered extension ownership without linking
`libwayland-client`. Vulkan/EGL Wayland presentation is not yet provided.

`createSharedBuffer(width, height)` adds the first pure-Abla content path. It
binds `wl_shm` version one, creates and sizes a close-on-exec Linux `memfd`,
maps it read/write and shared, and transfers its descriptor with an explicitly
marshalled x86-64 `sendmsg`/`SCM_RIGHTS` control message. It then creates one
XRGB8888 `wl_buffer`, destroys the temporary pool object, and closes the local
descriptor while retaining the affine mapping. `setSharedPixel()`,
`fillSharedRect()`, and `clearSharedPixels()` write B,G,R,X bytes with checked
bounds. `presentSharedPixels()` requests a frame callback, attaches the
buffer, issues buffer-coordinate damage, and commits; `waitFrame()` continues
strict dispatch through the compositor's completion event.

`setBufferScale(scale)` and `setBufferTransform(transform)` marshal the core
version-three/version-two `wl_surface` requests and stage their state for the
next `commit()` or pixel presentation. Scale accepts the positive signed wire
range and transform the eight `wl_output.transform` values. `bufferSurfaceWidth()`
and `bufferSurfaceHeight()` apply rotation and scale to the owned buffer
dimensions; 90/270-degree and flipped 90/270-degree transforms swap axes.
Presentation rejects buffers whose dimensions are not integer multiples of
the active scale before sending an attachment that would trigger a compositor
protocol error. These values are independent from fractional preferred scale
and viewporter source/destination policy.

With a version-six compositor binding, `preferredBufferScale` and
`preferredBufferTransform` retain the latest validated per-surface preference.
Preferred integer scale emits the same copied framebuffer-resize vocabulary as
fractional scale when no fractional-scale object is active; its `platformCode`
uses the common numerator-over-120 representation. Version-six preference
events arriving on the dedicated cursor surface are validated independently
without changing application-surface state.

`setOpaqueRegion()` and `clearOpaqueRegion()` control the compositor overdraw
hint. `setInputRegion()`, `setInputRegionEmpty()`, and `resetInputRegion()`
select rectangular, click-through, or default infinite hit testing. Each
setter creates a short-lived core `wl_region`, optionally adds one validated
rectangle, assigns it with the surface's copy-semantics request, destroys it,
and commits. `opaqueRegionSet` and `inputRegionMode` retain the resulting
policy without retaining the temporary protocol object.

`createSharedBuffers(width, height, count = 3)` provides the sustained-frame
path for one, two, or three buffers. All slots occupy fixed offsets in one
mapping and one temporary pool. `acquireSharedBuffer()` performs a bounded
non-blocking round-robin scan; `waitSharedBuffer()` dispatches until a release
makes a slot writable. `currentSharedBufferIndex()`, `sharedBufferCount()`,
`sharedBufferAvailable()`, and `availableSharedBufferCount()` expose state
without transferring ownership. Writes are rejected unless a slot has been
acquired, presentation marks that slot compositor-owned, and the matching
`wl_buffer.release` event makes it reusable.

Frame submission uses reusable 64 KiB native scratch storage. The frame
callback, attach, buffer-coordinate damage, and commit requests are packed
into one 64-byte stream write. Routine delete-ID, buffer-release, surface, and
callback events are read and decoded in place; uncommon shell traffic falls
back to the complete strict codec. The 66-frame live gate rotates all three
slots and proves zero managed-live-byte growth after warm-up. The mapping and
scratch storage are released during window teardown. A separate live gate uses
Weston's Pixman renderer and captures a deterministic 1024x768 compositor PNG
in `build/tests/wayland_pixels.png` for visual inspection.

`enableInput()` binds `wl_seat` version seven, waits for its complete
capability mask, and creates `wl_pointer` and `wl_keyboard` objects only when
advertised. Capability removal sends the versioned release request and clears
focus state; later re-addition creates fresh protocol objects.
`pollInputEvent(timeoutMilliseconds = 0)` returns the same copied
`WindowEvent` values used by X11. It currently provides keyboard focus,
portable physical key press/release with the raw evdev code in `platformCode`,
pointer position, five portable buttons, and horizontal/vertical scrolling.
`seatName`, `seatCapabilities`, `pointerFocused`, `keyboardFocused`,
`pointerX`, `pointerY`, modifier masks, and repeat rate/delay retain the latest
protocol state.

Touch-capable seats also own a version-seven `wl_touch`. Portable
`windowEventTouchBegan`, `windowEventTouchMoved`, `windowEventTouchEnded`, and
`windowEventTouchCancelled` values expose integer surface coordinates and the
protocol contact ID through `touchX()`, `touchY()`, and `touchId()`. Updates are
staged until `wl_touch.frame`, so consumers never observe a half-applied
multi-contact frame. Active `WaylandTouchPoint` snapshots retain exact 24.8
coordinates, major/minor ellipse axes, and orientation; `touchPointIndex()` and
`touchPoint()` expose them without folding touch into mouse input. Capability
loss and protocol cancellation finalize all contacts and discard superseded
staged updates.

`enableCursor()` builds a 16x24 ARGB8888 arrow entirely in Abla, backs it with
a close-on-exec `memfd`, transfers the pool descriptor directly, and assigns
the resulting `wl_surface` the pointer-cursor role. `setCursorVisible(false)`
uses a null cursor surface; showing it restores the owned surface. A preference
set before pointer focus is applied on the next enter, while focused changes
use the dedicated enter serial rather than a later keyboard/button serial.
Cursor-surface output events and the cursor SHM object's format events remain
separate from application-surface monitor state. Teardown first clears the
active pointer cursor, then releases the pointer and destroys/unmaps the cursor
buffer and surface.

`pointerCaptureAvailable()` requires both version-one
`zwp_pointer_constraints_v1` and `zwp_relative_pointer_manager_v1` globals.
`setPointerCaptured(true)` creates a persistent lock for the application
surface and one relative pointer for the seat; `pointerCaptured` records the
request while `pointerCaptureActive` follows the compositor's asynchronous
locked/unlocked events. Relative 24.8 accelerated deltas accumulate into the
existing virtual `pointerX/Y` coordinates and enqueue `windowEventPointerMoved`
with `platformCode == 1`; the latest accelerated and unaccelerated fixed values
remain available independently. `setPointerPositionHint()` commits the logical
unlock position. Disabling capture destroys only the lock, retaining the
managers and relative pointer for cheap recapture; retired lock events remain
valid until the display returns their IDs.

`pointerConfinementAvailable()` requires only the version-one
`zwp_pointer_constraints_v1` global. `setPointerConfined(true)` requests a
persistent whole-surface confinement without creating a relative pointer;
`pointerConfined` records ownership of that request and
`pointerConfinementActive` follows the asynchronous confined/unconfined
events. Capture and confinement are deliberately mutually exclusive, so an
attempt to enable either while the other is requested fails without emitting
a protocol request. Releasing confinement destroys its per-surface object but
retains the shared constraints manager. Retired confinement objects remain
routable until their display delete-ID event, matching the lock lifecycle.

Keyboard keymaps are not discarded: the direct stream receiver captures
close-on-exec ancillary descriptors with Linux `recvmsg`, preserves the
descriptor across any earlier messages from the same compositor batch, maps
the version-seven keymap privately, validates its terminating NUL, copies up
to 16 MiB into `keymap`, unmaps, and closes the descriptor. `keyboardMapped()`
reports an owned XKB v1 keymap; no `libxkbcommon` code participates.

The first pure-Abla XKB parser is now part of that receipt path.
`keyboardTextMapped()` reports that the owned map's numeric keycodes and
group-one symbols were accepted into fixed 256-key lookup tables. Printable
presses enqueue `windowEventText` after their physical `windowEventKey` using
the compositor's primary/shifted symbols, live depressed/latched/locked
modifier masks, and alphabetic Shift/Caps inversion. ASCII, the complete
Latin-1 keysym name range, `Uxxxx` Unicode names, and numeric direct-Unicode
keysyms become validated UTF-8. Control/Alt/Super/level-three combinations and
nonzero groups are conservatively suppressed rather than emitting incorrect
base text. Higher groups, level-three/four selection, dead-key compose, input
methods remain explicit future work.

Wayland repeat is client-owned as required by the protocol. A bounded
`repeat_info` rate of 1 through 1,000 Hz and delay up to 600,000 ms arms one
active non-modifier key. `pollInputEvent` uses a reusable monotonic-clock block
and reduces its native poll timeout to the next repeat deadline, then emits the
same key-before-text pair with `event.keyRepeated()` true. Rate zero disables
repeat. Release, keyboard focus loss, or keyboard capability removal cancels
the deadline. A late caller emits one repeat and resynchronizes to the current
time instead of receiving an unbounded catch-up burst.

`enableOutputs()` binds every initial `wl_output` global at version two through
four and waits for each atomic `done`. `outputs` retains immutable snapshots of
signed compositor position, physical millimeters, subpixel order, transform,
current/preferred pixel mode, refresh in millihertz, integer scale, stable name,
and description. `primaryMonitor()` returns the most recently entered output,
falling back to the first valid output before the surface is mapped, while
`primaryOutputScale()` returns its integer scale. Real `wl_surface.enter` and
`leave` traffic maintains the active-output set and enqueues
`windowEventMonitorChanged`; its monitor width, height, and name are available
through typed event accessors. Version-three/four output objects are released
during ordered teardown. Once enabled, registry output additions bind fresh
version-capped objects and removals retire the matching global/object, active
surface membership, and primary selection before emitting the replacement (or
empty) monitor value. A live remove/re-add gate proves distinct object IDs and
a rebuilt 1024x768 snapshot. When `zxdg_output_manager_v1` is advertised, each
core output also owns a version-matched xdg-output object. Logical position,
logical size, fallback name, and description merge into the same immutable
snapshot and honor the extension's version-two `done` or version-three
`wl_output.done` atomic boundary. `primaryLogicalX/Y/Width/Height` expose those
coordinates without conflating them with hardware pixels. Fractional-scale
preferences are independently optional: `enableFractionalScale()` binds the
standard version-one manager when advertised and queues a framebuffer-resized
event from each preferred numerator over 120. `preferredFramebufferWidth` and
`preferredFramebufferHeight` use the protocol's half-away rounding rule.
When `wp_viewporter` is advertised, `enableViewport()` owns one standard
version-one viewport for the surface. `setViewportDestination(width, height)`
stages an independently sized logical destination, and
`setPreferredViewportDestination()` stages the current xdg-shell width and
height; the next `commit()` or `presentSharedPixels()` applies it atomically
with other surface state. `setViewportSource(x, y, width, height)` stages a
whole-pixel crop, while `setViewportSourceFixed()` exposes each exact signed
24.8 protocol value for fractional crops. `unsetViewportSource()` emits four
`-1.0` fixed values and `unsetViewportDestination()` emits the protocol's
`-1, -1` reset. The setters reject zero/negative dimensions and partial reset
tuples locally. This lets an application allocate shared buffers at
`preferredFramebufferWidth/Height`, crop them when useful, and present them at
the logical window size. Buffer replacement remains explicit and affine rather
than happening behind the caller's back.

`enableDecorations(preferredMode)` optionally binds the version-one
`zxdg_decoration_manager_v1`, creates the toplevel decoration before any
content buffer is attached, requests client- or server-side mode, and waits for
both the decoration configure and its matching new xdg-surface configure/ack.
`decorationMode` is the compositor's effective choice rather than the request;
`decorated()` is true only for server-side controls. `setDecorationMode()` is
idempotent for the current preference, while `unsetDecorationMode()` returns
policy selection to the compositor. The decoration object is destroyed before
its xdg toplevel during affine teardown.

`idleInhibitAvailable()` reports the optional version-one protocol.
`setIdleInhibited(true)` creates one inhibitor for the application surface;
repeated calls are idempotent, while `false` destroys only the inhibitor so a
later call can cheaply reuse the manager. Both objects precede the core surface
in teardown. This is the direct compositor mechanism for games, video, and
presentation applications that must suppress idle behavior.

`tearingControlAvailable()` reports the staging version-one tearing-control
global. `enableTearingControl()` owns one extension object for the application
surface with a synchronized default. `setTearingAllowed(true)` commits the
asynchronous hint for latency-sensitive rendering, while `false` commits the
vsync hint; repeated values are idempotent. The compositor may ignore either
hint according to hardware, surface state, or user policy. Disabling the
object restores vsync on the next commit and retains the manager for reuse.
Requesting synchronized behavior succeeds without the optional extension;
requesting asynchronous behavior fails cleanly when it is unavailable.

`contentTypeAvailable()` reports the staging version-one content-type global.
`enableContentType()` owns one classification object, and `setContentType()`
idempotently commits `waylandContentTypeNone`, `waylandContentTypePhoto`,
`waylandContentTypeVideo`, or `waylandContentTypeGame`.
These are compositor optimization hints rather than behavioral guarantees;
for example, video may favor timing and scaling while game may favor latency.
`disableContentType()` restores none, destroys the per-surface object, and
retains its manager. None remains a successful no-op without the extension,
while non-default classifications fail cleanly when it is absent.

`presentationTimingAvailable()` and `enablePresentationTiming()` bind stable
`wp_presentation` version two and wait for its POSIX clock identifier.
`requestPresentationFeedback()` creates one one-shot feedback object for the
next surface commit; request it immediately before `presentSharedPixels()` when
sampling a frame. Completion records presented versus discarded status,
seconds high/low, nanoseconds, predicted refresh interval, sequence high/low,
synchronized output, and the vsync/hardware-clock/hardware-completion/zero-copy
flags. Split words preserve the protocol's unsigned 64-bit values without
inventing signed Abla timestamps. Sampling is opt-in, so the ordinary packed
64-byte shared-pixel submission remains unchanged.

`enableClipboard()` binds `wl_data_device_manager` version three for the
active seat. `setClipboard(text)` requires a real pointer or keyboard serial,
advertises UTF-8 and plain-text MIME types, and retains each affine source until
the compositor cancels it. `requestClipboard()` chooses UTF-8 preferentially,
passes a close-on-exec pipe through `wl_data_offer.receive`, reads at most 1 MiB
with a bounded poll, and enqueues the same copied `windowEventClipboard` value
used by X11. Empty text remains a successful transfer. The live gate moves a
26-byte Unicode value between two independent pure-Abla clients through nested
Weston.

Direct xdg-toplevel controls expose `setFullscreen`, `setMaximized`,
`setMinimized`, `setResizable`, and `requestClose`. Fullscreen can prefer a
known bound output or let the compositor choose. Received state values are
queried with `hasToplevelState`; the live headless gate verifies the complete
fullscreen configure/ack transition and return to windowed state.

`WindowConfig` controls title, logical size, resizability, visibility, initial
cursor visibility, decorations, transparency, fullscreen/monitor selection,
DPI behavior, and graphics surface needs. `Window.pollEvents()` returns bounded
value events for close, logical/framebuffer resize, focus, key, text, pointer,
scroll, file drop, and monitor changes. Applications may poll or wait with a
timeout.

The delivered surfaced facade uses `app.pollEvent(timeoutMilliseconds)`. Real
events remain copied immutable values. The frequent no-event result is one
canonical immutable value, and X11 reuses a window-owned 8-byte native poll
descriptor, so idle `pollEvent(0)` performs no general allocation and does not
grow runtime live memory.

Key events expose stable `keyA` through `keyZ`, printable, navigation, function,
keypad, and modifier constants rather than server-specific numbers.
`event.key()` and `event.keyPressed()` are the portable path;
`event.platformCode` is retained only for diagnostics and raw platform work.
The X11 implementation obtains the active core keyboard mapping during window
creation and translates KeySyms in Abla. It does not assume the common Xorg raw
keycode layout.

Pointer events similarly expose `pointerButtonLeft/right/middle/back/forward`
and typed accessors. X11 wheel buttons 4 through 7 become signed horizontal or
vertical scroll ticks on press, and their matching releases are suppressed.
Pointer motion sign-extends the protocol's 16-bit coordinates, so motion outside
the window's top or left edge remains negative instead of wrapping.

Printable key presses enqueue a separate copied `windowEventText` after the key
event. `event.text` is UTF-8 and `event.codepoint()` exposes the decoded scalar;
Shift and Caps Lock select the server-provided primary/shifted KeySyms. The
single pending value avoids callbacks and allocation-heavy general queues while
preserving key-before-text ordering. Core Latin-1 and direct Unicode KeySyms are
supported. Compose/dead-key sequences, input methods, and additional XKB groups
are not yet claimed.

On the current X11 platform, `visible=false` creates an initially unmapped
window; `show()`, `hide()`, and `setTitle()` update both the wire-protocol state
and the Abla-owned state. `setCursorVisible(false)` creates and selects a
one-pixel transparent core-protocol cursor; showing the cursor restores the
parent cursor. Both changes synchronize with the server before updating owned
state, and cursor resources are released before the window. This composes with
the existing confined `setPointerCaptured` mode. `resize(width, height)` emits
a checked ConfigureWindow request; the copied ConfigureNotify event is the
authoritative size update. The common application synchronizes its OpenGL
viewport dimensions before returning that event. Vulkan waits for outstanding
queue work, destroys
the persistent pixel presenter before the old swapchain, updates the surface
extent, re-queries capabilities/format, and recreates both resources before
returning the event. `presentClear()` and `presentPixels()` also classify
`VK_SUBOPTIMAL_KHR` and `VK_ERROR_OUT_OF_DATE_KHR`, rebuild the swapchain once,
and perform at most one retry when the original frame was not presented. A
resized `PixelBuffer` whose extent matches the authoritative window extent
triggers recreation before acquire when the old swapchain extent is stale. If
the rebuilt extent does not match the supplied pixels, presentation returns
`false` so the application can redraw rather than stretching or reading beyond
the buffer. Fixed-size windows
publish `WM_NORMAL_HINTS`,
undecorated windows publish `_MOTIF_WM_HINTS`, and fullscreen windows publish
the EWMH fullscreen state before mapping. Each required write/atom/map is part
of creation success. Transparent X11 windows are rejected until alpha-visual
and compositor capability selection is implemented, rather than silently
creating an opaque window.

Native code never retains an Abla callback. This keeps event ownership,
serialization, and failure behavior explicit.

## Shader inputs

`$glsl` is preferred for source embedded in Abla. It validates grammar and
stage structure, retains source spans, reflects interfaces, and produces a
backend-neutral shader package. `#$glsl` additionally freezes compilation when
all inputs are static. Every embedded `ShaderStageSource` carries its canonical
Abla module identity plus exact body `begin`/`end` byte offsets; runtime-created
packages use an empty identity and `-1` offsets. Hermetic include expansion
retains the root stage span while replacing only its resolved source text.

All reflection first passes through the shared pure-Abla `glslLex` layer. Its
immutable `GlslToken` values classify identifiers, integer/floating literals,
operators, punctuation, preprocessor markers, and quoted tokens while retaining
exact half-open byte ranges plus one-based line/column origins. Whitespace and
comments are skipped without losing position, operators use longest matching,
and CRLF or backslash-newline continuations are normalized for position
tracking. Malformed numbers, invalid bytes, unterminated comments, and
unterminated quoted tokens invalidate the package before reflection; the public
package error includes the lexical line and column. This token stream is the
common foundation for replacing the remaining declaration-specific scanners
with the full grammar and deterministic SPIR-V lowering.

Embedded stages accept typed Abla constant interpolation outside comments and
quoted text. `${expression}` and `${int: expression}` require an `int` and emit
one signed decimal token; `${uint: expression}` requires an `int`, rejects
negative values, and emits one non-negative decimal token; `${bool: expression}`
requires a `bool` and emits `true` or `false`. There is deliberately no string
form, so source text cannot inject GLSL declarations or statements. The same
syntax works in `#$glsl` when its expression is compile-time evaluable. A
`${float: expression}` attempt currently reports a dedicated diagnostic because
Abla does not yet expose deterministic float formatting; it is never rendered
from raw IEEE bits.

Quoted and angle-bracket `#include` directives are source-preserved and
reflected as ordered, stage-tagged `ShaderInclude` values with their path and
system/local form and source byte range. Empty or malformed directives
invalidate runtime-created packages, while an unterminated quoted directive in
`$glsl` reports the exact
subparser failure with both its exact raw cursor location and original Abla
extension span.
`package.resolveIncludes(modules)` resolves those dependencies recursively from
an explicit array of pure-Abla `GlslModule` values. It rejects empty/duplicate
module identities, missing local or system modules, include cycles, and depths
above 64, then reparses the expanded stage sources so reflection covers the
resolved declarations. It performs no ambient file reads. Filesystem/package
search paths and include-graph cache keys are not yet implemented.

The available reflection slice recognizes explicit `layout(location = N)`
input/output declarations and `layout(set = S, binding = B)` uniform/buffer
declarations while skipping whitespace and comments deterministically.
`ShaderPackage.locations` and `.bindings` retain stage, direction/storage, and
numeric coordinates plus the declared data type, identifier, and fixed/unsized
array extent. Uniform and storage interface blocks additionally expose ordered
`ShaderBlockMember` values with each member's type, name, and array extent, plus
the block instance name and array extent. Precision and memory qualifiers are
accepted on members. Comma-separated member declarations expand into ordered
reflection entries with independent array extents; duplicate and empty
declarators are rejected. A leading member `layout(...)` additionally retains
explicit `offset`, power-of-two `align`, and mutually exclusive `row_major` or
`column_major` metadata. Major-order metadata may cover several declarators,
while explicit `offset` or `align` on a multi-declarator statement is rejected
until computed host-layout validation can assign unambiguous values. Empty,
malformed, duplicate-name, duplicate-layout-key, and conflicting-major member
declarations are rejected.
Top-level named `struct` definitions produce ordered, stage-tagged
`ShaderStructure` values in `ShaderPackage.structures`. Members retain the same
type, name, and fixed-array metadata as block members and may refer to a
previously declared structure. Forward/self references, duplicate structure
names, unsized members, and layout-qualified structure members are rejected. An
inline comma-separated instance list is retained as ordered
`ShaderStructureInstance` values, including each fixed-array extent. Later
top-level declarations such as
`Payload first, second[3];` extend the same list, while a function returning
`Payload` is not misclassified as an instance. Duplicate stage-global, empty,
and trailing-comma instances fail. Initializers are not reflected yet.
Interface blocks continue to permit at most one instance. When a named
structure is used by an explicit input or output, `ShaderLocation.slots`
recursively sums
nested members, arrays, matrices, and wide double vectors. Collision detection
uses that complete range. Cross-stage linking compares the full nested
definition even when both stages use the same outer type name. Reflected
interface-block locations likewise retain their ordered members and computed
slot count.
`layout(push_constant)` uniform blocks are reflected separately as
stage-tagged `ShaderPushConstant` values. One block is accepted per stage;
incompatible member structures across stages, descriptor coordinates on a push
constant, and arrayed block instances are rejected.
`package.pushConstantLayout()` converts the shared reflected block into one
backend-neutral byte contract. It exposes the combined stage mask, total byte
size, and each member's offset, size, base alignment, array stride, matrix
stride, and matrix order. The initial executable layout slice follows Vulkan's
standard push-constant layout for scalar, vector, matrix, and fixed-array
members, honors explicit `offset` and increased `align`, rejects overlaps and
misalignment, and defaults to the Vulkan-required portable floor of 128 bytes.
Opaque and user-defined structure members remain rejected by layout conversion
until recursive structure layout is implemented; reflection itself continues
to preserve them.

`shader.pushConstants()` allocates that exact reflected size once and returns
affine `GraphicsPushConstants`. Name-based `writeMember()` requires an exact
member-sized `BufferBytes`. Typed `storeMemberF32`, `storeMemberI32`,
`storeMemberU32`, and `storeMemberBool` methods resolve a reflected name plus
optional vector component and fixed-array index without allocation. They accept
only the matching scalar/vector family, apply the reflected array stride, and
reject missing names, wrong types, invalid components, array overflow, and
integer range overflow without modifying memory. `storeMemberF64` provides the
same contract for `double` and `dvec*`. `storeMemberMatrixF32` and
`storeMemberMatrixF64` accept explicit column and row coordinates plus an
optional array index; they apply the reflected column/row-major matrix stride
and scalar width, so callers never calculate native layout offsets.
`writeBytes()` and
`storeU32()`/`storeF32()` remain available as checked offset-based hot paths.
`GraphicsSubpassPushConstants` exposes the same typed member methods with a
leading subpass index. Member offsets and sizes remain queryable. The reusable
native byte block feeds OpenGL uniform-buffer uploads and Vulkan command
recording directly, so name-based updates do not allocate per frame.

Scalar
`layout(constant_id = N) const` declarations produce stage-tagged
`ShaderSpecializationConstant` values containing the ID, type, name, and exact
default literal. The initial typed literal grammar covers `bool`, `int`,
`uint`, `float`, and `double`; duplicate IDs in one stage and type-incompatible
literals are rejected. Duplicate recognized keys inside one layout qualifier
are also errors. Duplicate input/output location ranges in one stage invalidate
the package. Standalone scalar/vector, matrix, and fixed-array declarators
reserve the GLSL-defined number of consecutive locations, so overlaps are
detected even when their base locations differ. A top-level declaration may
contain multiple comma-separated names with independent array extents. Every
name inherits the declaration's layout: this therefore reports overlapping
explicit locations, while same-typed opaque-uniform names may intentionally
alias one descriptor slot. Duplicate names, empty names, trailing commas, and
incompatible descriptor aliases are rejected.
Bindings shared across stages must agree on storage, data type, array extent,
and complete ordered member structure, including referenced named structures.
Each explicit
input in an adjacent raster stage must have a preceding output at the same
location and with the same type. Interpolation and precision qualifiers are
skipped without losing the declaration type. Other unknown layout keys remain
source-preserved and are not misclassified. For compute packages,
`layout(local_size_x/y/z)` produces one checked
`ShaderWorkgroup`; omitted Y/Z dimensions default to one. Vulkan-style
`local_size_x/y/z_id` keys additionally retain a specialization ID per axis,
with a default dimension of one. Concrete sizes and their independently
declared IDs merge across compatible layout statements, matching Vulkan GLSL;
at least one concrete dimension must be declared. Repeated concrete sizes/IDs
must agree, dimension IDs must be distinct, and they cannot collide with an
explicit specialization constant in the same stage. Composite specialization
constants, computed host-layout validation, and filesystem module discovery
are still forthcoming.

`spirvModule(words)` copies and structurally validates precompiled SPIR-V:
magic/version/bound/schema fields, unsigned 32-bit word domains, and every
instruction word-count boundary are checked before a driver call.
`VulkanDevice.shaderModule(module)` packs those words little-endian in Abla,
creates a real `VkShaderModule`, and destroys it affinely. This is the raw input
path for external/generated toolchains and the destination for the forthcoming
complete `$glsl` translator; structural validation does not claim full SPIR-V
semantic validation.

The executable translator is available as `package.spirv(stage)`. Its compute
path accepts exactly one compute stage with one `#version 450` or `460`
directive, an optional same-line `core` profile, and an explicit local-size
layout. Other profiles or a profile token moved onto a later line are rejected.
The
first form has an empty `main`; fixed dimensions emit SPIR-V 1.0 `LocalSize`,
while specialized axes emit SPIR-V 1.2 `LocalSizeId` backed by decorated
unsigned specialization constants and the reflected concrete defaults. An
empty fixed-workgroup shader may also declare any number of reflected scalar
`bool`, `int`, `uint`, `float`, or `double` specialization constants. Their
finite decimal defaults are converted to deterministic SPIR-V words in Abla,
decorated with their reflected IDs, and emitted deterministically;
out-of-range defaults fail emission. The portable 32-bit scalar subset creates
and dispatches real pipelines through both OpenGL and Vulkan. Vulkan
additionally accepts packed
64-bit double overrides, while OpenGL's specialization ABI deliberately
rejects them. Scalar constants and specialized workgroup axes may coexist in
one package; the emitter assigns disjoint SPIR-V IDs and preserves every
reflected `SpecId` on both backend forms. The
second grammar is the token-driven binding-zero homogeneous scalar storage
program documented below: one to 64 members, integer/Boolean decision
expressions, scalar specialization, compound assignment, cross-member reads,
typed scalar locals, and up to 64 ordered statements. Signed operations are
selected from the reflected member type, and every specialization ID is routed
through the real typed load/operation/store chain.
Repeated translation produces identical words and
all results create real Vulkan shader modules; the specialized form also
creates and dispatches a validation-clean Vulkan 1.4 compute pipeline with its
defaults. Any other
unsupported binding, global, statement, version, or stage returns a checked
`GlslSpirvResult` failure; nothing unsupported is silently dropped. These
narrow subsets establish the pure-Abla emitter and execution path, not
completion of general GLSL-to-SPIR-V compilation.

The initial raster translator recognizes strict procedural and vertex-buffer
triangle packages under either `#version 450` or `460`, with the same optional
same-line `core` profile. Its structural matcher
consumes the same lexer tokens as compute emission, so comments and token
boundaries are handled consistently rather than by raw substring matching.
Equivalent 450/460 compute-storage and raster packages emit byte-identical
SPIR-V. The procedural form declares three constant `vec2`
positions and selects one with `gl_VertexID`; the buffered forms accept either
one location-zero `vec2` position or an interleaved location-zero `vec2`
position plus a location-one `vec4` tint or `vec2` texture coordinate passed
through a location-zero varying. The texture form also accepts one binding-zero
fragment `sampler2D` and emits the corresponding sampled-image operation.
The procedural textured form emits constant position and texture-coordinate
arrays, selects both with `gl_VertexID`, and feeds the same fragment sample
operation without requiring a vertex buffer.
The procedural form may apply one vertex-visible binding-zero std140 `mat4`
uniform to the selected position. This emits a real uniform-block descriptor
access and matrix-vector multiply and is exercised by recorded binding
subpasses on both backends.
The indexed-cube form widens position to `vec3` and constructs clip-space
coordinates with a reflected std140 `mat4` transform, exercising the combined
texture/uniform binding with real depth testing across 24 face vertices and 36
indices.
The Abla emitter maps the OpenGL vertex builtin to Vulkan `VertexIndex`, emits
deterministic Vulkan 1.0 vertex and fragment modules, and rejects any
declaration, literal, builtin, or statement outside these subsets.
Repeated emission is word-identical, structural validation passes, and both
modules create real Lavapipe `VkShaderModule` objects. This is the shader
foundation for the first common graphics pipeline, not a claim that arbitrary
raster GLSL is translated.

On the raw Vulkan path, `device.computePipeline(shader)` creates an empty
`VkPipelineLayout` and a `VkComputePipeline` for entry point `main`.
`pipeline.dispatch(x, y, z)` validates positive bounded group counts, records
and binds the pipeline in a persistent command buffer, submits it, and waits for
completion. The command pool/buffer are allocated once with the pipeline and
reset for reuse. A pipeline-owned 72-byte native scratch buffer supplies the
begin, optional descriptor-set handle, and submit ABI structures, so repeated
dispatch performs no general heap allocation and retains both native handles.
Pipeline, command pool, then layout are destroyed affinely. This is a verified
execution foundation; general reusable command encoders and asynchronous
fences remain upcoming.

The first portable compute facade is `app.computePipeline(shader)`. It owns an
OpenGL compute program or a Vulkan pipeline created from the Abla-emitted
SPIR-V, reports structured creation errors, and exposes the same checked
`dispatch(x, y, z)` call on both backends. Backend choice occurs once during
creation; dispatch contains no backend probing beyond the selected affine
resource branch. Pipeline creation rejects a reflected local size exceeding any
X/Y/Z limit or the maximum total invocations. Dispatch rejects a group count
exceeding the selected device's X/Y/Z maximum. These checks return before a
driver pipeline or command call; creation uses `graphicsErrorLimitExceeded`.
OpenGL queues work without a forced full-context finish.
Repeated dispatch on both backends has a live-memory no-growth gate. Vulkan
currently waits for queue completion before resetting its persistent command
resources; asynchronous fences and frames-in-flight are required before this
becomes the high-throughput production path.
The common facade runs the shared Abla SPIR-V translator validation before
either backend is created, so OpenGL cannot accidentally accept a shader that
would fail after switching the same application to Vulkan.

`app.computeBindingPipeline(shader, move(binding))` retains an exact reflected
`GraphicsBindGroup` with the affine pipeline. Dispatch applies its precomputed
OpenGL binding arrays or one Vulkan descriptor set without constructing
descriptors in the hot path; pipeline destruction releases the bind group.
Creation rejects missing, extra, reordered, wrong-kind, wrong-range, or
wrong-backend entries before driver pipeline creation. The portable emitter
proves a strict two-storage-buffer form, a compute-visible `sampler2D` plus
storage-buffer form, and write-only/read-write RGBA8 `image2D` forms. The
sampled form reads a fixed coordinate; the image forms lower exact
`imageStore` or `imageLoad` plus `imageStore` to
deterministic pure-Abla SPIR-V. OpenGL and Vulkan both reach exact
repeated results with stable handles and zero warmed live-byte growth.
The deterministic layered form writes fixed coordinates in one RGBA8
`image2DArray` and one RGBA8 `image3D`; exact selected-layer/slice readback is
covered on both drivers. A second exact form writes one RGBA8 `image1D` and one
RGBA8 `imageCube`, completing live dimensional execution for fixed programs.

The generated push-expression form accepts one write-only RGBA8 image of any
supported dimension plus one reflected push block whose first member is the
matching signed coordinate (`int`, `ivec2`, or `ivec3`) and whose second member
is `vec4`. Block, instance, image, and member names are arbitrary. Emission
uses the reflected push offsets and image binding, so Vulkan receives a newly
constructed SPIR-V module while OpenGL executes the same source through its
push-block rewrite. Retained recording snapshots the complete values. General
arithmetic around those members, `imageLoad`, and image-valued locals remain
the next expression work.

Recorded compute composes the same typed planner resource table as rendering:

```abla
val resources = graphSubpassBindingResources(
    [destinationId], [move(destination)],
    [atlasId], [move(atlas)], [move(sampler)], [[0, 0]]
)
commands.recordComputeBindingResources(
    graph, move(resources), move(pipeline), 1
)
```

The one-stage map follows reflected bind-group entry order while each entry
selects its buffer or sampled-texture table by kind. Full textures, explicit
views, graph-owned transient sampled textures, imported uniform/storage
buffers, and their affine owners share record/seal/replay validation.
`recordComputeBindingResourcesPush(...)` adds the same copied push snapshot.

Storage images use a sampler-free retained table:

```abla
val resources = graphSubpassStorageTextureResources(
    [outputId], [move(output)],
    [graphicsStorageTextureWriteOnly], [[0]]
)
commands.recordComputeBindingResources(
    graph, move(resources), move(pipeline), 1
)
```

The graph pass must declare compatible read/write access for the entry access;
logical ID, descriptor, native image identity, access, and stage mapping join
the seal fingerprint.

`graphSubpassStorageTextureViewResources(...)` is the corresponding affine
view table. Its stage indices are ordinary zero-based view indices at the API
boundary and are encoded internally, keeping whole textures and views
unambiguous without exposing sentinel values.

The first executable push-constant slice combines the reflected value API with
storage compute. `shader.pushConstants()` creates a reusable value block,
`pipeline.dispatchPush(values, x, y, z)` requires its complete layout and stage
mask to match the pipeline, and plain `dispatch()` is rejected for a pipeline
that requires values. Vulkan places the reflected range in
`VkPipelineLayout` and records `vkCmdPushConstants` before dispatch. OpenGL
rewrites only the `push_constant` layout token to a reserved binding-15 std140
uniform block, owns one persistent UBO, and uploads the same Abla byte block
before dispatch. Binding 15 collisions and layouts whose std430 array or matrix
strides differ from std140 are rejected. The initial pure-Abla SPIR-V lowering
accepts the documented binding-zero `uint value` plus compute-visible
`uint addend` block and `value = value + addend` program. Integration tests run
that exact program on both real drivers, reject wrong stages and byte sizes,
verify repeated value updates, and assert zero steady-state allocation growth.
The first raster push-constant slice accepts the strict fragment form
`layout(push_constant) uniform Draw { vec4 tint; } draw` with
`color = draw.tint`. `renderPushToTarget(target, pipeline, values, clear)` and
`presentPushRender(pipeline, values, clear)` require the complete reflected
layout and stage mask to match. Their plain `renderToTarget` and
`presentRender` counterparts reject a pipeline that requires values. Vulkan
places the same range in the graphics pipeline layout and records
`vkCmdPushConstants` after binding the pipeline; OpenGL uses one persistent
binding-15 UBO owned by the linked program. Both command forms accept changing
values without allocation, and Vulkan swapchain recreation preserves the
reflected range. Integration tests prove the exact center pixel on both real
drivers and reject missing, wrong-stage, and wrong-size value blocks.

The strict vertex transform subset accepts
`layout(push_constant) uniform Transform { vec4 offset; } transform` and adds
`transform.offset.xy` to the procedural triangle position. It uses the same
`renderPushToTarget` and `presentPushRender` calls with a vertex-only reflected
stage mask. The `push-transform` sample alternates the triangle between its
centered and shifted-off-center positions, verifies both exact target pixels,
rejects missing values, and proves stable native handles with zero steady-state
allocation growth on OpenGL and Vulkan.

The strict combined-stage subset declares the same
`Draw { vec4 offset; vec4 tint; }` block in vertex and fragment stages. Its
reflected 32-byte layout has `offset` at byte 0, `tint` at byte 16, and the
combined vertex/fragment stage mask. The vertex stage adds `draw.offset.xy` to
the procedural position while the fragment stage returns `draw.tint`.
`push-draw` proves that one reusable value block independently changes geometry
and color, with exact pixels, missing-value rejection, stable handles, and zero
steady-state allocation growth on both backends.

Typed fragment expressions are no longer limited to fixed word templates. The
typed raster parser accepts up to eight reflected non-array `vec2`, `vec3`, or
`vec4` inputs in source order before one to eight reflected non-array `vec2`,
`vec3`, or `vec4` outputs, an optional
reflected block of up to eight non-array `float`, `vec2`, `vec3`, or `vec4`
members,
scalar/`vec4` literals, width-exact or scalar-splat `vec2`/`vec3`/`vec4`
constructors,
parentheses, single-component vector selectors `.x`/`.y`/`.z`/`.w` and their
`rgba`/`stpq` aliases, two- to four-component swizzles such as `.yx`, `.bgr`,
and `.bgra`, and
supported scalar or equal-width vector `*`, `/`, `+`, and `-` with GLSL
precedence. A selector may follow an input, push member, local, literal, or
parenthesized expression.
Single components emit width-checked scalar `OpCompositeExtract`; two- to
four-component selectors from one naming family emit a width-matched
`OpVectorShuffle`. Every selected component must exist in the source width;
repetition is supported.
`dot(left, right)` accepts two supported equal-width vector expressions, emits
core SPIR-V `OpDot`, and returns a scalar usable by constructors, locals, or
later mixed vector/scalar operations. Calls nest within the same
expression-depth bound; wrong arity or scalar operands reject.
`min(left, right)`, `max(left, right)`, and `clamp(value, low, high)` accept
homogeneous scalar or equal-width vector expressions and retain that type.
`min` and `max` also accept vector/scalar; `clamp` accepts a vector with two
scalar bounds. Each scalar argument is expanded to a width-matched runtime
splat before the homogeneous `GLSL.std.450` `FMin`, `FMax`, or `FClamp`
instruction. The import is
allocated and written only when at least one output expression uses one of
these built-ins, so every existing shader without them retains identical IDs,
words, and bounds. The inverse `float, vec4` form, partially mixed clamp bounds,
and wrong arities reject.
The same conditional import supports homogeneous scalar/vector `abs`, `floor`,
`ceil`, `sqrt`, and `inversesqrt`. Each unary call preserves its operand type,
uses the matching `GLSL.std.450` instruction, and composes with other calls
under the existing depth/token bounds. Missing or extra arguments reject.
Homogeneous scalar/vector `mix(x, y, amount)`, `step(edge, value)`, and
`smoothstep(low, high, value)` use `FMix`, `Step`, and `SmoothStep` through that
same import. Their result type matches the value operands. Vector `mix` accepts
a scalar amount, vector `step` accepts a scalar edge, and vector `smoothstep`
accepts two scalar edges; the emitter splats those scalar operands before the
homogeneous extended instruction. Scalar values with vector parameters,
partially mixed smoothstep edges, and wrong arities reject.
The table also covers homogeneous scalar/vector `round`, `roundEven`, `trunc`,
`sign`, `fract`, `radians`, `degrees`, `sin`, `cos`, `tan`, `asin`, `acos`,
unary `atan`, `sinh`, `cosh`, `tanh`, `asinh`, `acosh`, `atanh`, `exp`, `log`,
`exp2`, and `log2`, plus homogeneous binary `pow` and ternary `fma`. Each maps
to its exact `GLSL.std.450` instruction and shares the same arity/type checks.
The overloaded `atan(y, x)` form resolves from its top-level argument separator
without mistaking commas inside nested calls. Homogeneous scalar or equal-width
vector operands emit `Atan2` instruction 25, while the unary form retains
`Atan` instruction 18 and identical module output. Mixed operand types and a
third argument reject.
Vector geometry calls use their GLSL result rules rather than that homogeneous
rule: `length(vector)` and equal-width `distance` return `float`; `normalize`,
equal-width `faceforward` and `reflect`, and equal-width vector/vector/scalar
`refract` return the input vector width. `cross(vec3, vec3)` returns `vec3` and
rejects every other width. They map to `Length`, `Distance`, `Cross`,
`Normalize`, `FaceForward`, `Reflect`, and `Refract` instructions 66 through
72. Scalar operands where vectors are required, mixed widths, a vector
refraction ratio, and wrong arities reject.
Fragment-only `dFdx(value)`, `dFdy(value)`, and `fwidth(value)` preserve a
supported scalar or vector operand type and emit core SPIR-V `OpDPdx`, `OpDPdy`,
and `OpFwidth` opcodes 207 through 209. They compose with push members, inputs,
locals, arithmetic, and constructors under the same expression bounds; missing
or extra arguments reject. The `dFdxFine`/`dFdyFine`/`fwidthFine` and
`dFdxCoarse`/`dFdyCoarse`/`fwidthCoarse` variants emit opcodes 210 through 215
and conditionally add `DerivativeControl`; shaders using only ordinary
derivatives retain their prior capability list and module bytes.
Constructor arguments may be arbitrary supported scalar expressions. A single
runtime scalar emits one width-matched `OpCompositeConstruct` with its result
reused in every lane; explicit constructors require exactly two, three, or four
scalars in source order. Constant-only signed `vec4` constructors continue to
fold into the existing interned `OpConstantComposite` path, so their established
module bytes and sizes do not change. Other arities and vector-valued arguments
reject.
Prefix `+` is an identity and prefix `-` emits typed scalar or vector
`OpFNegate`; unary nesting is included in the same 64-level/token bounds.
Inputs and the push block may both be absent for a constant-only expression; a
push block reflected only in another stage does not become a fragment interface
requirement.
Before the ordered output writes, a body may declare up to eight ordered
`float`, `vec2`, `vec3`, or `vec4` locals, optionally qualified with `const`,
across at most 32 declaration and reassignment statements. Each initializer may use earlier
locals, inputs, push members, literals, and the same typed operators. A later
`name = expression` rebinds a mutable local; every assignment to a `const`
local is rejected. A declaration may contain comma-separated same-type
declarators; they are initialized and exposed from left to right, share the
declaration's optional `const`, count as one statement, and still count
individually toward the eight-local cap. Mutable locals also accept `+=`, `-=`,
`*=`, and `/=` under the same scalar/vector rules as the corresponding binary
operation. A compound assignment combines the current SSA expression with its
right operand and
rebinds the result; it does not emit a load, store, or function variable. The
standalone prefix/postfix forms `++name`, `name++`, `--name`, and `name--` also
rebind a mutable scalar or vector local by adding or subtracting typed one.
Because the statement result is unused, prefix and postfix forms have the same
zero-storage lowering. The parser checks every initializer and reassignment
against the declared type, rejects forward or undeclared references,
duplicates, interface/push-instance name collisions, unsupported compound
operators, malformed updates, and type-changing results, then expands the
current local tokens into later expressions. This produces the same SPIR-V
bytes as writing the expression inline.
Equal-type operations emit floating scalar or vector instructions; vector by
scalar multiplication in either operand order emits `OpVectorTimesScalar` with
normalized SPIR-V operand order. Vector/scalar division constructs a
width-matched runtime scalar splat and emits vector
`OpFDiv`, preserving division semantics without a reciprocal-multiply rewrite;
scalar/vector division is rejected. Equal-width vector and vector/scalar
`mod` forms emit core `OpFMod` instruction 141; the vector/scalar form
constructs the required runtime divisor splat. Scalar/vector `mod`, wrong
arities, and floating `%`/`%=` reject, matching GLSL's separate integer
operator and floating built-in rules. The parser produces bounded postfix IR
and emits a mixed-type push structure, reflected member offsets,
scalar/vector pointer types, entry-point interfaces, input locations/variables,
constants, loads, composites, typed operations, and one store per output
deterministically.
Output declarations and assignments use the same reflected source order, so
missing, duplicated, or reordered writes reject rather than being silently
reassociated. Each final expression must exactly match its output width.
Width-specific Output pointer and variable types support mixed narrow MRT
modules. The `narrow-input` native proof confirms that a `vec3` output writes
RGB and leaves alpha zero in an RGBA8 attachment on both backends.
Unknown or array members, mismatched addition/subtraction such as `vec4 +
float`, scalar final outputs, extra statements/declarations, malformed
expressions, and unsupported operators fail before pipeline creation. Existing
push-color and combined-stage fragment shaders use this generated path; their
former fixed SPIR-V tables were removed. The existing interpolated-color
fragment also uses this path, and its former fixed input-copy table was removed.
The basic solid-color fragment likewise accepts arbitrary four-component
or scalar-splat `vec4` literals through generated constants instead of its
former fixed table. Equal component bit patterns share one `OpConstant` across
all four composite lanes, so the one-argument and equivalent explicit forms
produce byte-identical modules.
The two-output MRT fragment now shares this emitter rather than its former fixed
95-word table. Independent add/subtract expressions prove that each output has
its own typed stack, while the multisampled MRT sample proves exact red/green
resolved pixels on both drivers.
Float constants are interned by exact 32-bit representation across every output
expression, vector lane, and scalar literal in the module. Signed zero and other
distinct bit patterns remain distinct. The red/green MRT module consequently
uses only its `0.0` and `1.0` constants and shrinks from 117 to 93 words without
changing either output.
`push-expression` loads a reflected scalar gain and the `.w` component of a
reflected vector, permutes another reflected vector from `.bgra` into logical
RGBA through a scalar-factor vector `mix`, applies postfix `--` to a
comma-declared mutable divisor, and increments its
sibling unit scalar after projecting the reflected vector onto a normalized
alpha axis with `dot`, applying `sqrt(abs(...))`, and clamping that projection
to `[0, 1]`,
then shapes it with `smoothstep` and selects the unit scale through nested
`step`/`mix`, multiplied by a
`cos(atan(0, 1)) + fwidthFine(vec2(0)).x` phase. It constructs a runtime
scalar-splat `vec4` denominator, executes vector division after vector negation
into a mutable vector, applies vector/scalar `mod`, clamps it with scalar
bounds, then rebinds it with `+=` and the second vector. Its reflected alpha
component also passes through scalar `mod`. It
proves its 48-byte mixed layout plus exact red/green output, stable handles, and
zero steady-state allocation growth on both real backends.

`narrow-input` uses the existing interleaved `vec2` vertex-output form and the
typed raster emitter for its matching `vec2` fragment input. The fragment
performs a `.yx` shuffle and extracts both checked components into a `vec3`
color. Exact RGB-red/zero-alpha offscreen pixels (`255` packed),
presented rendering, stable native pipeline handles, four repeated frames, and
zero live-byte growth pass on both backends. Deterministic module tests also
cover `vec3` and mixed `vec2`/`vec3` fragment inputs with distinct pointer types.

The push-aware buffered family mirrors the ordinary direct and GPU-indirect
surface exactly:
`renderPushVerticesToTarget`, `renderPushIndexedToTarget`,
`renderPushVerticesIndirectToTarget`,
`renderPushIndexedIndirectToTarget`, `presentPushRenderVertices`,
`presentPushRenderIndexed`, `presentPushRenderVerticesIndirect`, and
`presentPushRenderIndexedIndirect`. These methods retain the same checked
vertex/index/indirect usage, byte-size, count, ownership, target, depth, and
swapchain-recovery rules while additionally requiring an exact reflected value
layout. OpenGL reuses the program-owned UBO for every draw form; Vulkan records
the range before direct or indirect drawing. Their generation-checked pool
counterparts are `renderPushBufferPool*ToTarget` and
`presentPushRenderBufferPool*`. The `push-color` sample uses a layout-equivalent
16-byte block containing a `vec3` tint at byte 0 and scalar alpha at byte 12,
plus one device-local draw pool at offsets 16/48/64/80. It executes all eight
buffered forms plus both procedural forms for changing values across four
allocation-free frames on each backend.

Reusable attachment-operation passes have the matching
`renderPushPassToTarget`, `renderPushPassVerticesToTarget`,
`renderPushPassIndexedToTarget`,
`renderPushPassVerticesIndirectToTarget`, and
`renderPushPassIndexedIndirectToTarget` methods. The existing target/pass,
subpass index, clear-value storage, clear mask, discard-before mask,
discard-after mask, and Vulkan-compatible-render-pass checks remain unchanged;
the reflected value layout is an additional mandatory condition. The sample
uses the matching `renderPushPassBufferPool*ToTarget` helpers for every buffered
form and exercises clear/store, load/store, and discard/discard operations
before a stored exact-pixel pass, then repeats all five command forms
allocation-free.

For a prepared procedural subpass sequence,
`sequence.pushConstants()` creates one affine contiguous value block with the
reflected layout, byte offset, size, and stage mask of every pipeline.
`writeSubpass(index, values)` copies an exactly matching reusable value block;
the checked `storeF32` and `storeU32` methods update a subpass slice directly.
`renderPushSubpassesToTarget(target, sequence, constants, pass)` validates every
layout in order. OpenGL uploads each slice through its pipeline-owned persistent
UBO, while Vulkan records `vkCmdPushConstants` after each native subpass
pipeline bind. The ordinary `renderSubpassesToTarget` form rejects any sequence
whose pipelines require push values. The `push-color` sample proves two native
subpasses, missing-value rejection, exact output, stable handles, and zero
steady-state allocation growth on both backends.

The overload
`app.computePipeline(shader, ShaderSpecialization(values))` applies immutable,
typed specialization values. Constructors are
`shaderSpecializationBool`, `shaderSpecializationInt`,
`shaderSpecializationUint`, `shaderSpecializationFloat`, and
`shaderSpecializationDouble`. IDs, duplicate entries, scalar widths, numeric
ranges, and reflected GLSL types are checked before any driver call. Specialized
workgroup dimensions are substituted into the same per-axis and total-invocation
limit checks, including rejection of zero. Vulkan packs the accepted values into
one bounded `VkSpecializationInfo` allocation. OpenGL loads a deterministic
SPIR-V 1.0 module and supplies parallel ID/value arrays to
`glSpecializeShader`; the Vulkan module remains SPIR-V 1.2 with `LocalSizeId`.
The current executable subset applies unsigned 32-bit workgroup dimension IDs.
General reflected scalar constants await the corresponding general SPIR-V
emitter, and OpenGL's specialization API cannot directly consume a 64-bit
value. The integration suite creates and dispatches the same specialized
compute package on both real backends.

`app.computeStoragePipeline(shader, buffer)` is the first observable binding
slice. The shader must reflect exactly one `layout(std430, binding = 0)` buffer
at set zero and match the documented scalar-block write subset. Block, instance,
and target-member identifiers are parsed from the declaration and assignment;
there are no required names. The block accepts one to 64 homogeneous scalar
`int` or `uint` members. The emitter creates the variable-length SPIR-V struct,
assigns consecutive four-byte `std430` offsets, and indexes the LHS member in
the access chain. Every other referenced member receives its own deterministic
index constant and access chain while unreferenced members add no instructions.
Mixed signedness, arrays, qualified members, or an unknown target/read remain
explicit subset failures.
OpenGL binds the existing buffer object as SSBO binding zero and issues a shader
storage barrier. Vulkan owns a descriptor-set layout, pool, set, and storage
buffer update alongside the pipeline, then binds that set before dispatch.
The assignment expression writes the selected member and may read any
homogeneous member of the same block. It accepts typed integer literals,
one matching integer specialization constant, Boolean literals or one Boolean
specialization constant in condition expressions, nested parentheses, and
left-associative `+`, `-`, `*`, `/`, `%`, `<<`, `>>`, relational/equality,
bitwise, and `&&`/`^^`/`||` operators. A Boolean condition may feed the
right-associative integer `condition ? whenTrue : whenFalse` form. Integer
expressions also accept type-matched scalar `min(x, y)`, `max(x, y)`, and
`clamp(x, minimum, maximum)`. The emitter imports `GLSL.std.450` once and selects
its exact signed or unsigned extended instruction for the homogeneous block.
Integer targets also accept `+=`, `-=`, `*=`, `/=`, `%=`, `<<=`, `>>=`, `&=`,
`^=`, and `|=`; each lowers to the byte-identical load/binary/store program
produced by its expanded assignment.
`main` may contain up to 64 ordered scalar declarations and assignments to
members of that block. A declaration has the form `uint name = expression`,
`int name = expression`, or `bool name = expression`, optionally preceded by
`const`; integer locals must match the homogeneous block signedness. Locals are
declaration-before-use, uniquely named values. A later `name = expression`
rebinds a mutable local, while every mutation of a const local is rejected, and
integer locals accept the same ten compound-assignment operators as block
members. Standalone prefix or postfix integer updates such as `++name`,
`name--`, or `block.member++` lower to the corresponding add/subtract-by-one
token chain. One declaration may contain comma-separated same-type declarators;
each requires an initializer, becomes visible to declarators on its right, and
counts toward the 64-local bound. Local token stores capture or replace the
current result ID and subsequent reads reuse it directly, so they emit no
SPIR-V function variable, load, or store. This avoids local-memory traffic while
preserving snapshot semantics for previously evaluated expressions and member
reads.
Each buffer assignment emits its store before the next statement's loads, so
direct member reads still observe earlier writes. The flattened program is
capped below 8,192 tokens and must contain at least one buffer store; empty
bodies, foreign instances, undeclared local assignment, and other statements
remain explicit failures in this executable subset.
Brace-delimited `if (condition) { ... }`, `else if (condition) { ... }`, and
`else { ... }` statements may be chained and nested to 64 levels. Conditions
must be Boolean; branch arms may read existing locals and perform the supported
buffer-member assignments and updates. The emitter lowers each branch to
deterministic structured SPIR-V with `OpSelectionMerge`,
`OpBranchConditional`, and explicit then, optional else, and merge labels. An
`else if` chain becomes nested selections in the preceding else arm, preserving
structured control flow without a special backend path. A mutable local
declared before a selection may be rebound or updated in its arms. The emitter
snapshots its incoming SSA result, resets that result before an else arm, tracks
the actual predecessor after nested control flow, and emits a typed `OpPhi`
immediately after the merge label whenever the incoming IDs differ. This keeps
integer and Boolean locals in SSA form without function variables or local
loads/stores. Declaring a new local inside a branch remains rejected so lexical
scope cannot escape accidentally; const-local mutation and type changes remain
checked errors.
Brace-delimited `while (condition) { ... }` loops use the same Boolean
conditions and buffer-member statements and may be nested with selections or
other loops within the shared 64-level bound. Condition tokens are emitted in
the loop header so member loads are recomputed on every iteration. The SPIR-V
form uses `OpLoopMerge` with explicit header, body, continue, and merge labels;
the continue block branches back to the header. A predeclared mutable local may
be updated in the body. Before emitting a loop, the bounded token program is
scanned for local stores; only affected locals receive typed header `OpPhi`
values. Their entry predecessor/value is emitted immediately, their forward
back-edge value is patched when the body closes, and the header result remains
the local value after the loop. Unmodified locals receive no phi. Declarations
inside a loop remain rejected so no scope escapes.

`break;` and `continue;` target the nearest enclosing loop, including from
nested selection arms. The emitter tracks whether each selection arm reaches
its merge, records the SSA values and predecessor block for every early edge,
and emits variable-width typed phis only when those incoming values differ.
Continue-edge values merge in the loop's continue block before the single
header back edge; break-edge values merge with the condition-false value in the
loop merge block. This preserves zero-storage locals for multiple early edges
and nested loops. A statement directly following an unconditional jump in the
same block is a checked subset failure. `for`, `do`/`while`, `switch`, and
`return expression;` remain explicit grammar failures rather than being ignored
or miscompiled.

Because compute `main` returns `void`, `return;` is also supported at function
or nested control depth. It emits `OpReturn` immediately and marks that arm
terminated. When every arm of a selection returns or jumps away, the structural
merge label is retained and sealed with `OpUnreachable`; no synthetic final
return is appended after a terminated outer block. Return expressions and
statements directly following an unconditional return remain checked failures.
The strict compute declaration grammar and deterministic postfix/SSA lowering
consume the shared `GlslToken` stream end to end. Version, layout, specialization,
block/member, entry-point, assignment, and expression tokens are advanced by
immutable parse results carrying their next index, which fits Abla's ownership
model without a mutable borrowed cursor. Comments and whitespace cannot change
the parse, and longest-match operator tokens keep assignment operators from
being mistaken for bitwise operations. A compute-storage grammar failure is
reported through `GlslSpirvResult.error` at the offending token's original
one-based line and column. Typed literals, loads, operations, built-in calls,
selects, and stores retain that span in the postfix IR, so semantic type
failures report their responsible source token through the same result.
Precedence follows GLSL from
multiplicative through conditional selection. Signed right shift emits
arithmetic shift while unsigned right shift emits logical shift. Unary `+`,
signed symbolic `-`, integer `~`, and Boolean `!` bind at the primary-expression
level; negative numeric literals preserve their direct constant representation,
while unsigned symbolic negation and side-effecting `++`/`--` inside an
expression are rejected. The parser emits a
bounded postfix program of fewer than 128 tokens. The Abla emitter tracks integer
and Boolean stack types, emits `OpTypeBool`, typed comparison/logical SSA values,
and `OpSelect`, and requires the final stored value to remain an integer.
Boolean literals use `OpConstantTrue`/`OpConstantFalse`; Boolean specialization
defaults use their `OpSpecConstantTrue`/`OpSpecConstantFalse` forms and the same
typed common override API as other reflected constants.
Integer logical operands, Boolean select branches, a non-Boolean condition, raw
Boolean assignment, mismatched or missing local initializers, duplicate or
forward local references, const-local mutation, wrong built-in arity/types, and
other function-call expressions are explicit subset failures.
Both paths execute the same parsed chain and common checked readback observes
the result, including specialization overrides. Repeated storage dispatch also
reuses the Vulkan descriptor handle and pipeline-owned ABI scratch without
live-memory growth. The pipeline must drop before its borrowed storage buffer;
additional bindings, general block layouts, dynamic offsets, and descriptor
reuse are still upcoming.

Dynamic source through a common `ShaderSource` and common pipeline creation are
still target APIs. They will validate that the selected backend can consume the
provided representation.

## Raw access

The common API does not conceal capabilities it cannot model faithfully.
Applications can import `graphics/raw/opengl` or `graphics/raw/vulkan`, query a
native handle explicitly, and issue generated raw commands. Crossing this
boundary disables common-layer state assumptions for the affected object until
the documented synchronization/import operation is performed.

The repository now has stable `src/raw/opengl.ab` and `src/raw/vulkan.ab`
facades backed by deterministic generated registry modules. The delivered raw
slice exposes pinned revisions/hashes and complete command, form, feature,
extension, and audit-status metadata, plus all 6,271 selected OpenGL registry
constants as directly usable Abla values. Its full modules compile in the
offline registry gate. Vulkan constants, ABI layouts, native handles, and
callable generated commands remain future raw-generator stages, so metadata or
constant presence is not represented as executable specification coverage.

Raw APIs remain typed and capability checked where the specification permits;
they are called raw because they expose backend contracts, not because they are
unvalidated casts.
