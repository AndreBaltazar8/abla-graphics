#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
output_directory="$project_root/build/tests"

mkdir -p "$output_directory"
cd "$compiler_root"
# The complete public composition root plus this intentionally broad
# conformance source exceeds the generic compiler address-space guard. Keep the
# larger limit scoped to this gate rather than raising every build.
ABLA_MAX_MEMORY_MB=${ABLA_APPLICATION_TEST_MEMORY_MB:-8192} \
    ABLA_SYSROOT="$compiler_root" "$compiler" \
    build --project "$project_root/tests/application" \
    -o "$output_directory/application" --no-cache

for backend in opengl vulkan auto; do
    set +e
    xvfb-run -a -s "-screen 0 800x600x24" \
        "$output_directory/application" "$backend"
    status=$?
    set -e
    if [[ $status -ne 42 ]]; then
        printf 'Abla common %s application test returned %s, expected 42\n' \
            "$backend" "$status" >&2
        exit 1
    fi
done

for mode in fallback unavailable unsupported; do
    set +e
    VK_DRIVER_FILES=/abla-graphics/no-vulkan-driver.json \
        xvfb-run -a -s "-screen 0 800x600x24" \
        "$output_directory/application" "$mode"
    status=$?
    set -e
    if [[ $status -ne 42 ]]; then
        printf 'Abla common %s application test returned %s, expected 42\n' \
            "$mode" "$status" >&2
        exit 1
    fi
done
