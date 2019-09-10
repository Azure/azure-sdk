---
title: Azure SDK for Python (September 2019 Preview)
layout: post
date: 17 Sep 2019
tags: python
sidebar: python_sidebar
repository: azure/azure-sdk-for-python
permalink: /releases/2019-09-17/python.html
---

The Azure SDK team is pleased to make available the September 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for Azure Cosmos, Identity, Key Vault (keys and secrets), Event Hubs, and Storage (blob, files and queues).

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install --pre azure-eventhub
pip install --pre azure-identity
pip install --pre azure-cosmos
pip install --pre azure-keyvault-keys
pip install --pre azure-keyvault-secrets
pip install --pre azure-storage-blob
pip install --pre azure-storage-file
pip install --pre azure-storage-queue
```

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).


## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Azure Identity

- [TO BE FILLED]

### Cosmos

- The client connection has been adapted to consume the HTTP pipeline defined in `azure.core.pipeline`.
- The constructor of `CosmosClient` has been updated.
- The interactive objects (`Container`, `Database` etc) have been renamed with a `Proxy` suffix.
- Some `read_all` operations (e.g. `read_all_databases`) have been renamed to list operations (e.g. `list_databases`).
- A new connection string constructor has been added to `CosmosClient`.
- All operations that take `request_options` or `feed_options` parameters, these have been moved to keyword only parameters.
- A new error heirarchy that now inherits from `azure.core.AzureError` instead of `CosmosError`.

### Event Hubs

- [TO BE FILLED]

### Key Vault

- [TO BE FILLED]

### Storage

- [TO BE FILLED]

## Quick Links

| Library  | Install | Quickstart |  API Reference | Changelog |
| -- | -- | -- | -- | -- |
| azure-identity | [package](https://pypi.org/project/azure-identity/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/identity/azure-identity) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.identity.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/HISTORY.md) |
| azure-cosmos | [package](https://pypi.org/project/azure-cosmos/4.0.0b2/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.cosmos.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/cosmos/azure-cosmos/HISTORY.md) |
| azure-eventhub | [package](https://pypi.org/project/azure-eventhub/5.0.0b3/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs/HISTORY.md) |
| azure-keyvault-keys | [package](https://pypi.org/project/azure-keyvault-keys/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.keys.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md) |
| azure-keyvault-secrets | [package](https://pypi.org/project/azure-keyvault-secrets/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.secrets.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/HISTORY.md) |
| azure-storage-blob | [package](https://pypi.org/project/azure-storage-blob/12.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.blob.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-blob/HISTORY.md) |
| azure-storage-file | [package](https://pypi.org/project/azure-storage-file/12.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.file.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/HISTORY.md) |
| azure-storage-queue | [package](https://pypi.org/project/azure-storage-queue/12.0.0b3) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.queue.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/HISTORY.md) |

{% include refs.md %}
