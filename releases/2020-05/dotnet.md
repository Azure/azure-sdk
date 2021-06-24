---
title: Azure SDK for .NET (May 2020)
layout: post
date: 2020-05-01
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our {{ page.date | date: "%B %Y" }} client library releases.

#### GA

- Core
- Event Hubs

#### Updates

#### Preview

- Form Recognizer
- Search
- Service Bus

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.FormRecognizer --version 1.0.0-preview.2

    $> dotnet add package Azure.Identity --version 1.2.0-preview.3

    $> dotnet add package Azure.Messaging.EventHubs
    $> dotnet add package Azure.Messaging.EventHubs.Processor

    $> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.2

    $> dotnet add package Azure.Search.Documents --version 1.0.0-preview.3

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/CHANGELOG.md)

- Read client request ID value used for logging and tracing off the initial request object if available.
- Fixed a bug when using Azure.Core based libraries in Blazor WebAssembly apps.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- The set of features from v5.1.0-preview.1 are now generally available.  This includes the `EventProcessor<TPartition>` and `PartitionReceiver` types which focus on advanced application scenarios which require greater low-level control.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- The set of features from v5.1.0-preview.1 are now generally available.  This includes the enhancements to the `EventProcessorClient` for improved stability, resilience, and performance.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#100-preview2-05-06-2020)

- All of `FormRecognizerClient`'s `FormRecognizerClientOptions` are now passed to the client returned by
`FormRecognizerClient.GetFormTrainingClient`.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#120-preview3)

- New API allowing applications to control when `DeviceCodeCredential` and `InteractiveBrowserCredential` prompt for authentication.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md)

- Renamed `SearchIndexClient` to `SearchClient` and renamed numerous models for search index creation.
- Simplified the use of e-tags.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview2-2020-05-04)

- Allow specifying a list of named sessions when using ServiceBusSessionProcessor.
- Transactions/Send via support.
- Add SessionInitializingAsync/SessionClosingAsync events in ServiceBusSessionProcessor.
- Do not attempt to autocomplete messages with the processor if the user settled the message in their callback.
- Add SendAsync overload accepting an IEnumerable of ServiceBusMessage.

### DateProtection Blob Extensions [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.DataProtection.Blobs_1.0.0-preview.2/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Blobs/CHANGELOG.md)

- Package renamed to Azure.Extensions.AspNetCore.DataProtection.Blobs

### DateProtection Keys Extensions [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.DataProtection.Blobs_1.0.0-preview.2/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Keys/CHANGELOG.md)

- Package renamed to Azure.Extensions.AspNetCore.DataProtection.Keys
- Default overload of ProtectKeysWithAzureKeyVault now takes a Uri to be consistent with other extension methods and KeyVault clients.

### Configuration Secrets Extensions [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.Configuration.Secrets_1.0.0-preview.2/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Blobs/CHANGELOG.md)

- Package renamed to Azure.Extensions.AspNetCore.DataProtection.Blobs



## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
