---
title: Azure SDK for .NET (January 2020)
layout: post
date: 2020-01-13
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our January 2020 client library releases.

#### GA

- Event Hubs
- Key Vault (Certificates)

#### Updates

- Key Vault (Keys, Secrets)
- Storage (Blobs, Blobs Batch, Queues, File Shares, DataLake)

#### Preview

- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.1

    $> dotnet add package Azure.Cosmos --version 4.0.0-preview

    $> dotnet add package Azure.Data.AppConfiguration

    $> dotnet add package Azure.Identity

    $> dotnet add package Azure.Messaging.EventHubs
    $> dotnet add package Azure.Messaging.EventHubs.Processor

    $> dotnet add package Azure.Security.KeyVault.Certificates
    $> dotnet add package Azure.Security.KeyVault.Key
    $> dotnet add package Azure.Security.KeyVault.Secrets

    $> dotnet add package Azure.Storage.Blobs
    $> dotnet add package Azure.Storage.Blobs.Batch
    $> dotnet add package Azure.Storage.Files.DataLake --version 12.0.0-preview.8
    $> dotnet add package Azure.Storage.Files.Shares
    $> dotnet add package Azure.Storage.Queues

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Event Hubs

- Namespaces have been reorganized to align types to their functional area. Cross-functional types have been left in the root namespace while specialized types were moved to the Producer, Consumer, or Processor namespaces.

- The hierarchy of custom exceptions has been flattened, with only the EventHubsException remaining. The well-known failure scenarios that had previously been represented as stand-alone types are now exposed by the `Reason` property.  Please see the [Event Hubs README](https://github.com/Azure/azure-sdk-for-net/tree/main/sdk/eventhub/Azure.Messaging.EventHubs#event-hubs-exception) for details.

### Key Vault

- Challenge-based authentication requests are only sent over HTTPS.

### Storage

- Added Exists API to BlobBaseClient and BlobContainerClient
- Fixed SAS related bugs
- Fixed progress reporting for parallel uploads
- Fixed issue where certain query parameters were not being logged for DataLake.

### Text Analytics

- This library supports only the Text Analytics Service v3.0-preview.1 API.  The previous `Microsoft.Azure.CognitiveServices.Language.TextAnalytics` library supported only earlier service versions.
- The namespace/package name for Azure Text Analytics client library has changed from `Microsoft.Azure.CognitiveServices.Language.TextAnalytics` to `Azure.AI.TextAnalytics`
- Added support for:
  - Subscription key and AAD authentication for both synchronous and asynchronous clients.
  - Detect Language.
  - Separation of Entity Recognition and Entity Linking.
  - Identification of Personally Identifiable Information.
  - Analyze Sentiment APIs including analysis for mixed sentiment.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
