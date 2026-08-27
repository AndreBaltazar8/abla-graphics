#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"
cache_directory="$project_root/build/registry"
generator="$cache_directory/registry-generator"
manifest="$project_root/registry/manifest.toml"

manifest_value() {
    local section=$1
    local key=$2
    awk -v wanted_section="$section" -v wanted_key="$key" '
        $0 == "[" wanted_section "]" { active = 1; next }
        /^\[/ { active = 0 }
        active && $1 == wanted_key {
            value = $0
            sub(/^[^=]*=[[:space:]]*/, "", value)
            gsub(/^"|"$/, "", value)
            print value
            exit
        }
    ' "$manifest"
}

vulkan_repository=$(manifest_value vulkan repository)
vulkan_revision=$(manifest_value vulkan revision)
vulkan_path=$(manifest_value vulkan path)
vulkan_sha256=$(manifest_value vulkan sha256)
opengl_repository=$(manifest_value opengl repository)
opengl_revision=$(manifest_value opengl revision)
opengl_path=$(manifest_value opengl path)
opengl_sha256=$(manifest_value opengl sha256)

for value in "$vulkan_repository" "$vulkan_revision" "$vulkan_path" \
    "$vulkan_sha256" "$opengl_repository" "$opengl_revision" \
    "$opengl_path" "$opengl_sha256"; do
    if [[ -z $value ]]; then
        printf '%s\n' 'registry manifest is incomplete' >&2
        exit 1
    fi
done

mkdir -p "$cache_directory" "$project_root/registry/coverage" \
    "$project_root/src/raw"
curl --fail --location --silent --show-error \
    "https://raw.githubusercontent.com/${vulkan_repository#https://github.com/}/$vulkan_revision/$vulkan_path" \
    --output "$cache_directory/vk.xml"
curl --fail --location --silent --show-error \
    "https://raw.githubusercontent.com/${opengl_repository#https://github.com/}/$opengl_revision/$opengl_path" \
    --output "$cache_directory/gl.xml"

printf '%s  %s\n' "$vulkan_sha256" "$cache_directory/vk.xml" | sha256sum --check --status
printf '%s  %s\n' "$opengl_sha256" "$cache_directory/gl.xml" | sha256sum --check --status

cd "$compiler_root"
"$compiler" build --project "$project_root/tools/registry-generator" \
    -o "$generator" --no-cache
"$generator" vulkan "$cache_directory/vk.xml" \
    "$project_root/registry/audit/vulkan.tsv" \
    "$project_root/registry/coverage/vulkan.md" \
    "$project_root/src/raw/vulkan_registry.ab" \
    "$vulkan_revision" "$vulkan_sha256" \
    "$project_root/src/raw/vulkan_calls.ab" \
    "$project_root/src/raw/vulkan_builder_schema.ab" \
    "$project_root/registry/driver-vulkan-structures.txt" \
    "$project_root/src/driver/vulkan_builder_schema.ab"
"$generator" opengl "$cache_directory/gl.xml" \
    "$project_root/registry/audit/opengl.tsv" \
    "$project_root/registry/coverage/opengl.md" \
    "$project_root/src/raw/opengl_registry.ab" \
    "$opengl_revision" "$opengl_sha256" \
    "$project_root/src/raw/opengl_calls.ab"
