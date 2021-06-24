---
title: Azure SDK for .NET (February 2020)
layout: post
date: 2020-02-11
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our February 2020 client library releases.

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

    $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.2

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

### Azure.Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/CHANGELOG.md#102)

- Block bearer token authentication for non TLS protected endpoints.
- Add support for retrying on request timeouts.
- Add support for retrying on 408, 500, 502, 504 status codes.
- Remove commit hash from User-Agent telemetry.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#111)
- `ManagedIdentityCredential` now throws `CredentailUnavailableException` when the service returns a 400 status code, indicating an identity has not been assigned
- Updated error messaging from `DefaultAzureCredential` to more easily root cause failures

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview2-2020-02-11)

- Added the ability to create a Text Analytics client with a credential that can be updated in long-lived clients.
- Collection objects include a `HasError` property that allows to check if an operation on a particular document succeeded or failed.
- All batch overload methods have been renamed by adding the suffix `Batch` or `BatchAsync` accordingly.
- All single text operation methods now return an atomic type of the operation result.

### Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)
- Modified BlockBlobClient.Upload() and BlockBlobClient.UploadAsync() to support parallel and multi-part uploads.
- Added support for Encryption Scopes.

### Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)
- Added DataLakeFileClient.ReadTo() and DataLakeFileClient.ReadToAsync() APIs, providing support for parallel downloads to Stream and Files.
- Added progress reporting to DataLakeFileClient.Append() and DataLakeFileClient.AppendAsync().
- Added DataLakeFileSystemClient.GetRootDirectoryClient().
- Renamed LeaseDurationType, LeaseState, and LeaseStatus to DataLakeLeaseDuration, DataLakeLeaseState, and DataLakeLeaseStatus.

### Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)
- Added ShareFileClient.ClearRangesAsync() API.
- Added SMB parameters to File Copy APIs.
- Added support for file leases.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
