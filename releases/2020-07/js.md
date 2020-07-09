---
title: Azure SDK for JavaScript (July 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the July 2020 client library release.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Preview

- Storage

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/storage-blob
$> npm install @azure/storage-blob-changfeed
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/storage-queue
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md)

##### New Features
- Added support for Blob Tags, Blob Versioning, Quick Query, Jumbo Blobs, and more
- Added convenience method `createIfNotExists` for `ContainerClient`, `AppendBlobClient`, and `PageBlobClient`
- Added convenience method `deleteIfExists` for `ContainerClient` and `BlobClients`

#### Blob ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob-changefeed/CHANGELOG.md)

##### New Features
- Added a preview version of this library to support change feed

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### New Features
- Block size is increased to 4 GB max
- Added more mapping for Blob and DFS endpoints

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features
- Supports 4 TB files

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
