#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_GLTF_LIVE_ANIMATION_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/examples/gltf-live-animation" \
    -o "$output_directory/gltf-live-animation"

for backend in opengl vulkan; do
    xvfb-run -a -s "-screen 0 800x600x24" \
        env -u LD_LIBRARY_PATH "$output_directory/gltf-live-animation" "$backend"
done
