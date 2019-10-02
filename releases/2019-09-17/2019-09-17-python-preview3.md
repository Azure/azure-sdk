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

| Library  | Install | Quickstart |  API Reference | Changelog | Samples |
| -- | -- | -- | -- | -- | -- |
| azure-cosmos | [package](https://pypi.org/project/azure-cosmos/4.0.0b2/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.cosmos.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/cosmos/azure-cosmos/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos/samples) |
| azure-eventhub | [package](https://pypi.org/project/azure-eventhub/5.0.0b3/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs/examples) |
| azure-eventhub-checkpointstoreblob-aio | [package](https://pypi.org/project/azure-eventhub-checkpointstoreblob-aio/1.0.0b1/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs-checkpointstoreblob-aio) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.extensions.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs-checkpointstoreblob-aio/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs-checkpointstoreblob-aio/examples) |
| azure-keyvault-certificates | [package](https://pypi.org/project/azure-keyvault-certificates/4.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-certificates) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.certificates.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-certificates/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-certificates/samples) |
| azure-keyvault-keys | [package](https://pypi.org/project/azure-keyvault-keys/4.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.keys.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys/samples) |
| azure-keyvault-secrets | [package](https://pypi.org/project/azure-keyvault-secrets/4.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.secrets.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets/samples) |
| azure-storage-blob | [package](https://pypi.org/project/azure-storage-blob/12.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.blob.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-blob/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob/tests) |
| azure-storage-file | [package](https://pypi.org/project/azure-storage-file/12.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.file.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/tests) |
| azure-storage-queue | [package](https://pypi.org/project/azure-storage-queue/12.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.queue.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/tests) | 
| azure-appconfiguration | [package](https://pypi.org/project/azure-appconfiguration/1.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/appconfiguration/azure-appconfiguration) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.appconfiguration.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/appconfiguration/azure-appconfiguration/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/appconfiguration/azure-appconfiguration/examples) |
| azure-identity | [package](https://pypi.org/project/azure-identity/1.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/identity/azure-identity) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.identity.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/HISTORY.md) |  |
| azure-core | [package](https://pypi.org/project/azure-core/1.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/core/azure-core) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.core.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/core/azure-core/HISTORY.md) |  |

