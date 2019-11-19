---
title: Azure SDK for Python (September 2019 Preview)
layout: post
date: 17 Sep 2019
tags: python
sidebar: python_sidebar
repository: azure/azure-sdk-for-python
permalink: /releases/2019-09-17/python.html
---

The Azure SDK team is pleased to make available the September 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for Azure Cosmos, Identity, Key Vault (certificates, keys and secrets), Event Hubs, and Storage (blob, files and queues).

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install --pre azure-cosmos
pip install --pre azure-eventhub
pip install --pre azure-eventhub-checkpointstoreblob-aio
pip install --pre azure-keyvault-certificates
pip install --pre azure-keyvault-keys
pip install --pre azure-keyvault-secrets
pip install --pre azure-storage-blob
pip install --pre azure-storage-file
pip install --pre azure-storage-queue
pip install --pre azure-appconfiguration
pip install --pre azure-identity
```

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).


## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Cosmos

- The client connection has been adapted to consume the HTTP pipeline defined in `azure.core.pipeline`.
- The constructor of `CosmosClient` has been updated.
- The interactive objects (`Container`, `Database` etc) have been renamed with a `Proxy` suffix.
- Some `read_all` operations (e.g. `read_all_databases`) have been renamed to list operations (e.g. `list_databases`).
- A new connection string constructor has been added to `CosmosClient`.
- All operations that take `request_options` or `feed_options` parameters, these have been moved to keyword only parameters.
- A new error hierarchy that now inherits from `azure.core.AzureError` instead of `CosmosError`.

### Event Hubs

- Added `EventProcessor` load balancing.
- First release of `azure-eventhub-checkpointstoreblob-aio` using Azure Blob Storage to save checkpoint data.
- Removed constructor method of `PartitionProcessor`.
- Replaced `CheckpointManager` with `PartitionContext`.
- Updated all methods of `PartitionProcessor` to include `PartitionContext` as part of the arguments.
- Updated accessibility of most class members in `EventHub/EventHubConsumer/EventHubProducer`to be private.
- Moved `azure.eventhub.eventprocessor` to under `aio` package, which now becomes `azure.eventhub.aio.eventprocessor`.
- Added property `system_properties` on `EventData`.

### Key Vault

- Release of `azure-keyvault-certificates` supporting the certificates API
- `CryptographyClient` can perform encrypt/verify/wrap operations locally

### Storage

- Added support for client provided encryption key to numerous APIs.
- Added support for `append_block_from_url`, `upload_pages_from_url` in blobs.
- Added SAS support for snapshot and identity.
- Added upload_range_from_url API to write the bytes from one Azure File endpoint into the specified range of another Azure File endpoint.
- Added optional parameters for smb properties related parameters for create_file*, create_directory* related APIs and set_http_headers API.

### Identity
- Added a new credential type enabling shared sign-on with other Microsoft applications running on Windows, such as Visual Studio.

## Quick Links

See [Nov Release](..\2019-11\python.html)
