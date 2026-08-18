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
    "$output_directory/first.md" fixture-revision fixture-sha256
"$generator" vulkan \
    "$project_root/registry/fixtures/registry.xml" \
    "$output_directory/second.md" fixture-revision fixture-sha256

cmp "$output_directory/first.md" "$output_directory/second.md"
cmp "$output_directory/first.md" \
    "$project_root/registry/fixtures/vulkan.expected.md"

if "$generator" vulkan \
    "$project_root/registry/fixtures/missing-definition.xml" \
    "$output_directory/invalid.md" fixture-revision fixture-sha256 \
    >"$output_directory/invalid.log" 2>&1; then
    printf '%s\n' 'registry with a missing command definition unexpectedly passed' >&2
    exit 1
fi
rg -q 'required command has no definition: vkMissing' \
    "$output_directory/invalid.log"
