# Azure SDK

The Azure SDK delivers a platform for developers to leverage the wide variety of Azure services in their language of choice. The source for the client libraries exists for the most part in repositories for each language. This repository is meant to be a jumping off point into those language specific repositories. Issues related to a specific language should be opened in the corresponding repository but cross cutting issues can be opened in this repository.

| Language    | Design Guidelines                                                       | Repo                                                                |
|:------------|:-----------------------------------------------------------------------:|:-------------------------------------------------------------------:|
| General   |[General Design Guidelines](https://azuresdkspecs.z5.web.core.windows.net/)    |[azure-sdk Repository](https://github.com/Azure/azure-sdk)      |
| C#  /.NET   |[Design Guidelines for .NET](https://azuresdkspecs.z5.web.core.windows.net/DotNetSpec.html)    |[azure-sdk-for-net Repository](https://github.com/Azure/azure-sdk-for-net)      |
| Go          |                                                                         |[azure-sdk-for-go Repository](https://github.com/Azure/azure-sdk-for-go)        |
| Java        |[Design Guidelines for Java](https://azuresdkspecs.z5.web.core.windows.net/JavaSpec.html)      |[azure-sdk-for-java Repository](https://github.com/Azure/azure-sdk-for-java)    |
| JavaScript  |[Design Guidelines for JavaScript and TypeScript](https://azuresdkspecs.z5.web.core.windows.net/TypeScriptSpec.html)|[azure-sdk-for-js Repository](https://github.com/Azure/azure-sdk-for-js)        |
| Python      |[Design Guidelines for Python](https://azuresdkspecs.z5.web.core.windows.net/PythonSpec.html)    |[azure-sdk-for-python Repository](https://github.com/Azure/azure-sdk-for-python)|

Service teams should schedule reviews of their client libraries with the ADP Review Board.  See the [Review Process](docs/ReviewProcess.md) for more information.

## Terminology

- **SDK**: Software Development Kit. This refers to the entire Azure SDK for a single language, itself broken up into numerous Azure SDK _Client Libraries_ (as defined below).

- **Client Library**. This refers to a library (and associated tools, documentation, and samples) that customers/developers use to ease working with an Azure service. There is often one client library per service and per programming language. Sometimes a single client library will contain the ability to connect to multiple services. Each client library is published separately to the appropriate language-specific package repository.  These releases are performed exclusively by the Azure SDK engineering systems team. Customers/Developers consume and use each client library separately as necessary to solve their use case.

- **Package**. This refers to a client library after it has been packaged for distribution for customer-developers to consume. Examples are:
   - A Nuget package for a .NET client library
   - A Maven package for a Java library
   - An NPM package for a JavaScript library
   - A Python wheel for a Python library

# Azure Service Libraries

The following is a list of Azure services and links to their open source code:

## Client Libraries

| Service Name | Language Availability |
| ------------ | --------------------- |
| Azure Storage | [.NET](https://github.com/Azure/azure-storage-net) [Go](https://github.com/Azure/azure-storage-go) [Java](https://github.com/Azure/azure-storage-java) [Javascript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/storage) [Python](https://github.com/Azure/azure-storage-python) |
| CosmosDB | [Java](https://github.com/Azure/azure-cosmosdb-java) [Javascript](https://github.com/Azure/azure-cosmos-js) [Python](https://github.com/Azure/azure-cosmos-python) |
| Key Vault | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/KeyVault/data-plane) [Java](https://github.com/Azure/azure-keyvault-java) [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/keyVault) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-keyvault) |
| Service Bus | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/servicebus) [Java](https://github.com/Azure/azure-service-bus-java) [Javascript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/servicebus/service-bus) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-servicebus) |
| Event Hubs | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/eventhub) [Java](https://github.com/Azure/azure-event-hubs-java) [Javascript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/eventhub/) [Python](https://github.com/Azure/azure-event-hubs-python) |
| IotHub, Iot Devices, IotHub Provisioning Service, IotHub Provisioning Device | [.NET](https://github.com/Azure/azure-iot-sdk-csharp) [Java](https://github.com/Azure/azure-iot-sdk-java) [Node](https://github.com/Azure/azure-iot-sdk-node) [Python](https://github.com/Azure/azure-iot-sdk-python) |
| Event Grid | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/EventGrid/DataPlane) [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/eventgrid/data-plane) [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/eventgrid) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-eventgrid) |
| Batch | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/Batch/DataPlane) [Java](https://github.com/Azure/azure-batch-sdk-for-java) [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/batch) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-batch) |
| HDInsight | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/master/src/SDKs/HDInsight) [Go](https://github.com/Azure/azure-sdk-for-go/tree/master/services/preview/hdinsight) [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/hdinsight) [Javascript](https://github.com/Azure/azure-sdk-for-js/tree/master/packages/%40azure/arm-hdinsight) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-mgmt-hdinsight) |
| Application Insights Ingestion | [.NET](https://github.com/Microsoft/ApplicationInsights-dotnet) [Java](https://github.com/Microsoft/ApplicationInsights-java) [Node](https://github.com/Microsoft/ApplicationInsights-node.js) [Python](https://github.com/Microsoft/ApplicationInsights-python) |
| Application Insights Query | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/ApplicationInsights/DataPlane) [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/applicationinsights/data-plane) [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/applicationinsights-query) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-applicationinsights)|
| Log Analytics Query | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/OperationalInsights/DataPlane) [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/loganalytics/data-plane) [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/loganalytics) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-loganalytics) |
| Data Lake Analytics | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/DataLake.Analytics) [Java](https://github.com/Azure/azure-libraries-for-java/tree/master/azure-mgmt-datalake-analytics) [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/dataLake.Analytics) [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-mgmt-datalake-analytics) |
| Data Lake Store | [.NET](https://github.com/Azure/azure-data-lake-store-net) [Java](https://github.com/Azure/azure-data-lake-store-java) [Python](https://github.com/Azure/azure-data-lake-store-python) |
| Azure Search | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/Search) |
| Relay | [.NET](https://github.com/Azure/azure-relay-dotnet) [Node](https://github.com/Azure/azure-relay-node) |
| Cognitive Services | [.NET](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/CognitiveServices/dataPlane) [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/cognitiveservices/data-plane) | [Node](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services) [Python](https://github.com/Azure/azure-sdk-for-python) |


# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

[Internal azure-sdk DevOps Wiki](https://aka.ms/azure-sdk-devops-wiki)
