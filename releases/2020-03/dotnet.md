---
title: Azure SDK for .NET (March 2020)
layout: post
date: 2020-03-17
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our March 2020 client library releases.

#### GA

- Event Hubs

#### Updates

- Core
- Key Vault (Certificates, Keys, Secrets)
- Storage (Blobs, Blobs Batch, Queues, File Shares, DataLake)

#### Preview

- Key Vault (Certificates, Keys, Secrets)
- Text Analytics
- Search

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.3

    $> dotnet add package Azure.Cosmos --version 4.0.0-preview

    $> dotnet add package Azure.Data.AppConfiguration

    $> dotnet add package Azure.Identity

    $> dotnet add package Azure.Messaging.EventHubs
    $> dotnet add package Azure.Messaging.EventHubs.Processor

    $> dotnet add package Azure.Search --version 11.0.0-preview.1

    $> dotnet add package Azure.Security.KeyVault.Certificates
    $> dotnet add package Azure.Security.KeyVault.Key
    $> dotnet add package Azure.Security.KeyVault.Secrets

    $> dotnet add package Azure.Storage.Blobs
    $> dotnet add package Azure.Storage.Blobs.Batch
    $> dotnet add package Azure.Storage.Files.DataLake
    $> dotnet add package Azure.Storage.Files.Shares
    $> dotnet add package Azure.Storage.Queues

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core

- Add OPTIONS and TRACE HTTP request methods.
- Add `NetworkTimeout` property to `RetryOptions` and apply it to network operations like sending request or reading from the response stream.
- Implement serialization for RequestFailedException.

### Azure Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#120-preview1)

- Updating `DefaultAzureCredential` to enable authenticating through the Azure CLI
- `ClientCertificateCredential` now supports being constructed with a path to an unencrypted certificate (in either PFX or PEM format)
- `EnvironmentCredential` now supports reading a certificate path from `AZURE_CLIENT_CERTIFICATE_PATH`

### Azure Key Vault

#### 4.1.0-preview.1

- Add `RecoverableDays` property to properties.
- Add "import" value to `KeyOperation` enumeration.
- See changelogs for details:
  - [Certificates](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#410-preview1-2020-03-09)
  - [Keys](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#410-preview1-2020-03-09)
  - [Secrets](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#410-preview1-2020-03-09)

#### Certificates 4.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#401-2020-03-03)

- Fix certificate import and merge issues.
- Shorten diagnostic scope names.
- Sanitize header values in exceptions.

### Keys 4.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#402-2020-03-03)

- Shorten diagnostic scope names.
- Sanitize header values in exceptions.

#### Secrets 4.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#402-2020-03-03)

- Fix diagnostic bug for `SecretClient.PurgeDeletedSecret`.
- Shorten diagnostic scope names.
- Sanitize header values in exceptions.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview3-2020-03-10)

- New supported entity categories have been added.
- Added `DetectLanguageInput.None` for user convenience when overriding the default behavior of `CountryHint`.

#### Search

- Initial preview of the Azure.Search client library enabling you to query and
  update documents in search indexes.

### Azure Storage

#### Files DataLake [Changelog](https://www.nuget.org/packages/Azure.Storage.Files.DataLake/)

- This library is now Generally Available.


## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
