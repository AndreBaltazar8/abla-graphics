PROJECT_DIR := $(abspath .)
export ABLA_MAX_MEMORY_MB ?= 4096

.PHONY: all test test-core test-x11 test-wayland test-headless test-vulkan test-opengl \
	test-vulkan-window test-opengl-window test-glsl test-raw-commands test-raw-feature-labs test-gpu-profiler test-multi-window test-samples test-toolchain \
	test-application test-transfer test-texture-transfer test-wider-texture-transfer test-debug test-registry update-registry \
	test-texture-contract test-wider-texture test-wider-sampling test-shadow-mapping test-hdr-pbr test-gltf-material test-gltf-material-batches test-gltf-scene test-gltf-deformation-plan test-gltf-animation test-gltf-texture test-gltf-live-scene test-gltf-live-deformation test-gltf-live-animation test-pool test-texture-pool test-graph-texture test-graph-execute test-graph-commands test-runtime-linkage check-abla-only clean

all: check-abla-only test

check-abla-only:
	./tools/check-abla-only.sh

test: test-core test-texture-contract test-wider-texture test-wider-sampling test-shadow-mapping test-hdr-pbr test-gltf-material test-gltf-material-batches test-gltf-scene test-gltf-deformation-plan test-gltf-animation test-gltf-texture test-gltf-live-scene test-gltf-live-deformation test-gltf-live-animation test-x11 test-wayland test-headless test-vulkan test-vulkan-window test-opengl \
	test-opengl-window test-glsl test-application test-transfer test-texture-transfer test-wider-texture-transfer test-pool test-texture-pool test-graph-texture test-graph-execute test-graph-commands test-runtime-linkage test-debug test-registry test-raw-feature-labs test-gpu-profiler test-multi-window

test-core:
	./tools/test-core.sh

test-texture-contract:
	./tools/test-texture-contract.sh

test-wider-texture:
	./tools/test-wider-texture.sh

test-wider-sampling:
	./tools/test-wider-sampling.sh

test-shadow-mapping:
	./tools/test-shadow-mapping.sh

test-hdr-pbr:
	./tools/test-hdr-pbr.sh

test-gltf-material:
	./tools/test-gltf-material.sh

test-gltf-material-batches:
	./tools/test-gltf-material-batches.sh

test-gltf-scene:
	./tools/test-gltf-scene.sh

test-gltf-deformation-plan:
	./tools/test-gltf-deformation-plan.sh

test-gltf-animation:
	./tools/test-gltf-animation.sh

test-gltf-texture:
	./tools/test-gltf-texture.sh

test-gltf-live-scene:
	./tools/test-gltf-live-scene.sh

test-gltf-live-deformation:
	./tools/test-gltf-live-deformation.sh

test-gltf-live-animation:
	./tools/test-gltf-live-animation.sh

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

test-graph-texture:
	./tools/test-graph-texture.sh

test-graph-execute:
	./tools/test-graph-execute.sh

test-graph-commands:
	./tools/test-graph-commands.sh

test-runtime-linkage:
	./tools/test-runtime-linkage.sh

test-debug:
	./tools/test-debug.sh

test-registry:
	./tools/test-registry.sh

test-raw-commands:
	./tools/test-raw-commands.sh

test-raw-feature-labs:
	./tools/test-raw-feature-labs.sh

test-gpu-profiler:
	./tools/test-gpu-profiler.sh

test-multi-window:
	./tools/test-multi-window.sh

update-registry:
	./tools/update-registry.sh

test-samples:
	./tools/test-samples.sh

test-toolchain:
	./tools/test-toolchain.sh

clean:
	@if [ -d "$(PROJECT_DIR)/build" ]; then gio trash "$(PROJECT_DIR)/build"; fi
