#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/registry-test"
generator="$output_directory/registry-generator"

mkdir -p "$output_directory"
cd "$compiler_root"
"$compiler" build --project "$project_root/tools/registry-generator" \
    -o "$generator" --no-cache

"$generator" vulkan \
    "$project_root/registry/fixtures/registry.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/first.md" fixture-revision fixture-sha256
"$generator" vulkan \
    "$project_root/registry/fixtures/registry.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/second.md" fixture-revision fixture-sha256

cmp "$output_directory/first.md" "$output_directory/second.md"
cmp "$output_directory/first.md" \
    "$project_root/registry/fixtures/vulkan.expected.md"

if "$generator" vulkan \
    "$project_root/registry/fixtures/missing-definition.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/invalid.md" fixture-revision fixture-sha256 \
    >"$output_directory/invalid.log" 2>&1; then
    printf '%s\n' 'registry with a missing command definition unexpectedly passed' >&2
    exit 1
fi
rg -q 'required command has no definition: vkMissing' \
    "$output_directory/invalid.log"

for failure in duplicate incomplete invalid-status unknown; do
    if "$generator" vulkan \
        "$project_root/registry/fixtures/registry.xml" \
        "$project_root/registry/fixtures/audit-$failure.tsv" \
        "$output_directory/audit-$failure.md" fixture-revision fixture-sha256 \
        >"$output_directory/audit-$failure.log" 2>&1; then
        printf '%s\n' "invalid audit unexpectedly passed: $failure" >&2
        exit 1
    fi
done
rg -q 'duplicate audit row' "$output_directory/audit-duplicate.log"
rg -q 'unsafe or incomplete audit evidence' \
    "$output_directory/audit-incomplete.log"
rg -q 'unknown audit status' "$output_directory/audit-invalid-status.log"
rg -q 'audit row is absent from selected registry' \
    "$output_directory/audit-unknown.log"
