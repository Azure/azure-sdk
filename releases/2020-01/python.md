---
title: Azure SDK for Python (January 2020)
layout: post
date: January 2020
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the January 2020 client library GA release. This GA release includes new and updated client libraries for App Configuration, Identity, Key Vault (keys, secrets and certificates), Event Hubs and Storage (Blobs, Queues, and File share). Some of the libraries are released as preview such as Text Analytics, and Storage Datalake.

This release includes the following:

#### GA

- App Configuration
- Event Hubs
- Storage (Blobs, Queues, File Shares)
- Key Vault (Certificates, Secrets, Keys)
- Identity

#### Preview

- Text Analytics
- Storage (Data Lake)

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install --pre azure-eventhub
pip install --pre azure-eventhub-checkpointstoreblob-aio
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

### App Configuration

- Add AAD auth support

### Event Hubs

- Added support for tracing ([issue #7153](https://github.com/Azure/azure-sdk-for-python/issues/7153)).
- Added new boolean type parameter `track_last_enqueued_event_properties` in method `EventHubClient.create_consumer()`.
- Added new property `last_enqueued_event_properties` of EventHubConsumer which contains `sequence_number`, `offset`, `enqueued_time` and `retrieval_time information`.
- Removed support for IoT Hub direct connection. EventHubs compatible connection string of an IotHub can be used to create EventHubClient and read properties or events from an IoT Hub.
- Removed support for sending EventData to IoT Hub.
- Removed parameter exception in method `close()` of EventHubConsumer and EventHubProcuer.

### Storage

- The first preview for azure-storage-file-datalake has been released to allow accessing Azure Storage data with DataLake semantics when hierarchical namespace is enabled
- `azure.storage.file` is now `azure.storage.fileshare`.
  - The package is renamed from `azure-storage-file` to `azure-storage-file-share` along with renamed client modules.
- New API for stream download responses for blobs and files. This object is no longer iterable.
- Client and model modules are now internal.
- Changed optional params to keyword only in queues and files.
- `enqueue_message` is now called `send_message` in queues.
- Other breaking changes like renaming `LeaseClient` in blobs to `BlobLeaseClient`.

### Key Vault

- GA release of certificates

### Identity

- `DefaultAzureCredential` accepts an `authority` keyword argument, enabling
its use in national clouds
- All credentials with `tenant_id` and `client_id` positional parameters now accept them in that order
- Optional parameters for several credentials are now keyword arguments
- Authenticating with a single sign-on shared with other Microsoft applications
only requires a username when multiple users have signed in
- Async credentials default to [aiohttp](https://pypi.org/project/aiohttp/)
for transport
- Known issue ([#8292](https://github.com/Azure/azure-sdk-for-python/issues/8292)):
`DefaultAzureCredential` and `SharedTokenCredential` raise exceptions on Python 3.8
on Windows

### Text Analytics

- The first preview with new API design for the azure-ai-textanalytics client library
- New APIs include `recognize_linked_entities` and `recognize_pii_entities`, and an improved version of `analyze_sentiment`
- New underlying REST pipeline implementation based on the `azure-core` library
- Authentication with subscription key or Azure Active Directory supported
- Module-level, single text operations provided for performing analysis on a single string
- Asynchronous API operations added under `azure.ai.textanalytics.aio`
- New input types allow user to provide a list of strings as the input documents 
- Responses now consist of a heterogeneous list of results and document errors returned in the order of the provided documents
- Keyword argument `model_version` can be used to specify the model version used to analyze documents
- Keyword arguments `default_country_hint` and `default_language` allow users to specify the defaults at client instantiation

## Quick Links

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
