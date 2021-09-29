---
title: Azure SDK for C++ (January 2021)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the January 2021 client library release.

#### Beta

- Azure Core
- Azure Identity
- Azure Storage Common
- Azure Storage Blobs
- Azure Storage Files DataLake
- Azure Storage Files Shares

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-cpp

# git checkout <tag_name>
# For example:
git checkout azure-storage-blobs_12.0.0-beta.6
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

## Release highlights

### azure-core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta4-2021-01-13)

#### New Features

- Added a WinHTTP-based `HttpTransport` called `WinHttpTransport` and use that as the default `TransportPolicyOptions.Transport` on Windows when sending and receiving requests and responses over the wire.
- Added `Range` type to `Azure::Core::Http` namespace.
- Added support for long-running operations with `Operation<T>`.
- Added support for setting a custom transport adapter by implementing the method `std::shared_ptr<HttpTransport> ::AzureSdkGetCustomHttpTransport()`.
- Added interoperability between `std::chrono::system_clock` types and `DateTime`.
- Added default constructor to `DateTime` and support for dates since 0001.
- Added Base64 encoding and decoding utility APIs to the `Azure::Core` namespace available from `azure/core/base64.hpp`.
- Added `Http::Response<void>` template specialization.
- Added `GetHeadersAsString()` on the `Azure::Core::Http::Request` class.
- Added a `platform.hpp` header file for defining commonly used OS-specific `#define` constants.
- Added `IsCancelled()` on the `Azure::Core::Context` class.

#### Breaking Changes

- Removed `DateTime::operator Duration()`, `DateTime::Duration` typedef and `DateTime::Now()`.
- Moved `Azure::Core::BearerTokenAuthenticationPolicy`, defined in `azure/core/credentials.hpp` to `Azure::Core::Http` namespace in `azure/core/http/policy.hpp` header.
- Changed type of `Token::ExpiresOn` to `DateTime`.
- Renamed exception `OperationCanceledException` to `OperationCancelledException` and `ThrowIfCanceled()` to `ThrowIfCancelled()` on the `Context` class.
- Moved `Azure::Core::Version`, defined in `azure/core/version.hpp` to the `Azure::Core::Details` namespace.
- Changed `Azure::Core::AuthenticationException` to derive from `std::exception` instead of `std::runtime_error`.
- Changed the `BodyStream::Read` API from being a pure virtual function to non-virtual.
- Removed `CurlConnection`, `CurlConnectionPool`, `CurlSession`, and `CurlNetworkConnection` by making headers meant as implementation, private.
- Removed option `AllowBeast` from `CurlTransportSSLOptions` in `CurlTransportOptions`.
- Changed default option `NoRevoke` from `CurlTransportSSLOptions` for the `CurlTransportOptions` to `true`. This disables the revocation list checking by default.

#### Bug Fixes

- Fixed the Curl transport adapter connection pooling when setting options.
- Fixed setting up the default transport adapter.
- Fixed linker error of missing pthread on Linux.
- Initialize class data members to avoid MSVC warning.
- Throw `Azure::Core::Http::TransportException` if `curl_easy_init()` returns a null handle.

#### Other changes and Improvements

- Added support for distributing the C++ SDK as a source package via vcpkg.

### azure-identity [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/identity/azure-identity/CHANGELOG.md#100-beta2-2021-01-13)

#### Breaking Changes

- Moved `Azure::Identity::Version`, defined in `azure/identity/version.hpp` to the `Azure::Identity::Details` namespace.

#### Other changes and Improvements

- Add high-level and simplified identity.hpp file for simpler include experience for customers.

### azure-storage-common [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-common/CHANGELOG.md#1200-beta6-2020-01-14)

#### New Features

- Added new type `ContentHash`.
- Added definition of `Metadata`.
- Support setting account SAS permission with a raw string.

#### Breaking Changes

