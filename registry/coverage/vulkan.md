# Vulkan registry inventory

- Revision: `090f1b190d60ced4a1d198fd3747d071cc271b1c`
- SHA-256: `65d829561fa4b9e01a15e1327d9e6744f66b025b08c5c7ad13636bf0a8b15c62`
- Commands: 842
- Core features: 5
- Extensions: 473
- Constants: 5633
- Types: 2497
- Command parameters: 2845
- Aggregates: 1450
- Aggregate members: 7413
- Classified commands: 113/842
- Classified core features: 0/5
- Classified extensions: 0/473

## Commands

| Name | Form | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- | --- |
| `vkAcquireDrmDisplayEXT` | definition | unclassified | - | - | - | - |
| `vkAcquireFullScreenExclusiveModeEXT` | definition | unclassified | - | - | - | - |
| `vkAcquireNextImage2KHR` | definition | unclassified | - | - | - | - |
| `vkAcquireNextImageKHR` | definition | common | src/driver/vulkan.ab bounded per-frame swapchain image acquisition | src/driver/vulkan.ab typed swapchain timeout semaphore fence and index ABI | tests/vulkan_window/main.ab repeated surfaced frame acquisition | tests/application/main.ab out-of-date acquisition resize recovery |
| `vkAcquirePerformanceConfigurationINTEL` | definition | unclassified | - | - | - | - |
| `vkAcquireProfilingLockKHR` | definition | unclassified | - | - | - | - |
| `vkAcquireWinrtDisplayNV` | definition | unclassified | - | - | - | - |
| `vkAcquireXlibDisplayEXT` | definition | unclassified | - | - | - | - |
| `vkAllocateCommandBuffers` | definition | common | src/driver/vulkan.ab reusable transfer compute render and query command allocation | src/driver/vulkan.ab packed CommandBufferAllocateInfo ABI | tests/application/main.ab stable command handles across repeated operations | tests/application/main.ab invalid resources rejected before allocation |
| `vkAllocateDescriptorSets` | definition | common | src/driver/vulkan.ab affine bind-group descriptor allocation | src/driver/vulkan.ab packed DescriptorSetAllocateInfo ABI | examples/common-textured/main.ab stable descriptor set across repeated rendering | tests/application/main.ab duplicate binding rejection |
| `vkAllocateMemory` | definition | common | src/driver/vulkan.ab host-visible and device-local buffer memory allocation | src/driver/vulkan.ab packed allocation and memory-properties ABIs | tests/transfer/main.ab exact staged device-local upload and readback | tests/core.ab invalid placement and mapping rejection |
| `vkAntiLagUpdateAMD` | definition | unclassified | - | - | - | - |
| `vkBeginCommandBuffer` | definition | common | src/driver/vulkan.ab reusable command recording begin | src/driver/vulkan.ab packed CommandBufferBeginInfo ABI | examples/common-compute/main.ab repeated compute command recording | tests/application/main.ab invalid dispatch and transfer rejection before recording |
| `vkBindAccelerationStructureMemoryNV` | definition | unclassified | - | - | - | - |
| `vkBindBufferMemory` | definition | common | src/driver/vulkan.ab selected buffer memory binding | src/driver/vulkan.ab typed extern signature | tests/transfer/main.ab device-local transfer destination lifecycle | tests/core.ab invalid device-local mapping rejection |
| `vkBindBufferMemory2` | definition | unclassified | - | - | - | - |
| `vkBindBufferMemory2KHR` | alias | unclassified | - | - | - | - |
| `vkBindDataGraphPipelineSessionMemoryARM` | definition | unclassified | - | - | - | - |
| `vkBindImageMemory` | definition | common | src/driver/vulkan.ab texture memory binding | src/driver/vulkan.ab typed device image memory and offset ABI | tests/application/main.ab exact texture upload and readback | tests/application/main.ab invalid texture descriptor rejection |
| `vkBindImageMemory2` | definition | unclassified | - | - | - | - |
| `vkBindImageMemory2KHR` | alias | unclassified | - | - | - | - |
| `vkBindOpticalFlowSessionImageNV` | definition | unclassified | - | - | - | - |
| `vkBindTensorMemoryARM` | definition | unclassified | - | - | - | - |
| `vkBindVideoSessionMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkBuildAccelerationStructuresKHR` | definition | unclassified | - | - | - | - |
| `vkBuildMicromapsEXT` | definition | unclassified | - | - | - | - |
| `vkClearShaderInstrumentationMetricsARM` | definition | unclassified | - | - | - | - |
| `vkCmdBeginConditionalRendering2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginConditionalRenderingEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginCustomResolveEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginDebugUtilsLabelEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginGpaSampleAMD` | definition | unclassified | - | - | - | - |
| `vkCmdBeginGpaSessionAMD` | definition | unclassified | - | - | - | - |
| `vkCmdBeginPerTileExecutionQCOM` | definition | unclassified | - | - | - | - |
| `vkCmdBeginQuery` | definition | unclassified | - | - | - | - |
| `vkCmdBeginQueryIndexedEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginRenderPass` | definition | common | src/driver/vulkan.ab legacy offscreen and subpass recording | src/driver/vulkan.ab packed RenderPassBeginInfo and clear-value ABIs | tests/application/main.ab exact MRT multisample and two-subpass rendering | tests/application/main.ab invalid pass and attachment rejection |
| `vkCmdBeginRenderPass2` | definition | unclassified | - | - | - | - |
| `vkCmdBeginRenderPass2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdBeginRendering` | definition | common | src/driver/vulkan.ab surfaced dynamic rendering | src/driver/vulkan.ab packed RenderingInfo and attachment ABIs | tests/vulkan_window/main.ab repeated dynamic color rendering | tests/vulkan_window/main.ab forced legacy render-pass fallback |
| `vkCmdBeginRenderingKHR` | alias | unclassified | - | - | - | - |
| `vkCmdBeginShaderInstrumentationARM` | definition | unclassified | - | - | - | - |
| `vkCmdBeginTransformFeedback2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginTransformFeedbackEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBeginVideoCodingKHR` | definition | unclassified | - | - | - | - |
| `vkCmdBindDescriptorBufferEmbeddedSamplers2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindDescriptorBufferEmbeddedSamplersEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindDescriptorBuffersEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindDescriptorSets` | definition | common | src/driver/vulkan.ab render and compute descriptor binding | src/driver/vulkan.ab typed bind-point layout set and offset ABI | examples/common-textured/main.ab repeated indexed sampled rendering | examples/common-textured/main.ab missing shader binding rejection |
| `vkCmdBindDescriptorSets2` | definition | unclassified | - | - | - | - |
| `vkCmdBindDescriptorSets2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdBindIndexBuffer` | definition | common | src/driver/vulkan.ab direct range base and portable absolute-firstIndex indirect binding | src/driver/vulkan.ab typed command buffer handle offset and index-type ABI | examples/render-to-texture/main.ab nonzero pooled direct and indirect index rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `vkCmdBindIndexBuffer2` | definition | unclassified | - | - | - | - |
| `vkCmdBindIndexBuffer2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdBindIndexBuffer3KHR` | definition | unclassified | - | - | - | - |
| `vkCmdBindInvocationMaskHUAWEI` | definition | unclassified | - | - | - | - |
| `vkCmdBindPipeline` | definition | common | src/driver/vulkan.ab graphics and compute pipeline binding | src/driver/vulkan.ab typed bind-point and pipeline ABI | tests/application/main.ab exact compute and render execution | tests/application/main.ab invalid pipeline rejection before recording |
| `vkCmdBindPipelineShaderGroupNV` | definition | unclassified | - | - | - | - |
| `vkCmdBindResourceHeapEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindSamplerHeapEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindShadersEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindShadingRateImageNV` | definition | unclassified | - | - | - | - |
| `vkCmdBindTileMemoryQCOM` | definition | unclassified | - | - | - | - |
| `vkCmdBindTransformFeedbackBuffers2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindTransformFeedbackBuffersEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBindVertexBuffers` | definition | common | src/driver/vulkan.ab offset-aware raster vertex-buffer binding | src/driver/vulkan.ab typed buffer and offset array ABI | examples/push-color/main.ab nonzero pooled target pass and surfaced rendering | tests/pool/main.ab surfaced and offscreen misaligned range rejection |
| `vkCmdBindVertexBuffers2` | definition | unclassified | - | - | - | - |
| `vkCmdBindVertexBuffers2EXT` | alias | unclassified | - | - | - | - |
| `vkCmdBindVertexBuffers3KHR` | definition | unclassified | - | - | - | - |
| `vkCmdBlitImage` | definition | common | src/driver/vulkan.ab mip command recording | src/driver/vulkan.ab packed image blit ABI | tests/application/main.ab exact generated final mip | tests/application/main.ab invalid mip generation rejection |
| `vkCmdBlitImage2` | definition | unclassified | - | - | - | - |
| `vkCmdBlitImage2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdBuildAccelerationStructureNV` | definition | unclassified | - | - | - | - |
| `vkCmdBuildAccelerationStructuresIndirectKHR` | definition | unclassified | - | - | - | - |
| `vkCmdBuildAccelerationStructuresKHR` | definition | unclassified | - | - | - | - |
| `vkCmdBuildClusterAccelerationStructureIndirectNV` | definition | unclassified | - | - | - | - |
| `vkCmdBuildMicromapsEXT` | definition | unclassified | - | - | - | - |
| `vkCmdBuildPartitionedAccelerationStructuresNV` | definition | unclassified | - | - | - | - |
| `vkCmdClearAttachments` | definition | unclassified | - | - | - | - |
| `vkCmdClearColorImage` | definition | common | src/driver/vulkan.ab transfer clear command recording | src/driver/vulkan.ab packed clear color and image-subresource range ABIs | tests/application/main.ab exact repeated render-target and MRT clears | tests/application/main.ab invalid clear attachment rejection |
| `vkCmdClearDepthStencilImage` | definition | unclassified | - | - | - | - |
| `vkCmdControlVideoCodingKHR` | definition | unclassified | - | - | - | - |
| `vkCmdConvertCooperativeVectorMatrixNV` | definition | unclassified | - | - | - | - |
| `vkCmdCopyAccelerationStructureKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyAccelerationStructureNV` | definition | unclassified | - | - | - | - |
| `vkCmdCopyAccelerationStructureToMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyBuffer` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab synchronous and queued buffer copies | src/driver/vulkan.ab packed BufferCopy ABI | tests/transfer/main.ab exact three-slot upload and readback | tests/transfer/main.ab invalid queued range rejection |
| `vkCmdCopyBuffer2` | definition | unclassified | - | - | - | - |
| `vkCmdCopyBuffer2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdCopyBufferToImage` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab texture upload | src/driver/vulkan.ab packed buffer image copy ABI | tests/application/main.ab and tests/wider_texture_transfer/main.ab exact texture upload | tests/application/main.ab upload range rejection |
| `vkCmdCopyBufferToImage2` | definition | unclassified | - | - | - | - |
| `vkCmdCopyBufferToImage2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdCopyGpaSessionResultsAMD` | definition | unclassified | - | - | - | - |
| `vkCmdCopyImage` | definition | common | src/driver/vulkan.ab texture copy | src/driver/vulkan.ab packed image copy ABI | tests/application/main.ab exact texture copy | tests/application/main.ab incompatible copy rejection |
| `vkCmdCopyImage2` | definition | unclassified | - | - | - | - |
| `vkCmdCopyImage2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdCopyImageToBuffer` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab texture readback | src/driver/vulkan.ab packed buffer image copy ABI | tests/application/main.ab and tests/wider_texture_transfer/main.ab exact texture readback | tests/application/main.ab readback range rejection |
| `vkCmdCopyImageToBuffer2` | definition | unclassified | - | - | - | - |
| `vkCmdCopyImageToBuffer2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdCopyImageToMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryIndirectKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryIndirectNV` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToAccelerationStructureKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToImageIndirectKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToImageIndirectNV` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToImageKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMemoryToMicromapEXT` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMicromapEXT` | definition | unclassified | - | - | - | - |
| `vkCmdCopyMicromapToMemoryEXT` | definition | unclassified | - | - | - | - |
| `vkCmdCopyQueryPoolResults` | definition | unclassified | - | - | - | - |
| `vkCmdCopyQueryPoolResultsToMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCmdCopyTensorARM` | definition | unclassified | - | - | - | - |
| `vkCmdCuLaunchKernelNVX` | definition | unclassified | - | - | - | - |
| `vkCmdCudaLaunchKernelNV` | definition | unclassified | - | - | - | - |
| `vkCmdDebugMarkerBeginEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDebugMarkerEndEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDebugMarkerInsertEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDecodeVideoKHR` | definition | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryIndirectCountEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryIndirectCountNV` | definition | unclassified | - | - | - | - |
| `vkCmdDecompressMemoryNV` | definition | unclassified | - | - | - | - |
| `vkCmdDispatch` | definition | common | src/driver/vulkan.ab compute workgroup command recording | src/driver/vulkan.ab typed three-axis group-count ABI | examples/common-compute/main.ab exact storage and push compute output | tests/application/main.ab zero and limit-exceeding dispatch rejection |
| `vkCmdDispatchBase` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchBaseKHR` | alias | unclassified | - | - | - | - |
| `vkCmdDispatchDataGraphARM` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchGraphAMDX` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchGraphIndirectAMDX` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchGraphIndirectCountAMDX` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchIndirect` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchIndirect2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdDispatchTileQCOM` | definition | unclassified | - | - | - | - |
| `vkCmdDraw` | definition | common | src/driver/vulkan.ab render command recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact triangle pixels | tests/application/main.ab invalid vertex range rejection |
| `vkCmdDrawClusterHUAWEI` | definition | unclassified | - | - | - | - |
| `vkCmdDrawClusterIndirectHUAWEI` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndexed` | definition | common | src/driver/vulkan.ab indexed render recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact indexed output | tests/application/main.ab invalid index range rejection |
| `vkCmdDrawIndexedIndirect` | definition | common | src/driver/vulkan.ab offset-aware indexed indirect command recording | src/driver/vulkan.ab typed buffer offset count and stride ABI | tests/pool/main.ab absolute-firstIndex pooled target exact-pixel rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `vkCmdDrawIndexedIndirect2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCount` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCount2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCountAMD` | alias | unclassified | - | - | - | - |
| `vkCmdDrawIndexedIndirectCountKHR` | alias | unclassified | - | - | - | - |
| `vkCmdDrawIndirect` | definition | common | src/driver/vulkan.ab offset-aware non-indexed indirect command recording | src/driver/vulkan.ab typed buffer offset count and stride ABI | examples/render-to-texture/main.ab nonzero pooled render-pass vertex-indirect rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `vkCmdDrawIndirect2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndirectByteCount2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndirectByteCountEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCount` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCount2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCountAMD` | alias | unclassified | - | - | - | - |
| `vkCmdDrawIndirectCountKHR` | alias | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirect2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectCount2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectCountEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectCountNV` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksIndirectNV` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMeshTasksNV` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMultiEXT` | definition | unclassified | - | - | - | - |
| `vkCmdDrawMultiIndexedEXT` | definition | unclassified | - | - | - | - |
| `vkCmdEncodeVideoKHR` | definition | unclassified | - | - | - | - |
| `vkCmdEndConditionalRenderingEXT` | definition | unclassified | - | - | - | - |
| `vkCmdEndDebugUtilsLabelEXT` | definition | unclassified | - | - | - | - |
| `vkCmdEndGpaSampleAMD` | definition | unclassified | - | - | - | - |
| `vkCmdEndGpaSessionAMD` | definition | unclassified | - | - | - | - |
| `vkCmdEndPerTileExecutionQCOM` | definition | unclassified | - | - | - | - |
| `vkCmdEndQuery` | definition | unclassified | - | - | - | - |
| `vkCmdEndQueryIndexedEXT` | definition | unclassified | - | - | - | - |
| `vkCmdEndRenderPass` | definition | common | src/driver/vulkan.ab legacy render-pass completion | src/driver/vulkan.ab typed command-buffer ABI | tests/application/main.ab repeated MRT multisample and subpass completion | tests/application/main.ab invalid pass rejected before recording |
| `vkCmdEndRenderPass2` | definition | unclassified | - | - | - | - |
| `vkCmdEndRenderPass2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdEndRendering` | definition | common | src/driver/vulkan.ab surfaced dynamic rendering completion | src/driver/vulkan.ab typed extern signature | tests/vulkan_window/main.ab repeated dynamic presentation | tests/vulkan_window/main.ab forced legacy render-pass fallback |
| `vkCmdEndRendering2EXT` | alias | unclassified | - | - | - | - |
| `vkCmdEndRendering2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdEndRenderingKHR` | alias | unclassified | - | - | - | - |
| `vkCmdEndShaderInstrumentationARM` | definition | unclassified | - | - | - | - |
| `vkCmdEndTransformFeedback2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdEndTransformFeedbackEXT` | definition | unclassified | - | - | - | - |
| `vkCmdEndVideoCodingKHR` | definition | unclassified | - | - | - | - |
| `vkCmdExecuteCommands` | definition | unclassified | - | - | - | - |
| `vkCmdExecuteGeneratedCommandsEXT` | definition | unclassified | - | - | - | - |
| `vkCmdExecuteGeneratedCommandsNV` | definition | unclassified | - | - | - | - |
| `vkCmdFillBuffer` | definition | common | src/driver/vulkan.ab GPU buffer fill recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact partial fill readback | tests/application/main.ab alignment range and usage rejection |
| `vkCmdFillMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCmdInitializeGraphScratchMemoryAMDX` | definition | unclassified | - | - | - | - |
| `vkCmdInsertDebugUtilsLabelEXT` | definition | unclassified | - | - | - | - |
| `vkCmdNextSubpass` | definition | common | src/driver/vulkan.ab ordered subpass recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab exact second-subpass MRT pixels | tests/application/main.ab invalid subpass index rejection |
| `vkCmdNextSubpass2` | definition | unclassified | - | - | - | - |
| `vkCmdNextSubpass2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdOpticalFlowExecuteNV` | definition | unclassified | - | - | - | - |
| `vkCmdPipelineBarrier` | definition | common | src/driver/vulkan.ab image transitions | src/driver/vulkan.ab packed barrier ABI | tests/application/main.ab upload copy resolve and mip transitions | tests/application/main.ab usage validation before recording |
| `vkCmdPipelineBarrier2` | definition | common | src/driver/vulkan.ab synchronization2 transfer barriers | src/driver/vulkan.ab packed DependencyInfo and barrier2 ABIs | tests/vulkan/main.ab validated GPU fill and barrier2 counter | src/driver/vulkan.ab legacy barrier fallback |
| `vkCmdPipelineBarrier2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdPreprocessGeneratedCommandsEXT` | definition | unclassified | - | - | - | - |
| `vkCmdPreprocessGeneratedCommandsNV` | definition | unclassified | - | - | - | - |
| `vkCmdPushConstants` | definition | common | src/driver/vulkan.ab reflected compute push recording | src/driver/vulkan.ab typed extern and packed PushConstantRange ABI | tests/application/main.ab exact cross-backend push storage output | tests/application/main.ab wrong stage and byte-size rejection |
| `vkCmdPushConstants2` | definition | unclassified | - | - | - | - |
| `vkCmdPushConstants2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdPushDataEXT` | definition | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSet` | definition | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSet2` | definition | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSet2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetKHR` | alias | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplate` | definition | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplate2` | definition | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplate2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdPushDescriptorSetWithTemplateKHR` | alias | unclassified | - | - | - | - |
| `vkCmdResetEvent` | definition | unclassified | - | - | - | - |
| `vkCmdResetEvent2` | definition | unclassified | - | - | - | - |
| `vkCmdResetEvent2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdResetQueryPool` | definition | common | src/driver/vulkan.ab timestamp reset recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated timestamp samples | tests/application/main.ab invalid query rejection |
| `vkCmdResolveImage` | definition | common | src/driver/vulkan.ab explicit resolve recording | src/driver/vulkan.ab packed resolve ABI | tests/application/main.ab exact multisample resolve | tests/application/main.ab incompatible resolve rejection |
| `vkCmdResolveImage2` | definition | unclassified | - | - | - | - |
| `vkCmdResolveImage2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdSetAlphaToCoverageEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetAlphaToOneEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetAttachmentFeedbackLoopEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetBlendConstants` | definition | unclassified | - | - | - | - |
| `vkCmdSetCheckpointNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoarseSampleOrderNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetColorBlendAdvancedEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetColorBlendEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetColorBlendEquationEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetColorWriteEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetColorWriteMaskEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetComputeOccupancyPriorityNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetConservativeRasterizationModeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoverageModulationModeNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoverageModulationTableEnableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoverageModulationTableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoverageReductionModeNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoverageToColorEnableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCoverageToColorLocationNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetCullMode` | definition | unclassified | - | - | - | - |
| `vkCmdSetCullModeEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetDepthBias` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthBias2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthBiasEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthBiasEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetDepthBounds` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthBoundsTestEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthBoundsTestEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetDepthClampEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthClampRangeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthClipEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthClipNegativeOneToOneEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthCompareOp` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthCompareOpEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetDepthTestEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthTestEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetDepthWriteEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetDepthWriteEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetDescriptorBufferOffsets2EXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDescriptorBufferOffsetsEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDeviceMask` | definition | unclassified | - | - | - | - |
| `vkCmdSetDeviceMaskKHR` | alias | unclassified | - | - | - | - |
| `vkCmdSetDiscardRectangleEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDiscardRectangleEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDiscardRectangleModeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetDispatchParametersARM` | definition | unclassified | - | - | - | - |
| `vkCmdSetEvent` | definition | unclassified | - | - | - | - |
| `vkCmdSetEvent2` | definition | unclassified | - | - | - | - |
| `vkCmdSetEvent2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdSetExclusiveScissorEnableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetExclusiveScissorNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetExtraPrimitiveOverestimationSizeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetFragmentShadingRateEnumNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetFragmentShadingRateKHR` | definition | unclassified | - | - | - | - |
| `vkCmdSetFrontFace` | definition | unclassified | - | - | - | - |
| `vkCmdSetFrontFaceEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetLineRasterizationModeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetLineStipple` | definition | unclassified | - | - | - | - |
| `vkCmdSetLineStippleEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetLineStippleEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetLineStippleKHR` | alias | unclassified | - | - | - | - |
| `vkCmdSetLineWidth` | definition | unclassified | - | - | - | - |
| `vkCmdSetLogicOpEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetLogicOpEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetPatchControlPointsEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetPerformanceMarkerINTEL` | definition | unclassified | - | - | - | - |
| `vkCmdSetPerformanceOverrideINTEL` | definition | unclassified | - | - | - | - |
| `vkCmdSetPerformanceStreamMarkerINTEL` | definition | unclassified | - | - | - | - |
| `vkCmdSetPolygonModeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveRestartEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveRestartEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveRestartIndexEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveTopology` | definition | unclassified | - | - | - | - |
| `vkCmdSetPrimitiveTopologyEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetProvokingVertexModeEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetRasterizationSamplesEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetRasterizationStreamEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetRasterizerDiscardEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetRasterizerDiscardEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetRayTracingPipelineStackSizeKHR` | definition | unclassified | - | - | - | - |
| `vkCmdSetRenderingAttachmentLocations` | definition | unclassified | - | - | - | - |
| `vkCmdSetRenderingAttachmentLocationsKHR` | alias | unclassified | - | - | - | - |
| `vkCmdSetRenderingInputAttachmentIndices` | definition | unclassified | - | - | - | - |
| `vkCmdSetRenderingInputAttachmentIndicesKHR` | alias | unclassified | - | - | - | - |
| `vkCmdSetRepresentativeFragmentTestEnableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetSampleLocationsEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetSampleLocationsEnableEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetSampleMaskEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetScissor` | definition | common | src/driver/vulkan.ab dynamic render scissor state | src/driver/vulkan.ab packed Rect2D array ABI | examples/common-triangle/main.ab repeated full-target draw and resize | tests/application/main.ab invalid target extent rejection |
| `vkCmdSetScissorWithCount` | definition | unclassified | - | - | - | - |
| `vkCmdSetScissorWithCountEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetShadingRateImageEnableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetStencilCompareMask` | definition | unclassified | - | - | - | - |
| `vkCmdSetStencilOp` | definition | unclassified | - | - | - | - |
| `vkCmdSetStencilOpEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetStencilReference` | definition | unclassified | - | - | - | - |
| `vkCmdSetStencilTestEnable` | definition | unclassified | - | - | - | - |
| `vkCmdSetStencilTestEnableEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSetStencilWriteMask` | definition | unclassified | - | - | - | - |
| `vkCmdSetTessellationDomainOriginEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetVertexInputEXT` | definition | unclassified | - | - | - | - |
| `vkCmdSetViewport` | definition | common | src/driver/vulkan.ab dynamic render viewport state | src/driver/vulkan.ab packed Viewport array ABI | examples/common-triangle/main.ab resize to exact 640 by 480 | tests/application/main.ab invalid target extent rejection |
| `vkCmdSetViewportShadingRatePaletteNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetViewportSwizzleNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetViewportWScalingEnableNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetViewportWScalingNV` | definition | unclassified | - | - | - | - |
| `vkCmdSetViewportWithCount` | definition | unclassified | - | - | - | - |
| `vkCmdSetViewportWithCountEXT` | alias | unclassified | - | - | - | - |
| `vkCmdSubpassShadingHUAWEI` | definition | unclassified | - | - | - | - |
| `vkCmdTraceRaysIndirect2KHR` | definition | unclassified | - | - | - | - |
| `vkCmdTraceRaysIndirectKHR` | definition | unclassified | - | - | - | - |
| `vkCmdTraceRaysKHR` | definition | unclassified | - | - | - | - |
| `vkCmdTraceRaysNV` | definition | unclassified | - | - | - | - |
| `vkCmdUpdateBuffer` | definition | unclassified | - | - | - | - |
| `vkCmdUpdateMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCmdUpdatePipelineIndirectBufferNV` | definition | unclassified | - | - | - | - |
| `vkCmdWaitEvents` | definition | unclassified | - | - | - | - |
| `vkCmdWaitEvents2` | definition | unclassified | - | - | - | - |
| `vkCmdWaitEvents2KHR` | alias | unclassified | - | - | - | - |
| `vkCmdWriteAccelerationStructuresPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkCmdWriteAccelerationStructuresPropertiesNV` | definition | unclassified | - | - | - | - |
| `vkCmdWriteBufferMarker2AMD` | definition | unclassified | - | - | - | - |
| `vkCmdWriteBufferMarkerAMD` | definition | unclassified | - | - | - | - |
| `vkCmdWriteMarkerToMemoryAMD` | definition | unclassified | - | - | - | - |
| `vkCmdWriteMicromapsPropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkCmdWriteTimestamp` | definition | common | src/driver/vulkan.ab timestamp recording | src/driver/vulkan.ab typed extern signature | tests/application/main.ab monotonic timestamp samples | tests/application/main.ab invalid query rejection |
| `vkCmdWriteTimestamp2` | definition | unclassified | - | - | - | - |
| `vkCmdWriteTimestamp2KHR` | alias | unclassified | - | - | - | - |
| `vkCompileDeferredNV` | definition | unclassified | - | - | - | - |
| `vkConvertCooperativeVectorMatrixNV` | definition | unclassified | - | - | - | - |
| `vkCopyAccelerationStructureKHR` | definition | unclassified | - | - | - | - |
| `vkCopyAccelerationStructureToMemoryKHR` | definition | unclassified | - | - | - | - |
| `vkCopyImageToImage` | definition | unclassified | - | - | - | - |
| `vkCopyImageToImageEXT` | alias | unclassified | - | - | - | - |
| `vkCopyImageToMemory` | definition | unclassified | - | - | - | - |
| `vkCopyImageToMemoryEXT` | alias | unclassified | - | - | - | - |
| `vkCopyMemoryToAccelerationStructureKHR` | definition | unclassified | - | - | - | - |
| `vkCopyMemoryToImage` | definition | unclassified | - | - | - | - |
| `vkCopyMemoryToImageEXT` | alias | unclassified | - | - | - | - |
| `vkCopyMemoryToMicromapEXT` | definition | unclassified | - | - | - | - |
| `vkCopyMicromapEXT` | definition | unclassified | - | - | - | - |
| `vkCopyMicromapToMemoryEXT` | definition | unclassified | - | - | - | - |
| `vkCreateAccelerationStructure2KHR` | definition | unclassified | - | - | - | - |
| `vkCreateAccelerationStructureKHR` | definition | unclassified | - | - | - | - |
| `vkCreateAccelerationStructureNV` | definition | unclassified | - | - | - | - |
| `vkCreateAndroidSurfaceKHR` | definition | unclassified | - | - | - | - |
| `vkCreateBuffer` | definition | common | src/driver/vulkan.ab affine buffer creation | src/driver/vulkan.ab packed BufferCreateInfo ABI | tests/application/main.ab valid transfer and storage buffers | tests/application/main.ab zero-size and oversized buffer rejection |
| `vkCreateBufferCollectionFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkCreateBufferView` | definition | unclassified | - | - | - | - |
| `vkCreateCommandPool` | definition | common | src/driver/vulkan.ab affine reusable command-state creation | src/driver/vulkan.ab packed CommandPoolCreateInfo ABI | tests/application/main.ab transfer compute render query and presentation command pools | tests/application/main.ab invalid application rejection |
| `vkCreateComputePipelines` | definition | common | src/driver/vulkan.ab reflected compute pipeline creation | src/driver/vulkan.ab packed ComputePipelineCreateInfo and specialization ABIs | tests/application/main.ab exact specialized compute dispatch | tests/application/main.ab unsupported and oversized workgroup rejection |
| `vkCreateCuFunctionNVX` | definition | unclassified | - | - | - | - |
| `vkCreateCuModuleNVX` | definition | unclassified | - | - | - | - |
| `vkCreateCudaFunctionNV` | definition | unclassified | - | - | - | - |
| `vkCreateCudaModuleNV` | definition | unclassified | - | - | - | - |
| `vkCreateDataGraphPipelineSessionARM` | definition | unclassified | - | - | - | - |
| `vkCreateDataGraphPipelinesARM` | definition | unclassified | - | - | - | - |
| `vkCreateDebugReportCallbackEXT` | definition | unclassified | - | - | - | - |
| `vkCreateDebugUtilsMessengerEXT` | definition | common | src/driver/vulkan_debug.ab negotiated debug-utils messenger | src/driver/vulkan_debug.ab packed messenger create ABI and typed indirect call | tests/vulkan/main.ab live messenger and exact submitted message counts | tests/vulkan/main.ab explicitly disabled extension path |
| `vkCreateDeferredOperationKHR` | definition | unclassified | - | - | - | - |
| `vkCreateDescriptorPool` | definition | common | src/driver/vulkan.ab affine descriptor-pool creation | src/driver/vulkan.ab packed DescriptorPoolSize and DescriptorPoolCreateInfo ABIs | examples/common-textured/main.ab live sampled bind-group creation | tests/application/main.ab duplicate and wrong-usage binding rejection |
| `vkCreateDescriptorSetLayout` | definition | common | src/driver/vulkan.ab reflected bind-group layout creation | src/driver/vulkan.ab packed DescriptorSetLayoutBinding and create-info ABIs | tests/application/main.ab sampled uniform and storage layout validation | tests/application/main.ab duplicate binding rejection |
| `vkCreateDescriptorUpdateTemplate` | definition | unclassified | - | - | - | - |
| `vkCreateDescriptorUpdateTemplateKHR` | alias | unclassified | - | - | - | - |
| `vkCreateDevice` | definition | common | src/driver/vulkan.ab negotiated logical-device creation | src/driver/vulkan.ab packed DeviceQueueCreateInfo DeviceCreateInfo and feature-chain ABIs | tests/vulkan/main.ab compute timeline synchronization2 and dynamic-rendering device | tests/application/main.ab unavailable required feature rejection |
| `vkCreateDirectFBSurfaceEXT` | definition | unclassified | - | - | - | - |
| `vkCreateDisplayModeKHR` | definition | unclassified | - | - | - | - |
| `vkCreateDisplayPlaneSurfaceKHR` | definition | unclassified | - | - | - | - |
| `vkCreateEvent` | definition | unclassified | - | - | - | - |
| `vkCreateExecutionGraphPipelinesAMDX` | definition | unclassified | - | - | - | - |
| `vkCreateExternalComputeQueueNV` | definition | unclassified | - | - | - | - |
| `vkCreateFence` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab affine frame and transfer completion fences | src/driver/vulkan.ab packed FenceCreateInfo ABI | tests/transfer/main.ab three stable asynchronous transfer fences | src/driver/vulkan_transfer.ab partial slot creation cleanup |
| `vkCreateFramebuffer` | definition | common | src/driver/vulkan.ab target creation | src/driver/vulkan.ab packed framebuffer ABI | tests/application/main.ab MRT multisample framebuffer | tests/application/main.ab incompatible attachment rejection |
| `vkCreateGpaSessionAMD` | definition | unclassified | - | - | - | - |
| `vkCreateGraphicsPipelines` | definition | common | src/driver/vulkan.ab reflected graphics pipeline creation | src/driver/vulkan.ab packed shader vertex raster blend depth and dynamic-state ABIs | examples/common-triangle/main.ab live blended depth-tested raster pipelines | examples/common-triangle/main.ab invalid raster depth and vertex layout rejection |
| `vkCreateHeadlessSurfaceEXT` | definition | unclassified | - | - | - | - |
| `vkCreateIOSSurfaceMVK` | definition | unclassified | - | - | - | - |
| `vkCreateImage` | definition | common | src/driver/vulkan.ab texture allocation | src/driver/vulkan.ab packed image creation ABI | tests/application/main.ab texture and target creation | tests/application/main.ab invalid descriptor rejection |
| `vkCreateImagePipeSurfaceFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkCreateImageView` | definition | common | src/driver/vulkan.ab texture view creation | src/driver/vulkan.ab packed image view ABI | tests/application/main.ab render and resolve views | tests/application/main.ab incompatible target rejection |
| `vkCreateIndirectCommandsLayoutEXT` | definition | unclassified | - | - | - | - |
| `vkCreateIndirectCommandsLayoutNV` | definition | unclassified | - | - | - | - |
| `vkCreateIndirectExecutionSetEXT` | definition | unclassified | - | - | - | - |
| `vkCreateInstance` | definition | common | src/driver/vulkan.ab negotiated Vulkan instance creation | src/driver/vulkan.ab packed ApplicationInfo and InstanceCreateInfo ABIs | tests/vulkan/main.ab live Vulkan 1.4 instance with debug-utils negotiation | tests/application/main.ab unavailable loader rejection |
| `vkCreateMacOSSurfaceMVK` | definition | unclassified | - | - | - | - |
| `vkCreateMetalSurfaceEXT` | definition | unclassified | - | - | - | - |
| `vkCreateMicromapEXT` | definition | unclassified | - | - | - | - |
| `vkCreateOpticalFlowSessionNV` | definition | unclassified | - | - | - | - |
| `vkCreatePipelineBinariesKHR` | definition | unclassified | - | - | - | - |
| `vkCreatePipelineCache` | definition | unclassified | - | - | - | - |
| `vkCreatePipelineLayout` | definition | common | src/driver/vulkan.ab reflected descriptor and push pipeline layout | src/driver/vulkan.ab packed PipelineLayoutCreateInfo and push-range ABIs | tests/application/main.ab compute render binding and push pipelines | tests/application/main.ab mismatched binding and push rejection |
| `vkCreatePrivateDataSlot` | definition | unclassified | - | - | - | - |
| `vkCreatePrivateDataSlotEXT` | alias | unclassified | - | - | - | - |
| `vkCreateQueryPool` | definition | common | src/driver/vulkan.ab timestamp query creation | src/driver/vulkan.ab packed query-pool ABI | tests/application/main.ab timestamp query creation | tests/application/main.ab invalid application rejection |
| `vkCreateRayTracingPipelinesKHR` | definition | unclassified | - | - | - | - |
| `vkCreateRayTracingPipelinesNV` | definition | unclassified | - | - | - | - |
| `vkCreateRenderPass` | definition | common | src/driver/vulkan.ab render-pass creation | src/driver/vulkan.ab packed render-pass ABI | tests/application/main.ab native multisample resolve pass | tests/application/main.ab invalid render operation rejection |
| `vkCreateRenderPass2` | definition | unclassified | - | - | - | - |
| `vkCreateRenderPass2KHR` | alias | unclassified | - | - | - | - |
| `vkCreateSampler` | definition | common | src/driver/vulkan.ab affine sampler creation | src/driver/vulkan.ab packed SamplerCreateInfo ABI | tests/application/main.ab comparison and anisotropic sampler creation | src/sampler.ab unsupported comparison and anisotropy rejection |
| `vkCreateSamplerYcbcrConversion` | definition | unclassified | - | - | - | - |
| `vkCreateSamplerYcbcrConversionKHR` | alias | unclassified | - | - | - | - |
| `vkCreateScreenSurfaceQNX` | definition | unclassified | - | - | - | - |
| `vkCreateSemaphore` | definition | common | src/driver/vulkan.ab affine binary and timeline semaphore creation | src/driver/vulkan.ab packed SemaphoreCreateInfo and timeline-type ABIs | tests/vulkan_window/main.ab repeated acquire render present synchronization | tests/vulkan/main.ab invalid timeline value rejection |
| `vkCreateShaderInstrumentationARM` | definition | unclassified | - | - | - | - |
| `vkCreateShaderModule` | definition | common | src/driver/vulkan.ab emitted SPIR-V module creation | src/driver/vulkan.ab packed ShaderModuleCreateInfo and little-endian code ABI | tests/application/main.ab exact compute vertex and fragment pipelines | tests/core.ab invalid SPIR-V module rejection |
| `vkCreateShadersEXT` | definition | unclassified | - | - | - | - |
| `vkCreateSharedSwapchainsKHR` | definition | unclassified | - | - | - | - |
| `vkCreateStreamDescriptorSurfaceGGP` | definition | unclassified | - | - | - | - |
| `vkCreateSurfaceOHOS` | definition | unclassified | - | - | - | - |
| `vkCreateSwapchainKHR` | definition | common | src/driver/vulkan.ab negotiated surfaced swapchain creation | src/driver/vulkan.ab packed SwapchainCreateInfoKHR ABI | tests/vulkan_window/main.ab live minimum-image dynamic and legacy presentation | tests/application/main.ab stale swapchain recreation |
| `vkCreateTensorARM` | definition | unclassified | - | - | - | - |
| `vkCreateTensorViewARM` | definition | unclassified | - | - | - | - |
| `vkCreateUbmSurfaceSEC` | definition | unclassified | - | - | - | - |
| `vkCreateValidationCacheEXT` | definition | unclassified | - | - | - | - |
| `vkCreateViSurfaceNN` | definition | unclassified | - | - | - | - |
| `vkCreateVideoSessionKHR` | definition | unclassified | - | - | - | - |
| `vkCreateVideoSessionParametersKHR` | definition | unclassified | - | - | - | - |
| `vkCreateWaylandSurfaceKHR` | definition | unclassified | - | - | - | - |
| `vkCreateWin32SurfaceKHR` | definition | unclassified | - | - | - | - |
| `vkCreateXcbSurfaceKHR` | definition | unclassified | - | - | - | - |
| `vkCreateXlibSurfaceKHR` | definition | common | src/driver/vulkan.ab pure-Abla X11 Vulkan surface creation | src/driver/vulkan.ab packed XlibSurfaceCreateInfoKHR ABI | tests/vulkan_window/main.ab live visible X11 surface | src/driver/vulkan.ab invalid instance display or window rejection |
| `vkDebugMarkerSetObjectNameEXT` | definition | unclassified | - | - | - | - |
| `vkDebugMarkerSetObjectTagEXT` | definition | unclassified | - | - | - | - |
| `vkDebugReportMessageEXT` | definition | unclassified | - | - | - | - |
| `vkDeferredOperationJoinKHR` | definition | unclassified | - | - | - | - |
| `vkDestroyAccelerationStructureKHR` | definition | unclassified | - | - | - | - |
| `vkDestroyAccelerationStructureNV` | definition | unclassified | - | - | - | - |
| `vkDestroyBuffer` | definition | common | src/driver/vulkan.ab affine buffer lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated buffer lifecycle | tests/application/main.ab invalid buffer descriptor rejection |
| `vkDestroyBufferCollectionFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkDestroyBufferView` | definition | unclassified | - | - | - | - |
| `vkDestroyCommandPool` | definition | common | src/driver/vulkan.ab affine command-pool and owned-buffer lifetime | src/driver/vulkan.ab typed extern signature | examples/common-compute/main.ab repeated compute pipeline lifecycle | tests/application/main.ab invalid operation cleanup |
| `vkDestroyCuFunctionNVX` | definition | unclassified | - | - | - | - |
| `vkDestroyCuModuleNVX` | definition | unclassified | - | - | - | - |
| `vkDestroyCudaFunctionNV` | definition | unclassified | - | - | - | - |
| `vkDestroyCudaModuleNV` | definition | unclassified | - | - | - | - |
| `vkDestroyDataGraphPipelineSessionARM` | definition | unclassified | - | - | - | - |
| `vkDestroyDebugReportCallbackEXT` | definition | unclassified | - | - | - | - |
| `vkDestroyDebugUtilsMessengerEXT` | definition | common | src/driver/vulkan_debug.ab affine debug messenger lifetime | src/driver/vulkan_debug.ab typed indirect destroy call | tests/vulkan/main.ab stable owned messenger handle | tests/vulkan/main.ab invalid messenger idempotent drop |
| `vkDestroyDeferredOperationKHR` | definition | unclassified | - | - | - | - |
| `vkDestroyDescriptorPool` | definition | common | src/driver/vulkan.ab affine descriptor-pool lifetime | src/driver/vulkan.ab typed extern signature | examples/common-textured/main.ab repeated bind-group render lifecycle | tests/application/main.ab invalid bind-group rejection before allocation |
| `vkDestroyDescriptorSetLayout` | definition | common | src/driver/vulkan.ab affine descriptor-layout lifetime | src/driver/vulkan.ab typed extern signature | examples/common-textured/main.ab repeated bind-group render lifecycle | tests/application/main.ab invalid bind-group rejection before allocation |
| `vkDestroyDescriptorUpdateTemplate` | definition | unclassified | - | - | - | - |
| `vkDestroyDescriptorUpdateTemplateKHR` | alias | unclassified | - | - | - | - |
| `vkDestroyDevice` | definition | common | src/driver/vulkan.ab affine logical-device lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan/main.ab complete device resource lifecycle | src/driver/vulkan.ab partial device creation cleanup |
| `vkDestroyEvent` | definition | unclassified | - | - | - | - |
| `vkDestroyExternalComputeQueueNV` | definition | unclassified | - | - | - | - |
| `vkDestroyFence` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab affine fence lifetime | src/driver/vulkan.ab typed extern signature | tests/transfer/main.ab complete three-slot queue lifecycle | src/driver/vulkan_transfer.ab partial slot cleanup |
| `vkDestroyFramebuffer` | definition | common | src/driver/vulkan.ab affine legacy framebuffer lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab stable target and subpass framebuffer lifecycle | tests/application/main.ab failed target cleanup |
| `vkDestroyGpaSessionAMD` | definition | unclassified | - | - | - | - |
| `vkDestroyImage` | definition | common | src/driver/vulkan.ab affine texture image lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab sampled transfer and target texture lifecycle | tests/application/main.ab invalid texture descriptor rejection |
| `vkDestroyImageView` | definition | common | src/driver/vulkan.ab affine texture-view lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab valid default reinterpret and target views | tests/application/main.ab incompatible and out-of-range view rejection |
| `vkDestroyIndirectCommandsLayoutEXT` | definition | unclassified | - | - | - | - |
| `vkDestroyIndirectCommandsLayoutNV` | definition | unclassified | - | - | - | - |
| `vkDestroyIndirectExecutionSetEXT` | definition | unclassified | - | - | - | - |
| `vkDestroyInstance` | definition | common | src/driver/vulkan.ab affine instance lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan/main.ab complete debug instance lifecycle | src/driver/vulkan.ab failed initialization cleanup |
| `vkDestroyMicromapEXT` | definition | unclassified | - | - | - | - |
| `vkDestroyOpticalFlowSessionNV` | definition | unclassified | - | - | - | - |
| `vkDestroyPipeline` | definition | common | src/driver/vulkan.ab affine graphics and compute pipeline lifetime | src/driver/vulkan.ab typed extern signature | examples/common-triangle/main.ab alternate pipeline drop and stable primary pipeline | examples/common-triangle/main.ab invalid pipeline cleanup |
| `vkDestroyPipelineBinaryKHR` | definition | unclassified | - | - | - | - |
| `vkDestroyPipelineCache` | definition | unclassified | - | - | - | - |
| `vkDestroyPipelineLayout` | definition | common | src/driver/vulkan.ab affine pipeline-layout lifetime | src/driver/vulkan.ab typed extern signature | examples/common-triangle/main.ab repeated render pipeline lifecycle | tests/application/main.ab invalid pipeline cleanup |
| `vkDestroyPrivateDataSlot` | definition | unclassified | - | - | - | - |
| `vkDestroyPrivateDataSlotEXT` | alias | unclassified | - | - | - | - |
| `vkDestroyQueryPool` | definition | common | src/driver/vulkan.ab timestamp query lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab affine timestamp query drop | tests/application/main.ab invalid application rejection |
| `vkDestroyRenderPass` | definition | common | src/driver/vulkan.ab affine legacy render-pass lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab stable multisample and subpass render-pass lifecycle | tests/application/main.ab invalid render operation cleanup |
| `vkDestroySampler` | definition | common | src/driver/vulkan.ab affine sampler lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab comparison and anisotropic sampler lifecycle | src/sampler.ab invalid application and descriptor rejection |
| `vkDestroySamplerYcbcrConversion` | definition | unclassified | - | - | - | - |
| `vkDestroySamplerYcbcrConversionKHR` | alias | unclassified | - | - | - | - |
| `vkDestroySemaphore` | definition | common | src/driver/vulkan.ab affine binary and timeline semaphore lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan_window/main.ab repeated presenter and timeline lifecycle | src/driver/vulkan.ab partial synchronization cleanup |
| `vkDestroyShaderEXT` | definition | unclassified | - | - | - | - |
| `vkDestroyShaderInstrumentationARM` | definition | unclassified | - | - | - | - |
| `vkDestroyShaderModule` | definition | common | src/driver/vulkan.ab affine shader-module lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab compute and render pipeline shader lifecycle | tests/core.ab invalid SPIR-V rejected before creation |
| `vkDestroySurfaceKHR` | definition | common | src/driver/vulkan.ab affine X11 surface lifetime | src/driver/vulkan.ab typed extern signature | tests/vulkan_window/main.ab complete surfaced application lifecycle | src/driver/vulkan.ab invalid surface cleanup guard |
| `vkDestroySwapchainKHR` | definition | common | src/driver/vulkan.ab affine swapchain image-set lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab two resize-driven swapchain recreations | src/driver/vulkan.ab failed swapchain cleanup |
| `vkDestroyTensorARM` | definition | unclassified | - | - | - | - |
| `vkDestroyTensorViewARM` | definition | unclassified | - | - | - | - |
| `vkDestroyValidationCacheEXT` | definition | unclassified | - | - | - | - |
| `vkDestroyVideoSessionKHR` | definition | unclassified | - | - | - | - |
| `vkDestroyVideoSessionParametersKHR` | definition | unclassified | - | - | - | - |
| `vkDeviceWaitIdle` | definition | common | src/driver/vulkan.ab portable idle wait | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated application waitIdle | tests/application/main.ab invalid application rejection |
| `vkDisplayPowerControlEXT` | definition | unclassified | - | - | - | - |
| `vkEndCommandBuffer` | definition | common | src/driver/vulkan.ab reusable command recording completion | src/driver/vulkan.ab typed command-buffer result ABI | examples/common-compute/main.ab repeated compute command completion | tests/application/main.ab invalid operation rejected before completion |
| `vkEnumerateDeviceExtensionProperties` | definition | unclassified | - | - | - | - |
| `vkEnumerateDeviceLayerProperties` | definition | unclassified | - | - | - | - |
| `vkEnumerateInstanceExtensionProperties` | definition | common | src/driver/vulkan.ab debug-utils extension discovery | src/driver/vulkan.ab bounded ExtensionProperties ABI | tests/vulkan/main.ab negotiated extension availability | tests/vulkan/main.ab explicitly disabled extension path |
| `vkEnumerateInstanceLayerProperties` | definition | unclassified | - | - | - | - |
| `vkEnumerateInstanceVersion` | definition | common | src/driver/vulkan.ab loader API version negotiation | src/driver/vulkan.ab typed version output-pointer ABI | tests/vulkan/main.ab validated Vulkan 1.4 loader version | src/driver/vulkan.ab Vulkan 1.0 fallback on query failure |
| `vkEnumeratePhysicalDeviceGroups` | definition | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceGroupsKHR` | alias | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceQueueFamilyPerformanceCountersByRegionARM` | definition | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR` | definition | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDeviceShaderInstrumentationMetricsARM` | definition | unclassified | - | - | - | - |
| `vkEnumeratePhysicalDevices` | definition | common | src/driver/vulkan.ab bounded adapter enumeration | src/driver/vulkan.ab two-call count and handle-array ABI | tests/vulkan/main.ab nonempty named adapter inventory | tests/application/main.ab unavailable adapter rejection |
| `vkExportMetalObjectsEXT` | definition | unclassified | - | - | - | - |
| `vkFlushMappedMemoryRanges` | definition | unclassified | - | - | - | - |
| `vkFreeCommandBuffers` | definition | unclassified | - | - | - | - |
| `vkFreeDescriptorSets` | definition | unclassified | - | - | - | - |
| `vkFreeMemory` | definition | common | src/driver/vulkan.ab affine buffer memory lifetime | src/driver/vulkan.ab typed extern signature | tests/application/main.ab repeated buffer lifecycle | tests/application/main.ab invalid buffer descriptor rejection |
| `vkGetAccelerationStructureBuildSizesKHR` | definition | unclassified | - | - | - | - |
| `vkGetAccelerationStructureDeviceAddressKHR` | definition | unclassified | - | - | - | - |
| `vkGetAccelerationStructureHandleNV` | definition | unclassified | - | - | - | - |
| `vkGetAccelerationStructureMemoryRequirementsNV` | definition | unclassified | - | - | - | - |
| `vkGetAccelerationStructureOpaqueCaptureDescriptorDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetAndroidHardwareBufferPropertiesANDROID` | definition | unclassified | - | - | - | - |
| `vkGetBufferCollectionPropertiesFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkGetBufferDeviceAddress` | definition | unclassified | - | - | - | - |
| `vkGetBufferDeviceAddressEXT` | alias | unclassified | - | - | - | - |
| `vkGetBufferDeviceAddressKHR` | alias | unclassified | - | - | - | - |
| `vkGetBufferMemoryRequirements` | definition | common | src/driver/vulkan.ab placement-compatible buffer requirement query | src/driver/vulkan.ab packed MemoryRequirements ABI | tests/transfer/main.ab device-local copy buffer requirements | tests/application/main.ab oversized buffer rejection |
| `vkGetBufferMemoryRequirements2` | definition | unclassified | - | - | - | - |
| `vkGetBufferMemoryRequirements2KHR` | alias | unclassified | - | - | - | - |
| `vkGetBufferOpaqueCaptureAddress` | definition | unclassified | - | - | - | - |
| `vkGetBufferOpaqueCaptureAddressKHR` | alias | unclassified | - | - | - | - |
| `vkGetBufferOpaqueCaptureDescriptorDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetCalibratedTimestampsEXT` | alias | unclassified | - | - | - | - |
| `vkGetCalibratedTimestampsKHR` | definition | unclassified | - | - | - | - |
| `vkGetClusterAccelerationStructureBuildSizesNV` | definition | unclassified | - | - | - | - |
| `vkGetCudaModuleCacheNV` | definition | unclassified | - | - | - | - |
| `vkGetDataGraphPipelineAvailablePropertiesARM` | definition | unclassified | - | - | - | - |
| `vkGetDataGraphPipelinePropertiesARM` | definition | unclassified | - | - | - | - |
| `vkGetDataGraphPipelineSessionBindPointRequirementsARM` | definition | unclassified | - | - | - | - |
| `vkGetDataGraphPipelineSessionMemoryRequirementsARM` | definition | unclassified | - | - | - | - |
| `vkGetDeferredOperationMaxConcurrencyKHR` | definition | unclassified | - | - | - | - |
| `vkGetDeferredOperationResultKHR` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorEXT` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorSetHostMappingVALVE` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutBindingOffsetEXT` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutHostMappingInfoVALVE` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutSizeEXT` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutSupport` | definition | unclassified | - | - | - | - |
| `vkGetDescriptorSetLayoutSupportKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceAccelerationStructureCompatibilityKHR` | definition | unclassified | - | - | - | - |
| `vkGetDeviceBufferMemoryRequirements` | definition | unclassified | - | - | - | - |
| `vkGetDeviceBufferMemoryRequirementsKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceCombinedImageSamplerIndexNVX` | definition | unclassified | - | - | - | - |
| `vkGetDeviceFaultDebugInfoKHR` | definition | unclassified | - | - | - | - |
| `vkGetDeviceFaultInfoEXT` | definition | unclassified | - | - | - | - |
| `vkGetDeviceFaultReportsKHR` | definition | unclassified | - | - | - | - |
| `vkGetDeviceGroupPeerMemoryFeatures` | definition | unclassified | - | - | - | - |
| `vkGetDeviceGroupPeerMemoryFeaturesKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceGroupPresentCapabilitiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetDeviceGroupSurfacePresentModes2EXT` | definition | unclassified | - | - | - | - |
| `vkGetDeviceGroupSurfacePresentModesKHR` | definition | unclassified | - | - | - | - |
| `vkGetDeviceImageMemoryRequirements` | definition | unclassified | - | - | - | - |
| `vkGetDeviceImageMemoryRequirementsKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceImageSparseMemoryRequirements` | definition | unclassified | - | - | - | - |
| `vkGetDeviceImageSparseMemoryRequirementsKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceImageSubresourceLayout` | definition | unclassified | - | - | - | - |
| `vkGetDeviceImageSubresourceLayoutKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceMemoryCommitment` | definition | unclassified | - | - | - | - |
| `vkGetDeviceMemoryOpaqueCaptureAddress` | definition | unclassified | - | - | - | - |
| `vkGetDeviceMemoryOpaqueCaptureAddressKHR` | alias | unclassified | - | - | - | - |
| `vkGetDeviceMicromapCompatibilityEXT` | definition | unclassified | - | - | - | - |
| `vkGetDeviceProcAddr` | definition | unclassified | - | - | - | - |
| `vkGetDeviceQueue` | definition | common | src/driver/vulkan.ab selected graphics-compute queue retrieval | src/driver/vulkan.ab typed family index queue index and output ABI | tests/vulkan/main.ab live compute transfer and render queue | src/driver/vulkan.ab invalid queue handle rejects device |
| `vkGetDeviceQueue2` | definition | unclassified | - | - | - | - |
| `vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI` | definition | unclassified | - | - | - | - |
| `vkGetDeviceTensorMemoryRequirementsARM` | definition | unclassified | - | - | - | - |
| `vkGetDisplayModeProperties2KHR` | definition | unclassified | - | - | - | - |
| `vkGetDisplayModePropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetDisplayPlaneCapabilities2KHR` | definition | unclassified | - | - | - | - |
| `vkGetDisplayPlaneCapabilitiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetDisplayPlaneSupportedDisplaysKHR` | definition | unclassified | - | - | - | - |
| `vkGetDrmDisplayEXT` | definition | unclassified | - | - | - | - |
| `vkGetDynamicRenderingTilePropertiesQCOM` | definition | unclassified | - | - | - | - |
| `vkGetEncodedVideoSessionParametersKHR` | definition | unclassified | - | - | - | - |
| `vkGetEventStatus` | definition | unclassified | - | - | - | - |
| `vkGetExecutionGraphPipelineNodeIndexAMDX` | definition | unclassified | - | - | - | - |
| `vkGetExecutionGraphPipelineScratchSizeAMDX` | definition | unclassified | - | - | - | - |
| `vkGetExternalComputeQueueDataNV` | definition | unclassified | - | - | - | - |
| `vkGetFenceFdKHR` | definition | unclassified | - | - | - | - |
| `vkGetFenceStatus` | definition | common | src/driver/vulkan_transfer.ab nonblocking transfer-slot completion query | src/driver/vulkan_transfer.ab typed device and fence ABI | tests/transfer/main.ab three queued upload and readback slots | tests/transfer/main.ab stale generation rejection before slot access |
| `vkGetFenceWin32HandleKHR` | definition | unclassified | - | - | - | - |
| `vkGetFramebufferTilePropertiesQCOM` | definition | unclassified | - | - | - | - |
| `vkGetGeneratedCommandsMemoryRequirementsEXT` | definition | unclassified | - | - | - | - |
| `vkGetGeneratedCommandsMemoryRequirementsNV` | definition | unclassified | - | - | - | - |
| `vkGetGpaDeviceClockInfoAMD` | definition | unclassified | - | - | - | - |
| `vkGetGpaSessionResultsAMD` | definition | unclassified | - | - | - | - |
| `vkGetGpaSessionStatusAMD` | definition | unclassified | - | - | - | - |
| `vkGetImageDrmFormatModifierPropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetImageMemoryRequirements` | definition | common | src/driver/vulkan.ab texture memory requirement query | src/driver/vulkan.ab packed MemoryRequirements output ABI | tests/application/main.ab sampled transfer depth and multisample images | tests/application/main.ab invalid size and sample-count rejection |
| `vkGetImageMemoryRequirements2` | definition | unclassified | - | - | - | - |
| `vkGetImageMemoryRequirements2KHR` | alias | unclassified | - | - | - | - |
| `vkGetImageOpaqueCaptureDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetImageOpaqueCaptureDescriptorDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetImageSparseMemoryRequirements` | definition | unclassified | - | - | - | - |
| `vkGetImageSparseMemoryRequirements2` | definition | unclassified | - | - | - | - |
| `vkGetImageSparseMemoryRequirements2KHR` | alias | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout` | definition | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout2` | definition | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout2EXT` | alias | unclassified | - | - | - | - |
| `vkGetImageSubresourceLayout2KHR` | alias | unclassified | - | - | - | - |
| `vkGetImageViewAddressNVX` | definition | unclassified | - | - | - | - |
| `vkGetImageViewHandle64NVX` | definition | unclassified | - | - | - | - |
| `vkGetImageViewHandleNVX` | definition | unclassified | - | - | - | - |
| `vkGetImageViewOpaqueCaptureDescriptorDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetInstanceProcAddr` | definition | common | src/driver/vulkan_debug.ab instance extension entry-point loading | stdlib fixed-signature native address calls | tests/vulkan/main.ab create destroy and submit resolution | tests/vulkan/main.ab unavailable or disabled messenger rejection |
| `vkGetLatencyTimingsLegacyNV` | definition | unclassified | - | - | - | - |
| `vkGetLatencyTimingsNV` | definition | unclassified | - | - | - | - |
| `vkGetMemoryAndroidHardwareBufferANDROID` | definition | unclassified | - | - | - | - |
| `vkGetMemoryFdKHR` | definition | unclassified | - | - | - | - |
| `vkGetMemoryFdPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetMemoryHostPointerPropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetMemoryMetalHandleEXT` | definition | unclassified | - | - | - | - |
| `vkGetMemoryMetalHandlePropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetMemoryNativeBufferOHOS` | definition | unclassified | - | - | - | - |
| `vkGetMemoryRemoteAddressNV` | definition | unclassified | - | - | - | - |
| `vkGetMemoryWin32HandleKHR` | definition | unclassified | - | - | - | - |
| `vkGetMemoryWin32HandleNV` | definition | unclassified | - | - | - | - |
| `vkGetMemoryWin32HandlePropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetMemoryZirconHandleFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkGetMemoryZirconHandlePropertiesFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkGetMicromapBuildSizesEXT` | definition | unclassified | - | - | - | - |
| `vkGetNativeBufferPropertiesOHOS` | definition | unclassified | - | - | - | - |
| `vkGetPartitionedAccelerationStructuresBuildSizesNV` | definition | unclassified | - | - | - | - |
| `vkGetPastPresentationTimingEXT` | definition | unclassified | - | - | - | - |
| `vkGetPastPresentationTimingGOOGLE` | definition | unclassified | - | - | - | - |
| `vkGetPerformanceParameterINTEL` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCalibrateableTimeDomainsEXT` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCalibrateableTimeDomainsKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixFlexibleDimensionsPropertiesNV` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixProperties2EXT` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeMatrixPropertiesNV` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceCooperativeVectorPropertiesNV` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDescriptorSizeEXT` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDirectFBPresentationSupportEXT` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayPlaneProperties2KHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayPlanePropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayProperties2KHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceDisplayPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalBufferProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalBufferPropertiesKHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalFenceProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalFencePropertiesKHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalImageFormatPropertiesNV` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalSemaphoreProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalSemaphorePropertiesKHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceExternalTensorPropertiesARM` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFeatures` | definition | common | src/driver/vulkan.ab base feature availability query | src/driver/vulkan.ab packed PhysicalDeviceFeatures ABI | tests/vulkan/main.ab sampler anisotropy and core feature negotiation | tests/application/main.ab required feature rejection |
| `vkGetPhysicalDeviceFeatures2` | definition | common | src/driver/vulkan.ab promoted feature query | src/driver/vulkan.ab Vulkan 12 and 13 feature-chain ABI | tests/vulkan/main.ab timeline and synchronization2 enablement | src/driver/vulkan.ab core-version gating |
| `vkGetPhysicalDeviceFeatures2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFormatProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFormatProperties2` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFormatProperties2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceFragmentShadingRatesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceImageFormatProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceImageFormatProperties2` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceImageFormatProperties2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceMemoryProperties` | definition | common | src/driver/vulkan.ab ranked host-visible and device-local memory-type selection | src/driver/vulkan.ab packed PhysicalDeviceMemoryProperties ABI | tests/transfer/main.ab native device-local flag and exact staged bytes | tests/core.ab unknown placement rejection |
| `vkGetPhysicalDeviceMemoryProperties2` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceMemoryProperties2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceMultisamplePropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceOpticalFlowImageFormatsNV` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDevicePresentRectanglesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceProperties` | definition | common | src/driver/vulkan.ab adapter identity limits and timestamp query | src/driver/vulkan.ab packed PhysicalDeviceProperties ABI | tests/vulkan/main.ab named adapter compute texture storage and timestamp limits | tests/application/main.ab limit-exceeding resource rejection |
| `vkGetPhysicalDeviceProperties2` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceProperties2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphEngineOperationPropertiesARM` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphOpticalFlowImageFormatsARM` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphProcessingEnginePropertiesARM` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyDataGraphPropertiesARM` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyProperties` | definition | common | src/driver/vulkan.ab graphics compute and presentation family selection | src/driver/vulkan.ab two-call count and property-array ABI | tests/vulkan/main.ab valid graphics-compute queue family | tests/application/main.ab unavailable compatible queue rejection |
| `vkGetPhysicalDeviceQueueFamilyProperties2` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceQueueFamilyProperties2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceScreenPresentationSupportQNX` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSparseImageFormatProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSparseImageFormatProperties2` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSparseImageFormatProperties2KHR` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceCapabilities2EXT` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceCapabilities2KHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceCapabilitiesKHR` | definition | common | src/driver/vulkan.ab surface extent image-count transform and usage query | src/driver/vulkan.ab packed SurfaceCapabilitiesKHR ABI | tests/vulkan_window/main.ab valid minimum images and supported usage | src/driver/vulkan.ab invalid surface capability rejection |
| `vkGetPhysicalDeviceSurfaceFormats2KHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceFormatsKHR` | definition | common | src/driver/vulkan.ab bounded surface format and color-space enumeration | src/driver/vulkan.ab two-call count and SurfaceFormatKHR array ABI | tests/vulkan_window/main.ab selected live swapchain format | src/driver/vulkan.ab unavailable format rejection |
| `vkGetPhysicalDeviceSurfacePresentModes2EXT` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfacePresentModesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceSurfaceSupportKHR` | definition | common | src/driver/vulkan.ab queue-family surface support query | src/driver/vulkan.ab typed adapter family surface and output ABI | tests/vulkan_window/main.ab supported graphics presentation family | src/driver/vulkan.ab unsupported family rejection |
| `vkGetPhysicalDeviceToolProperties` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceToolPropertiesEXT` | alias | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceUbmPresentationSupportSEC` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceVideoCapabilitiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceVideoEncodeQualityLevelPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceVideoFormatPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceWaylandPresentationSupportKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceWin32PresentationSupportKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceXcbPresentationSupportKHR` | definition | unclassified | - | - | - | - |
| `vkGetPhysicalDeviceXlibPresentationSupportKHR` | definition | common | src/driver/vulkan.ab Xlib visual presentation compatibility query | src/driver/vulkan.ab typed adapter family display and visual ABI | tests/vulkan_window/main.ab live X11 presentation support | src/driver/vulkan.ab invalid display visual or family rejection |
| `vkGetPipelineBinaryDataKHR` | definition | unclassified | - | - | - | - |
| `vkGetPipelineCacheData` | definition | unclassified | - | - | - | - |
| `vkGetPipelineExecutableInternalRepresentationsKHR` | definition | unclassified | - | - | - | - |
| `vkGetPipelineExecutablePropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkGetPipelineExecutableStatisticsKHR` | definition | unclassified | - | - | - | - |
| `vkGetPipelineIndirectDeviceAddressNV` | definition | unclassified | - | - | - | - |
| `vkGetPipelineIndirectMemoryRequirementsNV` | definition | unclassified | - | - | - | - |
| `vkGetPipelineKeyKHR` | definition | unclassified | - | - | - | - |
| `vkGetPipelinePropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetPrivateData` | definition | unclassified | - | - | - | - |
| `vkGetPrivateDataEXT` | alias | unclassified | - | - | - | - |
| `vkGetQueryPoolResults` | definition | common | src/driver/vulkan.ab timestamp readback | src/driver/vulkan.ab typed extern signature | tests/application/main.ab monotonic timestamp samples | tests/application/main.ab invalid query rejection |
| `vkGetQueueCheckpointData2NV` | definition | unclassified | - | - | - | - |
| `vkGetQueueCheckpointDataNV` | definition | unclassified | - | - | - | - |
| `vkGetRandROutputDisplayEXT` | definition | unclassified | - | - | - | - |
| `vkGetRayTracingCaptureReplayShaderGroupHandlesKHR` | definition | unclassified | - | - | - | - |
| `vkGetRayTracingShaderGroupHandlesKHR` | definition | unclassified | - | - | - | - |
| `vkGetRayTracingShaderGroupHandlesNV` | alias | unclassified | - | - | - | - |
| `vkGetRayTracingShaderGroupStackSizeKHR` | definition | unclassified | - | - | - | - |
| `vkGetRefreshCycleDurationGOOGLE` | definition | unclassified | - | - | - | - |
| `vkGetRenderAreaGranularity` | definition | unclassified | - | - | - | - |
| `vkGetRenderingAreaGranularity` | definition | unclassified | - | - | - | - |
| `vkGetRenderingAreaGranularityKHR` | alias | unclassified | - | - | - | - |
| `vkGetSamplerOpaqueCaptureDescriptorDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetScreenBufferPropertiesQNX` | definition | unclassified | - | - | - | - |
| `vkGetSemaphoreCounterValue` | definition | common | src/driver/vulkan.ab timeline counter query | src/driver/vulkan.ab typed extern signature | tests/vulkan/main.ab exact repeated timeline counters | tests/vulkan/main.ab invalid timeline rejection |
| `vkGetSemaphoreCounterValueKHR` | alias | unclassified | - | - | - | - |
| `vkGetSemaphoreFdKHR` | definition | unclassified | - | - | - | - |
| `vkGetSemaphoreWin32HandleKHR` | definition | unclassified | - | - | - | - |
| `vkGetSemaphoreZirconHandleFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkGetShaderBinaryDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetShaderInfoAMD` | definition | unclassified | - | - | - | - |
| `vkGetShaderInstrumentationValuesARM` | definition | unclassified | - | - | - | - |
| `vkGetShaderModuleCreateInfoIdentifierEXT` | definition | unclassified | - | - | - | - |
| `vkGetShaderModuleIdentifierEXT` | definition | unclassified | - | - | - | - |
| `vkGetSleepStatusLegacyNV` | definition | unclassified | - | - | - | - |
| `vkGetSwapchainCounterEXT` | definition | unclassified | - | - | - | - |
| `vkGetSwapchainImagesKHR` | definition | common | src/driver/vulkan.ab bounded swapchain image enumeration | src/driver/vulkan.ab two-call count and image-array ABI | tests/vulkan_window/main.ab image count at least surface minimum | src/driver/vulkan.ab empty image inventory rejection |
| `vkGetSwapchainStatusKHR` | definition | unclassified | - | - | - | - |
| `vkGetSwapchainTimeDomainPropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetSwapchainTimingPropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkGetTensorMemoryRequirementsARM` | definition | unclassified | - | - | - | - |
| `vkGetTensorOpaqueCaptureDataARM` | definition | unclassified | - | - | - | - |
| `vkGetTensorOpaqueCaptureDescriptorDataARM` | definition | unclassified | - | - | - | - |
| `vkGetTensorViewOpaqueCaptureDescriptorDataARM` | definition | unclassified | - | - | - | - |
| `vkGetValidationCacheDataEXT` | definition | unclassified | - | - | - | - |
| `vkGetVideoSessionMemoryRequirementsKHR` | definition | unclassified | - | - | - | - |
| `vkGetWinrtDisplayNV` | definition | unclassified | - | - | - | - |
| `vkImportFenceFdKHR` | definition | unclassified | - | - | - | - |
| `vkImportFenceWin32HandleKHR` | definition | unclassified | - | - | - | - |
| `vkImportSemaphoreFdKHR` | definition | unclassified | - | - | - | - |
| `vkImportSemaphoreWin32HandleKHR` | definition | unclassified | - | - | - | - |
| `vkImportSemaphoreZirconHandleFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkInitializePerformanceApiINTEL` | definition | unclassified | - | - | - | - |
| `vkInvalidateMappedMemoryRanges` | definition | unclassified | - | - | - | - |
| `vkLatencySleepLegacyNV` | definition | unclassified | - | - | - | - |
| `vkLatencySleepNV` | definition | unclassified | - | - | - | - |
| `vkMapMemory` | definition | common | src/driver/vulkan.ab mapped-at-creation and reusable coherent read-write mapping | src/driver/vulkan.ab typed aligned memory range flags and mapped-pointer ABI | examples/common-buffer/main.ab allocation-free repeated write and read maps | tests/application/main.ab access nested mapped-use and logical-range rejection |
| `vkMapMemory2` | definition | unclassified | - | - | - | - |
| `vkMapMemory2KHR` | alias | unclassified | - | - | - | - |
| `vkMergePipelineCaches` | definition | unclassified | - | - | - | - |
| `vkMergeValidationCachesEXT` | definition | unclassified | - | - | - | - |
| `vkQueueBeginDebugUtilsLabelEXT` | definition | unclassified | - | - | - | - |
| `vkQueueBindSparse` | definition | unclassified | - | - | - | - |
| `vkQueueEndDebugUtilsLabelEXT` | definition | unclassified | - | - | - | - |
| `vkQueueInsertDebugUtilsLabelEXT` | definition | unclassified | - | - | - | - |
| `vkQueueNotifyOutOfBandLegacyNV` | definition | unclassified | - | - | - | - |
| `vkQueueNotifyOutOfBandNV` | definition | unclassified | - | - | - | - |
| `vkQueuePresentKHR` | definition | common | src/driver/vulkan.ab synchronized surfaced presentation | src/driver/vulkan.ab packed PresentInfoKHR ABI | tests/vulkan_window/main.ab repeated dynamic and legacy presentation | tests/application/main.ab suboptimal and out-of-date recovery |
| `vkQueueSetPerfHintQCOM` | definition | unclassified | - | - | - | - |
| `vkQueueSetPerformanceConfigurationINTEL` | definition | unclassified | - | - | - | - |
| `vkQueueSubmit` | definition | common | src/driver/vulkan.ab legacy transfer compute render and presentation submission | src/driver/vulkan.ab packed SubmitInfo ABI | tests/application/main.ab exact repeated compute transfer and render results | tests/application/main.ab validation failure before queue submission |
| `vkQueueSubmit2` | definition | common | src/driver/vulkan.ab synchronization2 transfer submission | src/driver/vulkan.ab packed SubmitInfo2 ABI | tests/vulkan/main.ab GPU fill and readback with synchronization2 | src/driver/vulkan.ab legacy submit fallback |
| `vkQueueSubmit2KHR` | alias | unclassified | - | - | - | - |
| `vkQueueWaitIdle` | definition | common | src/driver/vulkan.ab bounded legacy queue completion | src/driver/vulkan.ab typed queue result ABI | examples/common-compute/main.ab exact storage readback after completion | tests/application/main.ab invalid application rejection |
| `vkRegisterCustomBorderColorEXT` | definition | unclassified | - | - | - | - |
| `vkRegisterDeviceEventEXT` | definition | unclassified | - | - | - | - |
| `vkRegisterDisplayEventEXT` | definition | unclassified | - | - | - | - |
| `vkReleaseCapturedPipelineDataKHR` | definition | unclassified | - | - | - | - |
| `vkReleaseDisplayEXT` | definition | unclassified | - | - | - | - |
| `vkReleaseFullScreenExclusiveModeEXT` | definition | unclassified | - | - | - | - |
| `vkReleasePerformanceConfigurationINTEL` | definition | unclassified | - | - | - | - |
| `vkReleaseProfilingLockKHR` | definition | unclassified | - | - | - | - |
| `vkReleaseSwapchainImagesEXT` | alias | unclassified | - | - | - | - |
| `vkReleaseSwapchainImagesKHR` | definition | unclassified | - | - | - | - |
| `vkResetCommandBuffer` | definition | unclassified | - | - | - | - |
| `vkResetCommandPool` | definition | common | src/driver/vulkan.ab allocation-free command-state reuse | src/driver/vulkan.ab typed pool and flags ABI | examples/common-compute/main.ab four repeated zero-growth dispatch rounds | tests/application/main.ab invalid operation rejected before reset |
| `vkResetDescriptorPool` | definition | unclassified | - | - | - | - |
| `vkResetEvent` | definition | unclassified | - | - | - | - |
| `vkResetFences` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab reusable frame and transfer fence reset | src/driver/vulkan.ab typed fence-array ABI | tests/transfer/main.ab stable repeated slot submissions | src/driver/vulkan_transfer.ab reset only before validated submission |
| `vkResetGpaSessionAMD` | definition | unclassified | - | - | - | - |
| `vkResetQueryPool` | definition | unclassified | - | - | - | - |
| `vkResetQueryPoolEXT` | alias | unclassified | - | - | - | - |
| `vkSetBufferCollectionBufferConstraintsFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkSetBufferCollectionImageConstraintsFUCHSIA` | definition | unclassified | - | - | - | - |
| `vkSetDebugUtilsObjectNameEXT` | definition | unclassified | - | - | - | - |
| `vkSetDebugUtilsObjectTagEXT` | definition | unclassified | - | - | - | - |
| `vkSetDeviceMemoryPriorityEXT` | definition | unclassified | - | - | - | - |
| `vkSetEvent` | definition | unclassified | - | - | - | - |
| `vkSetGpaDeviceClockModeAMD` | definition | unclassified | - | - | - | - |
| `vkSetHdrMetadataEXT` | definition | unclassified | - | - | - | - |
| `vkSetLatencyMarkerLegacyNV` | definition | unclassified | - | - | - | - |
| `vkSetLatencyMarkerNV` | definition | unclassified | - | - | - | - |
| `vkSetLatencySleepModeLegacyNV` | definition | unclassified | - | - | - | - |
| `vkSetLatencySleepModeNV` | definition | unclassified | - | - | - | - |
| `vkSetLocalDimmingAMD` | definition | unclassified | - | - | - | - |
| `vkSetPrivateData` | definition | unclassified | - | - | - | - |
| `vkSetPrivateDataEXT` | alias | unclassified | - | - | - | - |
| `vkSetSwapchainPresentTimingQueueSizeEXT` | definition | unclassified | - | - | - | - |
| `vkShutdownLatencyDeviceLegacyNV` | definition | unclassified | - | - | - | - |
| `vkSignalSemaphore` | definition | common | src/driver/vulkan.ab timeline host signal | src/driver/vulkan.ab packed semaphore signal ABI | tests/vulkan/main.ab repeated monotonic timeline signals | tests/vulkan/main.ab non-increasing signal rejection |
| `vkSignalSemaphoreKHR` | alias | unclassified | - | - | - | - |
| `vkSubmitDebugUtilsMessageEXT` | definition | common | src/driver/vulkan_debug.ab synchronous debug message submission | src/driver/vulkan_debug.ab reusable callback-data ABI and typed indirect call | tests/vulkan/main.ab exact severity and type accounting | tests/vulkan/main.ab invalid masks and empty message rejection |
| `vkTransitionImageLayout` | definition | unclassified | - | - | - | - |
| `vkTransitionImageLayoutEXT` | alias | unclassified | - | - | - | - |
| `vkTrimCommandPool` | definition | unclassified | - | - | - | - |
| `vkTrimCommandPoolKHR` | alias | unclassified | - | - | - | - |
| `vkUninitializePerformanceApiINTEL` | definition | unclassified | - | - | - | - |
| `vkUnmapMemory` | definition | common | src/driver/vulkan.ab explicit reusable affine and temporary mapping completion | src/driver/vulkan.ab typed device and memory ABI | examples/common-buffer/main.ab repeated write-read unmap with zero growth | tests/application/main.ab repeated unmap and mapped GPU use rejection |
| `vkUnmapMemory2` | definition | unclassified | - | - | - | - |
| `vkUnmapMemory2KHR` | alias | unclassified | - | - | - | - |
| `vkUnregisterCustomBorderColorEXT` | definition | unclassified | - | - | - | - |
| `vkUpdateDescriptorSetWithTemplate` | definition | unclassified | - | - | - | - |
| `vkUpdateDescriptorSetWithTemplateKHR` | alias | unclassified | - | - | - | - |
| `vkUpdateDescriptorSets` | definition | common | src/driver/vulkan.ab sampled and ranged buffer descriptor writes | src/driver/vulkan.ab packed WriteDescriptorSet image-info and offset buffer-info ABIs | examples/indexed-textured-cube/main.ab nonzero pool uniform range rendering | tests/pool/main.ab misaligned range rejection |
| `vkUpdateIndirectExecutionSetPipelineEXT` | definition | unclassified | - | - | - | - |
| `vkUpdateIndirectExecutionSetShaderEXT` | definition | unclassified | - | - | - | - |
| `vkUpdateVideoSessionParametersKHR` | definition | unclassified | - | - | - | - |
| `vkWaitForFences` | definition | common | src/driver/vulkan.ab and src/driver/vulkan_transfer.ab bounded frame and transfer completion wait | src/driver/vulkan.ab typed fence-array wait-all and timeout ABI | tests/transfer/main.ab explicit queued upload and readback waits | tests/transfer/main.ab stale and invalid ticket rejection |
| `vkWaitForPresent2KHR` | definition | unclassified | - | - | - | - |
| `vkWaitForPresentKHR` | definition | unclassified | - | - | - | - |
| `vkWaitSemaphores` | definition | common | src/driver/vulkan.ab timeline host wait | src/driver/vulkan.ab packed semaphore wait ABI | tests/vulkan/main.ab repeated bounded timeline waits | tests/vulkan/main.ab negative value and timeout rejection |
| `vkWaitSemaphoresKHR` | alias | unclassified | - | - | - | - |
| `vkWriteAccelerationStructuresPropertiesKHR` | definition | unclassified | - | - | - | - |
| `vkWriteMicromapsPropertiesEXT` | definition | unclassified | - | - | - | - |
| `vkWriteResourceDescriptorsEXT` | definition | unclassified | - | - | - | - |
| `vkWriteSamplerDescriptorsEXT` | definition | unclassified | - | - | - | - |

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
