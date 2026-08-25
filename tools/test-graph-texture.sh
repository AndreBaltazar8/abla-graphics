#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_GRAPH_TEXTURE_TEST_MEMORY_MB:-6144} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build "$project_root/tests/graph_texture/main.ab" \
    -o "$output_directory/graph-texture" --no-cache

for backend in opengl vulkan auto; do
    set +e
    xvfb-run -a -s "-screen 0 800x600x24" \
        "$output_directory/graph-texture" "$backend"
    status=$?
    set -e
    if [[ $status -ne 42 ]]; then
        printf 'Abla %s graph-texture test returned %s, expected 42\n' \
            "$backend" "$status" >&2
        exit 1
    fi
done
