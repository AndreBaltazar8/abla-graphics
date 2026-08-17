PROJECT_DIR := $(abspath .)

.PHONY: all test test-core test-x11 test-vulkan test-opengl \
	test-vulkan-window test-opengl-window test-glsl test-samples test-toolchain \
	check-abla-only clean

all: check-abla-only test

check-abla-only:
	./tools/check-abla-only.sh

test: test-core test-x11 test-vulkan test-vulkan-window test-opengl \
	test-opengl-window test-glsl

test-core:
	./tools/test-core.sh

test-x11:
	./tools/test-x11.sh

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

test-samples:
	./tools/test-samples.sh

test-toolchain:
	./tools/test-toolchain.sh

clean:
	@if [ -d "$(PROJECT_DIR)/build" ]; then gio trash "$(PROJECT_DIR)/build"; fi
