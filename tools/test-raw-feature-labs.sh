#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/raw-feature-labs"

mkdir -p "$output_directory"
for sample in raw-opengl-feature-lab raw-vulkan-feature-lab; do
    cd "$compiler_root"
    ABLA_MAX_MEMORY_MB=${ABLA_RAW_FEATURE_LAB_MEMORY_MB:-16384} \
        ABLA_SYSROOT="$compiler_root" "$compiler" \
        build "$project_root/examples/$sample/main.ab" \
        -o "$output_directory/$sample" --fast --no-cache
    missing=$(env -u LD_LIBRARY_PATH ldd "$output_directory/$sample" |
        sed -n '/not found/p')
    if [[ -n $missing ]]; then
        printf '%s has unresolved shared libraries:\n%s\n' \
            "$sample" "$missing" >&2
        exit 1
    fi
done

LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s "-screen 0 800x600x24" \
    "$output_directory/raw-opengl-feature-lab"

validation_log="$output_directory/vulkan.validation.log"
validation_output="$output_directory/vulkan.out"
: > "$validation_log"
VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
    xvfb-run -a -s "-screen 0 800x600x24" \
    "$output_directory/raw-vulkan-feature-lab" \
    >"$validation_output" 2>"$validation_log"
cat "$validation_output"
if rg -q 'Validation Error|VUID-|ERROR' \
    "$validation_output" "$validation_log"; then
    cat "$validation_log" >&2
    exit 1
fi