- Renamed `SharedKeyCredential` to `StorageSharedKeyCredential`.
- Renamed `StorageSharedKeyCredential::UpdateAccountKey` to `Update`.
- Made `StorageRetryPolicy`, `StoragePerRetryPolicy` and `SharedKeyPolicy` private by moving them to the `Details` namespace.
- Removed `StorageRetryOptions`, use `Azure::Core::Http::RetryOptions` instead.
- Moved Account SAS into `Azure::Storage::Sas` namespace.
- All date time related strings are now changed to `Azure::Core::DateTime` type.
- Made version strings private by moving them into the `Details` namespace.
- Moved `Base64Encode` and `Base64Decode` from the `Azure::Storage` namespace to `Azure::Core` and removed the string accepting overload of `Base64Encode`.
- Renamed public constants so they no longer start with the prefix `c_`. For example, `c_InfiniteLeaseDuration` became `InfiniteLeaseDuration`.

#### Bug Fixes

- Fixed default EndpointSuffix when parsing a connection string.

### azure-storage-blobs [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-blobs/CHANGELOG.md#1200-beta6-2020-01-14)

#### New Features

- Added `CreateIfNotExists` and `DeleteIfExists` for blob containers and blobs.
- Added `IsHierarchicalNamespaceEnabled` in `GetAccountInfoResult`.
- Added `PageBlobClient::GetPageRangesDiff` and `PageBlobClient::GetManagedDiskPageRangesDiff`.
- Added `CreateBlobContainer`, `DeleteBlobContainer`, `UndeleteBlobContainer` into `BlobServiceClient`.
- Added `DeleteBlob` to `BlobContainerClient`.
- Support setting blob SAS permission with a raw string.

#### Breaking Changes

- Renamed `AppendBlobAccessConditions::MaxSize` to `IfMaxSizeLessThanOrEqual`.
- Renamed `AppendBlobAccessConditions::AppendPosition` to `IfAppendPositionEqual`.
- `BlobServiceProperties.DefaultServiceVersion` is now nullable.
- Renamed `DeleteBlobSubRequest::containerName` to `blobContainerName`.
- Renamed `SetBlobAccessTierSubRequest::containerName` to `blobContainerName`.
- Renamed `BlobSasBuilder::ContainerName` to `BlobContainerName`.
- Renamed `BlobSasResource::Container` to `BlobContainer`.
- Renamed `AccountSasResource::Container` to `BlobContainer`
- Renamed some structs:
  - `CreateContainerResult` to `CreateBlobContainerOptions`
  - `CreateContainerOptions` to `CreateBlobContainerOptions`
  - `DeleteContainerResult` to `DeleteBlobContainerResult`
  - `DeleteContainerOptions` to `DeleteBlobContainerOptions`
  - `GetContainerPropertiesResult` to `GetBlobContainerPropertiesResult`
  - `GetContainerPropertiesOptions` to `GetBlobContainerPropertiesOptions`
  - `SetContainerMetadataResult` to `SetBlobContainerMetadataResult`
  - `SetContainerMetadataOptions` to `SetBlobContainerMetadataOptions`
  - `GetContainerAccessPolicyResult` to `GetBlobContainerAccessPolicyResult`
  - `GetContainerAccessPolicyOptions` to `GetBlobContainerAccessPolicyOptions`
  - `SetContainerAccessPolicyResult` to `SetBlobContainerAccessPolicyResult`
  - `SetContainerAccessPolicyOptions` to `SetBlobContainerAccessPolicyOptions`
  - `AcquireContainerLeaseResult` to `AcquireBlobContainerLeaseResult`
  - `AcquireContainerLeaseOptions` to `AcquireBlobContainerLeaseOptions`
  - `RenewContainerLeaseResult` to `RenewBlobContainerLeaseResult`
  - `RenewContainerLeaseOptions` to `RenewBlobContainerLeaseOptions`
  - `ReleaseContainerLeaseResult` to `ReleaseBlobContainerLeaseResult`
  - `ReleaseContainerLeaseOptions` to `ReleaseBlobContainerLeaseOptions`
  - `ChangeContainerLeaseResult` to `ChangeBlobContainerLeaseResult`
  - `ChangeContainerLeaseOptions` to `ChangeBlobContainerLeaseOptions`
  - `BreakContainerLeaseResult` to `BreakBlobContainerLeaseResult`
  - `BreakContainerLeaseOptions` to `BreakBlobContainerLeaseOptions`
  - `ContainerAccessConditions` to `BlobContainerAccessConditions`
  - `ListContainersSegmentResult` to `ListBlobContainersSegmentResult`
  - `ListContainersSegmentOptions` to `ListBlobContainersSegmentOptions`
