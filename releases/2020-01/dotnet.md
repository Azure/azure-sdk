---
title: Azure SDK for .NET (January 2020)
layout: post
date: January 2020
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our January 2020 client library releases.

#### GA

- Key Vault (Certificates)

#### Updates

- Key Vault (Keys, Secrets)

#### Preview

- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.1

    $> dotnet add package Azure.Cosmos --version 4.0.0-preview

    $> dotnet add package Azure.Data.AppConfiguration --version 1.0.0-preview.4

    $> dotnet add package Azure.Identity

    $> dotnet add package Azure.Messaging.EventHubs --version 5.0.0-preview.6

    $> dotnet add package Azure.Security.KeyVault.Certificates
    $> dotnet add package Azure.Security.KeyVault.Key
    $> dotnet add package Azure.Security.KeyVault.Secrets

    $> dotnet add package Azure.Storage.Blobs
    $> dotnet add package Azure.Storage.Blobs.Batch
    $> dotnet add package Azure.Storage.Files.DataLake --version 12.0.0-preview.7
    $> dotnet add package Azure.Storage.Files.Shares
    $> dotnet add package Azure.Storage.Queues

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Key Vault

- Challenge-based authentication requests are only sent over HTTPS.

### Text Analytics

- This library supports only the Text Analytics Service v3.0-preview.1 API.  The previous `Microsoft.Azure.CognitiveServices.Language.TextAnalytics` library supported only earlier service versions.
- The namespace/package name for Azure Text Analytics client library has changed from `Microsoft.Azure.CognitiveServices.Language.TextAnalytics` to `Azure.AI.TextAnalytics`
- Added support for:
  - Subscription key and AAD authentication for both synchronous and asynchronous clients.
  - Detect Language.
  - Separation of Entity Recognition and Entity Linking.
  - Identification of Personally Identifiable Information.
  - Analyze Sentiment APIs including analysis for mixed sentiment.

## Quick Links

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
