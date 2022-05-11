---
title: Azure SDK for Embedded C (February 2022)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the February 2022 client library release.

#### GA

- Azure Core and Azure IoT

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Release highlights

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.3.0/CHANGELOG.md#130-2022-02-08)

#### Features Added

- Added a total bytes written field to the JSON writer.

#### Breaking Changes

- Compared to the previous 1.2.0 release, there are **no** breaking changes.
- Removed `az_storage_blobs.h`, which included some beta APIs for Azure Blob Storage such as `az_storage_blobs_blob_client()`.
  - These will ship in a future release, and are still available from [the previous beta release](https://github.com/Azure/azure-sdk-for-c/releases/tag/1.3.0-beta.1).

#### Bugs Fixed

- [[#2027]](https://github.com/Azure/azure-sdk-for-c/pull/2027) Update IoT user agent to append property name before property value in cases where a custom user agent was specified.
- [[#1885]](https://github.com/Azure/azure-sdk-for-c/pull/1885) Fix compilation error C4576 with C++ and MSVC 2019. (A community contribution, courtesy of _[hwmaier](https://github.com/hwmaier)_)

#### Acknowledgments

Thank you to our developer community members who helped to make Azure SDK for C better with their contributions to this release:

- Henrik Maier _([GitHub](https://github.com/hwmaier))_

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
