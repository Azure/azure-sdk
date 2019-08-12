---
title: Azure SDK for Python (July 2019 Preview)
date: 10 Jul 2019
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
permalink: /releases/2019-07-10/python.html
---

The Azure SDK team is pleased to make available the July 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for Azure Cosmos, Identity, Key Vault (keys and secrets), Event Hubs, and Storage (blob, files and queues).

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install --pre azure-cosmos
pip install --pre azure-eventhub
pip install --pre azure-identity
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

### Identity

* The new `azure-identity` package simplifies authentication across the Azure Python libraries. It supports token authentication using an Azure Active Directory [service principal](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) or [managed identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview). Additional forms of authentication (e.g. user authentication) will be added shortly.

### Cosmos

* New clients corresponding to each level in the object hierarchy (account, container, database etc.) have been created. You can directly access child clients by name.

### Keyvault

* The `azure-keyvault` package has been split into `azure-keyvault-keys` and `azure-keyvault-secrets`. We intend to add `azure-keyvault-certificates` shortly.

*Note: The `azure-keyvault-keys` and `azure-keyvault-secrets` packages cannot be installed into the same environment as the existing `azure-keyvault` package.*

#### Keys

* A new `azure.keyvault.keys.KeyClient` type is introduced. 
* Client instances are scoped to vaults (an instance interacts with one vault only)
* Asynchronous API supported on Python 3.5.3+

#### Secrets

* A new `azure.keyvault.secrets.SecretClient` type is introduced. 
* Client instances are scoped to vaults (an instance interacts with one vault only)
* Asynchronous API supported on Python 3.5.3+

### Storage

#### Blobs

New API design with separate clients for operations on the account, containers and blobs:

* `BlobServiceClient`: This client handles account-level operations. This includes managing service properties and listing the containers within an account.
* `ContainerClient`: The client handles operations for a particular container. This includes creating or deleting that container, as well as listing the blobs within that container and managing properties and metadata.
* `BlobClient`: The client handles operations for a particular blob. This includes creating or deleting that blob, as well as upload and download data and managing properties. This BlobClient handles all blob types (block, page and append). Where operations can behave differently according to type (i.e. upload_blob) the default behaviour will be block blobs unless otherwise specified.
* `LeaseClient`: Handles all lease operations for both containers and blobs.
These clients can be accessed by navigating down the client hierarchy, or instantiated directly using URLs to the resource (account, container or blob). For full details on the new API, please see the reference documentation.

#### Files

New API design with separate clients for operations on the account, files, shares and directories:

* `FileServiceClient`: This client handles account-level operations. This includes managing service properties and listing the shares within an account.
* `ShareClient`: The client handles operations for a particular share. This includes creating or deleting that share, as well as listing the directories within that share, and managing properties and metadata.
* `DirectoryClient`: The client handles operations for a particular directory. This includes creating or deleting that directory, as well as listing the files and subdirectories, and managing properties and metadata.
* `FileClient`: The client handles operations for a particular file. This includes creating or deleting that file, as well as upload and download data and managing properties.

These clients can be accessed by navigating down the client hierarchy, or instantiated directly using URLs to the resource (account, share, directory or file). For full details on the new API, please see the reference documentation.

#### Queues

New API design with separate clients for operations on the account and individual queues:

* `QueueServiceClient`: This client handles account-level operations. This includes managing service properties and listing the queues within an account.
* `QueueClient`: The client handles operations within a particular queue. This includes creating or deleting that queue, as well as enqueueing and dequeueing messages.

These clients can be accessed by navigating down the client hierarchy, or instantiated directly using URLs to the resource (account or queue). For full details on the new API, please see the reference documentation.

## Quick Links

| Library  | Install | Quickstart |  API Reference | Changelog |
| -- | -- | -- | -- | -- |
| azure-identity | [package](https://pypi.org/project/azure-identity/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/identity/azure-identity) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.identity.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/HISTORY.md) |
| azure-eventhub | [package](https://pypi.org/project/azure-eventhub/5.0.0b1/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs/HISTORY.md) |
| azure-keyvault-keys | [package](https://pypi.org/project/azure-keyvault-keys/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.keys.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md) |
| azure-keyvault-secrets | [package](https://pypi.org/project/azure-keyvault-secrets/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.secrets.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/HISTORY.md) |
| azure-storage-blob | [package](https://pypi.org/project/azure-storage-blob/12.0.0b1) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.blob.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-blob/HISTORY.md) |
| azure-storage-file | [package](https://pypi.org/project/azure-storage-file/12.0.0b1) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.file.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/HISTORY.md) |
| azure-storage-queue | [package](https://pypi.org/project/azure-storage-queue/12.0.0b1) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.queue.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/HISTORY.md) |
| azure-cosmos | [package](https://pypi.org/project/azure-cosmos/4.0.0b1/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.cosmos.html) | [changelog.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos/changelog.md) |

{% include refs.md %}