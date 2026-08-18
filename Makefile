PROJECT_DIR := $(abspath .)

.PHONY: all test test-core test-x11 test-headless test-vulkan test-opengl \
	test-vulkan-window test-opengl-window test-glsl test-samples test-toolchain \
	test-application test-registry update-registry check-abla-only clean

all: check-abla-only test

check-abla-only:
	./tools/check-abla-only.sh

test: test-core test-x11 test-headless test-vulkan test-vulkan-window test-opengl \
	test-opengl-window test-glsl test-application test-registry

test-core:
	./tools/test-core.sh

test-x11:
	./tools/test-x11.sh

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
