# Azure SDK for .NET Preview 1 Release Notes

The Azure SDK team is pleased to announce our July 2019 client library preview.  This represents the first release of a ground-up rewrite of our client libraries to ensure consistency, idiomatic design, productivity, and an excellent developer experience.  This preview includes new libraries for Storage (Blobs, Queues, and Files), Key Vault (Secrets and Keys), Event Hubs, Cosmos, Identity, and Azure App Configuration.

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.Storage.Blobs --version 12.0.0-preview.1
    $> dotnet add package Azure.Storage.Queues --version 12.0.0-preview.1
    $> dotnet add package Azure.Storage.Files --version 12.0.0-preview.1

    $> dotnet add package Azure.Security.KeyVault.Secrets --version 4.0.0-preview.1
    $> dotnet add package Azure.Security.KeyVault.Keys --version 4.0.0-preview.1

    $> dotnet add package Azure.Messaging.EventHubs --version 5.0.0-preview.1

    $> dotnet add package Microsoft.Azure.Cosmos --version 3.0.0.19-preview

    $> dotnet add package Azure.Identity --version 1.0.0-preview.2

    $> dotnet add package Azure.ApplicationModel.Configuration --version 1.0.0-preview.2

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose) and add the labels `Preview` and `Bug` or `Feature`.

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

- New client libraries were created using the [Azure SDK Design Guidelines for .NET](https://azuresdkspecs.z5.web.core.windows.net/DotNetSpec.html) resulting in consistent API patterns and shared features like automatic retries, authentication, logging, configurable transport pipelines, exceptions, mocking, etc.
- Support for Azure Active Directory credentials using our new Identity library that embrace the future of authentication across Azure services.
- Parity across synchronous and asynchronous APIs offering a choice appropriate to your application.

## Quick Links

| Service  | Install | Readme | Samples |  API Reference | Changelog |
| -- | -- | -- | -- | -- | -- |
| Storage - Blobs | [Package](https://www.nuget.org/packages/Azure.Storage.Blobs/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Blobs/tests/Samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Storage/Azure.Storage.Blobs.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/Changelog.txt) |
| Storage - Queues | [Package](https://www.nuget.org/packages/Azure.Storage.Queues/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Queues/tests/Samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Storage/Azure.Storage.Queues.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/Changelog.txt) |
| Storage - Files | [Package](https://www.nuget.org/packages/Azure.Storage.Files/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Files/tests/Samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Storage/Azure.Storage.Files.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files/Changelog.txt) |
| Storage - Common | [Package](https://www.nuget.org/packages/Azure.Storage.Common/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Common/README.md) | - | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Storage/Azure.Storage.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Common/Changelog.txt) |
| Key Vault - Secrets | [Package](https://www.nuget.org/packages/Azure.Security.KeyVault.Secrets/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Secrets/Readme.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Secrets/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/KeyVault/Azure.Security.KeyVault.Secrets.html) | - |
| Key Vault - Keys | [Package](https://www.nuget.org/packages/Azure.Security.KeyVault.Keys/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Keys/Readme.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Keys/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/KeyVault/Azure.Security.KeyVault.Keys.html) | - |
| Event Hubs | [Package](https://www.nuget.org/packages/Azure.Messaging.EventHubs/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/eventhub/Azure.Messaging.EventHubs/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/EventHubs/Azure.Messaging.EventHubs.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md) |
| Cosmos | [Package](https://www.nuget.org/packages/Microsoft.Azure.Cosmos/) | [Readme](https://github.com/Azure/azure-cosmos-dotnet-v3/blob/master/README.md) | [Samples](https://github.com/Azure/azure-cosmos-dotnet-v3/tree/master/Microsoft.Azure.Cosmos.Samples/CodeSamples) | [API Reference](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.cosmos?view=azure-dotnet-preview) | [Changelog](https://github.com/Azure/azure-cosmos-dotnet-v3/blob/master/changelog.md) |
| Identity | [Package](https://www.nuget.org/packages/Azure.Identity/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/README.md) | - | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Identity/Azure.Identity.html) | - |
| App Configuration | [Package](https://www.nuget.org/packages/Azure.ApplicationModel.Configuration/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/appconfiguration/Azure.ApplicationModel.Configuration/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/appconfiguration/Azure.ApplicationModel.Configuration/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/ApplicationModel.Configuration/Azure.ApplicationModel.Configuration.html) | - |
| Core | [Package](https://www.nuget.org/packages/Azure.Core) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core/Azure.Core/tests/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Core/Azure.Core.html) | - |
