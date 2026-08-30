#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/raw-commands"
modes=${ABLA_RAW_COMMAND_TEST_MODES:-"normal fast"}
backends=${ABLA_RAW_COMMAND_TEST_BACKENDS:-"opengl vulkan"}

run_opengl=false
run_vulkan=false
for backend in $backends; do
    case "$backend" in
        opengl) run_opengl=true ;;
        vulkan) run_vulkan=true ;;
        *)
            printf 'unsupported raw-command test backend: %s\n' "$backend" >&2
            exit 1
            ;;
    esac
done

mkdir -p "$output_directory"
for mode in $modes; do
    executable="$output_directory/raw-command-addresses-$mode"
    flags=()
    case "$mode" in
        normal) ;;
        fast) flags+=(--fast) ;;
        *)
            printf 'unsupported raw-command test mode: %s\n' "$mode" >&2
            exit 1
            ;;
    esac
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
    if $run_opengl; then
        LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s "-screen 0 800x600x24" \
            "$executable" opengl
    fi
    if $run_vulkan; then
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
    fi
done
