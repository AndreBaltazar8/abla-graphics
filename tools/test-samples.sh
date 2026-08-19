#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/samples"
wayland_runtime=$(mktemp -d)
weston_pid=''

cleanup() {
    if [[ -n $weston_pid ]]; then
        kill "$weston_pid" 2>/dev/null || true
        wait "$weston_pid" 2>/dev/null || true
    fi
    rm -rf -- "$wayland_runtime"
}
trap cleanup EXIT

mkdir -p "$output_directory"
chmod 700 "$wayland_runtime"

for sample in x11-window wayland-info wayland-window wayland-pixels \
    wayland-animation \
    vulkan-info vulkan-surface headless-opengl \
    common-headless \
    opengl-window common-clear common-triangle common-buffer common-texture \
    common-textured indexed-textured-cube render-to-texture \
    multiple-render-targets subpasses common-compute gpu-timestamp \
    frame-pacing render-graph; do
    cd "$compiler_root"
    ABLA_SYSROOT="$compiler_root" "$compiler" \
        build "$project_root/examples/$sample/main.ab" \
        -o "$output_directory/$sample" --no-cache
done

XDG_RUNTIME_DIR="$wayland_runtime" weston \
    --backend=headless-backend.so \
    --renderer=pixman \
    --width=1024 \
    --height=768 \
    --socket=wayland-abla-samples \
    --idle-time=0 \
    --log="$output_directory/weston-samples.log" &
weston_pid=$!
for _ in $(seq 1 100); do
    [[ -S "$wayland_runtime/wayland-abla-samples" ]] && break
    kill -0 "$weston_pid" 2>/dev/null || exit 1
    sleep 0.05
done
[[ -S "$wayland_runtime/wayland-abla-samples" ]]
XDG_RUNTIME_DIR="$wayland_runtime" WAYLAND_DISPLAY=wayland-abla-samples \
    "$output_directory/wayland-info"
XDG_RUNTIME_DIR="$wayland_runtime" WAYLAND_DISPLAY=wayland-abla-samples \
    timeout 10s "$output_directory/wayland-window"
XDG_RUNTIME_DIR="$wayland_runtime" WAYLAND_DISPLAY=wayland-abla-samples \
    timeout 10s "$output_directory/wayland-pixels"
XDG_RUNTIME_DIR="$wayland_runtime" WAYLAND_DISPLAY=wayland-abla-samples \
    timeout 10s "$output_directory/wayland-animation"

xvfb-run -a -s "-screen 0 1024x768x24" \
    "$output_directory/x11-window"
"$output_directory/vulkan-info"
xvfb-run -a -s "-screen 0 1024x768x24" \
    "$output_directory/vulkan-surface"
LIBGL_ALWAYS_SOFTWARE=1 "$output_directory/headless-opengl"
env -u DISPLAY "$output_directory/common-headless"
env -u DISPLAY "$output_directory/frame-pacing"
env -u DISPLAY "$output_directory/render-graph"
LIBGL_ALWAYS_SOFTWARE=1 xvfb-run -a -s "-screen 0 1024x768x24" \
    "$output_directory/opengl-window"
for backend in opengl vulkan; do
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-clear" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-triangle" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-buffer" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-texture" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-textured" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/indexed-textured-cube" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/render-to-texture" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/multiple-render-targets" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/subpasses" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/gpu-timestamp" "$backend"
done
