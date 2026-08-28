# Raw OpenGL feature lab

This backend-specific sample scans every command in the pinned desktop OpenGL
registry. It evaluates ordered core/profile transitions and extension providers
from one captured context snapshot, resolves every advertised entry point, and
fails if metadata is missing or an advertised command has no address.

Run it in the project development shell:

```sh
nix-shell shell.nix --run 'make test-raw-feature-labs'
```
