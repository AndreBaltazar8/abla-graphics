# Abla toolchain prerequisites

Abla Graphics is developed against `../ablac` and reports missing general
language capabilities explicitly rather than hiding project-specific compiler
special cases in the framework.

## Floating-point expressions

The 2026-08-17 compiler recognizes `f32` and `f64` as primitive type names,
but decimal literals are parsed as an integer followed by member access and
floating-point arithmetic does not pass semantic/LLVM validation. The initial
compiler-checked graphics math values therefore use deterministic millionth
fixed-point integers through `graphicsScalar`.

Before the public 0.1 vertex, matrix, clear-color, viewport, depth, and shader
constant API is frozen, `ablac` needs:

- decimal and exponent floating literals with an explicit/default width rule;
- checked `f32` and `f64` arithmetic/comparisons/conversions;
- system ABI lowering for floating parameters and results; and
- evaluator, LLVM, reflection, and export conformance tests.

Once those general capabilities pass the compiler suite, the framework math
surface will migrate to native floating values before compatibility guarantees
begin. Registry constants and bit flags are unaffected.

## Manifest-declared system driver libraries

Compiler commit `116090f` provides a bounded `nativeLibraries` string array in
the nearest ancestor root `abla.toml`. Names are passed as individual linker
arguments, limited to 32 distinct safe names, included in the build cache
identity, and rejected for non-hosted targets. The Vulkan tests use
`nativeLibraries = ["vulkan"]`. This is a general toolchain contract for
installed system/driver libraries, not a graphics-specific linker exception.
