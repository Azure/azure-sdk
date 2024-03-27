---
title: "Dependency addition checklist"
permalink: dependency_addition_checklist.html
folder: python
---

# Dependency addition checklist

When adding a dependency to a library, it's crucial to ensure that the dependency aligns with the library's goals, technical requirements, and legal constraints.
Approved dependencies can be found at https://github.com/Azure/azure-sdk/blob/main/docs/python/approved_dependencies.md

### Review checklist

- DO work with architects to review the intent of how you want to use it. e.g. sync/async, etc.
- DO work with LCA team to review the license compatibility. (aka.ms/cela -> Find my CELA contact)
  - MIT is the only one to auto-approve
- The library must have stable releases.
- The library must be pure Python or it provides wheels for all platforms and environments our SDK supports.
- The library must be in active development and be actively maintained (by more than a single contributor), with regular updates and patches, and a strong user following.
- NO dependency conflicts. Users must be able to use all our SDKs in the same environment. (We have some coverage in CI)
- DO understand the liability that you need to update your SDK in a timely manner if your SDK is broken due to a new release of the dependency.
- DO data protection check: if the dependency handles data, ensure it does so in a manner that complies with global and regional data protection laws applicable to your users.
- DO performance impact check: evaluate the library's performance impact on your project, considering factors like execution speed and memory consumption.
- DO recursive check: all the rules also apply to its sub-dependencies.
