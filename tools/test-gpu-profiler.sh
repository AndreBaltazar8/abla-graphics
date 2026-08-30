#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/gpu-profiler"
executable="$output_directory/gpu-profiler"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_GPU_PROFILER_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/examples/gpu-timestamp" \
    -o "$executable" --fast --no-cache

missing=$(env -u LD_LIBRARY_PATH ldd "$executable" | sed -n '/not found/p')
if [[ -n $missing ]]; then
    printf '%s has unresolved shared libraries:\n%s\n' \
        "$executable" "$missing" >&2
    exit 1
fi

opengl_output="$output_directory/opengl.out"
LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s "-screen 0 800x600x24" \
    env -u LD_LIBRARY_PATH "$executable" opengl >"$opengl_output"
cat "$opengl_output"
rg -q 'GPU profiler opengl: profiled=64 .* stable=true live=0$' \
    "$opengl_output"

vulkan_output="$output_directory/vulkan.out"
validation_log="$output_directory/vulkan.validation.log"
: >"$validation_log"
VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
    xvfb-run -a -s "-screen 0 800x600x24" \
    env -u LD_LIBRARY_PATH "$executable" vulkan \
    >"$vulkan_output" 2>"$validation_log"
cat "$vulkan_output"
rg -q 'GPU profiler vulkan: profiled=64 .* stable=true live=0$' \
    "$vulkan_output"
if rg -q 'Validation Error|VUID-|ERROR' \
    "$vulkan_output" "$validation_log"; then
    cat "$validation_log" >&2
    exit 1
fi
