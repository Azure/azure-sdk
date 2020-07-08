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

- _Add packages_

#### Preview

- Event Hubs
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
 $> dotnet add package Azure.AI.TextAnalytics

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

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/CHANGELOG.md#130-2020-07-02)

#### New features
- `HttpPipeline.CreateClientRequestIdScope` method to allow setting client request id on outgoing requests.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- The `EventHubConsumerClient` now supports configuring the `PrefetchCount` and `CacheEventCount` for more control over performance tuning.

- The `EventProcessor<TPartition>` now supports configuring a `LoadBalancingStrategy` for more control over performance tuning.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- The `EventProcessorClient` now supports configuring the `PrefetchCount`, `CacheEventCount`, and `LoadBalancingStrategy` for more control over performance tuning.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/search/Azure.Search.Documents/CHANGELOG.md#1100-2020-07-07)

#### Breaking Changes
- Removed `Azure.Core.Experimental` reference and features until they're moved
  into `Azure.Core`.
- Removed `SearchServiceCounters.SkillsetCounter` and `new SearchOptions(string continuationToken)`.

#### New Features
- Changed version to 11.0.0.
- Replaced `SearchClientOptions.ServiceVersion.V2019_05_06_Preview` with `SearchClientOptions.ServiceVersion.V2020_06_30`.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview4-2020-07-07)

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

#### Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)
- Added support for Blob Tags, Blob Versioning, Object Replication Service, Append Seal, Jumbo Blobs, and more
- Fixed a variety of bugs to improve the experience of using this library

#### Blobs ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs.ChangeFeed/CHANGELOG.md)
- Added a preview version of this library to support change feed

#### Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)
- Added support for Jumbo Files
- Fixed a variety of bugs to improve the experience of using this library

#### Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)
- Added support for Large Files and File Soft Delete
- Fixed a variety of bugs to improve the experience of using this library

#### Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#101-2020-06-23)

#### Key Bug Fixes
- The document confidence scores for analyze sentiment now contains the values the Text Analytics service returns. (Issue [#12889](https://github.com/Azure/azure-sdk-for-net/issues/12889)).

### New Management Libraries
A new set of management libraries that follow the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) and based on [Azure.Core libraries](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core/Azure.Core) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/dotnet.html).

To get started with these new libraries, please see the [quickstart guide here](https://github.com/Azure/azure-sdk-for-net/blob/master/doc/mgmt_preview_quickstart.md). These new libraries can be identifed by namespaces that start with `Azure.ResourceManager`, e.g. `Azure.ResourceManager.Network`

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
