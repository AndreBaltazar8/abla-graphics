#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
runtime_directory=$(mktemp -d)
weston_pid=''
client_pid=''

cleanup() {
    if [[ -n $client_pid ]]; then
        kill "$client_pid" 2>/dev/null || true
        wait "$client_pid" 2>/dev/null || true
    fi
    if [[ -n $weston_pid ]]; then
        kill "$weston_pid" 2>/dev/null || true
        wait "$weston_pid" 2>/dev/null || true
    fi
    rm -rf -- "$runtime_directory"
}
trap cleanup EXIT

chmod 700 "$runtime_directory"
XDG_RUNTIME_DIR="$runtime_directory" weston \
    --backend=x11-backend.so \
    --renderer=pixman \
    --width=800 \
    --height=600 \
    --socket=wayland-abla-input \
    --idle-time=0 \
    --log="$runtime_directory/weston.log" &
weston_pid=$!
for _ in $(seq 1 600); do
    [[ -S "$runtime_directory/wayland-abla-input" ]] && break
    kill -0 "$weston_pid" 2>/dev/null || exit 1
    sleep 0.1
done
[[ -S "$runtime_directory/wayland-abla-input" ]]

set +e
XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-input \
    timeout 10s "$project_root/build/tests/wayland_input" \
    >"$runtime_directory/client.log" 2>&1 &
client_pid=$!
set -e

window_id=''
for _ in $(seq 1 600); do
    window_id=$(sed -n \
        '/.*x11 output .* window id /{s/.* window id \([0-9][0-9]*\).*/\1/p;q;}' \
        "$runtime_directory/weston.log")
    [[ -n $window_id ]] && break
    kill -0 "$client_pid" 2>/dev/null || break
    sleep 0.1
done
if [[ -z $window_id ]]; then
    printf '%s\n' 'Unable to find nested Weston X11 window' >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi

wait_for_client_state() {
    local message=$1
    local attempt
    for attempt in $(seq 1 600); do
        if grep -Fx "$message" "$runtime_directory/client.log" >/dev/null; then
            return 0
        fi
        kill -0 "$client_pid" 2>/dev/null || break
        sleep 0.1
    done
    printf 'Wayland input client did not report %s\n' "$message" >&2
    cat "$runtime_directory/client.log" >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    return 1
}

wait_for_client_state 'wayland-input-test: surface ready'
xdotool windowfocus --sync "$window_id"
xdotool mousemove --window "$window_id" 400 360
xdotool click 1
wait_for_client_state 'wayland-input-test: keyboard ready'
xdotool key w
xdotool key W
xdotool keydown w
sleep 0.75
xdotool keyup w
xdotool mousemove --window "$window_id" 420 340
xdotool mousemove_relative -- 24 -16

set +e
wait "$client_pid"
status=$?
client_pid=''
set -e
cat "$runtime_directory/client.log"
if [[ $status -ne 42 ]]; then
    printf 'Wayland input test returned %s, expected 42\n' "$status" >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi
