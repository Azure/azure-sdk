---
title: Azure SDK for Embedded C (November 2022)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the November 2022 client library release.

#### Stable

- Azure Core and Azure IoT

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

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.4.0/CHANGELOG.md#140-2022-11-11)

#### Features Added

- [[#2329](https://github.com/Azure/azure-sdk-for-c/pull/2329)] Add Base64 URL decoder.
- [[#2375](https://github.com/Azure/azure-sdk-for-c/pull/2375)] Add Azure Device Update for IoT Hub, enabling Over-the-Air (OTA) updates for embedded devices.
- Added support in `az_json.h` to unescape JSON string tokens within an `az_span` using the `az_json_string_unescape()` API.

#### Bugs Fixed

- [[#2372](https://github.com/Azure/azure-sdk-for-c/pull/2372)] Incorrect minimum buffer size calculation when logging an HTTP request.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
