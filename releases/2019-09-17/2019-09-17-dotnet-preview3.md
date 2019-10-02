---
title: Azure SDK for .NET (September 2019 Preview)
layout: post
date: 17 Sep 2019
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
permalink: /releases/2019-09-17/dotnet.html
---

The Azure SDK team is pleased to announce our September 2019 client library preview.  This represents the first release of a ground-up rewrite of our client libraries to ensure consistency, idiomatic design, productivity, and an excellent developer experience.  This preview includes new libraries for Storage (Blobs, Queues, and Files), Key Vault (Secrets and Keys), Event Hubs, Cosmos, and Identity.

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.Storage.Blobs --version 12.0.0-preview.3
    $> dotnet add package Azure.Storage.Queues --version 12.0.0-preview.3
    $> dotnet add package Azure.Storage.Files --version 12.0.0-preview.3

    $> dotnet add package Azure.Security.KeyVault.Secrets --version 4.0.0-preview.4
    $> dotnet add package Azure.Security.KeyVault.Keys --version 4.0.0-preview.4
    $> dotnet add package Azure.Security.KeyVault.Certificates --version 4.0.0-preview.4

    $> dotnet add package Azure.Messaging.EventHubs --version 5.0.0-preview.3

    $> dotnet add package Azure.Identity --version 1.0.0-preview.4

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

- New client libraries were created using the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) resulting in consistent API patterns and shared features like automatic retries, authentication, logging, configurable transport pipelines, exceptions, mocking, etc.
- Support for Azure Active Directory credentials using our new Identity library that embrace the future of authentication across Azure services.
- Parity across synchronous and asynchronous APIs offering a choice appropriate to your application.
- Updated dependencies on the latest (preview-7) version of `Azure.Core` library.

### Azure Identity

- Added new user credential types, allowing authentication within client applications.

### Event Hubs

- Expanded support for sending multiple messages in a single call by adding the ability to create a batch which avoids the error scenario of exceeding size limits. Users having bandwidth concerns can control the batch size as desired.
- Introduced a new model for consuming events via the `EventProcessor` class. This simplifies the process of checkpointing today and will handle load balancing across partitions in upcoming updates.
- Enabled the ability to subscribe to the events exposed by an `EventHubConsumer` in the form of an asynchronous iterator. With the iterator, consumers are able to use the familiar `foreach` pattern to receive events as they are available and to process them.

### Key Vault

- Added support for cryptographic operations (such as sign, verify, encrypt, and decrypt) using KeyVault keys.
- Added support for challenge based authentication.
- Initial release of the `Azure.Security.KeyVault.Certificates` client library, enablign management of Key Vault certificates, issuers, and contacts.

## Quick Links

| Service  | Install | Readme | Samples |  API Reference | Changelog |
| -- | -- | -- | -- | -- | -- |
| Core | [Package](https://www.nuget.org/packages/Azure.Core) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/core/Azure.Core/tests/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Core.html) | - |
| Identity | [Package](https://www.nuget.org/packages/Azure.Identity/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/README.md) | - | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Identity.html) | - |
| Cosmos | [Package](https://www.nuget.org/packages/Microsoft.Azure.Cosmos/) | [Readme](https://github.com/Azure/azure-cosmos-dotnet-v3/blob/master/README.md) | [Samples](https://github.com/Azure/azure-cosmos-dotnet-v3/tree/master/Microsoft.Azure.Cosmos.Samples/CodeSamples) | [API Reference](https://docs.microsoft.com/en-us/dotnet/api/microsoft.azure.cosmos?view=azure-dotnet-preview) | [Changelog](https://github.com/Azure/azure-cosmos-dotnet-v3/blob/master/changelog.md) |
| Event Hubs | [Package](https://www.nuget.org/packages/Azure.Messaging.EventHubs/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/eventhub/Azure.Messaging.EventHubs/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Messaging.EventHubs.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md) |
| Key Vault - Certificates | [Package](https://www.nuget.org/packages/Azure.Security.KeyVault.Certificates/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Certificates/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Certificates/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Security.KeyVault.Certificates.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Certificates/ChangeLog.md) |
| Key Vault - Keys | [Package](https://www.nuget.org/packages/Azure.Security.KeyVault.Keys/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Keys/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Keys/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Security.KeyVault.Keys.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Keys/ChangeLog.md) |
| Key Vault - Secrets | [Package](https://www.nuget.org/packages/Azure.Security.KeyVault.Secrets/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/keyvault/Azure.Security.KeyVault.Secrets/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Secrets/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Security.KeyVault.Secrets.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/keyvault/Azure.Security.KeyVault.Secrets/ChangeLog.md) |
| Storage - Blobs | [Package](https://www.nuget.org/packages/Azure.Storage.Blobs/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Blobs/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Storage.Blobs.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Blobs/Changelog.txt) |
| Storage - Common | [Package](https://www.nuget.org/packages/Azure.Storage.Common/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Common/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Common/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Storage.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Common/Changelog.txt) |
| Storage - Files | [Package](https://www.nuget.org/packages/Azure.Storage.Files/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Files/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Storage.Files.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Files/Changelog.txt) |
| Storage - Queues | [Package](https://www.nuget.org/packages/Azure.Storage.Queues/) | [Readme](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/README.md) | [Samples](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/storage/Azure.Storage.Queues/samples) | [API Reference](https://azure.github.io/azure-sdk-for-net/api/Azure.Storage.Queues.html) | [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/storage/Azure.Storage.Queues/Changelog.txt) |

