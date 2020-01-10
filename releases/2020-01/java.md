---
title: Azure SDK for Java (January 2020)
layout: post
date: January 2020
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to make available the January 2020 client library GA release. This GA release includes new and updated client libraries for Identity, Key Vault (keys, secrets and certificates), Event Hubs and Storage (Blobs and Queues). Some of the libraries are released as beta and they are Checkpoint Store, Storage File.

## Installation Instructions
To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.0.0-beta.7</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opencensus</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.0.0-preview.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
```

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### App Configuration
- SettingSelector takes a filter instead of taking a list of strings. For more details. please see the [App Configuration](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md#101-2020-01-07).

### Event Hubs
- The Event Hub connection is reestablished when a transient failure is encountered.
- Error handling in `EventProcessor` is broken out and handled in several scenarios.
- For more details, please see the [EventHubs changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#501-2020-01-07).
  
### Keyvault Certificates
- Updated dependency. For more details. please see the [KeyVault Certificates](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#400-2020-01-07)

### Keyvault Keys
- - Fixes the logic of `getKeyId()` method in `KeyEncryptionKeyClient` and `KeyEncryptionKeyAsyncClient` to ensure key id is available in all scenarios. For more details. please see the [KeyVault Keys](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#402-2020-01-07)

### Keyvault Secrets
- - Updated dependency. For more details. please see the [KeyVault Secrets](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#402-2020-01-07)

### Storage Blob
- Optimized `downloadToFile` to avoid an unnecessary `getProperties` call and to lock on an ETag once the operation has
  started. For more details, please see the [Storage
  Blob](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md#version-1210-2019-12-??)
  change log.

### Storage Blob Batch
- Changed exception throwing to throw `StorageBlobException` on invalid request and `BlobBatchStorageException` when
  batch operations fail. For more details, please see the [Storage Blob
  Batch](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob-batch/CHANGELOG.md#version-1210-2019-12-??)
  change log.

### Storage Blob Cryptography
- Added a check in `EncryptedBlobClientBuilder` to enforce HTTPS for bearer token authentication. For more details,
  please see the [Storage Blob
  Cryptography](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md#version-1210-2019-12-??)
  change log.

### Storage File Datalake
- Fixed bug in ClientBuilders that prevented OAuth from functioning. For more details, please see the [Storage File Datalake](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#version-1200-beta7-2019-12-??)
  change log.

### Storage File Share
- Renamed FileReference to StorageFileItem. For more details, please see the [Storage File Share](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-share/CHANGELOG.md#version-1200-preview5-2019-10-??)
  change log.

### Storage Queue
- Added a check in ClientBuilders to enforce HTTPS for bearer token authentication. For more details, please see the [Storage Queue](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-queue/CHANGELOG.md#version-1210-2019-12-??)
  change log.

### Tracing
- Added links for batch send operation in Event Hubs client library.
- Added EventHubs.* properties to attributes of processing spans. Detailed [changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opentelemetry_1.0.0-beta.2/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md) for `azure-core-tracing-opentelemetry`.

### Text Analytics
- The first preview with new API design for the `azure-ai-textanalytics` client library
- It uses the Text Analytics service `v3.0-preview.1` API.
- New namespace/package name:
    - The namespace/package name for Azure Text Analytics client library has changed from 
    `com.microsoft.azure.cognitiveservices.language.textanalytics` to `com.azure.ai.textanalytics`
- Added support for:
  - Subscription key and AAD authentication for both synchronous and asynchronous clients.
  - Language detection.
  - Entity recognition.
  - Entity linking recognition.
  - Personally identifiable information entities recognition.
  - Key phrases extraction.
  - Analyze sentiment APIs including analysis for mixed sentiment.
  
For more details, please see the detailed [changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100-beta1-2020-01-09).

## Need help?
* For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
* For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
* For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
* File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
* Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Quick Links

{% assign packages = site.data.releases.latest.java-packages %}
{% include java-packages.html %}

{% include refs.md %}
