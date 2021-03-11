---
title: Azure SDK for Java (February 2020)
layout: post
date: 2020-02-11
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our February 2020 client library releases.

#### GA

- Event Hubs

#### Updates

- Storage (Blobs, Blobs Batch, Queues, File Shares, DataLake)

#### Preview

- Cosmos
- Identity
- Key Vault (Keys)
- Text Analytics

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
  <version>4.2.0-beta.1</version>
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
  <version>12.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.4.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.0.0-beta.12</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.3.0</version>
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
  <version>1.0.0-beta.2</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Event Hubs ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.0.1/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#501-2020-02-11))

- The Event Hub connection is reestablished when a transient failure is encountered.
- Error handling in `EventProcessor` is broken out and handled in several scenarios.



## Need help?
* For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
* For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
* For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
* File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
* Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

### Identity ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.1.0-beta.1/sdk/identity/azure-identity/CHANGELOG.md))

- All credential builders support setting a pipeline via `httpPipeline` method.
- SharedTokenCacheCredentialBuilder supports setting the tenant id via `tenantId` method.

### KeyVault Keys ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.0-beta.1/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md))

- `KeyVaultKey` model can be instantiated using factory methods `fromKeyId(String keyId, JsonWebKey jsonWebKey)` and `fromName(String name, JsonWebKey jsonWebKey)`.
- `KeyEncryptionKeyClientBuilder` can consume `KeyVaultKey` and build `KeyEncryptionKey` and `AsyncKeyEncryptionKey` via `buildKeyEncryptionKey(KeyVaultKey key)` and `buildAsyncKeyEncryptionKey(KeyVaultKey key)` methods respectively.

### Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_1.0.0-beta.2/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100-beta2-2020-02-12))

- General class and method rename to comply with API guidelines.
- All single text operation methods now return an atomic type of operation result.
- Simplified `TextAnaylticsError` to only contain `code`, `message`, and `target`.
- Added the ability to create a Text Analytics client with a credential that can be updated in long-lived clients.
- All batch overload methods have been renamed by adding the suffix `Batch`.
- Accessing a result on a `DocumentError` now raises a `TextAnalyticsException` with a description of the error.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.


## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
