---
title: Azure SDK for Python (May 2020)
layout: post
date: 2020-05-01
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the {{ page.date | date: "%B %Y" }} client library GA release.

This release includes the following:

#### Preview



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
pip install --pre azure-search-documents
pip install --pre azure-servicebus
pip install azure-ai-formrecognizer
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/CHANGELOG.md)

- `DefaultAzureCredential` can authenticate as the user signed in to Visual Studio Code's Azure Account extension. No configuration is required. This feature is not yet supported on Python 2.7 on Linux.
- `DeviceCodeCredential` caches tokens in memory
- New API allowing applications to control when `DeviceCodeCredential` and `InteractiveBrowserCredential` prompt for authentication. See the full [changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/CHANGELOG.md) for more details.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md)

- Add service sub-clients for Skillsets, Synonym Maps, and Indexers operations 
- Add helpers for defining Search Index fields
- `SearchIndexClient` renamed to `SearchClient`

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
