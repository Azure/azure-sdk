---
title: Azure SDK for C++ (November 2020)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the November 2020 client library release.


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

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

## Release highlights

### azure-core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta3-2020-11-11)

#### New Features
- Added `strings.hpp` with `Azure::Core::Strings::LocaleInvariantCaseInsensitiveEqual` and `Azure::Core::Strings::ToLower`.
- Added `GetPort()` to `Url`.
- Added `TransportPolicyOptions`.
- Added `TelemetryPolicyOptions`.
- Added `RequestFailedException` deriving from `std::runtime_error`.
- Added `CurlTransportOptions` for the `CurlTransport`.
- Added `DateTime` supporting dates since 1601.
- Added `OperationCanceledException`.
- Added `Encode` and `Decode` to `Url`.

#### Breaking Changes

- Removed `azure.hpp`.
- Removed macro `AZURE_UNREFERENCED_PARAMETER`.
- Bump CMake version from 3.12 to 3.13.
- Bump libcurl version from 7.4 to 7.44.
- Moved `ClientSecretCredential` and `EnvironmentCredential` to the Identity library.
- `Url` class changes:
  - `AppendPath` now does not encode the input by default.
  - Signature updated for `SetHost`, `SetPath` and `AppendPath`.
  - Removed `SetFragment`.
  - Renamed `AppendQueries` to `AppendQueryParameters`.
  - Renamed `AppendQuery` to `AppendQueryParameter`.
  - Renamed `RemoveQuery` to `RemoveQueryParameter`.
  - Renamed `GetQuery` to `GetQueryParameters`.

#### Bug Fixes

- Prevent pipeline of length zero to be created.
- Avoid re-using a connection when a request to upload data fails while using the `CurlTransport`.
- Add entropy to `Uuid` generation.

#### Other changes and Improvements

- Add high-level and simplified core.hpp file for simpler include experience for customers.
- Add code coverage using gcov with gcc.
- Update SDK-defined exception types to be classes instead of structs.
- Updated `TransportException` and `InvalidHeaderException` to derive from `RequestFailedException`.
- Vcpkg dependency version updated to 2020.11.
- Make libcurl network requests cancelable by Context::Cancel().
- Validate HTTP headers for invalid characters.
- Calling `Cancel()` from context now throws `OperationCanceledException`.

### azure-identity [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/identity/azure-identity/CHANGELOG.md#100-beta1-2020-11-11)

#### New Features

- Support for Client Secret Credential.
- Support for Environment Credential.

### azure-storage-common [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-common/CHANGELOG.md#1200-beta5-2020-11-13)

#### Breaking Changes

- Rename `LastModifiedTimeAccessConditions` to `ModifiedTimeConditions`.
- Rename `StorageError` to `StorageException`.
- Rename header file `storage_error.hpp` to `storage_exception.hpp`.
- Rename `SharedKeyCredential::SetAccountKey` to `SharedKeyCredential::UpdateAccountKey`.
- Rename `AccountSasBuilder::ToSasQueryParameters` to `AccountSasBuilder::GenerateSasToken`.
- Remove `storage_version.hpp` and add `version.hpp`.
- Make `SharedKeyCredential` a class.

#### Other Changes and Improvements

- Remove support for specifying SAS version.

### azure-storage-blobs [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-blobs/CHANGELOG.md#1200-beta5-2020-11-13)

#### New Features

- Support for replaceable HTTP transport layer.
- Add `version.hpp`.

#### Breaking Changes

- Move header `azure/storage/blobs/blob.hpp` to `azure/storage/blobs.hpp`.
- Service API return types which are typically suffixed with `Result` are moved to the `Models` sub-namespaces and everything else from the protocol layer is made private by moving to the `Details` namespace.
- Make XML serializer and deserializer private by moving them to the `Details` namespace.
- Remove `BlockBlobClientOptions`, `AppendBlobClientOptions` and `PageBlobClientOptions`, use `BlobClientOptions` instead.
- Rename `BlobSasBuilder::ToSasQueryParameters` to `BlobSasBuilder::GenerateSasToken`.

#### Other Changes and Improvements

- Default uploading/downloading concurrency is changed from 1 to 5.
- Remove support for specifying SAS version.


### azure-storage-files-shares [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-shares/CHANGELOG.md#1200-beta5-2020-11-13)

#### Breaking Changes

- `Azure::Storage::Files::Shares::Metrics::IncludeAPIs` is now renamed to `Azure::Storage::Files::Shares::Metrics::IncludeApis`, and is changed to a nullable member.
- Moved header `azure/storage/files/shares/shares.hpp` to `azure/storage/files/shares.hpp`.
- Moved returning model types and related functions in `Azure::Storage::Files::Shares` to `Azure::Storage::Files::Shares::Models`, and made other code private by moving it into `Azure::Storage::Files::Shares::Details`.
- Renamed `Azure::Storage::Files::Shares::ServiceClient` to `Azure::Storage::Files::Shares::ShareServiceClient`.


### azure-storage-files-datalake [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-datalake/CHANGELOG.md#1200-beta5-2020-11-13)

#### Breaking Changes

- Moved header `azure/storage/files/datalake/datalake.hpp` to `azure/storage/files/datalake.hpp`.
- Moved returning model types and related functions in `Azure::Storage::Files::DataLake` to `Azure::Storage::Files::DataLake::Models`, and made other code private by moving it into `Azure::Storage::Files::DataLake::Details`.
- Renamed `Azure::Storage::Files::DataLake::ServiceClient` to `Azure::Storage::Files::DataLake::DataLakeServiceClient`.

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
