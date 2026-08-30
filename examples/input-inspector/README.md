# Window and input inspector

This pure-Abla sample renders a compact 5x7 bitmap-text overlay through the
portable pixel presentation path and updates it from portable keyboard, UTF-8
text, pointer motion, pointer-button, wheel, focus, and monitor state. The same
application runs on OpenGL and Vulkan.

```sh
nix-shell shell.nix --run 'ablac build --project examples/input-inspector -o build/input-inspector'
build/input-inspector opengl
build/input-inspector vulkan
```

Press Escape to close it. `make test-input-inspector` drives real X11 input
with `xdotool` under Xvfb, verifies both backends and direct runtime linkage,
and keeps Vulkan validation enabled.
