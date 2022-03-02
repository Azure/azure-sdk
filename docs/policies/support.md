---
title: "Policies: Support"
permalink: policies_support.html
folder: policies
sidebar: general_sidebar
---

## **Azure SDK lifecycle and support policy**

Azure SDK Lifecycle and support are governed by the latest [Microsoft Modern Lifecycle Policy](https://docs.microsoft.com/en-US/lifecycle/policies/modern), which will prevail in case of any conflicts with the information below.

### **Package lifecycle**

Here are the stages of a typical package lifecycle (for major versions)

1. **Beta** – A new SDK that is available for early access and feedback purposes and is not recommended for use in production.
   The beta version support is limited to GitHub issues and response time is not guaranteed. Beta releases live typically for less than 1 year, after which they are either retired or released as stable.

2. **Active** - The SDKs are generally available and fully supported, will receive new feature updates, as well as bug and security fixes.
   The major version will remain active for at least 12 months from the release date. Compatible updates for the major release are provided through minor versions, or patch versions.
   Customers are encouraged to use the latest version as that is the version that will get fixes and updates.

3. **Maintenance** - Typically, maintenance mode is announced at the same time as the next major version is transitioned to Active,
   after which the releases will only address the most critical bug fixes and security fixes for at least another 12 months. 

4. **Retired** - A library no longer conforms to our most up-to-date [Azure SDK Guidelines](https://azure.github.io/azure-sdk/general_introduction.html), and is deprecated in favor of a newer library. Typically, support retirement is announced at the same time as the replacement library is transitioned to Active, after which the releases will only address the most critical bug fixes and security fixes for at least another 12 months. 

5. **Community** - SDK will no longer receive updates from Microsoft unless otherwise specified in the separate customer agreement.
   The package will remain available via public package managers and the GitHub repo, which can be maintained by the community.

You can check the lifecycle stage for your package at [this page](https://azure.github.io/azure-sdk/releases/latest/index.html)

### **Azure Clouds**

By default, the Azure libraries are configured to connect to the Global Azure Cloud.
Additional cloud target platforms are available, such as Azure Stack, Azure China and Government Cloud.
Package lifecycle may vary across different target platforms. Refer to the target platform documentation for more information.

### **Azure SDK dependencies**

The Azure SDK libraries depend on Azure Service REST API, programming language runtime, OS, and third-party libraries.

> The Azure SDK libraries will not be guaranteed to work on platforms and with other dependencies that have reached their end of life. Dropping support for such dependencies may be done without increasing the major version of the Azure SDK libraries. We strongly recommend migration to supported platforms and other dependencies to be eligible for technical support.

Below is a list of supported Azure SDK platforms and runtimes for your reference:

**Operating Systems:** Windows 10, macOS-10.15 , Linux (tested on Ubuntu 18.04)
For Mobile development, please check the [IOS supported platforms](https://azure.github.io/azure-sdk/ios_design.html#ios-library-support), and the [Android supported platforms](https://azure.github.io/azure-sdk/android_design.html)

**Runtime:**

- Any [supported .NET versions](https://dotnet.microsoft.com/en-us/platform/support/policy/dotnet-core) that implement .NET Standard 2.0.
- Java: Java 8 , Java 11
- Node.js: [LTS versions of Node.js](https://nodejs.org/about/releases/) including not just the ones in Active status, but also the ones in Maintainence status.
- Python 3.6+
- Go runtime– we support 2 latest major Go releases, refer to https://golang.org/doc/devel/release.html for more details.”
- For C, refer to the list of supported platforms and compilers [here](https://azure.github.io/azure-sdk/clang_design.html)

**Test configurations:**

Below are the test configurations covering different operating systems and runtimes. You may see some outgoing versions for which we are dropping support or incoming versions that we don't officially support yet. Please see the details in the previous section for the officially supported set.

- [.NET test configuration](https://github.com/Azure/azure-sdk-for-java/blob/main/eng/pipelines/templates/stages/platform-matrix.json)
- [Java test configuration](https://github.com/Azure/azure-sdk-for-java/blob/main/eng/pipelines/templates/stages/platform-matrix.json)
- [JavaScript test configuration](https://github.com/Azure/azure-sdk-for-js/blob/main/eng/pipelines/templates/stages/platform-matrix.json)
- [Python test configuration](https://github.com/Azure/azure-sdk-for-python/blob/main/eng/pipelines/templates/stages/platform-matrix.json)

### **Support**:

Customers with a support plan can open an Azure Support ticket [here](https://azure.microsoft.com/en-us/support/create-ticket/)
You can open GitHub issues [in the Azure SDK GitHub repositories](https://github.com/Azure/azure-sdk/blob/main/README.md) to track bugs and feature requests. GitHub issues are free, but may take a longer time to process.
