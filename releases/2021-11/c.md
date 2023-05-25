---
title: Azure SDK for Embedded C (November 2021)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the November 2021 client library release.

#### Beta

- Azure Core and Azure Storage

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Release highlights

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.3.0-beta.1/CHANGELOG.md#130-beta1-2021-11-09)

#### New Features

- Added Azure Blob Storage APIs for blob upload and download.
- Added `az_http_response_get_status_code()` convenience function to get HTTP status code from requests.

#### Bug Fixes

- Fixed `az_curl` CMake dependency propagation on `libcurl`.

#### Other Changes

- Improved HTTP request telemetry.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
