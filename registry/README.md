# Khronos registry baseline

`manifest.toml` pins the exact upstream Vulkan and OpenGL XML inputs and their
SHA-256 digests. `coverage/` is generated from those inputs by the pure-Abla
program in `tools/registry-generator`; generated files are never edited by
hand.

Each inventory row starts as `unclassified`. The reviewed tab-separated files
in `audit/` may move a command, core feature, or extension to `common`, `raw`,
`unsupported`, or `platform-inapplicable` only by supplying non-empty loader,
ABI, positive-test, and unsupported-path evidence. The generator rejects
duplicate rows, unknown registry names, invalid statuses, incomplete evidence,
and fields that could corrupt the Markdown ledger. The presence of a name in a
generated ledger is not a support claim.

Run `make test-registry` for the offline parser and determinism tests. Run
`make update-registry` to download the pinned upstream files, verify their
digests, join the reviewed audits, and regenerate both the committed ledgers
and `src/raw/*_registry.ab`. The generated Abla modules expose the exact pinned
revision/hash, counts, byte-sorted names, command forms, and joined statuses;
the OpenGL module additionally exposes all 6,271 selected `GL_*` literals as
exact Abla values and a sorted name inventory. The Vulkan module exposes 5,633
base and selected-extension `VK_*` constants, resolving integer and hexadecimal
literals, fixed all-bits masks, decimal floats, extension-name strings, bit
positions, inherited extension offsets, and aliases to exact Abla values.
Disabled-extension reservations and Vulkan SC-only definitions are excluded.
Both modules also expose aligned, byte-sorted type name, category, alias, and
declared-dependency arrays: 43 desktop OpenGL types and 2,497 selected Vulkan
types, including the Vulkan registry's internal base/compute/graphics feature
layers that compose its five public core versions.
Every selected command additionally has an aligned return type and parameter
count. Flat parameter arrays retain the owning command, parameter name, base
type, ABI pointer depth (including fixed-array decay), and constness for all
9,526 OpenGL and 2,845 Vulkan ABI parameters; command aliases inherit the
canonical signature.
Vulkan aggregate metadata covers 1,450 selected concrete structs/unions and
7,413 declaration-ordered members. It preserves base type, pointer depth,
constness, fixed-array dimensions, and bitfield width while selecting Vulkan
member variants and excluding Vulkan SC alternatives. These are layout inputs,
not unverified host offsets; emitted Abla layouts still require compiler-backed
size/alignment gates.
Explicit desktop OpenGL definitions win over GLES-only collisions. Unknown
expressions, unresolved or cyclic Vulkan aliases, missing definitions, and
conflicts stop generation. The modules are compiled by `make test-registry` through the
stable `src/raw/opengl.ab` and `src/raw/vulkan.ab` facades. Never edit generated
coverage or source files directly.

The raw metadata verification build uses Abla's semantics-equivalent `--fast`
pipeline to keep CI practical as the generated modules grow. Release-mode
whole-module LTO is also exercised whenever a new generated metadata family is
introduced; it is not required on every deterministic-regeneration check.
OpenGL and Vulkan facades compile in separate verifier executables so each
backend remains below the compiler's normal 2 GiB address-space test limit.
