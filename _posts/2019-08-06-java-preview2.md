---
title: Azure SDK for Java (August 2019 Preview)
layout: post
tags: java
sidebar: java_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to make available the August 2019 client library preview release. This represents the first release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new client libraries for Azure App Configuration, Cosmos, Identity, Key Vault (keys and secrets), Event Hubs, and Storage (Blobs, Files, and Queues).

## Installation Instructions
To use the preview libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-keys</artifactId>
  <version>4.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-secrets</artifactId>
  <version>4.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file</artifactId>
  <version>12.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.0.0-preview.2</version>
</dependency>
```

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog
Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

* Designed based on the [Azure SDK Design Guidelines for Java][java-guidelines], resulting in a consistent API design and common feature set such as HTTP retries, logging, transport protocols, authentication protocols, etc.
* Modernized API making use of Java 8 features such as streams, new date / time, functional interfaces, etc, to offer an improved and more productive developer experience.
* Synchronous and asynchronous APIs offer developers simplicity for simple cases, and full asynchronousity when performance and scalability matters. Reactive streams are offered using [Project Reactor](http://projectreactor.io).

### Azure Identity

- Added new user credential types, allowing new authentication flows (Interactive, Device code, Username/password). See [Microsoft Authentication Library (MSAL) authentication flows](https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-authentication-flows) for more details.

### Event Hubs

- Expanded support for sending multiple messages in a single call by adding the ability to create a batch which avoids the error scenario of exceeding size limits. Users having bandwidth concerns can control the batch size as desired.
- Introduced a new model for consuming events via the EventProcessor class. This simplifies the process of checkpointing today and will handle load balancing across partitions in upcoming updates.

### Key Vault

- Added support for cryptographic operations (such as sign, verify, encrypt, and decrypt) using KeyVault keys.
- Added support for challenge based authentication.

## Storage

- Added support for Azure Files and Azure Queue Storage.

## Need help?
* For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/track2reports/index.html).
* For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
* For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
* File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
* Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Quick Links

| Service  | Readme | Changelog | Samples | JavaDoc |
| -- | -- | -- | -- | -- |
| App Configuration | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/appconfiguration/azure-data-appconfiguration/README.md) | - | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/appconfiguration/azure-data-appconfiguration/src/samples/java) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Cosmos | [Readme](https://github.com/Azure/azure-cosmosdb-java/tree/v3/README.md) | - | [Samples](https://github.com/Azure/azure-cosmosdb-java/tree/v3/examples) | [JavaDoc](https://azure.github.io/azure-cosmosdb-java/3.0.0/) |
| Key Vault - Keys | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-keyvault-keys/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/keyvault/azure-keyvault-keys/src/samples/java) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Key Vault - Secrets | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-keyvault-secrets/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-keyvault-secrets/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/keyvault/azure-keyvault-secrets/src/samples/java) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Event Hubs | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventhubs/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventhubs/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/eventhubs/azure-eventhubs/src/samples/java) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - Blob | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/storage/client/blob/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/storage/client/blob/CHANGELOG.md) | - | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - File | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/storage/client/file/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/storage/client/file/CHANGELOG.md) | - | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - Queue | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/storage/client/queue/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/storage/client/queue/CHANGELOG.md) | - | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |

{% include refs.md %}