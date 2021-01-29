---
title: Azure SDK for Python (%%MMMM yyyy%%)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
azure-storage-file-share:12.4.0
azure-storage-file-datalake:12.2.1
azure-storage-blob:12.7.0

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the %%MMMM yyyy%% client library release.

#### GA

- Storage - Files Shares
- Storage - Blobs

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

- Storage - Files Data Lake

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash

$> pip install azure-storage-file-share==12.4.0
$> pip install azure-storage-file-datalake==12.2.1
$> pip install azure-storage-blob==12.7.0

```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Storage - Files Shares 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-storage-file-share_12.4.0/sdk/storage/azure-storage-file-share/CHANGELOG.md#1240-2021-01-13)
**Stable release of preview features** - Added support for enabling root squash and share protocols for file share. - Added support for `AzureSasCredential` to allow SAS rotation in long living clients. 

### Storage - Files Data Lake 12.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-storage-file-datalake_12.2.1/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1221-2021-01-13)
**New features** - Added support for `AzureSasCredential` to allow SAS rotation in long living clients.  **Fixes** - Converted PathProperties.last_modified to datetime format (#16019) 

### Storage - Blobs 12.7.0 [Changelog](https://github.com/Azure/azure-sdk-for-/blob/azure-storage-blob_12.7.0/sdk/storage/azure-storage-blob/CHANGELOG.md#1270-2021-01-13)
**Stable release of preview features** - Added `upload_blob_from_url` api on `BlobClient`. - Added support for leasing blob when get/set tags, listing all tags when find blobs by tags. - Added support for `AzureSasCredential` to allow SAS rotation in long living clients.  **Fixes** - Fixed url parsing for blob emulator/localhost (#15882) 


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
