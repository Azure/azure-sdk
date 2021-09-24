---
title: Azure SDK for Embedded C (September 2021)
layout: post
tags: c
sidebar: releases_sidebar
repository: Azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the September 2021 client library release.

#### GA

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

### azure-sdk-for-c [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/1.2.0/CHANGELOG.md#120-2021-09-08)

#### New Features

- Add `az_iot_provisioning_client_get_request_payload()` to create MQTT payload bodies during Device Provisioning.
- This version provides new APIs to follow the IoT Plug and Play convention to implement Telemetry, Commands, Properties and Components defined in a DTDL model.
  - To read/write properties, the SDK now provides functions to produce the right payload for components, as shown in the header `azure/iot/az_iot_hub_client_properties.h`.
  - To send telemetry messages, the required header is added to identify components.
  - When responding to a command invocation the component name is automatically parsed and provided when available.
  - All new samples follow the IoT Plug and Play convention and can be connected to IoT Hub (with or without DPS), or IoT Central.

#### Bug Fixes

- [[#1905]](https://github.com/Azure/azure-sdk-for-c/pull/1905) Fix the internal state of the JSON writer during calls to `az_json_writer_append_json_text()` by taking into account the required buffer space for commas. (A community contribution, courtesy of _[hwmaier](https://github.com/hwmaier)_)

#### Acknowledgments

Thank you to our developer community members who helped to make Azure SDK for C better with their contributions to this release:

- Henrik Maier _([GitHub](https://github.com/hwmaier))_

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
