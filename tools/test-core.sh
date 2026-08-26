#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
# This broad descriptor/utility source crosses the generic compiler
# address-space guard. Keep the larger limit isolated to this gate.
ABLA_MAX_MEMORY_MB=${ABLA_CORE_TEST_MEMORY_MB:-8192} \
    "$compiler" build "$project_root/tests/core.ab" \
    -o "$output_directory/core" --no-cache
set +e
"$output_directory/core"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'core test returned %s, expected 42\n' "$status" >&2
    exit 1
fi
