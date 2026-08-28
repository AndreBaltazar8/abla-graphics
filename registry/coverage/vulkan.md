# Vulkan registry inventory

- Revision: `090f1b190d60ced4a1d198fd3747d071cc271b1c`
- SHA-256: `65d829561fa4b9e01a15e1327d9e6744f66b025b08c5c7ad13636bf0a8b15c62`
- Commands: 842
- Core features: 5
- Extensions: 473
- Constants: 5633
- Types: 2497
- Command parameters: 2809
- Aggregates: 1450
- Aggregate members: 7413
- Classified commands: 113/842
- Classified core features: 0/5
- Classified extensions: 0/473

## Commands

| Name | Form | Core transitions | Extension providers | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `vkAcquireDrmDisplayEXT` | definition |  | VK_EXT_acquire_drm_display:all:all | unclassified | - | - | - | - |
| `vkAcquireFullScreenExclusiveModeEXT` | definition |  | VK_EXT_full_screen_exclusive:win32:all | unclassified | - | - | - | - |
| `vkAcquireNextImage2KHR` | definition |  | VK_KHR_swapchain:all:all|VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkAcquireNextImageKHR` | definition |  | VK_KHR_swapchain:all:all | common | src/driver/vulkan.ab bounded per-frame swapchain image acquisition | src/driver/vulkan.ab typed swapchain timeout semaphore fence and index ABI | tests/vulkan_window/main.ab repeated surfaced frame acquisition | tests/application/main.ab out-of-date acquisition resize recovery |
| `vkAcquirePerformanceConfigurationINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkAcquireProfilingLockKHR` | definition |  | VK_KHR_performance_query:all:all | unclassified | - | - | - | - |
| `vkAcquireWinrtDisplayNV` | definition |  | VK_NV_acquire_winrt_display:win32:all | unclassified | - | - | - | - |
| `vkAcquireXlibDisplayEXT` | definition |  | VK_EXT_acquire_xlib_display:xlib_xrandr:all | unclassified | - | - | - | - |
| `vkAllocateCommandBuffers` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reusable transfer compute render and query command allocation | src/driver/vulkan.ab packed CommandBufferAllocateInfo ABI | tests/application/main.ab stable command handles across repeated operations | tests/application/main.ab invalid resources rejected before allocation |
| `vkAllocateDescriptorSets` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine bind-group descriptor allocation | src/driver/vulkan.ab packed DescriptorSetAllocateInfo ABI | examples/common-textured/main.ab stable descriptor set across repeated rendering | tests/application/main.ab duplicate binding rejection |
| `vkAllocateMemory` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab host-visible and device-local buffer memory allocation | src/driver/vulkan.ab packed allocation and memory-properties ABIs | tests/transfer/main.ab exact staged device-local upload and readback | tests/core.ab invalid placement and mapping rejection |
| `vkAntiLagUpdateAMD` | definition |  | VK_AMD_anti_lag:all:all | unclassified | - | - | - | - |
| `vkBeginCommandBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reusable command recording begin | src/driver/vulkan.ab packed CommandBufferBeginInfo ABI | examples/common-compute/main.ab repeated compute command recording | tests/application/main.ab invalid dispatch and transfer rejection before recording |
| `vkBindAccelerationStructureMemoryNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkBindBufferMemory` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab selected buffer memory binding | src/driver/vulkan.ab typed extern signature | tests/transfer/main.ab device-local transfer destination lifecycle | tests/core.ab invalid device-local mapping rejection |
| `vkBindBufferMemory2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkBindBufferMemory2KHR` | alias |  | VK_KHR_bind_memory2:all:all | unclassified | - | - | - | - |
| `vkBindDataGraphPipelineSessionMemoryARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkBindImageMemory` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab texture memory binding | src/driver/vulkan.ab typed device image memory and offset ABI | tests/application/main.ab exact texture upload and readback | tests/application/main.ab invalid texture descriptor rejection |
| `vkBindImageMemory2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkBindImageMemory2KHR` | alias |  | VK_KHR_bind_memory2:all:all | unclassified | - | - | - | - |
| `vkBindOpticalFlowSessionImageNV` | definition |  | VK_NV_optical_flow:all:all | unclassified | - | - | - | - |
| `vkBindTensorMemoryARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkBindVideoSessionMemoryKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkBuildAccelerationStructuresKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkBuildMicromapsEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkClearShaderInstrumentationMetricsARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkCmdBeginConditionalRendering2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdBeginConditionalRenderingEXT` | definition |  | VK_EXT_conditional_rendering:all:all | unclassified | - | - | - | - |
| `vkCmdBeginCustomResolveEXT` | definition |  | VK_EXT_custom_resolve:all:all | unclassified | - | - | - | - |
| `vkCmdBeginDebugUtilsLabelEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkCmdBeginGpaSampleAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkCmdBeginGpaSessionAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkCmdBeginPerTileExecutionQCOM` | definition |  | VK_QCOM_tile_shading:all:all | unclassified | - | - | - | - |
| `vkCmdBeginQuery` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdBeginQueryIndexedEXT` | definition |  | VK_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `vkCmdBeginRenderPass` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab legacy offscreen and subpass recording | src/driver/vulkan.ab packed RenderPassBeginInfo and clear-value ABIs | tests/application/main.ab exact MRT multisample and two-subpass rendering | tests/application/main.ab invalid pass and attachment rejection |
| `vkCmdBeginRenderPass2` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkCmdBeginRenderPass2KHR` | alias |  | VK_KHR_create_renderpass2:all:all | unclassified | - | - | - | - |
| `vkCmdBeginRendering` | definition | VK_VERSION_1_3:+:all |  | common | src/driver/vulkan.ab surfaced dynamic rendering | src/driver/vulkan.ab packed RenderingInfo and attachment ABIs | tests/vulkan_window/main.ab repeated dynamic color rendering | tests/vulkan_window/main.ab forced legacy render-pass fallback |
| `vkCmdBeginRenderingKHR` | alias |  | VK_KHR_dynamic_rendering:all:all | unclassified | - | - | - | - |
| `vkCmdBeginShaderInstrumentationARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkCmdBeginTransformFeedback2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdBeginTransformFeedbackEXT` | definition |  | VK_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `vkCmdBeginVideoCodingKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkCmdBindDescriptorBufferEmbeddedSamplers2EXT` | definition |  | VK_KHR_maintenance6:all:all | unclassified | - | - | - | - |
| `vkCmdBindDescriptorBufferEmbeddedSamplersEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkCmdBindDescriptorBuffersEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkCmdBindDescriptorSets` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab render and compute descriptor binding | src/driver/vulkan.ab typed bind-point layout set and offset ABI | examples/common-textured/main.ab repeated indexed sampled rendering | examples/common-textured/main.ab missing shader binding rejection |
| `vkCmdBindDescriptorSets2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdBindDescriptorSets2KHR` | alias |  | VK_KHR_maintenance6:all:all | unclassified | - | - | - | - |
| `vkCmdBindIndexBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab direct range base and portable absolute-firstIndex indirect binding | src/driver/vulkan.ab typed command buffer handle offset and index-type ABI | examples/render-to-texture/main.ab nonzero pooled direct and indirect index rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `vkCmdBindIndexBuffer2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdBindIndexBuffer2KHR` | alias |  | VK_KHR_maintenance5:all:all | unclassified | - | - | - | - |
| `vkCmdBindIndexBuffer3KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdBindInvocationMaskHUAWEI` | definition |  | VK_HUAWEI_invocation_mask:all:all | unclassified | - | - | - | - |
| `vkCmdBindPipeline` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab graphics and compute pipeline binding | src/driver/vulkan.ab typed bind-point and pipeline ABI | tests/application/main.ab exact compute and render execution | tests/application/main.ab invalid pipeline rejection before recording |
| `vkCmdBindPipelineShaderGroupNV` | definition |  | VK_NV_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCmdBindResourceHeapEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkCmdBindSamplerHeapEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkCmdBindShadersEXT` | definition |  | VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdBindShadingRateImageNV` | definition |  | VK_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `vkCmdBindTileMemoryQCOM` | definition |  | VK_QCOM_tile_memory_heap:all:all | unclassified | - | - | - | - |
| `vkCmdBindTransformFeedbackBuffers2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdBindTransformFeedbackBuffersEXT` | definition |  | VK_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `vkCmdBindVertexBuffers` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab offset-aware raster vertex-buffer binding | src/driver/vulkan.ab typed buffer and offset array ABI | examples/push-color/main.ab nonzero pooled target pass and surfaced rendering | tests/pool/main.ab surfaced and offscreen misaligned range rejection |
| `vkCmdBindVertexBuffers2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdBindVertexBuffers2EXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdBindVertexBuffers3KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdBlitImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab mip command recording | src/driver/vulkan.ab packed image blit ABI | tests/application/main.ab exact generated final mip | tests/application/main.ab invalid mip generation rejection |
| `vkCmdBlitImage2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdBlitImage2KHR` | alias |  | VK_KHR_copy_commands2:all:all | unclassified | - | - | - | - |
| `vkCmdBuildAccelerationStructureNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkCmdBuildAccelerationStructuresIndirectKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdBuildAccelerationStructuresKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdBuildClusterAccelerationStructureIndirectNV` | definition |  | VK_NV_cluster_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdBuildMicromapsEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCmdBuildPartitionedAccelerationStructuresNV` | definition |  | VK_NV_partitioned_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdClearAttachments` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdClearColorImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab transfer clear command recording | src/driver/vulkan.ab packed clear color and image-subresource range ABIs | tests/application/main.ab exact repeated render-target and MRT clears | tests/application/main.ab invalid clear attachment rejection |
| `vkCmdClearDepthStencilImage` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdControlVideoCodingKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkCmdConvertCooperativeVectorMatrixNV` | definition |  | VK_NV_cooperative_vector:all:all | unclassified | - | - | - | - |
| `vkCmdCopyAccelerationStructureKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdCopyAccelerationStructureNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkCmdCopyAccelerationStructureToMemoryKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdCopyBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab synchronous and queued buffer copies | src/driver/vulkan.ab packed BufferCopy ABI | tests/transfer/main.ab exact three-slot upload and readback | tests/transfer/main.ab invalid queued range rejection |
| `vkCmdCopyBuffer2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdCopyBuffer2KHR` | alias |  | VK_KHR_copy_commands2:all:all | unclassified | - | - | - | - |
| `vkCmdCopyBufferToImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab texture upload | src/driver/vulkan.ab packed buffer image copy ABI | tests/application/main.ab and tests/wider_texture_transfer/main.ab exact texture upload | tests/application/main.ab upload range rejection |
| `vkCmdCopyBufferToImage2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdCopyBufferToImage2KHR` | alias |  | VK_KHR_copy_commands2:all:all | unclassified | - | - | - | - |
| `vkCmdCopyGpaSessionResultsAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkCmdCopyImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab texture copy | src/driver/vulkan.ab packed image copy ABI | tests/application/main.ab exact texture copy | tests/application/main.ab incompatible copy rejection |
| `vkCmdCopyImage2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdCopyImage2KHR` | alias |  | VK_KHR_copy_commands2:all:all | unclassified | - | - | - | - |
| `vkCmdCopyImageToBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab texture readback | src/driver/vulkan.ab packed buffer image copy ABI | tests/application/main.ab and tests/wider_texture_transfer/main.ab exact texture readback | tests/application/main.ab readback range rejection |
| `vkCmdCopyImageToBuffer2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdCopyImageToBuffer2KHR` | alias |  | VK_KHR_copy_commands2:all:all | unclassified | - | - | - | - |
| `vkCmdCopyImageToMemoryKHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryIndirectKHR` | definition |  | VK_KHR_copy_memory_indirect:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryIndirectNV` | definition |  | VK_NV_copy_memory_indirect:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryKHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToAccelerationStructureKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToImageIndirectKHR` | definition |  | VK_KHR_copy_memory_indirect:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToImageIndirectNV` | definition |  | VK_NV_copy_memory_indirect:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToImageKHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToMicromapEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMicromapEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCmdCopyMicromapToMemoryEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCmdCopyQueryPoolResults` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdCopyQueryPoolResultsToMemoryKHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdCopyTensorARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkCmdCuLaunchKernelNVX` | definition |  | VK_NVX_binary_import:all:all | unclassified | - | - | - | - |
| `vkCmdCudaLaunchKernelNV` | definition |  | VK_NV_cuda_kernel_launch:provisional:all | unclassified | - | - | - | - |
| `vkCmdDebugMarkerBeginEXT` | definition |  | VK_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `vkCmdDebugMarkerEndEXT` | definition |  | VK_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `vkCmdDebugMarkerInsertEXT` | definition |  | VK_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `vkCmdDecodeVideoKHR` | definition |  | VK_KHR_video_decode_queue:all:all | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryEXT` | definition |  | VK_EXT_memory_decompression:all:all | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryIndirectCountEXT` | definition |  | VK_EXT_memory_decompression:all:all | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryIndirectCountNV` | definition |  | VK_NV_memory_decompression:all:all | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryNV` | definition |  | VK_NV_memory_decompression:all:all | unclassified | - | - | - | - |
| `vkCmdDispatch` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab compute workgroup command recording | src/driver/vulkan.ab typed three-axis group-count ABI | examples/common-compute/main.ab exact storage and push compute output | tests/application/main.ab zero and limit-exceeding dispatch rejection |
| `vkCmdDispatchBase` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkCmdDispatchBaseKHR` | alias |  | VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkCmdDispatchDataGraphARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkCmdDispatchGraphAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkCmdDispatchGraphIndirectAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkCmdDispatchGraphIndirectCountAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkCmdDispatchIndirect` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdDispatchIndirect2KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDispatchTileQCOM` | definition |  | VK_QCOM_tile_shading:all:all | unclassified | - | - | - | - |
| `vkCmdDraw` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab render command recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact triangle pixels | tests/application/main.ab invalid vertex range rejection |
| `vkCmdDrawClusterHUAWEI` | definition |  | VK_HUAWEI_cluster_culling_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawClusterIndirectHUAWEI` | definition |  | VK_HUAWEI_cluster_culling_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndexed` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab indexed render recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact indexed output | tests/application/main.ab invalid index range rejection |
| `vkCmdDrawIndexedIndirect` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab offset-aware indexed indirect command recording | src/driver/vulkan.ab typed buffer offset count and stride ABI | tests/pool/main.ab absolute-firstIndex pooled target exact-pixel rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `vkCmdDrawIndexedIndirect2KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCount` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCount2KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCountAMD` | alias |  | VK_AMD_draw_indirect_count:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCountKHR` | alias |  | VK_KHR_draw_indirect_count:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndirect` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab offset-aware non-indexed indirect command recording | src/driver/vulkan.ab typed buffer offset count and stride ABI | examples/render-to-texture/main.ab nonzero pooled render-pass vertex-indirect rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `vkCmdDrawIndirect2KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndirectByteCount2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndirectByteCountEXT` | definition |  | VK_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCount` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCount2KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCountAMD` | alias |  | VK_AMD_draw_indirect_count:all:all | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCountKHR` | alias |  | VK_KHR_draw_indirect_count:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksEXT` | definition |  | VK_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirect2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectCount2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectCountEXT` | definition |  | VK_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectCountNV` | definition |  | VK_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectEXT` | definition |  | VK_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectNV` | definition |  | VK_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksNV` | definition |  | VK_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMultiEXT` | definition |  | VK_EXT_multi_draw:all:all | unclassified | - | - | - | - |
| `vkCmdDrawMultiIndexedEXT` | definition |  | VK_EXT_multi_draw:all:all | unclassified | - | - | - | - |
| `vkCmdEncodeVideoKHR` | definition |  | VK_KHR_video_encode_queue:all:all | unclassified | - | - | - | - |
| `vkCmdEndConditionalRenderingEXT` | definition |  | VK_EXT_conditional_rendering:all:all | unclassified | - | - | - | - |
| `vkCmdEndDebugUtilsLabelEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkCmdEndGpaSampleAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkCmdEndGpaSessionAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkCmdEndPerTileExecutionQCOM` | definition |  | VK_QCOM_tile_shading:all:all | unclassified | - | - | - | - |
| `vkCmdEndQuery` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdEndQueryIndexedEXT` | definition |  | VK_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `vkCmdEndRenderPass` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab legacy render-pass completion | src/driver/vulkan.ab typed command-buffer ABI | tests/application/main.ab repeated MRT multisample and subpass completion | tests/application/main.ab invalid pass rejected before recording |
| `vkCmdEndRenderPass2` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkCmdEndRenderPass2KHR` | alias |  | VK_KHR_create_renderpass2:all:all | unclassified | - | - | - | - |
| `vkCmdEndRendering` | definition | VK_VERSION_1_3:+:all |  | common | src/driver/vulkan.ab surfaced dynamic rendering completion | src/driver/vulkan.ab typed extern signature | tests/vulkan_window/main.ab repeated dynamic presentation | tests/vulkan_window/main.ab forced legacy render-pass fallback |
| `vkCmdEndRendering2EXT` | alias |  | VK_EXT_fragment_density_map_offset:all:all | unclassified | - | - | - | - |
| `vkCmdEndRendering2KHR` | definition |  | VK_KHR_maintenance10:all:all | unclassified | - | - | - | - |
| `vkCmdEndRenderingKHR` | alias |  | VK_KHR_dynamic_rendering:all:all | unclassified | - | - | - | - |
| `vkCmdEndShaderInstrumentationARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkCmdEndTransformFeedback2EXT` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdEndTransformFeedbackEXT` | definition |  | VK_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `vkCmdEndVideoCodingKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkCmdExecuteCommands` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdExecuteGeneratedCommandsEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCmdExecuteGeneratedCommandsNV` | definition |  | VK_NV_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCmdFillBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab GPU buffer fill recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact partial fill readback | tests/application/main.ab alignment range and usage rejection |
| `vkCmdFillMemoryKHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdInitializeGraphScratchMemoryAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkCmdInsertDebugUtilsLabelEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkCmdNextSubpass` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab ordered subpass recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact second-subpass MRT pixels | tests/application/main.ab invalid subpass index rejection |
| `vkCmdNextSubpass2` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkCmdNextSubpass2KHR` | alias |  | VK_KHR_create_renderpass2:all:all | unclassified | - | - | - | - |
| `vkCmdOpticalFlowExecuteNV` | definition |  | VK_NV_optical_flow:all:all | unclassified | - | - | - | - |
| `vkCmdPipelineBarrier` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab image transitions | src/driver/vulkan.ab packed barrier ABI | tests/application/main.ab upload copy resolve and mip transitions | tests/application/main.ab usage validation before recording |
| `vkCmdPipelineBarrier2` | definition | VK_VERSION_1_3:+:all |  | common | src/driver/vulkan.ab synchronization2 transfer barriers | src/driver/vulkan.ab packed DependencyInfo and barrier2 ABIs | tests/vulkan/main.ab validated GPU fill and barrier2 counter | src/driver/vulkan.ab legacy barrier fallback |
| `vkCmdPipelineBarrier2KHR` | alias |  | VK_KHR_synchronization2:all:all | unclassified | - | - | - | - |
| `vkCmdPreprocessGeneratedCommandsEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCmdPreprocessGeneratedCommandsNV` | definition |  | VK_NV_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCmdPushConstants` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reflected compute push recording | src/driver/vulkan.ab typed extern and packed PushConstantRange ABI | tests/application/main.ab exact cross-backend push storage output | tests/application/main.ab wrong stage and byte-size rejection |
| `vkCmdPushConstants2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdPushConstants2KHR` | alias |  | VK_KHR_maintenance6:all:all | unclassified | - | - | - | - |
| `vkCmdPushDataEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSet` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSet2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSet2KHR` | alias |  | VK_KHR_maintenance6:all:all | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetKHR` | alias |  | VK_KHR_push_descriptor:all:all | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplate` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplate2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplate2KHR` | alias |  | VK_KHR_maintenance6:all:all | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplateKHR` | alias |  | VK_KHR_push_descriptor:all:all|VK_KHR_descriptor_update_template:all:all | unclassified | - | - | - | - |
| `vkCmdResetEvent` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdResetEvent2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdResetEvent2KHR` | alias |  | VK_KHR_synchronization2:all:all | unclassified | - | - | - | - |
| `vkCmdResetQueryPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab timestamp reset recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated timestamp samples | tests/application/main.ab invalid query rejection |
| `vkCmdResolveImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab explicit resolve recording | src/driver/vulkan.ab packed resolve ABI | tests/application/main.ab exact multisample resolve | tests/application/main.ab incompatible resolve rejection |
| `vkCmdResolveImage2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdResolveImage2KHR` | alias |  | VK_KHR_copy_commands2:all:all | unclassified | - | - | - | - |
| `vkCmdSetAlphaToCoverageEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetAlphaToOneEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetAttachmentFeedbackLoopEnableEXT` | definition |  | VK_EXT_attachment_feedback_loop_dynamic_state:all:all | unclassified | - | - | - | - |
| `vkCmdSetBlendConstants` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetCheckpointNV` | definition |  | VK_NV_device_diagnostic_checkpoints:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoarseSampleOrderNV` | definition |  | VK_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `vkCmdSetColorBlendAdvancedEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetColorBlendEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetColorBlendEquationEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetColorWriteEnableEXT` | definition |  | VK_EXT_color_write_enable:all:all | unclassified | - | - | - | - |
| `vkCmdSetColorWriteMaskEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetComputeOccupancyPriorityNV` | definition |  | VK_NV_compute_occupancy_priority:all:all | unclassified | - | - | - | - |
| `vkCmdSetConservativeRasterizationModeEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoverageModulationModeNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoverageModulationTableEnableNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoverageModulationTableNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoverageReductionModeNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoverageToColorEnableNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCoverageToColorLocationNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetCullMode` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetCullModeEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthBias` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthBias2EXT` | definition |  | VK_EXT_depth_bias_control:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthBiasEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthBiasEnableEXT` | alias |  | VK_EXT_extended_dynamic_state2:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthBounds` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthBoundsTestEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthBoundsTestEnableEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthClampEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthClampRangeEXT` | definition |  | VK_EXT_shader_object:all:all|VK_EXT_depth_clamp_control:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthClipEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthClipNegativeOneToOneEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthCompareOp` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthCompareOpEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthTestEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthTestEnableEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDepthWriteEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDepthWriteEnableEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetDescriptorBufferOffsets2EXT` | definition |  | VK_KHR_maintenance6:all:all | unclassified | - | - | - | - |
| `vkCmdSetDescriptorBufferOffsetsEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkCmdSetDeviceMask` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetDeviceMaskKHR` | alias |  | VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkCmdSetDiscardRectangleEXT` | definition |  | VK_EXT_discard_rectangles:all:all | unclassified | - | - | - | - |
| `vkCmdSetDiscardRectangleEnableEXT` | definition |  | VK_EXT_discard_rectangles:all:all | unclassified | - | - | - | - |
| `vkCmdSetDiscardRectangleModeEXT` | definition |  | VK_EXT_discard_rectangles:all:all | unclassified | - | - | - | - |
| `vkCmdSetDispatchParametersARM` | definition |  | VK_ARM_scheduling_controls:all:all | unclassified | - | - | - | - |
| `vkCmdSetEvent` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetEvent2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetEvent2KHR` | alias |  | VK_KHR_synchronization2:all:all | unclassified | - | - | - | - |
| `vkCmdSetExclusiveScissorEnableNV` | definition |  | VK_NV_scissor_exclusive:all:all | unclassified | - | - | - | - |
| `vkCmdSetExclusiveScissorNV` | definition |  | VK_NV_scissor_exclusive:all:all | unclassified | - | - | - | - |
| `vkCmdSetExtraPrimitiveOverestimationSizeEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetFragmentShadingRateEnumNV` | definition |  | VK_NV_fragment_shading_rate_enums:all:all | unclassified | - | - | - | - |
| `vkCmdSetFragmentShadingRateKHR` | definition |  | VK_KHR_fragment_shading_rate:all:all | unclassified | - | - | - | - |
| `vkCmdSetFrontFace` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetFrontFaceEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetLineRasterizationModeEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetLineStipple` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetLineStippleEXT` | alias |  | VK_EXT_line_rasterization:all:all | unclassified | - | - | - | - |
| `vkCmdSetLineStippleEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetLineStippleKHR` | alias |  | VK_KHR_line_rasterization:all:all | unclassified | - | - | - | - |
| `vkCmdSetLineWidth` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetLogicOpEXT` | definition |  | VK_EXT_extended_dynamic_state2:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetLogicOpEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetPatchControlPointsEXT` | definition |  | VK_EXT_extended_dynamic_state2:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetPerformanceMarkerINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkCmdSetPerformanceOverrideINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkCmdSetPerformanceStreamMarkerINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkCmdSetPolygonModeEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveRestartEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveRestartEnableEXT` | alias |  | VK_EXT_extended_dynamic_state2:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveRestartIndexEXT` | definition |  | VK_EXT_primitive_restart_index:all:all | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveTopology` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveTopologyEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetProvokingVertexModeEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetRasterizationSamplesEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetRasterizationStreamEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetRasterizerDiscardEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetRasterizerDiscardEnableEXT` | alias |  | VK_EXT_extended_dynamic_state2:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetRayTracingPipelineStackSizeKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkCmdSetRenderingAttachmentLocations` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetRenderingAttachmentLocationsKHR` | alias |  | VK_KHR_dynamic_rendering_local_read:all:all | unclassified | - | - | - | - |
| `vkCmdSetRenderingInputAttachmentIndices` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetRenderingInputAttachmentIndicesKHR` | alias |  | VK_KHR_dynamic_rendering_local_read:all:all | unclassified | - | - | - | - |
| `vkCmdSetRepresentativeFragmentTestEnableNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetSampleLocationsEXT` | definition |  | VK_EXT_sample_locations:all:all | unclassified | - | - | - | - |
| `vkCmdSetSampleLocationsEnableEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetSampleMaskEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetScissor` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab dynamic render scissor state | src/driver/vulkan.ab packed Rect2D array ABI | examples/common-triangle/main.ab repeated full-target draw and resize | tests/application/main.ab invalid target extent rejection |
| `vkCmdSetScissorWithCount` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetScissorWithCountEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetShadingRateImageEnableNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetStencilCompareMask` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetStencilOp` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetStencilOpEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetStencilReference` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetStencilTestEnable` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetStencilTestEnableEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetStencilWriteMask` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetTessellationDomainOriginEXT` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetVertexInputEXT` | definition |  | VK_EXT_vertex_input_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetViewport` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab dynamic render viewport state | src/driver/vulkan.ab packed Viewport array ABI | examples/common-triangle/main.ab resize to exact 640 by 480 | tests/application/main.ab invalid target extent rejection |
| `vkCmdSetViewportShadingRatePaletteNV` | definition |  | VK_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `vkCmdSetViewportSwizzleNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetViewportWScalingEnableNV` | definition |  | VK_EXT_extended_dynamic_state3:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSetViewportWScalingNV` | definition |  | VK_NV_clip_space_w_scaling:all:all | unclassified | - | - | - | - |
| `vkCmdSetViewportWithCount` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdSetViewportWithCountEXT` | alias |  | VK_EXT_extended_dynamic_state:all:all|VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCmdSubpassShadingHUAWEI` | definition |  | VK_HUAWEI_subpass_shading:all:all | unclassified | - | - | - | - |
| `vkCmdTraceRaysIndirect2KHR` | definition |  | VK_KHR_ray_tracing_maintenance1:all:all | unclassified | - | - | - | - |
| `vkCmdTraceRaysIndirectKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkCmdTraceRaysKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkCmdTraceRaysNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkCmdUpdateBuffer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdUpdateMemoryKHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdUpdatePipelineIndirectBufferNV` | definition |  | VK_NV_device_generated_commands_compute:all:all | unclassified | - | - | - | - |
| `vkCmdWaitEvents` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCmdWaitEvents2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdWaitEvents2KHR` | alias |  | VK_KHR_synchronization2:all:all | unclassified | - | - | - | - |
| `vkCmdWriteAccelerationStructuresPropertiesKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCmdWriteAccelerationStructuresPropertiesNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkCmdWriteBufferMarker2AMD` | definition |  | VK_AMD_buffer_marker:all:all | unclassified | - | - | - | - |
| `vkCmdWriteBufferMarkerAMD` | definition |  | VK_AMD_buffer_marker:all:all | unclassified | - | - | - | - |
| `vkCmdWriteMarkerToMemoryAMD` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCmdWriteMicromapsPropertiesEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCmdWriteTimestamp` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab timestamp recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab monotonic timestamp samples | tests/application/main.ab invalid query rejection |
| `vkCmdWriteTimestamp2` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCmdWriteTimestamp2KHR` | alias |  | VK_KHR_synchronization2:all:all | unclassified | - | - | - | - |
| `vkCompileDeferredNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkConvertCooperativeVectorMatrixNV` | definition |  | VK_NV_cooperative_vector:all:all | unclassified | - | - | - | - |
| `vkCopyAccelerationStructureKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCopyAccelerationStructureToMemoryKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCopyImageToImage` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCopyImageToImageEXT` | alias |  | VK_EXT_host_image_copy:all:all | unclassified | - | - | - | - |
| `vkCopyImageToMemory` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCopyImageToMemoryEXT` | alias |  | VK_EXT_host_image_copy:all:all | unclassified | - | - | - | - |
| `vkCopyMemoryToAccelerationStructureKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCopyMemoryToImage` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkCopyMemoryToImageEXT` | alias |  | VK_EXT_host_image_copy:all:all | unclassified | - | - | - | - |
| `vkCopyMemoryToMicromapEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCopyMicromapEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCopyMicromapToMemoryEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCreateAccelerationStructure2KHR` | definition |  | VK_KHR_device_address_commands:all:all | unclassified | - | - | - | - |
| `vkCreateAccelerationStructureKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkCreateAccelerationStructureNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkCreateAndroidSurfaceKHR` | definition |  | VK_KHR_android_surface:android:all | unclassified | - | - | - | - |
| `vkCreateBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine buffer creation | src/driver/vulkan.ab packed BufferCreateInfo ABI | tests/application/main.ab valid transfer and storage buffers | tests/application/main.ab zero-size and oversized buffer rejection |
| `vkCreateBufferCollectionFUCHSIA` | definition |  | VK_FUCHSIA_buffer_collection:fuchsia:all | unclassified | - | - | - | - |
| `vkCreateBufferView` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCreateCommandPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine reusable command-state creation | src/driver/vulkan.ab packed CommandPoolCreateInfo ABI | tests/application/main.ab transfer compute render query and presentation command pools | tests/application/main.ab invalid application rejection |
| `vkCreateComputePipelines` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reflected compute pipeline creation | src/driver/vulkan.ab packed ComputePipelineCreateInfo and specialization ABIs | tests/application/main.ab exact specialized compute dispatch | tests/application/main.ab unsupported and oversized workgroup rejection |
| `vkCreateCuFunctionNVX` | definition |  | VK_NVX_binary_import:all:all | unclassified | - | - | - | - |
| `vkCreateCuModuleNVX` | definition |  | VK_NVX_binary_import:all:all | unclassified | - | - | - | - |
| `vkCreateCudaFunctionNV` | definition |  | VK_NV_cuda_kernel_launch:provisional:all | unclassified | - | - | - | - |
| `vkCreateCudaModuleNV` | definition |  | VK_NV_cuda_kernel_launch:provisional:all | unclassified | - | - | - | - |
| `vkCreateDataGraphPipelineSessionARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkCreateDataGraphPipelinesARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkCreateDebugReportCallbackEXT` | definition |  | VK_EXT_debug_report:all:all | unclassified | - | - | - | - |
| `vkCreateDebugUtilsMessengerEXT` | definition |  | VK_EXT_debug_utils:all:all | common | src/driver/vulkan_debug.ab negotiated debug-utils messenger | src/driver/vulkan_debug.ab packed messenger create ABI and typed indirect call | tests/vulkan/main.ab live messenger and exact submitted message counts | tests/vulkan/main.ab explicitly disabled extension path |
| `vkCreateDeferredOperationKHR` | definition |  | VK_KHR_deferred_host_operations:all:all | unclassified | - | - | - | - |
| `vkCreateDescriptorPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine descriptor-pool creation | src/driver/vulkan.ab packed DescriptorPoolSize and DescriptorPoolCreateInfo ABIs | examples/common-textured/main.ab live sampled bind-group creation | tests/application/main.ab duplicate and wrong-usage binding rejection |
| `vkCreateDescriptorSetLayout` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reflected bind-group layout creation | src/driver/vulkan.ab packed DescriptorSetLayoutBinding and create-info ABIs | tests/application/main.ab sampled uniform and storage layout validation | tests/application/main.ab duplicate binding rejection |
| `vkCreateDescriptorUpdateTemplate` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkCreateDescriptorUpdateTemplateKHR` | alias |  | VK_KHR_descriptor_update_template:all:all | unclassified | - | - | - | - |
| `vkCreateDevice` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab negotiated logical-device creation | src/driver/vulkan.ab packed DeviceQueueCreateInfo DeviceCreateInfo and feature-chain ABIs | tests/vulkan/main.ab compute timeline synchronization2 and dynamic-rendering device | tests/application/main.ab unavailable required feature rejection |
| `vkCreateDirectFBSurfaceEXT` | definition |  | VK_EXT_directfb_surface:directfb:all | unclassified | - | - | - | - |
| `vkCreateDisplayModeKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkCreateDisplayPlaneSurfaceKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkCreateEvent` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCreateExecutionGraphPipelinesAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkCreateExternalComputeQueueNV` | definition |  | VK_NV_external_compute_queue:all:all | unclassified | - | - | - | - |
| `vkCreateFence` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab affine frame and transfer completion fences | src/driver/vulkan.ab packed FenceCreateInfo ABI | tests/transfer/main.ab three stable asynchronous transfer fences | src/driver/vulkan_transfer.ab partial slot creation cleanup |
| `vkCreateFramebuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab target creation | src/driver/vulkan.ab packed framebuffer ABI | tests/application/main.ab MRT multisample framebuffer | tests/application/main.ab incompatible attachment rejection |
| `vkCreateGpaSessionAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkCreateGraphicsPipelines` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reflected graphics pipeline creation | src/driver/vulkan.ab packed shader vertex raster blend depth and dynamic-state ABIs | examples/common-triangle/main.ab live blended depth-tested raster pipelines | examples/common-triangle/main.ab invalid raster depth and vertex layout rejection |
| `vkCreateHeadlessSurfaceEXT` | definition |  | VK_EXT_headless_surface:all:all | unclassified | - | - | - | - |
| `vkCreateIOSSurfaceMVK` | definition |  | VK_MVK_ios_surface:ios:all | unclassified | - | - | - | - |
| `vkCreateImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab texture allocation | src/driver/vulkan.ab packed image creation ABI | tests/application/main.ab texture and target creation | tests/application/main.ab invalid descriptor rejection |
| `vkCreateImagePipeSurfaceFUCHSIA` | definition |  | VK_FUCHSIA_imagepipe_surface:fuchsia:all | unclassified | - | - | - | - |
| `vkCreateImageView` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab texture view creation | src/driver/vulkan.ab packed image view ABI | tests/application/main.ab render and resolve views | tests/application/main.ab incompatible target rejection |
| `vkCreateIndirectCommandsLayoutEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCreateIndirectCommandsLayoutNV` | definition |  | VK_NV_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCreateIndirectExecutionSetEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkCreateInstance` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab negotiated Vulkan instance creation | src/driver/vulkan.ab packed ApplicationInfo and InstanceCreateInfo ABIs | tests/vulkan/main.ab live Vulkan 1.4 instance with debug-utils negotiation | tests/application/main.ab unavailable loader rejection |
| `vkCreateMacOSSurfaceMVK` | definition |  | VK_MVK_macos_surface:macos:all | unclassified | - | - | - | - |
| `vkCreateMetalSurfaceEXT` | definition |  | VK_EXT_metal_surface:metal:all | unclassified | - | - | - | - |
| `vkCreateMicromapEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkCreateOpticalFlowSessionNV` | definition |  | VK_NV_optical_flow:all:all | unclassified | - | - | - | - |
| `vkCreatePipelineBinariesKHR` | definition |  | VK_KHR_pipeline_binary:all:all | unclassified | - | - | - | - |
| `vkCreatePipelineCache` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCreatePipelineLayout` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reflected descriptor and push pipeline layout | src/driver/vulkan.ab packed PipelineLayoutCreateInfo and push-range ABIs | tests/application/main.ab compute render binding and push pipelines | tests/application/main.ab mismatched binding and push rejection |
| `vkCreatePrivateDataSlot` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkCreatePrivateDataSlotEXT` | alias |  | VK_EXT_private_data:all:all | unclassified | - | - | - | - |
| `vkCreateQueryPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab timestamp query creation | src/driver/vulkan.ab packed query-pool ABI | tests/application/main.ab timestamp query creation | tests/application/main.ab invalid application rejection |
| `vkCreateRayTracingPipelinesKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkCreateRayTracingPipelinesNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkCreateRenderPass` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab render-pass creation | src/driver/vulkan.ab packed render-pass ABI | tests/application/main.ab native multisample resolve pass | tests/application/main.ab invalid render operation rejection |
| `vkCreateRenderPass2` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkCreateRenderPass2KHR` | alias |  | VK_KHR_create_renderpass2:all:all | unclassified | - | - | - | - |
| `vkCreateSampler` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine sampler creation | src/driver/vulkan.ab packed SamplerCreateInfo ABI | tests/application/main.ab comparison and anisotropic sampler creation | src/sampler.ab unsupported comparison and anisotropy rejection |
| `vkCreateSamplerYcbcrConversion` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkCreateSamplerYcbcrConversionKHR` | alias |  | VK_KHR_sampler_ycbcr_conversion:all:all | unclassified | - | - | - | - |
| `vkCreateScreenSurfaceQNX` | definition |  | VK_QNX_screen_surface:screen:all | unclassified | - | - | - | - |
| `vkCreateSemaphore` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine binary and timeline semaphore creation | src/driver/vulkan.ab packed SemaphoreCreateInfo and timeline-type ABIs | tests/vulkan_window/main.ab repeated acquire render present synchronization | tests/vulkan/main.ab invalid timeline value rejection |
| `vkCreateShaderInstrumentationARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkCreateShaderModule` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab emitted SPIR-V module creation | src/driver/vulkan.ab packed ShaderModuleCreateInfo and little-endian code ABI | tests/application/main.ab exact compute vertex and fragment pipelines | tests/core.ab invalid SPIR-V module rejection |
| `vkCreateShadersEXT` | definition |  | VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkCreateSharedSwapchainsKHR` | definition |  | VK_KHR_display_swapchain:all:all | unclassified | - | - | - | - |
| `vkCreateStreamDescriptorSurfaceGGP` | definition |  | VK_GGP_stream_descriptor_surface:ggp:all | unclassified | - | - | - | - |
| `vkCreateSurfaceOHOS` | definition |  | VK_OHOS_surface:ohos:all | unclassified | - | - | - | - |
| `vkCreateSwapchainKHR` | definition |  | VK_KHR_swapchain:all:all | common | src/driver/vulkan.ab negotiated surfaced swapchain creation | src/driver/vulkan.ab packed SwapchainCreateInfoKHR ABI | tests/vulkan_window/main.ab live minimum-image dynamic and legacy presentation | tests/application/main.ab stale swapchain recreation |
| `vkCreateTensorARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkCreateTensorViewARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkCreateUbmSurfaceSEC` | definition |  | VK_SEC_ubm_surface:ubm:all | unclassified | - | - | - | - |
| `vkCreateValidationCacheEXT` | definition |  | VK_EXT_validation_cache:all:all | unclassified | - | - | - | - |
| `vkCreateViSurfaceNN` | definition |  | VK_NN_vi_surface:vi:all | unclassified | - | - | - | - |
| `vkCreateVideoSessionKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkCreateVideoSessionParametersKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkCreateWaylandSurfaceKHR` | definition |  | VK_KHR_wayland_surface:wayland:all | unclassified | - | - | - | - |
| `vkCreateWin32SurfaceKHR` | definition |  | VK_KHR_win32_surface:win32:all | unclassified | - | - | - | - |
| `vkCreateXcbSurfaceKHR` | definition |  | VK_KHR_xcb_surface:xcb:all | unclassified | - | - | - | - |
| `vkCreateXlibSurfaceKHR` | definition |  | VK_KHR_xlib_surface:xlib:all | common | src/driver/vulkan.ab pure-Abla X11 Vulkan surface creation | src/driver/vulkan.ab packed XlibSurfaceCreateInfoKHR ABI | tests/vulkan_window/main.ab live visible X11 surface | src/driver/vulkan.ab invalid instance display or window rejection |
| `vkDebugMarkerSetObjectNameEXT` | definition |  | VK_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `vkDebugMarkerSetObjectTagEXT` | definition |  | VK_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `vkDebugReportMessageEXT` | definition |  | VK_EXT_debug_report:all:all | unclassified | - | - | - | - |
| `vkDeferredOperationJoinKHR` | definition |  | VK_KHR_deferred_host_operations:all:all | unclassified | - | - | - | - |
| `vkDestroyAccelerationStructureKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkDestroyAccelerationStructureNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkDestroyBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine buffer lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated buffer lifecycle | tests/application/main.ab invalid buffer descriptor rejection |
| `vkDestroyBufferCollectionFUCHSIA` | definition |  | VK_FUCHSIA_buffer_collection:fuchsia:all | unclassified | - | - | - | - |
| `vkDestroyBufferView` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDestroyCommandPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine command-pool and owned-buffer lifetime | src/driver/vulkan.ab typed extern signature | examples/common-compute/main.ab repeated compute pipeline lifecycle | tests/application/main.ab invalid operation cleanup |
| `vkDestroyCuFunctionNVX` | definition |  | VK_NVX_binary_import:all:all | unclassified | - | - | - | - |
| `vkDestroyCuModuleNVX` | definition |  | VK_NVX_binary_import:all:all | unclassified | - | - | - | - |
| `vkDestroyCudaFunctionNV` | definition |  | VK_NV_cuda_kernel_launch:provisional:all | unclassified | - | - | - | - |
| `vkDestroyCudaModuleNV` | definition |  | VK_NV_cuda_kernel_launch:provisional:all | unclassified | - | - | - | - |
| `vkDestroyDataGraphPipelineSessionARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkDestroyDebugReportCallbackEXT` | definition |  | VK_EXT_debug_report:all:all | unclassified | - | - | - | - |
| `vkDestroyDebugUtilsMessengerEXT` | definition |  | VK_EXT_debug_utils:all:all | common | src/driver/vulkan_debug.ab affine debug messenger lifetime | src/driver/vulkan_debug.ab typed indirect destroy call | tests/vulkan/main.ab stable owned messenger handle | tests/vulkan/main.ab invalid messenger idempotent drop |
| `vkDestroyDeferredOperationKHR` | definition |  | VK_KHR_deferred_host_operations:all:all | unclassified | - | - | - | - |
| `vkDestroyDescriptorPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine descriptor-pool lifetime | src/driver/vulkan.ab typed extern signature | examples/common-textured/main.ab repeated bind-group render lifecycle | tests/application/main.ab invalid bind-group rejection before allocation |
| `vkDestroyDescriptorSetLayout` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine descriptor-layout lifetime | src/driver/vulkan.ab typed extern signature | examples/common-textured/main.ab repeated bind-group render lifecycle | tests/application/main.ab invalid bind-group rejection before allocation |
| `vkDestroyDescriptorUpdateTemplate` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkDestroyDescriptorUpdateTemplateKHR` | alias |  | VK_KHR_descriptor_update_template:all:all | unclassified | - | - | - | - |
| `vkDestroyDevice` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine logical-device lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan/main.ab complete device resource lifecycle | src/driver/vulkan.ab partial device creation cleanup |
| `vkDestroyEvent` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDestroyExternalComputeQueueNV` | definition |  | VK_NV_external_compute_queue:all:all | unclassified | - | - | - | - |
| `vkDestroyFence` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab affine fence lifetime | src/driver/vulkan.ab typed extern signature | tests/transfer/main.ab complete three-slot queue lifecycle | src/driver/vulkan_transfer.ab partial slot cleanup |
| `vkDestroyFramebuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine legacy framebuffer lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab stable target and subpass framebuffer lifecycle | tests/application/main.ab failed target cleanup |
| `vkDestroyGpaSessionAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkDestroyImage` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine texture image lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab sampled transfer and target texture lifecycle | tests/application/main.ab invalid texture descriptor rejection |
| `vkDestroyImageView` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine texture-view lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab valid default reinterpret and target views | tests/application/main.ab incompatible and out-of-range view rejection |
| `vkDestroyIndirectCommandsLayoutEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkDestroyIndirectCommandsLayoutNV` | definition |  | VK_NV_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkDestroyIndirectExecutionSetEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkDestroyInstance` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine instance lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan/main.ab complete debug instance lifecycle | src/driver/vulkan.ab failed initialization cleanup |
| `vkDestroyMicromapEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkDestroyOpticalFlowSessionNV` | definition |  | VK_NV_optical_flow:all:all | unclassified | - | - | - | - |
| `vkDestroyPipeline` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine graphics and compute pipeline lifetime | src/driver/vulkan.ab typed extern signature | examples/common-triangle/main.ab alternate pipeline drop and stable primary pipeline | examples/common-triangle/main.ab invalid pipeline cleanup |
| `vkDestroyPipelineBinaryKHR` | definition |  | VK_KHR_pipeline_binary:all:all | unclassified | - | - | - | - |
| `vkDestroyPipelineCache` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDestroyPipelineLayout` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine pipeline-layout lifetime | src/driver/vulkan.ab typed extern signature | examples/common-triangle/main.ab repeated render pipeline lifecycle | tests/application/main.ab invalid pipeline cleanup |
| `vkDestroyPrivateDataSlot` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkDestroyPrivateDataSlotEXT` | alias |  | VK_EXT_private_data:all:all | unclassified | - | - | - | - |
| `vkDestroyQueryPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab timestamp query lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab affine timestamp query drop | tests/application/main.ab invalid application rejection |
| `vkDestroyRenderPass` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine legacy render-pass lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab stable multisample and subpass render-pass lifecycle | tests/application/main.ab invalid render operation cleanup |
| `vkDestroySampler` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine sampler lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab comparison and anisotropic sampler lifecycle | src/sampler.ab invalid application and descriptor rejection |
| `vkDestroySamplerYcbcrConversion` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkDestroySamplerYcbcrConversionKHR` | alias |  | VK_KHR_sampler_ycbcr_conversion:all:all | unclassified | - | - | - | - |
| `vkDestroySemaphore` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine binary and timeline semaphore lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan_window/main.ab repeated presenter and timeline lifecycle | src/driver/vulkan.ab partial synchronization cleanup |
| `vkDestroyShaderEXT` | definition |  | VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkDestroyShaderInstrumentationARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkDestroyShaderModule` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine shader-module lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab compute and render pipeline shader lifecycle | tests/core.ab invalid SPIR-V rejected before creation |
| `vkDestroySurfaceKHR` | definition |  | VK_KHR_surface:all:all | common | src/driver/vulkan.ab affine X11 surface lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan_window/main.ab complete surfaced application lifecycle | src/driver/vulkan.ab invalid surface cleanup guard |
| `vkDestroySwapchainKHR` | definition |  | VK_KHR_swapchain:all:all | common | src/driver/vulkan.ab affine swapchain image-set lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab two resize-driven swapchain recreations | src/driver/vulkan.ab failed swapchain cleanup |
| `vkDestroyTensorARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkDestroyTensorViewARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkDestroyValidationCacheEXT` | definition |  | VK_EXT_validation_cache:all:all | unclassified | - | - | - | - |
| `vkDestroyVideoSessionKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkDestroyVideoSessionParametersKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkDeviceWaitIdle` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab portable idle wait | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated application waitIdle | tests/application/main.ab invalid application rejection |
| `vkDisplayPowerControlEXT` | definition |  | VK_EXT_display_control:all:all | unclassified | - | - | - | - |
| `vkEndCommandBuffer` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab reusable command recording completion | src/driver/vulkan.ab typed command-buffer result ABI | examples/common-compute/main.ab repeated compute command completion | tests/application/main.ab invalid operation rejected before completion |
| `vkEnumerateDeviceExtensionProperties` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkEnumerateDeviceLayerProperties` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkEnumerateInstanceExtensionProperties` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab debug-utils extension discovery | src/driver/vulkan.ab bounded ExtensionProperties ABI | tests/vulkan/main.ab negotiated extension availability | tests/vulkan/main.ab explicitly disabled extension path |
| `vkEnumerateInstanceLayerProperties` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkEnumerateInstanceVersion` | definition | VK_VERSION_1_1:+:all |  | common | src/driver/vulkan.ab loader API version negotiation | src/driver/vulkan.ab typed version output-pointer ABI | tests/vulkan/main.ab validated Vulkan 1.4 loader version | src/driver/vulkan.ab Vulkan 1.0 fallback on query failure |
| `vkEnumeratePhysicalDeviceGroups` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceGroupsKHR` | alias |  | VK_KHR_device_group_creation:all:all | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceQueueFamilyPerformanceCountersByRegionARM` | definition |  | VK_ARM_performance_counters_by_region:all:all | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR` | definition |  | VK_KHR_performance_query:all:all | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceShaderInstrumentationMetricsARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDevices` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab bounded adapter enumeration | src/driver/vulkan.ab two-call count and handle-array ABI | tests/vulkan/main.ab nonempty named adapter inventory | tests/application/main.ab unavailable adapter rejection |
| `vkExportMetalObjectsEXT` | definition |  | VK_EXT_metal_objects:metal:all | unclassified | - | - | - | - |
| `vkFlushMappedMemoryRanges` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFreeCommandBuffers` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFreeDescriptorSets` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFreeMemory` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab affine buffer memory lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated buffer lifecycle | tests/application/main.ab invalid buffer descriptor rejection |
| `vkGetAccelerationStructureBuildSizesKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkGetAccelerationStructureDeviceAddressKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkGetAccelerationStructureHandleNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkGetAccelerationStructureMemoryRequirementsNV` | definition |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkGetAccelerationStructureOpaqueCaptureDescriptorDataEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetAndroidHardwareBufferPropertiesANDROID` | definition |  | VK_ANDROID_external_memory_android_hardware_buffer:android:all | unclassified | - | - | - | - |
| `vkGetBufferCollectionPropertiesFUCHSIA` | definition |  | VK_FUCHSIA_buffer_collection:fuchsia:all | unclassified | - | - | - | - |
| `vkGetBufferDeviceAddress` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkGetBufferDeviceAddressEXT` | alias |  | VK_EXT_buffer_device_address:all:all | unclassified | - | - | - | - |
| `vkGetBufferDeviceAddressKHR` | alias |  | VK_KHR_buffer_device_address:all:all | unclassified | - | - | - | - |
| `vkGetBufferMemoryRequirements` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab placement-compatible buffer requirement query | src/driver/vulkan.ab packed MemoryRequirements ABI | tests/transfer/main.ab device-local copy buffer requirements | tests/application/main.ab oversized buffer rejection |
| `vkGetBufferMemoryRequirements2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetBufferMemoryRequirements2KHR` | alias |  | VK_KHR_get_memory_requirements2:all:all | unclassified | - | - | - | - |
| `vkGetBufferOpaqueCaptureAddress` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkGetBufferOpaqueCaptureAddressKHR` | alias |  | VK_KHR_buffer_device_address:all:all | unclassified | - | - | - | - |
| `vkGetBufferOpaqueCaptureDescriptorDataEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetCalibratedTimestampsEXT` | alias |  | VK_EXT_calibrated_timestamps:all:all | unclassified | - | - | - | - |
| `vkGetCalibratedTimestampsKHR` | definition |  | VK_KHR_calibrated_timestamps:all:all | unclassified | - | - | - | - |
| `vkGetClusterAccelerationStructureBuildSizesNV` | definition |  | VK_NV_cluster_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkGetCudaModuleCacheNV` | definition |  | VK_NV_cuda_kernel_launch:provisional:all | unclassified | - | - | - | - |
| `vkGetDataGraphPipelineAvailablePropertiesARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkGetDataGraphPipelinePropertiesARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkGetDataGraphPipelineSessionBindPointRequirementsARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkGetDataGraphPipelineSessionMemoryRequirementsARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkGetDeferredOperationMaxConcurrencyKHR` | definition |  | VK_KHR_deferred_host_operations:all:all | unclassified | - | - | - | - |
| `vkGetDeferredOperationResultKHR` | definition |  | VK_KHR_deferred_host_operations:all:all | unclassified | - | - | - | - |
| `vkGetDescriptorEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetDescriptorSetHostMappingVALVE` | definition |  | VK_VALVE_descriptor_set_host_mapping:all:all | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutBindingOffsetEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutHostMappingInfoVALVE` | definition |  | VK_VALVE_descriptor_set_host_mapping:all:all | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutSizeEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutSupport` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutSupportKHR` | alias |  | VK_KHR_maintenance3:all:all | unclassified | - | - | - | - |
| `vkGetDeviceAccelerationStructureCompatibilityKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkGetDeviceBufferMemoryRequirements` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceBufferMemoryRequirementsKHR` | alias |  | VK_KHR_maintenance4:all:all | unclassified | - | - | - | - |
| `vkGetDeviceCombinedImageSamplerIndexNVX` | definition |  | VK_NVX_image_view_handle:all:all | unclassified | - | - | - | - |
| `vkGetDeviceFaultDebugInfoKHR` | definition |  | VK_KHR_device_fault:all:all | unclassified | - | - | - | - |
| `vkGetDeviceFaultInfoEXT` | definition |  | VK_EXT_device_fault:all:all | unclassified | - | - | - | - |
| `vkGetDeviceFaultReportsKHR` | definition |  | VK_KHR_device_fault:all:all | unclassified | - | - | - | - |
| `vkGetDeviceGroupPeerMemoryFeatures` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceGroupPeerMemoryFeaturesKHR` | alias |  | VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkGetDeviceGroupPresentCapabilitiesKHR` | definition |  | VK_KHR_swapchain:all:all|VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkGetDeviceGroupSurfacePresentModes2EXT` | definition |  | VK_EXT_full_screen_exclusive:win32:all | unclassified | - | - | - | - |
| `vkGetDeviceGroupSurfacePresentModesKHR` | definition |  | VK_KHR_swapchain:all:all|VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkGetDeviceImageMemoryRequirements` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceImageMemoryRequirementsKHR` | alias |  | VK_KHR_maintenance4:all:all | unclassified | - | - | - | - |
| `vkGetDeviceImageSparseMemoryRequirements` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceImageSparseMemoryRequirementsKHR` | alias |  | VK_KHR_maintenance4:all:all | unclassified | - | - | - | - |
| `vkGetDeviceImageSubresourceLayout` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceImageSubresourceLayoutKHR` | alias |  | VK_KHR_maintenance5:all:all | unclassified | - | - | - | - |
| `vkGetDeviceMemoryCommitment` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceMemoryOpaqueCaptureAddress` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceMemoryOpaqueCaptureAddressKHR` | alias |  | VK_KHR_buffer_device_address:all:all | unclassified | - | - | - | - |
| `vkGetDeviceMicromapCompatibilityEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkGetDeviceProcAddr` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceQueue` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab selected graphics-compute queue retrieval | src/driver/vulkan.ab typed family index queue index and output ABI | tests/vulkan/main.ab live compute transfer and render queue | src/driver/vulkan.ab invalid queue handle rejects device |
| `vkGetDeviceQueue2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI` | definition |  | VK_HUAWEI_subpass_shading:all:all | unclassified | - | - | - | - |
| `vkGetDeviceTensorMemoryRequirementsARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkGetDisplayModeProperties2KHR` | definition |  | VK_KHR_get_display_properties2:all:all | unclassified | - | - | - | - |
| `vkGetDisplayModePropertiesKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkGetDisplayPlaneCapabilities2KHR` | definition |  | VK_KHR_get_display_properties2:all:all | unclassified | - | - | - | - |
| `vkGetDisplayPlaneCapabilitiesKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkGetDisplayPlaneSupportedDisplaysKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkGetDrmDisplayEXT` | definition |  | VK_EXT_acquire_drm_display:all:all | unclassified | - | - | - | - |
| `vkGetDynamicRenderingTilePropertiesQCOM` | definition |  | VK_QCOM_tile_properties:all:all | unclassified | - | - | - | - |
| `vkGetEncodedVideoSessionParametersKHR` | definition |  | VK_KHR_video_encode_queue:all:all | unclassified | - | - | - | - |
| `vkGetEventStatus` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetExecutionGraphPipelineNodeIndexAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkGetExecutionGraphPipelineScratchSizeAMDX` | definition |  | VK_AMDX_shader_enqueue:provisional:all | unclassified | - | - | - | - |
| `vkGetExternalComputeQueueDataNV` | definition |  | VK_NV_external_compute_queue:all:all | unclassified | - | - | - | - |
| `vkGetFenceFdKHR` | definition |  | VK_KHR_external_fence_fd:all:all | unclassified | - | - | - | - |
| `vkGetFenceStatus` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan_transfer.ab nonblocking transfer-slot completion query | src/driver/vulkan_transfer.ab typed device and fence ABI | tests/transfer/main.ab three queued upload and readback slots | tests/transfer/main.ab stale generation rejection before slot access |
| `vkGetFenceWin32HandleKHR` | definition |  | VK_KHR_external_fence_win32:win32:all | unclassified | - | - | - | - |
| `vkGetFramebufferTilePropertiesQCOM` | definition |  | VK_QCOM_tile_properties:all:all | unclassified | - | - | - | - |
| `vkGetGeneratedCommandsMemoryRequirementsEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkGetGeneratedCommandsMemoryRequirementsNV` | definition |  | VK_NV_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkGetGpaDeviceClockInfoAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkGetGpaSessionResultsAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkGetGpaSessionStatusAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkGetImageDrmFormatModifierPropertiesEXT` | definition |  | VK_EXT_image_drm_format_modifier:all:all | unclassified | - | - | - | - |
| `vkGetImageMemoryRequirements` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab texture memory requirement query | src/driver/vulkan.ab packed MemoryRequirements output ABI | tests/application/main.ab sampled transfer depth and multisample images | tests/application/main.ab invalid size and sample-count rejection |
| `vkGetImageMemoryRequirements2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetImageMemoryRequirements2KHR` | alias |  | VK_KHR_get_memory_requirements2:all:all | unclassified | - | - | - | - |
| `vkGetImageOpaqueCaptureDataEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkGetImageOpaqueCaptureDescriptorDataEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetImageSparseMemoryRequirements` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetImageSparseMemoryRequirements2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetImageSparseMemoryRequirements2KHR` | alias |  | VK_KHR_get_memory_requirements2:all:all | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout2EXT` | alias |  | VK_EXT_host_image_copy:all:all|VK_EXT_image_compression_control:all:all | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout2KHR` | alias |  | VK_KHR_maintenance5:all:all | unclassified | - | - | - | - |
| `vkGetImageViewAddressNVX` | definition |  | VK_NVX_image_view_handle:all:all | unclassified | - | - | - | - |
| `vkGetImageViewHandle64NVX` | definition |  | VK_NVX_image_view_handle:all:all | unclassified | - | - | - | - |
| `vkGetImageViewHandleNVX` | definition |  | VK_NVX_image_view_handle:all:all | unclassified | - | - | - | - |
| `vkGetImageViewOpaqueCaptureDescriptorDataEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetInstanceProcAddr` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan_debug.ab instance extension entry-point loading | stdlib fixed-signature native address calls | tests/vulkan/main.ab create destroy and submit resolution | tests/vulkan/main.ab unavailable or disabled messenger rejection |
| `vkGetLatencyTimingsLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkGetLatencyTimingsNV` | definition |  | VK_NV_low_latency2:all:all | unclassified | - | - | - | - |
| `vkGetMemoryAndroidHardwareBufferANDROID` | definition |  | VK_ANDROID_external_memory_android_hardware_buffer:android:all | unclassified | - | - | - | - |
| `vkGetMemoryFdKHR` | definition |  | VK_KHR_external_memory_fd:all:all | unclassified | - | - | - | - |
| `vkGetMemoryFdPropertiesKHR` | definition |  | VK_KHR_external_memory_fd:all:all | unclassified | - | - | - | - |
| `vkGetMemoryHostPointerPropertiesEXT` | definition |  | VK_EXT_external_memory_host:all:all | unclassified | - | - | - | - |
| `vkGetMemoryMetalHandleEXT` | definition |  | VK_EXT_external_memory_metal:metal:all | unclassified | - | - | - | - |
| `vkGetMemoryMetalHandlePropertiesEXT` | definition |  | VK_EXT_external_memory_metal:metal:all | unclassified | - | - | - | - |
| `vkGetMemoryNativeBufferOHOS` | definition |  | VK_OHOS_external_memory:ohos:all | unclassified | - | - | - | - |
| `vkGetMemoryRemoteAddressNV` | definition |  | VK_NV_external_memory_rdma:all:all | unclassified | - | - | - | - |
| `vkGetMemoryWin32HandleKHR` | definition |  | VK_KHR_external_memory_win32:win32:all | unclassified | - | - | - | - |
| `vkGetMemoryWin32HandleNV` | definition |  | VK_NV_external_memory_win32:win32:all | unclassified | - | - | - | - |
| `vkGetMemoryWin32HandlePropertiesKHR` | definition |  | VK_KHR_external_memory_win32:win32:all | unclassified | - | - | - | - |
| `vkGetMemoryZirconHandleFUCHSIA` | definition |  | VK_FUCHSIA_external_memory:fuchsia:all | unclassified | - | - | - | - |
| `vkGetMemoryZirconHandlePropertiesFUCHSIA` | definition |  | VK_FUCHSIA_external_memory:fuchsia:all | unclassified | - | - | - | - |
| `vkGetMicromapBuildSizesEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkGetNativeBufferPropertiesOHOS` | definition |  | VK_OHOS_external_memory:ohos:all | unclassified | - | - | - | - |
| `vkGetPartitionedAccelerationStructuresBuildSizesNV` | definition |  | VK_NV_partitioned_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkGetPastPresentationTimingEXT` | definition |  | VK_EXT_present_timing:all:all | unclassified | - | - | - | - |
| `vkGetPastPresentationTimingGOOGLE` | definition |  | VK_GOOGLE_display_timing:all:all | unclassified | - | - | - | - |
| `vkGetPerformanceParameterINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCalibrateableTimeDomainsEXT` | alias |  | VK_EXT_calibrated_timestamps:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCalibrateableTimeDomainsKHR` | definition |  | VK_KHR_calibrated_timestamps:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixFlexibleDimensionsPropertiesNV` | definition |  | VK_NV_cooperative_matrix2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixProperties2EXT` | definition |  | VK_EXT_cooperative_matrix_maintenance1:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixPropertiesKHR` | definition |  | VK_KHR_cooperative_matrix:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixPropertiesNV` | definition |  | VK_NV_cooperative_matrix:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeVectorPropertiesNV` | definition |  | VK_NV_cooperative_vector:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDescriptorSizeEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDirectFBPresentationSupportEXT` | definition |  | VK_EXT_directfb_surface:directfb:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayPlaneProperties2KHR` | definition |  | VK_KHR_get_display_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayPlanePropertiesKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayProperties2KHR` | definition |  | VK_KHR_get_display_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayPropertiesKHR` | definition |  | VK_KHR_display:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalBufferProperties` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalBufferPropertiesKHR` | alias |  | VK_KHR_external_memory_capabilities:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalFenceProperties` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalFencePropertiesKHR` | alias |  | VK_KHR_external_fence_capabilities:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalImageFormatPropertiesNV` | definition |  | VK_NV_external_memory_capabilities:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalSemaphoreProperties` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalSemaphorePropertiesKHR` | alias |  | VK_KHR_external_semaphore_capabilities:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalTensorPropertiesARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFeatures` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab base feature availability query | src/driver/vulkan.ab packed PhysicalDeviceFeatures ABI | tests/vulkan/main.ab sampler anisotropy and core feature negotiation | tests/application/main.ab required feature rejection |
| `vkGetPhysicalDeviceFeatures2` | definition | VK_VERSION_1_1:+:all |  | common | src/driver/vulkan.ab promoted feature query | src/driver/vulkan.ab Vulkan 12 and 13 feature-chain ABI | tests/vulkan/main.ab timeline and synchronization2 enablement | src/driver/vulkan.ab core-version gating |
| `vkGetPhysicalDeviceFeatures2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFormatProperties` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFormatProperties2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFormatProperties2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFragmentShadingRatesKHR` | definition |  | VK_KHR_fragment_shading_rate:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceImageFormatProperties` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceImageFormatProperties2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceImageFormatProperties2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceMemoryProperties` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab ranked host-visible and device-local memory-type selection | src/driver/vulkan.ab packed PhysicalDeviceMemoryProperties ABI | tests/transfer/main.ab native device-local flag and exact staged bytes | tests/core.ab unknown placement rejection |
| `vkGetPhysicalDeviceMemoryProperties2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceMemoryProperties2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceMultisamplePropertiesEXT` | definition |  | VK_EXT_sample_locations:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceOpticalFlowImageFormatsNV` | definition |  | VK_NV_optical_flow:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDevicePresentRectanglesKHR` | definition |  | VK_KHR_swapchain:all:all|VK_KHR_device_group:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceProperties` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab adapter identity limits and timestamp query | src/driver/vulkan.ab packed PhysicalDeviceProperties ABI | tests/vulkan/main.ab named adapter compute texture storage and timestamp limits | tests/application/main.ab limit-exceeding resource rejection |
| `vkGetPhysicalDeviceProperties2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceProperties2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphEngineOperationPropertiesARM` | definition |  | VK_ARM_data_graph_instruction_set_tosa:all:all|VK_ARM_data_graph_optical_flow:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphOpticalFlowImageFormatsARM` | definition |  | VK_ARM_data_graph_optical_flow:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphProcessingEnginePropertiesARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphPropertiesARM` | definition |  | VK_ARM_data_graph:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR` | definition |  | VK_KHR_performance_query:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyProperties` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab graphics compute and presentation family selection | src/driver/vulkan.ab two-call count and property-array ABI | tests/vulkan/main.ab valid graphics-compute queue family | tests/application/main.ab unavailable compatible queue rejection |
| `vkGetPhysicalDeviceQueueFamilyProperties2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyProperties2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceScreenPresentationSupportQNX` | definition |  | VK_QNX_screen_surface:screen:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSparseImageFormatProperties` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSparseImageFormatProperties2` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSparseImageFormatProperties2KHR` | alias |  | VK_KHR_get_physical_device_properties2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV` | definition |  | VK_NV_coverage_reduction_mode:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceCapabilities2EXT` | definition |  | VK_EXT_display_surface_counter:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceCapabilities2KHR` | definition |  | VK_KHR_get_surface_capabilities2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceCapabilitiesKHR` | definition |  | VK_KHR_surface:all:all | common | src/driver/vulkan.ab surface extent image-count transform and usage query | src/driver/vulkan.ab packed SurfaceCapabilitiesKHR ABI | tests/vulkan_window/main.ab valid minimum images and supported usage | src/driver/vulkan.ab invalid surface capability rejection |
| `vkGetPhysicalDeviceSurfaceFormats2KHR` | definition |  | VK_KHR_get_surface_capabilities2:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceFormatsKHR` | definition |  | VK_KHR_surface:all:all | common | src/driver/vulkan.ab bounded surface format and color-space enumeration | src/driver/vulkan.ab two-call count and SurfaceFormatKHR array ABI | tests/vulkan_window/main.ab selected live swapchain format | src/driver/vulkan.ab unavailable format rejection |
| `vkGetPhysicalDeviceSurfacePresentModes2EXT` | definition |  | VK_EXT_full_screen_exclusive:win32:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfacePresentModesKHR` | definition |  | VK_KHR_surface:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceSupportKHR` | definition |  | VK_KHR_surface:all:all | common | src/driver/vulkan.ab queue-family surface support query | src/driver/vulkan.ab typed adapter family surface and output ABI | tests/vulkan_window/main.ab supported graphics presentation family | src/driver/vulkan.ab unsupported family rejection |
| `vkGetPhysicalDeviceToolProperties` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceToolPropertiesEXT` | alias |  | VK_EXT_tooling_info:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceUbmPresentationSupportSEC` | definition |  | VK_SEC_ubm_surface:ubm:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceVideoCapabilitiesKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceVideoEncodeQualityLevelPropertiesKHR` | definition |  | VK_KHR_video_encode_queue:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceVideoFormatPropertiesKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceWaylandPresentationSupportKHR` | definition |  | VK_KHR_wayland_surface:wayland:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceWin32PresentationSupportKHR` | definition |  | VK_KHR_win32_surface:win32:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceXcbPresentationSupportKHR` | definition |  | VK_KHR_xcb_surface:xcb:all | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceXlibPresentationSupportKHR` | definition |  | VK_KHR_xlib_surface:xlib:all | common | src/driver/vulkan.ab Xlib visual presentation compatibility query | src/driver/vulkan.ab typed adapter family display and visual ABI | tests/vulkan_window/main.ab live X11 presentation support | src/driver/vulkan.ab invalid display visual or family rejection |
| `vkGetPipelineBinaryDataKHR` | definition |  | VK_KHR_pipeline_binary:all:all | unclassified | - | - | - | - |
| `vkGetPipelineCacheData` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetPipelineExecutableInternalRepresentationsKHR` | definition |  | VK_KHR_pipeline_executable_properties:all:all | unclassified | - | - | - | - |
| `vkGetPipelineExecutablePropertiesKHR` | definition |  | VK_KHR_pipeline_executable_properties:all:all | unclassified | - | - | - | - |
| `vkGetPipelineExecutableStatisticsKHR` | definition |  | VK_KHR_pipeline_executable_properties:all:all | unclassified | - | - | - | - |
| `vkGetPipelineIndirectDeviceAddressNV` | definition |  | VK_NV_device_generated_commands_compute:all:all | unclassified | - | - | - | - |
| `vkGetPipelineIndirectMemoryRequirementsNV` | definition |  | VK_NV_device_generated_commands_compute:all:all | unclassified | - | - | - | - |
| `vkGetPipelineKeyKHR` | definition |  | VK_KHR_pipeline_binary:all:all | unclassified | - | - | - | - |
| `vkGetPipelinePropertiesEXT` | definition |  | VK_EXT_pipeline_properties:all:all | unclassified | - | - | - | - |
| `vkGetPrivateData` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkGetPrivateDataEXT` | alias |  | VK_EXT_private_data:all:all | unclassified | - | - | - | - |
| `vkGetQueryPoolResults` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab timestamp readback | src/driver/vulkan.ab typed extern signature | tests/application/main.ab monotonic timestamp samples | tests/application/main.ab invalid query rejection |
| `vkGetQueueCheckpointData2NV` | definition |  | VK_NV_device_diagnostic_checkpoints:all:all | unclassified | - | - | - | - |
| `vkGetQueueCheckpointDataNV` | definition |  | VK_NV_device_diagnostic_checkpoints:all:all | unclassified | - | - | - | - |
| `vkGetRandROutputDisplayEXT` | definition |  | VK_EXT_acquire_xlib_display:xlib_xrandr:all | unclassified | - | - | - | - |
| `vkGetRayTracingCaptureReplayShaderGroupHandlesKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkGetRayTracingShaderGroupHandlesKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkGetRayTracingShaderGroupHandlesNV` | alias |  | VK_NV_ray_tracing:all:all | unclassified | - | - | - | - |
| `vkGetRayTracingShaderGroupStackSizeKHR` | definition |  | VK_KHR_ray_tracing_pipeline:all:all | unclassified | - | - | - | - |
| `vkGetRefreshCycleDurationGOOGLE` | definition |  | VK_GOOGLE_display_timing:all:all | unclassified | - | - | - | - |
| `vkGetRenderAreaGranularity` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkGetRenderingAreaGranularity` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkGetRenderingAreaGranularityKHR` | alias |  | VK_KHR_maintenance5:all:all | unclassified | - | - | - | - |
| `vkGetSamplerOpaqueCaptureDescriptorDataEXT` | definition |  | VK_EXT_descriptor_buffer:all:all | unclassified | - | - | - | - |
| `vkGetScreenBufferPropertiesQNX` | definition |  | VK_QNX_external_memory_screen_buffer:screen:all | unclassified | - | - | - | - |
| `vkGetSemaphoreCounterValue` | definition | VK_VERSION_1_2:+:all |  | common | src/driver/vulkan.ab timeline counter query | src/driver/vulkan.ab typed extern signature | tests/vulkan/main.ab exact repeated timeline counters | tests/vulkan/main.ab invalid timeline rejection |
| `vkGetSemaphoreCounterValueKHR` | alias |  | VK_KHR_timeline_semaphore:all:all | unclassified | - | - | - | - |
| `vkGetSemaphoreFdKHR` | definition |  | VK_KHR_external_semaphore_fd:all:all | unclassified | - | - | - | - |
| `vkGetSemaphoreWin32HandleKHR` | definition |  | VK_KHR_external_semaphore_win32:win32:all | unclassified | - | - | - | - |
| `vkGetSemaphoreZirconHandleFUCHSIA` | definition |  | VK_FUCHSIA_external_semaphore:fuchsia:all | unclassified | - | - | - | - |
| `vkGetShaderBinaryDataEXT` | definition |  | VK_EXT_shader_object:all:all | unclassified | - | - | - | - |
| `vkGetShaderInfoAMD` | definition |  | VK_AMD_shader_info:all:all | unclassified | - | - | - | - |
| `vkGetShaderInstrumentationValuesARM` | definition |  | VK_ARM_shader_instrumentation:all:all | unclassified | - | - | - | - |
| `vkGetShaderModuleCreateInfoIdentifierEXT` | definition |  | VK_EXT_shader_module_identifier:all:all | unclassified | - | - | - | - |
| `vkGetShaderModuleIdentifierEXT` | definition |  | VK_EXT_shader_module_identifier:all:all | unclassified | - | - | - | - |
| `vkGetSleepStatusLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkGetSwapchainCounterEXT` | definition |  | VK_EXT_display_control:all:all | unclassified | - | - | - | - |
| `vkGetSwapchainImagesKHR` | definition |  | VK_KHR_swapchain:all:all | common | src/driver/vulkan.ab bounded swapchain image enumeration | src/driver/vulkan.ab two-call count and image-array ABI | tests/vulkan_window/main.ab image count at least surface minimum | src/driver/vulkan.ab empty image inventory rejection |
| `vkGetSwapchainStatusKHR` | definition |  | VK_KHR_shared_presentable_image:all:all | unclassified | - | - | - | - |
| `vkGetSwapchainTimeDomainPropertiesEXT` | definition |  | VK_EXT_present_timing:all:all | unclassified | - | - | - | - |
| `vkGetSwapchainTimingPropertiesEXT` | definition |  | VK_EXT_present_timing:all:all | unclassified | - | - | - | - |
| `vkGetTensorMemoryRequirementsARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkGetTensorOpaqueCaptureDataARM` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkGetTensorOpaqueCaptureDescriptorDataARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkGetTensorViewOpaqueCaptureDescriptorDataARM` | definition |  | VK_ARM_tensors:all:all | unclassified | - | - | - | - |
| `vkGetValidationCacheDataEXT` | definition |  | VK_EXT_validation_cache:all:all | unclassified | - | - | - | - |
| `vkGetVideoSessionMemoryRequirementsKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkGetWinrtDisplayNV` | definition |  | VK_NV_acquire_winrt_display:win32:all | unclassified | - | - | - | - |
| `vkImportFenceFdKHR` | definition |  | VK_KHR_external_fence_fd:all:all | unclassified | - | - | - | - |
| `vkImportFenceWin32HandleKHR` | definition |  | VK_KHR_external_fence_win32:win32:all | unclassified | - | - | - | - |
| `vkImportSemaphoreFdKHR` | definition |  | VK_KHR_external_semaphore_fd:all:all | unclassified | - | - | - | - |
| `vkImportSemaphoreWin32HandleKHR` | definition |  | VK_KHR_external_semaphore_win32:win32:all | unclassified | - | - | - | - |
| `vkImportSemaphoreZirconHandleFUCHSIA` | definition |  | VK_FUCHSIA_external_semaphore:fuchsia:all | unclassified | - | - | - | - |
| `vkInitializePerformanceApiINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkInvalidateMappedMemoryRanges` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkLatencySleepLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkLatencySleepNV` | definition |  | VK_NV_low_latency2:all:all | unclassified | - | - | - | - |
| `vkMapMemory` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab mapped-at-creation and reusable coherent read-write mapping | src/driver/vulkan.ab typed aligned memory range flags and mapped-pointer ABI | examples/common-buffer/main.ab allocation-free repeated write and read maps | tests/application/main.ab access nested mapped-use and logical-range rejection |
| `vkMapMemory2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkMapMemory2KHR` | alias |  | VK_KHR_map_memory2:all:all | unclassified | - | - | - | - |
| `vkMergePipelineCaches` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkMergeValidationCachesEXT` | definition |  | VK_EXT_validation_cache:all:all | unclassified | - | - | - | - |
| `vkQueueBeginDebugUtilsLabelEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkQueueBindSparse` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkQueueEndDebugUtilsLabelEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkQueueInsertDebugUtilsLabelEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkQueueNotifyOutOfBandLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkQueueNotifyOutOfBandNV` | definition |  | VK_NV_low_latency2:all:all | unclassified | - | - | - | - |
| `vkQueuePresentKHR` | definition |  | VK_KHR_swapchain:all:all | common | src/driver/vulkan.ab synchronized surfaced presentation | src/driver/vulkan.ab packed PresentInfoKHR ABI | tests/vulkan_window/main.ab repeated dynamic and legacy presentation | tests/application/main.ab suboptimal and out-of-date recovery |
| `vkQueueSetPerfHintQCOM` | definition |  | VK_QCOM_queue_perf_hint:all:all | unclassified | - | - | - | - |
| `vkQueueSetPerformanceConfigurationINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkQueueSubmit` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab legacy transfer compute render and presentation submission | src/driver/vulkan.ab packed SubmitInfo ABI | tests/application/main.ab exact repeated compute transfer and render results | tests/application/main.ab validation failure before queue submission |
| `vkQueueSubmit2` | definition | VK_VERSION_1_3:+:all |  | common | src/driver/vulkan.ab synchronization2 transfer submission | src/driver/vulkan.ab packed SubmitInfo2 ABI | tests/vulkan/main.ab GPU fill and readback with synchronization2 | src/driver/vulkan.ab legacy submit fallback |
| `vkQueueSubmit2KHR` | alias |  | VK_KHR_synchronization2:all:all | unclassified | - | - | - | - |
| `vkQueueWaitIdle` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab bounded legacy queue completion | src/driver/vulkan.ab typed queue result ABI | examples/common-compute/main.ab exact storage readback after completion | tests/application/main.ab invalid application rejection |
| `vkRegisterCustomBorderColorEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkRegisterDeviceEventEXT` | definition |  | VK_EXT_display_control:all:all | unclassified | - | - | - | - |
| `vkRegisterDisplayEventEXT` | definition |  | VK_EXT_display_control:all:all | unclassified | - | - | - | - |
| `vkReleaseCapturedPipelineDataKHR` | definition |  | VK_KHR_pipeline_binary:all:all | unclassified | - | - | - | - |
| `vkReleaseDisplayEXT` | definition |  | VK_EXT_direct_mode_display:all:all | unclassified | - | - | - | - |
| `vkReleaseFullScreenExclusiveModeEXT` | definition |  | VK_EXT_full_screen_exclusive:win32:all | unclassified | - | - | - | - |
| `vkReleasePerformanceConfigurationINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkReleaseProfilingLockKHR` | definition |  | VK_KHR_performance_query:all:all | unclassified | - | - | - | - |
| `vkReleaseSwapchainImagesEXT` | alias |  | VK_EXT_swapchain_maintenance1:all:all | unclassified | - | - | - | - |
| `vkReleaseSwapchainImagesKHR` | definition |  | VK_KHR_swapchain_maintenance1:all:all | unclassified | - | - | - | - |
| `vkResetCommandBuffer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkResetCommandPool` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab allocation-free command-state reuse | src/driver/vulkan.ab typed pool and flags ABI | examples/common-compute/main.ab four repeated zero-growth dispatch rounds | tests/application/main.ab invalid operation rejected before reset |
| `vkResetDescriptorPool` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkResetEvent` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkResetFences` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab reusable frame and transfer fence reset | src/driver/vulkan.ab typed fence-array ABI | tests/transfer/main.ab stable repeated slot submissions | src/driver/vulkan_transfer.ab reset only before validated submission |
| `vkResetGpaSessionAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkResetQueryPool` | definition | VK_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `vkResetQueryPoolEXT` | alias |  | VK_EXT_host_query_reset:all:all | unclassified | - | - | - | - |
| `vkSetBufferCollectionBufferConstraintsFUCHSIA` | definition |  | VK_FUCHSIA_buffer_collection:fuchsia:all | unclassified | - | - | - | - |
| `vkSetBufferCollectionImageConstraintsFUCHSIA` | definition |  | VK_FUCHSIA_buffer_collection:fuchsia:all | unclassified | - | - | - | - |
| `vkSetDebugUtilsObjectNameEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkSetDebugUtilsObjectTagEXT` | definition |  | VK_EXT_debug_utils:all:all | unclassified | - | - | - | - |
| `vkSetDeviceMemoryPriorityEXT` | definition |  | VK_EXT_pageable_device_local_memory:all:all | unclassified | - | - | - | - |
| `vkSetEvent` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkSetGpaDeviceClockModeAMD` | definition |  | VK_AMD_gpa_interface:all:all | unclassified | - | - | - | - |
| `vkSetHdrMetadataEXT` | definition |  | VK_EXT_hdr_metadata:all:all | unclassified | - | - | - | - |
| `vkSetLatencyMarkerLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkSetLatencyMarkerNV` | definition |  | VK_NV_low_latency2:all:all | unclassified | - | - | - | - |
| `vkSetLatencySleepModeLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkSetLatencySleepModeNV` | definition |  | VK_NV_low_latency2:all:all | unclassified | - | - | - | - |
| `vkSetLocalDimmingAMD` | definition |  | VK_AMD_display_native_hdr:all:all | unclassified | - | - | - | - |
| `vkSetPrivateData` | definition | VK_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `vkSetPrivateDataEXT` | alias |  | VK_EXT_private_data:all:all | unclassified | - | - | - | - |
| `vkSetSwapchainPresentTimingQueueSizeEXT` | definition |  | VK_EXT_present_timing:all:all | unclassified | - | - | - | - |
| `vkShutdownLatencyDeviceLegacyNV` | definition |  | VK_NV_low_latency:all:all | unclassified | - | - | - | - |
| `vkSignalSemaphore` | definition | VK_VERSION_1_2:+:all |  | common | src/driver/vulkan.ab timeline host signal | src/driver/vulkan.ab packed semaphore signal ABI | tests/vulkan/main.ab repeated monotonic timeline signals | tests/vulkan/main.ab non-increasing signal rejection |
| `vkSignalSemaphoreKHR` | alias |  | VK_KHR_timeline_semaphore:all:all | unclassified | - | - | - | - |
| `vkSubmitDebugUtilsMessageEXT` | definition |  | VK_EXT_debug_utils:all:all | common | src/driver/vulkan_debug.ab synchronous debug message submission | src/driver/vulkan_debug.ab reusable callback-data ABI and typed indirect call | tests/vulkan/main.ab exact severity and type accounting | tests/vulkan/main.ab invalid masks and empty message rejection |
| `vkTransitionImageLayout` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkTransitionImageLayoutEXT` | alias |  | VK_EXT_host_image_copy:all:all | unclassified | - | - | - | - |
| `vkTrimCommandPool` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkTrimCommandPoolKHR` | alias |  | VK_KHR_maintenance1:all:all | unclassified | - | - | - | - |
| `vkUninitializePerformanceApiINTEL` | definition |  | VK_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `vkUnmapMemory` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab explicit reusable affine and temporary mapping completion | src/driver/vulkan.ab typed device and memory ABI | examples/common-buffer/main.ab repeated write-read unmap with zero growth | tests/application/main.ab repeated unmap and mapped GPU use rejection |
| `vkUnmapMemory2` | definition | VK_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `vkUnmapMemory2KHR` | alias |  | VK_KHR_map_memory2:all:all | unclassified | - | - | - | - |
| `vkUnregisterCustomBorderColorEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkUpdateDescriptorSetWithTemplate` | definition | VK_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `vkUpdateDescriptorSetWithTemplateKHR` | alias |  | VK_KHR_descriptor_update_template:all:all | unclassified | - | - | - | - |
| `vkUpdateDescriptorSets` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab sampled and ranged buffer descriptor writes | src/driver/vulkan.ab packed WriteDescriptorSet image-info and offset buffer-info ABIs | examples/indexed-textured-cube/main.ab nonzero pool uniform range rendering | tests/pool/main.ab misaligned range rejection |
| `vkUpdateIndirectExecutionSetPipelineEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkUpdateIndirectExecutionSetShaderEXT` | definition |  | VK_EXT_device_generated_commands:all:all | unclassified | - | - | - | - |
| `vkUpdateVideoSessionParametersKHR` | definition |  | VK_KHR_video_queue:all:all | unclassified | - | - | - | - |
| `vkWaitForFences` | definition | VK_VERSION_1_0:+:all |  | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab bounded frame and transfer completion wait | src/driver/vulkan.ab typed fence-array wait-all and timeout ABI | tests/transfer/main.ab explicit queued upload and readback waits | tests/transfer/main.ab stale and invalid ticket rejection |
| `vkWaitForPresent2KHR` | definition |  | VK_KHR_present_wait2:all:all | unclassified | - | - | - | - |
| `vkWaitForPresentKHR` | definition |  | VK_KHR_present_wait:all:all | unclassified | - | - | - | - |
| `vkWaitSemaphores` | definition | VK_VERSION_1_2:+:all |  | common | src/driver/vulkan.ab timeline host wait | src/driver/vulkan.ab packed semaphore wait ABI | tests/vulkan/main.ab repeated bounded timeline waits | tests/vulkan/main.ab negative value and timeout rejection |
| `vkWaitSemaphoresKHR` | alias |  | VK_KHR_timeline_semaphore:all:all | unclassified | - | - | - | - |
| `vkWriteAccelerationStructuresPropertiesKHR` | definition |  | VK_KHR_acceleration_structure:all:all | unclassified | - | - | - | - |
| `vkWriteMicromapsPropertiesEXT` | definition |  | VK_EXT_opacity_micromap:all:all | unclassified | - | - | - | - |
| `vkWriteResourceDescriptorsEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |
| `vkWriteSamplerDescriptorsEXT` | definition |  | VK_EXT_descriptor_heap:all:all | unclassified | - | - | - | - |

## Core features

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `VK_VERSION_1_0` | unclassified | - | - | - | - |
| `VK_VERSION_1_1` | unclassified | - | - | - | - |
| `VK_VERSION_1_2` | unclassified | - | - | - | - |
| `VK_VERSION_1_3` | unclassified | - | - | - | - |
| `VK_VERSION_1_4` | unclassified | - | - | - | - |

## Extensions

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `VK_AMDX_dense_geometry_format` | unclassified | - | - | - | - |
| `VK_AMDX_shader_enqueue` | unclassified | - | - | - | - |
| `VK_AMD_anti_lag` | unclassified | - | - | - | - |
| `VK_AMD_buffer_marker` | unclassified | - | - | - | - |
| `VK_AMD_device_coherent_memory` | unclassified | - | - | - | - |
| `VK_AMD_display_native_hdr` | unclassified | - | - | - | - |
| `VK_AMD_draw_indirect_count` | unclassified | - | - | - | - |
| `VK_AMD_gcn_shader` | unclassified | - | - | - | - |
| `VK_AMD_gpa_interface` | unclassified | - | - | - | - |
| `VK_AMD_gpu_shader_half_float` | unclassified | - | - | - | - |
| `VK_AMD_gpu_shader_int16` | unclassified | - | - | - | - |
| `VK_AMD_memory_overallocation_behavior` | unclassified | - | - | - | - |
| `VK_AMD_mixed_attachment_samples` | unclassified | - | - | - | - |
| `VK_AMD_negative_viewport_height` | unclassified | - | - | - | - |
| `VK_AMD_pipeline_compiler_control` | unclassified | - | - | - | - |
| `VK_AMD_rasterization_order` | unclassified | - | - | - | - |
| `VK_AMD_shader_ballot` | unclassified | - | - | - | - |
| `VK_AMD_shader_core_properties` | unclassified | - | - | - | - |
| `VK_AMD_shader_core_properties2` | unclassified | - | - | - | - |
| `VK_AMD_shader_early_and_late_fragment_tests` | unclassified | - | - | - | - |
| `VK_AMD_shader_explicit_vertex_parameter` | unclassified | - | - | - | - |
| `VK_AMD_shader_fragment_mask` | unclassified | - | - | - | - |
| `VK_AMD_shader_image_load_store_lod` | unclassified | - | - | - | - |
| `VK_AMD_shader_info` | unclassified | - | - | - | - |
| `VK_AMD_shader_trinary_minmax` | unclassified | - | - | - | - |
| `VK_AMD_texture_gather_bias_lod` | unclassified | - | - | - | - |
| `VK_ANDROID_external_format_resolve` | unclassified | - | - | - | - |
| `VK_ANDROID_external_memory_android_hardware_buffer` | unclassified | - | - | - | - |
| `VK_ARM_data_graph` | unclassified | - | - | - | - |
| `VK_ARM_data_graph_instruction_set_tosa` | unclassified | - | - | - | - |
| `VK_ARM_data_graph_neural_accelerator_statistics` | unclassified | - | - | - | - |
| `VK_ARM_data_graph_optical_flow` | unclassified | - | - | - | - |
| `VK_ARM_format_pack` | unclassified | - | - | - | - |
| `VK_ARM_performance_counters_by_region` | unclassified | - | - | - | - |
| `VK_ARM_pipeline_opacity_micromap` | unclassified | - | - | - | - |
| `VK_ARM_rasterization_order_attachment_access` | unclassified | - | - | - | - |
| `VK_ARM_render_pass_striped` | unclassified | - | - | - | - |
| `VK_ARM_scheduling_controls` | unclassified | - | - | - | - |
| `VK_ARM_shader_core_builtins` | unclassified | - | - | - | - |
| `VK_ARM_shader_core_properties` | unclassified | - | - | - | - |
| `VK_ARM_shader_instrumentation` | unclassified | - | - | - | - |
| `VK_ARM_tensor_controls` | unclassified | - | - | - | - |
| `VK_ARM_tensors` | unclassified | - | - | - | - |
| `VK_EXT_4444_formats` | unclassified | - | - | - | - |
| `VK_EXT_acquire_drm_display` | unclassified | - | - | - | - |
| `VK_EXT_acquire_xlib_display` | unclassified | - | - | - | - |
| `VK_EXT_astc_decode_mode` | unclassified | - | - | - | - |
| `VK_EXT_attachment_feedback_loop_dynamic_state` | unclassified | - | - | - | - |
| `VK_EXT_attachment_feedback_loop_layout` | unclassified | - | - | - | - |
| `VK_EXT_blend_operation_advanced` | unclassified | - | - | - | - |
| `VK_EXT_border_color_swizzle` | unclassified | - | - | - | - |
| `VK_EXT_buffer_device_address` | unclassified | - | - | - | - |
| `VK_EXT_calibrated_timestamps` | unclassified | - | - | - | - |
| `VK_EXT_color_write_enable` | unclassified | - | - | - | - |
| `VK_EXT_conditional_rendering` | unclassified | - | - | - | - |
| `VK_EXT_conservative_rasterization` | unclassified | - | - | - | - |
| `VK_EXT_cooperative_matrix_maintenance1` | unclassified | - | - | - | - |
| `VK_EXT_custom_border_color` | unclassified | - | - | - | - |
| `VK_EXT_custom_resolve` | unclassified | - | - | - | - |
| `VK_EXT_debug_marker` | unclassified | - | - | - | - |
| `VK_EXT_debug_report` | unclassified | - | - | - | - |
| `VK_EXT_debug_utils` | unclassified | - | - | - | - |
| `VK_EXT_depth_bias_control` | unclassified | - | - | - | - |
| `VK_EXT_depth_clamp_control` | unclassified | - | - | - | - |
| `VK_EXT_depth_clamp_zero_one` | unclassified | - | - | - | - |
| `VK_EXT_depth_clip_control` | unclassified | - | - | - | - |
| `VK_EXT_depth_clip_enable` | unclassified | - | - | - | - |
| `VK_EXT_depth_range_unrestricted` | unclassified | - | - | - | - |
| `VK_EXT_descriptor_buffer` | unclassified | - | - | - | - |
| `VK_EXT_descriptor_heap` | unclassified | - | - | - | - |
| `VK_EXT_descriptor_indexing` | unclassified | - | - | - | - |
| `VK_EXT_device_address_binding_report` | unclassified | - | - | - | - |
| `VK_EXT_device_fault` | unclassified | - | - | - | - |
| `VK_EXT_device_generated_commands` | unclassified | - | - | - | - |
| `VK_EXT_device_memory_report` | unclassified | - | - | - | - |
| `VK_EXT_direct_mode_display` | unclassified | - | - | - | - |
| `VK_EXT_directfb_surface` | unclassified | - | - | - | - |
| `VK_EXT_discard_rectangles` | unclassified | - | - | - | - |
| `VK_EXT_display_control` | unclassified | - | - | - | - |
| `VK_EXT_display_surface_counter` | unclassified | - | - | - | - |
| `VK_EXT_dynamic_rendering_unused_attachments` | unclassified | - | - | - | - |
| `VK_EXT_extended_dynamic_state` | unclassified | - | - | - | - |
| `VK_EXT_extended_dynamic_state2` | unclassified | - | - | - | - |
| `VK_EXT_extended_dynamic_state3` | unclassified | - | - | - | - |
| `VK_EXT_external_memory_acquire_unmodified` | unclassified | - | - | - | - |
| `VK_EXT_external_memory_dma_buf` | unclassified | - | - | - | - |
| `VK_EXT_external_memory_host` | unclassified | - | - | - | - |
| `VK_EXT_external_memory_metal` | unclassified | - | - | - | - |
| `VK_EXT_filter_cubic` | unclassified | - | - | - | - |
| `VK_EXT_fragment_density_map` | unclassified | - | - | - | - |
| `VK_EXT_fragment_density_map2` | unclassified | - | - | - | - |
| `VK_EXT_fragment_density_map_offset` | unclassified | - | - | - | - |
| `VK_EXT_fragment_shader_interlock` | unclassified | - | - | - | - |
| `VK_EXT_frame_boundary` | unclassified | - | - | - | - |
| `VK_EXT_full_screen_exclusive` | unclassified | - | - | - | - |
| `VK_EXT_global_priority` | unclassified | - | - | - | - |
| `VK_EXT_global_priority_query` | unclassified | - | - | - | - |
| `VK_EXT_graphics_pipeline_library` | unclassified | - | - | - | - |
| `VK_EXT_hdr_metadata` | unclassified | - | - | - | - |
| `VK_EXT_headless_surface` | unclassified | - | - | - | - |
| `VK_EXT_host_image_copy` | unclassified | - | - | - | - |
| `VK_EXT_host_query_reset` | unclassified | - | - | - | - |
| `VK_EXT_image_2d_view_of_3d` | unclassified | - | - | - | - |
| `VK_EXT_image_compression_control` | unclassified | - | - | - | - |
| `VK_EXT_image_compression_control_swapchain` | unclassified | - | - | - | - |
| `VK_EXT_image_drm_format_modifier` | unclassified | - | - | - | - |
| `VK_EXT_image_robustness` | unclassified | - | - | - | - |
| `VK_EXT_image_sliced_view_of_3d` | unclassified | - | - | - | - |
| `VK_EXT_image_tiling_control` | unclassified | - | - | - | - |
| `VK_EXT_image_view_min_lod` | unclassified | - | - | - | - |
| `VK_EXT_index_type_uint8` | unclassified | - | - | - | - |
| `VK_EXT_inline_uniform_block` | unclassified | - | - | - | - |
| `VK_EXT_layer_settings` | unclassified | - | - | - | - |
| `VK_EXT_legacy_dithering` | unclassified | - | - | - | - |
| `VK_EXT_legacy_vertex_attributes` | unclassified | - | - | - | - |
| `VK_EXT_line_rasterization` | unclassified | - | - | - | - |
| `VK_EXT_load_store_op_none` | unclassified | - | - | - | - |
| `VK_EXT_map_memory_placed` | unclassified | - | - | - | - |
| `VK_EXT_memory_budget` | unclassified | - | - | - | - |
| `VK_EXT_memory_decompression` | unclassified | - | - | - | - |
| `VK_EXT_memory_priority` | unclassified | - | - | - | - |
| `VK_EXT_mesh_shader` | unclassified | - | - | - | - |
| `VK_EXT_metal_objects` | unclassified | - | - | - | - |
| `VK_EXT_metal_surface` | unclassified | - | - | - | - |
| `VK_EXT_multi_draw` | unclassified | - | - | - | - |
| `VK_EXT_multisampled_render_to_single_sampled` | unclassified | - | - | - | - |
| `VK_EXT_multisampled_render_to_swapchain` | unclassified | - | - | - | - |
| `VK_EXT_mutable_descriptor_type` | unclassified | - | - | - | - |
| `VK_EXT_nested_command_buffer` | unclassified | - | - | - | - |
| `VK_EXT_non_seamless_cube_map` | unclassified | - | - | - | - |
| `VK_EXT_opacity_micromap` | unclassified | - | - | - | - |
| `VK_EXT_pageable_device_local_memory` | unclassified | - | - | - | - |
| `VK_EXT_pci_bus_info` | unclassified | - | - | - | - |
| `VK_EXT_physical_device_drm` | unclassified | - | - | - | - |
| `VK_EXT_pipeline_creation_cache_control` | unclassified | - | - | - | - |
| `VK_EXT_pipeline_creation_feedback` | unclassified | - | - | - | - |
| `VK_EXT_pipeline_library_group_handles` | unclassified | - | - | - | - |
| `VK_EXT_pipeline_properties` | unclassified | - | - | - | - |
| `VK_EXT_pipeline_protected_access` | unclassified | - | - | - | - |
| `VK_EXT_pipeline_robustness` | unclassified | - | - | - | - |
| `VK_EXT_post_depth_coverage` | unclassified | - | - | - | - |
| `VK_EXT_present_mode_fifo_latest_ready` | unclassified | - | - | - | - |
| `VK_EXT_present_timing` | unclassified | - | - | - | - |
| `VK_EXT_primitive_restart_index` | unclassified | - | - | - | - |
| `VK_EXT_primitive_topology_list_restart` | unclassified | - | - | - | - |
| `VK_EXT_primitives_generated_query` | unclassified | - | - | - | - |
| `VK_EXT_private_data` | unclassified | - | - | - | - |
| `VK_EXT_provoking_vertex` | unclassified | - | - | - | - |
| `VK_EXT_queue_family_foreign` | unclassified | - | - | - | - |
| `VK_EXT_rasterization_order_attachment_access` | unclassified | - | - | - | - |
| `VK_EXT_ray_tracing_invocation_reorder` | unclassified | - | - | - | - |
| `VK_EXT_rgba10x6_formats` | unclassified | - | - | - | - |
| `VK_EXT_robustness2` | unclassified | - | - | - | - |
| `VK_EXT_sample_locations` | unclassified | - | - | - | - |
| `VK_EXT_sampler_filter_minmax` | unclassified | - | - | - | - |
| `VK_EXT_scalar_block_layout` | unclassified | - | - | - | - |
| `VK_EXT_separate_stencil_usage` | unclassified | - | - | - | - |
| `VK_EXT_shader_64bit_indexing` | unclassified | - | - | - | - |
| `VK_EXT_shader_atomic_float` | unclassified | - | - | - | - |
| `VK_EXT_shader_atomic_float2` | unclassified | - | - | - | - |
| `VK_EXT_shader_demote_to_helper_invocation` | unclassified | - | - | - | - |
| `VK_EXT_shader_float8` | unclassified | - | - | - | - |
| `VK_EXT_shader_image_atomic_int64` | unclassified | - | - | - | - |
| `VK_EXT_shader_long_vector` | unclassified | - | - | - | - |
| `VK_EXT_shader_module_identifier` | unclassified | - | - | - | - |
| `VK_EXT_shader_object` | unclassified | - | - | - | - |
| `VK_EXT_shader_ocp_microscaling_types` | unclassified | - | - | - | - |
| `VK_EXT_shader_replicated_composites` | unclassified | - | - | - | - |
| `VK_EXT_shader_split_barrier` | unclassified | - | - | - | - |
| `VK_EXT_shader_stencil_export` | unclassified | - | - | - | - |
| `VK_EXT_shader_subgroup_ballot` | unclassified | - | - | - | - |
| `VK_EXT_shader_subgroup_partitioned` | unclassified | - | - | - | - |
| `VK_EXT_shader_subgroup_vote` | unclassified | - | - | - | - |
| `VK_EXT_shader_tile_image` | unclassified | - | - | - | - |
| `VK_EXT_shader_uniform_buffer_unsized_array` | unclassified | - | - | - | - |
| `VK_EXT_shader_viewport_index_layer` | unclassified | - | - | - | - |
| `VK_EXT_subgroup_size_control` | unclassified | - | - | - | - |
| `VK_EXT_subpass_merge_feedback` | unclassified | - | - | - | - |
| `VK_EXT_surface_maintenance1` | unclassified | - | - | - | - |
| `VK_EXT_swapchain_colorspace` | unclassified | - | - | - | - |
| `VK_EXT_swapchain_maintenance1` | unclassified | - | - | - | - |
| `VK_EXT_texel_buffer_alignment` | unclassified | - | - | - | - |
| `VK_EXT_texture_compression_astc_3d` | unclassified | - | - | - | - |
| `VK_EXT_texture_compression_astc_hdr` | unclassified | - | - | - | - |
| `VK_EXT_tooling_info` | unclassified | - | - | - | - |
| `VK_EXT_transform_feedback` | unclassified | - | - | - | - |
| `VK_EXT_validation_cache` | unclassified | - | - | - | - |
| `VK_EXT_validation_features` | unclassified | - | - | - | - |
| `VK_EXT_validation_flags` | unclassified | - | - | - | - |
| `VK_EXT_vertex_attribute_divisor` | unclassified | - | - | - | - |
| `VK_EXT_vertex_attribute_robustness` | unclassified | - | - | - | - |
| `VK_EXT_vertex_input_dynamic_state` | unclassified | - | - | - | - |
| `VK_EXT_ycbcr_2plane_444_formats` | unclassified | - | - | - | - |
| `VK_EXT_ycbcr_image_arrays` | unclassified | - | - | - | - |
| `VK_EXT_zero_initialize_device_memory` | unclassified | - | - | - | - |
| `VK_FUCHSIA_buffer_collection` | unclassified | - | - | - | - |
| `VK_FUCHSIA_external_memory` | unclassified | - | - | - | - |
| `VK_FUCHSIA_external_semaphore` | unclassified | - | - | - | - |
| `VK_FUCHSIA_imagepipe_surface` | unclassified | - | - | - | - |
| `VK_GGP_frame_token` | unclassified | - | - | - | - |
| `VK_GGP_stream_descriptor_surface` | unclassified | - | - | - | - |
| `VK_GOOGLE_decorate_string` | unclassified | - | - | - | - |
| `VK_GOOGLE_display_timing` | unclassified | - | - | - | - |
| `VK_GOOGLE_hlsl_functionality1` | unclassified | - | - | - | - |
| `VK_GOOGLE_surfaceless_query` | unclassified | - | - | - | - |
| `VK_GOOGLE_user_type` | unclassified | - | - | - | - |
| `VK_HUAWEI_cluster_culling_shader` | unclassified | - | - | - | - |
| `VK_HUAWEI_hdr_vivid` | unclassified | - | - | - | - |
| `VK_HUAWEI_invocation_mask` | unclassified | - | - | - | - |
| `VK_HUAWEI_subpass_shading` | unclassified | - | - | - | - |
| `VK_IMG_filter_cubic` | unclassified | - | - | - | - |
| `VK_IMG_filter_linear_2d` | unclassified | - | - | - | - |
| `VK_IMG_format_pvrtc` | unclassified | - | - | - | - |
| `VK_IMG_relaxed_line_rasterization` | unclassified | - | - | - | - |
| `VK_INTEL_performance_query` | unclassified | - | - | - | - |
| `VK_INTEL_shader_integer_functions2` | unclassified | - | - | - | - |
| `VK_KHR_16bit_storage` | unclassified | - | - | - | - |
| `VK_KHR_8bit_storage` | unclassified | - | - | - | - |
| `VK_KHR_acceleration_structure` | unclassified | - | - | - | - |
| `VK_KHR_android_surface` | unclassified | - | - | - | - |
| `VK_KHR_bind_memory2` | unclassified | - | - | - | - |
| `VK_KHR_buffer_device_address` | unclassified | - | - | - | - |
| `VK_KHR_calibrated_timestamps` | unclassified | - | - | - | - |
| `VK_KHR_compute_shader_derivatives` | unclassified | - | - | - | - |
| `VK_KHR_cooperative_matrix` | unclassified | - | - | - | - |
| `VK_KHR_copy_commands2` | unclassified | - | - | - | - |
| `VK_KHR_copy_memory_indirect` | unclassified | - | - | - | - |
| `VK_KHR_create_renderpass2` | unclassified | - | - | - | - |
| `VK_KHR_dedicated_allocation` | unclassified | - | - | - | - |
| `VK_KHR_deferred_host_operations` | unclassified | - | - | - | - |
| `VK_KHR_depth_clamp_zero_one` | unclassified | - | - | - | - |
| `VK_KHR_depth_stencil_resolve` | unclassified | - | - | - | - |
| `VK_KHR_descriptor_update_template` | unclassified | - | - | - | - |
| `VK_KHR_device_address_commands` | unclassified | - | - | - | - |
| `VK_KHR_device_fault` | unclassified | - | - | - | - |
| `VK_KHR_device_group` | unclassified | - | - | - | - |
| `VK_KHR_device_group_creation` | unclassified | - | - | - | - |
| `VK_KHR_display` | unclassified | - | - | - | - |
| `VK_KHR_display_swapchain` | unclassified | - | - | - | - |
| `VK_KHR_draw_indirect_count` | unclassified | - | - | - | - |
| `VK_KHR_driver_properties` | unclassified | - | - | - | - |
| `VK_KHR_dynamic_rendering` | unclassified | - | - | - | - |
| `VK_KHR_dynamic_rendering_local_read` | unclassified | - | - | - | - |
| `VK_KHR_extended_flags` | unclassified | - | - | - | - |
| `VK_KHR_external_fence` | unclassified | - | - | - | - |
| `VK_KHR_external_fence_capabilities` | unclassified | - | - | - | - |
| `VK_KHR_external_fence_fd` | unclassified | - | - | - | - |
| `VK_KHR_external_fence_win32` | unclassified | - | - | - | - |
| `VK_KHR_external_memory` | unclassified | - | - | - | - |
| `VK_KHR_external_memory_capabilities` | unclassified | - | - | - | - |
| `VK_KHR_external_memory_fd` | unclassified | - | - | - | - |
| `VK_KHR_external_memory_win32` | unclassified | - | - | - | - |
| `VK_KHR_external_semaphore` | unclassified | - | - | - | - |
| `VK_KHR_external_semaphore_capabilities` | unclassified | - | - | - | - |
| `VK_KHR_external_semaphore_fd` | unclassified | - | - | - | - |
| `VK_KHR_external_semaphore_win32` | unclassified | - | - | - | - |
| `VK_KHR_format_feature_flags2` | unclassified | - | - | - | - |
| `VK_KHR_fragment_shader_barycentric` | unclassified | - | - | - | - |
| `VK_KHR_fragment_shading_rate` | unclassified | - | - | - | - |
| `VK_KHR_get_display_properties2` | unclassified | - | - | - | - |
| `VK_KHR_get_memory_requirements2` | unclassified | - | - | - | - |
| `VK_KHR_get_physical_device_properties2` | unclassified | - | - | - | - |
| `VK_KHR_get_surface_capabilities2` | unclassified | - | - | - | - |
| `VK_KHR_global_priority` | unclassified | - | - | - | - |
| `VK_KHR_image_format_list` | unclassified | - | - | - | - |
| `VK_KHR_imageless_framebuffer` | unclassified | - | - | - | - |
| `VK_KHR_incremental_present` | unclassified | - | - | - | - |
| `VK_KHR_index_type_uint8` | unclassified | - | - | - | - |
| `VK_KHR_internally_synchronized_queues` | unclassified | - | - | - | - |
| `VK_KHR_line_rasterization` | unclassified | - | - | - | - |
| `VK_KHR_load_store_op_none` | unclassified | - | - | - | - |
| `VK_KHR_maintenance1` | unclassified | - | - | - | - |
| `VK_KHR_maintenance10` | unclassified | - | - | - | - |
| `VK_KHR_maintenance11` | unclassified | - | - | - | - |
| `VK_KHR_maintenance2` | unclassified | - | - | - | - |
| `VK_KHR_maintenance3` | unclassified | - | - | - | - |
| `VK_KHR_maintenance4` | unclassified | - | - | - | - |
| `VK_KHR_maintenance5` | unclassified | - | - | - | - |
| `VK_KHR_maintenance6` | unclassified | - | - | - | - |
| `VK_KHR_maintenance7` | unclassified | - | - | - | - |
| `VK_KHR_maintenance8` | unclassified | - | - | - | - |
| `VK_KHR_maintenance9` | unclassified | - | - | - | - |
| `VK_KHR_map_memory2` | unclassified | - | - | - | - |
| `VK_KHR_multiview` | unclassified | - | - | - | - |
| `VK_KHR_opacity_micromap` | unclassified | - | - | - | - |
| `VK_KHR_performance_query` | unclassified | - | - | - | - |
| `VK_KHR_pipeline_binary` | unclassified | - | - | - | - |
| `VK_KHR_pipeline_executable_properties` | unclassified | - | - | - | - |
| `VK_KHR_pipeline_library` | unclassified | - | - | - | - |
| `VK_KHR_portability_enumeration` | unclassified | - | - | - | - |
| `VK_KHR_portability_subset` | unclassified | - | - | - | - |
| `VK_KHR_present_id` | unclassified | - | - | - | - |
| `VK_KHR_present_id2` | unclassified | - | - | - | - |
| `VK_KHR_present_mode_fifo_latest_ready` | unclassified | - | - | - | - |
| `VK_KHR_present_wait` | unclassified | - | - | - | - |
| `VK_KHR_present_wait2` | unclassified | - | - | - | - |
| `VK_KHR_push_descriptor` | unclassified | - | - | - | - |
| `VK_KHR_ray_query` | unclassified | - | - | - | - |
| `VK_KHR_ray_tracing_maintenance1` | unclassified | - | - | - | - |
| `VK_KHR_ray_tracing_pipeline` | unclassified | - | - | - | - |
| `VK_KHR_ray_tracing_position_fetch` | unclassified | - | - | - | - |
| `VK_KHR_relaxed_block_layout` | unclassified | - | - | - | - |
| `VK_KHR_robustness2` | unclassified | - | - | - | - |
| `VK_KHR_sampler_mirror_clamp_to_edge` | unclassified | - | - | - | - |
| `VK_KHR_sampler_ycbcr_conversion` | unclassified | - | - | - | - |
| `VK_KHR_separate_depth_stencil_layouts` | unclassified | - | - | - | - |
| `VK_KHR_shader_abort` | unclassified | - | - | - | - |
| `VK_KHR_shader_atomic_int64` | unclassified | - | - | - | - |
| `VK_KHR_shader_bfloat16` | unclassified | - | - | - | - |
| `VK_KHR_shader_clock` | unclassified | - | - | - | - |
| `VK_KHR_shader_constant_data` | unclassified | - | - | - | - |
| `VK_KHR_shader_draw_parameters` | unclassified | - | - | - | - |
| `VK_KHR_shader_expect_assume` | unclassified | - | - | - | - |
| `VK_KHR_shader_float16_int8` | unclassified | - | - | - | - |
| `VK_KHR_shader_float_controls` | unclassified | - | - | - | - |
| `VK_KHR_shader_float_controls2` | unclassified | - | - | - | - |
| `VK_KHR_shader_fma` | unclassified | - | - | - | - |
| `VK_KHR_shader_integer_dot_product` | unclassified | - | - | - | - |
| `VK_KHR_shader_maximal_reconvergence` | unclassified | - | - | - | - |
| `VK_KHR_shader_non_semantic_info` | unclassified | - | - | - | - |
| `VK_KHR_shader_quad_control` | unclassified | - | - | - | - |
| `VK_KHR_shader_relaxed_extended_instruction` | unclassified | - | - | - | - |
| `VK_KHR_shader_subgroup_extended_types` | unclassified | - | - | - | - |
| `VK_KHR_shader_subgroup_rotate` | unclassified | - | - | - | - |
| `VK_KHR_shader_subgroup_uniform_control_flow` | unclassified | - | - | - | - |
| `VK_KHR_shader_terminate_invocation` | unclassified | - | - | - | - |
| `VK_KHR_shader_untyped_pointers` | unclassified | - | - | - | - |
| `VK_KHR_shared_presentable_image` | unclassified | - | - | - | - |
| `VK_KHR_spirv_1_4` | unclassified | - | - | - | - |
| `VK_KHR_storage_buffer_storage_class` | unclassified | - | - | - | - |
| `VK_KHR_surface` | unclassified | - | - | - | - |
| `VK_KHR_surface_maintenance1` | unclassified | - | - | - | - |
| `VK_KHR_surface_protected_capabilities` | unclassified | - | - | - | - |
| `VK_KHR_swapchain` | unclassified | - | - | - | - |
| `VK_KHR_swapchain_maintenance1` | unclassified | - | - | - | - |
| `VK_KHR_swapchain_mutable_format` | unclassified | - | - | - | - |
| `VK_KHR_synchronization2` | unclassified | - | - | - | - |
| `VK_KHR_timeline_semaphore` | unclassified | - | - | - | - |
| `VK_KHR_unified_image_layouts` | unclassified | - | - | - | - |
| `VK_KHR_uniform_buffer_standard_layout` | unclassified | - | - | - | - |
| `VK_KHR_variable_pointers` | unclassified | - | - | - | - |
| `VK_KHR_vertex_attribute_divisor` | unclassified | - | - | - | - |
| `VK_KHR_video_decode_av1` | unclassified | - | - | - | - |
| `VK_KHR_video_decode_h264` | unclassified | - | - | - | - |
| `VK_KHR_video_decode_h265` | unclassified | - | - | - | - |
| `VK_KHR_video_decode_queue` | unclassified | - | - | - | - |
| `VK_KHR_video_decode_vp9` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_av1` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_feedback2` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_h264` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_h265` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_intra_refresh` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_quantization_map` | unclassified | - | - | - | - |
| `VK_KHR_video_encode_queue` | unclassified | - | - | - | - |
| `VK_KHR_video_maintenance1` | unclassified | - | - | - | - |
| `VK_KHR_video_maintenance2` | unclassified | - | - | - | - |
| `VK_KHR_video_queue` | unclassified | - | - | - | - |
| `VK_KHR_vulkan_memory_model` | unclassified | - | - | - | - |
| `VK_KHR_wayland_surface` | unclassified | - | - | - | - |
| `VK_KHR_win32_keyed_mutex` | unclassified | - | - | - | - |
| `VK_KHR_win32_surface` | unclassified | - | - | - | - |
| `VK_KHR_workgroup_memory_explicit_layout` | unclassified | - | - | - | - |
| `VK_KHR_xcb_surface` | unclassified | - | - | - | - |
| `VK_KHR_xlib_surface` | unclassified | - | - | - | - |
| `VK_KHR_zero_initialize_workgroup_memory` | unclassified | - | - | - | - |
| `VK_LUNARG_direct_driver_loading` | unclassified | - | - | - | - |
| `VK_MESA_image_alignment_control` | unclassified | - | - | - | - |
| `VK_MSFT_layered_driver` | unclassified | - | - | - | - |
| `VK_MVK_ios_surface` | unclassified | - | - | - | - |
| `VK_MVK_macos_surface` | unclassified | - | - | - | - |
| `VK_NN_vi_surface` | unclassified | - | - | - | - |
| `VK_NVX_binary_import` | unclassified | - | - | - | - |
| `VK_NVX_image_view_handle` | unclassified | - | - | - | - |
| `VK_NVX_multiview_per_view_attributes` | unclassified | - | - | - | - |
| `VK_NV_acquire_winrt_display` | unclassified | - | - | - | - |
| `VK_NV_clip_space_w_scaling` | unclassified | - | - | - | - |
| `VK_NV_cluster_acceleration_structure` | unclassified | - | - | - | - |
| `VK_NV_command_buffer_inheritance` | unclassified | - | - | - | - |
| `VK_NV_compute_occupancy_priority` | unclassified | - | - | - | - |
| `VK_NV_compute_shader_derivatives` | unclassified | - | - | - | - |
| `VK_NV_cooperative_matrix` | unclassified | - | - | - | - |
| `VK_NV_cooperative_matrix2` | unclassified | - | - | - | - |
| `VK_NV_cooperative_matrix_decode_vector` | unclassified | - | - | - | - |
| `VK_NV_cooperative_vector` | unclassified | - | - | - | - |
| `VK_NV_copy_memory_indirect` | unclassified | - | - | - | - |
| `VK_NV_corner_sampled_image` | unclassified | - | - | - | - |
| `VK_NV_coverage_reduction_mode` | unclassified | - | - | - | - |
| `VK_NV_cuda_kernel_launch` | unclassified | - | - | - | - |
| `VK_NV_dedicated_allocation` | unclassified | - | - | - | - |
| `VK_NV_dedicated_allocation_image_aliasing` | unclassified | - | - | - | - |
| `VK_NV_descriptor_pool_overallocation` | unclassified | - | - | - | - |
| `VK_NV_device_diagnostic_checkpoints` | unclassified | - | - | - | - |
| `VK_NV_device_diagnostics_config` | unclassified | - | - | - | - |
| `VK_NV_device_generated_commands` | unclassified | - | - | - | - |
| `VK_NV_device_generated_commands_compute` | unclassified | - | - | - | - |
| `VK_NV_displacement_micromap` | unclassified | - | - | - | - |
| `VK_NV_display_stereo` | unclassified | - | - | - | - |
| `VK_NV_extended_sparse_address_space` | unclassified | - | - | - | - |
| `VK_NV_external_compute_queue` | unclassified | - | - | - | - |
| `VK_NV_external_memory` | unclassified | - | - | - | - |
| `VK_NV_external_memory_capabilities` | unclassified | - | - | - | - |
| `VK_NV_external_memory_rdma` | unclassified | - | - | - | - |
| `VK_NV_external_memory_win32` | unclassified | - | - | - | - |
| `VK_NV_fill_rectangle` | unclassified | - | - | - | - |
| `VK_NV_fragment_coverage_to_color` | unclassified | - | - | - | - |
| `VK_NV_fragment_shader_barycentric` | unclassified | - | - | - | - |
| `VK_NV_fragment_shading_rate_enums` | unclassified | - | - | - | - |
| `VK_NV_framebuffer_mixed_samples` | unclassified | - | - | - | - |
| `VK_NV_geometry_shader_passthrough` | unclassified | - | - | - | - |
| `VK_NV_glsl_shader` | unclassified | - | - | - | - |
| `VK_NV_inherited_viewport_scissor` | unclassified | - | - | - | - |
| `VK_NV_linear_color_attachment` | unclassified | - | - | - | - |
| `VK_NV_low_latency` | unclassified | - | - | - | - |
| `VK_NV_low_latency2` | unclassified | - | - | - | - |
| `VK_NV_memory_decompression` | unclassified | - | - | - | - |
| `VK_NV_mesh_shader` | unclassified | - | - | - | - |
| `VK_NV_optical_flow` | unclassified | - | - | - | - |
| `VK_NV_partitioned_acceleration_structure` | unclassified | - | - | - | - |
| `VK_NV_per_stage_descriptor_set` | unclassified | - | - | - | - |
| `VK_NV_present_barrier` | unclassified | - | - | - | - |
| `VK_NV_present_metering` | unclassified | - | - | - | - |
| `VK_NV_push_constant_bank` | unclassified | - | - | - | - |
| `VK_NV_raw_access_chains` | unclassified | - | - | - | - |
| `VK_NV_ray_tracing` | unclassified | - | - | - | - |
| `VK_NV_ray_tracing_invocation_reorder` | unclassified | - | - | - | - |
| `VK_NV_ray_tracing_linear_swept_spheres` | unclassified | - | - | - | - |
| `VK_NV_ray_tracing_motion_blur` | unclassified | - | - | - | - |
| `VK_NV_ray_tracing_validation` | unclassified | - | - | - | - |
| `VK_NV_representative_fragment_test` | unclassified | - | - | - | - |
| `VK_NV_sample_mask_override_coverage` | unclassified | - | - | - | - |
| `VK_NV_scissor_exclusive` | unclassified | - | - | - | - |
| `VK_NV_shader_atomic_float16_vector` | unclassified | - | - | - | - |
| `VK_NV_shader_image_footprint` | unclassified | - | - | - | - |
| `VK_NV_shader_sm_builtins` | unclassified | - | - | - | - |
| `VK_NV_shader_subgroup_partitioned` | unclassified | - | - | - | - |
| `VK_NV_shading_rate_image` | unclassified | - | - | - | - |
| `VK_NV_viewport_array2` | unclassified | - | - | - | - |
| `VK_NV_viewport_swizzle` | unclassified | - | - | - | - |
| `VK_NV_win32_keyed_mutex` | unclassified | - | - | - | - |
| `VK_OHOS_external_memory` | unclassified | - | - | - | - |
| `VK_OHOS_surface` | unclassified | - | - | - | - |
| `VK_QCOM_cooperative_matrix_conversion` | unclassified | - | - | - | - |
| `VK_QCOM_data_graph_model` | unclassified | - | - | - | - |
| `VK_QCOM_elapsed_timer_query` | unclassified | - | - | - | - |
| `VK_QCOM_filter_cubic_clamp` | unclassified | - | - | - | - |
| `VK_QCOM_filter_cubic_weights` | unclassified | - | - | - | - |
| `VK_QCOM_fragment_density_map_offset` | unclassified | - | - | - | - |
| `VK_QCOM_image_processing` | unclassified | - | - | - | - |
| `VK_QCOM_image_processing2` | unclassified | - | - | - | - |
| `VK_QCOM_image_processing3` | unclassified | - | - | - | - |
| `VK_QCOM_multiview_per_view_render_areas` | unclassified | - | - | - | - |
| `VK_QCOM_multiview_per_view_viewports` | unclassified | - | - | - | - |
| `VK_QCOM_queue_perf_hint` | unclassified | - | - | - | - |
| `VK_QCOM_render_pass_shader_resolve` | unclassified | - | - | - | - |
| `VK_QCOM_render_pass_store_ops` | unclassified | - | - | - | - |
| `VK_QCOM_render_pass_transform` | unclassified | - | - | - | - |
| `VK_QCOM_rotated_copy_commands` | unclassified | - | - | - | - |
| `VK_QCOM_shader_multiple_wait_queues` | unclassified | - | - | - | - |
| `VK_QCOM_tile_memory_heap` | unclassified | - | - | - | - |
| `VK_QCOM_tile_properties` | unclassified | - | - | - | - |
| `VK_QCOM_tile_shading` | unclassified | - | - | - | - |
| `VK_QCOM_ycbcr_degamma` | unclassified | - | - | - | - |
| `VK_QNX_external_memory_screen_buffer` | unclassified | - | - | - | - |
| `VK_QNX_screen_surface` | unclassified | - | - | - | - |
| `VK_SEC_amigo_profiling` | unclassified | - | - | - | - |
| `VK_SEC_pipeline_cache_incremental_mode` | unclassified | - | - | - | - |
| `VK_SEC_throttle_hint` | unclassified | - | - | - | - |
| `VK_SEC_ubm_surface` | unclassified | - | - | - | - |
| `VK_VALVE_descriptor_set_host_mapping` | unclassified | - | - | - | - |
| `VK_VALVE_fragment_density_map_layered` | unclassified | - | - | - | - |
| `VK_VALVE_mutable_descriptor_type` | unclassified | - | - | - | - |
| `VK_VALVE_shader_mixed_float_dot_product` | unclassified | - | - | - | - |
| `VK_VALVE_video_encode_rgb_conversion` | unclassified | - | - | - | - |
