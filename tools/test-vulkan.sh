#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"

cd "$compiler_root"
ABLA_SYSROOT="$compiler_root" "$compiler" \
    build "$project_root/tests/vulkan/main.ab" \
    -o "$output_directory/vulkan" --no-cache

set +e
"$output_directory/vulkan"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Abla Vulkan test returned %s, expected 42\n' "$status" >&2
    exit 1
fi
