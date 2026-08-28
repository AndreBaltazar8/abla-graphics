# Vulkan registry inventory

- Revision: `fixture-revision`
- SHA-256: `fixture-sha256`
- Commands: 68
- Core features: 1
- Extensions: 2
- Constants: 8
- Types: 7
- Command parameters: 248
- Aggregates: 1
- Aggregate members: 4
- Classified commands: 1/68
- Classified core features: 1/1
- Classified extensions: 2/2

## Commands

| Name | Form | Core transitions | Extension providers | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `vkAddressResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkAlias` | alias | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkAlpha` | definition | VK_VERSION_1_0:+:all | VK_EXT_alpha:xlib:all | common | fixture loader | fixture ABI | fixture positive | fixture unsupported |
| `vkBindWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkBindWideResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkBufferImageWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkClearImageWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCopyWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCountedResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkCreateFixture` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDestroyFixture` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDeviceOnly` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDrawCountWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkDrawWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkEnumOutput` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkEnumerateFixture` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFillWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFloatState` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFloatState2` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFloatState3` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkFourPointers` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleEnumerateResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleFlags` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleFloatState` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleOutputResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandlePointerPair` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleScalarPointer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleTwoScalars` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkHandleWideFlags` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkImageFilteredWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkImageWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkInternal` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPhysicalStatusHandle` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerHandlePointer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerOnly` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerPair` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerScalar` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerTwoScalar` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkPointerWideResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkQueryPointer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkQueryTwoPointers` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkQueueLikeResult` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkQueueScalar` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkScalarFive` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkScalarFour` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkScalarOutput` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkScalarPointerPair` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkScalarSix` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkScalarThree` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusCalibrated` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusCreateDeferredPipelines` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusCreatePipelines` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusHandle` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusHandleScalarPointer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusPointer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusScalar` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusShaderGroup` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusWait` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkStatusWideScalar` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkThreeScalarOutput` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkTimestampWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkTwoHandlePointer` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkTwoWideScalar` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkTwoWideValues` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkUpdateWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkVoidWide` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |
| `vkZulu` | definition | VK_VERSION_1_0:+:all |  | unclassified | - | - | - | - |

## Core features

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `VK_VERSION_1_0` | raw | fixture loader | fixture ABI | fixture positive | fixture unsupported |

## Extensions

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `VK_EXT_alpha` | unsupported | fixture loader | fixture ABI | fixture positive | fixture unsupported |
| `VK_EXT_zulu` | platform-inapplicable | fixture loader | fixture ABI | fixture positive | fixture unsupported |
