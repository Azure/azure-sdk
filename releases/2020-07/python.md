---
title: Azure SDK for Python (July 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the July 2020 client library release.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Preview

- Management Library - Compute
- Management Library - Network
- Management Library - Resource
- Management Library - Storage
- Management Library - Monitor
- Management Library - AppConfiguration
- Management Library - EventHub
- Management Library - KeyVault
- Identity
- Service Bus
- Form Recognizer

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install --pre azure-mgmt-compute
pip install --pre azure-mgmt-network
pip install --pre azure-mgmt-resource
pip install --pre azure-mgmt-storage
pip install --pre azure-mgmt-monitor
pip install --pre azure-mgmt-appconfiguration
pip install --pre azure-mgmt-eventhub
pip install --pre azure-mgmt-keyvault
pip install --pre azure-identity
pip install --pre azure-servicebus
pip install azure-ai-formrecognizer
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### New Management Libraries

A new set of management libraries that follow the [Azure SDK Design Guidelines for Python](https://azure.github.io/azure-sdk/python/guidelines/) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. 
You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/python.html). Documentation and code samples for these new libraries can be found [here](https://azure.github.io/azure-sdk-for-python)

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md)

#### New Features

- This release continues to move towards feature parity with the existing sdk.  Recommend reading migration guide and full changelog for details.
- Support for management of Topic, Subscription and Rule entities; creation, deletion, and fetching of metadata.
- `receive_messages()` (formerly `receive()`) now supports receiving a batch of messages (`max_batch_size` > 1) without the need to set `prefetch` parameter during `ServiceBusReceiver` initialization.

#### Breaking changes

- `receive_messages()` (formerly `receive()`) no longer raises a `ValueError` if `max_batch_size` is less than the `prefetch` parameter set during `ServiceBusReceiver` initialization.
- To align better with broader service bus SDK family, renaming:
  `receive()` -> `receive_messages()`
  `peek()` ->  `peek_messages()`
  `schedule()` -> `schedule_messages()`
  `send()` ->  `send_messages()`

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#100b4-2020-07-07)

#### Breaking changes

- `begin_recognize_receipts` and `begin_recognize_receipts_from_url` now return a list of `RecognizedForm`
- Model and property renaming detailed in changelog

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/CHANGELOG.md)

#### New Features

- Added `AzureCliCredential`, which authenticates as the identity signed in to the Azure CLI
- Added `VSCodeCredential`, which authenticates as the user signed in to Visual Studio Code's Azure Account extension.
- The optional persistent cache for `DeviceCodeCredential` and `InteractiveBrowserCredential` is supported on Linux and macOS.

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
