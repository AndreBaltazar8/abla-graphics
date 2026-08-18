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
buffer, and acquire/render semaphores are created once with the application and
reused after each completed submission. `GraphicsConfig.framesInFlight` selects
one through eight independently fenced Vulkan pixel-upload slots (two by
default), and the same count is preserved when a stale swapchain is rebuilt.
Pixel coordinate `(0, 0)` is the top-left; the OpenGL presenter flips the
texture coordinate once in its full-screen shader.

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
    usage = bufferUsageStorage | bufferUsageCopyDestination
))
storage.writeI64(42)
```

`GraphicsBuffer` is affine, dispatches outside the read/write hot operation,
and owns either an OpenGL buffer object or a Vulkan buffer/allocation. Creation
maps portable usage flags to Vulkan usage bits and returns a structured error
for invalid descriptors or driver failure. Bounds checks use subtraction rather
than overflow-prone `offset + length`. A storage buffer larger than
`maximumStorageBufferBytes` returns `graphicsErrorLimitExceeded` before a
driver allocation. The current slice uses host-visible
storage and exposes checked 64-bit read/write probes; mapped ranges, queued
uploads, device-local selection, and general byte ranges remain upcoming APIs.
An application must let child buffers drop before its device/context.

Textures and views use the same backend-neutral ownership rule:

```abla
val color = app.texture(TextureDescriptor(
    size = Extent3D(1024, 1024),
    mipLevels = 11,
    format = textureFormatRgba8UnormSrgb,
    usage = textureUsageSampled | textureUsageCopyDestination
))
val fullView = color.view()
```

`GraphicsTexture` owns an allocated OpenGL 2D texture or Vulkan image plus
bound device memory. `GraphicsTextureView` is a non-owning full-resource alias
on the current OpenGL path and an owning `VkImageView` on Vulkan. Both paths
support single-sample 2D color and depth formats, complete mip allocation, and
validated color/depth/stencil aspect ranges. Vulkan compatible linear/sRGB
reinterpretation uses mutable-format images. OpenGL subresource and
format-reinterpreted views return `graphicsErrorUnsupportedFeature` until
texture-view support is negotiated. Width or height above
`maximumTextureDimension2D` returns `graphicsErrorLimitExceeded` before image
creation. Multisample/1D/3D creation,
data uploads, copies, layout transitions, and render-pass attachment use are
not yet part of this common slice. Views must drop before their parent texture,
and textures must drop before the application device/context.

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
`graphicsFeatureSamplerAnisotropy`. Creation fails with
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

## Window and events

`WindowConfig` controls title, logical size, resizability, visibility, initial
cursor visibility, decorations, transparency, fullscreen/monitor selection,
DPI behavior, and graphics surface needs. `Window.pollEvents()` returns bounded
value events for close, logical/framebuffer resize, focus, key, text, pointer,
scroll, file drop, and monitor changes. Applications may poll or wait with a
timeout.

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
all inputs are static.

The available reflection slice recognizes explicit `layout(location = N)`
input/output declarations and `layout(set = S, binding = B)` uniform/buffer
declarations while skipping whitespace and comments deterministically.
`ShaderPackage.locations` and `.bindings` retain stage, direction/storage, and
numeric coordinates plus the declared data type, identifier, and fixed/unsized
array extent. Duplicate
input/output locations or descriptor slots in one stage invalidate the package.
Bindings shared across stages must agree on storage and data type. Each explicit
input in an adjacent raster stage must have a preceding output at the same
location and with the same type. Interpolation and precision qualifiers are
skipped without losing the declaration type. Other unknown layout keys remain
source-preserved and are not misclassified. For compute packages,
`layout(local_size_x/y/z)` produces one checked
`ShaderWorkgroup`; omitted Y/Z dimensions default to one. Block members, push
constants, and general workgroup specialization reflection are still
forthcoming.

`spirvModule(words)` copies and structurally validates precompiled SPIR-V:
magic/version/bound/schema fields, unsigned 32-bit word domains, and every
instruction word-count boundary are checked before a driver call.
`VulkanDevice.shaderModule(module)` packs those words little-endian in Abla,
creates a real `VkShaderModule`, and destroys it affinely. This is the raw input
path for external/generated toolchains and the destination for the forthcoming
complete `$glsl` translator; structural validation does not claim full SPIR-V
semantic validation.

The executable translator is available as
`package.spirv(shaderStageCompute)`. It accepts exactly one compute stage with
one `#version 450` or `460` directive and an explicit local-size layout. The
first form has an empty `main`; the second grammar declares one binding-zero
`Values` storage block and either stores a parsed unsigned integer literal or
adds/multiplies the existing member value by a parsed unsigned literal. They
emit deterministic SPIR-V 1.0 modules using reflected workgroup/binding data;
the arithmetic forms emit real load/operation/store chains. Repeated
translation produces
identical words and both results create real Vulkan shader modules. Any other
binding, global, statement, version, or stage returns a checked
`GlslSpirvResult` failure; nothing unsupported is silently dropped. These
narrow subsets establish the pure-Abla emitter and execution path, not
completion of general GLSL-to-SPIR-V compilation.

On the raw Vulkan path, `device.computePipeline(shader)` creates an empty
`VkPipelineLayout` and a `VkComputePipeline` for entry point `main`.
`pipeline.dispatch(x, y, z)` validates positive bounded group counts, records
and binds the pipeline in a persistent command buffer, submits it, and waits for
completion. The command pool/buffer are allocated once with the pipeline and
reset for reuse; repeated dispatch retains both native handles. Pipeline,
command pool, then layout are destroyed affinely. This is a verified execution
foundation; descriptor-set layouts, general reusable command encoders, and
asynchronous fences remain upcoming.

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
Vulkan currently waits for queue completion before resetting its persistent
command resources; asynchronous fences and frames-in-flight are required before
this becomes the high-throughput production path.
The common facade runs the shared Abla SPIR-V translator validation before
either backend is created, so OpenGL cannot accidentally accept a shader that
would fail after switching the same application to Vulkan.

`app.computeStoragePipeline(shader, buffer)` is the first observable binding
slice. The shader must reflect exactly one `layout(std430, binding = 0)` buffer
at set zero and match the documented `Values { uint value; }` write subset.
OpenGL binds the existing buffer object as SSBO binding zero and issues a shader
storage barrier. Vulkan owns a descriptor-set layout, pool, set, and storage
buffer update alongside the pipeline, then binds that set before dispatch.
Both paths execute the parsed assignment and common checked readback observes
the result. The pipeline
must drop before its borrowed storage buffer; additional bindings, general
block layouts, dynamic offsets, and descriptor reuse are still upcoming.

Dynamic source through a common `ShaderSource` and common pipeline creation are
still target APIs. They will validate that the selected backend can consume the
provided representation.

## Raw access

The common API does not conceal capabilities it cannot model faithfully.
Applications can import `graphics/raw/opengl` or `graphics/raw/vulkan`, query a
native handle explicitly, and issue generated raw commands. Crossing this
boundary disables common-layer state assumptions for the affected object until
the documented synchronization/import operation is performed.

Raw APIs remain typed and capability checked where the specification permits;
they are called raw because they expose backend contracts, not because they are
unvalidated casts.
