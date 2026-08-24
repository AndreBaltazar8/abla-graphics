#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_TEXTURE_CONTRACT_TEST_MEMORY_MB:-6144} \
    "$compiler" build "$project_root/tests/texture_contract.ab" \
    -o "$output_directory/texture-contract" --no-cache
set +e
"$output_directory/texture-contract"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'texture contract test returned %s, expected 42\n' "$status" >&2
    exit 1
fi
