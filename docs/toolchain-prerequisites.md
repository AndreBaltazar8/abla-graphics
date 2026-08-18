# Abla toolchain prerequisites

Abla Graphics is developed against `../ablac` and reports missing general
language capabilities explicitly rather than hiding project-specific compiler
special cases in the framework.

## Floating-point expressions

Compiler commits `9581d03`, `db72fbf`, and `a38bca7` provide decimal and
exponent literals defaulting to `f64`, checked runtime `f64` arithmetic and
comparisons, direct and native ABI lowering, exported/boxed values, arrays,
class fields, closures, globals, exact `f64ToBits`/`f64FromBits`
representation helpers, and explicit signed `int` to `f64` conversion. The
public graphics math, color, and DPI surface therefore uses native `f64` values.

Abla Graphics performs deterministic round-to-nearest-even conversion from
binary64 to binary32 in pure Abla when OpenGL or Vulkan requires an `f32` bit
pattern. Explicit language-level `f32` conversions and compile-time floating
evaluation remain toolchain work; neither limitation requires a fixed-point
public graphics API. Registry constants and bit flags are unaffected.

## Manifest-declared system driver libraries

Compiler commit `116090f` provides a bounded `nativeLibraries` string array in
the nearest ancestor root `abla.toml`. Names are passed as individual linker
arguments, limited to 32 distinct safe names, included in the build cache
identity, and rejected for non-hosted targets. The Vulkan tests use
`nativeLibraries = ["vulkan"]`. This is a general toolchain contract for
installed system/driver libraries, not a graphics-specific linker exception.
