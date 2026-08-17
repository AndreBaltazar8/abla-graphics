#!/usr/bin/env bash
set -euo pipefail

project_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
compiler_root=$(cd -- "$project_root/../ablac" && pwd)
candidate="$project_root/build/toolchain/ablac-native-libs"

"$project_root/tools/ensure-toolchain.sh"

cd "$compiler_root"
ABLA_SYSROOT="$compiler_root" \
    "$compiler_root/tools/test-native-libraries.sh" "$candidate"
"$compiler_root/tools/test-pure-self-rebuild.sh" "$candidate"
