---
title: Azure SDK for .NET (October 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- Management Library - Compute
- Management Library - Network
- Management Library - Resources
- Management Library - Storage

#### Beta

- Event Grid
- Event Hubs
- Identity
- Key Vault
- Management Library - CosmosDB
- Management Library - DNS
- Management Library - Insight
- Metrics Advisor
- Monitor
- Search Documents
- Service Bus
- Storage
- Support packages for Microsoft.Spatial
- Tables
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.MetricsAdvisor --version 1.0.0-beta.1

$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.2

$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.2

$> dotnet add package Azure.Identity --version 1.3.0-beta.2

$> dotnet add package Azure.Messaging.EventGrid --version 4.0.0-beta.3

$> dotnet add package Azure.Messaging.EventHubs --version 5.3.0-beta.3
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.0-beta.3

$> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.8

$> dotnet install Azure.ResourceManager.Compute --version 1.0.0-preview.2
$> dotnet install Azure.ResourceManager.Network --version 1.0.0-preview.2
$> dotnet install Azure.ResourceManager.Resources --version 1.0.0-preview.2
$> dotnet install Azure.ResourceManager.Storage --version 1.0.0-preview.2

$> dotnet install Azure.ResourceManager.CosmosDB --version 1.0.0-preview.1
$> dotnet install Azure.ResourceManager.Dns --version 1.0.0-preview.1
$> dotnet install Azure.ResourceManager.Insights --version 1.0.0-preview.1

$> dotnet add package Azure.Search.Documents --version 11.2.0-beta.1

$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.2
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.2
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.2
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.2

$> dotnet add package Azure.Storage.Blobs --version 12.7.0-preview.1
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.4.0-preview.1
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.5
$> dotnet add package Azure.Storage.Files.DataLake --version 12.5.0-preview.1
$> dotnet add package Azure.Storage.Files.Shares --version 12.5.0-preview.1
$> dotnet add package Azure.Storage.Queues --version 12.5.0-preview.1

$> dotnet add package Microsoft.Azure.Core.Spatial --version 1.0.0-beta.1
$> dotnet add package Microsoft.Azure.Core.Spatial.NewtonsoftJson --version 1.0.0-beta.1

$> dotnet add package OpenTelemetry.Exporter.AzureMonitor --version 1.0.0-beta.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- Added support for Container Soft Delete.
- Added support for Blob Query Arrow output format.
- Added support for Blob Last Access Time tracking.

#### Key Bug Fixes
- Fixed bug causing `BlobAccessPolicy.StartsOn` and `.ExpiresOn` to crash the process.
- Fixed bug in where Stream returned from `AppendBlobClient.OpenWrite()`, `BlockBlobClient.OpenWrite()`, and `PageBlobClient.OpenWrite()` did not flush while disposing preventing compatibility with using keyword.
- Fixed bug where Listing Blobs with `BlobTraits.Metadata` would return `BlobItems` with null metadata instead of an empty dictionary if no metadata was present.

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### New Features
- Added support for Directory SAS.
- Added support for File Set Expiry.
- Added `Close` and `RetainUncommitedData` to `DataLakeFileUploadOptions`
- Added seekability to `DataLakeFileClient.OpenRead()`
- Added `DataLakeClientBuilderExtensions`

#### Key Bug Fixes
- Fixed bug where `DataLakeFileClient.Upload()` could not upload read-only files.
- Fixed bug causing `DataLakeBlobAccessPolicy.StartsOn` and `.ExpiresOn` to crash the process.
- Fixed bug where Stream returned from `DataLakeFileClient.OpenWrite()` did not flush while disposing preventing compatibility with using keyword.
- Fixed bug where `DataLakeDirectoryClient.Rename()` and `DataLakeDirectoryFileClient.Rename()` couldn't handle source paths with special characters.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- Added support for 4 TB Files
- Added support for SMB Multichannel
- Added support for Share and Share Snapshot Leases
- Added support for Get File Range Diff
- Added support for Set Share Tier

#### Key Bug Fixes
- Fixed bug causing `ShareAccessPolicy.StartsOn` and `.ExpiresOn` to crash the process.
- Fixed bug where Stream returned from `ShareFileClient.OpenWrite()` did not flush while disposing preventing compatibility with using keyword.

### Core Experimental [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core.Experimental/CHANGELOG.md#010-preview6-2020-10-06)

#### Breaking Changes
- `BinaryData`: Change return type of `FromObjectAsync` from `Task<T>` to `ValueTask<T>`.

### Event Grid [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventgrid/Azure.Messaging.EventGrid/CHANGELOG.md#400-beta3-2020-10-06)

#### New Features
- Added TraceParent/TraceState into CloudEvent extension attributes.
- Added KeyVaultAccessPolicyChangedEventData system event.

#### Breaking Changes
- Renamed Azure Communication Services system events.
- Renamed EventGridPublisherClientOptions DataSerializer property to Serializer.

#### Key Bug Fixes
- Fixed a bug where we were not parsing the Topic when parsing into EventGridEvents.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features
- `EventData` has been integrated with the new Schema Registry service, via use of the `SchemaRegistryAvroObjectSerializer` with the `BodyAsBinaryData` member.
- The `EventHubProducerClient` now offers the ability to opt-into idempotent publishing, reducing the potential for duplication when a publishing operation encounters timeouts or other transient failures.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features
- `EventData` has been integrated with the new Schema Registry service, via use of the `SchemaRegistryAvroObjectSerializer` with the `BodyAsBinaryData` member.

### Key Vault
- Bug fixes and performance improvements.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#130-beta2-2020-10-07)

#### New Features
- Update `DeviceCodeCredential` to output device code information and authentication instructions in the console, in the case no `deviceCodeCallback` is specified.
- Added `DeviceCodeCallback` to `DeviceCodeCredentialOptions`.
- Added default constructor to `DeviceCodeCredential`.

#### Breaking Changes
- Replaced `DeviceCodeCredential` constructor overload taking `deviceCodeCallback` and `DeviceCodeCredentialOptions` with constructor taking only `DeviceCodeCredentialOptions`.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/metricsadvisor/Azure.AI.MetricsAdvisor/CHANGELOG.md#100-beta1-2020-10-08)

- This is the first beta of the `Azure.AI.MetricsAdvisor` client library.

### Monitor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/OpenTelemetry.Exporter.AzureMonitor_1.0.0-beta.1/sdk/monitor/OpenTelemetry.Exporter.AzureMonitor/CHANGELOG.md#100-beta1-2020-10-07)

- Initial release of Azure Monitor Exporter for [OpenTelemetry .NET](https://github.com/open-telemetry/opentelemetry-dotnet)

### Search Documents [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md#1120-beta1-2020-10-09)

#### New Features
- Add `SearchIndexingBufferedSender<T>` to make indexing lots of documents fast and easy.
- Add support to `FieldBuilder` to define search fields for `Microsoft.Spatial` types without an explicit assembly dependency.
- Add support to `SearchFilter` to encode geometric types from `Microsoft.Spatial` without an explicit assembly dependency.
- Add `IndexingParameters.IndexingParametersConfiguration` property to define well-known properties supported by Azure Cognitive Search.

#### Key Bug Fixes
- Support deserializing null values during deserialization of skills ([#15108](https://github.com/Azure/azure-sdk-for-net/issues/15108)).
- Fixed issues preventing mocking clients or initializing all models.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview8-2020-10-06)

#### New Features
- Added `AcceptSessionAsync` that accepts a specific session based on session ID.

#### Breaking Changes
- Renamed `ViaQueueOrTopicName` to `TransactionQueueOrTopicName`.
- Renamed `ViaPartitionKey` to `TransactionPartitionKey`.
- Renamed `ViaEntityPath` to `TransactionEntityPath`.
- Renamed `Proxy` to `WebProxy`.
- Made `MaxReceiveWaitTime` in `ServiceBusProcessorOptions` and `ServiceBusSessionProcessorOptions` internal.
- Renamed `CreateSessionReceiverAsync` to `AcceptNextSessionAsync`.
- Removed `SessionId` from `ServiceBusClientOptions` in favor of `AcceptSessionAsync`.

### Support packages for Microsoft.Spatial

#### Microsoft.Azure.Core.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Microsoft.Azure.Core.Spatial/CHANGELOG.md#100-beta1-2020-10-08)

- Added `MicrosoftSpatialGeoJsonConverter` to serialize `Microsoft.Spatial.GeometryPoint` objects.

#### Microsoft.Azure.Core.Spatial.NewtonsoftJson [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Microsoft.Azure.Core.Spatial.NewtonsoftJson/CHANGELOG.md#100-beta1-2020-10-08)

- Added `NewtonsoftJsonMicrosoftSpatialGeoJsonConverter` to serialize `Microsoft.Spatial.GeographyPoint` objects.

### Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta2-2020-10-06)

#### New Features
- Implemented batch operations.
- `TableClient`'s `GetEntity` method now exposes the `select` query option to allow for more efficient existence checks for a table entity.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta2-2020-10-06)

#### Breaking changes
- Removed property `Length` from the library as it can be obtained by calling `Length` on the `Text` property of types `CategorizedEntity`, `SentenceSentiment`, `LinkedEntityMatch`, `AspectSentiment`, `OpinionSentiment`, and `PiiEntity`.

### New Management Libraries
A new set of management libraries that follow the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) and based on [Azure.Core libraries](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/core/Azure.Core) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. You can find the list of new packages [on this page](https://aka.ms/azsdk/releases).

To get started with these new libraries, please see the [quickstart guide here](https://aka.ms/azsdk/net/mgmt). These new libraries can be identifed by namespaces that start with `Azure.ResourceManager`, e.g. `Azure.ResourceManager.Network`

More details of recent management library release annoucements as well as future roadmap can be found at [this blog post](https://devblogs.microsoft.com/azure-sdk/october-2020-management-ga/)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
