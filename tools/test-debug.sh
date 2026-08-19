#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_DEBUG_TEST_MEMORY_MB:-4096} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/tests/debug" \
    -o "$output_directory/debug" --no-cache

set +e
LIBGL_ALWAYS_SOFTWARE=1 "$output_directory/debug"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Abla common debug test returned %s, expected 42\n' "$status" >&2
    exit 1
fi
