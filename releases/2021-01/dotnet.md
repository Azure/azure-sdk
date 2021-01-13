---
title: Azure SDK for .NET (January 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our January 2021 client library releases.

#### GA

- Newtonsoft.Json support for Azure.Core
- Newtonsoft.Json support for Microsoft.Spatial
- System.Text.Json support for Microsoft.Spatial
- Storage

#### Updates

- _Add packages_

#### Beta

- Azure.Storage.Blobs.ChangeFeed

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Microsoft.Azure.Core.NewtonsoftJson --version 1.0.0
$> dotnet add package Microsoft.Azure.Core.Spatial --version 1.0.0
$> dotnet add package Microsoft.Azure.Core.Spatial.NewtonsoftJson --version 1.0.0

$> dotnet add package Azure.Storage.Blobs --version 12.8.0
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.5.0
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.8
$> dotnet add package Azure.Storage.Common --version 12.7.0
$> dotnet add package Azure.Storage.Files.DataLake --version 12.6.0
$> dotnet add package Azure.Storage.Files.Shares --version 12.6.0
$> dotnet add package Azure.Storage.Queues --version 12.6.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Newtonsoft.Json support for Azure.Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.NewtonsoftJson_1.0.0/sdk/core/Microsoft.Azure.Core.NewtonsoftJson/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.NewtonsoftJson to use Newtonsoft.Json for serialization.

### Newtonsoft.Json support for Microsoft.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.Spatial.NewtonsoftJson_1.0.0/sdk/core/Microsoft.Azure.Core.Spatial.NewtonsoftJson/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.Spatial.NewtonsoftJson to use Newtonsoft.Json to serialize supported Microsoft.Spatial types.

### System.Text.Json support for Microsoft.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.Spatial_1.0.0/sdk/core/Microsoft.Azure.Core.Spatial/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.Spatial to use `System.Text.Json` to serialize supported Microsoft.Spatial types.

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

#### Key Bug Fixes
- Fixed bug where the `Stream` returned by `BlobBaseClient.OpenRead()` would return a different Length after calls to `Seek()`.
- Fixed bug where `BlobBaseClient.Exists()` did not function correctly for blob encrypted with Customer Provided Key or Encryption Scope.

### Azure Storage Blobs ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs.ChangeFeed/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where we couldn't handle `BlobChangeFeedEvent.EventData.ClientRequestIds` that were not GUIDs

### Azure Storage Common [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Common/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where parsing the connection string only accept lowercase values

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added constructors taking connection string to `DataLakeServiceClient`, `DataLakeFileSystemClient`, `DataLakeDirectoryClient`, and `DataLakeFileClient`.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

#### Key Bug Fixes
- Fixed bug where the `Stream` returned by `DataLakeFileClient.OpenRead()` would return a different Length after calls to `Seek()`.
- Fixed bug where `DataLakePathClient.SetPermissions()`, `DataLakeFileClient.SetPermissions()`, and `DataLakeDirectoryClient.SetPermissions()` could not just set `Owner` or `Group`.
- Fixed bug where `DataLakeDirectoryClient` initialized with a `Uri` would throw a null exception when `GetPaths()` was called.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

#### Key Bug Fixes
- Fixed bug where the `Stream` returned by `ShareFileClient.OpenRead()` would return a different Length after calls to `Seek()`.

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
