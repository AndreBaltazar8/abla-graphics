#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
candidate="$project_root/build/toolchain/ablac-native-libs"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
"$project_root/tools/ensure-toolchain.sh"

cd "$compiler_root"
ABLA_SYSROOT="$compiler_root" "$candidate" \
    build "$project_root/tests/opengl/main.ab" \
    -o "$output_directory/opengl" --no-cache

set +e
LIBGL_ALWAYS_SOFTWARE=1 "$output_directory/opengl"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Abla OpenGL test returned %s, expected 42\n' "$status" >&2
    exit 1
fi
