#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
compiler="$compiler_root/build/ablac"

cd "$compiler_root"
ABLA_SYSROOT="$compiler_root" \
    "$compiler_root/tools/test-native-libraries.sh" "$compiler"
"$compiler_root/tools/test-pure-self-rebuild.sh" "$compiler_root/build/ablac.bin"
