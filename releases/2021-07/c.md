---
title: Azure SDK for Embedded C (July 2021)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the July 2021 client library release.

#### Beta

- Azure Core and IoT Plug and Play

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Release highlights

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.2.0-beta.1/CHANGELOG.md#120-beta1-2021-07-09)

#### New Features

- Added a current depth field to the JSON reader.
- Added base64 encoding and decoding APIs that accept `az_span`, available from the `azure/core/az_base64.h` header.
- Public preview version of a new set of APIs to simplify the experience using Azure IoT Plug and Play. To consume this new feature, the `az::iot::hub` CMake target has been updated. The APIs can be found in the header files: `az_iot_hub_client.h` and `az_iot_hub_client_properties.h`.
- New samples showing how to consume the new IoT Plug and Play APIs:
  - paho_iot_pnp_component_sample.c
  - paho_iot_pnp_sample.c
  - paho_iot_pnp_with_provisioning_sample.c

#### Bug Fixes

- [[#1640]](https://github.com/Azure/azure-sdk-for-c/pull/1640) Update precondition on `az_iot_provisioning_client_parse_received_topic_and_payload()` to require topic and payload minimum size of 1 instead of 0.
- [[#1699]](https://github.com/Azure/azure-sdk-for-c/pull/1699) Update precondition on `az_iot_message_properties_init()` to not allow `written_length` larger than the passed span.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
