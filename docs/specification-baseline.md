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
