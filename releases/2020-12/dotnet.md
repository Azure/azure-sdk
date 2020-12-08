---
title: Azure SDK for .NET (December 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our December 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Storage

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Storage.Blobs --version 12.8.0-beta.1
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.5.0-beta.1
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.7
$> dotnet add package Azure.Storage.Common --version 12.7.0-beta.1
$> dotnet add package Azure.Storage.Files.DataLake --version 12.6.0-beta.1
$> dotnet add package Azure.Storage.Files.Shares --version 12.6.0-beta.1
$> dotnet add package Azure.Storage.Queues --version 12.6.0-beta.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- Added support for Lease Id for `SetBlobTags()` and `GetBlobTags()` supported in storage service version 2020-04-08.
- Added support for `BlockBlobClient.SyncUploadFromUri()` supported in storage service version 2020-04-08.
- Added `Tags` to `TaggedBlobItem` supported in storage service version 2020-04-08.
- Added `IsHierarchicalNamespaceEnabled` to `AccountInfo`.

#### Key Bug Fixes
- Fixed bug where `BlobContainerClient.GetBlobClient()`, `BlobContainerClient.GetParentServiceClient()`, `BlobServiceClient.GetBlobContainerClient()`, `BlobBaseClient.WithClientSideEncryptionOptions()`, `BlobBaseClient.GetParentBlobContainerClient()`, `BlobBaseClient.WithSnapshot()` and `BlobBaseClient.WithVersion()` created clients that could not generate a SAS from clients that could generate a SAS

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where `DataLakeServiceClient.GetFileSystemClient()`, `DataLakeFileSystemClient.GetFileClient()`, `DataLakeFileSystemClient.GetDirectoryClient()`,
`DataLakeDirectoryClient.GetSubDirectoryClient()` and `DataLakeFileClient.GetFileClient()` created clients that could not generate a SAS from clients that could generate a SAS.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- Added support for Share Enable Protocol (`ShareCreateOptions.Protocols`, `ShareProperties.Protocols`) supported in storage service version 2020-04-08.
- Added support for Share Squash Root (`ShareCreateOptions.RootSquash`, `ShareProperties.RootSquash`,`ShareSetPropertiesOptions.RootSquash`) supported in storage service version 2020-04-08.

#### Key Bug Fixes
- Fixed bug where `ShareServiceClient.GetShareClient()`, `ShareClient.GetDirectoryClient()`, `ShareClient.GetRootDirectoryClient()`, `ShareClient.WithSnapshot()`, `ShareDirectoryClient.GetSubDirectoryClient()` and `ShareDirectoryClient.GetFileClient()` created clients that could not generate a SAS from clients that could generate a SAS

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where `QueueServiceClient.GetQueueClient()` and `QueueClient.WithClientSideEncryptionOptions()` created clients that could not generate a SAS from clients that could generate a SAS

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
