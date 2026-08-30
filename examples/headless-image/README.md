# Headless image generation

This display-free sample asks the selected GPU backend to produce four exact
RGBA8 colors, arranges them into a 16x16 quadrant image, and writes a portable
plain PPM file. OpenGL clears and reads its surfaceless pbuffer; Vulkan fills
and reads device-owned storage. The exported bytes are identical across both
backends.

```sh
nix-shell shell.nix --run 'ablac build --project examples/headless-image -o build/headless-image'
env -u DISPLAY -u WAYLAND_DISPLAY build/headless-image opengl build/opengl.ppm
env -u DISPLAY -u WAYLAND_DISPLAY build/headless-image vulkan build/vulkan.ppm
```

`make test-headless-image` removes all display variables and
`LD_LIBRARY_PATH`, checks both emitted files against the committed golden hash,
compares them byte-for-byte, and keeps Vulkan validation enabled.
