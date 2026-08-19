#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"
runtime_directory=$(mktemp -d)
weston_pid=''

cleanup() {
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
    --socket=wayland-abla-test \
    --idle-time=0 \
    --log="$output_directory/weston.log" &
weston_pid=$!

for _ in $(seq 1 100); do
    if [[ -S "$runtime_directory/wayland-abla-test" ]]; then
        break
    fi
    if ! kill -0 "$weston_pid" 2>/dev/null; then
        printf '%s\n' 'Weston exited before creating its socket' >&2
        sed -n '1,200p' "$output_directory/weston.log" >&2
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
    sed -n '1,200p' "$output_directory/weston.log" >&2
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
    sed -n '1,200p' "$output_directory/weston.log" >&2
    exit 1
fi
