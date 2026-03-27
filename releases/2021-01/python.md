---
title: Azure SDK for Python (January 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the January 2021 client library release.

#### GA

- _Add packages_

#### Updates

- Event Hubs
- Service Bus

#### Beta

- Tables
- Text Analytics
- Form Recognizer
- Live Video Analytics on IoT Edge
- Opentelemetry Azure Monitor
- Microsoft Azure Attestation

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-data-tables
pip install azure-eventhub
pip install azure-eventhub-checkpointstoreblob
pip install azure-eventhub-checkpointstoreblob-aio
pip install azure-media-analytics-edge
pip install azure-servicebus
pip install azure-ai-textanalytics --pre
pip install azure-ai-formrecognizer --pre
pip install azure-opentelemetry-exporter-azuremonitor --pre
pip install azure-security-attestation --pre
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub/CHANGELOG.md#521-2021-01-11)
- Updated `azure.eventhub.extension.__init__.py` to be compatible with pkgutil-style namespace (PR #13210, thanks @pjachowi).
- Updated uAMQP dependency to 1.2.13
  - Added support for Python 3.9.
  - Fixed bug that macOS was unable to detect network error (#15473).
  - Fixed bug that `uamqp.ReceiveClient` and `uamqp.ReceiveClientAsync` receive messages during connection establishment (#15555).
  - Fixed bug where connection establishment on macOS with Clang 12 triggering unrecognized selector exception (#15567).
  - Fixed bug in accessing message properties triggering segmentation fault when the underlying C bytes are NULL (#15568).

### Event Hubs CheckpointStoreBlob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub-checkpointstoreblob-aio/CHANGELOG.md#112-2021-01-11)
- Fixed a bug that `BlobCheckpointStore.list_ownership` and `BlobCheckpointStore.list_checkpoints` triggering `KeyError` due to reading empty metadata of parent node when working with Data Lake enabled Blob Storage.

### Event Hubs CheckpointStoreBlob Async [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub-checkpointstoreblob-aio/CHANGELOG.md#112-2021-01-11)
- Fixed a bug that `BlobCheckpointStore.list_ownership` and `BlobCheckpointStore.list_checkpoints` triggering `KeyError` due to reading empty metadata of parent node when working with Data Lake enabled Blob Storage.

### Live Video Analytics on IoT Edge [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/3f1ad07b16d73107bb6c465859d224c44b6a3f55/sdk/media/azure-media-analytics-edge/CHANGELOG.md#100b1)

- Initial release of Live Video Analytics on IoT Edge.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/servicebus/azure-servicebus/CHANGELOG.md#701-2021-01-12)
- `forward_to` and `forward_dead_lettered_messages_to` will no longer cause authorization errors when used in `ServiceBusAdministrationClient` for queues and subscriptions (#15543).
- Updated uAMQP dependency to 1.2.13.
  - Fixed bug that macOS was unable to detect network error (#15473).
  - Fixed bug that `uamqp.ReceiveClient` and `uamqp.ReceiveClientAsync` receive messages during connection establishment (#15555).
  - Fixed bug where connection establishment on macOS with Clang 12 triggering unrecognized selector exception (#15567).
  - Fixed bug in accessing message properties triggering segmentation fault when the underlying C bytes are NULL (#15568).

### Opentelemetry Azure Monitor [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-opentelemetry-exporter-azuremonitor_1.0.0b2/sdk/monitor/azure-opentelemetry-exporter-azuremonitor/CHANGELOG.md)
- Breaking Changes
  - Rename Azure Trace exporter class, only allow connection string configuration. (#15349)
  - OpenTelemetry Exporter use Resources API to retrieve cloud role props (#15816)
  - Change span to envelope conversion to adhere to common schema and other languages. (#15344)
  - This library is renamed to `azure-opentelemetry-exporter-azuremonitor`. (#16030)
  - Fix to only retry upon request error. (#16087)

### Microsoft Azure Attestation [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/attestation/azure-security-attestation/CHANGELOG.md#100b1-2020-12-09)

  - Initial release of Azure Security Attestation to support data-plane operations.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
