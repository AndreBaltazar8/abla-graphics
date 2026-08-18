# Khronos registry baseline

`manifest.toml` pins the exact upstream Vulkan and OpenGL XML inputs and their
SHA-256 digests. `coverage/` is generated from those inputs by the pure-Abla
program in `tools/registry-generator`; generated files are never edited by
hand.

Each inventory row starts as `unclassified`. A command or extension may move
to `common`, `raw`, `unsupported`, or `platform-inapplicable` only when its
loader and ABI path have been audited and the required positive and negative
tests exist. The presence of a name in a generated ledger is not a support
claim.

Run `make test-registry` for the offline parser and determinism tests. Run
`make update-registry` to download the pinned upstream files, verify their
digests, and regenerate the committed ledgers.
