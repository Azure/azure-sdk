---
title: Azure SDK for Python (September 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the September 2020 client library release.

#### GA

- Form Recognizer

#### Updates

- Key Vault Certificates
- App Configuration
- Event Hubs

#### Preview

- Event Grid
- Search
- Tables
- Identity
- Key Vault Administration

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-ai-formrecognizer
pip install azure-eventgrid --pre
pip install azure-identity --pre
pip install azure-keyvault-administration
pip install azure-keyvault-certificates
pip install azure-search-documents --pre
pip install azure-appconfiguration
pip install azure-eventhubs
pip install azure-eventhub-checkpointstoreblob
pip install azure-eventhub-checkpointstoreblob-aio
pip install azure-data-tables
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-2020-08-20)

- Generally available, stable version 3.0.0 released

### Event Grid [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventgrid/azure-eventgrid/CHANGELOG.md#200b1-2020-09-08)

- Azure Event Grid v2 preview SDK (v2.0.0b1) is released with support for CloudEvent

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/CHANGELOG.md#150b1-2020-09-08)

- Reintroduced user authentication API from the last beta version (1.4.0b7)
- Added support for ADFS and Subject Name/Issuer authentication

### Key Vault

#### Administration [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-administration/CHANGELOG.md#400b1-2020-09-08)

- First beta release with support for role-based access control, full-vault backup, and full-vault restore and selective key restore operations

#### Certificates [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-certificates/CHANGELOG.md#421-2020-09-08)

- Fixed incompatibility issues with API version `2016-10-01`

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md)

#### Features

- Added azure.search.documents.RequestEntityTooLargeError
- Flush method in BatchClient now will not return until all actions are done

#### Breaking Changes

- Removed succeeded_actions & failed_actions from BatchClient
- Removed get_index_document_batching_client from SearchClient

### Application Configuration [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/appconfiguration/azure-appconfiguration/CHANGELOG.md)

#### Features

- Added match condition support for set_read_only method

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhub/CHANGELOG.md)

#### Features

- Added `SharedAccessSignature` support to connection strings

### Event Hubs CheckpointStoreBlob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhub-checkpointstoreblob/CHANGELOG.md)

#### Key Bug Fixes

- Fixes a bug that may gradually slow down retrieving checkpoint data if the storage account has "File share soft delete" enabled.

### Azure Data Tables [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/tables/azure-data-tables/CHANGELOG.md)

#### Features

- Azure Data Tables v2 preview SDK (v12.0.0b1) is released with support for Storage and CosmosDB

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
