# Specification baseline

The framework initially targets:

- OpenGL 4.6 core profile;
- OpenGL Shading Language 4.60; and
- Vulkan 1.4 core plus discoverable registered extensions.

The Vulkan generator consumes the canonical `vk.xml` registry. The OpenGL
generator consumes the canonical OpenGL registry. Exact upstream commits and
content hashes live in `registry/manifest.toml`; updating them is a normal
reviewed change with regenerated coverage reports and conformance tests. The
[importer contract](registry-importer.md) defines deterministic generation and
the fail-closed boundary between the delivered inventory stage and future ABI
binding generation.

Specification breadth is split intentionally:

- the portable API covers concepts with sound OpenGL and Vulkan implementations;
- backend modules expose ergonomic backend-only features; and
- generated raw modules aim to classify the entire pinned registry.

“Supported” means there is a callable loader/ABI path, capability negotiation,
at least one positive test, and an unsupported-path test. Merely defining a
constant does not count.

The first implemented portable negotiation slice covers compute, storage
buffers, sampled textures, depth textures, comparison samplers, and compatible
view-format reinterpretation, plus queried sampler anisotropy. It reports API
version plus 2D texture, storage buffer, per-axis compute group/local-size,
total invocation, and sampler anisotropy limits from the active OpenGL context
or selected Vulkan physical device/queue family. The common resource and
compute paths enforce these delivered limits before driver work. Broader
extension and feature-structure negotiation is still classified as future
work. The backend-specific Vulkan surface additionally discovers
`VK_EXT_debug_utils`; its optional debug module owns the messenger, including
the process-resolved Abla callback, atomic message accounting, and a tested
explicitly disabled path.
