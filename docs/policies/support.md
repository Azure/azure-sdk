## **Azure SDK lifecycle and support policy**

Azure SDK Lifecycle and support are governed by the latest [Online Service Terms document](https://www.microsoftvolumelicensing.com/Downloader.aspx?documenttype=OST&lang=English) and [Microsoft Modern Lifecycle Policy](https://docs.microsoft.com/en-US/lifecycle/policies/modern),  which will prevail in case of any conflicts with the information below. 

### **Package lifecycle** 
Here are the stages of a typical package lifecycle (for major versions)
1.	**Pre-release/Preview/Beta** – A new SDK is available for early access and feedback purposes and should not be used in production.  
The preview version support is limited to GitHub issues and response time is not guaranteed. Preview releases live typically for less than 1 year , after which either retired or released to GA.

2.	**Active** - The SDKs are generally available and fully supported, will receive new feature updates, as well as bug and security fixes.  
The major version will remain active for at least 12 months from the release date. Compatible updates for the major release are provided through minor versions, or patch versions.  
Customers encouraged to use the latest minor version, and only the latest minor version will get fixes and updates.  

3.	**Maintenance** - Typically, maintenance mode is announced at the same time as the next major version is transitioned to Active,  
after which the releases will only address the most critical bug fixes and security fixes for at least another 12 months.  

4.	**Released to the community** - SDK will no longer receive updates from Microsoft unless otherwise specified in the separate customer agreement.  
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

**Operating Systems:** Windows 10, macOS-10.15 , Linux (tested on Ubuntu 18.04)  See test configuration [here](https://github.com/Azure/azure-sdk-for-net/blob/master/eng/pipelines/templates/stages/platform-matrix.json).   
For Mobile development: iOS version 13+, Android API level 21+

**Runtime:** 
* Any platforms supporting .NET Standard 2.0. Tested on .NET Framework 4.6.1 and .NET Core 2.1, .NET 5.0, see test configuration [here](https://github.com/Azure/azure-sdk-for-net/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* Java: Java 8 , Java 11, see test configuration [here](https://github.com/Azure/azure-sdk-for-java/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* JS/TS: Node 8.x,10.x,12.x,14.x , see test configuration [here](https://github.com/Azure/azure-sdk-for-js/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* Python 3.5+, 2.7 , see configuration [here](https://github.com/Azure/azure-sdk-for-python/blob/master/eng/pipelines/templates/stages/platform-matrix.json)  
* Go runtime– we support 2 latest major Go releases, refer to  https://golang.org/doc/devel/release.html for more details.”

### **Support**:
Customers with support plan can open the Azure Support ticket [here](https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fazure.microsoft.com%2Fen-us%2Fsupport%2Fcreate-ticket%2F&data=04%7C01%7CElena.Raikhman%40microsoft.com%7C144b66f8b5c0490f3cbe08d8d765b744%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637496179151201463%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=Ie8gcF%2B0sRcrS25b28XKQcogcUr90NNXRcXXqwYrBz8%3D&reserved=0)  
We also use GitHub Issues to track bugs and feature requests. GitHub issues are free, but may take a longer time to process.   
