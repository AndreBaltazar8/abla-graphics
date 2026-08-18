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
exact Abla values and a sorted name inventory. Explicit desktop definitions
win over GLES-only collisions. Unknown expressions and same-priority conflicts
stop generation. The modules are compiled by `make test-registry` through the
stable `src/raw/opengl.ab`
and `src/raw/vulkan.ab` facades. Never edit generated coverage or source files
directly.