- API signature for `CommitBlockList` has changed. `BlockType` doesn't need to be specified anymore.
- `PageBlobClient::GetPageRanges` doesn't support getting difference between current blob and a snapshot anymore. Use `PageBlobClient::GetPageRangesDiff` instead.
- Moved Blob SAS into `Azure::Storage::Sas` namespace.
- Replaced all transactional content MD5/CRC64 with the `ContentHash` struct.
- `EncryptionKeySha256` is changed to binary (`std::vector<uint8_t>`).
- `ContentMd5` HTTP header is renamed to `ContentHash`, the type is also changed to `ContentHash`.
- `ServerEncrypted` fields are renamed to `IsServerEncrypted`, and changed to non-nullable type.
- Added `Is` prefix to bool variable names. Like `IsAccessTierInferred`, `IsDeleted`.
- `IsServerEncrypted`, `EncryptionKeySha256` and `EncryptionScope` are removed from `ClearPageBlobPagesResult`, since they are never returned from storage server.
- `ListBlobsFlatSegment` is renamed to `ListBlobsSinglePage`.
- `ListBlobsByHierarchySegment` is renamed to `ListBlobsByHierarchySinglePage`.
- `ListBlobContainersSegment` is renamed to `ListBlobContainersSinglePage`.
- `FindBlobsByTags` is renamed to `FindBlobsByTagsSinglePage`.
- `MaxResults` in list APIs are renamed to `PageSizeHint`.
- All date time related strings are now changed to `Azure::Core::DateTime` type.
- Replaced `std::pair<int64_t, int64_t>` with `Azure::Core::Http::Range` to denote blob ranges.
- Made version strings private by moving them into the `Details` namespace.
- Replaced scoped enums that don't support bitwise operations with extensible enum.
- Continuation token of result types are changed to nullable.
- Renamed `Models::DeleteSnapshotsOption::Only` to `OnlySnapshots`.
- Renamed `SourceConditions` in API options to `SourceAccessConditions`.
- Removed Blob Batch.
- `DownloadBlobResult::Content-Range` is changed to an `Azure::Core::Http::Range`, an extra field `BlobSize` is added.
- Removed `Undelete` from `BlobContainerClient`.
- `BlobRetentionPolicy::Enabled` is renamed to `BlobRetentionPolicy::IsEnabled`, `BlobStaticWebsite::Enabled` is renamed to `BlobStaticWebsite::IsEnabled`.
- Changed type for metadata to case-insensitive `std::map`.
- Changed parameter type for token credential from `Azure::Identity::ClientSecretCredential` to `Azure::Core::TokenCredential`.
- Renamed member function `GetUri` of client types to `GetUrl`.
- `BlobClient::GetBlockBlobClient`, `BlobClient::GetAppendBlobClient` and `BlobClient::GetPageBlobClient` are renamed to `BlobClient::AsBlockBlobClient`, `BlobClient::AsAppendBlobClient` and `BlobClient::AsPageBlobClient` respectively.

### azure-storage-files-shares [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-shares/CHANGELOG.md#1200-beta6-2020-01-14)

#### New Features

- Added support for `CreateIfNotExists` for Share and Directory clients, and `DeleteIfExists` for Share, Directory and File clients.
- Support setting file SAS permission with a raw string.

