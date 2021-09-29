---
title: Azure SDK for Embedded C (September 2020)
layout: post
tags: c
sidebar: releases_sidebar
repository: azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the September 2020 client library release.

#### Beta

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

## Changelog

### Azure Core [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/main/CHANGELOG.md)

### New Features

- Add `az_json_writer_append_json_text()` to support appending existing JSON with the JSON writer.
- Add support for system properties for IoT Hub messages to `az_iot_common.h`.
- Add new HTTP result named `AZ_ERROR_HTTP_END_OF_HEADERS` to designate the end of the headers iterated over by `az_http_response_get_next_header()`.
- Add new IoT result named `AZ_ERROR_IOT_END_OF_PROPERTIES` to designate the end of the properties iterated over by `az_iot_message_properties_next()`.
- Add `AZ_IOT_MESSAGE_PROPERTIES_USER_ID` and `AZ_IOT_MESSAGE_PROPERTIES_CREATION_TIME` helper macros.
- Add new `az_result` value `AZ_ERROR_DEPENDENCY_NOT_PROVIDED` which is returned by the HTTP adapter.

### Breaking Changes

- Rename `az_iot_hub_client_properties` to `az_iot_message_properties` and move it from `az_iot_hub_client.h` to `az_iot_common.h`.
- Remove `az_pair`, and its usage from `az_http_request_append_header()`, `az_http_response_get_next_header()`, and `az_iot_message_properties_next()` in favor of individual name and value `az_span` parameters.
- Remove `az_credential_client_secret` structure, and `az_credential_client_secret_init()` function.
- Remove `az_platform_atomic_compare_exchange()` from platform.
- In `az_result.h`, rename `az_failed()` to `az_result_failed()` and `az_succeeded()` to `az_result_succeeded()`.
- `az_iot_is_success_status()` renamed to `az_iot_status_succeeded()`.
- `az_iot_is_retriable_status()` renamed to `az_iot_status_retriable()`.
- `az_iot_retry_calc_delay()` renamed to `az_iot_calculate_retry_delay()`.
- `az_iot_hub_client_sas_get_password()` parameter `token_expiration_epoch_time` moved to second parameter.
- `az_iot_provisioning_client_init()` parameter `global_device_endpoint` renamed to `global_device_hostname`.
- `az_iot_provisioning_client_query_status_get_publish_topic()` now accepts the `operation_id` from the `register_response` as the second parameter instead of the whole `az_iot_provisioning_client_register_response` struct.
- Renamed the macro `AZ_SPAN_NULL` to `AZ_SPAN_EMPTY`.
- Renamed the `az_result` value `AZ_ERROR_INSUFFICIENT_SPAN_SIZE` to `AZ_ERROR_NOT_ENOUGH_SPACE`.
- Removed the helper macros `AZ_RETURN_IF_FAILED()` and `AZ_RETURN_IF_NOT_ENOUGH_SIZE()` from `az_result.h`.
- Behavioral change to disallow passing `NULL` pointers to `az_context` APIs and update documentation.
- Removed `AZ_HUB_CLIENT_DEFAULT_MQTT_TELEMETRY_DUPLICATE` and `AZ_HUB_CLIENT_DEFAULT_MQTT_TELEMETRY_RETAIN` named constants from `az_iot_hub_client.h`.

### Bug Fixes

- Fix the strict-aliasing issue in `az_span_dtoa()` and `az_span_atod()`.
- Fix the SDK warnings for the release configurations.
- Do not use a shared static scratch buffer for JSON token parsing. Instead use stack space.

### Other Changes and Improvements

- Refactor and update IoT samples.
- Optimize the code size for URL encoding and setting HTTP query parameters.
- Add support for building the SDK on ARM (Cortex M4) and adding it to CI.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
