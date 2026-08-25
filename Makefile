PROJECT_DIR := $(abspath .)
export ABLA_MAX_MEMORY_MB ?= 4096

.PHONY: all test test-core test-x11 test-wayland test-headless test-vulkan test-opengl \
	test-vulkan-window test-opengl-window test-glsl test-samples test-toolchain \
	test-application test-transfer test-texture-transfer test-wider-texture-transfer test-debug test-registry update-registry \
	test-texture-contract test-wider-texture test-wider-sampling test-pool test-texture-pool check-abla-only clean

all: check-abla-only test

check-abla-only:
	./tools/check-abla-only.sh

test: test-core test-texture-contract test-wider-texture test-wider-sampling test-x11 test-wayland test-headless test-vulkan test-vulkan-window test-opengl \
	test-opengl-window test-glsl test-application test-transfer test-texture-transfer test-wider-texture-transfer test-pool test-texture-pool test-debug test-registry

test-core:
	./tools/test-core.sh

test-texture-contract:
	./tools/test-texture-contract.sh

test-wider-texture:
	./tools/test-wider-texture.sh

test-wider-sampling:
	./tools/test-wider-sampling.sh

test-x11:
	./tools/test-x11.sh

test-wayland:
	./tools/test-wayland.sh

test-headless:
	./tools/test-headless.sh

test-vulkan:
	./tools/test-vulkan.sh

test-vulkan-window:
	./tools/test-vulkan-window.sh

test-opengl:
	./tools/test-opengl.sh

test-opengl-window:
	./tools/test-opengl-window.sh

test-glsl:
	./tools/test-glsl.sh

test-application:
	./tools/test-application.sh

test-transfer:
	./tools/test-transfer.sh

test-texture-transfer:
	./tools/test-texture-transfer.sh

test-wider-texture-transfer:
	./tools/test-wider-texture-transfer.sh

test-pool:
	./tools/test-pool.sh

test-texture-pool:
	./tools/test-texture-pool.sh

test-debug:
	./tools/test-debug.sh

test-registry:
	./tools/test-registry.sh

update-registry:
	./tools/update-registry.sh

test-samples:
	./tools/test-samples.sh

test-toolchain:
	./tools/test-toolchain.sh

clean:
	@if [ -d "$(PROJECT_DIR)/build" ]; then gio trash "$(PROJECT_DIR)/build"; fi
