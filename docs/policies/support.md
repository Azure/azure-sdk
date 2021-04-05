---
title: "Policies: Support"
permalink: policies_support.html
folder: policies
sidebar: general_sidebar
---

## **Azure SDK lifecycle and support policy**

Azure SDK Lifecycle and support are governed by the latest [Microsoft Modern Lifecycle Policy](https://docs.microsoft.com/en-US/lifecycle/policies/modern),  which will prevail in case of any conflicts with the information below. 

### **Package lifecycle** 
Here are the stages of a typical package lifecycle (for major versions)
1.	**Beta** – A new SDK is available for early access and feedback purposes and not recommended to be used in production.  
The beta version support is limited to GitHub issues and response time is not guaranteed. Beta releases live typically for less than 1 year, after which they are either retired or released to GA.

2.	**Active** - The SDKs are generally available and fully supported, will receive new feature updates, as well as bug and security fixes.  
The major version will remain active for at least 12 months from the release date. Compatible updates for the major release are provided through minor versions, or patch versions.  
Customers are encouraged to use the latest version as that is the version that will get fixes and updates.  

3.	**Maintenance** - Typically, maintenance mode is announced at the same time as the next major version is transitioned to Active,  
after which the releases will only address the most critical bug fixes and security fixes for at least another 12 months.  

4.	**Community** - SDK will no longer receive updates from Microsoft unless otherwise specified in the separate customer agreement.  
The package will remain available via public package managers and the GitHub repo, which can be maintained by the community.  

You can check the lifecycle stage for your package at [this page](https://azure.github.io/azure-sdk/releases/latest/index.html)  

### **Azure Clouds** 
By default, the Azure libraries are configured to connect to the Global Azure Cloud.  
Additional cloud target platforms are available, such as Azure Stack, Azure China and Government Cloud.  
Package lifecycle may vary across different target platforms. Refer to the target platform documentation for more information.   

### **Azure SDK dependencies**
The Azure SDK libraries depend on Azure Service REST API, programming language runtime, OS, and third-party libraries.  
The Azure SDK will not guarantee support of dependencies that reached their end of life.  

Below is a list of common Azure SDK dependencies for your reference: 

**Operating Systems:** Windows 10, macOS-10.15 , Linux (tested on Ubuntu 18.04) 
For Mobile development, please find IOS supported platforms [here](https://azure.github.io/azure-sdk/ios_design.html#ios-library-support), and Android supported platforms [here](https://azure.github.io/azure-sdk/android_design.html)

**Runtime:** 
* Any platforms supporting .NET Standard 2.0. Tested on .NET Framework 4.6.1 and .NET Core 2.1, .NET 5.0, see test configuration [here](https://github.com/Azure/azure-sdk-for-net/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* Java: Java 8 , Java 11, see test configuration [here](https://github.com/Azure/azure-sdk-for-java/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* JS/TS: Node 8.x,10.x,12.x,14.x , see test configuration [here](https://github.com/Azure/azure-sdk-for-js/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* Python 3.5+, 2.7 , see test configuration [here](https://github.com/Azure/azure-sdk-for-python/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* Go runtime– we support 2 latest major Go releases, refer to  https://golang.org/doc/devel/release.html for more details.”
* For C, refer to the list of supported platforms and compilers [here](https://azure.github.io/azure-sdk/clang_design.html)

### **Support**:
Customers with support plan can open the Azure Support ticket [here](https://azure.microsoft.com/en-us/support/create-ticket/)  
You can open a GitHub issues [in the Azure SDK GitHub repositories](https://github.com/Azure/azure-sdk/blob/master/README.md)  to track bugs and feature requests. GitHub issues are free, but may take a longer time to process.   
