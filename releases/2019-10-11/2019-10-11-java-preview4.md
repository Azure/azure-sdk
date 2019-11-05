---
title: Azure SDK for Java (October 2019 Preview)
layout: post
date: 11 Oct 2019
tags: java
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
permalink: /releases/2019-10-11/java.html
---

The Azure SDK team is pleased to make available the October 2019 client library preview release. This represents the updated release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new and updated client libraries for Azure App Configuration, Identity, Key Vault (keys, secrets and certificates), Event Hubs and Event Hubs Checkpoint Store, and Storage (Blobs, Files, and Queues).

## Installation Instructions
To use the preview libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.0.0-preview.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.0-preview.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-certificates</artifactId>
  <version>4.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-keys</artifactId>
  <version>4.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-secrets</artifactId>
  <version>4.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.0.0-preview.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file</artifactId>
  <version>12.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opencensus</artifactId>
  <version>1.0.0-preview.3</version>
</dependency>
```

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog
Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

* Designed based on the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java_introduction.html), resulting in a consistent API design and common feature set such as HTTP retries, logging, transport protocols, authentication protocols, etc.
* Modernized API making use of Java 8 features such as streams, new date / time, functional interfaces, etc, to offer an improved and more productive developer experience.
* Synchronous and asynchronous APIs offer developers simplicity for simple cases, and full asynchronousity when performance and scalability matters. Reactive streams are offered using [Project Reactor](http://projectreactor.io).

### Event Hubs
- Added Proxy support for Event Hubs sync and async clients.
- EventHubConsumer and EventHubAsyncConsumer now provides last enqueued event information.
- Refactored azure-messaging-eventhubs to extract AMQP implementation details to azure-core-amqp module.
- Added modules support for JDK 9+ and renamed model classes to support Java bean naming convention.

### Event Hub Checkpoint Store
- Added modules support for JDK 9+.

### Key Vault [Secrets, Keys and Certificates] 
- Updated to be fully compliant with the Java 9 Platform Module System.
- Getters and setters were updated to use Java Bean notation.
- Added importCertificate API to CertificateClient and CertificateAsyncClient.
- Changed VoidResponse to Response<Void> on sync API, and Mono<VoidResponse> to Mono<Response<Void>> on async API.

####  Storage [Blob, Files and Queues]
- Added Support for Azure Storage Blob batching operations (delete and set tier).
- Added Client Side Encryption support for Blob Storage.
- Added separate packages for LeaseClient, BlobClient, AppendBlobClient, BlockBlobClient, and PageBlobClient.
- Updated to be fully compliant with the Java 9 Platform Module System.
- Changed VoidResponse to Response<Void> on sync API, and Mono<VoidResponse> to Mono<Response<Void>> on async API.
- Added ParallelTransferOptions to buffered upload, upload from file and download to file methods.
- Removed SAS token generation APIs from clients, use BlobServiceSasSignatureValues to generate SAS tokens.
- Removed SASTokenCredential, SASTokenCredentialPolicy in client builders, and added sasToken(String) method instead.
- Fixes various issues ( metadata does not allow capital letter, create method name in PageBlob).

####  Tracing
- Added tracing support for AMQP client libraries

## Need help?
* For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/track2reports/index.html).
* For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
* For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
* File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
* Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Quick Links

| Service  | Readme | Changelog | Samples | JavaDoc |
| -- | -- | -- | -- | -- |
| App Configuration | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/9e2d5fb1f1b32c9a9355cf6c3f992664799c905e/sdk/appconfiguration/azure-data-appconfiguration/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/9e2d5fb1f1b32c9a9355cf6c3f992664799c905e/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md) | [Samples](https://azure.github.io/azure-sdk/posts/2019-08-06/dotnet-preview2.html) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Event Hubs | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.0.0-preview.4/sdk/eventhubs/azure-messaging-eventhubs/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.0.0-preview.4/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-messaging-eventhubs_5.0.0-preview.4/sdk/eventhubs/azure-messaging-eventhubs/src/samples/java/com/azure/messaging/eventhubs) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Event Hubs Checkpoint Store | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs-checkpointstore-blob_1.0.0-preview.2/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/README.md) | [Changelog]( https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs-checkpointstore-blob_1.0.0-preview.2/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-messaging-eventhubs-checkpointstore-blob_1.0.0-preview.2/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/src/samples/java/com/azure/messaging/eventhubs/checkpointstore/blob) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Identity | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/identity/azure-identity/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/identity/azure-identity/CHANGELOG.md) |  | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Key Vault - Keys | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-keys/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-keys/src/samples/java/com/azure/security/keyvault/keys) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Key Vault - Certificates | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-certificates/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-certificates/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-certificates/src/samples/java/com/azure/security/keyvault/certificates) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Key Vault - Secrets | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-secrets/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-secrets/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-keyvault-keys_4.0.0-preview.4/sdk/keyvault/azure-keyvault-secrets/src/samples/java/com/azure/security/keyvault/secrets) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - Blob | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob/src/samples) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - Blobs Batch | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob-batch/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob-batch/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob-batch/src/samples) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - Blobs Cryptography | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-blob-cryptography/README.md) | [Changelog]() | [Samples]() | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - File | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-file/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-file/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-file/src/samples) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Storage - Queue | [Readme](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-queue/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-queue/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-storage-blob_12.0.0-preview.4/sdk/storage/azure-storage-queue/src/samples) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |
| Tracing | [Readme](https://github.com/Azure/azure-sdk-for-java/tree/azure-core-tracing-opencensus_1.0.0-preview.3/sdk/tracing/azure-core-tracing-opencensus/README.md) | [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opencensus_1.0.0-preview.3/sdk/tracing/azure-core-tracing-opencensus/CHANGELOG.md) | [Samples](https://github.com/Azure/azure-sdk-for-java/tree/azure-core-tracing-opencensus_1.0.0-preview.3/sdk/tracing/azure-core-tracing-opencensus/src/samples/java/com/azure/core/tracing/opencensus) | [JavaDoc](https://azure.github.io/azure-sdk-for-java/track2reports/index.html) |

{% include refs.md %}
