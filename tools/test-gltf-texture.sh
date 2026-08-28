#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_GLTF_TEXTURE_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build "$project_root/tests/gltf_texture.ab" \
    -o "$output_directory/gltf-texture" --no-cache

set +e
env -u LD_LIBRARY_PATH "$output_directory/gltf-texture"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'glTF texture test returned %s, expected 42\n' "$status" >&2
    exit 1
fi
