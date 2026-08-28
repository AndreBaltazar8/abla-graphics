#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/raw-commands"

mkdir -p "$output_directory"
for mode in normal fast; do
    executable="$output_directory/raw-command-addresses-$mode"
    flags=()
    if [[ $mode == fast ]]; then flags+=(--fast); fi
    cd "$compiler_root"
    ABLA_MAX_MEMORY_MB=${ABLA_RAW_COMMAND_TEST_MEMORY_MB:-16384} \
        ABLA_SYSROOT="$compiler_root" "$compiler" \
        build "$project_root/examples/raw-command-addresses/main.ab" \
        -o "$executable" --no-cache "${flags[@]}"

    missing=$(env -u LD_LIBRARY_PATH ldd "$executable" | sed -n '/not found/p')
    if [[ -n $missing ]]; then
        printf '%s has unresolved shared libraries:\n%s\n' \
            "$executable" "$missing" >&2
        exit 1
    fi
    LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s "-screen 0 800x600x24" \
        "$executable" opengl
    validation_log="$output_directory/vulkan-$mode.validation.log"
    validation_output="$output_directory/vulkan-$mode.out"
    : > "$validation_log"
    VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
        xvfb-run -a -s "-screen 0 800x600x24" \
        "$executable" vulkan >"$validation_output" 2>"$validation_log"
    cat "$validation_output"
    if rg -q 'Validation Error|VUID-|ERROR' \
        "$validation_output" "$validation_log"; then
        cat "$validation_log" >&2
        exit 1
    fi
done
