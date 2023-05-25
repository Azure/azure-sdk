---
title: Azure SDK for Python (July 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the July 2020 client library release.

#### GA

- Search

#### Updates

- _Add packages_

#### Preview

- Management Library - Compute
- Management Library - Network
- Management Library - Resource
- Management Library - Storage
- Management Library - Monitor
- Management Library - AppConfiguration
- Management Library - Event Hubs
- Management Library - KeyVault
- Service Bus
- Storage
- Event Hubs
- Form Recognizer
- Identity

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
pip install --pre azure-servicebus
pip install --pre azure-eventhub
pip install azure-ai-formrecognizer
pip install --pre azure-identity
pip install azure-search-documents
pip install --pre azure-storage-blob
pip install --pre azure-storage-blob-changefeed
pip install --pre azure-storage-file-datalake
pip install --pre azure-storage-file-share
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### New Management Libraries

A new set of management libraries that follow the [Azure SDK Design Guidelines for Python](https://azure.github.io/azure-sdk/python/guidelines/) are now in Public Preview. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more.
You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/python.html). Documentation and code samples for these new libraries can be found [here](https://azure.github.io/azure-sdk-for-python)

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/servicebus/azure-servicebus/CHANGELOG.md)

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

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub/CHANGELOG.md)

#### New Features

- `EventHubConsumerClient` constructor accepts two new parameters for the load balancer.
    - `load_balancing_strategy`, which can be "greedy" or "balanced".
     With greedy strategy, one execution of load balancing will claim as many partitions as required to balance the load
     whereas with balanced strategy one execution of load balancing will claim at most 1 partition.
    - `partition_ownership_expiration_interval`, which allows you to customize the partition ownership expiration for load balancing.
     A consumer client may lose its owned partitions more often with a smaller expiration interval. But a larger interval
     may result in idle partitions not being claimed for longer time.
- Added enum class `azure.eventhub.LoadBalancingStrategy` for `load_balancing_strategy`.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#100b4-2020-07-07)

#### Breaking changes

- `begin_recognize_receipts` and `begin_recognize_receipts_from_url` now return a list of `RecognizedForm`
- Model and property renaming detailed in changelog

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/identity/azure-identity/CHANGELOG.md)

#### New Features

- Added `AzureCliCredential`, which authenticates as the identity signed in to the Azure CLI
- Added `VSCodeCredential`, which authenticates as the user signed in to Visual Studio Code's Azure Account extension.
- The optional persistent cache for `DeviceCodeCredential` and `InteractiveBrowserCredential` is supported on Linux and macOS.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/search/azure-search-documents/CHANGELOG.md)

#### New Features

- Exposed more models:

  * BM25SimilarityAlgorithm
  * ClassicSimilarityAlgorithm
  * EdgeNGramTokenFilterSide
  * EntityCategory
  * EntityRecognitionSkillLanguage
  * FieldMapping
  * FieldMappingFunction
  * ImageAnalysisSkillLanguage
  * ImageDetail
  * IndexerExecutionStatus
  * IndexerStatus
  * KeyPhraseExtractionSkillLanguage
  * MicrosoftStemmingTokenizerLanguage
  * MicrosoftTokenizerLanguage
  * OcrSkillLanguage
  * PhoneticEncoder
  * ScoringFunctionAggregation
  * ScoringFunctionInterpolation

### Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md)

##### New Features
- Added `query_blob` API to enable users to select/project on block blob or block blob snapshot data by providing simple query expressions
- Added blob versioning feature, so that every time there is a blob override the `version_id` will be updated automatically and returned in the response, the `version_id` could be used later to refer to the overwritten blob
- Added `set_blob_tags`, `get_blob_tags`, and `find_blobs_by_tags` to acquire blobs based on blob tags
- Block size is increased to 4GB at maximum, max single put size is increased to 5GB

#### Blob ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-blob-changefeed/CHANGELOG.md)

##### New Features
- Added a preview version of this library to support change feed

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

##### New Features
- Block size is increased to 4 GB max and max single put increased to 5 GB

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

##### New Features
- Added `undelete_share` on FileShareServiceClient

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
