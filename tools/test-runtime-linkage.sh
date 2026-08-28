#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/tests"
executable="$output_directory/runtime-linkage"

mkdir -p "$output_directory"
cd "$compiler_root"
# The partitioned LLVM build reserves more virtual address space than its
# resident set on the complete graphics module graph. Keep it bounded without
# tripping LLVM's allocation failure path on otherwise healthy builds.
ABLA_MAX_MEMORY_MB=${ABLA_RUNTIME_LINKAGE_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build "$project_root/examples/common-headless/main.ab" \
    -o "$executable" --no-cache

missing=$(env -u LD_LIBRARY_PATH ldd "$executable" | \
    sed -n '/not found/p')
if [[ -n $missing ]]; then
    printf 'fresh Abla executable has unresolved shared libraries:\n%s\n' \
        "$missing" >&2
    exit 1
fi

output=$(env -u LD_LIBRARY_PATH \
    -u ABLA_GRAPHICS_LVP_ICD \
    -u ABLA_GRAPHICS_EGL_VENDOR \
    -u ABLA_GRAPHICS_DRI \
    -u DISPLAY \
    "$executable")
printf '%s\n' "$output"
rg -q '^Headless opengl: ' <<<"$output"
rg -q '^Headless vulkan: ' <<<"$output"
printf 'runtime-linkage direct=true unresolved=0\n'
