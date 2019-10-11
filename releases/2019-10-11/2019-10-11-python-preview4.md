---
title: Azure SDK for Python (October 2019 Preview)
layout: post
date: 11 Oct 2019
tags: python
sidebar: python_sidebar
repository: azure/azure-sdk-for-python
permalink: /releases/2019-10-11/python.html
---

The Azure SDK team is pleased to make available the October 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for Azure Cosmos, Identity, Key Vault (certificates, keys and secrets), Event Hubs, and Storage (blob, files and queues).

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

- Added support for a `timeout` keyword argument to all operations to specify an absolute timeout in seconds within which the operation must be completed. If the timeout value is exceeded, a `azure.cosmos.errors.CosmosClientTimeoutError` will be raised.
- Added a new `ConnectionRetryPolicy` to manage retry behaviour during HTTP connection errors, along with constructor and per-operation keyword arguments to configure retry behavior.

### Event Hubs

- Added support for tracing ([issue #7153](https://github.com/Azure/azure-sdk-for-python/issues/7153)).
- Added new boolean type parameter `track_last_enqueued_event_properties` in method `EventHubClient.create_consumer()`.
- Added new property `last_enqueued_event_properties` of EventHubConsumer which contains `sequence_number`, `offset`, `enqueued_time` and `retrieval_time information`.
- Removed support for IoT Hub direct connection. EventHubs compatible connection string of an IotHub can be used to create EventHubClient and read properties or events from an IoT Hub.
- Removed support for sending EventData to IoT Hub.
- Removed parameter exception in method `close()` of EventHubConsumer and EventHubProcuer.

### Key Vault

- Restructured the `Certificate`, `Key`, and `Secret` models. For more specific details, see the respective
[certificate](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-certificates/HISTORY.md),
[key](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md),
and [secret](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/HISTORY.md) changelogs.
- Both async and sync versions of `create_certificate` return pollers now that poll on the certificate's successful creation

### Storage

- Added batching support in blobs.
- Added support to set rehydrate priority in blobs.
- Breaking changes in `PermissionModels` for blobs, queues and files.
- Modified several methods in blobs to use more keyworrd-only arguments.
- Other breaking changes in blobs, queues and files.

### Identity
- `AuthorizationCodeCredential` authenticates with a previously obtained
authorization code. See Azure Active Directory's
[authorization code documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-auth-code-flow)
for more information about this authentication flow.
- Multi-cloud support: client credentials accept the authority of an Azure Active
Directory authentication endpoint as an `authority` keyword argument. Known
authorities are defined in `azure.identity.KnownAuthorities`. The default
authority is for Azure Public Cloud, `login.microsoftonline.com`
(`KnownAuthorities.AZURE_PUBLIC_CLOUD`).

## Quick Links

| Library  | Install | Quickstart |  API Reference | Changelog | Samples |
| -- | -- | -- | -- | -- | -- |
| azure-cosmos | [package](https://pypi.org/project/azure-cosmos/4.0.0b4/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.cosmos.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/cosmos/azure-cosmos/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/cosmos/azure-cosmos/samples) |
| azure-eventhub | [package](https://pypi.org/project/azure-eventhub/5.0.0b4/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs/examples) |
| azure-eventhub-checkpointstoreblob-aio | [package](https://pypi.org/project/azure-eventhub-checkpointstoreblob-aio/1.0.0b4/) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs-checkpointstoreblob-aio) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.eventhub.extensions.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhubs-checkpointstoreblob-aio/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/eventhub/azure-eventhubs-checkpointstoreblob-aio/examples) |
| azure-keyvault-certificates | [package](https://pypi.org/project/azure-keyvault-certificates/4.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-certificates) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.certificates.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-certificates/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-certificates/samples) |
| azure-keyvault-keys | [package](https://pypi.org/project/azure-keyvault-keys/4.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys) |  [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.keys.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-keys/samples) |
| azure-keyvault-secrets | [package](https://pypi.org/project/azure-keyvault-secrets/4.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.keyvault.secrets.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/keyvault/azure-keyvault-secrets/samples) |
| azure-storage-blob | [package](https://pypi.org/project/azure-storage-blob/12.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.blob.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/storage/azure-storage-blob/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-blob/tests) |
| azure-storage-file | [package](https://pypi.org/project/azure-storage-file/12.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.file.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-file/tests) |
| azure-storage-queue | [package](https://pypi.org/project/azure-storage-queue/12.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.storage.queue.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/storage/azure-storage-queue/tests) |
| azure-appconfiguration | [package](https://pypi.org/project/azure-appconfiguration/1.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/appconfiguration/azure-appconfiguration) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.appconfiguration.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/appconfiguration/azure-appconfiguration/HISTORY.md) | [Samples](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/appconfiguration/azure-appconfiguration/examples) |
| azure-identity | [package](https://pypi.org/project/azure-identity/1.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/identity/azure-identity) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.identity.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/HISTORY.md) |  |
| azure-core | [package](https://pypi.org/project/azure-core/1.0.0b4) | [Readme.md](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/core/azure-core) | [Preview Documentation](https://azure.github.io/azure-sdk-for-python/ref/azure.core.html) | [History.md](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/core/azure-core/HISTORY.md) |  |

{% include refs.md %}
