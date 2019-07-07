# Azure SDK for Python Preview 1 Release Notes 

The Azure SDK team is pleased to make available the July 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for AzureCosmos, Identity, Key Vault (keys and secrets), Event Hubs, and Storage (blob, files and queues).

## Installation Instructions
To install the latest preview version of all the of the packages, copy and paste the below into a terminal.

    `pip install --pre azure-cosmos azure-storage azure-eventhubs azure-keyvault-keys azure-keyvault-secrets azure-storage-blob azure-storage-file azure-storage-queue`

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

* New clients corresponding to each level in the object hierarchy (account, container, database etc.) have been created. You can directly access child clients by name.

### Keyvault

* The `azure-keyvault` packages has been split into `azure-keyvault-keys` and `azure-keyvault-secrets`. We intend to add `azure-keyvault-secrets` shortly.

> Note: The `azure-keyvault-keys` and `azure-keyvault-secrets` packages cannot be installed into the same environment as the existing `azure-keyvault` package.

#### Keys

* A new `azure.keyvault.keys.KeyClient` type is introduced. 
* Added support for `async` service methods using the `azure.keyvault.keys.aio.KeyClient`.

#### Secrets

* A new `azure.keyvault.secrets.SecretClient` type is introduced. 
* Added support for `async` service methods using the `azure.keyvault.secrets.aio.SecretClient`.

### Storage

#### Blobs

* Create a new set of clients (`BlobServiceClient`, `ContainerClient`, `BlobClient`) corresponding to the storage account, the container and individual blobs respectively.
* Allow callers to specify the blob type in individual method calls rather than instantiating different client types depending on which blob type they want to interact with.


## Quick Links

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