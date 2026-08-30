#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/compute-particles"
executable="$output_directory/compute-particles"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_COMPUTE_PARTICLES_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/examples/compute-particles" \
    -o "$executable" --fast --no-cache

missing=$(env -u LD_LIBRARY_PATH ldd "$executable" | sed -n '/not found/p')
if [[ -n $missing ]]; then
    printf '%s has unresolved shared libraries:\n%s\n' \
        "$executable" "$missing" >&2
    exit 1
fi

opengl_output="$output_directory/opengl.out"
LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s '-screen 0 800x800x24' \
    env -u LD_LIBRARY_PATH timeout 90s \
    "$executable" opengl >"$opengl_output"
cat "$opengl_output"
rg -q '^Compute particles opengl: particles=16384 frames=120 updatesPerSecond=[1-9][0-9]* exact=true stable=true live=0$' \
    "$opengl_output"

vulkan_output="$output_directory/vulkan.out"
validation_log="$output_directory/vulkan.validation.log"
: >"$validation_log"
VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
    xvfb-run -a -s '-screen 0 800x800x24' \
    env -u LD_LIBRARY_PATH timeout 90s \
    "$executable" vulkan >"$vulkan_output" 2>"$validation_log"
cat "$vulkan_output"
rg -q '^Compute particles vulkan: particles=16384 frames=120 updatesPerSecond=[1-9][0-9]* exact=true stable=true live=0$' \
    "$vulkan_output"
if rg -q 'Validation Error|VUID-|ERROR' \
    "$vulkan_output" "$validation_log"; then
    cat "$validation_log" >&2
    exit 1
fi
