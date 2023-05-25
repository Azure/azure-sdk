---
title: Azure SDK for Python (March 2020)
layout: post
date: 2020-03-17
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the March 2020 client library GA release.

This release includes the following:

#### GA

- Key Vault
- Event Hubs
- Storage DataLake

#### Preview

- Text Analytics
- Identity
- Search


## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install azure-eventhub
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
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Key Vault

- Sockets opened by a client can be closed by calling the client's `close` method, or using the client as a context manager

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub/CHANGELOG.md#501-2020-03-09)
- Fixed a bug that swallowed errors when receiving events with azure.eventhub.EventHubConsumerClient #9660
- Fixed a bug that caused get_eventhub_properties, get_partition_ids, and get_partition_properties to raise an error on Azure Stack #9920

### Event Hubs CheckpointStoreBlob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub-checkpointstoreblob/CHANGELOG.md#110-2020-03-09)

- Param api_version of BlobCheckpointStore now supports older versions of Azure Storage Service API.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#change-log-azure-ai-textanalytics)

- Pass `"none"` into `country_hint` to not use the default of `"US"` for the `detect_language` method
- Parameters `country_hint` and `language` are now passed as keyword arguments

### Identity
- (Preview) `DefaultAzureCredential` can authenticate with the identity logged in to the Azure CLI.

### Search
- (Preview) Initial release of Python SDK for Azure Cognitive Search

### Storage File Datalake [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)
- This library is now Generally Available.
- Added `set_file_system_access_policy` and `get_file_system_access_policy` APIs on `FileSystemClient`
- Added `upload_data` API on `DataLakeFileClient` to support bulk upload.
- There have been some breaking changes in the APIs which you can explore in the changelog.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
