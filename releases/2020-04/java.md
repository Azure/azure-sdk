---
title: Azure SDK for Java (April 2020)
layout: post
date: 2020-04-14
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
- FormRecognizer
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
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

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

### Event Hubs ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.1.0-beta.1/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md))

- Added heartbeat for single process event consumer in EventProcessorClient.
- Added batch receive for EventProcessorClient.

### Event Hubs Checkpoint Store ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs-checkpointstore-blob_1.1.0-beta.1/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/CHANGELOG.md))

- Updates dependencies.

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-formrecognizer_1.0.0-beta.1/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md))

- The first preview with new API design for the Azure Cognitive Services Form Recognizer client library
- Adds `FormRecognizerClient` to analyze custom forms, receipts, and form content/layout
- Adds `FormTrainingClient` to train custom models (with/without labels), and manage the custom models on your account
- Authentication with API key supported using `AzureKeyCredential("<api_key>")` from `com.azure.core.credential`
- For stream methods, `content-type` is automatically detected

### Identity

#### 1.0.5 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#105-2020-04-07))

- Update azure-core dependency to version 1.4.0.

#### 1.1.0-beta.3 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.1.0-beta.3/sdk/identity/azure-identity/CHANGELOG.md#110-beta3-2020-04-07))

- Added `KnownAuthorityHosts` to enable quick references to public azure authority hosts.
- Added methods to allow credential configuration in `DefaultAzureCredentialBuilder`
- Added support for authority host to be read from `AZURE_AUTHORITY_HOST` environment variable.
- Added support for `ClientCertificateCredential` and `UserNamePasswordCredential` in EnvironmentCredential.

### KeyVault Certificates

#### 4.0.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-certificates_4.0.2/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#402-2020-04-07))

- Update azure-core dependency to version 1.4.0.

#### 4.1.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-certificates_4.1.0-beta.2/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta2-2020-04-09))

- Added `retryPolicy` setter in `CertificateClientBuilder`
- Update azure-core dependency to version 1.4.0.

### KeyVault Keys

#### 4.1.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.1.2/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#412-2020-04-07))

- Update azure-core dependency to version 1.4.0.

#### 4.2.0-beta.3 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.0-beta.3/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#420-beta3-2020-04-09))

- Added `LocalCryptographyClient`, `LocalCryptographyAsyncClient`, `LocalKeyEncryptionKeyClient` and `LocalKeyEncryptionKeyAsyncClient` to perform cryptography operations locally.
- Added `retryPolicy` setter in `KeyClientBuilder`, `CryptographyClientBuilder` and `KeyEncryptionKeyClientBuilder`
- Update azure-core dependency to version 1.4.0.

### KeyVault Secrets

#### 4.1.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-secrets_4.1.2/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#412-2020-04-07))

- Update azure-core dependency to version 1.4.0.

#### 4.2.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-secrets_4.2.0-beta.2/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#420-beta2-2020-04-09))

- Update azure-core dependency to version 1.4.0.
- Added `retryPolicy` setter in `SecretClientBuilder`

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

### Service Bus ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-servicebus_7.0.0-beta.1/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md))

- Initial preview of Azure Service Bus client library version 7.
- This version of library has been designed based on the [Azure SDK Design Guidelines for Java]({{site.baseurl}}{% link docs/java/introduction.md %}) to ensure consistency, idiomatic design, and excellent developer experience and productivity.

### Blobs ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md))
- This release contains various bug fixes to improve quality.

### Blobs Cryptography ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md))
- It is now possible to specify a key/keyResolver after they specify a pipeline/client on the builder

### Files Datalake ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md))
- Added an `isDirectory` property to `PathProperties`.
- Added overloads to `DataLakeFileSystemClient.createFile/createDirectory`, `DataLakeDirectoryClient.createFile/createSubdirectory` to allow overwrite behavior.

### Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_1.0.0-beta.4/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md))

- Throws an illegal argument exception when the given list of documents is an empty list.
- Renamed all input parameters `text` to `document`, and `inputTexts` to `documents`.
- Removed all PII endpoints and update with related changes, such as remove related models, samples, codesnippets, docstrings, etc from this library.
- Replaced `TextAnalyticsApiKeyCredential` with `AzureKeyCredential`.

### Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opentelemetry_1.0.0-beta.4/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md))

- Added az namespace info attribute to all outgoing spans for Http Libraries.
- Updated `io.opentelemetry` to 0.2.4.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
