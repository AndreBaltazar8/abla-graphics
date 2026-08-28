#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=${ABLA_COMPILER_ROOT:-$(cd -- "$project_root/../ablac" && pwd)}
compiler=${ABLA_COMPILER:-"$compiler_root/build/ablac"}
output_directory="$project_root/build/registry-test"
generator="$output_directory/registry-generator"

mkdir -p "$output_directory"
cd "$compiler_root"
"$compiler" build --project "$project_root/tools/registry-generator" \
    -o "$generator" --no-cache

"$generator" vulkan \
    "$project_root/registry/fixtures/registry.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/first.md" "$output_directory/first.ab" \
    fixture-revision fixture-sha256 "$output_directory/first.calls.ab" \
    "$output_directory/first.builders.ab" \
    "$project_root/registry/fixtures/driver-vulkan-structures.txt" \
    "$output_directory/first.driver-builders.ab"
"$generator" vulkan \
    "$project_root/registry/fixtures/registry.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/second.md" "$output_directory/second.ab" \
    fixture-revision fixture-sha256 "$output_directory/second.calls.ab" \
    "$output_directory/second.builders.ab" \
    "$project_root/registry/fixtures/driver-vulkan-structures.txt" \
    "$output_directory/second.driver-builders.ab"

cmp "$output_directory/first.md" "$output_directory/second.md"
cmp "$output_directory/first.ab" "$output_directory/second.ab"
cmp "$output_directory/first.calls.ab" "$output_directory/second.calls.ab"
cmp "$output_directory/first.builders.ab" \
    "$output_directory/second.builders.ab"
cmp "$output_directory/first.driver-builders.ab" \
    "$output_directory/second.driver-builders.ab"
cmp "$output_directory/first.md" \
    "$project_root/registry/fixtures/vulkan.expected.md"
cmp "$output_directory/first.ab" \
    "$project_root/registry/fixtures/vulkan.expected.ab"
cmp "$output_directory/first.calls.ab" \
    "$project_root/registry/fixtures/vulkan.calls.expected.ab"
cmp "$output_directory/first.builders.ab" \
    "$project_root/registry/fixtures/vulkan.builders.expected.ab"
cmp "$output_directory/first.driver-builders.ab" \
    "$project_root/registry/fixtures/vulkan.driver-builders.expected.ab"
rg -Fq -- '- Raw call ABI families: 62' "$output_directory/first.md"
rg -Fq -- '- ABI families with paired executable evidence: 0/62' \
    "$output_directory/first.md"
rg -Fq '| `unsupported` | 1 | 0 | 1 | 0 | rejected |' \
    "$output_directory/first.md"
rg -Fq '| `void(pointer)` | 2 | 0 | 0 | 2 | unclaimed |' \
    "$output_directory/first.md"

if "$generator" vulkan \
    "$project_root/registry/fixtures/missing-definition.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/invalid.md" "$output_directory/invalid.ab" \
    fixture-revision fixture-sha256 \
    >"$output_directory/invalid.log" 2>&1; then
    printf '%s\n' 'registry with a missing command definition unexpectedly passed' >&2
    exit 1
fi
rg -q 'required command has no definition: vkMissing' \
    "$output_directory/invalid.log"

for failure in duplicate incomplete invalid-status unknown; do
    if "$generator" vulkan \
        "$project_root/registry/fixtures/registry.xml" \
        "$project_root/registry/fixtures/audit-$failure.tsv" \
        "$output_directory/audit-$failure.md" \
        "$output_directory/audit-$failure.ab" \
        fixture-revision fixture-sha256 \
        >"$output_directory/audit-$failure.log" 2>&1; then
        printf '%s\n' "invalid audit unexpectedly passed: $failure" >&2
        exit 1
    fi
done
rg -q 'duplicate audit row' "$output_directory/audit-duplicate.log"
rg -q 'unsafe or incomplete audit evidence' \
    "$output_directory/audit-incomplete.log"
rg -q 'unknown audit status' "$output_directory/audit-invalid-status.log"
rg -q 'audit row is absent from selected registry' \
    "$output_directory/audit-unknown.log"

"$generator" opengl \
    "$project_root/registry/fixtures/opengl-registry.xml" \
    "$project_root/registry/fixtures/opengl-audit.tsv" \
    "$output_directory/opengl-first.md" \
    "$output_directory/opengl-first.ab" \
    fixture-revision fixture-sha256 \
    "$output_directory/opengl-first.calls.ab" \
    "$output_directory/opengl-first.dispatch.ab"
