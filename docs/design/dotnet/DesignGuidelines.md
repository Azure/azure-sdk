# 1.0 General Guidelines

### 1.0.0 General .NET API Design

1.0.1 :white_check_mark: **DO** follow the official [Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/). See Appendix A (at the end of this document) for design guidelines that are commonly overlooked in existing Azure SDKs.

1.0.2 :warning: **NOTE** additional gudelines in this section overrule the Framework Design Guidelines  

1.0.3 :white_check_mark: **DO** use Azure HTTP Pipeline to implement all methods that call Azure services. The pipeline takes care of many [General Azure SDK Guidelines](https://github.com/Azure/azure-sdk/blob/master/docs/design/common/DesignGuidelines.md), e.g. telemetry, logging, retries, mockability. Details of the pipeline design and usage are described in Appendix B below.

# 2.0 Basic Azure SDK Design Pattern

TODO:
This scection describes the basic shape of a typical Azure SDK:
- basic shape of the clinet types
- basic shape of service call methods
- cancellations
- return type (Response<T>) of service methods
- pipeline
- customizing service client and service method calls

# 3.0 Naming Gudelines

## 3.0.0 Namespace Naming

3.0.1 :white_check_mark: **DO** register all namespaces with adparch@microsoft.com, 
i.e. send email about your proposed namespaces to this address to start a discussion.  

3.0.2 :white_check_mark: **DO** adhere to the following scheme when choosing a namespace:
```Azure.<group>.<service>[.<feature>]```. For example, ```Azure.Storage.Blobs```, ```Azure.CognitiveServices.Speech.Recognition```
3.0.3 :no_entry: **DO NOT** place service API in second level namespace, e.g. ```Azure.KeyVault```

3.0.4 :ballot_box_with_check: **CONSIDER** using one of the following pre-approved namespace groups:

- Azure.Diagnostics (e.g. Azure.Diagnostics.OperationalInsights)
- Azure.Cognitive (e.g. Azure.Cognitive.FaceRecognition)
- Azure.Iot (e.g. Azure.Iot.Hub)
- Azure.Networking (e.g. Azure.Networking.EventHub)
- Azure.Runtime (e.g. Azure.Runtime.VirtualMachines)
- Azure.Security (e.g. Azure.Security.KeyVault)
- Azure.Storage (e.g. Azure.Storage.Blobs)

## 3.1.0 Type Naming
TODO: XxxClient, XxxResopurce, etc. 

## 4.0 Packaging and Versioning
TODO

## 5.0 Error Reporting
TODO

## 6.0 Authentication
TODO

## 7.0 Repository Guidelines
TODO:
- source code
- tests
- documentation
- spamples

## 8.0 Common Type Usage
TODO:
- Etag
- Response<T>
- System.Uri
  
## Appendix A: Commonly Overlooked .NET API Design Guidelines
Some .NET Design Guiudelines have been notoriously overlooked in exisitng Azure SDKs. This section serves as a way to highlight these guidelines.

:no_entry: **DO NOT** have abstractions (interfaces of abstract classes) unless types both implement and consume them (i.e. you have parameters typed as the abstraction).

:no_entry: **DO NOT**  use interfaces if you can use abstract classes. The only reasons to use an interface are: a) you need to “multiple-inherit”, b) you want structs to implement and abstraction.

 :no_entry: **DO NOT**  use very generic words and terms for type names, e.g. do not use names like “OperationResponse”, “DataCollection” etc.

:warning: **AVOID** parameters types where it’s not clear what valid values are supported, e.g. string parameters are often like that.

:no_entry: **DO NOT** have empty types (types with no members)

## Appendix B: Azure Http Pipeline
TODO:
For now just link to sources: https://github.com/Azure/azure-sdk-for-net-lab/tree/master/Core/Azure.Core
Once we publish Nuget package, this will be updated.

## Appendix Z: TODO
- integration with ASP.NET application model
- performance
