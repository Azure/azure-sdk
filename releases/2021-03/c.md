---
title: Azure SDK for Embedded C (March 2021)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA

- Azure Core
- Azure IoT

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Release highlights

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.1.0/CHANGELOG.md#110-2021-03-09)

#### Breaking Changes

- Compared to the previous 1.0.0 release, there are **no** breaking changes.
- Removed `az_iot_pnp_client.h`, which included some beta APIs related to IoT Plug and Play such as `az_iot_pnp_client()`.
  - These will ship in a future release.

#### Bug Fixes

- [[#1600]](https://github.com/Azure/azure-sdk-for-c/pull/1600) Make sure `az_json_writer_append_json_text()` appends a comma between elements of a JSON array.
- [[#1580]](https://github.com/Azure/azure-sdk-for-c/pull/1580) Fix build on Ubuntu 18.04 by updating CMake policy and MSVC runtime libraries.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
