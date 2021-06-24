---
title: Azure SDK for C++ (February 2021)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the February 2021 client library release.

#### Beta

- Azure Core
- Azure Identity
- Azure Storage Common
- Azure Storage Blobs
- Azure Storage Files Shares
- Azure Storage Files DataLake

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
# From Vcpkg
vcpkg install azure-storage-blobs-cpp

# From Source
git clone https://github.com/Azure/azure-sdk-for-cpp
# git checkout <tag_name>
# For example:
git checkout azure-storage-blobs_12.0.0-beta.8
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

## Release highlights

### azure-core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta6-2021-02-09)

#### New Features

- Added support for HTTP conditional requests `MatchConditions` and `RequestConditions`.
- Added the `Hash` base class and MD5 hashing APIs to the `Azure::Core::Cryptography` namespace available from `azure/core/cryptography/hash.hpp`.

#### Breaking Changes

- Removed `Context::CancelWhen()`.
- Removed `LogClassification` and related functionality, added `LogLevel` instead.

#### Bug Fixes

- Fixed computation of the token expiration time in `BearerTokenAuthenticationPolicy`.
- Fixed compilation dependency issue for MacOS when consuming the SDK from VcPkg.
- Fixed support for sending requests to endpoints with a custom port within the url on Windows when using the WinHttp transport.

### azure-identity [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/identity/azure-identity/CHANGELOG.md#100-beta3-2021-02-02)

#### Breaking Changes

- `ClientSecretCredential ` constructor takes `ClientSecretCredentialOptions` struct instead of authority host string. `TokenCredentialOptions` struct has authority host string as data member.

### azure-storage-common [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-common/CHANGELOG.md#1200-beta8-2021-02-12)

#### Breaking Changes

- Removed the `Azure::Storage::Md5` class from `crypt.hpp`. Use the type from `Azure::Core::Cryptography` namespace instead, from `azure/core/cryptography/hash.hpp`.
- Renamed `Crc64` to `Crc64Hash` and change it to derive from the `Azure::Core::Cryptography::Hash` class.

### azure-storage-blobs [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-blobs/CHANGELOG.md#1200-beta8-2021-02-12)

#### Breaking Changes

- Removed `BreakBlobLeaseResult::Leasetime`.
- Moved `Azure::Core::Context` out of options bag of each API, and make it the last optional parameter.

### azure-storage-files-shares [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-shares/CHANGELOG.md#1200-beta8-2021-02-12)

#### New Features

- Changed type of `FileAttributes` to extensible enum.

#### Breaking Changes

- `ListSharesSinglePageOptions::ListSharesInclude` was renamed to `ListSharesSinglePageOptions::ListSharesIncludeFlags`.
- `DeleteShareOptions::IncludeSnapshots` was renamed to `DeleteShareOptions::DeleteSnapshots`.
- `FileShareSmbProperties` was renamed to `FileSmbProperties`.
- `DownloadShareFileOptions::GetRangeContentMd5` was renamed to `DownloadShareFileOptions::RangeHashAlgorithm`.
- `UploadFileRangeFromUriOptions::SourceContentHash` was renamed to `UploadFileRangeFromUriOptions::TransactionalContentHash`.
- `GetShareFileRangeListOptions::PrevShareSnapshot` was renamed to `GetShareFileRangeListOptions::PreviousShareSnapshot`.
- Refined `CreateShareDirectoryResult` and `CreateShareFileResult`.
- Removed `DownloadShareFileDetails::AcceptRanges`.
- Removed `GetShareFilePropertiesResult::FileType`.
- Added `RequestId` in `ForceCloseShareDirectoryHandleResult`.
- Removed `TransactionalContentHash` from `ClearShareFileRangeResult`.
- Changed API signature of `ShareFileClient::UploadRangeFromUri`.
- Renamed `ForceCloseAllHandles` to `ForceCloseAllHandlesSinglePage` and all related structs.
- Made all `ContinuationToken` in return types nullable.
- Renamed `ShareFileHttpHeaders` to `FileHttpHeaders`.
- Renamed `ShareGetPropertiesResult::AccessTierChangeTime` to `AccessTierChangedOn`.
- Renamed `ShareGetStatisticsResult::ShareUsageBytes` to `ShareUsageInBytes`.
- Renamed `ShareGetPermissionResult::Permission` to `FilePermission`.
- Grouped all file SMB properties into a struct and refined the APIs that return these properties.
- Renamed `numberOfHandlesClosed` to `NumberOfHandlesClosed` and `numberOfHandlesFailedToClose` to `NumberOfHandlesFailedToClose`.
- Renamed `FileGetRangeListResult::FileContentLength` to `FileSize`.
- Renamed `StorageServiceProperties` to `FileServiceProperties`.
- Removed `LeaseTime` in results returned by lease operations. Also removed `LeaseId` in `ShareBreakLeaseResult`.
- Moved `Azure::Core::Context` out of options bag of each API, and make it the last optional parameter.

### azure-storage-files-datalake [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-datalake/CHANGELOG.md#1200-beta8-2021-02-12)

#### Breaking Changes

- Removed `DataLakeFileSystemClient::GetPathClient`.
- Renamed `SetDataLakePathAccessControlRecursiveListSinglePageOptions::MaxEntries` to `PageSizeHint`.
- `GetDataLakePathPropertiesResult::ServerEncrypted` was renamed to `IsServerEncrypted`.
- `GetDataLakePathPropertiesResult::AccessTierInferred` was renamed to `IsAccessTierInferred`.
- `HttpHeaders` of `DownloadDataLakeFileResult` and `DownloadDataLakeFileToResult` was moved into `Details`, to align with Blob service.
- Removed `BreakDataLakeLeaseResult::LeaseTime`.
- Renamed APIs for modifying access list recursively. Used to be with pattern `AccessControlRecursiveList`, now is with pattern `AccessControlListRecursive`.
- Refined options for `ScheduleDeletion`, to be consistent with other APIs.
- Renamed `ContentLength` in `PathItem` to `FileSize`.
- In `PathSetAccessControlRecursiveResult`, `DirectoriesSuccessful` is renamed to `NumberOfSuccessfulDirectories`, `FilesSuccessful` is renamed to `NumberOfSuccessfulFiles`, `FailureCount` is renamed to `NumberOfFailures`.
- Moved `Azure::Core::Context` out of options bag of each API, and make it the last optional parameter.

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
