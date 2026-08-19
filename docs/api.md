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

`sampledTextureEntry`, `uniformBufferEntry`, and `storageBufferEntry` may be
combined in one group with unique bindings from 0 through 31. Groups currently
accept up to 16 entries in descriptor set zero and one resource per entry.
Visibility can combine `shaderVisibilityVertex`, `shaderVisibilityFragment`,
and `shaderVisibilityCompute`. Pipeline creation structurally matches every
reflected shader binding before driver work, rejecting missing, extra,
wrong-stage, wrong-kind, nonzero-set, or array bindings.

OpenGL maps sampled entries to the matching texture/sampler unit and buffer
entries to the matching UBO or SSBO slot, reapplying the group before each draw.
Vulkan creates one compatible set layout, aggregated descriptor pool, descriptor
set, and a full image view for each sampled entry; every draw records
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
Updating a uniform with reused `BufferBytes` and `writeAllBytes` uses direct
whole-buffer backend paths, avoiding a temporary copy descriptor per call.

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
ranges. OpenGL binds copy-read/copy-write targets and calls
`glCopyBufferSubData`. Vulkan owns one transfer command pool, command buffer,
and scratch ABI block with the device, resets and reuses them, emits
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

Persistent mapped-at-creation ranges, queued transfers, and device-local
selection remain upcoming APIs.
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

`GraphicsTexture` owns an allocated OpenGL 2D texture or Vulkan image plus
bound device memory. `GraphicsTextureView` is a non-owning full-resource alias
on the current OpenGL path and an owning `VkImageView` on Vulkan. Both paths
support single-sample 2D color and depth formats, complete mip allocation, and
validated color/depth/stencil aspect ranges. They also create 2x, 4x, 8x, and
16x multisampled 2D color/depth textures when usage is exactly
`textureUsageRenderAttachment`; sampled/copy usage remains rejected, so an
application resolves into a separate single-sample resource, either owned by
the target or supplied explicitly. Vulkan compatible linear/sRGB
reinterpretation uses mutable-format images. OpenGL subresource and
format-reinterpreted views return `graphicsErrorUnsupportedFeature` until
texture-view support is negotiated. Width or height above
`maximumTextureDimension2D` returns `graphicsErrorLimitExceeded` before image
creation.

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
1D/3D copies, format-converting copies, general byte layouts, and asynchronous
upload queues are not yet part of this common slice. Views must
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
to match.

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
exercises all four buffered command forms against a 4x color/depth target,
automatically resolves its owned output, then samples it, with exact center-pixel
verification, stable native handles, and zero live-byte growth. The same
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
`graphicsFeatureComparisonSamplers`, and
`graphicsFeatureViewFormatReinterpretation`, and
`graphicsFeatureSamplerAnisotropy`, and `graphicsFeatureTimestampQueries`.
Creation fails with
`graphicsErrorUnsupportedFeature` when an installed requested backend cannot
provide every required bit. Automatic selection may skip such a backend and
select the next capable one.

After successful creation, `app.capabilities` reports the selected driver's
feature mask, `GraphicsVersion`, maximum 2D texture dimension, maximum storage
buffer byte range, maximum compute workgroups in X, maximum compute workgroup
size in X, maximum compute invocations, and maximum integer sampler anisotropy.
The corresponding Y/Z workgroup-count and local-size limits are also reported.
These values come from
`glGet*` on the current OpenGL context or `vkGetPhysicalDeviceProperties` and
the selected Vulkan queue family. The current OpenGL path deliberately does not
advertise view-format reinterpretation; Vulkan does because the implemented
mutable-format view path has positive coverage. Unknown requirement bits are
an invalid configuration.

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
records are the direct input for the forthcoming OpenGL memory-barrier and
Vulkan synchronization2 materialization layer.

Transient resources with disjoint lifetimes and the same compatibility class
share the lowest available `GraphicsGraphAllocation` slot. Slot capacity grows
to the largest aliased resource, while overlapping or incompatible lifetimes
remain separate. Imported resources receive no allocation slot. This is the
render-graph planning layer; command-encoder execution, backend barrier
materialization, and real transient resource pools are not yet claimed.

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
constant, and arrayed block instances are rejected. Scalar
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
constants, computed host-layout validation, filesystem module discovery, and
general push-constant backend wiring are still forthcoming.

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
directive and an explicit local-size layout. The
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
second grammar declares one binding-zero `Values` storage block whose member is
`int` or `uint`, and either stores a matching parsed integer literal or applies
`+`, `-`, `*`, `/`, or `%` to the existing member and that literal. Division
and remainder select signed or unsigned SPIR-V operations from the reflected
member type. It also accepts one matching reflected integer
specialization constant as the stored value or arithmetic operand, emits its
`OpSpecConstant` and `SpecId`, and routes that ID through the real
load/operation/store chain. A common storage pipeline overriding `3u` with
`5u` observably transforms `2u` into `10u` on both installed backends.
Repeated translation produces identical words and
all results create real Vulkan shader modules; the specialized form also
creates and dispatches a validation-clean Vulkan 1.4 compute pipeline with its
defaults. Any other
binding, global, statement, version, or stage returns a checked
`GlslSpirvResult` failure; nothing unsupported is silently dropped. These
narrow subsets establish the pure-Abla emitter and execution path, not
completion of general GLSL-to-SPIR-V compilation.

The initial raster translator recognizes strict procedural and vertex-buffer
triangle packages. The procedural form declares three constant `vec2`
positions and selects one with `gl_VertexID`; the buffered forms accept either
one location-zero `vec2` position or an interleaved location-zero `vec2`
position plus a location-one `vec4` tint or `vec2` texture coordinate passed
through a location-zero varying. The texture form also accepts one binding-zero
fragment `sampler2D` and emits the corresponding sampled-image operation.
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
the access chain. Mixed signedness, arrays, qualified members, or an unknown
target remain explicit subset failures.
OpenGL binds the existing buffer object as SSBO binding zero and issues a shader
storage barrier. Vulkan owns a descriptor-set layout, pool, set, and storage
buffer update alongside the pipeline, then binds that set before dispatch.
The assignment expression reads and writes that same selected storage member and
accepts typed integer literals,
one matching scalar specialization constant, nested parentheses, and
left-associative `+`, `-`, `*`, `/`, `%`, `<<`, `>>`, `&`, `^`, and `|`.
Precedence follows GLSL: multiplicative, additive, shift, bitwise AND, XOR, then
OR. Signed right shift emits arithmetic shift while unsigned right shift emits
logical shift. Unary `+`, signed symbolic `-`, and integer `~` bind at the
primary-expression level; negative numeric literals preserve their direct
constant representation, while unsigned symbolic negation and `++`/`--` are
rejected. The parser emits a bounded postfix program of fewer than 128 tokens,
and the Abla emitter deterministically assigns one SSA result per load and
unary/binary operation. Comparison, Boolean/logical, and function-call
expressions remain explicit subset failures.
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
