---
title: Azure SDK for Java (September 2019 Preview)
layout: post
date: 17 Sept 2019
tags: java
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
permalink: /releases/2019-09-17/java.html
---

The Azure SDK team is pleased to make available the September 2019 client library preview release. This represents the updated release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This preview release includes new and updated client libraries for Azure App Configuration, Identity, Key Vault (keys, secrets and certificates), Event Hubs and Event Hubs Checkpoint Store, and Storage (Blobs, Files, and Queues).

## Installation Instructions
To use the preview libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.0.0-preview.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-certificates</artifactId>
  <version>4.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-keys</artifactId>
  <version>4.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-keyvault-secrets</artifactId>
  <version>4.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.0.0-preview.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file</artifactId>
  <version>12.0.0-preview.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.0.0-preview.3</version>
</dependency>
```

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog
Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

* Designed based on the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java_introduction.html), resulting in a consistent API design and common feature set such as HTTP retries, logging, transport protocols, authentication protocols, etc.
* Modernized API making use of Java 8 features such as streams, new date / time, functional interfaces, etc, to offer an improved and more productive developer experience.
* Synchronous and asynchronous APIs offer developers simplicity for simple cases, and full asynchronousity when performance and scalability matters. Reactive streams are offered using [Project Reactor](http://projectreactor.io).

### Azure Identity
- Added new credential type `SharedTokenCacheCredential`, allowing authenticating to Azure Active Directory if you are logged in Visual Studio 2019 (currently supported on Windows only).

### Event Hubs
- Added synchronous interface to send and receive messages
- Optimized EventProcessor implementation, added support for balancing partitions across multiple instances of `EventProcessor`.

### Event Hub Checkpoint Store
- Added reactive streams support using Project Reactor.
- Provides an instance of BlobPartitionManager to your Event Processor. BlobPartitionManager uses Storage Blobs to store checkpoints and balance partition load among all instances of Event Processors.
- Stores checkpoint and partition ownership details in Azure Storage Blobs.

### Key Vault Certificates
- Added reactive streams support using Project Reactor.
- Added support for authentication using azure-identity credentials and HTTP challenge based authentication, allowing clients to interact with vaults in sovereign clouds.
- Updated packages structure to group Key, Secret, and Certificate clients in the respective directories

###  Storage
- Changed API design replacing List responses to `PagedFlux` on async APIs and `PagedIterable` on sync APIs.
- Simplified API to return model types directly on non-maximal overloads.
- Added priority support for Azure blob rehydration feature.
- Added convenience upload methods to `BlockBlobClient` and `BlockBlobAsyncClient`.
- Added uploadRangeFromUrl APIs on sync and async File client.
- Added generate SAS token APIs for Storage File and Queue.
- Added validation policy to check the equality of request client id between request and response.
- Improved error handling (tracing telemetry on maximum overload API, added UnexpectedLengthException).
- Removed dependency on Netty.

### App Configuration
- Removed dependency on Netty.
- Added logging when throwing `RutimeException`s.

## Need help?
* For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
* For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
* For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
* File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
* Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Quick Links

See [Nov Release](..\2019-11\java.html)
