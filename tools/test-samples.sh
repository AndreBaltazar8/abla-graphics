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

samples=(x11-window wayland-info wayland-window wayland-pixels \
    wayland-animation \
    wayland-input \
    wayland-output \
    wayland-clipboard \
    vulkan-info vulkan-surface headless-opengl \
    common-headless \
    opengl-window common-clear common-triangle common-buffer async-buffer async-texture async-wider-texture buffer-pool texture-pool common-texture wider-texture wider-sampling \
    common-textured indexed-textured-cube render-to-texture \
    multiple-render-targets subpasses common-compute gpu-timestamp \
    push-color push-transform push-draw push-expression narrow-input \
    frame-pacing render-graph materialized-render-graph graph-post-process \
    recorded-graph-copy recorded-graph-render recorded-graph-compute \
    recorded-graph-transient-compute recorded-graph-buffered-render \
    recorded-graph-indirect-render recorded-graph-push-render \
    recorded-graph-depth-render recorded-graph-resolve-render \
    recorded-graph-mrt-render deferred-renderer recorded-graph-subpasses \
    recorded-graph-binding-subpasses recorded-graph-texture-render \
    recorded-graph-texture-compute recorded-compute-render \
    recorded-graph-storage-image-compute \
    recorded-graph-storage-image-view-compute \
    recorded-graph-storage-image-r32f-compute \
    recorded-graph-layered-storage-images \
    recorded-graph-storage-image-dimensions \
    recorded-graph-storage-image-push \
    recorded-graph-storage-image-read-add fragment-storage-image \
    recorded-graph-texture-subpasses \
    recorded-graph-transient-texture-subpasses)

for sample in "${samples[@]}"; do
    cd "$compiler_root"
    ABLA_MAX_MEMORY_MB=${ABLA_SAMPLE_TEST_MEMORY_MB:-8192} \
        ABLA_SYSROOT="$compiler_root" "$compiler" \
        build "$project_root/examples/$sample/main.ab" \
        -o "$output_directory/$sample" --no-cache
done

for sample in "${samples[@]}"; do
    missing=$(env -u LD_LIBRARY_PATH ldd "$output_directory/$sample" | \
        sed -n '/not found/p')
    if [[ -n $missing ]]; then
        printf '%s has unresolved shared libraries:\n%s\n' \
            "$sample" "$missing" >&2
        exit 1
    fi
done
unset LD_LIBRARY_PATH

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
XDG_RUNTIME_DIR="$wayland_runtime" WAYLAND_DISPLAY=wayland-abla-samples \
    timeout 10s "$output_directory/wayland-input"
XDG_RUNTIME_DIR="$wayland_runtime" WAYLAND_DISPLAY=wayland-abla-samples \
    timeout 10s "$output_directory/wayland-output"

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
        "$output_directory/async-buffer" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/async-texture" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/async-wider-texture" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/buffer-pool" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/texture-pool" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/materialized-render-graph" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/graph-post-process" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-copy" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-transient-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-buffered-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-indirect-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-push-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-depth-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-resolve-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-mrt-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/deferred-renderer" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-subpasses" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-binding-subpasses" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-texture-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-texture-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-compute-render" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-storage-image-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-storage-image-view-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-storage-image-r32f-compute" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-layered-storage-images" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-storage-image-dimensions" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-storage-image-push" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-storage-image-read-add" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/fragment-storage-image" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-texture-subpasses" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/recorded-graph-transient-texture-subpasses" \
        "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/common-texture" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/wider-texture" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/wider-sampling" "$backend"
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
        "$output_directory/push-color" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/push-transform" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/push-draw" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/push-expression" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/narrow-input" "$backend"
    xvfb-run -a -s "-screen 0 1024x768x24" \
        "$output_directory/gpu-timestamp" "$backend"
done
