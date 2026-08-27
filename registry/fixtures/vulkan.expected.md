# Vulkan registry inventory

- Revision: `fixture-revision`
- SHA-256: `fixture-sha256`
- Commands: 12
- Core features: 1
- Extensions: 2
- Constants: 8
- Types: 4
- Command parameters: 19
- Aggregates: 1
- Aggregate members: 4
- Classified commands: 1/12
- Classified core features: 1/1
- Classified extensions: 2/2

## Commands

| Name | Form | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- | --- |
| `vkAlias` | alias | unclassified | - | - | - | - |
| `vkAlpha` | definition | common | fixture loader | fixture ABI | fixture positive | fixture unsupported |
| `vkCreateFixture` | definition | unclassified | - | - | - | - |
| `vkDestroyFixture` | definition | unclassified | - | - | - | - |
| `vkInternal` | definition | unclassified | - | - | - | - |
| `vkPointerOnly` | definition | unclassified | - | - | - | - |
| `vkPointerScalar` | definition | unclassified | - | - | - | - |
| `vkPointerTwoScalar` | definition | unclassified | - | - | - | - |
| `vkQueryPointer` | definition | unclassified | - | - | - | - |
| `vkStatusHandle` | definition | unclassified | - | - | - | - |
| `vkStatusPointer` | definition | unclassified | - | - | - | - |
| `vkZulu` | definition | unclassified | - | - | - | - |

## Core features

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `VK_VERSION_1_0` | raw | fixture loader | fixture ABI | fixture positive | fixture unsupported |

## Extensions

| Name | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- |
| `VK_EXT_alpha` | unsupported | fixture loader | fixture ABI | fixture positive | fixture unsupported |
| `VK_EXT_zulu` | platform-inapplicable | fixture loader | fixture ABI | fixture positive | fixture unsupported |