#### Breaking Changes

- Removed constructors in clients that takes a `Azure::Identity::ClientSecretCredential`.
- Removed Share Lease related APIs such as `ShareClient::AcquireLease` and `ReleaseLease` since they are not supported in recent service versions.
- Moved File SAS into `Azure::Storage::Sas` namespace.
- Replaced all transactional content MD5/CRC64 with the `ContentHash` struct.
- `FileShareHttpHeaders` is renamed to `ShareFileHttpHeaders`, and member `std::string ContentMd5` is changed to `Storage::ContentHash ContentHash`.
- All date time related strings are now changed to `Azure::Core::DateTime` type.
- Moved version strings into `Details` namespace.
- Renamed all functions and structures that could retrieve partial query results from the server to have `SinglePage` suffix instead of `Segment` suffix.
- Removed `FileRange`, `ClearRange`, and `Offset` and `Length` pair in options. They are now represented with `Azure::Core::Http::Range`.
- Replace scoped enums that don't support bitwise operations with extensible enum.
- `IsServerEncrypted` members in `DownloadFileToResult`, `UploadFileFromResult`, `FileDownloadResult` and `FileGetPropertiesResult` are no longer nullable.
- Create APIs for Directory and File now returns `FileShareSmbProperties` that aggregates SMB related properties.
- `DirectoryClient` is renamed to `ShareDirectoryClient`, `FileClient` is renamed to `ShareFileClient`.
- Directory and File related result types and options types now have a `Share` prefix. For example, `SetDirectoryPropertiesResult` is changed to `SetShareDirectoryPropertiesResult`.
- Renamed `GetSubDirectoryClient` to `GetSubdirectoryClient`.


### azure-storage-files-datalake [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-datalake/CHANGELOG.md#1200-beta6-2020-01-14)

#### New Features

- Support setting DataLake SAS permission with a raw string.
- Added support for `CreateIfNotExists` and `DeleteIfExists` for FileSystem, Path, Directory and File clients.

#### Breaking Changes

- Moved DataLake SAS into `Azure::Storage::Sas` namespace.
- `EncrytionKeySha256` are changed to binary (`std::vector<uint8_t>`).
- Replaced all transactional content MD5/CRC64 with the `ContentHash` struct.
- `DataLakeHttpHeaders` is renamed to `PathHttpHeaders`, and now contains `ContentHash` for the resource.
- All date time related strings are now changed to `Azure::Core::DateTime` type.
- `CreationTime` is renamed to `CreatedOn`.
- `AccessTierChangeTime` is renamed to `AccessTierChangedOn`.
- `CopyCompletionTime` is renamed to `CopyCompletedOn`.
- `ExpiryTime` is renamed to `ExpiresOn`.
- `LastAccessTime` is renamed to `LastAccessedOn`.
- Made version strings private by moving them into the `Details` namespace.
- Renamed all functions and structures that could retrieve partial query results from the server to have `SinglePage` suffix instead of `Segment` suffix.
- `ReadFileResult` now have `ContentRange` as string.
- `ReadFileOptions` now have `Azure::Core::Http::Range` instead of `Content-Length` and `Offset`.
- Replaced scoped enums that don't support bitwise operations with extensible enum.
- `ListPaths` is renamed to `ListPathsSinglePage` and its related return type and options are also renamed accordingly.
- Added `DataLake` prefix to `FileSystemClient`, `PathClient`,  `DirectoryClient`, and `FileClient` types.
- FileSystems, Path, Directory and File related result types and options types now have a `DataLake` prefix. For example, `GetFileSystemPropertiesResult` is changed to `GetDataLakeFileSystemPropertiesResult`.
- Renamed `GetSubDirectoryClient` to `GetSubdirectoryClient`.
- Removed `NamespaceEnabled` field in `CreateDataLakeFileSystemResult`.

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
