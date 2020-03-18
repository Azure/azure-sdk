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


#### Preview

Text Analytics
Identity


## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install --pre azure-eventhub
pip install --pre azure-eventhub-checkpointstoreblob-aio
pip install azure-storage-blob
pip install azure-storage-file-datalake
pip install azure-storage-file-share
pip install azure-storage-queue
pip install azure-keyvault-certificates
pip install azure-keyvault-keys
pip install azure-keyvault-secrets
pip install --pre azure-identity
pip install --pre azure-ai-textanalytics
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#change-log-azure-ai-textanalytics)

- Pass `"none"` into `country_hint` to not use the default of `"US"` for the `detect_language` method
- Parameters `country_hint` and `language` are now passed as keyword arguments


### Azure Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md)

- `StorageUserAgentPolicy` now replaced with `UserAgentPolicy` from azure-core.

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-file-share/CHANGELOG.md)

- `StorageUserAgentPolicy` now replaced with `UserAgentPolicy` from azure-core.

#### File Datalake [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

- This library is now Generally Available.
- There have been some breaking changes in the APIs which you can explore in the changelog.

### Identity
- (Preview) `DefaultAzureCredential` can authenticate with the identity logged in to the Azure CLI.

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
