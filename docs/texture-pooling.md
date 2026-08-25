# Portable texture reuse

Texture reuse must describe an application-visible guarantee that both OpenGL
and Vulkan can honor. It must not expose Vulkan heap offsets as though OpenGL
immutable texture storage had the same allocation model.

## Decision

The common layer uses a bounded, homogeneous, fixed-slot texture pool. Pool
construction eagerly creates every `GraphicsTexture` from one exact
`TextureDescriptor`. `acquire()` and `release()` only update fixed integer
metadata and return generation-checked lease tokens. The pool retains affine
ownership of all textures for its entire lifetime.

This means:

- OpenGL reuses complete immutable texture objects and their readback scratch;
- Vulkan reuses complete images, bound device memory, transfer state, and
  layout tracking;
- a warmed acquire/release cycle performs no driver allocation and no managed
  allocation;
- capacity is deterministic and exhaustion returns the invalid token `0`;
- a released token becomes stale even when its slot is immediately reused;
- all slots have exactly the same extent, dimension, format, mip count, sample
  count, and usage flags.

Leases are scoped to the pool that issued them; compact integer tokens are not
global identifiers. Fixed homogeneous slots cannot externally fragment: a
request either obtains one whole compatible slot or observes exact capacity
exhaustion.

The descriptor label is diagnostic and does not alter compatibility. A pool
does not accept an alternate descriptor at acquisition time, so compatibility
cannot silently widen.

## Why leases do not own textures

`GraphicsTexture` is affine. Abla can move a statically known array slot and
restore it, but deliberately cannot prove restoration of a dynamically indexed
slot. Moving textures out of a runtime-selected pool slot would therefore
either make the pool partially initialized or require weakening ownership.

Instead, a lease is an integer token containing a slot and generation. Pool
operations validate that token before borrowing the retained texture. Initial
public operations cover synchronous byte upload/readback, asynchronous byte
upload/readback, sampled binding entries, and texture-to-texture copies. They
are sufficient to upload pooled data, sample it in a real draw, and prove exact
readback without exposing a native handle as ownership.

The retained `textures` array is a borrowed low-level escape hatch, like a
buffer pool's `backing` resource. It does not transfer ownership, but bypassing
the generation-checked helpers also bypasses their logical stale-lease check.

A `GraphicsBindingEntry` created from a lease is a snapshot of native handles,
as existing binding entries are. Applications must retain the lease until all
bind groups made from that entry have been dropped. Releasing the lease does
not destroy the native object, so an accidental stale entry cannot become a
use-after-free, but using its newly repurposed contents would be a logical
lifetime error. Pool-aware draw encoders can carry and revalidate lease tokens
when that higher-level command layer is added.

## Render graph integration

`GraphicsMaterializedRenderGraph` now owns one capacity-one homogeneous pool
and one retained lease for each allocation slot produced by the pure planner.
It maps compatible non-overlapping logical textures to that stable object and
rechecks the complete descriptor before accepting the planner's opaque
compatibility class. Imported textures stay caller-owned. Pass-order and
generation tokens guard upload, readback, copying, and sampled entries by
logical resource ID. See `docs/render-graph-textures.md` for the full contract
and evidence.

This still does not claim Vulkan heap suballocation. It can be added later as a
backend-private implementation under the same common ownership contract. It
must classify Vulkan memory requirements, honor alignment and memory-type bits,
bind only compatible images, and defer storage reuse until GPU completion.
OpenGL will continue to reuse whole texture objects.

## Required evidence

The pool gate must exercise every backend selection and prove:

- invalid capacity and texture descriptors are rejected;
- exact capacity exhaustion and deterministic first-free reuse;
- generation changes and stale/double-release rejection;
- byte-exact upload and readback through a lease;
- an exact sampled draw produced from a pooled texture;
- asynchronous upload/readback through a lease;
- stable OpenGL/Vulkan native handles across repeated reuse;
- zero `runtimeMemoryLiveBytes()` growth over a warmed acquire/release loop;
- Vulkan validation remains silent.

The repository also carries an independently buildable sample that uses only
the public pool surface.
