---
title: Azure SDK for Java (March 2020)
layout: post
date: 2020-03-17
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our March 2020 client library releases.

#### GA

- Storage DataLake

#### Updates

- App Configuration
- Identity
- Storage (Blobs, Blobs Batch, Blob Cryptography, Queues, File Shares)

#### Preview

- Cosmos
- Identity
- KeyVault (Certificates, Keys, Secrets)
- Search
- Text Analytics
- Tracing OpenTelemetry

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
  <artifactId>azure-identity</artifactId>
  <version>1.1.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.0-beta.2</version>
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
- Upgrade `azure-core` version from `1.2.0` to `1.3.0`.

### Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos_4.0.1-beta.1/sdk/cosmos/azure-cosmos/CHANGELOG.md))

### Identity

#### 1.0.4 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.0.4/sdk/identity/azure-identity/CHANGELOG.md))

- Upgraded `azure-core` version from `1.2.0` to `1.3.0`.

#### 1.1.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.1.0-beta.2/sdk/identity/azure-identity/CHANGELOG.md))

- Added `authorityHost` setter in `DefaultAzureCredentialBuilder`.
- Added `executorService` setter in all the credential builders except `ManagedIdentityCredentialBuilder`.
- Added `tokenRefreshOffset` setter in all the credential builders.
- Added `httpClient` setter in all the credential builders.
- Updated `DefaultAzureCredential` to enable authenticating through the Azure CLI.

### KeyVault Certificates ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-certificates_4.1.0-beta.1/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md))

- Added `recoverableDays` property to `CertificateProperties`.
- Added support for `7.1-Preview1` service version.

### KeyVault Keys ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.0-beta.2/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md))

- Added `recoverableDays` property to `KeyProperties`.
- Added `Import` operation to `KeyOperation`.
- Added support for `7.1-Preview1` service version.

### KeyVault Secrets ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-secrets_4.2.0-beta.1/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md))

- Added `recoverableDays` property to `SecretProperties`.
- Added support for `7.1-Preview1` service version.

### Search ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-search_11.0.0-beta.1/sdk/search/azure-search/CHANGELOG.md))

- Support for `Document` operations such as add, delete, and update.
- Support for autocomplete, search, and suggestion operations on `Document`s.
- Support for the resource operations on `Indexes`, `Indexers`, `Skillsets`, and `Synonyms`.

### Azure Storage

#### Files DataLake ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-datalake_12.0.1/sdk/storage/azure-storage-file-datalake/CHANGELOG.md))

- This library is now Generally Available.

#### Blobs ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.5.0/sdk/storage/azure-storage-blob/CHANGELOG.md))

- Added logic to ReliableDownload to retry TimeoutException.
- Added default timeout to download stream to timeout if certain amount of time passes without seeing any data.

#### Blobs Batch ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-batch_12.4.0/sdk/storage/azure-storage-blob-batch/CHANGELOG.md))

- Fixed bug where AAD authorization would fail.

#### Blobs Cryptography ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-cryptography_12.5.0/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md))

- Added support for specifying customer provided key.

### Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_1.0.0-beta.3/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md))

- General class and method rename to comply with API guidelines.
- Introduced `TextAnalyticsPagedFlux`, `TextAnalyticsPagedIterable`, and `TextAnalyticsPagedResponse` type. Moved `modelVersion` amd `TextDocumentBatchStatistics` into `TextAnalyticsPagedResponse`. All collection APIs are return `TextAnalyticsPagedFlux` and `TextAnalyticsPagedIterable` in the asynchronous and synchronous client, respectively. Most of existing API surface are changes. Please check up `TextAnalyticsAsyncClient` and `TextAnalyticsClient` for more detail.
- Introduced `EntityCategory` class to support major entity categories that the service supported.
- Added `getDefaultCountryHint()`, `getDefaultLanguage()` and `getServiceVersion()` to `TextAnalyticsClient`
- Supported `Iterable<T>` instead of `List<T>` text inputs.
- Removed `InnerError`, `DocumentResultCollection` and `TextAnalyticsClientOptions` class.

### Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opentelemetry_1.0.0-beta.3/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md))

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include shared/refs.md %}
