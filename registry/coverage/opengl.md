# OpenGL registry inventory

- Revision: `e8f7cd0e35ac8d6f5667a021ff83d04b1fec41ef`
- SHA-256: `fba2eaa6262cededdba0dd3cd1e3b1806c24899a7c5df8158467e41c19969426`
- Commands: 2892
- Core features: 19
- Extensions: 623
- Constants: 6271
- Types: 43
- Command parameters: 9526
- Aggregates: 0
- Aggregate members: 0
- Classified commands: 109/2892
- Classified core features: 0/19
- Classified extensions: 0/623

## Commands

| Name | Form | Core transitions | Extension providers | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `glAccum` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glAccumxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glAcquireKeyedMutexWin32EXT` | definition |  | GL_EXT_win32_keyed_mutex:all:all | unclassified | - | - | - | - |
| `glActiveProgramEXT` | definition |  | GL_EXT_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glActiveShaderProgram` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glActiveStencilFaceEXT` | definition |  | GL_EXT_stencil_two_side:all:all | unclassified | - | - | - | - |
| `glActiveTexture` | definition | GL_VERSION_1_3:+:all |  | common | src/driver/opengl.ab sampled-texture slot activation | src/driver/opengl.ab typed texture-unit ABI | examples/common-textured/main.ab repeated sampled rendering with stable binding | examples/common-textured/main.ab missing shader binding rejection |
| `glActiveTextureARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glActiveVaryingNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glAddClientPointerRangeMESA` | definition |  | GL_MESA_map_buffer_client_pointer:all:all | unclassified | - | - | - | - |
| `glAlphaFragmentOp1ATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glAlphaFragmentOp2ATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glAlphaFragmentOp3ATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glAlphaFunc` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glAlphaFuncxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glAlphaToCoverageDitherControlNV` | definition |  | GL_NV_alpha_to_coverage_dither_control:all:all | unclassified | - | - | - | - |
| `glApplyFramebufferAttachmentCMAAINTEL` | definition |  | GL_INTEL_framebuffer_CMAA:all:all | unclassified | - | - | - | - |
| `glApplyTextureEXT` | definition |  | GL_EXT_light_texture:all:all | unclassified | - | - | - | - |
| `glAreProgramsResidentNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glAreTexturesResident` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glAreTexturesResidentEXT` | definition |  | GL_EXT_texture_object:all:all | unclassified | - | - | - | - |
| `glArrayElement` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glArrayElementEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glArrayObjectATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glAsyncCopyBufferSubDataNVX` | definition |  | GL_NVX_gpu_multicast2:all:all | unclassified | - | - | - | - |
| `glAsyncCopyImageSubDataNVX` | definition |  | GL_NVX_gpu_multicast2:all:all | unclassified | - | - | - | - |
| `glAsyncMarkerSGIX` | definition |  | GL_SGIX_async:all:all | unclassified | - | - | - | - |
| `glAttachObjectARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glAttachShader` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab render and compute program assembly | src/driver/opengl.ab typed program and shader-name ABI | tests/opengl/main.ab valid vertex and fragment program link | tests/opengl/main.ab empty program link rejection |
| `glBegin` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glBeginConditionalRender` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glBeginConditionalRenderNV` | definition |  | GL_NV_conditional_render:all:all | unclassified | - | - | - | - |
| `glBeginConditionalRenderNVX` | definition |  | GL_NVX_conditional_render:all:all | unclassified | - | - | - | - |
| `glBeginFragmentShaderATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glBeginOcclusionQueryNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glBeginPerfMonitorAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glBeginPerfQueryINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glBeginQuery` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glBeginQueryARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glBeginQueryIndexed` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback3:all:all | unclassified | - | - | - | - |
| `glBeginTransformFeedback` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glBeginTransformFeedbackEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBeginTransformFeedbackNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBeginVertexShaderEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBeginVideoCaptureNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glBindAttribLocation` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glBindAttribLocationARB` | definition |  | GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindBuffer` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab buffer target binding | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact buffer upload readback copy and fill | tests/application/main.ab range and usage rejection |
| `glBindBufferARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glBindBufferBase` | definition | GL_VERSION_3_0:+:all|GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | common | src/driver/opengl.ab uniform and storage binding slots | src/driver/opengl.ab typed target index and name ABI | tests/application/main.ab exact storage compute and bind-group validation | tests/application/main.ab wrong buffer usage rejection |
| `glBindBufferBaseEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBindBufferBaseNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBindBufferOffsetEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBindBufferOffsetNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBindBufferRange` | definition | GL_VERSION_3_0:+:all|GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | common | src/driver/opengl.ab ranged uniform and storage binding slots | src/driver/opengl.ab typed target index name offset and size ABI | examples/indexed-textured-cube/main.ab nonzero pool uniform range rendering | tests/pool/main.ab misaligned range rejection |
| `glBindBufferRangeEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBindBufferRangeNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glBindBuffersBase` | definition | GL_VERSION_4_4:+:all | GL_ARB_multi_bind:all:all | unclassified | - | - | - | - |
| `glBindBuffersRange` | definition | GL_VERSION_4_4:+:all | GL_ARB_multi_bind:all:all | unclassified | - | - | - | - |
| `glBindFragDataLocation` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glBindFragDataLocationEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glBindFragDataLocationIndexed` | definition | GL_VERSION_3_3:+:all | GL_ARB_blend_func_extended:all:all | unclassified | - | - | - | - |
| `glBindFragmentShaderATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glBindFramebuffer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | common | src/driver/opengl.ab draw read resolve and default framebuffer binding | src/driver/opengl.ab typed target and framebuffer-name ABI | tests/application/main.ab repeated offscreen MRT resolve and surfaced rendering | tests/application/main.ab incompatible target rejection |
| `glBindFramebufferEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glBindImageTexture` | definition | GL_VERSION_4_2:+:all | GL_ARB_shader_image_load_store:all:all | unclassified | - | - | - | - |
| `glBindImageTextureEXT` | definition |  | GL_EXT_shader_image_load_store:all:all | unclassified | - | - | - | - |
| `glBindImageTextures` | definition | GL_VERSION_4_4:+:all | GL_ARB_multi_bind:all:all | unclassified | - | - | - | - |
| `glBindLightParameterEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindMaterialParameterEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindMultiTextureEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glBindParameterEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindProgramARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glBindProgramNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glBindProgramPipeline` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glBindRenderbuffer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glBindRenderbufferEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glBindSampler` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | common | src/driver/opengl.ab sampled-texture sampler binding | src/driver/opengl.ab typed unit and sampler-name ABI | examples/common-textured/main.ab repeated sampled rendering with stable binding | examples/common-textured/main.ab missing shader binding rejection |
| `glBindSamplers` | definition | GL_VERSION_4_4:+:all | GL_ARB_multi_bind:all:all | unclassified | - | - | - | - |
| `glBindShadingRateImageNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glBindTexGenParameterEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindTexture` | definition | GL_VERSION_1_1:+:all |  | common | src/driver/opengl.ab texture allocation and checked upload binding | src/driver/opengl.ab typed target and name ABI | tests/application/main.ab exact texture upload and reupload readback | tests/application/main.ab upload range and texture validity rejection |
| `glBindTextureEXT` | definition |  | GL_EXT_texture_object:all:all | unclassified | - | - | - | - |
| `glBindTextureUnit` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab target-inherent sampled texture unit binding | src/driver/opengl.ab typed unit and texture name ABI | examples/wider-sampling/main.ab exact array cube and volume sampling | tests/application/main.ab reflected sampler dimension mismatch rejection |
| `glBindTextureUnitParameterEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindTextures` | definition | GL_VERSION_4_4:+:all | GL_ARB_multi_bind:all:all | unclassified | - | - | - | - |
| `glBindTransformFeedback` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glBindTransformFeedbackNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glBindVertexArray` | definition | GL_VERSION_3_0:+:all | GL_ARB_vertex_array_object:all:all | common | src/driver/opengl.ab raster vertex-state binding | src/driver/opengl.ab typed vertex-array name ABI | examples/common-triangle/main.ab repeated direct indexed and indirect rendering | examples/common-triangle/main.ab invalid layout pipeline rejection |
| `glBindVertexArrayAPPLE` | definition |  | GL_APPLE_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glBindVertexBuffer` | definition | GL_VERSION_4_3:+:all | GL_ARB_vertex_attrib_binding:all:all | unclassified | - | - | - | - |
| `glBindVertexBuffers` | definition | GL_VERSION_4_4:+:all | GL_ARB_multi_bind:all:all | unclassified | - | - | - | - |
| `glBindVertexShaderEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glBindVideoCaptureStreamBufferNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glBindVideoCaptureStreamTextureNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glBinormal3bEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3bvEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3dEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3dvEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3fEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3fvEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3iEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3ivEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3sEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormal3svEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBinormalPointerEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glBitmap` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glBitmapxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glBlendBarrierKHR` | definition |  | GL_KHR_blend_equation_advanced:all:all | unclassified | - | - | - | - |
| `glBlendBarrierNV` | definition |  | GL_NV_blend_equation_advanced:all:all | unclassified | - | - | - | - |
| `glBlendColor` | definition | GL_VERSION_1_4:+:all | GL_ARB_imaging:all:all | unclassified | - | - | - | - |
| `glBlendColorEXT` | definition |  | GL_EXT_blend_color:all:all | unclassified | - | - | - | - |
| `glBlendColorxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glBlendEquation` | definition | GL_VERSION_1_4:+:all | GL_ARB_imaging:all:all | unclassified | - | - | - | - |
| `glBlendEquationEXT` | definition |  | GL_EXT_blend_minmax:all:all | unclassified | - | - | - | - |
| `glBlendEquationIndexedAMD` | definition |  | GL_AMD_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendEquationSeparate` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab portable color and alpha blend equations | src/driver/opengl.ab typed equation-pair ABI | examples/common-triangle/main.ab repeated alpha-blended rendering | examples/common-triangle/main.ab invalid raster state rejection |
| `glBlendEquationSeparateEXT` | definition |  | GL_EXT_blend_equation_separate:all:all | unclassified | - | - | - | - |
| `glBlendEquationSeparateIndexedAMD` | definition |  | GL_AMD_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendEquationSeparatei` | definition | GL_VERSION_4_0:+:all |  | unclassified | - | - | - | - |
| `glBlendEquationSeparateiARB` | definition |  | GL_ARB_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendEquationi` | definition | GL_VERSION_4_0:+:all |  | unclassified | - | - | - | - |
| `glBlendEquationiARB` | definition |  | GL_ARB_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendFunc` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glBlendFuncIndexedAMD` | definition |  | GL_AMD_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendFuncSeparate` | definition | GL_VERSION_1_4:+:all |  | common | src/driver/opengl.ab portable source and destination blend factors | src/driver/opengl.ab typed color and alpha factor ABI | examples/common-triangle/main.ab repeated source-alpha rendering | examples/common-triangle/main.ab invalid raster state rejection |
| `glBlendFuncSeparateEXT` | definition |  | GL_EXT_blend_func_separate:all:all | unclassified | - | - | - | - |
| `glBlendFuncSeparateINGR` | definition |  | GL_INGR_blend_func_separate:all:all | unclassified | - | - | - | - |
| `glBlendFuncSeparateIndexedAMD` | definition |  | GL_AMD_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendFuncSeparatei` | definition | GL_VERSION_4_0:+:all |  | unclassified | - | - | - | - |
| `glBlendFuncSeparateiARB` | definition |  | GL_ARB_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendFunci` | definition | GL_VERSION_4_0:+:all |  | unclassified | - | - | - | - |
| `glBlendFunciARB` | definition |  | GL_ARB_draw_buffers_blend:all:all | unclassified | - | - | - | - |
| `glBlendParameteriNV` | definition |  | GL_NV_blend_equation_advanced:all:all | unclassified | - | - | - | - |
| `glBlitFramebuffer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | common | src/driver/opengl.ab render-target resolve | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact multisample resolve | tests/application/main.ab incompatible resolve rejection |
| `glBlitFramebufferEXT` | definition |  | GL_EXT_framebuffer_blit:all:all | unclassified | - | - | - | - |
| `glBlitFramebufferLayerEXT` | definition |  | GL_EXT_framebuffer_blit_layers:all:all | unclassified | - | - | - | - |
| `glBlitFramebufferLayersEXT` | definition |  | GL_EXT_framebuffer_blit_layers:all:all | unclassified | - | - | - | - |
| `glBlitNamedFramebuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glBufferAddressRangeNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glBufferAttachMemoryNV` | definition |  | GL_NV_memory_attachment:all:all | unclassified | - | - | - | - |
| `glBufferData` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab affine buffer storage allocation | src/driver/opengl.ab typed size and pointer ABI | tests/application/main.ab valid transfer and storage buffers | tests/application/main.ab zero-size and oversized buffer rejection |
| `glBufferDataARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glBufferPageCommitmentARB` | definition |  | GL_ARB_sparse_buffer:all:all | unclassified | - | - | - | - |
| `glBufferPageCommitmentMemNV` | definition |  | GL_NV_memory_object_sparse:all:all | unclassified | - | - | - | - |
| `glBufferParameteriAPPLE` | definition |  | GL_APPLE_flush_buffer_range:all:all | unclassified | - | - | - | - |
| `glBufferStorage` | definition | GL_VERSION_4_4:+:all | GL_ARB_buffer_storage:all:all | common | src/driver/opengl.ab immutable coherent persistent upload storage | src/driver/opengl.ab typed size data pointer and storage flags ABI | examples/common-buffer/main.ab repeated mapped GPU copies with zero growth | tests/core.ab persistent capability and descriptor rejection |
| `glBufferStorageExternalEXT` | definition |  | GL_EXT_external_buffer:all:all | unclassified | - | - | - | - |
| `glBufferStorageMemEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glBufferSubData` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab checked buffer upload | src/driver/opengl.ab typed offset size and pointer ABI | tests/application/main.ab exact partial and whole uploads | tests/application/main.ab range and usage rejection |
| `glBufferSubDataARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glCallCommandListNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glCallList` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glCallLists` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glCheckFramebufferStatus` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | common | src/driver/opengl.ab framebuffer completeness validation | src/driver/opengl.ab typed target result ABI | tests/application/main.ab color depth multisample and MRT target creation | tests/application/main.ab incompatible and missing attachment rejection |
| `glCheckFramebufferStatusEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glCheckNamedFramebufferStatus` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCheckNamedFramebufferStatusEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClampColor` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glClampColorARB` | definition |  | GL_ARB_color_buffer_float:all:all | unclassified | - | - | - | - |
| `glClear` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab surfaced color and depth clear execution | src/driver/opengl.ab typed mask ABI | tests/application/main.ab exact repeated color and depth output | tests/application/main.ab invalid clear descriptor rejection |
| `glClearAccum` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glClearAccumxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glClearBufferData` | definition | GL_VERSION_4_3:+:all | GL_ARB_clear_buffer_object:all:all | unclassified | - | - | - | - |
| `glClearBufferSubData` | definition | GL_VERSION_4_3:+:all | GL_ARB_clear_buffer_object:all:all | common | src/driver/opengl.ab GPU buffer fill | src/driver/opengl.ab typed clear-subrange ABI | tests/application/main.ab exact partial fill readback | tests/application/main.ab alignment range and usage rejection |
| `glClearBufferfi` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glClearBufferfv` | definition | GL_VERSION_3_0:+:all |  | common | src/driver/opengl.ab render-target clear | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact MRT clear | tests/application/main.ab attachment bounds rejection |
| `glClearBufferiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glClearBufferuiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glClearColor` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glClearColorIiEXT` | definition |  | GL_EXT_texture_integer:all:all | unclassified | - | - | - | - |
| `glClearColorIuiEXT` | definition |  | GL_EXT_texture_integer:all:all | unclassified | - | - | - | - |
| `glClearColorxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glClearDepth` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab depth clear state | src/driver/opengl.ab typed binary64 ABI | tests/application/main.ab exact depth-tested target output | tests/application/main.ab invalid depth target rejection |
| `glClearDepthdNV` | definition |  | GL_NV_depth_buffer_float:all:all | unclassified | - | - | - | - |
| `glClearDepthf` | definition | GL_VERSION_4_1:+:all | GL_ARB_ES2_compatibility:all:all | unclassified | - | - | - | - |
| `glClearDepthfOES` | definition |  | GL_OES_single_precision:all:all | unclassified | - | - | - | - |
| `glClearDepthxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glClearIndex` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glClearNamedBufferData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedBufferDataEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedBufferSubData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedBufferSubDataEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedFramebufferfi` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedFramebufferfv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedFramebufferiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearNamedFramebufferuiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClearStencil` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glClearTexImage` | definition | GL_VERSION_4_4:+:all | GL_ARB_clear_texture:all:all | unclassified | - | - | - | - |
| `glClearTexSubImage` | definition | GL_VERSION_4_4:+:all | GL_ARB_clear_texture:all:all | unclassified | - | - | - | - |
| `glClientActiveTexture` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glClientActiveTextureARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glClientActiveVertexStreamATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glClientAttribDefaultEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glClientWaitSemaphoreui64NVX` | definition |  | GL_NVX_progress_fence:all:all | unclassified | - | - | - | - |
| `glClientWaitSync` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab targeted copy completion | src/driver/opengl.ab typed sync flags and unsigned-timeout ABI | tests/transfer/main.ab nonblocking poll and explicit three-slot completion | tests/transfer/main.ab stale ticket and invalid range rejection |
| `glClipControl` | definition | GL_VERSION_4_5:+:all | GL_ARB_clip_control:all:all | unclassified | - | - | - | - |
| `glClipPlane` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glClipPlanefOES` | definition |  | GL_OES_single_precision:all:all | unclassified | - | - | - | - |
| `glClipPlanexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glColor3b` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3bv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor3fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glColor3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glColor3i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3ub` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3ubv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3ui` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3uiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3us` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3usv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor3xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glColor3xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glColor4b` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4bv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4fNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor4fNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor4fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glColor4hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glColor4i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4ub` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4ubVertex2fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor4ubVertex2fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor4ubVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor4ubVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glColor4ubv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4ui` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4uiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4us` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4usv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColor4xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glColor4xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glColorFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glColorFragmentOp1ATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glColorFragmentOp2ATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glColorFragmentOp3ATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glColorMask` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glColorMaskIndexedEXT` | definition |  | GL_EXT_draw_buffers2:all:all | unclassified | - | - | - | - |
| `glColorMaski` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glColorMaterial` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColorPointer` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glColorPointerEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glColorPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glColorPointervINTEL` | definition |  | GL_INTEL_parallel_arrays:all:all | unclassified | - | - | - | - |
| `glColorSubTableEXT` | definition |  | GL_EXT_color_subtable:all:all | unclassified | - | - | - | - |
| `glColorTableEXT` | definition |  | GL_EXT_paletted_texture:all:all | unclassified | - | - | - | - |
| `glColorTableParameterfvSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glColorTableParameterivSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glColorTableSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glCombinerInputNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glCombinerOutputNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glCombinerParameterfNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glCombinerParameterfvNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glCombinerParameteriNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glCombinerParameterivNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glCombinerStageParameterfvNV` | definition |  | GL_NV_register_combiners2:all:all | unclassified | - | - | - | - |
| `glCommandListSegmentsNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glCompileCommandListNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glCompileShader` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab GLSL source compilation | src/driver/opengl.ab typed shader-name ABI | tests/opengl/main.ab valid vertex and fragment compilation | tests/opengl/main.ab malformed source compiler rejection |
| `glCompileShaderARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glCompileShaderIncludeARB` | definition |  | GL_ARB_shading_language_include:all:all | unclassified | - | - | - | - |
| `glCompressedMultiTexImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedMultiTexImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedMultiTexImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedMultiTexSubImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedMultiTexSubImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedMultiTexSubImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTexImage1D` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glCompressedTexImage1DARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glCompressedTexImage2D` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glCompressedTexImage2DARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glCompressedTexImage3D` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glCompressedTexImage3DARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glCompressedTexSubImage1D` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glCompressedTexSubImage1DARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glCompressedTexSubImage2D` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glCompressedTexSubImage2DARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glCompressedTexSubImage3D` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glCompressedTexSubImage3DARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glCompressedTextureImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTextureImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTextureImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTextureSubImage1D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTextureSubImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTextureSubImage2D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab compressed two-dimensional byte upload | src/driver/opengl.ab typed DSA region format byte-count and pointer ABI | tests/wider_texture/main.ab and tests/wider_texture_transfer/main.ab exact pitched BC1 upload | tests/wider_texture/main.ab short source rejection |
| `glCompressedTextureSubImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCompressedTextureSubImage3D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab compressed pitched layered and volume byte upload | src/driver/opengl.ab typed DSA xyz extent format byte-count and pointer ABI | tests/wider_texture/main.ab exact pitched two-layer BC1 array round trip | tests/texture_contract.ab compressed crossing and pitch rejection |
| `glCompressedTextureSubImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glConservativeRasterParameterfNV` | definition |  | GL_NV_conservative_raster_dilate:all:all | unclassified | - | - | - | - |
| `glConservativeRasterParameteriNV` | definition |  | GL_NV_conservative_raster_pre_snap_triangles:all:all | unclassified | - | - | - | - |
| `glConvolutionFilter1DEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glConvolutionFilter2DEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glConvolutionParameterfEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glConvolutionParameterfvEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glConvolutionParameteriEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glConvolutionParameterivEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glConvolutionParameterxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glConvolutionParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glCopyBufferSubData` | definition | GL_VERSION_3_1:+:all | GL_ARB_copy_buffer:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab synchronous and queued GPU copies | src/driver/opengl.ab typed range ABI | tests/transfer/main.ab exact three-slot upload and readback | tests/transfer/main.ab invalid queued range rejection |
| `glCopyColorSubTableEXT` | definition |  | GL_EXT_color_subtable:all:all | unclassified | - | - | - | - |
| `glCopyColorTableSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glCopyConvolutionFilter1DEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glCopyConvolutionFilter2DEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glCopyImageSubData` | definition | GL_VERSION_4_3:+:all | GL_ARB_copy_image:all:all | common | src/driver/opengl.ab texture copy | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact texture copy | tests/application/main.ab incompatible copy rejection |
| `glCopyImageSubDataNV` | definition |  | GL_NV_copy_image:all:all | unclassified | - | - | - | - |
| `glCopyMultiTexImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyMultiTexImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyMultiTexSubImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyMultiTexSubImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyMultiTexSubImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyNamedBufferSubData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glCopyPixels` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glCopyTexImage1D` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glCopyTexImage1DEXT` | definition |  | GL_EXT_copy_texture:all:all | unclassified | - | - | - | - |
| `glCopyTexImage2D` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glCopyTexImage2DEXT` | definition |  | GL_EXT_copy_texture:all:all | unclassified | - | - | - | - |
| `glCopyTexSubImage1D` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glCopyTexSubImage1DEXT` | definition |  | GL_EXT_copy_texture:all:all | unclassified | - | - | - | - |
| `glCopyTexSubImage2D` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glCopyTexSubImage2DEXT` | definition |  | GL_EXT_copy_texture:all:all | unclassified | - | - | - | - |
| `glCopyTexSubImage3D` | definition | GL_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `glCopyTexSubImage3DEXT` | definition |  | GL_EXT_copy_texture:all:all | unclassified | - | - | - | - |
| `glCopyTextureImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureSubImage1D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureSubImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureSubImage2D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureSubImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureSubImage3D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCopyTextureSubImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCoverFillPathInstancedNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glCoverFillPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glCoverStrokePathInstancedNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glCoverStrokePathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glCoverageModulationNV` | definition |  | GL_NV_framebuffer_mixed_samples:all:all | unclassified | - | - | - | - |
| `glCoverageModulationTableNV` | definition |  | GL_NV_framebuffer_mixed_samples:all:all | unclassified | - | - | - | - |
| `glCreateBuffers` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateCommandListsNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glCreateFramebuffers` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateMemoryObjectsEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glCreatePerfQueryINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glCreateProgram` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab affine render and compute program creation | src/driver/opengl.ab typed result ABI | tests/opengl/main.ab valid linked program creation | tests/opengl/main.ab empty program link rejection |
| `glCreateProgramObjectARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glCreateProgramPipelines` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateProgressFenceNVX` | definition |  | GL_NVX_progress_fence:all:all | unclassified | - | - | - | - |
| `glCreateQueries` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateRenderbuffers` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateSamplers` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateSemaphoresNV` | definition |  | GL_NV_timeline_semaphore:all:all | unclassified | - | - | - | - |
| `glCreateShader` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab affine source and SPIR-V shader creation | src/driver/opengl.ab typed stage result ABI | tests/application/main.ab render and specialized compute shader creation | tests/opengl/main.ab malformed source rejection |
| `glCreateShaderObjectARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glCreateShaderProgramEXT` | definition |  | GL_EXT_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glCreateShaderProgramv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glCreateStatesNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glCreateSyncFromCLeventARB` | definition |  | GL_ARB_cl_event:all:all | unclassified | - | - | - | - |
| `glCreateTextures` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateTransformFeedbacks` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCreateVertexArrays` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glCullFace` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab portable front and back face culling | src/driver/opengl.ab typed face-mode ABI | examples/common-triangle/main.ab live front-cull alternate pipeline | examples/common-triangle/main.ab invalid cull mode rejection |
| `glCullParameterdvEXT` | definition |  | GL_EXT_cull_vertex:all:all | unclassified | - | - | - | - |
| `glCullParameterfvEXT` | definition |  | GL_EXT_cull_vertex:all:all | unclassified | - | - | - | - |
| `glCurrentPaletteMatrixARB` | definition |  | GL_ARB_matrix_palette:all:all | unclassified | - | - | - | - |
| `glDebugMessageCallback` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | common | src/driver/opengl_debug.ab optional debug callback ownership | src/driver/opengl_debug_callback.ab process-resolved Abla callback ABI | tests/opengl/main.ab exact injected message counts | tests/opengl/main.ab explicitly disabled messenger |
| `glDebugMessageCallbackAMD` | definition |  | GL_AMD_debug_output:all:all | unclassified | - | - | - | - |
| `glDebugMessageCallbackARB` | definition |  | GL_ARB_debug_output:all:all | unclassified | - | - | - | - |
| `glDebugMessageControl` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | common | src/driver/opengl_debug.ab all-severity debug configuration | src/driver/opengl_debug.ab typed extern signature | tests/opengl/main.ab high medium low and notification delivery | tests/opengl/main.ab invalid severity rejection |
| `glDebugMessageControlARB` | definition |  | GL_ARB_debug_output:all:all | unclassified | - | - | - | - |
| `glDebugMessageEnableAMD` | definition |  | GL_AMD_debug_output:all:all | unclassified | - | - | - | - |
| `glDebugMessageInsert` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | common | src/driver/opengl_debug.ab allocation-free debug message injection | src/driver/opengl_debug.ab reusable string ABI storage | tests/opengl/main.ab exact type and severity accounting | tests/opengl/main.ab invalid type and empty message rejection |
| `glDebugMessageInsertAMD` | definition |  | GL_AMD_debug_output:all:all | unclassified | - | - | - | - |
| `glDebugMessageInsertARB` | definition |  | GL_ARB_debug_output:all:all | unclassified | - | - | - | - |
| `glDeformSGIX` | definition |  | GL_SGIX_polynomial_ffd:all:all | unclassified | - | - | - | - |
| `glDeformationMap3dSGIX` | definition |  | GL_SGIX_polynomial_ffd:all:all | unclassified | - | - | - | - |
| `glDeformationMap3fSGIX` | definition |  | GL_SGIX_polynomial_ffd:all:all | unclassified | - | - | - | - |
| `glDeleteAsyncMarkersSGIX` | definition |  | GL_SGIX_async:all:all | unclassified | - | - | - | - |
| `glDeleteBuffers` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab affine buffer lifetime | src/driver/opengl.ab typed extern signature | tests/application/main.ab repeated buffer lifecycle | tests/application/main.ab invalid buffer descriptor rejection |
| `glDeleteBuffersARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glDeleteCommandListsNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glDeleteFencesAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glDeleteFencesNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glDeleteFragmentShaderATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glDeleteFramebuffers` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | common | src/driver/opengl.ab affine framebuffer and resolve lifetime | src/driver/opengl.ab typed name-array ABI | tests/application/main.ab stable repeated target lifecycle | tests/application/main.ab failed target cleanup |
| `glDeleteFramebuffersEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glDeleteLists` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glDeleteMemoryObjectsEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glDeleteNamedStringARB` | definition |  | GL_ARB_shading_language_include:all:all | unclassified | - | - | - | - |
| `glDeleteNamesAMD` | definition |  | GL_AMD_name_gen_delete:all:all | unclassified | - | - | - | - |
| `glDeleteObjectARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glDeleteOcclusionQueriesNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glDeletePathsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glDeletePerfMonitorsAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glDeletePerfQueryINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glDeleteProgram` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab affine program lifetime | src/driver/opengl.ab typed program-name ABI | tests/opengl/main.ab valid program drop invalidates wrapper | tests/opengl/main.ab rejected empty program cleanup |
| `glDeleteProgramPipelines` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glDeleteProgramsARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glDeleteProgramsNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glDeleteQueries` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab timestamp query lifetime | src/driver/opengl.ab typed extern signature | tests/application/main.ab affine timestamp query drop | tests/application/main.ab invalid application rejection |
| `glDeleteQueriesARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glDeleteQueryResourceTagNV` | definition |  | GL_NV_query_resource_tag:all:all | unclassified | - | - | - | - |
| `glDeleteRenderbuffers` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glDeleteRenderbuffersEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glDeleteSamplers` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | common | src/driver/opengl.ab affine sampler lifetime | src/driver/opengl.ab typed name-array ABI | tests/application/main.ab comparison and anisotropic sampler lifecycle | src/sampler.ab invalid application and descriptor rejection |
| `glDeleteSemaphoresEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glDeleteShader` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab affine attached-shader lifetime | src/driver/opengl.ab typed shader-name ABI | tests/opengl/main.ab linked source shader cleanup | tests/opengl/main.ab failed compile cleanup |
| `glDeleteStatesNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glDeleteSync` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab affine copy-fence lifetime | src/driver/opengl.ab typed opaque sync-pointer ABI | tests/transfer/main.ab repeated queued copies with zero live growth | src/driver/opengl_transfer.ab failed submit and slot-drop cleanup |
| `glDeleteTextures` | definition | GL_VERSION_1_1:+:all |  | common | src/driver/opengl.ab affine texture lifetime | src/driver/opengl.ab typed name-array ABI | tests/application/main.ab texture target and upload lifecycle | tests/application/main.ab invalid texture descriptor rejection |
| `glDeleteTexturesEXT` | definition |  | GL_EXT_texture_object:all:all | unclassified | - | - | - | - |
| `glDeleteTransformFeedbacks` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glDeleteTransformFeedbacksNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glDeleteVertexArrays` | definition | GL_VERSION_3_0:+:all | GL_ARB_vertex_array_object:all:all | common | src/driver/opengl.ab affine raster vertex-state lifetime | src/driver/opengl.ab typed name-array ABI | examples/common-triangle/main.ab alternate pipeline drop and stable primary state | examples/common-triangle/main.ab invalid pipeline cleanup |
| `glDeleteVertexArraysAPPLE` | definition |  | GL_APPLE_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glDeleteVertexShaderEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glDepthBoundsEXT` | definition |  | GL_EXT_depth_bounds_test:all:all | unclassified | - | - | - | - |
| `glDepthBoundsdNV` | definition |  | GL_NV_depth_buffer_float:all:all | unclassified | - | - | - | - |
| `glDepthFunc` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab portable depth comparison state | src/driver/opengl.ab typed comparison ABI | examples/common-triangle/main.ab repeated less-depth rendering | examples/common-triangle/main.ab invalid depth state rejection |
| `glDepthMask` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab portable depth write state | src/driver/opengl.ab typed boolean ABI | examples/common-triangle/main.ab enabled depth-write rendering | examples/common-triangle/main.ab write-without-depth rejection |
| `glDepthRange` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glDepthRangeArraydvNV` | definition |  | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glDepthRangeArrayv` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glDepthRangeIndexed` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glDepthRangeIndexeddNV` | definition |  | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glDepthRangedNV` | definition |  | GL_NV_depth_buffer_float:all:all | unclassified | - | - | - | - |
| `glDepthRangef` | definition | GL_VERSION_4_1:+:all | GL_ARB_ES2_compatibility:all:all | unclassified | - | - | - | - |
| `glDepthRangefOES` | definition |  | GL_OES_single_precision:all:all | unclassified | - | - | - | - |
| `glDepthRangexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glDetachObjectARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glDetachShader` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glDetailTexFuncSGIS` | definition |  | GL_SGIS_detail_texture:all:all | unclassified | - | - | - | - |
| `glDisable` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab cull blend and depth state disablement | src/driver/opengl.ab typed capability ABI | examples/common-triangle/main.ab alternate and primary fixed-function state transitions | examples/common-triangle/main.ab descriptor validation before state mutation |
| `glDisableClientState` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glDisableClientStateIndexedEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glDisableClientStateiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glDisableIndexedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_draw_buffers2:all:all | unclassified | - | - | - | - |
| `glDisableVariantClientStateEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glDisableVertexArrayAttrib` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glDisableVertexArrayAttribEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glDisableVertexArrayEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glDisableVertexAttribAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glDisableVertexAttribArray` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glDisableVertexAttribArrayARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glDisablei` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glDispatchCompute` | definition | GL_VERSION_4_3:+:all | GL_ARB_compute_shader:all:all | common | src/driver/opengl.ab reflected compute workgroup dispatch | src/driver/opengl.ab typed three-axis group-count ABI | examples/common-compute/main.ab repeated storage and push compute output | tests/application/main.ab zero and limit-exceeding dispatch rejection |
| `glDispatchComputeGroupSizeARB` | definition |  | GL_ARB_compute_variable_group_size:all:all | unclassified | - | - | - | - |
| `glDispatchComputeIndirect` | definition | GL_VERSION_4_3:+:all | GL_ARB_compute_shader:all:all | unclassified | - | - | - | - |
| `glDrawArrays` | definition | GL_VERSION_1_1:+:all |  | common | src/driver/opengl.ab allocation-free pixel and simple triangle drawing | src/driver/opengl.ab typed mode first and count ABI | tests/application/main.ab exact repeated pixel and triangle presentation | tests/application/main.ab invalid vertex range rejection |
| `glDrawArraysEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glDrawArraysIndirect` | definition | GL_VERSION_4_0:+:all | GL_ARB_draw_indirect:all:all | common | src/driver/opengl.ab offset-aware indirect non-indexed rendering | src/driver/opengl.ab typed mode and indirect-pointer ABI | examples/render-to-texture/main.ab nonzero pooled render-pass vertex-indirect rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `glDrawArraysInstanced` | definition | GL_VERSION_3_1:+:all |  | common | src/driver/opengl.ab direct instanced vertex rendering | src/driver/opengl.ab typed mode range and instance-count ABI | tests/application/main.ab repeated direct triangle presentation | examples/common-triangle/main.ab zero instance-count rejection |
| `glDrawArraysInstancedARB` | definition |  | GL_ARB_draw_instanced:all:all | unclassified | - | - | - | - |
| `glDrawArraysInstancedBaseInstance` | definition | GL_VERSION_4_2:+:all | GL_ARB_base_instance:all:all | unclassified | - | - | - | - |
| `glDrawArraysInstancedEXT` | definition |  | GL_EXT_draw_instanced:all:all | unclassified | - | - | - | - |
| `glDrawBuffer` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glDrawBuffers` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab MRT setup | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact dual attachment output | tests/application/main.ab attachment count rejection |
| `glDrawBuffersARB` | definition |  | GL_ARB_draw_buffers:all:all | unclassified | - | - | - | - |
| `glDrawBuffersATI` | definition |  | GL_ATI_draw_buffers:all:all | unclassified | - | - | - | - |
| `glDrawCommandsAddressNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glDrawCommandsNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glDrawCommandsStatesAddressNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glDrawCommandsStatesNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glDrawElementArrayAPPLE` | definition |  | GL_APPLE_element_array:all:all | unclassified | - | - | - | - |
| `glDrawElementArrayATI` | definition |  | GL_ATI_element_array:all:all | unclassified | - | - | - | - |
| `glDrawElements` | definition | GL_VERSION_1_1:+:all |  | common | src/driver/opengl.ab offset-aware single-instance indexed drawing | src/driver/opengl.ab typed mode count index-type and pointer ABI | examples/render-to-texture/main.ab nonzero pooled render-pass indexed rendering | tests/pool/main.ab surfaced and offscreen short range rejection |
| `glDrawElementsBaseVertex` | definition | GL_VERSION_3_2:+:all | GL_ARB_draw_elements_base_vertex:all:all | unclassified | - | - | - | - |
| `glDrawElementsIndirect` | definition | GL_VERSION_4_0:+:all | GL_ARB_draw_indirect:all:all | common | src/driver/opengl.ab offset-aware indirect indexed rendering | src/driver/opengl.ab typed mode index-type and indirect-pointer ABI | tests/pool/main.ab absolute-firstIndex pooled target exact-pixel rendering | tests/pool/main.ab offscreen short and stale range rejection |
| `glDrawElementsInstanced` | definition | GL_VERSION_3_1:+:all |  | common | src/driver/opengl.ab direct indexed instanced rendering | src/driver/opengl.ab typed mode count index-type pointer and instances ABI | examples/common-triangle/main.ab live indexed two-instance rendering | examples/common-triangle/main.ab invalid index count and instances rejection |
| `glDrawElementsInstancedARB` | definition |  | GL_ARB_draw_instanced:all:all | unclassified | - | - | - | - |
| `glDrawElementsInstancedBaseInstance` | definition | GL_VERSION_4_2:+:all | GL_ARB_base_instance:all:all | unclassified | - | - | - | - |
| `glDrawElementsInstancedBaseVertex` | definition | GL_VERSION_3_2:+:all | GL_ARB_draw_elements_base_vertex:all:all | unclassified | - | - | - | - |
| `glDrawElementsInstancedBaseVertexBaseInstance` | definition | GL_VERSION_4_2:+:all | GL_ARB_base_instance:all:all | unclassified | - | - | - | - |
| `glDrawElementsInstancedEXT` | definition |  | GL_EXT_draw_instanced:all:all | unclassified | - | - | - | - |
| `glDrawMeshArraysSUN` | definition |  | GL_SUN_mesh_array:all:all | unclassified | - | - | - | - |
| `glDrawMeshTasksEXT` | definition |  | GL_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `glDrawMeshTasksIndirectEXT` | definition |  | GL_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `glDrawMeshTasksIndirectNV` | definition |  | GL_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `glDrawMeshTasksNV` | definition |  | GL_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `glDrawPixels` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glDrawRangeElementArrayAPPLE` | definition |  | GL_APPLE_element_array:all:all | unclassified | - | - | - | - |
| `glDrawRangeElementArrayATI` | definition |  | GL_ATI_element_array:all:all | unclassified | - | - | - | - |
| `glDrawRangeElements` | definition | GL_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `glDrawRangeElementsBaseVertex` | definition | GL_VERSION_3_2:+:all | GL_ARB_draw_elements_base_vertex:all:all | unclassified | - | - | - | - |
| `glDrawRangeElementsEXT` | definition |  | GL_EXT_draw_range_elements:all:all | unclassified | - | - | - | - |
| `glDrawTextureNV` | definition |  | GL_NV_draw_texture:all:all | unclassified | - | - | - | - |
| `glDrawTransformFeedback` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glDrawTransformFeedbackInstanced` | definition | GL_VERSION_4_2:+:all | GL_ARB_transform_feedback_instanced:all:all | unclassified | - | - | - | - |
| `glDrawTransformFeedbackNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glDrawTransformFeedbackStream` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback3:all:all | unclassified | - | - | - | - |
| `glDrawTransformFeedbackStreamInstanced` | definition | GL_VERSION_4_2:+:all | GL_ARB_transform_feedback_instanced:all:all | unclassified | - | - | - | - |
| `glDrawVkImageNV` | definition |  | GL_NV_draw_vulkan_image:all:all | unclassified | - | - | - | - |
| `glEGLImageTargetTexStorageEXT` | definition |  | GL_EXT_EGL_image_storage:all:all | unclassified | - | - | - | - |
| `glEGLImageTargetTextureStorageEXT` | definition |  | GL_EXT_EGL_image_storage:all:all | unclassified | - | - | - | - |
| `glEdgeFlag` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEdgeFlagFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glEdgeFlagPointer` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEdgeFlagPointerEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glEdgeFlagPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glEdgeFlagv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glElementPointerAPPLE` | definition |  | GL_APPLE_element_array:all:all | unclassified | - | - | - | - |
| `glElementPointerATI` | definition |  | GL_ATI_element_array:all:all | unclassified | - | - | - | - |
| `glEnable` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab cull blend and depth state enablement | src/driver/opengl.ab typed capability ABI | examples/common-triangle/main.ab live cull blend and depth pipelines | examples/common-triangle/main.ab invalid raster and depth rejection |
| `glEnableClientState` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEnableClientStateIndexedEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glEnableClientStateiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glEnableIndexedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_draw_buffers2:all:all | unclassified | - | - | - | - |
| `glEnableVariantClientStateEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glEnableVertexArrayAttrib` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glEnableVertexArrayAttribEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glEnableVertexArrayEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glEnableVertexAttribAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glEnableVertexAttribArray` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab reflected vertex attribute enablement | src/driver/opengl.ab typed location ABI | examples/common-triangle/main.ab interleaved position and color attributes | examples/common-triangle/main.ab mismatched vertex layout rejection |
| `glEnableVertexAttribArrayARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glEnablei` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glEnd` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEndConditionalRender` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glEndConditionalRenderNV` | definition |  | GL_NV_conditional_render:all:all | unclassified | - | - | - | - |
| `glEndConditionalRenderNVX` | definition |  | GL_NVX_conditional_render:all:all | unclassified | - | - | - | - |
| `glEndFragmentShaderATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glEndList` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEndOcclusionQueryNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glEndPerfMonitorAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glEndPerfQueryINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glEndQuery` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glEndQueryARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glEndQueryIndexed` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback3:all:all | unclassified | - | - | - | - |
| `glEndTransformFeedback` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glEndTransformFeedbackEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glEndTransformFeedbackNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glEndVertexShaderEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glEndVideoCaptureNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glEvalCoord1d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord1dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord1f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord1fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord1xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glEvalCoord1xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glEvalCoord2d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord2dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord2f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord2fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalCoord2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glEvalCoord2xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glEvalMapsNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glEvalMesh1` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalMesh2` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalPoint1` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvalPoint2` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glEvaluateDepthValuesARB` | definition |  | GL_ARB_sample_locations:all:all | unclassified | - | - | - | - |
| `glExecuteProgramNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glExtractComponentEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glFeedbackBuffer` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFeedbackBufferxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glFenceSync` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab synchronous and queued copy fences | src/driver/opengl.ab typed condition flags and opaque result ABI | tests/transfer/main.ab three simultaneous native in-flight slots | tests/transfer/main.ab invalid queued range rejection |
| `glFinalCombinerInputNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glFinish` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab portable idle wait | src/driver/opengl.ab typed extern signature | tests/application/main.ab repeated application waitIdle | tests/application/main.ab invalid application rejection |
| `glFinishAsyncSGIX` | definition |  | GL_SGIX_async:all:all | unclassified | - | - | - | - |
| `glFinishFenceAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glFinishFenceNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glFinishObjectAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glFinishTextureSUNX` | definition |  | GL_SUNX_constant_data:all:all | unclassified | - | - | - | - |
| `glFlush` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glFlushMappedBufferRange` | definition | GL_VERSION_3_0:+:all | GL_ARB_map_buffer_range:all:all | unclassified | - | - | - | - |
| `glFlushMappedBufferRangeAPPLE` | definition |  | GL_APPLE_flush_buffer_range:all:all | unclassified | - | - | - | - |
| `glFlushMappedNamedBufferRange` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glFlushMappedNamedBufferRangeEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glFlushPixelDataRangeNV` | definition |  | GL_NV_pixel_data_range:all:all | unclassified | - | - | - | - |
| `glFlushRasterSGIX` | definition |  | GL_SGIX_flush_raster:all:all | unclassified | - | - | - | - |
| `glFlushStaticDataIBM` | definition |  | GL_IBM_static_data:all:all | unclassified | - | - | - | - |
| `glFlushVertexArrayRangeAPPLE` | definition |  | GL_APPLE_vertex_array_range:all:all | unclassified | - | - | - | - |
| `glFlushVertexArrayRangeNV` | definition |  | GL_NV_vertex_array_range:all:all | unclassified | - | - | - | - |
| `glFogCoordFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glFogCoordPointer` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogCoordPointerEXT` | definition |  | GL_EXT_fog_coord:all:all | unclassified | - | - | - | - |
| `glFogCoordPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glFogCoordd` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogCoorddEXT` | definition |  | GL_EXT_fog_coord:all:all | unclassified | - | - | - | - |
| `glFogCoorddv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogCoorddvEXT` | definition |  | GL_EXT_fog_coord:all:all | unclassified | - | - | - | - |
| `glFogCoordf` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogCoordfEXT` | definition |  | GL_EXT_fog_coord:all:all | unclassified | - | - | - | - |
| `glFogCoordfv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogCoordfvEXT` | definition |  | GL_EXT_fog_coord:all:all | unclassified | - | - | - | - |
| `glFogCoordhNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glFogCoordhvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glFogFuncSGIS` | definition |  | GL_SGIS_fog_function:all:all | unclassified | - | - | - | - |
| `glFogf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogi` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFogxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glFogxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glFragmentColorMaterialSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentCoverageColorNV` | definition |  | GL_NV_fragment_coverage_to_color:all:all | unclassified | - | - | - | - |
| `glFragmentLightModelfSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightModelfvSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightModeliSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightModelivSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightfSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightfvSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightiSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentLightivSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentMaterialfSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentMaterialfvSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentMaterialiSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFragmentMaterialivSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glFrameTerminatorGREMEDY` | definition |  | GL_GREMEDY_frame_terminator:all:all | unclassified | - | - | - | - |
| `glFrameZoomSGIX` | definition |  | GL_SGIX_framezoom:all:all | unclassified | - | - | - | - |
| `glFramebufferDrawBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glFramebufferDrawBuffersEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glFramebufferFetchBarrierEXT` | definition |  | GL_EXT_shader_framebuffer_fetch_non_coherent:all:all | unclassified | - | - | - | - |
| `glFramebufferParameteri` | definition | GL_VERSION_4_3:+:all | GL_ARB_framebuffer_no_attachments:all:all | unclassified | - | - | - | - |
| `glFramebufferParameteriMESA` | definition |  | GL_MESA_framebuffer_flip_y:all:all | unclassified | - | - | - | - |
| `glFramebufferReadBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glFramebufferRenderbuffer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferRenderbufferEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferSampleLocationsfvARB` | definition |  | GL_ARB_sample_locations:all:all | unclassified | - | - | - | - |
| `glFramebufferSampleLocationsfvNV` | definition |  | GL_NV_sample_locations:all:all | unclassified | - | - | - | - |
| `glFramebufferSamplePositionsfvAMD` | definition |  | GL_AMD_framebuffer_sample_positions:all:all | unclassified | - | - | - | - |
| `glFramebufferShadingRateEXT` | definition |  | GL_EXT_fragment_shading_rate:all:all | unclassified | - | - | - | - |
| `glFramebufferTexture` | definition | GL_VERSION_3_2:+:all |  | unclassified | - | - | - | - |
| `glFramebufferTexture1D` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferTexture1DEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferTexture2D` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | common | src/driver/opengl.ab target setup | src/driver/opengl.ab typed extern signature | tests/application/main.ab render-to-texture output | tests/application/main.ab incompatible attachment rejection |
| `glFramebufferTexture2DEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferTexture3D` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferTexture3DEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureARB` | definition |  | GL_ARB_geometry_shader4:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureEXT` | definition |  | GL_NV_geometry_program4:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureFaceARB` | definition |  | GL_ARB_geometry_shader4:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureFaceEXT` | definition |  | GL_NV_geometry_program4:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureLayer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureLayerARB` | definition |  | GL_ARB_geometry_shader4:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureLayerEXT` | definition |  | GL_EXT_texture_array:all:all|GL_NV_geometry_program4:all:all | unclassified | - | - | - | - |
| `glFramebufferTextureMultiviewOVR` | definition |  | GL_OVR_multiview:all:all | unclassified | - | - | - | - |
| `glFreeObjectBufferATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glFrontFace` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab portable winding state | src/driver/opengl.ab typed winding ABI | examples/common-triangle/main.ab clockwise and counter-clockwise pipelines | examples/common-triangle/main.ab invalid front-face rejection |
| `glFrustum` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glFrustumfOES` | definition |  | GL_OES_single_precision:all:all | unclassified | - | - | - | - |
| `glFrustumxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGenAsyncMarkersSGIX` | definition |  | GL_SGIX_async:all:all | unclassified | - | - | - | - |
| `glGenBuffers` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab affine buffer creation | src/driver/opengl.ab typed output-pointer ABI | tests/application/main.ab valid transfer and storage buffers | tests/application/main.ab invalid buffer descriptor rejection |
| `glGenBuffersARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glGenFencesAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glGenFencesNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glGenFragmentShadersATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glGenFramebuffers` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | common | src/driver/opengl.ab affine framebuffer and resolve creation | src/driver/opengl.ab typed output-pointer ABI | tests/application/main.ab color depth multisample and MRT targets | tests/application/main.ab incompatible attachment rejection |
| `glGenFramebuffersEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGenLists` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGenNamesAMD` | definition |  | GL_AMD_name_gen_delete:all:all | unclassified | - | - | - | - |
| `glGenOcclusionQueriesNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGenPathsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGenPerfMonitorsAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGenProgramPipelines` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glGenProgramsARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGenProgramsNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGenQueries` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab timestamp query creation | src/driver/opengl.ab typed extern signature | tests/application/main.ab timestamp query creation | tests/application/main.ab invalid application rejection |
| `glGenQueriesARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGenQueryResourceTagNV` | definition |  | GL_NV_query_resource_tag:all:all | unclassified | - | - | - | - |
| `glGenRenderbuffers` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGenRenderbuffersEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGenSamplers` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | common | src/driver/opengl.ab affine sampler creation | src/driver/opengl.ab typed output-pointer ABI | tests/application/main.ab comparison and anisotropic sampler creation | src/sampler.ab unsupported comparison and anisotropy rejection |
| `glGenSemaphoresEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glGenSymbolsEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGenTextures` | definition | GL_VERSION_1_1:+:all |  | common | src/driver/opengl.ab affine texture creation | src/driver/opengl.ab typed output-pointer ABI | tests/application/main.ab valid sampled transfer and render-target textures | tests/application/main.ab invalid texture descriptor rejection |
| `glGenTexturesEXT` | definition |  | GL_EXT_texture_object:all:all | unclassified | - | - | - | - |
| `glGenTransformFeedbacks` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glGenTransformFeedbacksNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glGenVertexArrays` | definition | GL_VERSION_3_0:+:all | GL_ARB_vertex_array_object:all:all | common | src/driver/opengl.ab affine raster vertex-state creation | src/driver/opengl.ab typed output-pointer ABI | examples/common-triangle/main.ab live pipeline creation with stable vertex array | examples/common-triangle/main.ab invalid pipeline cleanup |
| `glGenVertexArraysAPPLE` | definition |  | GL_APPLE_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGenVertexShadersEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGenerateMipmap` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGenerateMipmapEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGenerateMultiTexMipmapEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGenerateTextureMipmap` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab mip generation | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact first and final mip | tests/application/main.ab invalid mip generation rejection |
| `glGenerateTextureMipmapEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetActiveAtomicCounterBufferiv` | definition | GL_VERSION_4_2:+:all | GL_ARB_shader_atomic_counters:all:all | unclassified | - | - | - | - |
| `glGetActiveAttrib` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetActiveAttribARB` | definition |  | GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetActiveSubroutineName` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetActiveSubroutineUniformName` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetActiveSubroutineUniformiv` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetActiveUniform` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetActiveUniformARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetActiveUniformBlockName` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetActiveUniformBlockiv` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetActiveUniformName` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetActiveUniformsiv` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetActiveVaryingNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glGetArrayObjectfvATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGetArrayObjectivATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGetAttachedObjectsARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetAttachedShaders` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetAttribLocation` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetAttribLocationARB` | definition |  | GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetBooleanIndexedvEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_draw_buffers2:all:all | unclassified | - | - | - | - |
| `glGetBooleani_v` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetBooleanv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetBufferParameteri64v` | definition | GL_VERSION_3_2:+:all |  | unclassified | - | - | - | - |
| `glGetBufferParameteriv` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glGetBufferParameterivARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetBufferParameterui64vNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glGetBufferPointerv` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glGetBufferPointervARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetBufferSubData` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab checked buffer readback | src/driver/opengl.ab typed offset size and pointer ABI | tests/application/main.ab exact partial and whole readback | tests/application/main.ab range and usage rejection |
| `glGetBufferSubDataARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetClipPlane` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetClipPlanefOES` | definition |  | GL_OES_single_precision:all:all | unclassified | - | - | - | - |
| `glGetClipPlanexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetColorTableEXT` | definition |  | GL_EXT_paletted_texture:all:all | unclassified | - | - | - | - |
| `glGetColorTableParameterfvEXT` | definition |  | GL_EXT_paletted_texture:all:all | unclassified | - | - | - | - |
| `glGetColorTableParameterfvSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glGetColorTableParameterivEXT` | definition |  | GL_EXT_paletted_texture:all:all | unclassified | - | - | - | - |
| `glGetColorTableParameterivSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glGetColorTableSGI` | definition |  | GL_SGI_color_table:all:all | unclassified | - | - | - | - |
| `glGetCombinerInputParameterfvNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glGetCombinerInputParameterivNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glGetCombinerOutputParameterfvNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glGetCombinerOutputParameterivNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glGetCombinerStageParameterfvNV` | definition |  | GL_NV_register_combiners2:all:all | unclassified | - | - | - | - |
| `glGetCommandHeaderNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glGetCompressedMultiTexImageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetCompressedTexImage` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glGetCompressedTexImageARB` | definition |  | GL_ARB_texture_compression:all:all | unclassified | - | - | - | - |
| `glGetCompressedTextureImage` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetCompressedTextureImageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetCompressedTextureSubImage` | definition | GL_VERSION_4_5:+:all | GL_ARB_get_texture_sub_image:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab compressed texture readback | src/driver/opengl.ab typed region buffer-size and byte-pointer ABI | tests/wider_texture/main.ab and tests/wider_texture_transfer/main.ab exact pitched BC1 readback | tests/wider_texture/main.ab short destination rejection |
| `glGetConvolutionFilterEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glGetConvolutionParameterfvEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glGetConvolutionParameterivEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glGetConvolutionParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetCoverageModulationTableNV` | definition |  | GL_NV_framebuffer_mixed_samples:all:all | unclassified | - | - | - | - |
| `glGetDebugMessageLog` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glGetDebugMessageLogAMD` | definition |  | GL_AMD_debug_output:all:all | unclassified | - | - | - | - |
| `glGetDebugMessageLogARB` | definition |  | GL_ARB_debug_output:all:all | unclassified | - | - | - | - |
| `glGetDetailTexFuncSGIS` | definition |  | GL_SGIS_detail_texture:all:all | unclassified | - | - | - | - |
| `glGetDoubleIndexedvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetDoublei_v` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glGetDoublei_vEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetDoublev` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetError` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab checked driver failure boundary | src/driver/opengl.ab typed error-code result ABI | tests/opengl/main.ab successful program use and malformed shader rejection | tests/application/main.ab unsupported OpenGL feature rejection |
| `glGetFenceivNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glGetFinalCombinerInputParameterfvNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glGetFinalCombinerInputParameterivNV` | definition |  | GL_NV_register_combiners:all:all | unclassified | - | - | - | - |
| `glGetFirstPerfQueryIdINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glGetFixedvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetFloatIndexedvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetFloati_v` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glGetFloati_vEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetFloatv` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab sampler anisotropy capability query | src/driver/opengl.ab typed floating output-pointer ABI | tests/opengl/main.ab validated maximum anisotropy at least 16 | src/driver/opengl.ab conservative one-times fallback |
| `glGetFogFuncSGIS` | definition |  | GL_SGIS_fog_function:all:all | unclassified | - | - | - | - |
| `glGetFragDataIndex` | definition | GL_VERSION_3_3:+:all | GL_ARB_blend_func_extended:all:all | unclassified | - | - | - | - |
| `glGetFragDataLocation` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetFragDataLocationEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glGetFragmentLightfvSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glGetFragmentLightivSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glGetFragmentMaterialfvSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glGetFragmentMaterialivSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glGetFragmentShadingRatesEXT` | definition |  | GL_EXT_fragment_shading_rate:all:all | unclassified | - | - | - | - |
| `glGetFramebufferAttachmentParameteriv` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGetFramebufferAttachmentParameterivEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGetFramebufferParameterfvAMD` | definition |  | GL_AMD_framebuffer_sample_positions:all:all | unclassified | - | - | - | - |
| `glGetFramebufferParameteriv` | definition | GL_VERSION_4_3:+:all | GL_ARB_framebuffer_no_attachments:all:all | unclassified | - | - | - | - |
| `glGetFramebufferParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetFramebufferParameterivMESA` | definition |  | GL_MESA_framebuffer_flip_y:all:all | unclassified | - | - | - | - |
| `glGetGraphicsResetStatus` | definition | GL_VERSION_4_5:+:all | GL_KHR_robustness:all:all | unclassified | - | - | - | - |
| `glGetGraphicsResetStatusARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGetHandleARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetHistogramEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glGetHistogramParameterfvEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glGetHistogramParameterivEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glGetHistogramParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetImageHandleARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetImageHandleNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetImageTransformParameterfvHP` | definition |  | GL_HP_image_transform:all:all | unclassified | - | - | - | - |
| `glGetImageTransformParameterivHP` | definition |  | GL_HP_image_transform:all:all | unclassified | - | - | - | - |
| `glGetInfoLogARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetInstrumentsSGIX` | definition |  | GL_SGIX_instruments:all:all | unclassified | - | - | - | - |
| `glGetInteger64i_v` | definition | GL_VERSION_3_2:+:all |  | unclassified | - | - | - | - |
| `glGetInteger64v` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | common | src/driver/opengl.ab storage-buffer limit query | src/driver/opengl.ab typed 64-bit output-pointer ABI | tests/opengl/main.ab validated positive storage limit | src/driver/opengl.ab bounded portable storage cap |
| `glGetIntegerIndexedvEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_draw_buffers2:all:all | unclassified | - | - | - | - |
| `glGetIntegeri_v` | definition | GL_VERSION_3_0:+:all|GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | common | src/driver/opengl.ab indexed compute workgroup limit query | src/driver/opengl.ab typed name index and output ABI | tests/opengl/main.ab validated three-axis group and local limits | tests/application/main.ab limit-exceeding dispatch rejection |
| `glGetIntegerui64i_vNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glGetIntegerui64vNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glGetIntegerv` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab version extension and scalar limit queries | src/driver/opengl.ab typed integer output-pointer ABI | tests/opengl/main.ab validated version texture compute and extension counts | src/driver/opengl.ab conservative defaults for unavailable limits |
| `glGetInternalformatSampleivNV` | definition |  | GL_NV_internalformat_sample_query:all:all | unclassified | - | - | - | - |
| `glGetInternalformati64v` | definition | GL_VERSION_4_3:+:all | GL_ARB_internalformat_query2:all:all | unclassified | - | - | - | - |
| `glGetInternalformativ` | definition | GL_VERSION_4_2:+:all | GL_ARB_internalformat_query:all:all | unclassified | - | - | - | - |
| `glGetInvariantBooleanvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetInvariantFloatvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetInvariantIntegervEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetLightfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetLightiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetLightxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetListParameterfvSGIX` | definition |  | GL_SGIX_list_priority:all:all | unclassified | - | - | - | - |
| `glGetListParameterivSGIX` | definition |  | GL_SGIX_list_priority:all:all | unclassified | - | - | - | - |
| `glGetLocalConstantBooleanvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetLocalConstantFloatvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetLocalConstantIntegervEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetMapAttribParameterfvNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glGetMapAttribParameterivNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glGetMapControlPointsNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glGetMapParameterfvNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glGetMapParameterivNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glGetMapdv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetMapfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetMapiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetMapxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetMaterialfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetMaterialiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetMaterialxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetMemoryObjectDetachedResourcesuivNV` | definition |  | GL_NV_memory_attachment:all:all | unclassified | - | - | - | - |
| `glGetMemoryObjectParameterivEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glGetMinmaxEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glGetMinmaxParameterfvEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glGetMinmaxParameterivEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glGetMultiTexEnvfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexEnvivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexGendvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexGenfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexGenivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexImageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexLevelParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexLevelParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexParameterIivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexParameterIuivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultiTexParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetMultisamplefv` | definition | GL_VERSION_3_2:+:all | GL_ARB_texture_multisample:all:all | unclassified | - | - | - | - |
| `glGetMultisamplefvNV` | definition |  | GL_NV_explicit_multisample:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferParameteri64v` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferParameterui64vNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferPointerv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferPointervEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferSubData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedBufferSubDataEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedFramebufferAttachmentParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedFramebufferAttachmentParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedFramebufferParameterfvAMD` | definition |  | GL_AMD_framebuffer_sample_positions:all:all | unclassified | - | - | - | - |
| `glGetNamedFramebufferParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedFramebufferParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedProgramLocalParameterIivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedProgramLocalParameterIuivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedProgramLocalParameterdvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedProgramLocalParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedProgramStringEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedProgramivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedRenderbufferParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedRenderbufferParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetNamedStringARB` | definition |  | GL_ARB_shading_language_include:all:all | unclassified | - | - | - | - |
| `glGetNamedStringivARB` | definition |  | GL_ARB_shading_language_include:all:all | unclassified | - | - | - | - |
| `glGetNextPerfQueryIdINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glGetObjectBufferfvATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGetObjectBufferivATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGetObjectLabel` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glGetObjectLabelEXT` | definition |  | GL_EXT_debug_label:all:all | unclassified | - | - | - | - |
| `glGetObjectParameterfvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetObjectParameterivAPPLE` | definition |  | GL_APPLE_object_purgeable:all:all | unclassified | - | - | - | - |
| `glGetObjectParameterivARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetObjectPtrLabel` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glGetOcclusionQueryivNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGetOcclusionQueryuivNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGetPathCommandsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathCoordsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathDashArrayNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathLengthNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathMetricRangeNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathMetricsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathParameterfvNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathParameterivNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPathSpacingNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetPerfCounterInfoINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glGetPerfMonitorCounterDataAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGetPerfMonitorCounterInfoAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGetPerfMonitorCounterStringAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGetPerfMonitorCountersAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGetPerfMonitorGroupStringAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGetPerfMonitorGroupsAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glGetPerfQueryDataINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glGetPerfQueryIdByNameINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glGetPerfQueryInfoINTEL` | definition |  | GL_INTEL_performance_query:all:all | unclassified | - | - | - | - |
| `glGetPixelMapfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetPixelMapuiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetPixelMapusv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetPixelMapxv` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetPixelTexGenParameterfvSGIS` | definition |  | GL_SGIS_pixel_texture:all:all | unclassified | - | - | - | - |
| `glGetPixelTexGenParameterivSGIS` | definition |  | GL_SGIS_pixel_texture:all:all | unclassified | - | - | - | - |
| `glGetPixelTransformParameterfvEXT` | definition |  | GL_EXT_pixel_transform:all:all | unclassified | - | - | - | - |
| `glGetPixelTransformParameterivEXT` | definition |  | GL_EXT_pixel_transform:all:all | unclassified | - | - | - | - |
| `glGetPointerIndexedvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetPointeri_vEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetPointerv` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core|GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glGetPointervEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glGetPolygonStipple` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetProgramBinary` | definition | GL_VERSION_4_1:+:all | GL_ARB_get_program_binary:all:all | unclassified | - | - | - | - |
| `glGetProgramEnvParameterIivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glGetProgramEnvParameterIuivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glGetProgramEnvParameterdvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramEnvParameterfvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramInfoLog` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab bounded link diagnostic capture | src/driver/opengl.ab typed length and byte-output ABI | tests/opengl/main.ab empty-program link diagnostic path | src/driver/opengl.ab 4096-byte bounded adoption |
| `glGetProgramInterfaceiv` | definition | GL_VERSION_4_3:+:all | GL_ARB_program_interface_query:all:all | unclassified | - | - | - | - |
| `glGetProgramLocalParameterIivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glGetProgramLocalParameterIuivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glGetProgramLocalParameterdvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramLocalParameterfvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramNamedParameterdvNV` | definition |  | GL_NV_fragment_program:all:all | unclassified | - | - | - | - |
| `glGetProgramNamedParameterfvNV` | definition |  | GL_NV_fragment_program:all:all | unclassified | - | - | - | - |
| `glGetProgramParameterdvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramParameterfvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramPipelineInfoLog` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetProgramPipelineiv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetProgramResourceIndex` | definition | GL_VERSION_4_3:+:all | GL_ARB_program_interface_query:all:all | unclassified | - | - | - | - |
| `glGetProgramResourceLocation` | definition | GL_VERSION_4_3:+:all | GL_ARB_program_interface_query:all:all | unclassified | - | - | - | - |
| `glGetProgramResourceLocationIndex` | definition | GL_VERSION_4_3:+:all | GL_ARB_program_interface_query:all:all | unclassified | - | - | - | - |
| `glGetProgramResourceName` | definition | GL_VERSION_4_3:+:all | GL_ARB_program_interface_query:all:all | unclassified | - | - | - | - |
| `glGetProgramResourcefvNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glGetProgramResourceiv` | definition | GL_VERSION_4_3:+:all | GL_ARB_program_interface_query:all:all | unclassified | - | - | - | - |
| `glGetProgramStageiv` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetProgramStringARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramStringNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramSubroutineParameteruivNV` | definition |  | GL_NV_gpu_program5:all:all | unclassified | - | - | - | - |
| `glGetProgramiv` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab program link-status query | src/driver/opengl.ab typed parameter output ABI | tests/opengl/main.ab valid and empty program link status | tests/opengl/main.ab empty program rejection |
| `glGetProgramivARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetProgramivNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetQueryBufferObjecti64v` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetQueryBufferObjectiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetQueryBufferObjectui64v` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetQueryBufferObjectuiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetQueryIndexediv` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback3:all:all | unclassified | - | - | - | - |
| `glGetQueryObjecti64v` | definition | GL_VERSION_3_3:+:all | GL_ARB_timer_query:all:all | unclassified | - | - | - | - |
| `glGetQueryObjecti64vEXT` | definition |  | GL_EXT_timer_query:all:all | unclassified | - | - | - | - |
| `glGetQueryObjectiv` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glGetQueryObjectivARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGetQueryObjectui64v` | definition | GL_VERSION_3_3:+:all | GL_ARB_timer_query:all:all | common | src/driver/opengl.ab timestamp readback | src/driver/opengl.ab typed extern signature | tests/application/main.ab monotonic timestamp samples | tests/application/main.ab invalid query rejection |
| `glGetQueryObjectui64vEXT` | definition |  | GL_EXT_timer_query:all:all | unclassified | - | - | - | - |
| `glGetQueryObjectuiv` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glGetQueryObjectuivARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGetQueryiv` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glGetQueryivARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glGetRenderbufferParameteriv` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGetRenderbufferParameterivEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glGetSamplerParameterIiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glGetSamplerParameterIuiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glGetSamplerParameterfv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glGetSamplerParameteriv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glGetSemaphoreParameterivNV` | definition |  | GL_NV_timeline_semaphore:all:all | unclassified | - | - | - | - |
| `glGetSemaphoreParameterui64vEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glGetSeparableFilterEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glGetShaderInfoLog` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab bounded compile diagnostic capture | src/driver/opengl.ab typed length and byte-output ABI | tests/opengl/main.ab exact malformed-source driver diagnostic | src/driver/opengl.ab 4096-byte bounded adoption |
| `glGetShaderPrecisionFormat` | definition | GL_VERSION_4_1:+:all | GL_ARB_ES2_compatibility:all:all | unclassified | - | - | - | - |
| `glGetShaderSource` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetShaderSourceARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetShaderiv` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab source and specialized compile-status query | src/driver/opengl.ab typed parameter output ABI | tests/opengl/main.ab valid and malformed source status | tests/opengl/main.ab malformed source rejection |
| `glGetShadingRateImagePaletteNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glGetShadingRateSampleLocationivNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glGetSharpenTexFuncSGIS` | definition |  | GL_SGIS_sharpen_texture:all:all | unclassified | - | - | - | - |
| `glGetStageIndexNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glGetString` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetStringi` | definition | GL_VERSION_3_0:+:all |  | common | src/driver/opengl.ab bounded extension-name enumeration | src/driver/opengl.ab typed name index and string-pointer ABI | tests/application/main.ab SPIR-V and anisotropy feature negotiation | src/driver/opengl.ab null extension pointer handling |
| `glGetSubroutineIndex` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetSubroutineUniformLocation` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetSynciv` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | unclassified | - | - | - | - |
| `glGetTexBumpParameterfvATI` | definition |  | GL_ATI_envmap_bumpmap:all:all | unclassified | - | - | - | - |
| `glGetTexBumpParameterivATI` | definition |  | GL_ATI_envmap_bumpmap:all:all | unclassified | - | - | - | - |
| `glGetTexEnvfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetTexEnviv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetTexEnvxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetTexFilterFuncSGIS` | definition |  | GL_SGIS_texture_filter4:all:all | unclassified | - | - | - | - |
| `glGetTexGendv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetTexGenfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetTexGeniv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glGetTexGenxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetTexImage` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexLevelParameterfv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexLevelParameteriv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexLevelParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetTexParameterIiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexParameterIivEXT` | definition |  | GL_EXT_texture_integer:all:all | unclassified | - | - | - | - |
| `glGetTexParameterIuiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexParameterIuivEXT` | definition |  | GL_EXT_texture_integer:all:all | unclassified | - | - | - | - |
| `glGetTexParameterPointervAPPLE` | definition |  | GL_APPLE_texture_range:all:all | unclassified | - | - | - | - |
| `glGetTexParameterfv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexParameteriv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glGetTexParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glGetTextureHandleARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetTextureHandleNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetTextureImage` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureImageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureLevelParameterfv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureLevelParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureLevelParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureLevelParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterIiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterIivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterIuiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterIuivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterfv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTextureSamplerHandleARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetTextureSamplerHandleNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetTextureSubImage` | definition | GL_VERSION_4_5:+:all | GL_ARB_get_texture_sub_image:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab texture readback | src/driver/opengl.ab typed extern signature | tests/application/main.ab and tests/wider_texture_transfer/main.ab exact texture readback | tests/application/main.ab readback range rejection |
| `glGetTrackMatrixivNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetTransformFeedbackVarying` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetTransformFeedbackVaryingEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glGetTransformFeedbackVaryingNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glGetTransformFeedbacki64_v` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTransformFeedbacki_v` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetTransformFeedbackiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetUniformBlockIndex` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetUniformBufferSizeEXT` | definition |  | GL_EXT_bindable_uniform:all:all | unclassified | - | - | - | - |
| `glGetUniformIndices` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glGetUniformLocation` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetUniformLocationARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetUniformOffsetEXT` | definition |  | GL_EXT_bindable_uniform:all:all | unclassified | - | - | - | - |
| `glGetUniformSubroutineuiv` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glGetUniformdv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glGetUniformfv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetUniformfvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetUniformi64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glGetUniformi64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glGetUniformiv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetUniformivARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glGetUniformui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glGetUniformui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glGetUniformuiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetUniformuivEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glGetUnsignedBytei_vEXT` | definition |  | GL_EXT_memory_object:all:all|GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glGetUnsignedBytevEXT` | definition |  | GL_EXT_memory_object:all:all|GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glGetVariantArrayObjectfvATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGetVariantArrayObjectivATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glGetVariantBooleanvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVariantFloatvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVariantIntegervEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVariantPointervEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVaryingLocationNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayIndexed64iv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayIndexediv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayIntegeri_vEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayIntegervEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayPointeri_vEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayPointervEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexArrayiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribArrayObjectfvATI` | definition |  | GL_ATI_vertex_attrib_array_object:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribArrayObjectivATI` | definition |  | GL_ATI_vertex_attrib_array_object:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribIiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetVertexAttribIivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribIuiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glGetVertexAttribIuivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribLdv` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribLdvEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribLi64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribLui64vARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribLui64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribPointerv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetVertexAttribPointervARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribPointervNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribdv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetVertexAttribdvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribdvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribfv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetVertexAttribfvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribfvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribiv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glGetVertexAttribivARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glGetVertexAttribivNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glGetVideoCaptureStreamdvNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glGetVideoCaptureStreamfvNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glGetVideoCaptureStreamivNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glGetVideoCaptureivNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glGetVideoi64vNV` | definition |  | GL_NV_present_video:all:all | unclassified | - | - | - | - |
| `glGetVideoivNV` | definition |  | GL_NV_present_video:all:all | unclassified | - | - | - | - |
| `glGetVideoui64vNV` | definition |  | GL_NV_present_video:all:all | unclassified | - | - | - | - |
| `glGetVideouivNV` | definition |  | GL_NV_present_video:all:all | unclassified | - | - | - | - |
| `glGetVkProcAddrNV` | definition |  | GL_NV_draw_vulkan_image:all:all | unclassified | - | - | - | - |
| `glGetnCompressedTexImage` | definition | GL_VERSION_4_5:+:all |  | unclassified | - | - | - | - |
| `glGetnCompressedTexImageARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGetnTexImage` | definition | GL_VERSION_4_5:+:all |  | unclassified | - | - | - | - |
| `glGetnTexImageARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformdv` | definition | GL_VERSION_4_5:+:all |  | unclassified | - | - | - | - |
| `glGetnUniformdvARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformfv` | definition | GL_VERSION_4_5:+:all | GL_KHR_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformfvARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformi64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glGetnUniformiv` | definition | GL_VERSION_4_5:+:all | GL_KHR_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformivARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glGetnUniformuiv` | definition | GL_VERSION_4_5:+:all | GL_KHR_robustness:all:all | unclassified | - | - | - | - |
| `glGetnUniformuivARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactorbSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactordSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactorfSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactoriSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactorsSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactorubSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactoruiSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glGlobalAlphaFactorusSUN` | definition |  | GL_SUN_global_alpha:all:all | unclassified | - | - | - | - |
| `glHint` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glHintPGI` | definition |  | GL_PGI_misc_hints:all:all | unclassified | - | - | - | - |
| `glHistogramEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glIglooInterfaceSGIX` | definition |  | GL_SGIX_igloo_interface:all:all | unclassified | - | - | - | - |
| `glImageTransformParameterfHP` | definition |  | GL_HP_image_transform:all:all | unclassified | - | - | - | - |
| `glImageTransformParameterfvHP` | definition |  | GL_HP_image_transform:all:all | unclassified | - | - | - | - |
| `glImageTransformParameteriHP` | definition |  | GL_HP_image_transform:all:all | unclassified | - | - | - | - |
| `glImageTransformParameterivHP` | definition |  | GL_HP_image_transform:all:all | unclassified | - | - | - | - |
| `glImportMemoryFdEXT` | definition |  | GL_EXT_memory_object_fd:all:all | unclassified | - | - | - | - |
| `glImportMemoryWin32HandleEXT` | definition |  | GL_EXT_memory_object_win32:all:all | unclassified | - | - | - | - |
| `glImportMemoryWin32NameEXT` | definition |  | GL_EXT_memory_object_win32:all:all | unclassified | - | - | - | - |
| `glImportSemaphoreFdEXT` | definition |  | GL_EXT_semaphore_fd:all:all | unclassified | - | - | - | - |
| `glImportSemaphoreWin32HandleEXT` | definition |  | GL_EXT_semaphore_win32:all:all | unclassified | - | - | - | - |
| `glImportSemaphoreWin32NameEXT` | definition |  | GL_EXT_semaphore_win32:all:all | unclassified | - | - | - | - |
| `glImportSyncEXT` | definition |  | GL_EXT_x11_sync_object:all:all | unclassified | - | - | - | - |
| `glIndexFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glIndexFuncEXT` | definition |  | GL_EXT_index_func:all:all | unclassified | - | - | - | - |
| `glIndexMask` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexMaterialEXT` | definition |  | GL_EXT_index_material:all:all | unclassified | - | - | - | - |
| `glIndexPointer` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexPointerEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glIndexPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glIndexd` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexdv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexi` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexs` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexsv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexub` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexubv` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIndexxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glIndexxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glInitNames` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glInsertComponentEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glInsertEventMarkerEXT` | definition |  | GL_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `glInstrumentsBufferSGIX` | definition |  | GL_SGIX_instruments:all:all | unclassified | - | - | - | - |
| `glInterleavedArrays` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glInterpolatePathsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glInvalidateBufferData` | definition | GL_VERSION_4_3:+:all | GL_ARB_invalidate_subdata:all:all | unclassified | - | - | - | - |
| `glInvalidateBufferSubData` | definition | GL_VERSION_4_3:+:all | GL_ARB_invalidate_subdata:all:all | unclassified | - | - | - | - |
| `glInvalidateFramebuffer` | definition | GL_VERSION_4_3:+:all | GL_ARB_invalidate_subdata:all:all | common | src/driver/opengl.ab discard store operation | src/driver/opengl.ab typed extern signature | tests/application/main.ab discard attachment pass | tests/application/main.ab attachment bounds rejection |
| `glInvalidateNamedFramebufferData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glInvalidateNamedFramebufferSubData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glInvalidateSubFramebuffer` | definition | GL_VERSION_4_3:+:all | GL_ARB_invalidate_subdata:all:all | unclassified | - | - | - | - |
| `glInvalidateTexImage` | definition | GL_VERSION_4_3:+:all | GL_ARB_invalidate_subdata:all:all | unclassified | - | - | - | - |
| `glInvalidateTexSubImage` | definition | GL_VERSION_4_3:+:all | GL_ARB_invalidate_subdata:all:all | unclassified | - | - | - | - |
| `glIsAsyncMarkerSGIX` | definition |  | GL_SGIX_async:all:all | unclassified | - | - | - | - |
| `glIsBuffer` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glIsBufferARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glIsBufferResidentNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glIsCommandListNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glIsEnabled` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glIsEnabledIndexedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_draw_buffers2:all:all | unclassified | - | - | - | - |
| `glIsEnabledi` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glIsFenceAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glIsFenceNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glIsFramebuffer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glIsFramebufferEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glIsImageHandleResidentARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glIsImageHandleResidentNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glIsList` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glIsMemoryObjectEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glIsNameAMD` | definition |  | GL_AMD_name_gen_delete:all:all | unclassified | - | - | - | - |
| `glIsNamedBufferResidentNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glIsNamedStringARB` | definition |  | GL_ARB_shading_language_include:all:all | unclassified | - | - | - | - |
| `glIsObjectBufferATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glIsOcclusionQueryNV` | definition |  | GL_NV_occlusion_query:all:all | unclassified | - | - | - | - |
| `glIsPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glIsPointInFillPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glIsPointInStrokePathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glIsProgram` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glIsProgramARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glIsProgramNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glIsProgramPipeline` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glIsQuery` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glIsQueryARB` | definition |  | GL_ARB_occlusion_query:all:all | unclassified | - | - | - | - |
| `glIsRenderbuffer` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glIsRenderbufferEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glIsSampler` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glIsSemaphoreEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glIsShader` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glIsStateNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glIsSync` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | unclassified | - | - | - | - |
| `glIsTexture` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glIsTextureEXT` | definition |  | GL_EXT_texture_object:all:all | unclassified | - | - | - | - |
| `glIsTextureHandleResidentARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glIsTextureHandleResidentNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glIsTransformFeedback` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glIsTransformFeedbackNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glIsVariantEnabledEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glIsVertexArray` | definition | GL_VERSION_3_0:+:all | GL_ARB_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glIsVertexArrayAPPLE` | definition |  | GL_APPLE_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glIsVertexAttribEnabledAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glLGPUCopyImageSubDataNVX` | definition |  | GL_NVX_linked_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glLGPUInterlockNVX` | definition |  | GL_NVX_linked_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glLGPUNamedBufferSubDataNVX` | definition |  | GL_NVX_linked_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glLabelObjectEXT` | definition |  | GL_EXT_debug_label:all:all | unclassified | - | - | - | - |
| `glLightEnviSGIX` | definition |  | GL_SGIX_fragment_lighting:all:all | unclassified | - | - | - | - |
| `glLightModelf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightModelfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightModeli` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightModeliv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightModelxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLightModelxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLightf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLighti` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLightxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLightxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLineStipple` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLineWidth` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glLineWidthxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLinkProgram` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab render and compute program linking | src/driver/opengl.ab typed program-name ABI | tests/opengl/main.ab valid vertex-fragment link | tests/opengl/main.ab empty program link rejection |
| `glLinkProgramARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glListBase` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glListDrawCommandsStatesClientNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glListParameterfSGIX` | definition |  | GL_SGIX_list_priority:all:all | unclassified | - | - | - | - |
| `glListParameterfvSGIX` | definition |  | GL_SGIX_list_priority:all:all | unclassified | - | - | - | - |
| `glListParameteriSGIX` | definition |  | GL_SGIX_list_priority:all:all | unclassified | - | - | - | - |
| `glListParameterivSGIX` | definition |  | GL_SGIX_list_priority:all:all | unclassified | - | - | - | - |
| `glLoadIdentity` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLoadIdentityDeformationMapSGIX` | definition |  | GL_SGIX_polynomial_ffd:all:all | unclassified | - | - | - | - |
| `glLoadMatrixd` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLoadMatrixf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLoadMatrixxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLoadName` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLoadProgramNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glLoadTransposeMatrixd` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLoadTransposeMatrixdARB` | definition |  | GL_ARB_transpose_matrix:all:all | unclassified | - | - | - | - |
| `glLoadTransposeMatrixf` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glLoadTransposeMatrixfARB` | definition |  | GL_ARB_transpose_matrix:all:all | unclassified | - | - | - | - |
| `glLoadTransposeMatrixxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glLockArraysEXT` | definition |  | GL_EXT_compiled_vertex_array:all:all | unclassified | - | - | - | - |
| `glLogicOp` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glMakeBufferNonResidentNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glMakeBufferResidentNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glMakeImageHandleNonResidentARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeImageHandleNonResidentNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeImageHandleResidentARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeImageHandleResidentNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeNamedBufferNonResidentNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glMakeNamedBufferResidentNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glMakeTextureHandleNonResidentARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeTextureHandleNonResidentNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeTextureHandleResidentARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMakeTextureHandleResidentNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glMap1d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMap1f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMap1xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMap2d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMap2f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMap2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMapBuffer` | definition | GL_VERSION_1_5:+:all |  | unclassified | - | - | - | - |
| `glMapBufferARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glMapBufferRange` | definition | GL_VERSION_3_0:+:all | GL_ARB_map_buffer_range:all:all | common | src/driver/opengl.ab mapped-at-creation and reusable read-write range mapping | src/driver/opengl.ab typed offset length flags and mapped-pointer ABI | examples/common-buffer/main.ab allocation-free repeated write and read maps | tests/application/main.ab access nested mapped-use and logical-range rejection |
| `glMapControlPointsNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glMapGrid1d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMapGrid1f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMapGrid1xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMapGrid2d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMapGrid2f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMapGrid2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMapNamedBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMapNamedBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMapNamedBufferRange` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMapNamedBufferRangeEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMapObjectBufferATI` | definition |  | GL_ATI_map_object_buffer:all:all | unclassified | - | - | - | - |
| `glMapParameterfvNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glMapParameterivNV` | definition |  | GL_NV_evaluators:all:all | unclassified | - | - | - | - |
| `glMapTexture2DINTEL` | definition |  | GL_INTEL_map_texture:all:all | unclassified | - | - | - | - |
| `glMapVertexAttrib1dAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glMapVertexAttrib1fAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glMapVertexAttrib2dAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glMapVertexAttrib2fAPPLE` | definition |  | GL_APPLE_vertex_program_evaluators:all:all | unclassified | - | - | - | - |
| `glMaterialf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMaterialfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMateriali` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMaterialiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMaterialxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMaterialxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMatrixFrustumEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixIndexPointerARB` | definition |  | GL_ARB_matrix_palette:all:all | unclassified | - | - | - | - |
| `glMatrixIndexubvARB` | definition |  | GL_ARB_matrix_palette:all:all | unclassified | - | - | - | - |
| `glMatrixIndexuivARB` | definition |  | GL_ARB_matrix_palette:all:all | unclassified | - | - | - | - |
| `glMatrixIndexusvARB` | definition |  | GL_ARB_matrix_palette:all:all | unclassified | - | - | - | - |
| `glMatrixLoad3x2fNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoad3x3fNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoadIdentityEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoadTranspose3x3fNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoadTransposedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoadTransposefEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoaddEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixLoadfEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMode` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMatrixMult3x2fNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMult3x3fNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMultTranspose3x3fNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMultTransposedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMultTransposefEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMultdEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixMultfEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixOrthoEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixPopEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixPushEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixRotatedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixRotatefEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixScaledEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixScalefEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixTranslatedEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMatrixTranslatefEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glMaxShaderCompilerThreadsARB` | definition |  | GL_ARB_parallel_shader_compile:all:all | unclassified | - | - | - | - |
| `glMaxShaderCompilerThreadsKHR` | definition |  | GL_KHR_parallel_shader_compile:all:all | unclassified | - | - | - | - |
| `glMemoryBarrier` | definition | GL_VERSION_4_2:+:all | GL_ARB_shader_image_load_store:all:all | common | src/driver/opengl.ab compute and coherent mapped-transfer visibility | src/driver/opengl.ab typed barrier-mask ABI | examples/common-buffer/main.ab exact wrapped persistent upload and readback | tests/application/main.ab invalid mapped transfer rejection |
| `glMemoryBarrierByRegion` | definition | GL_VERSION_4_5:+:all | GL_ARB_ES3_1_compatibility:all:all | unclassified | - | - | - | - |
| `glMemoryBarrierEXT` | definition |  | GL_EXT_shader_image_load_store:all:all | unclassified | - | - | - | - |
| `glMemoryObjectParameterivEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glMinSampleShading` | definition | GL_VERSION_4_0:+:all |  | unclassified | - | - | - | - |
| `glMinSampleShadingARB` | definition |  | GL_ARB_sample_shading:all:all | unclassified | - | - | - | - |
| `glMinmaxEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glMultMatrixd` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultMatrixf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultMatrixxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultTransposeMatrixd` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultTransposeMatrixdARB` | definition |  | GL_ARB_transpose_matrix:all:all | unclassified | - | - | - | - |
| `glMultTransposeMatrixf` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultTransposeMatrixfARB` | definition |  | GL_ARB_transpose_matrix:all:all | unclassified | - | - | - | - |
| `glMultTransposeMatrixxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiDrawArrays` | definition | GL_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `glMultiDrawArraysEXT` | definition |  | GL_EXT_multi_draw_arrays:all:all | unclassified | - | - | - | - |
| `glMultiDrawArraysIndirect` | definition | GL_VERSION_4_3:+:all | GL_ARB_multi_draw_indirect:all:all | unclassified | - | - | - | - |
| `glMultiDrawArraysIndirectAMD` | definition |  | GL_AMD_multi_draw_indirect:all:all | unclassified | - | - | - | - |
| `glMultiDrawArraysIndirectBindlessCountNV` | definition |  | GL_NV_bindless_multi_draw_indirect_count:all:all | unclassified | - | - | - | - |
| `glMultiDrawArraysIndirectBindlessNV` | definition |  | GL_NV_bindless_multi_draw_indirect:all:all | unclassified | - | - | - | - |
| `glMultiDrawArraysIndirectCount` | definition | GL_VERSION_4_6:+:all |  | unclassified | - | - | - | - |
| `glMultiDrawArraysIndirectCountARB` | definition |  | GL_ARB_indirect_parameters:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementArrayAPPLE` | definition |  | GL_APPLE_element_array:all:all | unclassified | - | - | - | - |
| `glMultiDrawElements` | definition | GL_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `glMultiDrawElementsBaseVertex` | definition | GL_VERSION_3_2:+:all | GL_ARB_draw_elements_base_vertex:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementsEXT` | definition |  | GL_EXT_multi_draw_arrays:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementsIndirect` | definition | GL_VERSION_4_3:+:all | GL_ARB_multi_draw_indirect:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementsIndirectAMD` | definition |  | GL_AMD_multi_draw_indirect:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementsIndirectBindlessCountNV` | definition |  | GL_NV_bindless_multi_draw_indirect_count:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementsIndirectBindlessNV` | definition |  | GL_NV_bindless_multi_draw_indirect:all:all | unclassified | - | - | - | - |
| `glMultiDrawElementsIndirectCount` | definition | GL_VERSION_4_6:+:all |  | unclassified | - | - | - | - |
| `glMultiDrawElementsIndirectCountARB` | definition |  | GL_ARB_indirect_parameters:all:all | unclassified | - | - | - | - |
| `glMultiDrawMeshTasksIndirectCountEXT` | definition |  | GL_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `glMultiDrawMeshTasksIndirectCountNV` | definition |  | GL_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `glMultiDrawMeshTasksIndirectEXT` | definition |  | GL_EXT_mesh_shader:all:all | unclassified | - | - | - | - |
| `glMultiDrawMeshTasksIndirectNV` | definition |  | GL_NV_mesh_shader:all:all | unclassified | - | - | - | - |
| `glMultiDrawRangeElementArrayAPPLE` | definition |  | GL_APPLE_element_array:all:all | unclassified | - | - | - | - |
| `glMultiModeDrawArraysIBM` | definition |  | GL_IBM_multimode_draw_arrays:all:all | unclassified | - | - | - | - |
| `glMultiModeDrawElementsIBM` | definition |  | GL_IBM_multimode_draw_arrays:all:all | unclassified | - | - | - | - |
| `glMultiTexBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1d` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1dARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1dv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1dvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1f` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1fARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1fv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1fvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1i` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1iARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1iv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1ivARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1s` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1sARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1sv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord1svARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord1xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2d` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2dARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2dv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2dvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2f` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2fARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2fv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2fvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2i` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2iARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2iv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2ivARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2s` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2sARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2sv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord2svARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord2xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3d` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3dARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3dv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3dvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3f` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3fARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3fv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3fvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3i` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3iARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3iv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3ivARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3s` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3sARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3sv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord3svARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord3xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4d` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4dARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4dv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4dvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4f` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4fARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4fv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4fvARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4i` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4iARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4iv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4ivARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4s` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4sARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4sv` | definition | GL_VERSION_1_3:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glMultiTexCoord4svARB` | definition |  | GL_ARB_multitexture:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoord4xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glMultiTexCoordPointerEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexEnvfEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexEnvfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexEnviEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexEnvivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexGendEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexGendvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexGenfEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexGenfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexGeniEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexGenivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexParameterIivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexParameterIuivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexParameterfEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexParameteriEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexRenderbufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexSubImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexSubImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMultiTexSubImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glMulticastBarrierNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastBlitFramebufferNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastBufferSubDataNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastCopyBufferSubDataNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastCopyImageSubDataNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastFramebufferSampleLocationsfvNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastGetQueryObjecti64vNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastGetQueryObjectivNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastGetQueryObjectui64vNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastGetQueryObjectuivNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glMulticastScissorArrayvNVX` | definition |  | GL_NVX_gpu_multicast2:all:all | unclassified | - | - | - | - |
| `glMulticastViewportArrayvNVX` | definition |  | GL_NVX_gpu_multicast2:all:all | unclassified | - | - | - | - |
| `glMulticastViewportPositionWScaleNVX` | definition |  | GL_NVX_gpu_multicast2:all:all | unclassified | - | - | - | - |
| `glMulticastWaitSyncNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glNamedBufferAttachMemoryNV` | definition |  | GL_NV_memory_attachment:all:all | unclassified | - | - | - | - |
| `glNamedBufferData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedBufferDataEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedBufferPageCommitmentARB` | definition |  | GL_ARB_sparse_buffer:all:all | unclassified | - | - | - | - |
| `glNamedBufferPageCommitmentEXT` | definition |  | GL_ARB_sparse_buffer:all:all | unclassified | - | - | - | - |
| `glNamedBufferPageCommitmentMemNV` | definition |  | GL_NV_memory_object_sparse:all:all | unclassified | - | - | - | - |
| `glNamedBufferStorage` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedBufferStorageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedBufferStorageExternalEXT` | definition |  | GL_EXT_external_buffer:all:all | unclassified | - | - | - | - |
| `glNamedBufferStorageMemEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glNamedBufferSubData` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedBufferSubDataEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedCopyBufferSubDataEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferDrawBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferDrawBuffers` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferParameteri` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferParameteriEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferReadBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferRenderbuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferRenderbufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferSampleLocationsfvARB` | definition |  | GL_ARB_sample_locations:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferSampleLocationsfvNV` | definition |  | GL_NV_sample_locations:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferSamplePositionsfvAMD` | definition |  | GL_AMD_framebuffer_sample_positions:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTexture` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTexture1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTexture2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTexture3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTextureEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTextureFaceEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTextureLayer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTextureLayerEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedFramebufferTextureMultiviewOVR` | definition |  | GL_OVR_multiview:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameter4dEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameter4dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameter4fEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameter4fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameterI4iEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameterI4ivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameterI4uiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameterI4uivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParameters4fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParametersI4ivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramLocalParametersI4uivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedProgramStringEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedRenderbufferStorage` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedRenderbufferStorageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedRenderbufferStorageMultisample` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedRenderbufferStorageMultisampleAdvancedAMD` | definition |  | GL_AMD_framebuffer_multisample_advanced:all:all | unclassified | - | - | - | - |
| `glNamedRenderbufferStorageMultisampleCoverageEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedRenderbufferStorageMultisampleEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glNamedStringARB` | definition |  | GL_ARB_shading_language_include:all:all | unclassified | - | - | - | - |
| `glNewList` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNewObjectBufferATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glNormal3b` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3bv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glNormal3fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glNormal3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glNormal3i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormal3xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glNormal3xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glNormalFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glNormalPointer` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glNormalPointerEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glNormalPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glNormalPointervINTEL` | definition |  | GL_INTEL_parallel_arrays:all:all | unclassified | - | - | - | - |
| `glNormalStream3bATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3bvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3dATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3dvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3fATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3fvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3iATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3ivATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3sATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glNormalStream3svATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glObjectLabel` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glObjectPtrLabel` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glObjectPurgeableAPPLE` | definition |  | GL_APPLE_object_purgeable:all:all | unclassified | - | - | - | - |
| `glObjectUnpurgeableAPPLE` | definition |  | GL_APPLE_object_purgeable:all:all | unclassified | - | - | - | - |
| `glOrtho` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glOrthofOES` | definition |  | GL_OES_single_precision:all:all | unclassified | - | - | - | - |
| `glOrthoxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPNTrianglesfATI` | definition |  | GL_ATI_pn_triangles:all:all | unclassified | - | - | - | - |
| `glPNTrianglesiATI` | definition |  | GL_ATI_pn_triangles:all:all | unclassified | - | - | - | - |
| `glPassTexCoordATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glPassThrough` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPassThroughxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPatchParameterfv` | definition | GL_VERSION_4_0:+:all | GL_ARB_tessellation_shader:all:all | unclassified | - | - | - | - |
| `glPatchParameteri` | definition | GL_VERSION_4_0:+:all | GL_ARB_tessellation_shader:all:all | unclassified | - | - | - | - |
| `glPathCommandsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathCoordsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathCoverDepthFuncNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathDashArrayNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathGlyphIndexArrayNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathGlyphIndexRangeNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathGlyphRangeNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathGlyphsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathMemoryGlyphIndexArrayNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathParameterfNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathParameterfvNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathParameteriNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathParameterivNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathStencilDepthOffsetNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathStencilFuncNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathStringNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathSubCommandsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPathSubCoordsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPauseTransformFeedback` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glPauseTransformFeedbackNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glPixelDataRangeNV` | definition |  | GL_NV_pixel_data_range:all:all | unclassified | - | - | - | - |
| `glPixelMapfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPixelMapuiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPixelMapusv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPixelMapx` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPixelStoref` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glPixelStorei` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab scoped pitched uncompressed and compressed pack-unpack state | src/driver/opengl.ab typed state-name and integer ABI | tests/wider_texture/main.ab exact padded array cube volume and BC1 round trips | tests/texture_contract.ab invalid pitch and block alignment rejection |
| `glPixelStorex` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPixelTexGenParameterfSGIS` | definition |  | GL_SGIS_pixel_texture:all:all | unclassified | - | - | - | - |
| `glPixelTexGenParameterfvSGIS` | definition |  | GL_SGIS_pixel_texture:all:all | unclassified | - | - | - | - |
| `glPixelTexGenParameteriSGIS` | definition |  | GL_SGIS_pixel_texture:all:all | unclassified | - | - | - | - |
| `glPixelTexGenParameterivSGIS` | definition |  | GL_SGIS_pixel_texture:all:all | unclassified | - | - | - | - |
| `glPixelTexGenSGIX` | definition |  | GL_SGIX_pixel_texture:all:all | unclassified | - | - | - | - |
| `glPixelTransferf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPixelTransferi` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPixelTransferxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPixelTransformParameterfEXT` | definition |  | GL_EXT_pixel_transform:all:all | unclassified | - | - | - | - |
| `glPixelTransformParameterfvEXT` | definition |  | GL_EXT_pixel_transform:all:all | unclassified | - | - | - | - |
| `glPixelTransformParameteriEXT` | definition |  | GL_EXT_pixel_transform:all:all | unclassified | - | - | - | - |
| `glPixelTransformParameterivEXT` | definition |  | GL_EXT_pixel_transform:all:all | unclassified | - | - | - | - |
| `glPixelZoom` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPixelZoomxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPointAlongPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glPointParameterf` | definition | GL_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `glPointParameterfARB` | definition |  | GL_ARB_point_parameters:all:all | unclassified | - | - | - | - |
| `glPointParameterfEXT` | definition |  | GL_EXT_point_parameters:all:all | unclassified | - | - | - | - |
| `glPointParameterfSGIS` | definition |  | GL_SGIS_point_parameters:all:all | unclassified | - | - | - | - |
| `glPointParameterfv` | definition | GL_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `glPointParameterfvARB` | definition |  | GL_ARB_point_parameters:all:all | unclassified | - | - | - | - |
| `glPointParameterfvEXT` | definition |  | GL_EXT_point_parameters:all:all | unclassified | - | - | - | - |
| `glPointParameterfvSGIS` | definition |  | GL_SGIS_point_parameters:all:all | unclassified | - | - | - | - |
| `glPointParameteri` | definition | GL_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `glPointParameteriNV` | definition |  | GL_NV_point_sprite:all:all | unclassified | - | - | - | - |
| `glPointParameteriv` | definition | GL_VERSION_1_4:+:all |  | unclassified | - | - | - | - |
| `glPointParameterivNV` | definition |  | GL_NV_point_sprite:all:all | unclassified | - | - | - | - |
| `glPointParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPointSize` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glPointSizexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPollAsyncSGIX` | definition |  | GL_SGIX_async:all:all | unclassified | - | - | - | - |
| `glPollInstrumentsSGIX` | definition |  | GL_SGIX_instruments:all:all | unclassified | - | - | - | - |
| `glPolygonMode` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glPolygonOffset` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glPolygonOffsetClamp` | definition | GL_VERSION_4_6:+:all | GL_ARB_polygon_offset_clamp:all:all | unclassified | - | - | - | - |
| `glPolygonOffsetClampEXT` | definition |  | GL_EXT_polygon_offset_clamp:all:all | unclassified | - | - | - | - |
| `glPolygonOffsetEXT` | definition |  | GL_EXT_polygon_offset:all:all | unclassified | - | - | - | - |
| `glPolygonOffsetxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glPolygonStipple` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPopAttrib` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPopClientAttrib` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPopDebugGroup` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glPopGroupMarkerEXT` | definition |  | GL_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `glPopMatrix` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPopName` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPresentFrameDualFillNV` | definition |  | GL_NV_present_video:all:all | unclassified | - | - | - | - |
| `glPresentFrameKeyedNV` | definition |  | GL_NV_present_video:all:all | unclassified | - | - | - | - |
| `glPrimitiveBoundingBoxARB` | definition |  | GL_ARB_ES3_2_compatibility:all:all | unclassified | - | - | - | - |
| `glPrimitiveRestartIndex` | definition | GL_VERSION_3_1:+:all |  | unclassified | - | - | - | - |
| `glPrimitiveRestartIndexNV` | definition |  | GL_NV_primitive_restart:all:all | unclassified | - | - | - | - |
| `glPrimitiveRestartNV` | definition |  | GL_NV_primitive_restart:all:all | unclassified | - | - | - | - |
| `glPrioritizeTextures` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPrioritizeTexturesEXT` | definition |  | GL_EXT_texture_object:all:all | unclassified | - | - | - | - |
| `glPrioritizeTexturesxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glProgramBinary` | definition | GL_VERSION_4_1:+:all | GL_ARB_get_program_binary:all:all | unclassified | - | - | - | - |
| `glProgramBufferParametersIivNV` | definition |  | GL_NV_parameter_buffer_object:all:all | unclassified | - | - | - | - |
| `glProgramBufferParametersIuivNV` | definition |  | GL_NV_parameter_buffer_object:all:all | unclassified | - | - | - | - |
| `glProgramBufferParametersfvNV` | definition |  | GL_NV_parameter_buffer_object:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameter4dARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameter4dvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameter4fARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameter4fvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameterI4iNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameterI4ivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameterI4uiNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameterI4uivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramEnvParameters4fvEXT` | definition |  | GL_EXT_gpu_program_parameters:all:all | unclassified | - | - | - | - |
| `glProgramEnvParametersI4ivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramEnvParametersI4uivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameter4dARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameter4dvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameter4fARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameter4fvARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameterI4iNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameterI4ivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameterI4uiNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameterI4uivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramLocalParameters4fvEXT` | definition |  | GL_EXT_gpu_program_parameters:all:all | unclassified | - | - | - | - |
| `glProgramLocalParametersI4ivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramLocalParametersI4uivNV` | definition |  | GL_NV_gpu_program4:all:all | unclassified | - | - | - | - |
| `glProgramNamedParameter4dNV` | definition |  | GL_NV_fragment_program:all:all | unclassified | - | - | - | - |
| `glProgramNamedParameter4dvNV` | definition |  | GL_NV_fragment_program:all:all | unclassified | - | - | - | - |
| `glProgramNamedParameter4fNV` | definition |  | GL_NV_fragment_program:all:all | unclassified | - | - | - | - |
| `glProgramNamedParameter4fvNV` | definition |  | GL_NV_fragment_program:all:all | unclassified | - | - | - | - |
| `glProgramParameter4dNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramParameter4dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramParameter4fNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramParameter4fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramParameteri` | definition | GL_VERSION_4_1:+:all | GL_ARB_get_program_binary:all:all|GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramParameteriARB` | definition |  | GL_ARB_geometry_shader4:all:all | unclassified | - | - | - | - |
| `glProgramParameteriEXT` | definition |  | GL_EXT_geometry_shader4:all:all | unclassified | - | - | - | - |
| `glProgramParameters4dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramParameters4fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramPathFragmentInputGenNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glProgramStringARB` | definition |  | GL_ARB_fragment_program:all:all|GL_ARB_vertex_program:all:all | unclassified | - | - | - | - |
| `glProgramSubroutineParametersuivNV` | definition |  | GL_NV_gpu_program5:all:all | unclassified | - | - | - | - |
| `glProgramUniform1d` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1dEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1f` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1fEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1i` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform1i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform1i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform1i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform1iEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1iv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1ivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1ui` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform1ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform1ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform1ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform1uiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform1uiv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform1uivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2d` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2dEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2f` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2fEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2i` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform2i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform2i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform2i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform2iEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2iv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2ivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2ui` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform2ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform2ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform2ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform2uiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform2uiv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform2uivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3d` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3dEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3f` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3fEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3i` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform3i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform3i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform3i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform3iEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3iv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3ivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3ui` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform3ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform3ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform3ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform3uiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform3uiv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform3uivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4d` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4dEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4f` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4fEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4i` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform4i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform4i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform4i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform4iEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4iv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4ivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4ui` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform4ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform4ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glProgramUniform4ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glProgramUniform4uiEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniform4uiv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniform4uivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformHandleui64ARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glProgramUniformHandleui64NV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glProgramUniformHandleui64vARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glProgramUniformHandleui64vNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x3dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x3dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x3fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x3fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x4dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x4dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x4fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix2x4fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x2dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x2dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x2fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x2fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x4dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x4dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x4fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix3x4fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x2dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x2dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x2fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x2fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x3dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x3dvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x3fv` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glProgramUniformMatrix4x3fvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glProgramUniformui64NV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glProgramUniformui64vNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glProgramVertexLimitNV` | definition |  | GL_NV_geometry_program4:all:all | unclassified | - | - | - | - |
| `glProvokingVertex` | definition | GL_VERSION_3_2:+:all | GL_ARB_provoking_vertex:all:all | unclassified | - | - | - | - |
| `glProvokingVertexEXT` | definition |  | GL_EXT_provoking_vertex:all:all | unclassified | - | - | - | - |
| `glPushAttrib` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPushClientAttrib` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPushClientAttribDefaultEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glPushDebugGroup` | definition | GL_VERSION_4_3:+:all | GL_KHR_debug:all:all | unclassified | - | - | - | - |
| `glPushGroupMarkerEXT` | definition |  | GL_EXT_debug_marker:all:all | unclassified | - | - | - | - |
| `glPushMatrix` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glPushName` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glQueryCounter` | definition | GL_VERSION_3_3:+:all | GL_ARB_timer_query:all:all | common | src/driver/opengl.ab timestamp sampling | src/driver/opengl.ab typed extern signature | tests/application/main.ab repeated timestamp samples | tests/application/main.ab invalid query rejection |
| `glQueryMatrixxOES` | definition |  | GL_OES_query_matrix:all:all | unclassified | - | - | - | - |
| `glQueryObjectParameteruiAMD` | definition |  | GL_AMD_occlusion_query_event:all:all | unclassified | - | - | - | - |
| `glQueryResourceNV` | definition |  | GL_NV_query_resource:all:all | unclassified | - | - | - | - |
| `glQueryResourceTagNV` | definition |  | GL_NV_query_resource_tag:all:all | unclassified | - | - | - | - |
| `glRasterPos2d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRasterPos2xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRasterPos3d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos3xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRasterPos3xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRasterPos4d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRasterPos4xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRasterPos4xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRasterSamplesEXT` | definition |  | GL_EXT_raster_multisample:all:all|GL_NV_framebuffer_mixed_samples:all:all | unclassified | - | - | - | - |
| `glReadBuffer` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab MRT resolve selection | src/driver/opengl.ab typed extern signature | tests/application/main.ab exact second attachment resolve | tests/application/main.ab attachment bounds rejection |
| `glReadInstrumentsSGIX` | definition |  | GL_SGIX_instruments:all:all | unclassified | - | - | - | - |
| `glReadPixels` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab bounded framebuffer pixel readback | src/driver/opengl.ab typed region format type and output-pointer ABI | tests/application/main.ab exact surfaced and render-target RGBA8 pixels | tests/application/main.ab out-of-range texture readback rejection |
| `glReadnPixels` | definition | GL_VERSION_4_5:+:all | GL_KHR_robustness:all:all | unclassified | - | - | - | - |
| `glReadnPixelsARB` | definition |  | GL_ARB_robustness:all:all | unclassified | - | - | - | - |
| `glRectd` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRectdv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRectf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRectfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRecti` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRectiv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRects` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRectsv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRectxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glRectxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glReferencePlaneSGIX` | definition |  | GL_SGIX_reference_plane:all:all | unclassified | - | - | - | - |
| `glReleaseClientPointerRangeMESA` | definition |  | GL_MESA_map_buffer_client_pointer:all:all | unclassified | - | - | - | - |
| `glReleaseKeyedMutexWin32EXT` | definition |  | GL_EXT_win32_keyed_mutex:all:all | unclassified | - | - | - | - |
| `glReleaseShaderCompiler` | definition | GL_VERSION_4_1:+:all | GL_ARB_ES2_compatibility:all:all | unclassified | - | - | - | - |
| `glRenderGpuMaskNV` | definition |  | GL_NV_gpu_multicast:all:all | unclassified | - | - | - | - |
| `glRenderMode` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRenderbufferStorage` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glRenderbufferStorageEXT` | definition |  | GL_EXT_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glRenderbufferStorageMultisample` | definition | GL_VERSION_3_0:+:all | GL_ARB_framebuffer_object:all:all | unclassified | - | - | - | - |
| `glRenderbufferStorageMultisampleAdvancedAMD` | definition |  | GL_AMD_framebuffer_multisample_advanced:all:all | unclassified | - | - | - | - |
| `glRenderbufferStorageMultisampleCoverageNV` | definition |  | GL_NV_framebuffer_multisample_coverage:all:all | unclassified | - | - | - | - |
| `glRenderbufferStorageMultisampleEXT` | definition |  | GL_EXT_framebuffer_multisample:all:all | unclassified | - | - | - | - |
| `glReplacementCodePointerSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glReplacementCodeubSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glReplacementCodeubvSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiColor3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiColor3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiColor4fNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiColor4fNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiColor4ubVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiColor4ubVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiTexCoord2fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiTexCoord2fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuiVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glReplacementCodeuivSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glReplacementCodeusSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glReplacementCodeusvSUN` | definition |  | GL_SUN_triangle_list:all:all | unclassified | - | - | - | - |
| `glRequestResidentProgramsNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glResetHistogramEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glResetMemoryObjectParameterNV` | definition |  | GL_NV_memory_attachment:all:all | unclassified | - | - | - | - |
| `glResetMinmaxEXT` | definition |  | GL_EXT_histogram:all:all | unclassified | - | - | - | - |
| `glResizeBuffersMESA` | definition |  | GL_MESA_resize_buffers:all:all | unclassified | - | - | - | - |
| `glResolveDepthValuesNV` | definition |  | GL_NV_sample_locations:all:all | unclassified | - | - | - | - |
| `glResumeTransformFeedback` | definition | GL_VERSION_4_0:+:all | GL_ARB_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glResumeTransformFeedbackNV` | definition |  | GL_NV_transform_feedback2:all:all | unclassified | - | - | - | - |
| `glRotated` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRotatef` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glRotatexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glSampleCoverage` | definition | GL_VERSION_1_3:+:all |  | unclassified | - | - | - | - |
| `glSampleCoverageARB` | definition |  | GL_ARB_multisample:all:all | unclassified | - | - | - | - |
| `glSampleMapATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glSampleMaskEXT` | definition |  | GL_EXT_multisample:all:all | unclassified | - | - | - | - |
| `glSampleMaskIndexedNV` | definition |  | GL_NV_explicit_multisample:all:all | unclassified | - | - | - | - |
| `glSampleMaskSGIS` | definition |  | GL_SGIS_multisample:all:all | unclassified | - | - | - | - |
| `glSampleMaski` | definition | GL_VERSION_3_2:+:all | GL_ARB_texture_multisample:all:all | unclassified | - | - | - | - |
| `glSamplePatternEXT` | definition |  | GL_EXT_multisample:all:all | unclassified | - | - | - | - |
| `glSamplePatternSGIS` | definition |  | GL_SGIS_multisample:all:all | unclassified | - | - | - | - |
| `glSamplerParameterIiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glSamplerParameterIuiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glSamplerParameterf` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glSamplerParameterfv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | common | src/driver/opengl.ab anisotropy configuration | src/driver/opengl.ab typed float-pointer ABI | tests/application/main.ab maximum anisotropy sampler creation | src/sampler.ab unsupported anisotropy rejection |
| `glSamplerParameteri` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | common | src/driver/opengl.ab address filter LOD and comparison configuration | src/driver/opengl.ab typed integer parameter ABI | tests/application/main.ab repeat mirror linear and comparison sampler creation | src/resources.ab invalid address filter LOD and comparison rejection |
| `glSamplerParameteriv` | definition | GL_VERSION_3_3:+:all | GL_ARB_sampler_objects:all:all | unclassified | - | - | - | - |
| `glScaled` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glScalef` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glScalexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glScissor` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glScissorArrayv` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glScissorExclusiveArrayvNV` | definition |  | GL_NV_scissor_exclusive:all:all | unclassified | - | - | - | - |
| `glScissorExclusiveNV` | definition |  | GL_NV_scissor_exclusive:all:all | unclassified | - | - | - | - |
| `glScissorIndexed` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glScissorIndexedv` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3b` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3bEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3bv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3bvEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3d` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3dEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3dv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3dvEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3f` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3fEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3fv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3fvEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3i` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3iEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3iv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3ivEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3s` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3sEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3sv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3svEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3ub` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3ubEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3ubv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3ubvEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3ui` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3uiEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3uiv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3uivEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3us` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3usEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColor3usv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColor3usvEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColorFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glSecondaryColorPointer` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSecondaryColorPointerEXT` | definition |  | GL_EXT_secondary_color:all:all | unclassified | - | - | - | - |
| `glSecondaryColorPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glSelectBuffer` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glSelectPerfMonitorCountersAMD` | definition |  | GL_AMD_performance_monitor:all:all | unclassified | - | - | - | - |
| `glSemaphoreParameterivNV` | definition |  | GL_NV_timeline_semaphore:all:all | unclassified | - | - | - | - |
| `glSemaphoreParameterui64vEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glSeparableFilter2DEXT` | definition |  | GL_EXT_convolution:all:all | unclassified | - | - | - | - |
| `glSetFenceAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glSetFenceNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glSetFragmentShaderConstantATI` | definition |  | GL_ATI_fragment_shader:all:all | unclassified | - | - | - | - |
| `glSetInvariantEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glSetLocalConstantEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glSetMultisamplefvAMD` | definition |  | GL_AMD_sample_positions:all:all | unclassified | - | - | - | - |
| `glShadeModel` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glShaderBinary` | definition | GL_VERSION_4_1:+:all | GL_ARB_ES2_compatibility:all:all | common | src/driver/opengl.ab emitted SPIR-V shader upload | src/driver/opengl.ab typed shader-array format byte-buffer and length ABI | tests/application/main.ab specialized compute and raster SPIR-V pipelines | src/driver/opengl.ab binary upload error rejection |
| `glShaderOp1EXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glShaderOp2EXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glShaderOp3EXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glShaderSource` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab bounded GLSL source submission | src/driver/opengl.ab typed source-pointer array ABI | tests/opengl/main.ab valid source program creation | tests/opengl/main.ab malformed source rejection |
| `glShaderSourceARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glShaderStorageBlockBinding` | definition | GL_VERSION_4_3:+:all | GL_ARB_shader_storage_buffer_object:all:all | unclassified | - | - | - | - |
| `glShadingRateCombinerOpsEXT` | definition |  | GL_EXT_fragment_shading_rate:all:all | unclassified | - | - | - | - |
| `glShadingRateEXT` | definition |  | GL_EXT_fragment_shading_rate:all:all | unclassified | - | - | - | - |
| `glShadingRateImageBarrierNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glShadingRateImagePaletteNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glShadingRateSampleOrderCustomNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glShadingRateSampleOrderNV` | definition |  | GL_NV_shading_rate_image:all:all | unclassified | - | - | - | - |
| `glSharpenTexFuncSGIS` | definition |  | GL_SGIS_sharpen_texture:all:all | unclassified | - | - | - | - |
| `glSignalSemaphoreEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glSignalSemaphoreui64NVX` | definition |  | GL_NVX_progress_fence:all:all | unclassified | - | - | - | - |
| `glSignalVkFenceNV` | definition |  | GL_NV_draw_vulkan_image:all:all | unclassified | - | - | - | - |
| `glSignalVkSemaphoreNV` | definition |  | GL_NV_draw_vulkan_image:all:all | unclassified | - | - | - | - |
| `glSpecializeShader` | definition | GL_VERSION_4_6:+:all |  | common | src/driver/opengl.ab scalar-specialized SPIR-V entry point | src/driver/opengl.ab typed entry-name index and value arrays ABI | tests/application/main.ab exact bool int uint and float specialization | tests/application/main.ab mismatched specialization rejection |
| `glSpecializeShaderARB` | definition |  | GL_ARB_gl_spirv:all:all | unclassified | - | - | - | - |
| `glSpriteParameterfSGIX` | definition |  | GL_SGIX_sprite:all:all | unclassified | - | - | - | - |
| `glSpriteParameterfvSGIX` | definition |  | GL_SGIX_sprite:all:all | unclassified | - | - | - | - |
| `glSpriteParameteriSGIX` | definition |  | GL_SGIX_sprite:all:all | unclassified | - | - | - | - |
| `glSpriteParameterivSGIX` | definition |  | GL_SGIX_sprite:all:all | unclassified | - | - | - | - |
| `glStartInstrumentsSGIX` | definition |  | GL_SGIX_instruments:all:all | unclassified | - | - | - | - |
| `glStateCaptureNV` | definition |  | GL_NV_command_list:all:all | unclassified | - | - | - | - |
| `glStencilClearTagEXT` | definition |  | GL_EXT_stencil_clear_tag:all:all | unclassified | - | - | - | - |
| `glStencilFillPathInstancedNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilFillPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilFunc` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glStencilFuncSeparate` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glStencilFuncSeparateATI` | definition |  | GL_ATI_separate_stencil:all:all | unclassified | - | - | - | - |
| `glStencilMask` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glStencilMaskSeparate` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glStencilOp` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glStencilOpSeparate` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glStencilOpSeparateATI` | definition |  | GL_ATI_separate_stencil:all:all | unclassified | - | - | - | - |
| `glStencilOpValueAMD` | definition |  | GL_AMD_stencil_operation_extended:all:all | unclassified | - | - | - | - |
| `glStencilStrokePathInstancedNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilStrokePathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilThenCoverFillPathInstancedNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilThenCoverFillPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilThenCoverStrokePathInstancedNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStencilThenCoverStrokePathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glStopInstrumentsSGIX` | definition |  | GL_SGIX_instruments:all:all | unclassified | - | - | - | - |
| `glStringMarkerGREMEDY` | definition |  | GL_GREMEDY_string_marker:all:all | unclassified | - | - | - | - |
| `glSubpixelPrecisionBiasNV` | definition |  | GL_NV_conservative_raster:all:all | unclassified | - | - | - | - |
| `glSwizzleEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glSyncTextureINTEL` | definition |  | GL_INTEL_map_texture:all:all | unclassified | - | - | - | - |
| `glTagSampleBufferSGIX` | definition |  | GL_SGIX_tag_sample_buffer:all:all | unclassified | - | - | - | - |
| `glTangent3bEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3bvEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3dEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3dvEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3fEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3fvEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3iEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3ivEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3sEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangent3svEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTangentPointerEXT` | definition |  | GL_EXT_coordinate_frame:all:all | unclassified | - | - | - | - |
| `glTbufferMask3DFX` | definition |  | GL_3DFX_tbuffer:all:all | unclassified | - | - | - | - |
| `glTessellationFactorAMD` | definition |  | GL_AMD_vertex_shader_tessellator:all:all | unclassified | - | - | - | - |
| `glTessellationModeAMD` | definition |  | GL_AMD_vertex_shader_tessellator:all:all | unclassified | - | - | - | - |
| `glTestFenceAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glTestFenceNV` | definition |  | GL_NV_fence:all:all | unclassified | - | - | - | - |
| `glTestObjectAPPLE` | definition |  | GL_APPLE_fence:all:all | unclassified | - | - | - | - |
| `glTexAttachMemoryNV` | definition |  | GL_NV_memory_attachment:all:all | unclassified | - | - | - | - |
| `glTexBuffer` | definition | GL_VERSION_3_1:+:all |  | unclassified | - | - | - | - |
| `glTexBufferARB` | definition |  | GL_ARB_texture_buffer_object:all:all | unclassified | - | - | - | - |
| `glTexBufferEXT` | definition |  | GL_EXT_texture_buffer_object:all:all | unclassified | - | - | - | - |
| `glTexBufferRange` | definition | GL_VERSION_4_3:+:all | GL_ARB_texture_buffer_range:all:all | unclassified | - | - | - | - |
| `glTexBumpParameterfvATI` | definition |  | GL_ATI_envmap_bumpmap:all:all | unclassified | - | - | - | - |
| `glTexBumpParameterivATI` | definition |  | GL_ATI_envmap_bumpmap:all:all | unclassified | - | - | - | - |
| `glTexCoord1bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord1bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord1d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord1hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord1i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord1xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord1xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord2bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord2bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord2d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2fColor3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fColor3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fColor4fNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fColor4fNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fColor4ubVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fColor4ubVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fNormal3fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fNormal3fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fVertex3fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fVertex3fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord2fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord2hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord2i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord2xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord3bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord3bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord3d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord3i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord3xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord3xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord4bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord4bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glTexCoord4d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4fColor4fNormal3fVertex4fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord4fColor4fNormal3fVertex4fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord4fVertex4fSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord4fVertex4fvSUN` | definition |  | GL_SUN_vertex:all:all | unclassified | - | - | - | - |
| `glTexCoord4fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord4hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glTexCoord4i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoord4xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoord4xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexCoordFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glTexCoordPointer` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexCoordPointerEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glTexCoordPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glTexCoordPointervINTEL` | definition |  | GL_INTEL_parallel_arrays:all:all | unclassified | - | - | - | - |
| `glTexEnvf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexEnvfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexEnvi` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexEnviv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexEnvxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexEnvxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexFilterFuncSGIS` | definition |  | GL_SGIS_texture_filter4:all:all | unclassified | - | - | - | - |
| `glTexGend` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexGendv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexGenf` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexGenfv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexGeni` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexGeniv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTexGenxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexGenxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexImage1D` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glTexImage2D` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab per-mip texture storage allocation | src/driver/opengl.ab typed size format and data-pointer ABI | tests/application/main.ab exact multi-level texture upload and readback | tests/core.ab overflowing size and invalid multisample descriptor rejection |
| `glTexImage2DMultisample` | definition | GL_VERSION_3_2:+:all | GL_ARB_texture_multisample:all:all | common | src/driver/opengl.ab multisample allocation | src/driver/opengl.ab typed extern signature | tests/application/main.ab four-sample render target | tests/application/main.ab sample count rejection |
| `glTexImage2DMultisampleCoverageNV` | definition |  | GL_NV_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTexImage3D` | definition | GL_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `glTexImage3DEXT` | definition |  | GL_EXT_texture3D:all:all | unclassified | - | - | - | - |
| `glTexImage3DMultisample` | definition | GL_VERSION_3_2:+:all | GL_ARB_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTexImage3DMultisampleCoverageNV` | definition |  | GL_NV_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTexImage4DSGIS` | definition |  | GL_SGIS_texture4D:all:all | unclassified | - | - | - | - |
| `glTexPageCommitmentARB` | definition |  | GL_ARB_sparse_texture:all:all | unclassified | - | - | - | - |
| `glTexPageCommitmentMemNV` | definition |  | GL_NV_memory_object_sparse:all:all | unclassified | - | - | - | - |
| `glTexParameterIiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glTexParameterIivEXT` | definition |  | GL_EXT_texture_integer:all:all | unclassified | - | - | - | - |
| `glTexParameterIuiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glTexParameterIuivEXT` | definition |  | GL_EXT_texture_integer:all:all | unclassified | - | - | - | - |
| `glTexParameterf` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glTexParameterfv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glTexParameteri` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab allocated mip range configuration | src/driver/opengl.ab typed target parameter and value ABI | tests/application/main.ab four-level mip generation and readback | tests/core.ab invalid multisample mip-count rejection |
| `glTexParameteriv` | definition | GL_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `glTexParameterxOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexParameterxvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glTexRenderbufferNV` | definition |  | GL_NV_explicit_multisample:all:all | unclassified | - | - | - | - |
| `glTexStorage1D` | definition | GL_VERSION_4_2:+:all | GL_ARB_texture_storage:all:all | common | src/driver/opengl.ab immutable one-dimensional texture allocation | src/driver/opengl.ab typed levels format and width ABI | tests/wider_texture/main.ab live one-dimensional texture creation | tests/texture_contract.ab invalid one-dimensional shape rejection |
| `glTexStorage1DEXT` | definition |  | GL_EXT_texture_storage:all:all | unclassified | - | - | - | - |
| `glTexStorage2D` | definition | GL_VERSION_4_2:+:all | GL_ARB_texture_storage:all:all | common | src/driver/opengl.ab immutable two-dimensional and cube texture allocation | src/driver/opengl.ab typed levels format width and height ABI | tests/wider_texture/main.ab live cube and BC1 texture creation | tests/texture_contract.ab invalid cube and compressed descriptor rejection |
| `glTexStorage2DEXT` | definition |  | GL_EXT_texture_storage:all:all | unclassified | - | - | - | - |
| `glTexStorage2DMultisample` | definition | GL_VERSION_4_3:+:all | GL_ARB_texture_storage_multisample:all:all | unclassified | - | - | - | - |
| `glTexStorage3D` | definition | GL_VERSION_4_2:+:all | GL_ARB_texture_storage:all:all | common | src/driver/opengl.ab immutable array and volume texture allocation | src/driver/opengl.ab typed levels format width height and depth ABI | tests/wider_texture/main.ab live array and volume texture creation | tests/texture_contract.ab invalid array and volume descriptor rejection |
| `glTexStorage3DEXT` | definition |  | GL_EXT_texture_storage:all:all | unclassified | - | - | - | - |
| `glTexStorage3DMultisample` | definition | GL_VERSION_4_3:+:all | GL_ARB_texture_storage_multisample:all:all | unclassified | - | - | - | - |
| `glTexStorageMem1DEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTexStorageMem2DEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTexStorageMem2DMultisampleEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTexStorageMem3DEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTexStorageMem3DMultisampleEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTexStorageSparseAMD` | definition |  | GL_AMD_sparse_texture:all:all | unclassified | - | - | - | - |
| `glTexSubImage1D` | definition | GL_VERSION_1_1:+:all |  | unclassified | - | - | - | - |
| `glTexSubImage1DEXT` | definition |  | GL_EXT_subtexture:all:all | unclassified | - | - | - | - |
| `glTexSubImage2D` | definition | GL_VERSION_1_1:+:all |  | common | src/driver/opengl.ab checked pixel-region upload | src/driver/opengl.ab typed region format and pixel-pointer ABI | tests/application/main.ab exact partial upload and reupload readback | tests/application/main.ab out-of-range upload rejection |
| `glTexSubImage2DEXT` | definition |  | GL_EXT_subtexture:all:all | unclassified | - | - | - | - |
| `glTexSubImage3D` | definition | GL_VERSION_1_2:+:all |  | unclassified | - | - | - | - |
| `glTexSubImage3DEXT` | definition |  | GL_EXT_texture3D:all:all | unclassified | - | - | - | - |
| `glTexSubImage4DSGIS` | definition |  | GL_SGIS_texture4D:all:all | unclassified | - | - | - | - |
| `glTextureAttachMemoryNV` | definition |  | GL_NV_memory_attachment:all:all | unclassified | - | - | - | - |
| `glTextureBarrier` | definition | GL_VERSION_4_5:+:all | GL_ARB_texture_barrier:all:all | unclassified | - | - | - | - |
| `glTextureBarrierNV` | definition |  | GL_NV_texture_barrier:all:all | unclassified | - | - | - | - |
| `glTextureBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureBufferRange` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureBufferRangeEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureColorMaskSGIS` | definition |  | GL_SGIS_texture_color_mask:all:all | unclassified | - | - | - | - |
| `glTextureImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureImage2DMultisampleCoverageNV` | definition |  | GL_NV_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTextureImage2DMultisampleNV` | definition |  | GL_NV_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTextureImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureImage3DMultisampleCoverageNV` | definition |  | GL_NV_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTextureImage3DMultisampleNV` | definition |  | GL_NV_texture_multisample:all:all | unclassified | - | - | - | - |
| `glTextureLightEXT` | definition |  | GL_EXT_light_texture:all:all | unclassified | - | - | - | - |
| `glTextureMaterialEXT` | definition |  | GL_EXT_light_texture:all:all | unclassified | - | - | - | - |
| `glTextureNormalEXT` | definition |  | GL_EXT_texture_perturb_normal:all:all | unclassified | - | - | - | - |
| `glTexturePageCommitmentEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTexturePageCommitmentMemNV` | definition |  | GL_NV_memory_object_sparse:all:all | unclassified | - | - | - | - |
| `glTextureParameterIiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterIivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterIuiv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterIuivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterf` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterfEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterfv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterfvEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameteri` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameteriEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameteriv` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureParameterivEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureRangeAPPLE` | definition |  | GL_APPLE_texture_range:all:all | unclassified | - | - | - | - |
| `glTextureRenderbufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage1D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_texture_storage:all:all | unclassified | - | - | - | - |
| `glTextureStorage2D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_texture_storage:all:all | unclassified | - | - | - | - |
| `glTextureStorage2DMultisample` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage2DMultisampleEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage3D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all|GL_EXT_texture_storage:all:all | unclassified | - | - | - | - |
| `glTextureStorage3DMultisample` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorage3DMultisampleEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureStorageMem1DEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTextureStorageMem2DEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTextureStorageMem2DMultisampleEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTextureStorageMem3DEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTextureStorageMem3DMultisampleEXT` | definition |  | GL_EXT_memory_object:all:all | unclassified | - | - | - | - |
| `glTextureStorageSparseAMD` | definition |  | GL_AMD_sparse_texture:all:all | unclassified | - | - | - | - |
| `glTextureSubImage1D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab raw one-dimensional byte upload | src/driver/opengl.ab typed DSA region format and pointer ABI | tests/wider_texture/main.ab exact one-dimensional raw byte round trip | tests/texture_contract.ab one-dimensional region shape rejection |
| `glTextureSubImage1DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureSubImage2D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab raw pitched two-dimensional byte upload | src/driver/opengl.ab typed DSA region format and pointer ABI | tests/wider_texture/main.ab exact pitched R8 two-dimensional round trip | tests/wider_texture/main.ab short source rejection |
| `glTextureSubImage2DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureSubImage3D` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | common | src/driver/opengl.ab and src/driver/opengl_transfer.ab raw array cube and volume byte upload | src/driver/opengl.ab typed DSA xyz extent format and pointer ABI | tests/wider_texture/main.ab and tests/wider_texture_transfer/main.ab exact array cube and volume round trips | tests/texture_contract.ab crossing depth and layer rejection |
| `glTextureSubImage3DEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTextureView` | definition | GL_VERSION_4_3:+:all | GL_ARB_texture_view:all:all | common | src/driver/opengl.ab owned subresource and compatible-format views | src/driver/opengl.ab typed target format mip and layer ABI | tests/wider_texture/main.ab live array cube volume and BC1 view ownership | tests/texture_contract.ab incompatible view rejection |
| `glTrackMatrixNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glTransformFeedbackAttribsNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glTransformFeedbackBufferBase` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTransformFeedbackBufferRange` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glTransformFeedbackStreamAttribsNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glTransformFeedbackVaryings` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glTransformFeedbackVaryingsEXT` | definition |  | GL_EXT_transform_feedback:all:all | unclassified | - | - | - | - |
| `glTransformFeedbackVaryingsNV` | definition |  | GL_NV_transform_feedback:all:all | unclassified | - | - | - | - |
| `glTransformPathNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glTranslated` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTranslatef` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glTranslatexOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glUniform1d` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform1dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform1f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform1fARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform1fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform1fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform1i` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform1i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform1i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform1i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform1i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform1iARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform1iv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform1ivARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform1ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform1ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform1ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform1ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform1ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform1uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform1uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform1uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform2d` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform2dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform2f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform2fARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform2fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform2fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform2i` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform2i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform2i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform2i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform2i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform2iARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform2iv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform2ivARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform2ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform2ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform2ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform2ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform2ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform2uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform2uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform2uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform3d` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform3dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform3f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform3fARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform3fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform3fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform3i` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform3i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform3i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform3i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform3i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform3iARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform3iv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform3ivARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform3ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform3ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform3ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform3ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform3ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform3uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform3uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform3uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform4d` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform4dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniform4f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform4fARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform4fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform4fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform4i` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform4i64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform4i64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform4i64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform4i64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform4iARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform4iv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniform4ivARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniform4ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform4ui64ARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform4ui64NV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform4ui64vARB` | definition |  | GL_ARB_gpu_shader_int64:all:all | unclassified | - | - | - | - |
| `glUniform4ui64vNV` | definition |  | GL_AMD_gpu_shader_int64:all:all|GL_NV_gpu_shader5:all:all | unclassified | - | - | - | - |
| `glUniform4uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniform4uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glUniform4uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all | unclassified | - | - | - | - |
| `glUniformBlockBinding` | definition | GL_VERSION_3_1:+:all | GL_ARB_uniform_buffer_object:all:all | unclassified | - | - | - | - |
| `glUniformBufferEXT` | definition |  | GL_EXT_bindable_uniform:all:all | unclassified | - | - | - | - |
| `glUniformHandleui64ARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glUniformHandleui64NV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glUniformHandleui64vARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glUniformHandleui64vNV` | definition |  | GL_NV_bindless_texture:all:all | unclassified | - | - | - | - |
| `glUniformMatrix2dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix2fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix2fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniformMatrix2x3dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix2x3fv` | definition | GL_VERSION_2_1:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix2x4dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix2x4fv` | definition | GL_VERSION_2_1:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix3dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix3fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix3fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniformMatrix3x2dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix3x2fv` | definition | GL_VERSION_2_1:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix3x4dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix3x4fv` | definition | GL_VERSION_2_1:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix4dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix4fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix4fvARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUniformMatrix4x2dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix4x2fv` | definition | GL_VERSION_2_1:+:all |  | unclassified | - | - | - | - |
| `glUniformMatrix4x3dv` | definition | GL_VERSION_4_0:+:all | GL_ARB_gpu_shader_fp64:all:all | unclassified | - | - | - | - |
| `glUniformMatrix4x3fv` | definition | GL_VERSION_2_1:+:all |  | unclassified | - | - | - | - |
| `glUniformSubroutinesuiv` | definition | GL_VERSION_4_0:+:all | GL_ARB_shader_subroutine:all:all | unclassified | - | - | - | - |
| `glUniformui64NV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glUniformui64vNV` | definition |  | GL_NV_shader_buffer_load:all:all | unclassified | - | - | - | - |
| `glUnlockArraysEXT` | definition |  | GL_EXT_compiled_vertex_array:all:all | unclassified | - | - | - | - |
| `glUnmapBuffer` | definition | GL_VERSION_1_5:+:all |  | common | src/driver/opengl.ab explicit reusable and affine mapping completion | src/driver/opengl.ab typed result ABI | examples/common-buffer/main.ab repeated write-read unmap with zero growth | tests/application/main.ab repeated unmap and mapped GPU use rejection |
| `glUnmapBufferARB` | definition |  | GL_ARB_vertex_buffer_object:all:all | unclassified | - | - | - | - |
| `glUnmapNamedBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glUnmapNamedBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glUnmapObjectBufferATI` | definition |  | GL_ATI_map_object_buffer:all:all | unclassified | - | - | - | - |
| `glUnmapTexture2DINTEL` | definition |  | GL_INTEL_map_texture:all:all | unclassified | - | - | - | - |
| `glUpdateObjectBufferATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glUploadGpuMaskNVX` | definition |  | GL_NVX_gpu_multicast2:all:all | unclassified | - | - | - | - |
| `glUseProgram` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab render and compute program binding | src/driver/opengl.ab typed program-name ABI | tests/opengl/main.ab valid program bind and unbind | tests/application/main.ab invalid pipeline rejection before binding |
| `glUseProgramObjectARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glUseProgramStages` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glUseShaderProgramEXT` | definition |  | GL_EXT_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glVDPAUFiniNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAUGetSurfaceivNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAUInitNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAUIsSurfaceNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAUMapSurfacesNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAURegisterOutputSurfaceNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAURegisterVideoSurfaceNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAURegisterVideoSurfaceWithPictureStructureNV` | definition |  | GL_NV_vdpau_interop2:all:all | unclassified | - | - | - | - |
| `glVDPAUSurfaceAccessNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAUUnmapSurfacesNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glVDPAUUnregisterSurfaceNV` | definition |  | GL_NV_vdpau_interop:all:all | unclassified | - | - | - | - |
| `glValidateProgram` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glValidateProgramARB` | definition |  | GL_ARB_shader_objects:all:all | unclassified | - | - | - | - |
| `glValidateProgramPipeline` | definition | GL_VERSION_4_1:+:all | GL_ARB_separate_shader_objects:all:all | unclassified | - | - | - | - |
| `glVariantArrayObjectATI` | definition |  | GL_ATI_vertex_array_object:all:all | unclassified | - | - | - | - |
| `glVariantPointerEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantbvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantdvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantfvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantivEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantsvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantubvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantuivEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVariantusvEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertex2bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glVertex2bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glVertex2d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertex2hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertex2i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex2xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glVertex2xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glVertex3bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glVertex3bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glVertex3d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertex3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertex3i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex3xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glVertex3xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glVertex4bOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glVertex4bvOES` | definition |  | GL_OES_byte_coordinates:all:all | unclassified | - | - | - | - |
| `glVertex4d` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4dv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4f` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4fv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertex4hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertex4i` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4iv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4s` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4sv` | definition | GL_VERSION_1_0:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertex4xOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glVertex4xvOES` | definition |  | GL_OES_fixed_point:all:all | unclassified | - | - | - | - |
| `glVertexArrayAttribBinding` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayAttribFormat` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayAttribIFormat` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayAttribLFormat` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayBindVertexBufferEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayBindingDivisor` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayColorOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayEdgeFlagOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayElementBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayFogCoordOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayIndexOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayMultiTexCoordOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayNormalOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayParameteriAPPLE` | definition |  | GL_APPLE_vertex_array_range:all:all | unclassified | - | - | - | - |
| `glVertexArrayRangeAPPLE` | definition |  | GL_APPLE_vertex_array_range:all:all | unclassified | - | - | - | - |
| `glVertexArrayRangeNV` | definition |  | GL_NV_vertex_array_range:all:all | unclassified | - | - | - | - |
| `glVertexArraySecondaryColorOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayTexCoordOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribBindingEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribDivisorEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribFormatEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribIFormatEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribIOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribLFormatEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribLOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexAttribOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexBindingDivisorEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexBuffer` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexBuffers` | definition | GL_VERSION_4_5:+:all | GL_ARB_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexArrayVertexOffsetEXT` | definition |  | GL_EXT_direct_state_access:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1d` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib1dARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1dNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1dv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib1dvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib1fARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1fNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib1fvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1s` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib1sARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1sNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1sv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib1svARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib1svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2d` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib2dARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2dNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2dv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib2dvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib2fARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2fNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib2fvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2s` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib2sARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2sNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2sv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib2svARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib2svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3d` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib3dARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3dNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3dv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib3dvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib3fARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3fNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib3fvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3s` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib3sARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3sNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3sv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib3svARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib3svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Nbv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NbvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Niv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NivARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Nsv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NsvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Nub` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NubARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Nubv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NubvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Nuiv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NuivARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4Nusv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4NusvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4bv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4bvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4d` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4dARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4dNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4dv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4dvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4f` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4fARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4fNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4fv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4fvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4hNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4iv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4ivARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4s` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4sARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4sNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4sv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4svARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4ubNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4ubv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4ubvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4ubvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4uiv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4uivARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttrib4usv` | definition | GL_VERSION_2_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttrib4usvARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttribArrayObjectATI` | definition |  | GL_ATI_vertex_attrib_array_object:all:all | unclassified | - | - | - | - |
| `glVertexAttribBinding` | definition | GL_VERSION_4_3:+:all | GL_ARB_vertex_attrib_binding:all:all | unclassified | - | - | - | - |
| `glVertexAttribDivisor` | definition | GL_VERSION_3_3:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribDivisorARB` | definition |  | GL_ARB_instanced_arrays:all:all | unclassified | - | - | - | - |
| `glVertexAttribFormat` | definition | GL_VERSION_4_3:+:all | GL_ARB_vertex_attrib_binding:all:all | unclassified | - | - | - | - |
| `glVertexAttribFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glVertexAttribI1i` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI1iEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI1iv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI1ivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI1ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI1uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI1uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI1uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI2i` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI2iEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI2iv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI2ivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI2ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI2uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI2uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI2uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI3i` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI3iEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI3iv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI3ivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI3ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI3uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI3uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI3uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4bv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4bvEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4i` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4iEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4iv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4ivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4sv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4svEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4ubv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4ubvEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4ui` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4uiEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4uiv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4uivEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribI4usv` | definition | GL_VERSION_3_0:+:all |  | unclassified | - | - | - | - |
| `glVertexAttribI4usvEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribIFormat` | definition | GL_VERSION_4_3:+:all | GL_ARB_vertex_attrib_binding:all:all | unclassified | - | - | - | - |
| `glVertexAttribIFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glVertexAttribIPointer` | definition | GL_VERSION_3_0:+:all |  | common | src/driver/opengl.ab reflected unsigned integer vertex layout | src/driver/opengl.ab typed location width type stride and offset ABI | examples/common-triangle/main.ab live interleaved uint vertex input on both backends | examples/common-triangle/main.ab missing or mismatched integer attribute rejection |
| `glVertexAttribIPointerEXT` | definition |  | GL_EXT_gpu_shader4:all:all|GL_NV_vertex_program4:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1d` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1dEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1dvEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1i64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1i64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1ui64ARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1ui64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1ui64vARB` | definition |  | GL_ARB_bindless_texture:all:all | unclassified | - | - | - | - |
| `glVertexAttribL1ui64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2d` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2dEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2dvEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2i64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2i64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2ui64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL2ui64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3d` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3dEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3dvEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3i64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3i64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3ui64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL3ui64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4d` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4dEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4dv` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4dvEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4i64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4i64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4ui64NV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribL4ui64vNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribLFormat` | definition | GL_VERSION_4_3:+:all | GL_ARB_vertex_attrib_binding:all:all | unclassified | - | - | - | - |
| `glVertexAttribLFormatNV` | definition |  | GL_NV_vertex_attrib_integer_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribLPointer` | definition | GL_VERSION_4_1:+:all | GL_ARB_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribLPointerEXT` | definition |  | GL_EXT_vertex_attrib_64bit:all:all | unclassified | - | - | - | - |
| `glVertexAttribP1ui` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP1uiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP2ui` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP2uiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP3ui` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP3uiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP4ui` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribP4uiv` | definition | GL_VERSION_3_3:+:all | GL_ARB_vertex_type_2_10_10_10_rev:all:all | unclassified | - | - | - | - |
| `glVertexAttribParameteriAMD` | definition |  | GL_AMD_interleaved_elements:all:all | unclassified | - | - | - | - |
| `glVertexAttribPointer` | definition | GL_VERSION_2_0:+:all |  | common | src/driver/opengl.ab reflected floating vertex layout with buffer base offset | src/driver/opengl.ab typed location width type stride and summed offset ABI | examples/push-color/main.ab nonzero pooled target pass and surfaced rendering | tests/pool/main.ab surfaced and offscreen misaligned range rejection |
| `glVertexAttribPointerARB` | definition |  | GL_ARB_vertex_program:all:all|GL_ARB_vertex_shader:all:all | unclassified | - | - | - | - |
| `glVertexAttribPointerNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs1dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs1fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs1hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttribs1svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs2dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs2fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs2hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttribs2svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs3dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs3fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs3hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttribs3svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs4dvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs4fvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs4hvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexAttribs4svNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexAttribs4ubvNV` | definition |  | GL_NV_vertex_program:all:all | unclassified | - | - | - | - |
| `glVertexBindingDivisor` | definition | GL_VERSION_4_3:+:all | GL_ARB_vertex_attrib_binding:all:all | unclassified | - | - | - | - |
| `glVertexBlendARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glVertexBlendEnvfATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexBlendEnviATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexFormatNV` | definition |  | GL_NV_vertex_buffer_unified_memory:all:all | unclassified | - | - | - | - |
| `glVertexPointer` | definition | GL_VERSION_1_1:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glVertexPointerEXT` | definition |  | GL_EXT_vertex_array:all:all | unclassified | - | - | - | - |
| `glVertexPointerListIBM` | definition |  | GL_IBM_vertex_array_lists:all:all | unclassified | - | - | - | - |
| `glVertexPointervINTEL` | definition |  | GL_INTEL_parallel_arrays:all:all | unclassified | - | - | - | - |
| `glVertexStream1dATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1dvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1fATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1fvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1iATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1ivATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1sATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream1svATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2dATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2dvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2fATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2fvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2iATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2ivATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2sATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream2svATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3dATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3dvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3fATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3fvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3iATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3ivATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3sATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream3svATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4dATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4dvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4fATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4fvATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4iATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4ivATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4sATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexStream4svATI` | definition |  | GL_ATI_vertex_streams:all:all | unclassified | - | - | - | - |
| `glVertexWeightPointerEXT` | definition |  | GL_EXT_vertex_weighting:all:all | unclassified | - | - | - | - |
| `glVertexWeightfEXT` | definition |  | GL_EXT_vertex_weighting:all:all | unclassified | - | - | - | - |
| `glVertexWeightfvEXT` | definition |  | GL_EXT_vertex_weighting:all:all | unclassified | - | - | - | - |
| `glVertexWeighthNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVertexWeighthvNV` | definition |  | GL_NV_half_float:all:all | unclassified | - | - | - | - |
| `glVideoCaptureNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glVideoCaptureStreamParameterdvNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glVideoCaptureStreamParameterfvNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glVideoCaptureStreamParameterivNV` | definition |  | GL_NV_video_capture:all:all | unclassified | - | - | - | - |
| `glViewport` | definition | GL_VERSION_1_0:+:all |  | common | src/driver/opengl.ab surfaced and offscreen viewport state | src/driver/opengl.ab typed origin and extent ABI | examples/common-triangle/main.ab exact resize to 640 by 480 | tests/application/main.ab invalid zero extent rejection |
| `glViewportArrayv` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glViewportIndexedf` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glViewportIndexedfv` | definition | GL_VERSION_4_1:+:all | GL_ARB_viewport_array:all:all | unclassified | - | - | - | - |
| `glViewportPositionWScaleNV` | definition |  | GL_NV_clip_space_w_scaling:all:all | unclassified | - | - | - | - |
| `glViewportSwizzleNV` | definition |  | GL_NV_viewport_swizzle:all:all | unclassified | - | - | - | - |
| `glWaitSemaphoreEXT` | definition |  | GL_EXT_semaphore:all:all | unclassified | - | - | - | - |
| `glWaitSemaphoreui64NVX` | definition |  | GL_NVX_progress_fence:all:all | unclassified | - | - | - | - |
| `glWaitSync` | definition | GL_VERSION_3_2:+:all | GL_ARB_sync:all:all | unclassified | - | - | - | - |
| `glWaitVkSemaphoreNV` | definition |  | GL_NV_draw_vulkan_image:all:all | unclassified | - | - | - | - |
| `glWeightPathsNV` | definition |  | GL_NV_path_rendering:all:all | unclassified | - | - | - | - |
| `glWeightPointerARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightbvARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightdvARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightfvARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightivARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightsvARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightubvARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightuivARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWeightusvARB` | definition |  | GL_ARB_vertex_blend:all:all | unclassified | - | - | - | - |
| `glWindowPos2d` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2dARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2dMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2dv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2dvARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2dvMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2f` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2fARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2fMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2fv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2fvARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2fvMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2i` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2iARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2iMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2iv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2ivARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2ivMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2s` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2sARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2sMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2sv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos2svARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos2svMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3d` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3dARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3dMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3dv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3dvARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3dvMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3f` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3fARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3fMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3fv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3fvARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3fvMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3i` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3iARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3iMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3iv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3ivARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3ivMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3s` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3sARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3sMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3sv` | definition | GL_VERSION_1_4:+:all|GL_VERSION_3_2:-:core |  | unclassified | - | - | - | - |
| `glWindowPos3svARB` | definition |  | GL_ARB_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos3svMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4dMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4dvMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4fMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4fvMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4iMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4ivMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4sMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowPos4svMESA` | definition |  | GL_MESA_window_pos:all:all | unclassified | - | - | - | - |
| `glWindowRectanglesEXT` | definition |  | GL_EXT_window_rectangles:all:all | unclassified | - | - | - | - |
| `glWriteMaskEXT` | definition |  | GL_EXT_vertex_shader:all:all | unclassified | - | - | - | - |

