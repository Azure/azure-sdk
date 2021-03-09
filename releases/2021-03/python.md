---
title: Azure SDK for Python (March 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

- Event Hubs
- Event Hubs Checkpoint Store
- Event Hubs Checkpoint Store Async

#### Beta

- Event Hubs

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-eventhub==5.3.1
$> pip install azure-eventhub==5.4.0b1
$> pip install azure-eventhub-checkpointstoreblob==1.1.3
$> pip install azure-eventhub-checkpointstoreblob-aio==1.1.3
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Event Hubs 5.3.1 [Changelog](https://github.com/Azure/azure-sdk-for-python/tree/azure-eventhub_5.3.1/sdk/eventhub/azure-eventhub/CHANGELOG.md#531-2021-03-09)

This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

#### Bug fixes

- Sending empty `event_data_batch` will be a no-op now instead of raising error.

### Event Hubs 5.4.0b1 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/feature/eventhub%2Fidempotent-producer/sdk/eventhub/azure-eventhub/CHANGELOG.md#540b1-2021-03-09)

This version and all future versions will require Python 2.7 or Python 3.6+, Python 3.5 is no longer supported.

#### New Features

- Added support for idempotent publishing which is supported by the service to endeavor to reduce the number of duplicate
  events that are published.
  - `EventHubProducerClient` constructor accepts two new parameters for idempotent publishing:
    - `enable_idempotent_partitions`: A boolean value to tell the `EventHubProducerClient` whether to enable idempotency.
    - `partition_config`: The set of configurations that can be specified to influence publishing behavior
     specific to the configured Event Hub partition.
  - Introduced a new method `get_partition_publishing_properties` on `EventHubProducerClient` to inspect the information
    about the state of publishing for a partition.
  - Introduced a new property `published_sequence_number` on `EventData` to get the publishing sequence number assigned
    to the event at the time it was successfully published.
  - Introduced a new property `starting_published_sequence_number` on `EventDataBatch` to get the publishing sequence
    number assigned to the first event in the batch at the time the batch was successfully published.
  - Introduced a new class `azure.eventhub.PartitionPublishingConfiguration` which is a set of configurations that can be
    specified to influence the behavior when publishing directly to an Event Hub partition.

#### Notes

- Updated uAMQP dependency to 1.2.15.

### Event Hubs CheckpointStoreBlob 1.1.3 [Changelog](https://github.com/Azure/azure-sdk-for-python/tree/azure-eventhub-checkpointstoreblob_1.1.3/sdk/eventhub/azure-eventhub-checkpointstoreblob/CHANGELOG.md#113-2021-03-09)

This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

#### Bug fixes
- Updated vendor azure-storage-blob dependency to v12.7.1.
  - Fixed storage blob authentication failure due to request date header too old (#16192).

### Event Hubs CheckpointStoreBlob Async 1.1.3 [Changelog](https://github.com/Azure/azure-sdk-for-python/tree/azure-eventhub-checkpointstoreblob-aio_1.1.3/sdk/eventhub/azure-eventhub-checkpointstoreblob-aio/CHANGELOG.md#113-2021-03-09)

This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

#### Bug fixes
- Updated vendor azure-storage-blob dependency to v12.7.1.
  - Fixed storage blob authentication failure due to request date header too old (#16192).

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
