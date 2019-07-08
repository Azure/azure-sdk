# Azure SDK for Python Preview 1 Release Notes 

The Azure SDK team is pleased to make available the July 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for AzureCosmos, Identity, Key Vault (keys and secrets), Event Hubs, and Storage (blob, files and queues).

## Installation Instructions
To install the latest preview version of all the of the packages, copy and paste the below into a terminal.

    `pip install --pre azure-cosmos azure-storage azure-eventhub azure-keyvault-keys azure-keyvault-secrets azure-storage-blob azure-storage-file azure-storage-queue`

To install the latest preview version individually:

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
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/auzre/azure-sdk-for-python/issues).


## Changelog
Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Identity

Azure Identity simplifies authentication across the Azure Python libraries. It supports token authentication using an Azure Active Directory [service principal](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli) or [managed identity](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview). Additional forms of authentication (e.g. user authentication) will be added shortly.


### Cosmos

> TODO: Fill in...

### Keyvault

* The `azure-keyvault` packages has been split into `azure-keyvault-keys` and `azure-keyvault-secrets`. We will add `azure-keyvault-certificates` shortly.


> Note: The `azure-keyvault-keys` and `azure-keyvault-secrets` packages cannot be installed into the same environment as the existing `azure-keyvault` package.

#### Keys

* The `Azure
* Added support for `async` clients.


#### Secrets

Azure Key Vault is a cloud service that provides a secure storage of secrets, such as passwords and database connection strings. The [`azure-keyvault-secrets`](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets) library allows you to securely store and tightly control the access to tokens, passwords, API keys, and other secrets. This library offers operations to create, retrieve, update, delete, purge, backup, restore and list the secrets and its versions.

* Added support for `async` clients.

### Storage

#### Blobs

Azure Blob storage is Microsoft's object storage solution for the cloud. Blob storage is optimized for storing massive amounts of unstructured data, such as text or binary data.

#### Files

Azure File offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol. Azure file shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS. Additionally, Azure file shares can be cached on Windows Servers with Azure File Sync for fast access near where the data is being used.

#### Queues

Azure Storage Queues is a service for storing large numbers of messages that can be accessed from anywhere in the world via authenticated calls using HTTP or HTTPS. A single queue message can be up to 64 KB in size, and a queue can contain millions of messages, up to the total capacity limit of a storage account.

## Quick Links
TODO: fill out table and update links
| Library  | Install | Quickstart |  API Reference | Changelog |
| -- | -- | -- | -- | -- |
| azure-identity | [package](https://pypi.org/project/azure-identity/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/identity/azure-identity) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.identity.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md) |
| azure-eventhub | [package](https://pypi.org/project/azure-eventhub/5.0.0b1/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs/HISTORY.md) |
| azure-keyvault-keys | [package](https://pypi.org/project/azure-keyvault-keys/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.keys.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md) |
| azure-keyvault-secrets | [package](https://pypi.org/project/azure-keyvault-secrets/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.secrets.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/HISTORY.md) |
| azure-storage-blob | [package](https://pypi.org/project/azure-storage-blob/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.blob.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-blob/HISTORY.md) |
| azure-storage-file | [package](https://pypi.org/project/azure-storage-file/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.file.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/HISTORY.md) |
| azure-storage-queue | [package](https://pypi.org/project/azure-storage-queue/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.queue.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/HISTORY.md) |
| azure-cosmos | [package](https://pypi.org/project/azure-cosmos/4.0.0b1/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-storage-cosmos) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.cosmos.html) | [changelog.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos/changelog.md) |