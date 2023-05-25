---
title: Azure SDK for Java (August 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our August 2020 client library releases.

#### GA

- Azure Storage Blob

#### Updates

- Azure App Configuration
- Azure Core
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure-Cosmos
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Azure Spring Boot

#### Preview

- Azure Core Experimental
- Azure Core Management
- Azure Core Serializer Json Gson
- Azure Core Serializer Json Jackson
- Azure Core Tracing OpenTelemetry
- Form Recognizer
- Azure Search Documents
- Azure Service Bus

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.7.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.5.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.2.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.3.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.4</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-identity</artifactId>
    <version>1.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.8.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.6.0</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-certificates</artifactId>
    <version>4.1.0</version>
</dependency>
<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-keys</artifactId>
    <version>4.2.0</version>
</dependency>
<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0-beta.5</version>
</dependency>
```

To use Azure Spring Boot starters, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.

```xml
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-active-directory-b2c-spring-boot-starter</artifactId>
  <version>2.3.3</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-active-directory-spring-boot-starter</artifactId>
  <version>2.3.3</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-cosmosdb-spring-boot-starter</artifactId>
  <version>2.3.3</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-data-gremlin-spring-boot-starter</artifactId>
  <version>2.3.3</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-keyvault-secrets-spring-boot-starter</artifactId>
  <version>2.3.3</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-spring-boot-metrics-starter</artifactId>
  <version>2.3.3</version>
<dependency>
</dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
  <version>2.3.3</version>
</dependency>
```
## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#170-2020-08-07))

#### New Features

- Redesigned `SimpleTokenCache` to gracefully attempt a token refresh 5 minutes before actual expiry.
- Added `ObjectSerializer` and `JsonSerializer` APIs to support pluggable serialization within SDKs.
- Added `TypeReference<T>` to enable serialization handling for `Class<T>` and `Type` while retaining generics through a call stack.
- Added `MemberNameConverter` which converts a `Member` type of `Field` or `Method` into its expected serialized JSON property name.
- Updated `reactor-core` version to `3.3.8.RELEASE`.
- Updated `reactor-netty` version to `0.9.10.RELEASE`.
- Updated `netty` version to `4.1.51.Final`.
- Updated `netty-tcnative` version to `2.0.31.Final`.

#### Key Bug Fixes

- Updated handling of `OffsetDateTime` serialization to implicitly convert date strings missing time zone into UTC.
- Updated `PollerFlux` and `SyncPoller` to propagate exceptions when polling instead of only on failed statuses.

### Azure Core Experimental ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta2-2020-08-07))

#### Breaking Changes

- Moved `ObjectSerializer` and some implementation of `JsonSerializer` into `azure-core`.
- Created sub-interface of `JsonSerializer` in `azure-core` to include APIs that weren't moved.

### Azure Core Http Netty ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-netty/CHANGELOG.md#154-2020-08-07))

#### New Features

- Updated `reactor-core` version to `3.3.8.RELEASE`.
- Updated `reactor-netty` version to `0.9.10.RELEASE`.
- Updated `netty` version to `4.1.51.Final`.
- Updated `netty-tcnative` version to `2.0.31.Final`.

#### Key Bug Fixes

- Fixed a bug where connections weren't being re-used when using a proxy which lead to a new TCP and SSL session for each request.
- Fixed a bug where a non-shareable proxy handler could be added twice into a `ChannelPipeline`.

### Azure Core Management ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-management/CHANGELOG.md#100-beta3-2020-08-07))

#### New Features

- Added optional `Context` parameter to methods in `PollerFactory` class, which will be shared for all polling requests.
- Added `getResponseHeaders()` method to `PollResult.Error` class.
- Added `AzureProfile` class.
- Added `IdentifierProvider` and `DelayProvider` interfaces.

#### Key Bug Fixes

- Fixed polling status HTTP status code check to include 202.

### Azure Core Serializer Json Gson ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-serializer-json-gson/CHANGELOG.md#100-beta3-2020-08-12))

#### New Features

- `GsonJsonSerializer` now implements the interface `MemberNameConverter`.

#### Breaking Changes

- Changed `GsonJsonSerializer` to implement `azure-core`'s `JsonSerialzer` instead of `azure-core-experimental`'s.
- Removed JSON tree models and APIs.

#### Breaking Changes

### Azure Core Serializer Json Jackson ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#100-beta3-2020-08-12))

#### New Features

- `JacksonJsonSerializer` now implements the interface `MemberNameConverter`.

#### Breaking Changes

- Changed `JacksonJsonSerializer` to implement `azure-core`'s `JsonSerialzer` instead of `azure-core-experimental`'s.
- Removed JSON tree models and APIs.

#### Breaking Changes

### Azure Core Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta6-2020-08-07))

#### New Featues

- Update `opentelemetry-api` dependency version to `0.6.0` and included `io.grpc:grpc-context[1.30.0]` external dependency.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#431-2020-08-13))

#### 4.3.1 (2020-08-13)

#### Key Bug Fixes

- Fixed issue with `GROUP BY` query, where it was returning only one page.
- Fixed user agent string format to comply with central SDK guidelines.
- Enhanced diagnostics information to include query plan diagnostics.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#430-2020-07-29))

#### 4.3.0 (2020-07-29)

#### New Features

- Updated reactor-core library version to `3.3.8.RELEASE`.
- Updated reactor-netty library version to `0.9.10.RELEASE`.
- Updated netty library version to `4.1.51.Final`.
- Added new overload APIs for `upsertItem` with `partitionKey`.
- Added open telemetry tracing support.

#### Key Bug Fixes

- Fixed issue where SSLException gets thrown in case of cancellation of requests in GATEWAY mode.
- Fixed resource throttle retry policy on stored procedures execution.
- Fixed issue where SDK hangs in log level DEBUG mode.
- Fixed periodic spikes in latency in Direct mode.
- Fixed high client initialization time issue.
- Fixed http proxy bug when customizing client with direct mode and gateway mode.
- Fixed potential NPE in users passes null options.
- Added timeUnit to `requestLatency` in diagnostics string.
- Removed duplicate uri string from diagnostics string.
- Fixed diagnostics string in proper JSON format for point operations.
- Fixed issue with `.single()` operator causing the reactor chain to blow up in case of Not Found exception.

### Azure Identity ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#110-2020-08-10))

#### 1.1.0 (2020-08-10)

- Upgraded core dependency to 1.7.0
- Removed the default value of 0 for port in `InteractiveBrowserCredential`.

### Breaking Changes
- Removing Application Authentication APIs for GA release. These will be reintroduced in 1.2.0-beta.1.
  - Removed class `AuthenticationRecord`
  - Removed class `AuthenticationRequiredException`
  - Removed methods `allowUnencryptedCache()` and `enablePersistentCache()` from `ClientCertificateCredentialBuilder`,
   `ClientSecretCredentialBuilder`, `InteractiveBrowserCredentialBuilder`, `DeviceCodeCredentialBuilder`,
    `UsernamePasswordCredentialBuilder` and `ClientCertificateCredentialBuilder`.
  - Removed methods `allowUnencryptedCache()` and `authenticationRecord(AuthenticationRecord)` from `SharedTokenCacheCredentialBuilder`.
  - Removed methods `authenticationRecord(AuthenticationRecord)` and `disableAutomaticAuthentication()` from `DeviceCodeCredentialBuilder` and `InteractiveBrowserCredentialBuilder`.
  - Removed methods `authenticate(TokenRequestContext)` and `authenticate()` from `DeviceCodeCredential`, `InteractiveBrowserCredential`
    and `UsernamePasswordCredential`.

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-beta1-2020-08-11))

#### Breaking changes
- Bumped package version to 3.0.0-beta.1 and now targets the service's stable v2.0 API
- Changed param ordering for methods `beginRecognizeCustomForms` and `beginRecognizeCustomFormsFromUrl`
- Model and property renamings detailed in the Changelog.

#### New features
- Added support for context passing.

#### Key Bug Fixes
- Fixed `getFields()` on `RecognizedForm` to preserve service side ordering of fields.

### Azure Key Vault Certificates ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#410-2020-08-12))

#### New features
- Added support for service version `7.1`.
- Added `retryPolicy` setter in `CertificateClientBuilder`.
- Added `recoverableDays` property to `CertificateProperties`.

#### Key Bug Fixes
- Fixed an issue that prevented using classes from package `com.azure.security.keyvault.certificates` when working on a project using Java 9+.

### Azure Key Vault Keys ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#420-2020-08-12))

#### New features
- Added support for service version `7.1`.
- Added `retryPolicy` setter in `KeyClientBuilder`, `CryptographyClientBuilder` and `KeyEncryptionKeyClientBuilder`.
- Added `recoverableDays` property to `KeyProperties`.
- Added `Import` operation to `KeyOperation`.

#### Key Bug Fixes
- Fixed an issue that prevented using classes from package `com.azure.security.keyvault.keys` when working on a project using Java 9+.

### Azure Key Vault Secrets ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#420-2020-08-12))

#### New features
- Added support for service version `7.1`.
- Added `retryPolicy` setter in `SecretClientBuilder`.
- Added `recoverableDays` property to `SecretProperties`.

### Azure Search Documents ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/search/azure-search-documents/CHANGELOG.md#1110-beta1-2020-08-12))

#### New Features

- Added `buildSearchFields` API to `SearchIndexClient` and `SearchIndexAsyncClient` to aid in creating `SearchField`s from the passed `Class`.
- Added `SearchableFieldProperty`, `SimpleFieldProperty`, and `FieldBuilderIgnore` to annotate `Class`es passed into `buildSearchFields`.
- Added `getDefaultLogOptions` to `SearchClientBuilder`, `SearchIndexCleintBuilder`, and `SearchIndexerClientBuilder`. Updated client construction to use default log options by default.
- Added the ability for clients to accept a `JsonSerializer` to specify a custom JSON serialization layer when dealing with Search documents.

### Azure Service Bus ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-beta5-2020-08-11))

#### New features
- Automatic lock renewal using LockRenewalOperation.
- A timeout period is added when synchronously receiving messages.

#### Breaking changes
- Service Bus queue, topic, and subscription creation are done through CreateQueueOptions,
  CreateTopicOptions, and CreateSubscriptionOptions.
- Only updateable properties on QueueProperties, TopicProperties, and SubscriptionProperties are exposed
- MessageDetailCount is flattened and removed in QueueRuntimeInfo, TopicRuntimeInfo, and SubscriptionRuntimeInfo.

### Azure Spring Boot

#### New Features
- Support connection to multiple Key Vault from a single application configuration file
- Support case sensitive keys in Key Vault
- Key Vault Spring Boot Actuator

#### Key Bug Fixes
- Address CVEs and cleaned up all warnings at build time.

#### Breaking Changes
- azure-servicebus-spring-boot-starter
- azure-mediaservices-spring-boot-starter
- azure-storage-spring-boot-starter
- Revamp KeyVault refreshing logic to avoid unnecessary updates.
- Update the underpinning JMS library for Service Bus to JMS 2.0 to support seamlessly lift and shift their Spring workloads to Azure and automatic creation of resources.

### Azure Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md)

##### New Features
- GA of v12.8.0, includes features from all preview versions
- Added support for Object Replication Service on listBlobs and getProperties
- Added support for blob tags
- Added RehydratePriority to BlobProperties and BlobItemProperties
- Added support to set tier on a snapshot or version

##### Key Bug Fixes
- Fixed bug that ignored customer specified block size when determining buffer sizes in BlobClient.upload
- Fixed a bug that would cause buffered upload to always put an empty blob before uploading actual data

#### Blob ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-changefeed/CHANGELOG.md)

##### New Features
- Added the ability to read to the current hour
- Standardized continuation token behavior

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

##### New Features
- GA of v12.2.0

##### Key Bug Fixes
- Fixed bug where Query Input Stream would throw when a ByteBuffer of length 0 was encountered

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

##### New Features
- GA of v12.6.0, for the 2019-12-12 service version

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