"$generator" opengl \
    "$project_root/registry/fixtures/opengl-registry.xml" \
    "$project_root/registry/fixtures/opengl-audit.tsv" \
    "$output_directory/opengl-second.md" \
    "$output_directory/opengl-second.ab" \
    fixture-revision fixture-sha256 \
    "$output_directory/opengl-second.calls.ab" \
    "$output_directory/opengl-second.dispatch.ab"
cmp "$output_directory/opengl-first.md" \
    "$output_directory/opengl-second.md"
cmp "$output_directory/opengl-first.ab" \
    "$output_directory/opengl-second.ab"
cmp "$output_directory/opengl-first.calls.ab" \
    "$output_directory/opengl-second.calls.ab"
cmp "$output_directory/opengl-first.dispatch.ab" \
    "$output_directory/opengl-second.dispatch.ab"
rg -q '^val rawOpenGlRegistryConstantCount = 2$' \
    "$output_directory/opengl-first.ab"
rg -q '^val GL_FIXTURE_ONE = 0x1$' \
    "$output_directory/opengl-first.ab"
rg -q '^val GL_FIXTURE_OVERRIDE = 0x3$' \
    "$output_directory/opengl-first.ab"
rg -q 'ablaUnsafeCallExact_Void' \
    "$output_directory/opengl-first.dispatch.ab"
rg -q 'ablaUnsafeCallExact_F32_I32' \
    "$output_directory/opengl-first.dispatch.ab"
rg -Fq 'f64ToBits(ablaUnsafeCallExact_F32_I32' \
    "$output_directory/opengl-first.dispatch.ab"
rg -Fq '"handleResult(handle)"' \
    "$output_directory/opengl-first.calls.ab"
rg -q 'ablaUnsafeCallExact_U32_I32' \
    "$output_directory/opengl-first.dispatch.ab"
rg -q 'ablaUnsafeCallExact_Address_Pointer' \
    "$output_directory/opengl-first.dispatch.ab"
rg -Fq 'GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core|GL_VERSION_4_3:+:core' \
    "$output_directory/opengl-first.calls.ab"
rg -Fq 'GL_EXT_fixture:x11:all' \
    "$output_directory/opengl-first.calls.ab"
rg -Fq 'VK_EXT_alpha:xlib:all' \
    "$output_directory/first.calls.ab"
rg -Fq 'fun rawVulkanCallDispatchScopeSchema' \
    "$output_directory/first.calls.ab"
rg -Fq 'fun rawOpenGlCallDispatchScopeSchema' \
    "$output_directory/opengl-first.calls.ab"
rg -Fq -- '- Raw call ABI families: 3' \
    "$output_directory/opengl-first.md"
rg -Fq -- '- ABI families with paired executable evidence: 2/3' \
    "$output_directory/opengl-first.md"
rg -Fq '| `f32(i32)` | 1 | 1 | 0 | 0 | paired |' \
    "$output_directory/opengl-first.md"

if "$generator" opengl \
    "$project_root/registry/fixtures/opengl-invalid-constant.xml" \
    "$project_root/registry/fixtures/opengl-audit.tsv" \
    "$output_directory/opengl-invalid.md" \
    "$output_directory/opengl-invalid.ab" \
    fixture-revision fixture-sha256 \
    >"$output_directory/opengl-invalid.log" 2>&1; then
    printf '%s\n' 'invalid OpenGL constant unexpectedly passed' >&2
    exit 1
fi
rg -q 'unsupported OpenGL constant expression' \
    "$output_directory/opengl-invalid.log"

if "$generator" vulkan \
    "$project_root/registry/fixtures/vulkan-invalid-constant.xml" \
    "$project_root/registry/fixtures/audit.tsv" \
    "$output_directory/vulkan-invalid.md" \
    "$output_directory/vulkan-invalid.ab" \
    fixture-revision fixture-sha256 \
    >"$output_directory/vulkan-invalid.log" 2>&1; then
    printf '%s\n' 'invalid Vulkan constant unexpectedly passed' >&2
    exit 1
fi
rg -q 'unsupported Vulkan constant expression' \
    "$output_directory/vulkan-invalid.log"

cd "$compiler_root"
for backend in opengl vulkan; do
    source_file="$project_root/tests/raw_${backend}_registry.ab"
    if [[ $backend == vulkan ]]; then
        source_file="$project_root/tests/raw_registry.ab"
    fi
    executable="$output_directory/raw-$backend-registry"
    "$compiler" build "$source_file" -o "$executable" --fast --no-cache
    set +e
    "$executable"
    status=$?
    set -e
    if [[ $status -ne 42 ]]; then
        printf 'raw %s registry test returned %s, expected 42\n' \
            "$backend" "$status" >&2
        exit 1
    fi
done
