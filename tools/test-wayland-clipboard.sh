#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
runtime_directory=$(mktemp -d)
weston_pid=''
owner_pid=''
reader_pid=''

cleanup() {
    if [[ -n $reader_pid ]]; then
        kill "$reader_pid" 2>/dev/null || true
        wait "$reader_pid" 2>/dev/null || true
    fi
    if [[ -n $owner_pid ]]; then
        kill "$owner_pid" 2>/dev/null || true
        wait "$owner_pid" 2>/dev/null || true
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
    --socket=wayland-abla-clipboard \
    --idle-time=0 \
    --log="$runtime_directory/weston.log" &
weston_pid=$!
for _ in $(seq 1 100); do
    [[ -S "$runtime_directory/wayland-abla-clipboard" ]] && break
    kill -0 "$weston_pid" 2>/dev/null || exit 1
    sleep 0.05
done
[[ -S "$runtime_directory/wayland-abla-clipboard" ]]

XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-clipboard \
    timeout 15s "$project_root/build/tests/wayland_clipboard_owner" \
    >"$runtime_directory/owner.log" 2>&1 &
owner_pid=$!

window_id=''
for _ in $(seq 1 100); do
    window_id=$(sed -n \
        's/.*x11 output .* window id \([0-9][0-9]*\).*/\1/p' \
        "$runtime_directory/weston.log" | head -n 1)
    [[ -n $window_id ]] && break
    kill -0 "$owner_pid" 2>/dev/null || break
    sleep 0.05
done
if [[ -z $window_id ]]; then
    printf '%s\n' 'Unable to find nested Weston X11 window' >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi

sleep 0.4
xdotool windowfocus "$window_id"
xdotool mousemove --window "$window_id" 400 300
xdotool key c

for _ in $(seq 1 100); do
    grep -q 'ready=true' "$runtime_directory/owner.log" 2>/dev/null && break
    kill -0 "$owner_pid" 2>/dev/null || break
    sleep 0.05
done
if ! grep -q 'ready=true' "$runtime_directory/owner.log" 2>/dev/null; then
    printf '%s\n' 'Wayland clipboard owner did not claim selection' >&2
    sed -n '1,120p' "$runtime_directory/owner.log" >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi

XDG_RUNTIME_DIR="$runtime_directory" \
WAYLAND_DISPLAY=wayland-abla-clipboard \
    timeout 10s "$project_root/build/tests/wayland_clipboard_reader" \
    >"$runtime_directory/reader.log" 2>&1 &
reader_pid=$!
sleep 0.4
xdotool windowfocus "$window_id"
xdotool key alt+Tab
xdotool mousemove --window "$window_id" 400 300
xdotool click 1

set +e
wait "$reader_pid"
reader_status=$?
reader_pid=''
wait "$owner_pid"
owner_status=$?
owner_pid=''
set -e
sed -n '1,120p' "$runtime_directory/reader.log"
sed -n '1,120p' "$runtime_directory/owner.log"
if [[ $reader_status -ne 42 || $owner_status -ne 42 ]]; then
    printf 'Wayland clipboard test returned reader=%s owner=%s, expected 42/42\n' \
        "$reader_status" "$owner_status" >&2
    sed -n '1,240p' "$runtime_directory/weston.log" >&2
    exit 1
fi
