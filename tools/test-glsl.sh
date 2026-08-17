#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
"$compiler" build "$project_root/tests/glsl_subparser.ab" \
    -o "$output_directory/glsl" --no-cache
set +e
"$output_directory/glsl"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'GLSL subparser test returned %s, expected 42\n' "$status" >&2
    exit 1
fi

if "$compiler" build "$project_root/tests/glsl_invalid.ab" \
    -o "$output_directory/glsl-invalid" --no-cache \
    >"$output_directory/glsl-invalid.log" 2>&1; then
    printf '%s\n' 'invalid GLSL stage unexpectedly compiled' >&2
    exit 1
fi
rg -q 'subparser `glslParsePackage` failed' \
    "$output_directory/glsl-invalid.log"
