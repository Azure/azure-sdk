---
title: Azure SDK for Java (March 2020)
layout: post
date: March 2020
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our March 2020 client library releases.

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
  <version>1.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.4</version>
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
  <version>12.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.4.0</version>
</dependency>
  
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.0.1-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search</artifactId>
  <version>11.0.0-beta.1</search>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### App Configuration ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-appconfiguration_1.1.0/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md))

- Updated javadoc to support the changes that App Configuration service no longer support `*a` and `*a*` suffix and full text search.
- Upgrade Azure Core version from 1.2.0 to 1.3.0.

### Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_1.0.0-beta.3/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md))

- General class and method rename to comply with API guidelines.
- Introduced `TextAnalyticsPagedFlux`, `TextAnalyticsPagedIterable`, and `TextAnalyticsPagedResponse` type. Moved `modelVersion` amd `TextDocumentBatchStatistics` into `TextAnalyticsPagedResponse`. All collection APIs are return `TextAnalyticsPagedFlux` and `TextAnalyticsPagedIterable` in the asynchronous and synchronous client, respectively. Most of existing API surface are changes. Please check up `TextAnalyticsAsyncClient` and `TextAnalyticsClient` for more detail.
- Introduced `EntityCategory` class to support major entity categories that the service supported.
- Added `getDefaultCountryHint()`, `getDefaultLanguage()` and `getServiceVersion()` to `TextAnalyticsClient`
- Supported `Iterable<T>` instead of `List<T>` text inputs.
- Removed `InnerError`, `DocumentResultCollection` and `TextAnalyticsClientOptions` class.

### Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos_4.0.1-beta.1/sdk/cosmos/azure-cosmos/CHANGELOG.md))

### Search ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-search_11.0.0-beta.1/sdk/search/azure-search/CHANGELOG.md))

### Identity ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.0.4/sdk/identity/azure-identity/CHANGELOG.md))

### Storage Blobs ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.5.0/sdk/storage/azure-storage-blob/CHANGELOG.md))

### Storage Blobs Batch ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-batch_12.4.0/sdk/storage/azure-storage-blob-batch/CHANGELOG.md))

### Storage Blobs Cryptography ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-cryptography_12.5.0/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md))

### Storage Files Shares ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-share_12.3.0/sdk/storage/azure-storage-file-share/CHANGELOG.md))

### Storage Files Datalake ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-datalake_12.0.1/sdk/storage/azure-storage-file-datalake/CHANGELOG.md))

### Storage Queues ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-queue_12.4.0/sdk/storage/azure-storage-queue/CHANGELOG.md))

### Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opentelemetry_1.0.0-beta.3/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md))

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
