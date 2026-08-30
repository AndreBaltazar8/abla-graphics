# Compute particles

This pure-Abla stress sample launches 16,384 GPU invocations per frame. A
deterministic `$glsl` compute shader uses `gl_GlobalInvocationID` and one
reusable push-constant frame index to scatter moving particles into an RGBA8
storage image; the portable render pipeline samples the accumulating trails
into a surfaced full-screen triangle.

```sh
nix-shell shell.nix --run 'ablac build --project examples/compute-particles -o build/compute-particles'
build/compute-particles opengl
build/compute-particles vulkan
```

The measured loop runs 120 frames, reports particle updates per second, and
requires exact GPU output, stable native handles, and zero live-memory growth.
`make test-compute-particles` runs both software backends with direct runtime
linkage and Vulkan validation checks.
