---
title: Azure SDK for C++ (June 2021)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the June 2021 client library release.

#### GA

- Azure Core
- Azure Identity
- Azure Storage Common
- Azure Storage Blobs
- Azure Storage Files Shares
- Azure Storage Files DataLake

#### Beta

- Azure Key Vault Common
- Azure Key Vault Keys

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash

# From Source
git clone https://github.com/Azure/azure-sdk-for-cpp
# git checkout <tag_name>
# For example:
git checkout azure-storage-blobs_12.0.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-cpp/issues).

## Release highlights

### azure-core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/CHANGELOG.md#100-2021-06-04)

#### Bug Fixes

- Make `RequestFailedException` copiable so it can be propagated across thread.
- By default, add `x-ms-request-id` header to the allow list of headers to log.

### azure-identity [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/identity/azure-identity/CHANGELOG.md#100-2021-06-04)

No API changes since `1.0.0-beta.6`.

### azure-storage-blobs [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-blobs/CHANGELOG.md#1200-2021-06-08)

#### Other Changes and Improvements

- Added and updated some samples.
- Fixed a read consistency issue.


### azure-storage-files-shares [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-shares/CHANGELOG.md#1200-2021-06-08)

#### Breaking Changes

- Renamed `ContentLength` in `FileItemDetails` to `FileSize`.

#### Other Changes and Improvements

- Updated some samples.
- Fixed a read consistency issue.


### azure-storage-common [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-common/CHANGELOG.md#1200-2021-06-08)

#### Other Changes and Improvements

- Fixed a filename encoding issue.


### azure-storage-files-datalake [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-datalake/CHANGELOG.md#1200-2021-06-08)

#### Breaking Changes

- Renamed `ContentLength` in `FlushFileResult` to `FileSize`.

#### Other Changes and Improvements

- Removed `IfUnmodifiedSince` from access conditions of setting filesystem metadata operation.
- Updated some samples.
- Fixed a read consistency issue.

### azure-security-keyvault-common [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/azure-security-keyvault-common_4.0.0-beta.3/sdk/keyvault/azure-security-keyvault-common/CHANGELOG.md#400-beta3-2021-06-08)

No breaking changes or new features added. Includes only implementation enhancements.
### azure-security-keyvault-keys [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#400-beta3-2021-06-08)

#### Breaking Changes

- Updated `MaxPageResults` type to `int32_t`, from `uint32_t`, affecting:
  - `GetDeletedKeysOptions()`.
  - `GetPropertiesOfKeysOptions()`.
  - `GetPropertiesOfKeyVersionsOptions()`.
- Updated `CreateRsaKeyOptions::KeySize` type from `uint64_t` to `int64_t`.
- Updated `CreateRsaKeyOptions::PublicExponent` type from `uint64_t` to `int64_t`.
- Updated `CreateOctKeyOptions::KeySize` type from `uint64_t` to `int64_t`.

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
