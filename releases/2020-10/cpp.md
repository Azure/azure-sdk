---
title: Azure SDK for C++ (October 2020)
layout: post
tags: C++ cpp
sidebar: releases_sidebar
repository: azure/azure-sdk-for-cpp
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### Beta

- Azure Core
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

## Changelog

### Azure Core [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/core/azure-core/CHANGELOG.md)

#### Bug Fixes

- Fixed a case where path was not properly encoded
- Switched to select() in libcurl for polling operations

### Azure Storage Blobs [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-blobs/CHANGELOG.md#100-beta2-2020-09-09)

### Azure Storage Files DataLake [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-datalake/CHANGELOG.md#100-beta2-2020-09-09)

#### New Features

- Support for SetExpiry

### Azure Storage Files Shares [Changelog](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/storage/azure-storage-files-shares/CHANGELOG.md#100-beta2-2020-09-09)

## Latest Releases

View all the latest versions of C++ packages [here][cpp-latest-releases].

{% include refs.md %}
