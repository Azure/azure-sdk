---
title: Azure SDK for Embedded C (November 2020)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the November 2020 client library release.

#### Beta

- Azure IoT PnP

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Release highlights

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/main/CHANGELOG.md#110-beta2-2020-11-11)

#### New Features

- Public preview version of a new set of APIs to simplify the experience using IoT Plug and Play. To consume this new feature, a new CMake target has been added `az::iot::pnp`. The APIs can be found in its header file: `az_iot_pnp_client.h`.
- New samples showing how to consume the new IoT Plug and Play APIs:
  - paho_iot_pnp_component_sample.c
  - paho_iot_pnp_sample.c
  - paho_iot_pnp_with_provisioning_sample.c

#### Bug Fixes

- [[#1472]](https://github.com/Azure/azure-sdk-for-c/pull/1472) Fix `az_iot_message_properties_next()` when the buffer in which the properties were kept was bigger than the length of characters in the buffer.

#### Other Changes and Improvements

- [[#1473]](https://github.com/Azure/azure-sdk-for-c/pull/1473) Add remove server certificate validation on paho and ESP8266 samples.
- [[#1449]](https://github.com/Azure/azure-sdk-for-c/pull/1449) Add basic reconnection capability for the ESP8266 sample.
- [[#1490]](https://github.com/Azure/azure-sdk-for-c/pull/1490) Fix static analyzer flagging of non-checked return value in `az_iot_hub_client_c2d_parse_received_topic()`.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
