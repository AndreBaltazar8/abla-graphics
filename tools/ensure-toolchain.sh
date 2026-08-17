#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
bootstrap_compiler="$compiler_root/build/ablac"
candidate="$project_root/build/toolchain/ablac-native-libs"

mkdir -p "$(dirname -- "$candidate")"
newer=
if [[ -x $candidate ]]; then
    newer=$(find "$compiler_root/src" "$compiler_root/stdlib" \
        -type f -name '*.ab' -newer "$candidate" -print -quit)
fi
if [[ ! -x $candidate || -n $newer ]]; then
    cd "$compiler_root"
    "$bootstrap_compiler" build src/orc_main.ab \
        -o "$candidate" --no-cache
fi
