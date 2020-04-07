---
title: Azure SDK for Python (April 2020)
layout: post
date: April 2020
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the April 2020 client library GA release.

This release includes the following:

#### GA



#### Preview

- Service Bus
- Event Hubs


## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install --pre azure-eventhub
pip install azure-eventhub-checkpointstoreblob
pip install azure-eventhub-checkpointstoreblob-aio
pip install azure-storage-blob
pip install azure-storage-file-datalake
pip install azure-storage-file-share
pip install azure-storage-queue
pip install azure-keyvault-certificates
pip install azure-keyvault-keys
pip install azure-keyvault-secrets
pip install --pre azure-identity
pip install --pre azure-ai-textanalytics
pip install --pre azure-search
pip install --pre azure-servicebus
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md)

- This release simplifies the client hierarchy and many common flows, such as spawning senders and receivers directly from the `ServiceBusClient`.  Recommend reading migration guide and full changelog for details.
- Support for Azure Identity based authentication.
- Exception hierarchy has been overhauled and made more precise to better denote failure reasons.
- Batch creation is now initiated off of the sender via `create_batch`.
- Users should be aware that this is a preview release with only support for queues, full featureset will be included in upcoming previews.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhub/CHANGELOG.md)

- Added `EventHubConsumerClient.receive_batch()` to receive and process events in batches instead of one by one. #9184
- `EventHubConsumerCliuent.receive()` has a new param `max_wait_time`. 
`on_event` is called every `max_wait_time` when no events are received and `max_wait_time` is not `None` or 0.
- Param event of `PartitionContext.update_checkpoint` is now optional. The last received event is used when param event is not passed in.
- `EventData.system_properties` has added missing properties when consuming messages from IotHub. #10408

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
