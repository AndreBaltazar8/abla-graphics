#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
candidate="$project_root/build/toolchain/ablac-native-libs"
output_directory="$project_root/build/samples"

mkdir -p "$output_directory"
"$project_root/tools/ensure-toolchain.sh"

for sample in x11-window vulkan-info headless-opengl opengl-window; do
    cd "$compiler_root"
    ABLA_SYSROOT="$compiler_root" "$candidate" \
        build "$project_root/examples/$sample/main.ab" \
        -o "$output_directory/$sample" --no-cache
done

xvfb-run -a -s "-screen 0 1024x768x24" \
    "$output_directory/x11-window"
"$output_directory/vulkan-info"
LIBGL_ALWAYS_SOFTWARE=1 "$output_directory/headless-opengl"
LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s "-screen 0 1024x768x24" \
    "$output_directory/opengl-window"
