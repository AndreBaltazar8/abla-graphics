#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/input-inspector"
executable="$output_directory/input-inspector"

mkdir -p "$output_directory"
cd "$compiler_root"
ABLA_MAX_MEMORY_MB=${ABLA_INPUT_INSPECTOR_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/examples/input-inspector" \
    -o "$executable" --fast --no-cache

missing=$(env -u LD_LIBRARY_PATH ldd "$executable" | sed -n '/not found/p')
if [[ -n $missing ]]; then
    printf '%s has unresolved shared libraries:\n%s\n' \
        "$executable" "$missing" >&2
    exit 1
fi

run_backend() {
    local backend=$1
    local output="$output_directory/$backend.out"
    local validation="$output_directory/$backend.validation.log"
    : >"$validation"
    xvfb-run -a -s '-screen 0 1024x768x24' bash -c '
        set -euo pipefail
        executable=$1
        backend=$2
        output=$3
        validation=$4
        if [[ $backend == opengl ]]; then
            LIBGL_ALWAYS_SOFTWARE=1 env -u LD_LIBRARY_PATH \
                "$executable" "$backend" automated \
                >"$output" 2>"$validation" &
        else
            VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
                env -u LD_LIBRARY_PATH \
                "$executable" "$backend" automated \
                >"$output" 2>"$validation" &
        fi
        application_pid=$!
        window=0
        attempt=0
        while [[ $window == 0 && $attempt -lt 100 ]]; do
            window=$(xdotool search --name "^Abla Input Inspector$" \
                2>/dev/null | head -n 1 || true)
            [[ -n $window ]] || window=0
            if [[ $window == 0 ]]; then sleep 0.05; fi
            attempt=$((attempt + 1))
        done
        if [[ $window == 0 ]]; then
            kill "$application_pid" 2>/dev/null || true
            wait "$application_pid" 2>/dev/null || true
            exit 1
        fi
        xdotool windowfocus --sync "$window"
        xdotool mousemove --window "$window" 120 90
        xdotool mousedown 1 mouseup 1 click 4
        xdotool keydown a keyup a
        wait "$application_pid"
    ' _ "$executable" "$backend" "$output" "$validation"
    cat "$output"
    rg -q "^Input inspector $backend: key=true text=true pointer=true button=true scroll=true overlay=true presented=[0-9]+ monitor=1024x768$" \
        "$output"
    if rg -q 'Validation Error|VUID-|ERROR' "$output" "$validation"; then
        cat "$validation" >&2
        exit 1
    fi

    local self_test_output="$output_directory/$backend.self-test.out"
    if [[ $backend == opengl ]]; then
        LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s '-screen 0 1024x768x24' \
            env -u LD_LIBRARY_PATH "$executable" "$backend" self-test \
            >"$self_test_output"
    else
        VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation \
            xvfb-run -a -s '-screen 0 1024x768x24' \
            env -u LD_LIBRARY_PATH "$executable" "$backend" self-test \
            >"$self_test_output" 2>>"$validation"
    fi
    rg -q "^Input inspector $backend: key=true text=true pointer=true button=true scroll=true overlay=true presented=2 monitor=1024x768$" \
        "$self_test_output"
    if rg -q 'Validation Error|VUID-|ERROR' \
        "$self_test_output" "$validation"; then
        cat "$validation" >&2
        exit 1
    fi
}

run_backend opengl
run_backend vulkan
