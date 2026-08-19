#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"
runtime_directory=$(mktemp -d)
weston_pid=''
pixels_pid=''

cleanup() {
    if [[ -n $pixels_pid ]]; then
        kill "$pixels_pid" 2>/dev/null || true
        wait "$pixels_pid" 2>/dev/null || true
    fi
    if [[ -n $weston_pid ]]; then
        kill "$weston_pid" 2>/dev/null || true
        wait "$weston_pid" 2>/dev/null || true
    fi
    rm -rf -- "$runtime_directory"
}
trap cleanup EXIT

mkdir -p "$output_directory"
chmod 700 "$runtime_directory"

cd "$compiler_root"
"$compiler" build "$project_root/tests/wayland_protocol.ab" \
    -o "$output_directory/wayland_protocol" --no-cache
"$compiler" build "$project_root/tests/wayland_live.ab" \
    -o "$output_directory/wayland_live" --no-cache
"$compiler" build "$project_root/tests/wayland_window.ab" \
    -o "$output_directory/wayland_window" --no-cache
"$compiler" build "$project_root/tests/wayland_pixels.ab" \
    -o "$output_directory/wayland_pixels" --no-cache
"$compiler" build "$project_root/tests/wayland_animation.ab" \
    -o "$output_directory/wayland_animation" --no-cache

set +e
"$output_directory/wayland_protocol"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Wayland protocol test returned %s, expected 42\n' "$status" >&2
    exit 1
fi

XDG_RUNTIME_DIR="$runtime_directory" weston \
    --backend=headless-backend.so \
    --renderer=pixman \
    --width=1024 \
    --height=768 \
    --debug \
    --socket=wayland-abla-test \
    --idle-time=0 \
    --log="$runtime_directory/weston.log" &
weston_pid=$!

for _ in $(seq 1 100); do
    if [[ -S "$runtime_directory/wayland-abla-test" ]]; then
        break
    fi
    if ! kill -0 "$weston_pid" 2>/dev/null; then
        printf '%s\n' 'Weston exited before creating its socket' >&2
        sed -n '1,200p' "$runtime_directory/weston.log" >&2
        exit 1
    fi
    sleep 0.05
done

if [[ ! -S "$runtime_directory/wayland-abla-test" ]]; then
    printf '%s\n' 'Weston socket was not created' >&2
    exit 1
fi

set +e
XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-test \
    "$output_directory/wayland_live"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Wayland live test returned %s, expected 42\n' "$status" >&2
    sed -n '1,200p' "$runtime_directory/weston.log" >&2
    exit 1
fi

set +e
XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-test \
    timeout 10s "$output_directory/wayland_window"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Wayland window test returned %s, expected 42\n' "$status" >&2
    sed -n '1,200p' "$runtime_directory/weston.log" >&2
    exit 1
fi

XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-test \
    timeout 10s "$output_directory/wayland_pixels" &
pixels_pid=$!
sleep 0.4
find "$output_directory" -maxdepth 1 -type f \
    -name 'wayland-screenshot-*.png' -delete
set +e
(
    cd "$output_directory"
    XDG_RUNTIME_DIR="$runtime_directory" \
    WAYLAND_DISPLAY=wayland-abla-test \
        weston-screenshooter
)
screenshot_status=$?
wait "$pixels_pid"
status=$?
pixels_pid=''
set -e
screenshot_file=$(find "$output_directory" -maxdepth 1 -type f \
    -name 'wayland-screenshot-*.png' -print -quit)
if [[ -n $screenshot_file ]]; then
    mv -- "$screenshot_file" "$output_directory/wayland_pixels.png"
fi
if [[ $status -ne 42 || $screenshot_status -ne 0 ||
      ! -s "$output_directory/wayland_pixels.png" ]]; then
    printf 'Wayland pixel/screenshot test returned %s/%s, expected 42/0\n' \
        "$status" "$screenshot_status" >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi

set +e
XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-test \
    timeout 10s "$output_directory/wayland_animation"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Wayland animation test returned %s, expected 42\n' \
        "$status" >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi
