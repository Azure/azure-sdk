---
title: Azure SDK for .NET (March 2020)
layout: post
date: March 2020
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our March 2020 client library releases.

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

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.3

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
    $> dotnet add package Azure.Storage.Files.DataLake --version 12.0.0-preview.9
    $> dotnet add package Azure.Storage.Files.Shares
    $> dotnet add package Azure.Storage.Queues

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/CHANGELOG.md#120-preview1)
- Updating `DefaultAzureCredential` to enable authenticating through the Azure CLI
- `ClientCertificateCredential` now supports being constructed with a path to an unencrypted certificate (in either PFX or PEM format)
- `EnvironmentCredential` now supports reading a certificate path from `AZURE_CLIENT_CERTIFICATE_PATH`

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview3-2020-03-10)
- New supported entity categories have been added.
- Added `DetectLanguageInput.None` for user convenience when overriding the default behavior of `CountryHint`.

## Latest Releases

{% assign packages = site.data.releases.latest.dotnet-packages %}
{% include dotnet-packages.html %}

{% include refs.md %}
