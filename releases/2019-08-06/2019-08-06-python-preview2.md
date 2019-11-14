---
title: Azure SDK for Python (August 2019 Preview)
layout: post
date: 6 Aug 2019
tags: python
sidebar: python_sidebar
repository: azure/azure-sdk-for-python
permalink: /releases/2019-08-06/python.html
---

The Azure SDK team is pleased to make available the August 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for Azure Cosmos, Identity, Key Vault (keys and secrets), Event Hubs, and Storage (blob, files and queues).

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
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

### Azure Identity

- Added new user credential types, allowing authentication within client applications.

### Event Hubs

- Expanded support for sending multiple messages in a single call by adding the ability to create a batch which avoids the error scenario of exceeding size limits. Users having bandwidth concerns can control the batch size as desired.
- Introduced a new model for consuming events via the EventProcessor class. This simplifies the process of checkpointing today and will handle load balancing across partitions in upcoming updates.

### Key Vault

- Added support for cryptographic operations (such as sign, verify, encrypt, and decrypt) using KeyVault keys.
- Added support for challenge based authentication.

### Storage

- Added async API support for all supported storage types (blobs, files, and queues).

## Quick Links

See [Nov Release](..\2019-11\python.html)

{% include refs.md %}
