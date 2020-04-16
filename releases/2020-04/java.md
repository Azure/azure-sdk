---
title: Azure SDK for Java (April 2020)
layout: post
date: April 2020
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our April 2020 client library releases.

#### Updates

- App Configuration
- EventHubs (Client, Checkpoint Store)
- Identity
- KeyVault (Certificates, Keys, Secrets)
- Storage (Blobs, Blobs Batch, Blobs Cryptography, Files Datalake, Files Shares, Queues)

#### Preview

- EventHubs (Client, Checkpoint Store)
- Identity
- KeyVault (Certificates, Keys, Secrets)
- Search
- ServiceBus
- Text Analytics
- Tracing OpenTelemetry

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.0.1-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.0.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.1.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.0.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.1.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.1.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.0.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.1.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.1.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>1.0.0-beta.2</search>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### App Configuration ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-appconfiguration_1.1.1/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md))

- Update dependency version, `azure-core` to 1.4.0 and `azure-core-http-netty` to 1.5.0.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.1.0-beta.1/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md)

- Added heartbeat for single process event consumer in EventProcessorClient.
- Added batch receive for EventProcessorClient.
- Bug fixes for reconnection issues.

### Event Hubs Checkpoint Store [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs-checkpointstore-blob_1.1.0-beta.1/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/CHANGELOG.md)

- Updates dependency of azure-messaging-eventhubs to support receiving in batches.

### Identity

#### 1.0.5 (Changelog)

#### 1.1.0-beta.3 (Changelog)

### KeyVault Certificates

#### 4.0.2 (Changelog)

#### 4.1.0-beta.2 (Changelog)

### KeyVault Keys

#### 4.1.2 (Changelog)

#### 4.2.0-beta.2 (Changelog)

### KeyVault Secrets

#### 4.1.2 (Changelog)

#### 4.2.0-beta.3 (Changelog)

### Search ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-search-documents_1.0.0-beta.2/sdk/search/azure-search-documents/CHANGELOG.md))
Version 1.0.0-beta.2 is the consecutive beta version of 11.0.0-beta.1. The version is made because we renamed
the search client library module name and namespace.

- Renamed the azure-search module to azure-search-documents.
- Changed the namespace com.azure.search to com.azure.search.documents.
- Added support for continuation tokens to resume server-side paging.
- Replaced `SearchApiKeyCredential` with `AzureKeyCredential`.
- Moved `AzureKeyCredentialPolicy` to Azure Core.
- Fixed a bug where the Date header wouldn't be updated with a new value on request retry.
- Changed the field type of `CustomAnalyzer`.
- Made `RangeFacetResult` and `ValueFacetResult` object strongly typed.
- Added helper function for IndexBatchException.
- Added ScoringParameter class.
- Refactored some boolean field getter.
- Made `IndexDocumentsBatch` APIs plurality.

### ServiceBus [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-servicebus_7.0.0-beta.1/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md)

- Initial preview of Azure Service Bus client library version 7.
- This version of library has been designed based on the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java_introduction.html) to ensure consistency, idiomatic design, and excellent developer experience and productivity.

### Blobs [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md)
- This release contains various bug fixes to improve quality.

### Blobs Cryptography [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md)
- It is now possible to specify a key/keyResolver after they specify a pipeline/client on the builder

### Files Datalake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)
- Added an `isDirectory` property to `PathProperties`.
- Added overloads to `DataLakeFileSystemClient.createFile/createDirectory`, `DataLakeDirectoryClient.createFile/createSubdirectory` to allow overwrite behavior.

### Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_1.0.0-beta.4/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md))

- Throws an illegal argument exception when the given list of documents is an empty list.
- Renamed all input parameters `text` to `document`, and `inputTexts` to `documents`.
- Removed all PII endpoints and update with related changes, such as remove related models, samples, codesnippets, docstrings, etc from this library.
- Replaced `TextAnalyticsApiKeyCredential` with `AzureKeyCredential`.

### Tracing OpenTelemetry (Changelog)

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

{% assign packages = site.data.releases.latest.java-packages %}
{% include java-packages.html %}

{% include refs.md %}
