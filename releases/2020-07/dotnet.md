---
title: Azure SDK for .NET (July 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our July 2020 client library releases.

#### GA

- Search
- Text Analytics

#### Updates

- App Configuration

#### Preview

- Event Hubs
- Form Recognizer
- Identity
- Service Bus
- Storage
- Management Library - Compute
- Management Library - Network
- Management Library - Resources
- Management Library - Storage
- Management Library - KeyVault
- Management Library - EventHubs
- Management Library - AppConfiguration

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
 $> dotnet add package Azure.AI.FormRecognizer --version 1.0.0-preview.4

 $> dotnet add package Azure.AI.TextAnalytics

 $> dotnet add package Azure.Data.AppConfiguration

 $> dotnet add package Azure.Identity --version 1.2.0-preview.5

 $> dotnet add package Azure.Messaging.EventHubs --version 5.2.0-preview.1
 $> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.2.0-preview.1

 $> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.4

 $> dotnet add package Azure.Storage.Blobs --version 12.5.0-preview.5
 $> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.5.0-preview.5
 $> dotnet add package Azure.Storage.Files.DataLake --version 12.0.0-preview.1
 $> dotnet add package Azure.Storage.Files.Shares --version 12.3.0-preview.1
 $> dotnet add package Azure.Storage.Queues --version 12.4.0-preview.5

 $> dotnet add package Azure.Search.Documents

 $> dotnet add package Azure.ResourceManager.Compute --version 1.0.0-preview.1
 $> dotnet add package Azure.ResourceManager.Network --version 1.0.0-preview.1
 $> dotnet add package Azure.ResourceManager.Resources --version 1.0.0-preview.1
 $> dotnet add package Azure.ResourceManager.Storage --version 1.0.0-preview.1
 $> dotnet add package Azure.ResourceManager.KeyVault --version 1.0.0-preview.1
 $> dotnet add package Azure.ResourceManager.EventHubs --version 1.0.0-preview.1
 $> dotnet add package Azure.ResourceManager.AppConfiguration --version 1.0.0-preview.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### App Configuration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/appconfiguration/Azure.Data.AppConfiguration/CHANGELOG.md#101-2020-07-07)

- Update the tag list for the AzConfig package

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/CHANGELOG.md#130-2020-07-02)

#### New features
- `HttpPipeline.CreateClientRequestIdScope` method to allow setting client request id on outgoing requests.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- The `EventHubConsumerClient` now supports configuring the `PrefetchCount` and `CacheEventCount` for more control over performance tuning.

- The `EventProcessor<TPartition>` now supports configuring a `LoadBalancingStrategy` for more control over performance tuning.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- The `EventProcessorClient` now supports configuring the `PrefetchCount`, `CacheEventCount`, and `LoadBalancingStrategy` for more control over performance tuning.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#100-preview4-2020-07-07)

#### Breaking Changes
- `RecognizedReceipt` and `RecognizedReceiptsCollection` classes removed. Receipt field values must now be obtained from a `RecognizedForm`.
- Model and property renamings detailed in the Changelog.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#120-preview5-2020-07-08)

#### New Features
- Added options classes `ClientCertificateCredentialOptions` and `ClientSecretCredentialOptions` which support the following new option
    - `EnablePersistentCache` configures these credentials to use a persistent cache shared between credentials which set this option. By default the cache is per credential and in memory only.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md#1100-2020-07-07)

#### Breaking Changes
- Removed `Azure.Core.Experimental` reference and features until they're moved
  into `Azure.Core`.
- Removed `SearchServiceCounters.SkillsetCounter` and `new SearchOptions(string continuationToken)`.

#### New Features
- Changed version to 11.0.0.
- Replaced `SearchClientOptions.ServiceVersion.V2019_05_06_Preview` with `SearchClientOptions.ServiceVersion.V2020_06_30`.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview4-2020-07-07)

#### Breaking Changes
- Remove use of "Batch" in Peek/Receive methods.
- Add Message/Messages suffix to Peek/Send/Receive/Abandon/Defer/Complete/DeadLetter methods.
- Rename ServiceBusSender.CreateBatch to ServiceBusSender.CreateMessageBatch
- Rename CreateBatchOptions to CreateMessageBatchOptions
- Rename ServiceBusMessageBatch.TryAdd to ServiceBusMessageBatch.TryAddMessage
- Change output list type from IList to IReadOnlyList

#### New Features
- Add IAsyncEnumerable Receive overload
- Add batch schedule/cancel schedule messages

### Storage

#### Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

##### New Features
- Added support for Blob Tags, Blob Versioning, Object Replication Service, Append Seal, and Jumbo Blobs
- Added support for setting access tier on Blob Snapshots and Versions
- Added RehydratePriority to BlobProperties and BlobItemProperties

##### Key Bug Fixes
- Fixed bug where `BlobBaseClient.DownloadTo()` was throwing an exception when downloading blobs of size 0
- Fixed bug where all `BlobModelFactory.BlobProperties()` parameters were required
- Fixed bug where `BlobBaseClient.BlobName` was encoded, affecting SAS generation
- Fixed bug where AccountType enum was missing BlockBlobStorage and FileStorage

#### Blobs ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs.ChangeFeed/CHANGELOG.md)

##### New Features
- Added a preview version of this library to support change feed

#### Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

##### New Features
- Added support for Jumbo Files

#### Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

##### New Features
- Added support for Large Files and File Soft Delete

##### Key Bug Fixes
- Fixed bug where ShareDirectoryClient and ShareFileClient.Name and .Path were sometimes URL-encoded
- Fixed bug where ShareClient.WithSnapshot(), ShareDirectoryClient.WithSnapshot(), and ShareFileClient.WithSnapshot() were not functioning correctly

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#101-2020-06-23)

#### Key Bug Fixes
- The document confidence scores for analyze sentiment now contains the values the Text Analytics service returns. (Issue [#12889](https://github.com/Azure/azure-sdk-for-net/issues/12889)).

### New Management Libraries
A new set of management libraries that follow the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) and based on [Azure.Core libraries](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/core/Azure.Core) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/dotnet.html).

To get started with these new libraries, please see the [quickstart guide here](https://github.com/Azure/azure-sdk-for-net/blob/main/doc/mgmt_preview_quickstart.md). These new libraries can be identifed by namespaces that start with `Azure.ResourceManager`, e.g. `Azure.ResourceManager.Network`

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
