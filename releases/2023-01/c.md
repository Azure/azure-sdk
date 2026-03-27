---
title: Azure SDK for Embedded C (January 2023)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the January 2023 client library release.

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

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.5.0/CHANGELOG.md#150-2023-01-10)

#### Features Added

- [[#2443](https://github.com/Azure/azure-sdk-for-c/pull/2443)] Adding IoT Device Provisioning support for [Custom Allocation Payload](https://docs.microsoft.com/azure/iot-dps/how-to-send-additional-data).
  - New APIs: `az_iot_provisioning_client_register_get_request_payload()` and  `az_iot_provisioning_client_registration_state.payload`.
  - Deprecated: `az_iot_provisioning_client_get_request_payload()`.

#### Bugs Fixed

- [[#2437](https://github.com/Azure/azure-sdk-for-c/pull/2437)] Update ADU device information payload to GA key/values.
- [[#2443](https://github.com/Azure/azure-sdk-for-c/pull/2443)] Azure IoT Samples now display errors following the _source file:line number_ format, allowing Visual Studio Code to automatically create links from the output log.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
