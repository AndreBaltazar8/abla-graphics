#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_WIDER_SAMPLING_TEST_MEMORY_MB:-6144} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/examples/wider-sampling" \
    -o "$output_directory/wider-sampling" --no-cache

for backend in opengl vulkan auto; do
    xvfb-run -a -s "-screen 0 800x600x24" \
        "$output_directory/wider-sampling" "$backend"
done
