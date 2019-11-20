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

See [Nov Release](..\2019-11\python.html)

{% include refs.md %}
