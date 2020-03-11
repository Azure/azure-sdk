---
title: Azure SDK for Python (March 2020)
layout: post
date: March 2020
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the March 2020 client library GA release.

This release includes the following:

#### GA

Event Hubs

#### Preview

Text Analytics


## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install azure-eventhub
pip install azure-eventhub-checkpointstoreblob
pip install azure-eventhub-checkpointstoreblob-aio
pip install azure-storage-blob
pip install --pre azure-storage-file-datalake
pip install --pre azure-storage-file-share
pip install azure-storage-queue
pip install azure-keyvault-certificates
pip install azure-keyvault-keys
pip install azure-keyvault-secrets
pip install azure-identity
pip install --pre azure-ai-textanalytics
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhub/CHANGELOG.md#501-2020-03-09)
- Fixed a bug that swallowed errors when receiving events with azure.eventhub.EventHubConsumerClient #9660
- Fixed a bug that caused get_eventhub_properties, get_partition_ids, and get_partition_properties to raise an error on Azure Stack #9920

### Event Hubs CheckpointStoreBlob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhub-checkpointstoreblob/CHANGELOG.md#110-2020-03-09)

- Param api_version of BlobCheckpointStore now supports older versions of Azure Storage Service API.


### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#change-log-azure-ai-textanalytics)

- Pass `"none"` into `country_hint` to not use the default of `"US"` for the `detect_language` method
- Parameters `country_hint` and `language` are now passed as keyword arguments

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
