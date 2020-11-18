---
title: Azure SDK for .NET (November 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- Storage

#### Updates

- _Add packages_

#### Beta

- Event Hubs
- Key Vault Administration, Certificates, Keys, and Secrets
- Tables

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Messaging.EventHubs --version 5.3.0-beta.4
$> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.3.0-beta.4

$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.3

$> dotnet add package Azure.Security.KeyVault.Administration --version 4.0.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Certificates --version 4.2.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Keys --version 4.2.0-beta.3
$> dotnet add package Azure.Security.KeyVault.Secrets --version 4.2.0-beta.3

$> dotnet add package Azure.Storage.Blobs --version 12.7.0
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.4.0
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.6
$> dotnet add package Azure.Storage.Files.DataLake --version 12.5.0
$> dotnet add package Azure.Storage.Files.Shares --version 12.5.0
$> dotnet add package Azure.Storage.Queues --version 12.5.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md#530-beta4-2020-11-10)

This release contains a collection of minor bug fixes, performance improvements, and documentation enhancements.

#### New Features

- Connection strings can now be parsed into their key/value pairs using the `EventHubsConnectionStringProperties` class.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md#530-beta4-2020-11-10)

This release contains a collection of minor bug fixes, performance improvements, and documentation enhancements.

### Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta3-2020-11-12)

#### New Features

- Added support for Upsert batch operations.
- Added support for some numeric type coercion for TableEntity properties.
- Added TryGetFailedEntityFromException method on TablesTransactionalBatch to extract the entity that caused a batch failure from a RequestFailedException.

### Key Vault

These releases include a number of notable changes based on feedback.

#### Administration [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Administration_4.0.0-beta.3/sdk/keyvault/Azure.Security.KeyVault.Administration/CHANGELOG.md#400-beta3-2020-11-12)

- Both `BackupOperation` and `RestoreOperation` return a result containing the `Uri` instead of just the `Uri` itself for future possible expansion.
- Changed `NotActions` and `NotDataActions` to `DenyActions` and `DenyDataActions` respectively.
- Consolidated `KeyVaultAccessControlClientOptions` and `KeyVaultBackupClientOptions` into `KeyVaultAdministrationClientOptions`.

#### Certificates [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Certificates_4.2.0-beta.3/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#420-beta3-2020-11-12)

- Documentation improvements.

#### Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Keys_4.2.0-beta.3/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#420-beta3-2020-11-12)

- Added support for "oct-HSM" for Managed HSM.
- Added support for AES-CBC and AES-GCM - locally when possible on the client.
- Added support for key export on Managed HSM, including early preview support for Secure Key Release.

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added ability to get parent `BlobContainerClient` from `BlobBaseClient` and to get parent `BlobServiceClient` from `BlobContainerClient`.
- Added seekability to `BaseBlobClient.OpenRead()`.
- Added additional info to exception messages.
- Added ability to set Position on streams created with `BlobBaseClient.OpenRead()`.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `BlobBaseClient`, `BlobClient`, `BlockBlobClient`, `AppendBlobClient`, `PageBlobClient` and `BlobContainerClient`.
- Added CanAccountGenerateSasUri property and `GenerateAccountSasUri()` to `BlobServiceClient`.
- Restored single upload threshold for parallel uploads from 5 TB to 256 MB.

#### Key Bug Fixes
- Fixed bug where Blobs SDK couldn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.
- Fixed bug where `BlobContainerClient.SetAccessPolicy()` would throw an exception if signed identifier permissions were not in the correct order.

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added additional info to exception messages.
- Added `DataLakeDirectoryClient.GetPaths()`.
- Added ability to set Position on streams created with `DataLakeFileClient.OpenRead()`.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `DataLakePathClient`, `DataLakeFileClient`, `DataLakeDirectoryClient` and `DataLakeFileSystemClient`.
- Added CanGenerateAccountSasUri property and `GenerateAccountSasUri()` to `DataLakeServiceClient`.
- Restored single upload threshold for parallel uploads from 5 TB to 256 MB.

#### Key Bug Fixes
- Fixed bug where `DataLakeFileSystem.SetAccessPolicy()` would throw an exception if signed identifier permissions were not in the correct order.
- Fixed bug where DataLake SDK couldn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Renamed `ShareClient.SetTier()` -> `ShareClient.SetProperties()`. `SetProperties()` can be used to set both Share Tier and Share Quota.
- Changed `ShareDeleteOptions.IncludeSnapshots` -> `.ShareSnapshotsDeleteOption`, and added option to also delete Share Snapshots that have been leased.
- Added additional info to exception messages.
- Removed ability to create a `ShareLeaseClient` for a Share or Share Snapshot. This feature has been rescheduled for future release.
- Added ability to set Position on streams created with `ShareFileClient.OpenRead()`.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `ShareFileClient`, `ShareDirectoryClient` and `ShareClient`.
- Added CanGenerateSasUri property and` GenerateAccountSasUri()` to `ShareServiceClient`.
- Changed default constructor for FileSmbProperties from internal to public.

#### Key Bug Fixes
- Fixed bug where `ShareDirectoryClient.Exists()`, `.DeleteIfExists()` and `ShareFileClient.Exists()`, `.DeleteIfExists()` would thrown an exception when the directory or file's parent directory didn't exist.
- Fixed bug where File Share SDK coudn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added CanGenerateSasUri property and `GenerateSasUri()` to `QueueClient`.
- Added CanGenerateAccountSasUri property and `GenerateAccountSasUri()` to `QueueServiceClient`.

#### Key Bug Fixes
- Fixed a bug where `QueueServiceClient.SetProperties` and `QueueService.GetProperties` where the creating/parsing XML Service Queue Properties CorsRules incorrectly causing Invalid XML Errors
- Fixed bug where Queues SDK coudn't handle SASs with start and expiry time in format other than yyyy-MM-ddTHH:mm:ssZ.


## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
