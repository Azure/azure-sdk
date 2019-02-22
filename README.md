# Azure SDK

The Azure SDK delivers a platform for developers to leverage the wide variety of Azure services in their language of choice. The source for the libraries exists for the most part in repositories for each language. This repository is meant to be a jumping off point into those language specific repositories. Issues related to a specific language should be opened in the corresponding repository but cross cutting issues can be opened in this repository.

| [.NET](https://github.com/Azure/azure-sdk-for-net) | [Java](https://github.com/Azure/azure-sdk-for-java) | [Python](https://github.com/Azure/azure-sdk-for-python) | [JavaScript](https://github.com/Azure/azure-sdk-for-js) | [Go](https://github.com/Azure/azure-sdk-for-go) |

## Azure SDK Design Guidelines

- [.NET](https://azuresdkspecs.z5.web.core.windows.net/DotNetSpec.html) ([template](https://github.com/Azure/azure-sdk-for-net/tree/master/src/SDKs/Template/data-plane))
- [Java](https://azuresdkspecs.z5.web.core.windows.net/JavaSpec.html) ([template](https://github.com/Azure/azure-sdk-for-java/tree/master/template/client))
- [Python](https://azuresdkspecs.z5.web.core.windows.net/PythonSpec.html) ([template](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-template))
- [TypeScript](https://azuresdkspecs.z5.web.core.windows.net/TypeScriptSpec.html) ([template](https://github.com/Azure/azure-sdk-for-js/tree/master/packages/%40azure/template))

# Azure Service Libraries

The following is a list of Azure services and links to their open source code:

## Client Libraries

| Service Name | .NET | Java | Python | JavaScript | Go |
| ------------ | ------ | ----- | ------ | ------- | -------- |
| Azure Storage | [code](https://github.com/Azure/azure-storage-net) | [code](https://github.com/Azure/azure-storage-java) | [code](https://github.com/Azure/azure-storage-python) | [code](https://github.com/Azure/azure-storage-node) | [code](https://github.com/Azure/azure-storage-go) |
| CosmosDB | | [code](https://github.com/Azure/azure-cosmosdb-java) | [code](https://github.com/Azure/azure-cosmos-python) | [code](https://github.com/Azure/azure-cosmos-js) |
| Keyvault | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/KeyVault/dataPlane)  | [code](https://github.com/Azure/azure-keyvault-java) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-keyvault) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/keyVault)|
| Service Bus | [code](https://github.com/Azure/azure-service-bus-dotnet) | [code](https://github.com/Azure/azure-service-bus-java) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-servicebus) | [code](https://github.com/Azure/azure-sdk-for-js/tree/master/packages/%40azure/servicebus/data-plane) |
| Event Hubs | [code](https://github.com/Azure/azure-event-hubs-dotnet) | [code](https://github.com/Azure/azure-event-hubs-java) | [code](https://github.com/Azure/azure-event-hubs-python) | [code](https://github.com/Azure/azure-sdk-for-js/tree/master/packages/%40azure/eventhubs/) |
| IotHub, Iot Devices, IotHub Provisioning Service, IotHub Provisioning Device | [code](https://github.com/Azure/azure-iot-sdk-csharp) | [code](https://github.com/Azure/azure-iot-sdk-java) | [code](https://github.com/Azure/azure-iot-sdk-python) | [code](https://github.com/Azure/azure-iot-sdk-node) |
| Event Grid | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/EventGrid/DataPlane) | [code](https://github.com/Azure/azure-sdk-for-java/tree/master/eventgrid/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-eventgrid) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/eventgrid) |
| Batch | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/Batch/DataPlane) | [code](https://github.com/Azure/azure-batch-sdk-for-java) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-batch) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/batch) |
| HDInsight | | | | |
| Notification Hubs | | | | |
| Application Insights Ingestion | [code](https://github.com/Microsoft/ApplicationInsights-dotnet) | [code](https://github.com/Microsoft/ApplicationInsights-java)| [code](https://github.com/Microsoft/ApplicationInsights-python) | [code](https://github.com/Microsoft/ApplicationInsights-node.js) |
| Application Insights Query | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/ApplicationInsights/DataPlane)| [code](https://github.com/Azure/azure-sdk-for-java/tree/master/applicationinsights/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-applicationinsights)| [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/applicationinsights-query) |
| Log Analytics Ingestion | | | | |
| Log Analytics Query | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/OperationalInsights/DataPlane) | [code](https://github.com/Azure/azure-sdk-for-java/tree/master/loganalytics/data-plane) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-loganalytics) | [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/loganalytics) |
| Service Fabric | | | | |
| DataLake Analytics | [code](https://github.com/Azure/azure-sdk-for-net/tree/psSdkJson6/src/SDKs/DataLake.Analytics)| [code](https://github.com/Azure/azure-libraries-for-java/tree/master/azure-mgmt-datalake-analytics) | [code](https://github.com/Azure/azure-sdk-for-python/tree/master/azure-mgmt-datalake-analytics)| [code](https://github.com/Azure/azure-sdk-for-node/tree/master/lib/services/dataLake.Analytics)|
| Datalake Store | [code](https://github.com/Azure/azure-data-lake-store-net) | [code](https://github.com/Azure/azure-data-lake-store-java) | [code](https://github.com/Azure/azure-data-lake-store-python) | |
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
