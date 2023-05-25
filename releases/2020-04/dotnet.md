---
title: Azure SDK for .NET (April 2020)
layout: post
date: 2020-04-14
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our April 2020 client library releases.

#### Updates

- Core
- Key Vault
- Storage

#### Preview

- Event Hubs
- Form Recognizer
- Identity
- Search
- Service Bus
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.FormRecognizer --version 1.0.0-preview.1

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.4

    $> dotnet add package Azure.Identity --version 1.2.0-preview.2

    $> dotnet add package Azure.Messaging.EventHubs --version 5.1.0-preview.1
    $> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.1.0-preview.1

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

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/CHANGELOG.md)

- `AzureKeyCredential` and its respective policy.
- Response trace messages are properly identified.
- Content type "application/x-www-form-urlencoded" is decoded in trace messages.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#100-preview1-04-23-2020)

- The first preview Azure Form Recognizer client library that follows the [.NET Azure SDK Design Guidelines](https://azure.github.io/azure-sdk/dotnet_introduction.html).
- This library replaces the package [`Microsoft.Azure.CognitiveServices.FormRecognizer`](https://www.nuget.org/packages/Microsoft.Azure.CognitiveServices.FormRecognizer/0.8.0-preview).
- This library supports only the Form Recognizer Service v2.0-preview API.
- Two client design:
  - `FormRecognizerClient` to recognize and extract fields/values on custom forms, receipts, and form content/layout.
  - `FormTrainingClient` to train custom models, and manage the custom models on your resource account.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#120-preview2)
- Updates `DefaultAzureCredential` to enable authenticating through Visual Studio and Visual Studio Code.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- A new primitive, `EventProcessor<TPartition>`, has been implemented to serve as an extensibility point for creating a custom event processor instance.  More detail can be found in the [design proposal](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.2.0-preview.1/sdk/eventhub/Azure.Messaging.EventHubs/design/event-processor%7BT%7D-proposal.md).

- A new primitive, `PartitionProcessor`, has been implemented to serve as a low-level means of reading batches of events from a single partition with greater control over network configuration.  More detail can be found in the [design proposal](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Messaging.EventHubs_5.2.0-preview.1/sdk/eventhub/Azure.Messaging.EventHubs/design/partition-receiver-proposal.md).

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- The `EventProcessorClient` has been enhanced to derive from the new `EventProcessor<TPartition>` primitive, brining improvements to stability, resilience, and performance.

### Key Vault Certificates [Changelog][keyvault-certificates], Keys [Changelog][keyvault-keys], and Secrets [Changelog][keyvault-secrets]

- Fixed concurrency issue in our challenge-based authentication policy ([#9737](https://github.com/Azure/azure-sdk-for-net/issues/9737))

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md)

- Renamed to `Azure.Search.Documents` (assembly, namespace, and package)
- Added support for creating and managing Search Indexes

### Storage

#### Azure Storage Blob [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)
- The new 12.4.1 release contains various bug fixes and improvements to the library

#### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)
- Added `PathProperties.IsDirectory`
- Fixed bugs where exceptions were thrown

#### Azure Storage Common [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Common/CHANGELOG.md)
- This release contains bug fixes to improve quality

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md)

- Initial preview of the Azure.Messaging.ServiceBus library enabling you to send/receive/settle messages from queues/topics and session support.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview4-2020-04-07)

- Remove the `RecognizePiiEntities` endpoint and all related models.
- Add mock support for the Text Analytics client with respective samples.
- Add integration for ASP.NET Core.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}

  [keyvault-certificates]: https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Certificates_4.0.2/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#402-2020-03-18
  [keyvault-keys]: https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Keys_4.0.3/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#403-2020-03-18
  [keyvault-secrets]: https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Secrets_4.0.3/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#403-2020-03-18
