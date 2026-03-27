---
title: Azure SDK for Python (October 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### GA

- Management Library - Compute
- Management Library - Network
- Management Library - Resource
- Management Library - Storage
- Management Library - Monitor
- Management Library - AppConfiguration
- Management Library - Event Hubs
- Management Library - KeyVault

#### Updates

- App Configuration
- Identity
- Key Vault Keys

#### Beta

- Storage
- Service Bus
- Search
- Text Analytics
- Metrics Advisor
- Key Vault Administration

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-servicebus --pre
pip install azure-search-documents --pre
pip install azure-appconfiguration
pip install azure-ai-textanalytics --pre
pip install azure-ai-metricsadvisor --pre
pip install azure-identity
pip install azure-keyvault-administration
pip install azure-keyvault-keys
pip install azure-mgmt-compute
pip install azure-mgmt-network
pip install azure-mgmt-resource
pip install azure-mgmt-storage
pip install azure-mgmt-monitor
pip install azure-mgmt-appconfiguration
pip install azure-mgmt-eventhub
pip install azure-mgmt-keyvault
pip install azure-storage-blob --pre
pip install azure-storage-file-datalake --pre
pip install azure-storage-file-share --pre
pip install azure-storage-queue
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/servicebus/azure-servicebus/CHANGELOG.md)

#### Breaking changes

* Passing any type other than `ReceiveMode` as parameter `receive_mode` now throws a `TypeError` instead of `AttributeError`.
* Administration Client calls now take only entity names, not `<Entity>Descriptions` as well to reduce ambiguity in which entity was being acted on. TypeError will now be thrown on improper parameter types (non-string).
* `AMQPMessage` (`Message.amqp_message`) properties are now read-only, changes of these properties would not be reflected in the underlying message.  This may be subject to change before GA.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/search/azure-search-documents/CHANGELOG.md)

#### New Features

- Added auto_flush_interval support for SearchIndexingBufferedSender

#### Breaking Changes

- Renamed SearchIndexDocumentBatchingClient to SearchIndexingBufferedSender
- Renamed SearchIndexDocumentBatchingClient.add_upload_actions to SearchIndexingBufferedSender.upload_documents
- Renamed SearchIndexDocumentBatchingClient.add_delete_actions to SearchIndexingBufferedSender.delete_documents
- Renamed SearchIndexDocumentBatchingClient.add_merge_actions to SearchIndexingBufferedSender.merge_documents
- Renamed SearchIndexDocumentBatchingClient.add_merge_or_upload_actions to SearchIndexingBufferedSender.merge_or_upload_documents
- Stopped supporting window kwargs for SearchIndexingBufferedSender
- Split kwarg hook into on_new, on_progress, on_error, on_remove for SearchIndexingBufferedSender

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b2-2020-10-06)

#### Breaking changes

* Removed extra property `length` from relevant models. Originally, this property represented the length of the `text` property in those same models. To get the length of the text in these models, just call `len()` on the text property.

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/identity/azure-identity/CHANGELOG.md#141-2020-10-07)

#### Key Bug Fixes
- Fixed a bug causing tokens acquired from the Azure CLI to have incorrectly long lifetimes

### Key Vault

#### Administration [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/keyvault/azure-keyvault-administration/CHANGELOG.md#400b2-2020-10-06)

#### New Features
- `KeyVaultBackupClient.get_backup_status` and `.get_restore_status` enable checking the status of a pending operation by its job ID

#### Breaking Changes
- The `role_assignment_name` parameter of `KeyVaultAccessControlClient.create_role_assignment` is now an optional keyword-only argument. The client will generate a name for the assignment when one isn't provided.

#### Keys [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#430-2020-10-06)

#### New Features
- CryptographyClient can perform decrypt and sign operations locally

### Azure Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md)

##### New Features
- Added support for Arrow format (`ArrowType`) output serialization using `quick_query()`.
- Added support for undeleting a container.
- Added support for `LastAccessTime` property on a blob, which could be the last time a blob was written or read.

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

##### New Features
- Added support for recursive set/update/remove Access Control on a path and sub-paths.
- Added support for setting an expiry on files where the file gets deleted once it expires.
- Added support to generate directory SAS and added support to specify additional user ids and correlation ids for user delegation SAS.

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

##### New Features
- Added support for enabling SMB Multichannel for the share service.
- Added support for leasing a share.
- Added support for getting the range diff between current file and a snapshot as well as getting the diff between two file snapshots.

### Management Libraries
We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Python](https://azure.github.io/azure-sdk/python/guidelines/). These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. Documentation and code samples for these new libraries can be found [here](https://aka.ms/azsdk/python/mgmt)

More details of recent management library release annoucements as well as future roadmap can be found at [this blog post](https://devblogs.microsoft.com/azure-sdk/october-2020-management-ga/)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
