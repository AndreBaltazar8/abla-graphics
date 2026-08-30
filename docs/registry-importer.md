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
each rejection class.

The generated coverage ledger groups every normalized command signature into
an exact raw-call ABI family. For each family it reports the total registry
commands, common/raw rows with paired positive and unsupported-path evidence,
rejection-only unsupported/platform rows, and commands that remain
unclassified. A family is marked `paired` when at least one reviewed executable
command exercises that layout; this is a prioritization signal, not a claim
that every command in the family is supported. The current pinned ledgers show
49 of 284 OpenGL families and 54 of 122 Vulkan families with paired executable
evidence.

The same inventory and audit join now generate importable Abla modules behind
`src/raw/opengl_dispatch.ab` and `src/raw/vulkan.ab`. They contain the pinned
revision/hash and complete byte-sorted arrays for command names/forms/statuses,
public core features/statuses, and extensions/statuses. Normal applications do
not import or initialize these inspection arrays. The offline fixture compares
their exact bytes across two runs, and the full pinned modules are compiler-
checked together. The OpenGL side also emits exact signed-decimal/hexadecimal
constant declarations. Vulkan generation emits constants, complete aggregate
metadata, exact callable-command ABI families, a complete opt-in structure
schema, and a compact manifest-selected production-driver schema.
API-qualified desktop definitions override GLES-only collisions; unknown
literal forms and conflicting equal-priority definitions are hard errors.

For every distinct normalized OpenGL ABI, generation also emits one exact
intrinsic declaration, one `RawNativeCommand` shape predicate, and one
owner/current-context checked `RawOpenGlApi.callExact...` method. The intrinsic
name uses `ablac`'s closed exact-signature grammar, so adding a representable
Khronos layout is a deterministic registry output change rather than a new
compiler allowlist entry. The offline fixture compares this dispatch output
across two independent runs.

The inventory parser recognizes only the XML structures needed for this stage;
other registry structures are not interpreted or presented as generated ABI
coverage. The later binding stage must use an explicit tag/attribute allowlist
for every structure it consumes. A newly encountered tag in a consumed context
must stop generation with its location rather than being silently omitted.

The binding stage generates and validates, in dependency order:

1. scalar aliases, handles, enums, bitmasks, and constants;
2. structures and unions with target ABI layout assertions;
3. command signatures and per-instance/per-device loading metadata;
4. feature and extension negotiation metadata;
5. hosted aggregate layouts, bitfields, and `structextends` relationships;
6. a reviewed production subset for driver structure packing.

Generated declarations will feed the existing audit join rather than infer
support from the presence of a registry token.

`registry/driver-vulkan-structures.txt` is the production subset boundary. A
missing, duplicate, or ABI-unresolved requested type fails generation. The
full raw schema remains separate so normal applications compile only the small
driver subset they actually need.

The production output includes both compact inspection records and direct
numeric size, structure-type, and member-offset constants. Setup code may use
checked name-based lookup; warmed submission and transfer builders use the
numeric constants so registry-driven packing introduces no runtime parsing or
allocation.

Generated ledger and Abla files carry the upstream revision and content hash. Generation uses
byte-order sorting and no wall-clock timestamp. `make test-registry` checks the
pure-Abla parser against a fixture twice and compares the exact expected bytes.
`make update-registry` reads `registry/manifest.toml`, downloads only the pinned
raw files, verifies both SHA-256 values before generation, and replaces the
committed inventories. Running the update twice must leave the tree unchanged.

Updating a registry is a reviewed source change: change the revision and hash,
regenerate, inspect inventory additions/removals, extend the parser for any
newly consumed schema only with tests, and never carry forward a support status
without its evidence still passing.

`tools/update-registry.sh` and the registry/raw/linkage gates use `../ablac` by
default. Set `ABLA_COMPILER_ROOT` to an isolated compiler checkout, or
`ABLA_COMPILER` to a specific launcher inside that checkout, when validating a
compiler-dependent ABI slice without replacing another active build.
