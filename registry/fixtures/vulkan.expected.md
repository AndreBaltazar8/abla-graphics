# Vulkan registry inventory

- Revision: `fixture-revision`
- SHA-256: `fixture-sha256`
- Commands: 4
- Core features: 1
- Extensions: 2
- Constants: 8
- Classified commands: 1/4
- Classified core features: 1/1
- Classified extensions: 2/2

## Commands

| Name | Form | Status | Loader | ABI | Positive test | Unsupported path |
| --- | --- | --- | --- | --- | --- | --- |
| `vkAlias` | alias | unclassified | - | - | - | - |
| `vkAlpha` | definition | common | fixture loader | fixture ABI | fixture positive | fixture unsupported |
| `vkInternal` | definition | unclassified | - | - | - | - |
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
