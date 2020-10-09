---
title: Azure SDK for .NET (October 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Event Hubs
<<<<<<< HEAD
- Key Vault
=======
>>>>>>> 1cee149a4111c2253a85da722877aa5bfa5fd4d3
- Storage
- Tables

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.2

$> dotnet add package Azure.Messaging.EventHubs --version 5.3.0-beta.3
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.0-beta.3

<<<<<<< HEAD
$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.2
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.2
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.2
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.2

=======
>>>>>>> 1cee149a4111c2253a85da722877aa5bfa5fd4d3
$> dotnet add package Azure.Storage.Blobs --version 12.7.0-preview.1
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.4.0-preview.1
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.5
$> dotnet add package Azure.Storage.Files.DataLake --version 12.5.0-preview.1
$> dotnet add package Azure.Storage.Files.Shares --version 12.5.0-preview.1
$> dotnet add package Azure.Storage.Queues --version 12.5.0-preview.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure.Data.Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta2-2020-10-06)

#### New Features

- Implemented batch operations.
- `TableClient`'s `GetEntity` method now exposes the `select` query option to allow for more efficient existence checks for a table entity.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features

- `EventData` has been integrated with the new Schema Registry service, via use of the `SchemaRegistryAvroObjectSerializer` with the `BodyAsBinaryData` member.

- The `EventHubProducerClient` now offers the ability to opt-into idempotent publishing, reducing the potential for duplication when a publishing operation encounters timeouts or other transient failures.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features

- `EventData` has been integrated with the new Schema Registry service, via use of the `SchemaRegistryAvroObjectSerializer` with the `BodyAsBinaryData` member.

<<<<<<< HEAD

### Key Vault

- Bug fixes and performance improvements.

=======
>>>>>>> 1cee149a4111c2253a85da722877aa5bfa5fd4d3
### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- Added support for Container Soft Delete.
- Added support for Blob Query Arrow output format.
- Added support for Blob Last Access Time tracking.

#### Key Bug Fixes
- Fixed bug causing `BlobAccessPolicy.StartsOn` and `.ExpiresOn` to crash the process.
- Fixed bug in where Stream returned from `AppendBlobClient.OpenWrite()`, `BlockBlobClient.OpenWrite()`, and `PageBlobClient.OpenWrite()` did not flush while disposing preventing compatibility with using keyword.
- Fixed bug where Listing Blobs with `BlobTraits.Metadata` would return `BlobItems` with null metadata instead of an empty dictionary if no metadata was present.

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### New Features
- Added support for Directory SAS.
- Added support for File Set Expiry.
- Added `Close` and `RetainUncommitedData` to `DataLakeFileUploadOptions`
- Added seekability to `DataLakeFileClient.OpenRead()`
- Added `DataLakeClientBuilderExtensions`

#### Key Bug Fixes
- Fixed bug where `DataLakeFileClient.Upload()` could not upload read-only files.
- Fixed bug causing `DataLakeBlobAccessPolicy.StartsOn` and `.ExpiresOn` to crash the process.
- Fixed bug where Stream returned from `DataLakeFileClient.OpenWrite()` did not flush while disposing preventing compatibility with using keyword.
- Fixed bug where `DataLakeDirectoryClient.Rename()` and `DataLakeDirectoryFileClient.Rename()` couldn't handle source paths with special characters.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- Added support for 4 TB Files
- Added support for SMB Multichannel
- Added support for Share and Share Snapshot Leases
- Added support for Get File Range Diff
- Added support for Set Share Tier

#### Key Bug Fixes
- Fixed bug causing `ShareAccessPolicy.StartsOn` and `.ExpiresOn` to crash the process.
- Fixed bug where Stream returned from `ShareFileClient.OpenWrite()` did not flush while disposing preventing compatibility with using keyword.


## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
