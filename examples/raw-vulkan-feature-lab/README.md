# Raw Vulkan feature lab

This backend-specific sample scans all commands in the pinned Vulkan registry.
It combines generated global/instance/device scope with negotiated core
versions, the exact enabled extension sets, and platform restrictions. Every
advertised entry point must resolve through its correct Vulkan loader.

Run it in the project development shell:

```sh
nix-shell shell.nix --run 'make test-raw-feature-labs'
```
