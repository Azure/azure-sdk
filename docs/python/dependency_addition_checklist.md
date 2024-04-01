---
title: "Dependency addition checklist"
permalink: dependency_addition_checklist.html
folder: python
---

# Dependency addition checklist

When adding a dependency to a library, it's crucial to ensure that the dependency aligns with the library's goals, technical requirements, and legal constraints.

- You can directly use the library if it's on [approved dependencies list](https://github.com/Azure/azure-sdk/blob/main/docs/python/approved_dependencies.md).
- You can bypass the checklist for libraries on the [conditionally approved dependencies list](https://github.com/Azure/azure-sdk/blob/main/docs/python/conditionally_approved_dependencies.md), but ensure to consult with the architects about your intended use of the library.
- The aiohttp library does not require approval for HTTP usage; however, consult with the architects before using it for websocket purposes.
- If the library does not meet all of these requirements below, you could discuss with the architects about using an optional dependency to enable certain opt-in scenarios.

### Review checklist

- DO work with architects to review the intent of how you want to use it. e.g. sync/async, etc.
- DO work with LCA team to review the license compatibility (aka.ms/cela -> Find my CELA contact).
  - MIT is the only one to auto-approve
- The library must have stable releases and support the full band of supported Python versions.
- Both synchronous and asynchronous support are necessary. If the library supports only one type, a solution for the other must be identified.
- The library must be pure Python, or provide wheels for all platforms and environments our SDK supports.
- The library must be in active development and be actively maintained (by more than a single contributor), with regular updates and patches, and a strong user following.
- NO dependency conflicts. Users must be able to use all our SDKs in the same environment. (We have some coverage in CI)
- DO be aware of the responsibility that you need to promptly (within days, not months) update your SDK if it becomes incompatible due to a new version of the dependency.
- DO data protection check: if the dependency handles data, ensure it does so in a manner that complies with global and regional data protection laws applicable to your users.
- DO performance impact check: evaluate the library's performance impact on your project, considering factors like execution speed and memory consumption.
- DO recursive check: all the rules also apply to its sub-dependencies.
