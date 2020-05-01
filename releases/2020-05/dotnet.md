---
title: Azure SDK for .NET (May 2020)
layout: post
date: 2020-05-01
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our {{ page.date | date: "%B %Y" }} client library releases.

#### Updates

#### Preview

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.FormRecognizer --version 1.0.0-preview.1

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.4

    $> dotnet add package Azure.Identity --version 1.2.0-preview.2

    $> dotnet add package Azure.Messaging.EventHubs
    $> dotnet add package Azure.Messaging.EventHubs.Processor

    $> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.1

    $> dotnet add package Azure.Search.Documents --version 1.0.0-preview.2

    $> dotnet add package Azure.Security.KeyVault.Certificates --version 4.0.2
    $> dotnet add package Azure.Security.KeyVault.Keys --version 4.0.3
    $> dotnet add package Azure.Security.KeyVault.Secrets --version 4.0.3

    $> dotnet add package Azure.Storage.Blobs
    $> dotnet add package Azure.Storage.Common
    $> dotnet add package Azure.Storage.Files.DataLake

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/CHANGELOG.md)

- Read client request ID value used for logging and tracing off the initial request object if available.
- Fixed a bug when using Azure.Core based libraries in Blazor WebAssembly apps.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- The set of features from v5.1.0-preview.1 are now generally available.  This includes the `EventProcessor<TPartition>` and `PartitionReceiver` types which focus on advanced application scenarios which require greater low-level control. 

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- The set of features from v5.1.0-preview.1 are now generally available.  This includes the enhancements to the `EventProcessorClient` for improved stability, resilience, and performance.

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
