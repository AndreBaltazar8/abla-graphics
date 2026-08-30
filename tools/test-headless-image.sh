#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/headless-image"
executable="$output_directory/headless-image"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_HEADLESS_IMAGE_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/examples/headless-image" \
    -o "$executable" --fast --no-cache

missing=$(env -u LD_LIBRARY_PATH ldd "$executable" | sed -n '/not found/p')
if [[ -n $missing ]]; then
    printf '%s has unresolved shared libraries:\n%s\n' \
        "$executable" "$missing" >&2
    exit 1
fi

opengl_image="$output_directory/opengl.ppm"
opengl_output="$output_directory/opengl.out"
LIBGL_ALWAYS_SOFTWARE=1 env -u DISPLAY -u WAYLAND_DISPLAY \
    -u XDG_RUNTIME_DIR -u LD_LIBRARY_PATH \
    "$executable" opengl "$opengl_image" >"$opengl_output"
cat "$opengl_output"
rg -q 'Headless image opengl: .* exact=true display=false$' "$opengl_output"

vulkan_image="$output_directory/vulkan.ppm"
vulkan_output="$output_directory/vulkan.out"
validation_log="$output_directory/vulkan.validation.log"
: >"$validation_log"
VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
    env -u DISPLAY -u WAYLAND_DISPLAY -u XDG_RUNTIME_DIR -u LD_LIBRARY_PATH \
    "$executable" vulkan "$vulkan_image" \
    >"$vulkan_output" 2>"$validation_log"
cat "$vulkan_output"
rg -q 'Headless image vulkan: .* exact=true display=false$' "$vulkan_output"
if rg -q 'Validation Error|VUID-|ERROR' \
    "$vulkan_output" "$validation_log"; then
    cat "$validation_log" >&2
    exit 1
fi

cmp "$opengl_image" "$vulkan_image"
test "$(sha256sum "$opengl_image" | cut -d' ' -f1)" = \
    409d6b25e43d58aca1f5cadbb1ab3b417fc7a1ceea47ea3d16f92ab7c35b9c04
