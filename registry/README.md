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
digests, join the reviewed audits, and regenerate the committed ledgers. Never
edit a file in `coverage/` directly.