## Core features

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `GL_VERSION_1_0` | unclassified | - | - | - | - |
| `GL_VERSION_1_1` | unclassified | - | - | - | - |
| `GL_VERSION_1_2` | unclassified | - | - | - | - |
| `GL_VERSION_1_3` | unclassified | - | - | - | - |
| `GL_VERSION_1_4` | unclassified | - | - | - | - |
| `GL_VERSION_1_5` | unclassified | - | - | - | - |
| `GL_VERSION_2_0` | unclassified | - | - | - | - |
| `GL_VERSION_2_1` | unclassified | - | - | - | - |
| `GL_VERSION_3_0` | unclassified | - | - | - | - |
| `GL_VERSION_3_1` | unclassified | - | - | - | - |
| `GL_VERSION_3_2` | unclassified | - | - | - | - |
| `GL_VERSION_3_3` | unclassified | - | - | - | - |
| `GL_VERSION_4_0` | unclassified | - | - | - | - |
| `GL_VERSION_4_1` | unclassified | - | - | - | - |
| `GL_VERSION_4_2` | unclassified | - | - | - | - |
| `GL_VERSION_4_3` | unclassified | - | - | - | - |
| `GL_VERSION_4_4` | unclassified | - | - | - | - |
| `GL_VERSION_4_5` | unclassified | - | - | - | - |
| `GL_VERSION_4_6` | unclassified | - | - | - | - |

