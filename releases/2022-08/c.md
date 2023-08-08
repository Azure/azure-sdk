---
title: Azure SDK for Embedded C (August 2022)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the August 2022 client library release.

#### Beta

- Azure Core

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c
cd azure-sdk-for-c
git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Release highlights

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.4.0-beta.1/CHANGELOG.md#140-beta1-2022-08-09)

#### Features Added

- Added support in `az_json.h` to unescape JSON string tokens within an `az_span` using the `az_json_string_unescape()` API.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
