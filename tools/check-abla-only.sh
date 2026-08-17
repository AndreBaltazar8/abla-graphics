#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

if ! command -v rg >/dev/null 2>&1; then
    printf '%s\n' 'ripgrep is required for the Abla-only audit' >&2
    exit 127
fi

forbidden=$(find "$project_root" \
    -path "$project_root/.git" -prune -o \
    -path "$project_root/build" -prune -o \
    -type f \( \
        -name '*.c' -o -name '*.h' -o -name '*.cc' -o -name '*.hh' -o \
        -name '*.cpp' -o -name '*.hpp' -o -name '*.cxx' -o \
        -name '*.hxx' -o -name '*.m' -o -name '*.mm' -o -name '*.rs' \
    \) -print)

if [[ -n $forbidden ]]; then
    printf '%s\n' 'non-Abla implementation source is forbidden:' >&2
    printf '%s\n' "$forbidden" >&2
    exit 1
fi

if rg -n -i \
    'nativeLibraries[[:space:]]*=.*(glfw|sdl)|import[[:space:]]+.*(glfw|sdl)' \
    "$project_root" \
    -g '*.ab' -g 'abla.toml'; then
    printf '%s\n' 'GLFW/SDL dependency is forbidden' >&2
    exit 1
fi

printf '%s\n' 'Abla-only source audit passed'
