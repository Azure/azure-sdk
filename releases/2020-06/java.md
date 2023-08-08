---
title: Azure SDK for Java (June 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our June 2020 client library releases.

#### GA

- Core
- Core - AMQP
- Core - Http - Netty
- Core - Http - OkHttp
- Text Analytics
- Azure Cosmos

#### Updates
- KeyVault (Certificates, Keys, Secrets)

#### Preview

- Form Recognizer
- KeyVault (Certificates, Keys, Secrets)
- Service Bus
- Tracing OpenTelemetry

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.5.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.5.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.2.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.2</version
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.0.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.1.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.1.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.0-beta.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.0.1</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

### Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#151-2020-06-08))

Here are some of the highlights:

#### Bug fixes

- Better handling of custom `Content-Type` headers, ex `application/custom+json`.

### Core - AMQP ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#120-2020-06-08))

Here are some of the highlights:

#### New features

- Added support for AMQP transactions.

#### Bug fixes

- Fixed receiver recovery after losing network connection.
- Fixed triggering multiple retries occuring when creating a new AMQP channel.
- Fixed adding credits to new AMQP receive links upon creation.

### Core - Http - Netty ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-netty/CHANGELOG.md#152-2020-06-08))

Here are some of the highlights:

#### Bug fixes

- Fixed incorrect handling of environment inferred proxies when they don't use authentication.

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#100-beta3-2020-06-10))

Here are some of the highlights:

#### Breaking changes

- Method `getFormTrainingClient()` is removed from `FormRecognizerClient` and `getFormRecognizerClient()` is added to `FormTrainingClient`
- `USReceipt` and related types have been removed. Information about a `RecognizedReceipt` must now be extracted from its `RecognizedForm`.
- Other method and property renaming detailed in changelog

#### New features

- Added support to copy a custom model from one Form Recognizer resource to another.
- Added support for authentication using Azure Active Directory credential.

### KeyVault Keys
#### 4.1.4 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.1.4/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#414-2020-06-10))
##### Functional Changes
- `404` responses from `listPropertiesOfKeyVersions` in `KeyAsyncClient` and `KeyClient` now throw a `ResourceNotFoundException`.

#### 4.2.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.0-beta.4/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#420-beta4-2020-06-10))
##### Functional Changes
- `404` responses from `listPropertiesOfKeyVersions` in `KeyAsyncClient` and `KeyClient` now throw a `ResourceNotFoundException`.
- `buildAsyncKeyEncryptionKey` in `LocalKeyEncryptionKeyClientBuilder` now throws an exception when no ID is present in a given `JsonWebKey`.

### KeyVault Secrets
#### 4.2.0-beta.3 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-secrets_4.2.0-beta.3/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#420-beta3-2020-06-10))
##### Bug fixes
- Fixed `ByteBuff` resource leak in `KeyVaultCredentialPolicy`.

### Text Analytics

#### 1.0.0 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100-2020-06-09))

- Initial release of `azure-ai-textanalytics` version 1.0.0 which targets Azure Text Analytics service API version v3.0.

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100-beta5-2020-05-27))

##### New features

- Added Text property and `getText()` to `SentenceSentiment`.
- Added `getWarnings()` to `CategorizedEntityCollection`, `KeyPhrasesCollection`, `LinkedEntityCollection` to retrieve warnings.
- Text analytics SDK update the service to version `v3.0` from `v3.0-preview.1`.

##### Breaking changes

- Removed pagination feature, which removed `TextAnalyticsPagedIterable`, `TextAnalyticsPagedFlux` and `TextAnalyticsPagedResponse`
- Removed overload methods for API that takes a list of String, only keep max-overload API that has a list of String, language or country hint, and `TextAnalyticsRequestOption`.
- Renamed `apiKey()` to `credential()` on TextAnalyticsClientBuilder.
- Removed `getGraphemeLength()` and `getGraphemeOffset()` from `CategorizedEntity`, `SentenceSentiment`, and `LinkedEntityMatch`.
- Removed `TextDocumentInput(String id, String text, String language)` constructor, but added `setLanguage()` setter since `language` is optional.

### Service Bus ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-beta3-2020-06-08))

Here are some of the highlights:

#### New Features

- Added support for transactions. APIs to create, commit and rollback a transaction and to send and settle messages using a transaction.

### Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta5-2020-06-08))

Here are some of the highlights:

#### Breaking changes

- Changed `Tracer` loading from using all on classpath to only using the first.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#401-2020-06-10))

## 4.0.1 (2020-06-10)
### New Features
* Renamed `QueryRequestOptions` to `CosmosQueryRequestOptions`.
* Updated `ChangeFeedProcessorBuilder` to builder pattern.
* Updated `CosmosPermissionProperties` with new container name and child resources APIs.
### Key Bug Fixes
* Fixed ConnectionPolicy `toString()` Null Pointer Exception.

## 4.0.1-beta.4 (2020-06-03)
### New Features
* Added more samples & enriched docs to `CosmosClientBuilder`.
* Updated `CosmosDatabase` & `CosmosContainer` APIs with throughputProperties for autoscale/autopilot support.
* Renamed `CosmosClientException` to `CosmosException`.
* Replaced `AccessCondition` & `AccessConditionType` by `ifMatchETag()` & `ifNoneMatchETag()` APIs.
* Merged all `Cosmos*AsyncResponse` & `CosmosResponse` types to a single `CosmosResponse` type.
* Renamed `CosmosResponseDiagnostics` to `CosmosDiagnostics`.
* Wrapped `FeedResponseDiagnostics` in `CosmosDiagnostics`.
* Removed `jackson` dependency from azure-cosmos & relying on azure-core.
* Replaced `CosmosKeyCredential` with `AzureKeyCredential` type.
* Added `ProxyOptions` APIs to `GatewayConnectionConfig`.
* Updated SDK to use `Instant` type instead of `OffsetDateTime`.
* Added new enum type `OperationKind`.
* Renamed `FeedOptions` to `QueryRequestOptions`.
* Added `getETag()` & `getTimestamp()` APIs to `Cosmos*Properties` types.
* Added `userAgent` information in `CosmosException` & `CosmosDiagnostics`.
* Updated new line character in `Diagnostics` to System new line character.
* Removed `readAll*` APIs, use query select all APIs instead.
* Added `ChangeFeedProcessor` estimate lag API.
### Key Bug Fixes
* Fixed issue with parsing of query results in case of Value order by queries.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
