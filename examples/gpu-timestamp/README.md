# GPU profiler

This sample turns the portable timestamp-query resource into a small frame
profiler. It warms the selected backend, measures 64 submitted clear/present
frames, and reports minimum, average, and maximum GPU nanoseconds plus the
corresponding estimated frame rate.

The query and its native command state are retained for the entire run. The
sample fails if timestamps regress, a duration is zero, the native handles
change, the statistics are inconsistent, or the measured loop grows live
memory.

Build and run it from the repository's Nix environment:

```sh
nix-shell shell.nix --run 'ablac build --project examples/gpu-timestamp -o build/gpu-profiler'
build/gpu-profiler opengl
build/gpu-profiler vulkan
```

Use `make test-gpu-profiler` for direct-linkage checks, explicit OpenGL and
validation-enabled Vulkan execution, and output assertions.
