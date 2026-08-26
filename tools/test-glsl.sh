#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
"$compiler" build "$project_root/tests/glsl_lexer.ab" \
    -o "$output_directory/glsl-lexer" --no-cache
set +e
"$output_directory/glsl-lexer"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'GLSL lexer test returned %s, expected 42\n' "$status" >&2
    exit 1
fi

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

"$compiler" build "$project_root/tests/glsl_dual_texture.ab" \
    -o "$output_directory/glsl-dual-texture" --no-cache
set +e
"$output_directory/glsl-dual-texture"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'GLSL dual-texture test returned %s, expected 42\n' "$status" >&2
    exit 1
fi

"$compiler" build "$project_root/tests/glsl_storage_image_push.ab" \
    -o "$output_directory/glsl-storage-image-push" --no-cache
set +e
"$output_directory/glsl-storage-image-push"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'GLSL storage-image push test returned %s, expected 42\n' \
        "$status" >&2
    exit 1
fi

"$compiler" build "$project_root/tests/push_constants.ab" \
    -o "$output_directory/push-constants" --no-cache
set +e
"$output_directory/push-constants"
status=$?
set -e
if [[ $status -ne 42 ]]; then
    printf 'Push-constant value test returned %s, expected 42\n' "$status" >&2
    exit 1
fi

if "$compiler" build "$project_root/tests/glsl_invalid.ab" \
    -o "$output_directory/glsl-invalid" --no-cache \
    >"$output_directory/glsl-invalid.log" 2>&1; then
    printf '%s\n' 'invalid GLSL stage unexpectedly compiled' >&2
    exit 1
fi
rg -q 'unknown GLSL stage' \
    "$output_directory/glsl-invalid.log"

if "$compiler" build "$project_root/tests/glsl_invalid_quote.ab" \
    -o "$output_directory/glsl-invalid-quote" --no-cache \
    >"$output_directory/glsl-invalid-quote.log" 2>&1; then
    printf '%s\n' 'unterminated GLSL quoted include unexpectedly compiled' >&2
    exit 1
fi
rg -q 'unterminated GLSL quoted text' \
    "$output_directory/glsl-invalid-quote.log"
rg -q 'source\[subparser\]:' \
    "$output_directory/glsl-invalid-quote.log"

if "$compiler" build "$project_root/tests/glsl_invalid_interpolation.ab" \
    -o "$output_directory/glsl-invalid-interpolation" --no-cache \
    >"$output_directory/glsl-invalid-interpolation.log" 2>&1; then
    printf '%s\n' 'string GLSL interpolation unexpectedly compiled' >&2
    exit 1
fi
rg -q 'glslInterpolationInt' \
    "$output_directory/glsl-invalid-interpolation.log"

if "$compiler" build \
    "$project_root/tests/glsl_invalid_float_interpolation.ab" \
    -o "$output_directory/glsl-invalid-float-interpolation" --no-cache \
    >"$output_directory/glsl-invalid-float-interpolation.log" 2>&1; then
    printf '%s\n' 'GLSL float interpolation unexpectedly compiled' >&2
    exit 1
fi
rg -q 'GLSL float interpolation requires deterministic Abla float formatting' \
    "$output_directory/glsl-invalid-float-interpolation.log"