## Extensions

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `GL_3DFX_multisample` | unclassified | - | - | - | - |
| `GL_3DFX_tbuffer` | unclassified | - | - | - | - |
| `GL_3DFX_texture_compression_FXT1` | unclassified | - | - | - | - |
| `GL_AMD_blend_minmax_factor` | unclassified | - | - | - | - |
| `GL_AMD_conservative_depth` | unclassified | - | - | - | - |
| `GL_AMD_debug_output` | unclassified | - | - | - | - |
| `GL_AMD_depth_clamp_separate` | unclassified | - | - | - | - |
| `GL_AMD_draw_buffers_blend` | unclassified | - | - | - | - |
| `GL_AMD_framebuffer_multisample_advanced` | unclassified | - | - | - | - |
| `GL_AMD_framebuffer_sample_positions` | unclassified | - | - | - | - |
| `GL_AMD_gcn_shader` | unclassified | - | - | - | - |
| `GL_AMD_gpu_shader_half_float` | unclassified | - | - | - | - |
| `GL_AMD_gpu_shader_int16` | unclassified | - | - | - | - |
| `GL_AMD_gpu_shader_int64` | unclassified | - | - | - | - |
| `GL_AMD_interleaved_elements` | unclassified | - | - | - | - |
| `GL_AMD_multi_draw_indirect` | unclassified | - | - | - | - |
| `GL_AMD_name_gen_delete` | unclassified | - | - | - | - |
| `GL_AMD_occlusion_query_event` | unclassified | - | - | - | - |
| `GL_AMD_performance_monitor` | unclassified | - | - | - | - |
| `GL_AMD_pinned_memory` | unclassified | - | - | - | - |
| `GL_AMD_query_buffer_object` | unclassified | - | - | - | - |
| `GL_AMD_sample_positions` | unclassified | - | - | - | - |
| `GL_AMD_seamless_cubemap_per_texture` | unclassified | - | - | - | - |
| `GL_AMD_shader_atomic_counter_ops` | unclassified | - | - | - | - |
| `GL_AMD_shader_ballot` | unclassified | - | - | - | - |
| `GL_AMD_shader_explicit_vertex_parameter` | unclassified | - | - | - | - |
| `GL_AMD_shader_gpu_shader_half_float_fetch` | unclassified | - | - | - | - |
| `GL_AMD_shader_image_load_store_lod` | unclassified | - | - | - | - |
| `GL_AMD_shader_stencil_export` | unclassified | - | - | - | - |
| `GL_AMD_shader_trinary_minmax` | unclassified | - | - | - | - |
| `GL_AMD_sparse_texture` | unclassified | - | - | - | - |
| `GL_AMD_stencil_operation_extended` | unclassified | - | - | - | - |
| `GL_AMD_texture_gather_bias_lod` | unclassified | - | - | - | - |
| `GL_AMD_texture_texture4` | unclassified | - | - | - | - |
| `GL_AMD_transform_feedback3_lines_triangles` | unclassified | - | - | - | - |
| `GL_AMD_transform_feedback4` | unclassified | - | - | - | - |
| `GL_AMD_vertex_shader_layer` | unclassified | - | - | - | - |
| `GL_AMD_vertex_shader_tessellator` | unclassified | - | - | - | - |
| `GL_AMD_vertex_shader_viewport_index` | unclassified | - | - | - | - |
| `GL_APPLE_aux_depth_stencil` | unclassified | - | - | - | - |
| `GL_APPLE_client_storage` | unclassified | - | - | - | - |
| `GL_APPLE_element_array` | unclassified | - | - | - | - |
| `GL_APPLE_fence` | unclassified | - | - | - | - |
| `GL_APPLE_float_pixels` | unclassified | - | - | - | - |
| `GL_APPLE_flush_buffer_range` | unclassified | - | - | - | - |
| `GL_APPLE_object_purgeable` | unclassified | - | - | - | - |
| `GL_APPLE_rgb_422` | unclassified | - | - | - | - |
| `GL_APPLE_row_bytes` | unclassified | - | - | - | - |
| `GL_APPLE_specular_vector` | unclassified | - | - | - | - |
| `GL_APPLE_texture_range` | unclassified | - | - | - | - |
| `GL_APPLE_transform_hint` | unclassified | - | - | - | - |
| `GL_APPLE_vertex_array_object` | unclassified | - | - | - | - |
| `GL_APPLE_vertex_array_range` | unclassified | - | - | - | - |
| `GL_APPLE_vertex_program_evaluators` | unclassified | - | - | - | - |
| `GL_APPLE_ycbcr_422` | unclassified | - | - | - | - |
| `GL_ARB_ES2_compatibility` | unclassified | - | - | - | - |
| `GL_ARB_ES3_1_compatibility` | unclassified | - | - | - | - |
| `GL_ARB_ES3_2_compatibility` | unclassified | - | - | - | - |
| `GL_ARB_ES3_compatibility` | unclassified | - | - | - | - |
| `GL_ARB_arrays_of_arrays` | unclassified | - | - | - | - |
| `GL_ARB_base_instance` | unclassified | - | - | - | - |
| `GL_ARB_bindless_texture` | unclassified | - | - | - | - |
| `GL_ARB_blend_func_extended` | unclassified | - | - | - | - |
| `GL_ARB_buffer_storage` | unclassified | - | - | - | - |
| `GL_ARB_cl_event` | unclassified | - | - | - | - |
| `GL_ARB_clear_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_clear_texture` | unclassified | - | - | - | - |
| `GL_ARB_clip_control` | unclassified | - | - | - | - |
| `GL_ARB_color_buffer_float` | unclassified | - | - | - | - |
| `GL_ARB_compatibility` | unclassified | - | - | - | - |
| `GL_ARB_compressed_texture_pixel_storage` | unclassified | - | - | - | - |
| `GL_ARB_compute_shader` | unclassified | - | - | - | - |
| `GL_ARB_compute_variable_group_size` | unclassified | - | - | - | - |
| `GL_ARB_conditional_render_inverted` | unclassified | - | - | - | - |
| `GL_ARB_conservative_depth` | unclassified | - | - | - | - |
| `GL_ARB_copy_buffer` | unclassified | - | - | - | - |
| `GL_ARB_copy_image` | unclassified | - | - | - | - |
| `GL_ARB_cull_distance` | unclassified | - | - | - | - |
| `GL_ARB_debug_output` | unclassified | - | - | - | - |
| `GL_ARB_depth_buffer_float` | unclassified | - | - | - | - |
| `GL_ARB_depth_clamp` | unclassified | - | - | - | - |
| `GL_ARB_depth_texture` | unclassified | - | - | - | - |
| `GL_ARB_derivative_control` | unclassified | - | - | - | - |
| `GL_ARB_direct_state_access` | unclassified | - | - | - | - |
| `GL_ARB_draw_buffers` | unclassified | - | - | - | - |
| `GL_ARB_draw_buffers_blend` | unclassified | - | - | - | - |
| `GL_ARB_draw_elements_base_vertex` | unclassified | - | - | - | - |
| `GL_ARB_draw_indirect` | unclassified | - | - | - | - |
| `GL_ARB_draw_instanced` | unclassified | - | - | - | - |
| `GL_ARB_enhanced_layouts` | unclassified | - | - | - | - |
| `GL_ARB_explicit_attrib_location` | unclassified | - | - | - | - |
| `GL_ARB_explicit_uniform_location` | unclassified | - | - | - | - |
| `GL_ARB_fragment_coord_conventions` | unclassified | - | - | - | - |
| `GL_ARB_fragment_layer_viewport` | unclassified | - | - | - | - |
| `GL_ARB_fragment_program` | unclassified | - | - | - | - |
| `GL_ARB_fragment_program_shadow` | unclassified | - | - | - | - |
| `GL_ARB_fragment_shader` | unclassified | - | - | - | - |
| `GL_ARB_fragment_shader_interlock` | unclassified | - | - | - | - |
| `GL_ARB_framebuffer_no_attachments` | unclassified | - | - | - | - |
| `GL_ARB_framebuffer_object` | unclassified | - | - | - | - |
| `GL_ARB_framebuffer_sRGB` | unclassified | - | - | - | - |
| `GL_ARB_geometry_shader4` | unclassified | - | - | - | - |
| `GL_ARB_get_program_binary` | unclassified | - | - | - | - |
| `GL_ARB_get_texture_sub_image` | unclassified | - | - | - | - |
| `GL_ARB_gl_spirv` | unclassified | - | - | - | - |
| `GL_ARB_gpu_shader5` | unclassified | - | - | - | - |
| `GL_ARB_gpu_shader_fp64` | unclassified | - | - | - | - |
| `GL_ARB_gpu_shader_int64` | unclassified | - | - | - | - |
| `GL_ARB_half_float_pixel` | unclassified | - | - | - | - |
| `GL_ARB_half_float_vertex` | unclassified | - | - | - | - |
| `GL_ARB_imaging` | unclassified | - | - | - | - |
| `GL_ARB_indirect_parameters` | unclassified | - | - | - | - |
| `GL_ARB_instanced_arrays` | unclassified | - | - | - | - |
| `GL_ARB_internalformat_query` | unclassified | - | - | - | - |
| `GL_ARB_internalformat_query2` | unclassified | - | - | - | - |
| `GL_ARB_invalidate_subdata` | unclassified | - | - | - | - |
| `GL_ARB_map_buffer_alignment` | unclassified | - | - | - | - |
| `GL_ARB_map_buffer_range` | unclassified | - | - | - | - |
| `GL_ARB_matrix_palette` | unclassified | - | - | - | - |
| `GL_ARB_multi_bind` | unclassified | - | - | - | - |
| `GL_ARB_multi_draw_indirect` | unclassified | - | - | - | - |
| `GL_ARB_multisample` | unclassified | - | - | - | - |
| `GL_ARB_multitexture` | unclassified | - | - | - | - |
| `GL_ARB_occlusion_query` | unclassified | - | - | - | - |
| `GL_ARB_occlusion_query2` | unclassified | - | - | - | - |
| `GL_ARB_parallel_shader_compile` | unclassified | - | - | - | - |
| `GL_ARB_pipeline_statistics_query` | unclassified | - | - | - | - |
| `GL_ARB_pixel_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_point_parameters` | unclassified | - | - | - | - |
| `GL_ARB_point_sprite` | unclassified | - | - | - | - |
| `GL_ARB_polygon_offset_clamp` | unclassified | - | - | - | - |
| `GL_ARB_post_depth_coverage` | unclassified | - | - | - | - |
| `GL_ARB_program_interface_query` | unclassified | - | - | - | - |
| `GL_ARB_provoking_vertex` | unclassified | - | - | - | - |
| `GL_ARB_query_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_robust_buffer_access_behavior` | unclassified | - | - | - | - |
| `GL_ARB_robustness` | unclassified | - | - | - | - |
| `GL_ARB_robustness_isolation` | unclassified | - | - | - | - |
| `GL_ARB_sample_locations` | unclassified | - | - | - | - |
| `GL_ARB_sample_shading` | unclassified | - | - | - | - |
| `GL_ARB_sampler_objects` | unclassified | - | - | - | - |
| `GL_ARB_seamless_cube_map` | unclassified | - | - | - | - |
| `GL_ARB_seamless_cubemap_per_texture` | unclassified | - | - | - | - |
| `GL_ARB_separate_shader_objects` | unclassified | - | - | - | - |
| `GL_ARB_shader_atomic_counter_ops` | unclassified | - | - | - | - |
| `GL_ARB_shader_atomic_counters` | unclassified | - | - | - | - |
| `GL_ARB_shader_ballot` | unclassified | - | - | - | - |
| `GL_ARB_shader_bit_encoding` | unclassified | - | - | - | - |
| `GL_ARB_shader_clock` | unclassified | - | - | - | - |
| `GL_ARB_shader_draw_parameters` | unclassified | - | - | - | - |
| `GL_ARB_shader_group_vote` | unclassified | - | - | - | - |
| `GL_ARB_shader_image_load_store` | unclassified | - | - | - | - |
| `GL_ARB_shader_image_size` | unclassified | - | - | - | - |
| `GL_ARB_shader_objects` | unclassified | - | - | - | - |
| `GL_ARB_shader_precision` | unclassified | - | - | - | - |
| `GL_ARB_shader_stencil_export` | unclassified | - | - | - | - |
| `GL_ARB_shader_storage_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_shader_subroutine` | unclassified | - | - | - | - |
| `GL_ARB_shader_texture_image_samples` | unclassified | - | - | - | - |
| `GL_ARB_shader_texture_lod` | unclassified | - | - | - | - |
| `GL_ARB_shader_viewport_layer_array` | unclassified | - | - | - | - |
| `GL_ARB_shading_language_100` | unclassified | - | - | - | - |
| `GL_ARB_shading_language_420pack` | unclassified | - | - | - | - |
| `GL_ARB_shading_language_include` | unclassified | - | - | - | - |
| `GL_ARB_shading_language_packing` | unclassified | - | - | - | - |
| `GL_ARB_shadow` | unclassified | - | - | - | - |
| `GL_ARB_shadow_ambient` | unclassified | - | - | - | - |
| `GL_ARB_sparse_buffer` | unclassified | - | - | - | - |
| `GL_ARB_sparse_texture` | unclassified | - | - | - | - |
| `GL_ARB_sparse_texture2` | unclassified | - | - | - | - |
| `GL_ARB_sparse_texture_clamp` | unclassified | - | - | - | - |
| `GL_ARB_spirv_extensions` | unclassified | - | - | - | - |
| `GL_ARB_stencil_texturing` | unclassified | - | - | - | - |
| `GL_ARB_sync` | unclassified | - | - | - | - |
| `GL_ARB_tessellation_shader` | unclassified | - | - | - | - |
| `GL_ARB_texture_barrier` | unclassified | - | - | - | - |
| `GL_ARB_texture_border_clamp` | unclassified | - | - | - | - |
| `GL_ARB_texture_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_texture_buffer_object_rgb32` | unclassified | - | - | - | - |
| `GL_ARB_texture_buffer_range` | unclassified | - | - | - | - |
| `GL_ARB_texture_compression` | unclassified | - | - | - | - |
| `GL_ARB_texture_compression_bptc` | unclassified | - | - | - | - |
| `GL_ARB_texture_compression_rgtc` | unclassified | - | - | - | - |
| `GL_ARB_texture_cube_map` | unclassified | - | - | - | - |
| `GL_ARB_texture_cube_map_array` | unclassified | - | - | - | - |
| `GL_ARB_texture_env_add` | unclassified | - | - | - | - |
| `GL_ARB_texture_env_combine` | unclassified | - | - | - | - |
| `GL_ARB_texture_env_crossbar` | unclassified | - | - | - | - |
| `GL_ARB_texture_env_dot3` | unclassified | - | - | - | - |
| `GL_ARB_texture_filter_anisotropic` | unclassified | - | - | - | - |
| `GL_ARB_texture_filter_minmax` | unclassified | - | - | - | - |
| `GL_ARB_texture_float` | unclassified | - | - | - | - |
| `GL_ARB_texture_gather` | unclassified | - | - | - | - |
| `GL_ARB_texture_mirror_clamp_to_edge` | unclassified | - | - | - | - |
| `GL_ARB_texture_mirrored_repeat` | unclassified | - | - | - | - |
| `GL_ARB_texture_multisample` | unclassified | - | - | - | - |
| `GL_ARB_texture_non_power_of_two` | unclassified | - | - | - | - |
| `GL_ARB_texture_query_levels` | unclassified | - | - | - | - |
| `GL_ARB_texture_query_lod` | unclassified | - | - | - | - |
| `GL_ARB_texture_rectangle` | unclassified | - | - | - | - |
| `GL_ARB_texture_rg` | unclassified | - | - | - | - |
| `GL_ARB_texture_rgb10_a2ui` | unclassified | - | - | - | - |
| `GL_ARB_texture_stencil8` | unclassified | - | - | - | - |
| `GL_ARB_texture_storage` | unclassified | - | - | - | - |
| `GL_ARB_texture_storage_multisample` | unclassified | - | - | - | - |
| `GL_ARB_texture_swizzle` | unclassified | - | - | - | - |
| `GL_ARB_texture_view` | unclassified | - | - | - | - |
| `GL_ARB_timer_query` | unclassified | - | - | - | - |
| `GL_ARB_transform_feedback2` | unclassified | - | - | - | - |
| `GL_ARB_transform_feedback3` | unclassified | - | - | - | - |
| `GL_ARB_transform_feedback_instanced` | unclassified | - | - | - | - |
| `GL_ARB_transform_feedback_overflow_query` | unclassified | - | - | - | - |
| `GL_ARB_transpose_matrix` | unclassified | - | - | - | - |
| `GL_ARB_uniform_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_vertex_array_bgra` | unclassified | - | - | - | - |
| `GL_ARB_vertex_array_object` | unclassified | - | - | - | - |
| `GL_ARB_vertex_attrib_64bit` | unclassified | - | - | - | - |
| `GL_ARB_vertex_attrib_binding` | unclassified | - | - | - | - |
| `GL_ARB_vertex_blend` | unclassified | - | - | - | - |
| `GL_ARB_vertex_buffer_object` | unclassified | - | - | - | - |
| `GL_ARB_vertex_program` | unclassified | - | - | - | - |
| `GL_ARB_vertex_shader` | unclassified | - | - | - | - |
| `GL_ARB_vertex_type_10f_11f_11f_rev` | unclassified | - | - | - | - |
| `GL_ARB_vertex_type_2_10_10_10_rev` | unclassified | - | - | - | - |
| `GL_ARB_viewport_array` | unclassified | - | - | - | - |
| `GL_ARB_window_pos` | unclassified | - | - | - | - |
| `GL_ATI_draw_buffers` | unclassified | - | - | - | - |
| `GL_ATI_element_array` | unclassified | - | - | - | - |
| `GL_ATI_envmap_bumpmap` | unclassified | - | - | - | - |
| `GL_ATI_fragment_shader` | unclassified | - | - | - | - |
| `GL_ATI_map_object_buffer` | unclassified | - | - | - | - |
| `GL_ATI_meminfo` | unclassified | - | - | - | - |
| `GL_ATI_pixel_format_float` | unclassified | - | - | - | - |
| `GL_ATI_pn_triangles` | unclassified | - | - | - | - |
| `GL_ATI_separate_stencil` | unclassified | - | - | - | - |
| `GL_ATI_text_fragment_shader` | unclassified | - | - | - | - |
| `GL_ATI_texture_env_combine3` | unclassified | - | - | - | - |
| `GL_ATI_texture_float` | unclassified | - | - | - | - |
| `GL_ATI_texture_mirror_once` | unclassified | - | - | - | - |
| `GL_ATI_vertex_array_object` | unclassified | - | - | - | - |
| `GL_ATI_vertex_attrib_array_object` | unclassified | - | - | - | - |
| `GL_ATI_vertex_streams` | unclassified | - | - | - | - |
| `GL_EXT_422_pixels` | unclassified | - | - | - | - |
| `GL_EXT_EGL_image_storage` | unclassified | - | - | - | - |
| `GL_EXT_EGL_sync` | unclassified | - | - | - | - |
| `GL_EXT_abgr` | unclassified | - | - | - | - |
| `GL_EXT_bgra` | unclassified | - | - | - | - |
| `GL_EXT_bindable_uniform` | unclassified | - | - | - | - |
| `GL_EXT_blend_color` | unclassified | - | - | - | - |
| `GL_EXT_blend_equation_separate` | unclassified | - | - | - | - |
| `GL_EXT_blend_func_separate` | unclassified | - | - | - | - |
| `GL_EXT_blend_logic_op` | unclassified | - | - | - | - |
| `GL_EXT_blend_minmax` | unclassified | - | - | - | - |
| `GL_EXT_blend_subtract` | unclassified | - | - | - | - |
| `GL_EXT_clip_volume_hint` | unclassified | - | - | - | - |
| `GL_EXT_cmyka` | unclassified | - | - | - | - |
| `GL_EXT_color_subtable` | unclassified | - | - | - | - |
| `GL_EXT_compiled_vertex_array` | unclassified | - | - | - | - |
| `GL_EXT_convolution` | unclassified | - | - | - | - |
| `GL_EXT_coordinate_frame` | unclassified | - | - | - | - |
| `GL_EXT_copy_texture` | unclassified | - | - | - | - |
| `GL_EXT_cull_vertex` | unclassified | - | - | - | - |
| `GL_EXT_debug_label` | unclassified | - | - | - | - |
| `GL_EXT_debug_marker` | unclassified | - | - | - | - |
| `GL_EXT_depth_bounds_test` | unclassified | - | - | - | - |
| `GL_EXT_direct_state_access` | unclassified | - | - | - | - |
| `GL_EXT_draw_buffers2` | unclassified | - | - | - | - |
| `GL_EXT_draw_instanced` | unclassified | - | - | - | - |
| `GL_EXT_draw_range_elements` | unclassified | - | - | - | - |
| `GL_EXT_external_buffer` | unclassified | - | - | - | - |
| `GL_EXT_fog_coord` | unclassified | - | - | - | - |
| `GL_EXT_fragment_shading_rate` | unclassified | - | - | - | - |
| `GL_EXT_framebuffer_blit` | unclassified | - | - | - | - |
| `GL_EXT_framebuffer_blit_layers` | unclassified | - | - | - | - |
| `GL_EXT_framebuffer_multisample` | unclassified | - | - | - | - |
| `GL_EXT_framebuffer_multisample_blit_scaled` | unclassified | - | - | - | - |
| `GL_EXT_framebuffer_object` | unclassified | - | - | - | - |
| `GL_EXT_framebuffer_sRGB` | unclassified | - | - | - | - |
| `GL_EXT_geometry_shader4` | unclassified | - | - | - | - |
| `GL_EXT_gpu_program_parameters` | unclassified | - | - | - | - |
| `GL_EXT_gpu_shader4` | unclassified | - | - | - | - |
| `GL_EXT_histogram` | unclassified | - | - | - | - |
| `GL_EXT_index_array_formats` | unclassified | - | - | - | - |
| `GL_EXT_index_func` | unclassified | - | - | - | - |
| `GL_EXT_index_material` | unclassified | - | - | - | - |
| `GL_EXT_index_texture` | unclassified | - | - | - | - |
| `GL_EXT_light_texture` | unclassified | - | - | - | - |
| `GL_EXT_memory_object` | unclassified | - | - | - | - |
| `GL_EXT_memory_object_fd` | unclassified | - | - | - | - |
| `GL_EXT_memory_object_win32` | unclassified | - | - | - | - |
| `GL_EXT_mesh_shader` | unclassified | - | - | - | - |
| `GL_EXT_misc_attribute` | unclassified | - | - | - | - |
| `GL_EXT_multi_draw_arrays` | unclassified | - | - | - | - |
| `GL_EXT_multisample` | unclassified | - | - | - | - |
| `GL_EXT_multiview_tessellation_geometry_shader` | unclassified | - | - | - | - |
| `GL_EXT_multiview_texture_multisample` | unclassified | - | - | - | - |
| `GL_EXT_multiview_timer_query` | unclassified | - | - | - | - |
| `GL_EXT_packed_depth_stencil` | unclassified | - | - | - | - |
| `GL_EXT_packed_float` | unclassified | - | - | - | - |
| `GL_EXT_packed_pixels` | unclassified | - | - | - | - |
| `GL_EXT_paletted_texture` | unclassified | - | - | - | - |
| `GL_EXT_pixel_buffer_object` | unclassified | - | - | - | - |
| `GL_EXT_pixel_transform` | unclassified | - | - | - | - |
| `GL_EXT_pixel_transform_color_table` | unclassified | - | - | - | - |
| `GL_EXT_point_parameters` | unclassified | - | - | - | - |
| `GL_EXT_polygon_offset` | unclassified | - | - | - | - |
| `GL_EXT_polygon_offset_clamp` | unclassified | - | - | - | - |
| `GL_EXT_post_depth_coverage` | unclassified | - | - | - | - |
| `GL_EXT_provoking_vertex` | unclassified | - | - | - | - |
| `GL_EXT_raster_multisample` | unclassified | - | - | - | - |
| `GL_EXT_rescale_normal` | unclassified | - | - | - | - |
| `GL_EXT_secondary_color` | unclassified | - | - | - | - |
| `GL_EXT_semaphore` | unclassified | - | - | - | - |
| `GL_EXT_semaphore_fd` | unclassified | - | - | - | - |
| `GL_EXT_semaphore_win32` | unclassified | - | - | - | - |
| `GL_EXT_separate_shader_objects` | unclassified | - | - | - | - |
| `GL_EXT_separate_specular_color` | unclassified | - | - | - | - |
| `GL_EXT_shader_framebuffer_fetch` | unclassified | - | - | - | - |
| `GL_EXT_shader_framebuffer_fetch_non_coherent` | unclassified | - | - | - | - |
| `GL_EXT_shader_image_load_formatted` | unclassified | - | - | - | - |
| `GL_EXT_shader_image_load_store` | unclassified | - | - | - | - |
| `GL_EXT_shader_integer_mix` | unclassified | - | - | - | - |
| `GL_EXT_shader_samples_identical` | unclassified | - | - | - | - |
| `GL_EXT_shadow_funcs` | unclassified | - | - | - | - |
| `GL_EXT_shared_texture_palette` | unclassified | - | - | - | - |
| `GL_EXT_sparse_texture2` | unclassified | - | - | - | - |
| `GL_EXT_stencil_clear_tag` | unclassified | - | - | - | - |
| `GL_EXT_stencil_two_side` | unclassified | - | - | - | - |
| `GL_EXT_stencil_wrap` | unclassified | - | - | - | - |
| `GL_EXT_subtexture` | unclassified | - | - | - | - |
| `GL_EXT_texture` | unclassified | - | - | - | - |
| `GL_EXT_texture3D` | unclassified | - | - | - | - |
| `GL_EXT_texture_array` | unclassified | - | - | - | - |
| `GL_EXT_texture_buffer_object` | unclassified | - | - | - | - |
| `GL_EXT_texture_compression_latc` | unclassified | - | - | - | - |
| `GL_EXT_texture_compression_rgtc` | unclassified | - | - | - | - |
| `GL_EXT_texture_compression_s3tc` | unclassified | - | - | - | - |
| `GL_EXT_texture_cube_map` | unclassified | - | - | - | - |
| `GL_EXT_texture_env_add` | unclassified | - | - | - | - |
| `GL_EXT_texture_env_combine` | unclassified | - | - | - | - |
| `GL_EXT_texture_env_dot3` | unclassified | - | - | - | - |
| `GL_EXT_texture_filter_anisotropic` | unclassified | - | - | - | - |
| `GL_EXT_texture_filter_minmax` | unclassified | - | - | - | - |
| `GL_EXT_texture_integer` | unclassified | - | - | - | - |
| `GL_EXT_texture_lod_bias` | unclassified | - | - | - | - |
| `GL_EXT_texture_mirror_clamp` | unclassified | - | - | - | - |
| `GL_EXT_texture_object` | unclassified | - | - | - | - |
| `GL_EXT_texture_perturb_normal` | unclassified | - | - | - | - |
| `GL_EXT_texture_sRGB` | unclassified | - | - | - | - |
| `GL_EXT_texture_sRGB_R8` | unclassified | - | - | - | - |
| `GL_EXT_texture_sRGB_RG8` | unclassified | - | - | - | - |
| `GL_EXT_texture_sRGB_decode` | unclassified | - | - | - | - |
| `GL_EXT_texture_shadow_lod` | unclassified | - | - | - | - |
| `GL_EXT_texture_shared_exponent` | unclassified | - | - | - | - |
| `GL_EXT_texture_snorm` | unclassified | - | - | - | - |
| `GL_EXT_texture_storage` | unclassified | - | - | - | - |
| `GL_EXT_texture_swizzle` | unclassified | - | - | - | - |
| `GL_EXT_timer_query` | unclassified | - | - | - | - |
| `GL_EXT_transform_feedback` | unclassified | - | - | - | - |
| `GL_EXT_vertex_array` | unclassified | - | - | - | - |
| `GL_EXT_vertex_array_bgra` | unclassified | - | - | - | - |
| `GL_EXT_vertex_attrib_64bit` | unclassified | - | - | - | - |
| `GL_EXT_vertex_shader` | unclassified | - | - | - | - |
| `GL_EXT_vertex_weighting` | unclassified | - | - | - | - |
| `GL_EXT_win32_keyed_mutex` | unclassified | - | - | - | - |
| `GL_EXT_window_rectangles` | unclassified | - | - | - | - |
| `GL_EXT_x11_sync_object` | unclassified | - | - | - | - |
| `GL_GREMEDY_frame_terminator` | unclassified | - | - | - | - |
| `GL_GREMEDY_string_marker` | unclassified | - | - | - | - |
| `GL_HP_convolution_border_modes` | unclassified | - | - | - | - |
| `GL_HP_image_transform` | unclassified | - | - | - | - |
| `GL_HP_occlusion_test` | unclassified | - | - | - | - |
| `GL_HP_texture_lighting` | unclassified | - | - | - | - |
| `GL_IBM_cull_vertex` | unclassified | - | - | - | - |
| `GL_IBM_multimode_draw_arrays` | unclassified | - | - | - | - |
| `GL_IBM_rasterpos_clip` | unclassified | - | - | - | - |
| `GL_IBM_static_data` | unclassified | - | - | - | - |
| `GL_IBM_texture_mirrored_repeat` | unclassified | - | - | - | - |
| `GL_IBM_vertex_array_lists` | unclassified | - | - | - | - |
| `GL_INGR_blend_func_separate` | unclassified | - | - | - | - |
| `GL_INGR_color_clamp` | unclassified | - | - | - | - |
| `GL_INGR_interlace_read` | unclassified | - | - | - | - |
| `GL_INTEL_blackhole_render` | unclassified | - | - | - | - |
| `GL_INTEL_conservative_rasterization` | unclassified | - | - | - | - |
| `GL_INTEL_fragment_shader_ordering` | unclassified | - | - | - | - |
| `GL_INTEL_framebuffer_CMAA` | unclassified | - | - | - | - |
| `GL_INTEL_map_texture` | unclassified | - | - | - | - |
| `GL_INTEL_parallel_arrays` | unclassified | - | - | - | - |
| `GL_INTEL_performance_query` | unclassified | - | - | - | - |
| `GL_KHR_blend_equation_advanced` | unclassified | - | - | - | - |
| `GL_KHR_blend_equation_advanced_coherent` | unclassified | - | - | - | - |
| `GL_KHR_context_flush_control` | unclassified | - | - | - | - |
| `GL_KHR_debug` | unclassified | - | - | - | - |
| `GL_KHR_no_error` | unclassified | - | - | - | - |
| `GL_KHR_parallel_shader_compile` | unclassified | - | - | - | - |
| `GL_KHR_robust_buffer_access_behavior` | unclassified | - | - | - | - |
| `GL_KHR_robustness` | unclassified | - | - | - | - |
| `GL_KHR_shader_subgroup` | unclassified | - | - | - | - |
| `GL_KHR_texture_compression_astc_hdr` | unclassified | - | - | - | - |
| `GL_KHR_texture_compression_astc_ldr` | unclassified | - | - | - | - |
| `GL_KHR_texture_compression_astc_sliced_3d` | unclassified | - | - | - | - |
| `GL_MESAX_texture_stack` | unclassified | - | - | - | - |
| `GL_MESA_framebuffer_flip_x` | unclassified | - | - | - | - |
| `GL_MESA_framebuffer_flip_y` | unclassified | - | - | - | - |
| `GL_MESA_framebuffer_swap_xy` | unclassified | - | - | - | - |
| `GL_MESA_map_buffer_client_pointer` | unclassified | - | - | - | - |
| `GL_MESA_pack_invert` | unclassified | - | - | - | - |
| `GL_MESA_program_binary_formats` | unclassified | - | - | - | - |
| `GL_MESA_resize_buffers` | unclassified | - | - | - | - |
| `GL_MESA_shader_integer_functions` | unclassified | - | - | - | - |
| `GL_MESA_texture_const_bandwidth` | unclassified | - | - | - | - |
| `GL_MESA_tile_raster_order` | unclassified | - | - | - | - |
| `GL_MESA_window_pos` | unclassified | - | - | - | - |
| `GL_MESA_ycbcr_texture` | unclassified | - | - | - | - |
| `GL_NVX_blend_equation_advanced_multi_draw_buffers` | unclassified | - | - | - | - |
| `GL_NVX_conditional_render` | unclassified | - | - | - | - |
| `GL_NVX_gpu_memory_info` | unclassified | - | - | - | - |
| `GL_NVX_gpu_multicast2` | unclassified | - | - | - | - |
| `GL_NVX_linked_gpu_multicast` | unclassified | - | - | - | - |
| `GL_NVX_progress_fence` | unclassified | - | - | - | - |
| `GL_NV_alpha_to_coverage_dither_control` | unclassified | - | - | - | - |
| `GL_NV_bindless_multi_draw_indirect` | unclassified | - | - | - | - |
| `GL_NV_bindless_multi_draw_indirect_count` | unclassified | - | - | - | - |
| `GL_NV_bindless_texture` | unclassified | - | - | - | - |
| `GL_NV_blend_equation_advanced` | unclassified | - | - | - | - |
| `GL_NV_blend_equation_advanced_coherent` | unclassified | - | - | - | - |
| `GL_NV_blend_minmax_factor` | unclassified | - | - | - | - |
| `GL_NV_blend_square` | unclassified | - | - | - | - |
| `GL_NV_clip_space_w_scaling` | unclassified | - | - | - | - |
| `GL_NV_command_list` | unclassified | - | - | - | - |
| `GL_NV_compute_program5` | unclassified | - | - | - | - |
| `GL_NV_compute_shader_derivatives` | unclassified | - | - | - | - |
| `GL_NV_conditional_render` | unclassified | - | - | - | - |
| `GL_NV_conservative_raster` | unclassified | - | - | - | - |
| `GL_NV_conservative_raster_dilate` | unclassified | - | - | - | - |
| `GL_NV_conservative_raster_pre_snap` | unclassified | - | - | - | - |
| `GL_NV_conservative_raster_pre_snap_triangles` | unclassified | - | - | - | - |
| `GL_NV_conservative_raster_underestimation` | unclassified | - | - | - | - |
| `GL_NV_copy_depth_to_color` | unclassified | - | - | - | - |
| `GL_NV_copy_image` | unclassified | - | - | - | - |
| `GL_NV_deep_texture3D` | unclassified | - | - | - | - |
| `GL_NV_depth_buffer_float` | unclassified | - | - | - | - |
| `GL_NV_depth_clamp` | unclassified | - | - | - | - |
| `GL_NV_draw_texture` | unclassified | - | - | - | - |
| `GL_NV_draw_vulkan_image` | unclassified | - | - | - | - |
| `GL_NV_evaluators` | unclassified | - | - | - | - |
| `GL_NV_explicit_multisample` | unclassified | - | - | - | - |
| `GL_NV_fence` | unclassified | - | - | - | - |
| `GL_NV_fill_rectangle` | unclassified | - | - | - | - |
| `GL_NV_float_buffer` | unclassified | - | - | - | - |
| `GL_NV_fog_distance` | unclassified | - | - | - | - |
| `GL_NV_fragment_coverage_to_color` | unclassified | - | - | - | - |
| `GL_NV_fragment_program` | unclassified | - | - | - | - |
| `GL_NV_fragment_program2` | unclassified | - | - | - | - |
| `GL_NV_fragment_program4` | unclassified | - | - | - | - |
| `GL_NV_fragment_program_option` | unclassified | - | - | - | - |
| `GL_NV_fragment_shader_barycentric` | unclassified | - | - | - | - |
| `GL_NV_fragment_shader_interlock` | unclassified | - | - | - | - |
| `GL_NV_framebuffer_mixed_samples` | unclassified | - | - | - | - |
| `GL_NV_framebuffer_multisample_coverage` | unclassified | - | - | - | - |
| `GL_NV_geometry_program4` | unclassified | - | - | - | - |
| `GL_NV_geometry_shader4` | unclassified | - | - | - | - |
| `GL_NV_geometry_shader_passthrough` | unclassified | - | - | - | - |
| `GL_NV_gpu_multicast` | unclassified | - | - | - | - |
| `GL_NV_gpu_program4` | unclassified | - | - | - | - |
| `GL_NV_gpu_program5` | unclassified | - | - | - | - |
| `GL_NV_gpu_program5_mem_extended` | unclassified | - | - | - | - |
| `GL_NV_gpu_shader5` | unclassified | - | - | - | - |
| `GL_NV_half_float` | unclassified | - | - | - | - |
| `GL_NV_internalformat_sample_query` | unclassified | - | - | - | - |
| `GL_NV_light_max_exponent` | unclassified | - | - | - | - |
| `GL_NV_memory_attachment` | unclassified | - | - | - | - |
| `GL_NV_memory_object_sparse` | unclassified | - | - | - | - |
| `GL_NV_mesh_shader` | unclassified | - | - | - | - |
| `GL_NV_multisample_coverage` | unclassified | - | - | - | - |
| `GL_NV_multisample_filter_hint` | unclassified | - | - | - | - |
| `GL_NV_occlusion_query` | unclassified | - | - | - | - |
| `GL_NV_packed_depth_stencil` | unclassified | - | - | - | - |
| `GL_NV_parameter_buffer_object` | unclassified | - | - | - | - |
| `GL_NV_parameter_buffer_object2` | unclassified | - | - | - | - |
| `GL_NV_path_rendering` | unclassified | - | - | - | - |
| `GL_NV_path_rendering_shared_edge` | unclassified | - | - | - | - |
| `GL_NV_pixel_data_range` | unclassified | - | - | - | - |
| `GL_NV_point_sprite` | unclassified | - | - | - | - |
| `GL_NV_present_video` | unclassified | - | - | - | - |
| `GL_NV_primitive_restart` | unclassified | - | - | - | - |
| `GL_NV_primitive_shading_rate` | unclassified | - | - | - | - |
| `GL_NV_query_resource` | unclassified | - | - | - | - |
| `GL_NV_query_resource_tag` | unclassified | - | - | - | - |
| `GL_NV_register_combiners` | unclassified | - | - | - | - |
| `GL_NV_register_combiners2` | unclassified | - | - | - | - |
| `GL_NV_representative_fragment_test` | unclassified | - | - | - | - |
| `GL_NV_robustness_video_memory_purge` | unclassified | - | - | - | - |
| `GL_NV_sample_locations` | unclassified | - | - | - | - |
| `GL_NV_sample_mask_override_coverage` | unclassified | - | - | - | - |
| `GL_NV_scissor_exclusive` | unclassified | - | - | - | - |
| `GL_NV_shader_atomic_counters` | unclassified | - | - | - | - |
| `GL_NV_shader_atomic_float` | unclassified | - | - | - | - |
| `GL_NV_shader_atomic_float64` | unclassified | - | - | - | - |
| `GL_NV_shader_atomic_fp16_vector` | unclassified | - | - | - | - |
| `GL_NV_shader_atomic_int64` | unclassified | - | - | - | - |
| `GL_NV_shader_buffer_load` | unclassified | - | - | - | - |
| `GL_NV_shader_buffer_store` | unclassified | - | - | - | - |
| `GL_NV_shader_storage_buffer_object` | unclassified | - | - | - | - |
| `GL_NV_shader_subgroup_partitioned` | unclassified | - | - | - | - |
| `GL_NV_shader_texture_footprint` | unclassified | - | - | - | - |
| `GL_NV_shader_thread_group` | unclassified | - | - | - | - |
| `GL_NV_shader_thread_shuffle` | unclassified | - | - | - | - |
| `GL_NV_shading_rate_image` | unclassified | - | - | - | - |
| `GL_NV_stereo_view_rendering` | unclassified | - | - | - | - |
| `GL_NV_tessellation_program5` | unclassified | - | - | - | - |
| `GL_NV_texgen_emboss` | unclassified | - | - | - | - |
| `GL_NV_texgen_reflection` | unclassified | - | - | - | - |
| `GL_NV_texture_barrier` | unclassified | - | - | - | - |
| `GL_NV_texture_compression_vtc` | unclassified | - | - | - | - |
| `GL_NV_texture_env_combine4` | unclassified | - | - | - | - |
| `GL_NV_texture_expand_normal` | unclassified | - | - | - | - |
| `GL_NV_texture_multisample` | unclassified | - | - | - | - |
| `GL_NV_texture_rectangle` | unclassified | - | - | - | - |
| `GL_NV_texture_rectangle_compressed` | unclassified | - | - | - | - |
| `GL_NV_texture_shader` | unclassified | - | - | - | - |
| `GL_NV_texture_shader2` | unclassified | - | - | - | - |
| `GL_NV_texture_shader3` | unclassified | - | - | - | - |
| `GL_NV_timeline_semaphore` | unclassified | - | - | - | - |
| `GL_NV_transform_feedback` | unclassified | - | - | - | - |
| `GL_NV_transform_feedback2` | unclassified | - | - | - | - |
| `GL_NV_uniform_buffer_std430_layout` | unclassified | - | - | - | - |
| `GL_NV_uniform_buffer_unified_memory` | unclassified | - | - | - | - |
| `GL_NV_vdpau_interop` | unclassified | - | - | - | - |
| `GL_NV_vdpau_interop2` | unclassified | - | - | - | - |
| `GL_NV_vertex_array_range` | unclassified | - | - | - | - |
| `GL_NV_vertex_array_range2` | unclassified | - | - | - | - |
| `GL_NV_vertex_attrib_integer_64bit` | unclassified | - | - | - | - |
| `GL_NV_vertex_buffer_unified_memory` | unclassified | - | - | - | - |
| `GL_NV_vertex_program` | unclassified | - | - | - | - |
| `GL_NV_vertex_program1_1` | unclassified | - | - | - | - |
| `GL_NV_vertex_program2` | unclassified | - | - | - | - |
| `GL_NV_vertex_program2_option` | unclassified | - | - | - | - |
| `GL_NV_vertex_program3` | unclassified | - | - | - | - |
| `GL_NV_vertex_program4` | unclassified | - | - | - | - |
| `GL_NV_video_capture` | unclassified | - | - | - | - |
| `GL_NV_viewport_array2` | unclassified | - | - | - | - |
| `GL_NV_viewport_swizzle` | unclassified | - | - | - | - |
| `GL_OES_byte_coordinates` | unclassified | - | - | - | - |
| `GL_OES_compressed_paletted_texture` | unclassified | - | - | - | - |
| `GL_OES_fixed_point` | unclassified | - | - | - | - |
| `GL_OES_query_matrix` | unclassified | - | - | - | - |
| `GL_OES_read_format` | unclassified | - | - | - | - |
| `GL_OES_single_precision` | unclassified | - | - | - | - |
| `GL_OML_interlace` | unclassified | - | - | - | - |
| `GL_OML_resample` | unclassified | - | - | - | - |
| `GL_OML_subsample` | unclassified | - | - | - | - |
| `GL_OVR_multiview` | unclassified | - | - | - | - |
| `GL_OVR_multiview2` | unclassified | - | - | - | - |
| `GL_PGI_misc_hints` | unclassified | - | - | - | - |
| `GL_PGI_vertex_hints` | unclassified | - | - | - | - |
| `GL_REND_screen_coordinates` | unclassified | - | - | - | - |
| `GL_S3_s3tc` | unclassified | - | - | - | - |
| `GL_SGIS_detail_texture` | unclassified | - | - | - | - |
| `GL_SGIS_fog_function` | unclassified | - | - | - | - |
| `GL_SGIS_generate_mipmap` | unclassified | - | - | - | - |
| `GL_SGIS_multisample` | unclassified | - | - | - | - |
| `GL_SGIS_pixel_texture` | unclassified | - | - | - | - |
| `GL_SGIS_point_line_texgen` | unclassified | - | - | - | - |
| `GL_SGIS_point_parameters` | unclassified | - | - | - | - |
| `GL_SGIS_sharpen_texture` | unclassified | - | - | - | - |
| `GL_SGIS_texture4D` | unclassified | - | - | - | - |
| `GL_SGIS_texture_border_clamp` | unclassified | - | - | - | - |
| `GL_SGIS_texture_color_mask` | unclassified | - | - | - | - |
| `GL_SGIS_texture_edge_clamp` | unclassified | - | - | - | - |
| `GL_SGIS_texture_filter4` | unclassified | - | - | - | - |
| `GL_SGIS_texture_lod` | unclassified | - | - | - | - |
| `GL_SGIS_texture_select` | unclassified | - | - | - | - |
| `GL_SGIX_async` | unclassified | - | - | - | - |
| `GL_SGIX_async_histogram` | unclassified | - | - | - | - |
| `GL_SGIX_async_pixel` | unclassified | - | - | - | - |
| `GL_SGIX_blend_alpha_minmax` | unclassified | - | - | - | - |
| `GL_SGIX_calligraphic_fragment` | unclassified | - | - | - | - |
| `GL_SGIX_clipmap` | unclassified | - | - | - | - |
| `GL_SGIX_convolution_accuracy` | unclassified | - | - | - | - |
| `GL_SGIX_depth_pass_instrument` | unclassified | - | - | - | - |
| `GL_SGIX_depth_texture` | unclassified | - | - | - | - |
| `GL_SGIX_flush_raster` | unclassified | - | - | - | - |
| `GL_SGIX_fog_offset` | unclassified | - | - | - | - |
| `GL_SGIX_fragment_lighting` | unclassified | - | - | - | - |
| `GL_SGIX_framezoom` | unclassified | - | - | - | - |
| `GL_SGIX_igloo_interface` | unclassified | - | - | - | - |
| `GL_SGIX_instruments` | unclassified | - | - | - | - |
| `GL_SGIX_interlace` | unclassified | - | - | - | - |
| `GL_SGIX_ir_instrument1` | unclassified | - | - | - | - |
| `GL_SGIX_list_priority` | unclassified | - | - | - | - |
| `GL_SGIX_pixel_texture` | unclassified | - | - | - | - |
| `GL_SGIX_pixel_tiles` | unclassified | - | - | - | - |
| `GL_SGIX_polynomial_ffd` | unclassified | - | - | - | - |
| `GL_SGIX_reference_plane` | unclassified | - | - | - | - |
| `GL_SGIX_resample` | unclassified | - | - | - | - |
| `GL_SGIX_scalebias_hint` | unclassified | - | - | - | - |
| `GL_SGIX_shadow` | unclassified | - | - | - | - |
| `GL_SGIX_shadow_ambient` | unclassified | - | - | - | - |
| `GL_SGIX_sprite` | unclassified | - | - | - | - |
| `GL_SGIX_subsample` | unclassified | - | - | - | - |
| `GL_SGIX_tag_sample_buffer` | unclassified | - | - | - | - |
| `GL_SGIX_texture_add_env` | unclassified | - | - | - | - |
| `GL_SGIX_texture_coordinate_clamp` | unclassified | - | - | - | - |
| `GL_SGIX_texture_lod_bias` | unclassified | - | - | - | - |
| `GL_SGIX_texture_multi_buffer` | unclassified | - | - | - | - |
| `GL_SGIX_texture_scale_bias` | unclassified | - | - | - | - |
| `GL_SGIX_vertex_preclip` | unclassified | - | - | - | - |
| `GL_SGIX_ycrcb` | unclassified | - | - | - | - |
| `GL_SGIX_ycrcb_subsample` | unclassified | - | - | - | - |
| `GL_SGIX_ycrcba` | unclassified | - | - | - | - |
| `GL_SGI_color_matrix` | unclassified | - | - | - | - |
| `GL_SGI_color_table` | unclassified | - | - | - | - |
| `GL_SGI_texture_color_table` | unclassified | - | - | - | - |
| `GL_SUNX_constant_data` | unclassified | - | - | - | - |
| `GL_SUN_convolution_border_modes` | unclassified | - | - | - | - |
| `GL_SUN_global_alpha` | unclassified | - | - | - | - |
| `GL_SUN_mesh_array` | unclassified | - | - | - | - |
| `GL_SUN_slice_accum` | unclassified | - | - | - | - |
| `GL_SUN_triangle_list` | unclassified | - | - | - | - |
| `GL_SUN_vertex` | unclassified | - | - | - | - |
| `GL_WIN_phong_shading` | unclassified | - | - | - | - |
| `GL_WIN_specular_fog` | unclassified | - | - | - | - |
