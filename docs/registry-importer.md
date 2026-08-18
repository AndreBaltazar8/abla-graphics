# Khronos registry importer

The registry pipeline has two deliberately separate stages.

The current inventory stage is implemented by
`tools/registry-generator/main.ab`. It reads the complete pinned XML file,
collects command definitions, selects core features and extensions for the
requested API, follows their filtered `<require>` blocks, merges duplicate API
variants, follows selected internal Vulkan base/compute/graphics feature
requirements without exposing those implementation groups as public core
versions, and emits a byte-sorted coverage ledger. OpenGL compatibility-only
requirements and Vulkan SC-only requirements are excluded from the target
inventories. Missing sections, unterminated selected elements, missing command
definitions, and malformed selected requirements are hard errors.

The audit join is also implemented. `registry/audit/*.tsv` contains only
reviewed classifications and four independent evidence fields. Unlisted rows
remain `unclassified`; duplicate classifications, names absent from the
selected registry, unknown kinds/statuses, empty evidence, and Markdown control
characters are hard errors. Offline fixtures exercise all four statuses and
each rejection class. This stage does not generate ABI declarations.

The inventory parser recognizes only the XML structures needed for this stage;
other registry structures are not interpreted or presented as generated ABI
coverage. The later binding stage must use an explicit tag/attribute allowlist
for every structure it consumes. A newly encountered tag in a consumed context
must stop generation with its location rather than being silently omitted.

The binding stage will generate, in dependency order:

1. scalar aliases, handles, enums, bitmasks, and constants;
2. structures and unions with target ABI layout assertions;
3. command signatures and per-instance/per-device loading metadata;
4. feature and extension negotiation metadata.

Generated declarations will feed the existing audit join rather than infer
support from the presence of a registry token.

Generated files carry the upstream revision and content hash. Generation uses
byte-order sorting and no wall-clock timestamp. `make test-registry` checks the
pure-Abla parser against a fixture twice and compares the exact expected bytes.
`make update-registry` reads `registry/manifest.toml`, downloads only the pinned
raw files, verifies both SHA-256 values before generation, and replaces the
committed inventories. Running the update twice must leave the tree unchanged.

Updating a registry is a reviewed source change: change the revision and hash,
regenerate, inspect inventory additions/removals, extend the parser for any
newly consumed schema only with tests, and never carry forward a support status
without its evidence still passing.
