---
title: Azure SDK for .NET (July 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our July 2020 client library releases.

#### GA

- Text Analytics

#### Updates

- _Add packages_

#### Preview

- Event Hubs
- Form Recognizer
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
 
 $> dotnet add package Azure.Messaging.EventHubs --version 5.2.0-preview.1
 $> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.2.0-preview.1

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

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- The `EventHubConsumerClient` now supports configuring the `PrefetchCount` and `CacheEventCount` for more control over performance tuning.

- The `EventProcessor<TPartition>` now supports configuring a `LoadBalancingStrategy` for more control over performance tuning.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- The `EventProcessorClient` now supports configuring the `PrefetchCount`, `CacheEventCount`, and `LoadBalancingStrategy` for more control over performance tuning.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#100-preview4-2020-07-07)

#### Breaking Changes
- `RecognizedReceipt` and `RecognizedReceiptsCollection` classes removed. Receipt field values must now be obtained from a `RecognizedForm`.
- Model and property renamings detailed in the Changelog.

### New Management Libraries
A new set of management libraries that follow the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) and based on [Azure.Core libraries](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core/Azure.Core) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/dotnet.html).

To get started with these new libraries, please see the [quickstart guide here](https://github.com/Azure/azure-sdk-for-net/blob/master/doc/mgmt_preview_quickstart.md). These new libraries can be identifed by namespaces that start with `Azure.ResourceManager`, e.g. `Azure.ResourceManager.Network`

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#101-2020-06-23)

#### Key Bug Fixes
- The document confidence scores for analyze sentiment now contains the values the Text Analytics service returns. (Issue [#12889](https://github.com/Azure/azure-sdk-for-net/issues/12889)).

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
