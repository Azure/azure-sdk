# Azure SDK

The Azure SDK delivers a platform for developers to leverage the wide variety of Azure services in their language of choice. The source for the client libraries exists for the most part in repositories for each language. This repository is meant to be a jumping off point into those language specific repositories. Issues related to a specific language should be opened in the corresponding repository but cross cutting issues can be opened in this repository.

| Language    | Guidelines                                                              | Repo                                                                |
|:------------|:-----------------------------------------------------------------------:|:-------------------------------------------------------------------:|
| C#  /.NET   |[Link](https://azuresdkspecs.z5.web.core.windows.net/DotNetSpec.html)    |[azure-sdk-for-net](https://github.com/Azure/azure-sdk-for-net)      |
| Java        |[Link](https://azuresdkspecs.z5.web.core.windows.net/JavaSpec.html)      |[azure-sdk-for-java](https://github.com/Azure/azure-sdk-for-java)    |
| JavaScript  |[Link](https://azuresdkspecs.z5.web.core.windows.net/TypeScriptSpec.html)|[azure-sdk-for-js](https://github.com/Azure/azure-sdk-for-js)        |
| Python      |[Link](https://azuresdkspecs.z5.web.core.windows.net/PythonSpec.html)    |[azure-sdk-for-python](https://github.com/Azure/azure-sdk-for-python)|
| Go          |                                                                         |[azure-sdk-for-go](https://github.com/Azure/azure-sdk-for-go)        |

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

| Service Name | .NET | Java | Python | JavaScript | Go |
| ------------ | ------ | ----- | ------ | ------- | -------- |
| Azure Storage | [code](https://github.com/Azure/azure-storage-net) | [code](https://github.com/Azure/azure-storage-java) | [code](https://github.com/Azure/azure-storage-python) | [code](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/storage) | [code](https://github.com/Azure/azure-storage-go) |
| CosmosDB | | [code](https://github.com/Azure/azure-cosmosdb-java) | [code](https://github.com/Azure/azure-cosmos-python) | [code](https://github.com/Azure/azure-cosmos-js) |
| Key Vault | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/KeyVault/data-plane)  | [code](https://github.com/Azure/azure-keyvault-java) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-keyvault) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/keyVault)|
| Service Bus | [code](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/servicebus) | [code](https://github.com/Azure/azure-service-bus-java) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-servicebus) | [code](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/servicebus/service-bus) |
| Event Hubs | [code](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/eventhub) | [code](https://github.com/Azure/azure-event-hubs-java) | [code](https://github.com/Azure/azure-event-hubs-python) | [code](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/eventhub/) |
| IotHub, Iot Devices, IotHub Provisioning Service, IotHub Provisioning Device | [code](https://github.com/Azure/azure-iot-sdk-csharp) | [code](https://github.com/Azure/azure-iot-sdk-java) | [code](https://github.com/Azure/azure-iot-sdk-python) | [code](https://github.com/Azure/azure-iot-sdk-node) |
| Event Grid | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/EventGrid/DataPlane) | [code](https://github.com/Azure/azure-sdk-for-java/tree/master/eventgrid/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-eventgrid) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/eventgrid) |
| Batch | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/Batch/DataPlane) | [code](https://github.com/Azure/azure-batch-sdk-for-java) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-batch) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/batch) |
| HDInsight | [code](https://github.com/Azure/azure-sdk-for-net/tree/master/src/SDKs/HDInsight) | [code](https://github.com/Azure/azure-sdk-for-java/tree/master/hdinsight) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-mgmt-hdinsight) | [code](https://github.com/Azure/azure-sdk-for-js/tree/master/packages/%40azure/arm-hdinsight) | [code](https://github.com/Azure/azure-sdk-for-go/tree/master/services/preview/hdinsight)
| Notification Hubs | | | | |
| Application Insights Ingestion | [code](https://github.com/Microsoft/ApplicationInsights-dotnet) | [code](https://github.com/Microsoft/ApplicationInsights-java)| [code](https://github.com/Microsoft/ApplicationInsights-python) | [code](https://github.com/Microsoft/ApplicationInsights-node.js) |
| Application Insights Query | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/ApplicationInsights/DataPlane)| [code](https://github.com/Azure/azure-sdk-for-java/tree/master/applicationinsights/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-applicationinsights)| [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/applicationinsights-query) |
| Log Analytics Ingestion | | | | |
| Log Analytics Query | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/OperationalInsights/DataPlane) | [code](https://github.com/Azure/azure-sdk-for-java/tree/master/loganalytics/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-loganalytics) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/loganalytics) |
| Service Fabric | | | | |
| Data Lake Analytics | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/DataLake.Analytics)| [code](https://github.com/Azure/azure-libraries-for-java/tree/master/azure-mgmt-datalake-analytics) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-mgmt-datalake-analytics)| [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/dataLake.Analytics)|
| Data Lake Store | [code](https://github.com/Azure/azure-data-lake-store-net) | [code](https://github.com/Azure/azure-data-lake-store-java) | [code](https://github.com/Azure/azure-data-lake-store-python) | |
| Azure Search | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/Search) | | | |
| Relay | [code](https://github.com/Azure/azure-relay-dotnet) | | | [code](https://github.com/Azure/azure-relay-node)|
| Cognitive Services | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/CognitiveServices/dataPlane) | [code](https://github.com/Azure/azure-sdk-for-java/tree/master/cognitiveservices/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services) |
| SQL | | | | |
| MySQL | | | | |
| PostgreSQL | | | | |
| Redis | | | | |

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
