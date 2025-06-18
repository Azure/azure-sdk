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
- Storage
- System.Text.Json support for Microsoft.Spatial

#### Updates

- Microsoft Azure ServiceBus
- Service Bus

#### Beta

- Attestation
- Authentication
- Azure Storage Blobs ChangeFeed
- Live Video Analytics on IoT Edge
- Tables


## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Data.Tables --version 3.0.0-beta.5
$> dotnet add package Azure.Media.Analytics.Edge --version 1.0.0-beta.1
$> dotnet add package Azure.Messaging.ServiceBus --version 7.0.1
$> dotnet add package Azure.MixedReality.Authentication --version 1.0.0-preview.2
$> dotnet add package Azure.Security.Attestation --version 1.0.0-beta.1
$> dotnet add package Azure.Storage.Blobs --version 12.8.0
$> dotnet add package Azure.Storage.Blobs.Batch --version 12.5.0
$> dotnet add package Azure.Storage.Blobs.ChangeFeed --version 12.0.0-preview.8
$> dotnet add package Azure.Storage.Common --version 12.7.0
$> dotnet add package Azure.Storage.Files.DataLake --version 12.6.0
$> dotnet add package Azure.Storage.Files.Shares --version 12.6.0
$> dotnet add package Azure.Storage.Queues --version 12.6.0
$> dotnet add package Microsoft.Azure.Core.NewtonsoftJson --version 1.0.0
$> dotnet add package Microsoft.Azure.Core.Spatial --version 1.0.0
$> dotnet add package Microsoft.Azure.Core.Spatial.NewtonsoftJson --version 1.0.0
$> dotnet add package Microsoft.Azure.ServiceBus --version 5.1.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Attestation [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/attestation/Azure.Security.Attestation/CHANGELOG.md)

- Initial release of Azure.Security.Attestation Beta version to support data-plane operations of Microsoft Azure Attestation.

### Authentication [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/mixedreality/Azure.MixedReality.Authentication/CHANGELOG.md#100-preview2-2021-01-12)

- Configured with shared source.

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

### Azure Storage Blobs ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Blobs.ChangeFeed/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where we couldn't handle `BlobChangeFeedEvent.EventData.ClientRequestIds` that were not GUIDs

### Azure Storage Common [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Common/CHANGELOG.md)

#### Key Bug Fixes
- Fixed bug where parsing the connection string only accept lowercase values

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.DataLake/CHANGELOG.md)

#### New Features
- GA all features in previous release.
- Added constructors taking connection string to `DataLakeServiceClient`, `DataLakeFileSystemClient`, `DataLakeDirectoryClient`, and `DataLakeFileClient`.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

#### Key Bug Fixes
- Fixed bug where the `Stream` returned by `DataLakeFileClient.OpenRead()` would return a different Length after calls to `Seek()`.
- Fixed bug where `DataLakePathClient.SetPermissions()`, `DataLakeFileClient.SetPermissions()`, and `DataLakeDirectoryClient.SetPermissions()` could not just set `Owner` or `Group`.
- Fixed bug where `DataLakeDirectoryClient` initialized with a `Uri` would throw a null exception when `GetPaths()` was called.

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Files.Shares/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.

#### Key Bug Fixes
- Fixed bug where the `Stream` returned by `ShareFileClient.OpenRead()` would return a different Length after calls to `Seek()`.

### Azure Storage Queues [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/storage/Azure.Storage.Queues/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support for `AzureSasCredential`. That allows SAS rotation for long living clients.


### Live Video Analytics on IoT Edge [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Media.Analytics.Edge_1.0.0-beta.1/sdk/mediaservices/Azure.Media.Analytics.Edge/CHANGELOG.md#100-beta1-2020-12-11)

- Initial release of Live Video Analytics on IoT Edge.

### Microsoft.Azure.ServiceBus

- Update dependency of Microsoft.Azure.Amqp to version 2.4.9.

### Newtonsoft.Json support for Azure.Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.NewtonsoftJson_1.0.0/sdk/core/Microsoft.Azure.Core.NewtonsoftJson/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.NewtonsoftJson to use Newtonsoft.Json for serialization.

### Newtonsoft.Json support for Microsoft.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.Spatial.NewtonsoftJson_1.0.0/sdk/core/Microsoft.Azure.Core.Spatial.NewtonsoftJson/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.Spatial.NewtonsoftJson to use Newtonsoft.Json to serialize supported Microsoft.Spatial types.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#701-2021-01-12)

#### Key Bug Fixes
- Fixed race condition that could occur when using the same `ServiceBusSessionReceiverOptions` instance
for several receivers.
- Increased the authorization refresh buffer to make it less likely that authorization will expire.

### System.Text.Json support for Microsoft.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.Spatial_1.0.0/sdk/core/Microsoft.Azure.Core.Spatial/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.Spatial to use `System.Text.Json` to serialize supported Microsoft.Spatial types.

### Tables [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/tables/Azure.Data.Tables/CHANGELOG.md#300-beta5-2021-01-12)

#### Key Bug Fixes
- Fixed an issue which transposed the values used for EndPartitionKey and StartRowKey in the generated Sas token Uri

#### Key Bug Fixes
- Fixed bug where the `Stream` returned by `BlobBaseClient.OpenRead()` would return a different Length after calls to `Seek()`.
- Fixed bug where `BlobBaseClient.Exists()` did not function correctly for blob encrypted with Customer Provided Key or Encryption Scope.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
