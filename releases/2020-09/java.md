---
title: Azure SDK for Java (September 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our September 2020 client library releases.

#### GA

- Azure Core Serializer GSON JSON
- Azure Core Serializer Jackson JSON
- Form Recognizer

#### Updates

- Azure App Configuration
- Azure Core
- Azure Core AMQP
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure Event Hubs
- Azure Identity
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Azure Search Documents
- Azure Spring Cloud
- Form Recognizer
- Azure Cosmos
- Azure Spring Boot

#### Preview

- Azure Core Experimental
- Azure Core Serializer Apache Avro
- Azure Identity
- Azure Key Vault Administration
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Anomaly Detector
- Event Grid
- Azure Search Documents
- Azure Service Bus
- Azure Tables
- Azure Text Analytics

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-anomalydetector</artifactId>
  <version>3.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.8.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.5.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.6.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.3.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-avro-apache</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.1.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-messaging-eventgrid</artifactId>
    <version>2.0.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-messaging-eventhubs</artifactId>
    <version>5.2.0</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-messaging-servicebus</artifactId>
    <version>7.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.2.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-administration</artifactId>
    <version>4.0.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-certificates</artifactId>
    <version>4.1.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-certificates</artifactId>
    <version>4.2.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-keys</artifactId>
    <version>4.2.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-keys</artifactId>
    <version>4.3.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.2.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.3.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.1.0-beta.1</version>
</dependency>
```
To use Azure Spring Cloud starters and binders, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.

```xml
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-context</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-eventhubs-stream-binder</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-servicebus-queue-stream-binder</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-servicebus-topic-stream-binder</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-cloud-azure-servicebus-stream-binder-core</artifactId>
    <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-starter-azure-cache</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-starter-azure-eventhubs</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-starter-azure-eventhubs-kafka</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-starter-azure-servicebus</artifactId>
  <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-starter-azure-storage</artifactId>
    <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-cloud-starter-azure-storage-queue</artifactId>
    <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-cloud-azure-storage</artifactId>
    <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-integration-eventhubs</artifactId>
    <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-integration-servicebus</artifactId>
    <version>1.2.8</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-integration-storage-queue</artifactId>
    <version>1.2.8</version>
</dependency>

```

To use Azure Spring Boot starters, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.
```xml
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-active-directory-b2c-spring-boot-starter</artifactId>
  <version>2.3.5</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-active-directory-spring-boot-starter</artifactId>
  <version>2.3.5</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-cosmosdb-spring-boot-starter</artifactId>
  <version>2.3.5</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-data-gremlin-spring-boot-starter</artifactId>
  <version>2.3.5</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-keyvault-secrets-spring-boot-starter</artifactId>
  <version>2.3.5</version>
</dependency>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-spring-boot-metrics-starter</artifactId>
  <version>2.3.5</version>
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
  <version>2.3.5</version>
</dependency>
</dependency>

```
## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#181-2020-09-08))

#### New Features

- New `InputStream` and `OutputStream` APIs for serialization and deserialization.
- Added logging for the request attempt count to better correlate when requests are retried.
- Updated `reactor-core` version to `3.3.9.RELEASE`.
- Updated FasterXML Jackson versions to `2.11.2`.

#### Bug Fixes

- General performance fixes for serialization, URL modification and parsing, and more.
- Improved request and response body logging performance by using bulk `ByteBuffer` reading instead of byte by byte reading.
- Fixed bug where header logging checked for a log level of not equals `verbose` instead of equals `verbose`.


### Azure Core AMQP ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-amqp/CHANGELOG.md#151-2020-09-10))

#### New Features

- Expose AmqpAnnotatedMessage, AmqpMessageHeader, and other AMQP properties.
- Add support for authenticating with Shared Access Signatures.

#### Bug Fixes

- Close children sessions and links when its associated parent is disposed.

### Azure Core Experimental ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta4-2020-09-08))

#### New Features

- Added `AvroSerializer` interface containing Avro specific serializer APIs.
- Added `AvroSerializerProvider` interface as a service provider for `AvroSerializer`.

### Azure Core Http Netty ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-netty/CHANGELOG.md#161-2020-09-08))

#### New Features

- Added new APIs to configure request write timeout, response timeout, and response body read timeout.
- Updated `reactor-core` version to `3.3.9.RELEASE`.
- Updated `reactor-netty` version to `0.9.11.RELEASE`.

#### Breaking Changes

- Changed default timeouts from infinite to 60 seconds.

### Azure Core Http OkHttp ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-okhttp/CHANGELOG.md#131-2020-09-08))

#### New Features

- Updated `okhttp` dependency from `4.2.2` to `4.8.1`.
- Added request timeout configuration.

#### Breaking Changes

- Changed default connect timeout from 60 seconds to 10 and default read timeout from 120 seconds to 60 seconds.

#### Bug Fixes

- Fixed bug where `Configuration` proxy would lead to a `NullPointerException` when set.

### Azure Core Serializer Apache Avro ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-avro-apache/CHANGELOG.md#100-beta3-2020-09-08))

#### New Features

- Updated `ApacheAvroSerializer` to implement `AvroSerializer` instead of `ObjectSerializer`.
- Added implementation for `AvroSerializerProvider`.

### Azure Core Serializer JSON GSON ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-json-gson/CHANGELOG.md#101-2020-09-08))

- General availability.

### Azure Core Serializer JSON Jackson ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#101-2020-09-08))

- General availability.

### Azure Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#520-2020-09-11)

#### New Features

- Add support for connection strings containing a Shared Access Signature.
- Add options for controlling partition ownership expiration, load balancing strategy.

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-formrecognizer_3.0.0/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-2020-08-20))

- General availability, stable version 3.0.0 released targetting v2.0 GA version of the Form Recognizer service

#### Breaking changes

- Renamed `BoundingBox` model to `FieldBoundingBox`

### Azure Identity ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.1.2/sdk/identity/azure-identity/CHANGELOG.md#112-2020-09-09))

- Upgraded core dependency to 1.8.1

### Azure Identity Beta ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.2.0-beta.1/sdk/identity/azure-identity/CHANGELOG.md#120-beta1-2020-09-11))

- Added `InteractiveBrowserCredentialBuilder.redirectUrl(String)` to configure the redirect URL
- Deprecated `InteractiveBrowserCredentialBuilder.port(int)`
- Added support for App Service 2019 MSI Endpoint in `ManagedIdentityCredential`
- Added Shared Token cache support for MacOS Keychain, Gnome Keyring, and plain text for other Linux environments
- Added option to write to shared token cache from `InteractiveBrowserCredential`, `AuthorizationCodeCredential`, `UsernamePasswordCredential`, `DeviceCodeCredential` `ClientSecretCredential` and `ClientCertificateCredential`
- Added new APIs for authenticating users with `DeviceCodeCredential`,  `InteractiveBrowserCredential` and `UsernamePasswordCredential`.
    - Added method `authenticate` which pro-actively interacts with the user to authenticate if necessary and returns a serializable `AuthenticationRecord`
- Added following configurable options in classes `DeviceCodeCredentialBuilder` and `InteractiveBrowserCredentialBuilder`
    - `authenticationRecord` enables initializing a credential with an `AuthenticationRecord` returned from a prior call to `Authenticate`
    - `disableAutomaticAuthentication` disables automatic user interaction causing the credential to throw an `AuthenticationRequiredException` when interactive authentication is necessary.

### Azure Key Vault Administration 4.0.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta1-2020-09-11))

#### New features
- Added two new clients for performing Role-based Access Control (RBAC) operations on Key Vault: `KeyVaultAccessControlClient` and `KeyVaultAccessControlAsyncClient`.
- Added two new clients for performing backup and restore operations on Key Vault: `KeyVaultBackupClient` and `KeyVaultBackupAsyncClient`.

### Azure Key Vault Certificates 4.3.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta1-2020-09-11))

#### Key Bug Fixes
- Fixed an issue that prevented using classes from package `com.azure.security.keyvault.certificates` when working on a project using Java 9+.

### Azure Key Vault Keys 4.3.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta1-2020-09-11))

#### Key Bug Fixes
- Fixed an issue that prevented using classes from package `com.azure.security.keyvault.keys` when working on a project using Java 9+.

### Anomaly Detector ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-anomalydetector_3.0.0-beta.1/sdk/anomalydetector/azure-ai-anomalydetector/CHANGELOG.md#300-beta1-2020-08-27))

- Initial preview release for Anomaly Detector.

### Azure Search Documents 11.1.0 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#1110-2020-09-09))

#### New Features

- GA release of `buildSearchFields` on `SearchIndexClient` and `SearchIndexAsyncClient`.
- GA release of `JsonSerializer` functionality for `SearchClient` and `SearchAsyncClient`.
- GA release of default `HttpLogOptions` on client builders.

#### Breaking Changes

- Renamed `SearchableFieldProperty` to `SearchableField` and `SimpleFieldProperty` to `SimpleField`.
- Renamed `FieldBuilderOptions.setConverter` to `FieldBuilderOptions.setJsonSerializer`.
- Replaced `ObjectSerializer` setters in builders with `JsonSerializer` to better represent the type requirement.

#### Bug Fixes

- Deprecated getter `OcrSkill.setShouldDetectOrientation()` and replaced with correct Javabeans named `isShouldDetectOrientation()`.

### Azure Search Documents 11.2.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#1120-beta1-2020-09-09))

#### New Features

- Added `SearchBatchClient` and `SearchBatchAsyncClient` which handle automatically creating and sending document batches.
- Added `IndexingHook` interface to provide callback functionality when indexing documents with batching clients.
- Added `IndexingParametersConfiguration`, and related enums, to offer strongly type configuration for `IndexingParameters`.
- Added `ScoringStatistics` and `SessionId` to `SearchOptions`.

#### Breaking Changes

- Updated Jackson annotations to include `required = true` when service must receive or return the property.

### Azure Spring Cloud ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/spring/azure-spring-cloud-autoconfigure/CHANGELOG.md#128-2020-09-14))

#### New features

- Enable Storage starter to support overwriting blob data.
- Enable Actuator for storage blob.
- Enable scheduled enqueue message in Service Bus binders.

#### Key Bug Fixes

- Fixed the repeated consumption of Event Hubs messages when the checkpoint mode is BATCH.

### Event Grid ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventgrid/azure-messaging-eventgrid/CHANGELOG.md#200-beta1-2020-09-09))

- Initial Preview release for Event Grid

### Azure Service Bus ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-beta6-2020-09-11))

#### New features
- Add support for authenticating with a connection string containing a Shared Access Signature.

#### Breaking changes
- LockRenewalOperation is removed. Replaced with renewMessageLock and renewSessionLock.
- ServiceBusDeadLetterReceiverBuilder is removed and replaced with `ServiceBusReceiverBuilder.subQueue(SubQueue)`.
- Remove settlement methods that take `String lockToken` and replace with `ServiceBusReceivedMessage`.
- Rename ServiceBusMangementClient to ServiceBusAdministrationClient.
- Replace all return and parameter types of Instant with OffsetDateTime.

### Tables ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-tables_12.0.0-beta.1/sdk/tables/azure-data-tables/CHANGELOG.md#1200-beta1-2020-09-10))

- Initial preview release for Azure Tables

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md#440-2020-09-12))

#### 4.4.0 (2020-09-12)

#### Key Bug Fixes

- Fixed RequestTimeoutException when enabling `netty-tcnative-boringssl` dependency.
- Fixed memory leak issue on Delete operations in `GATEWAY` mode.
- Fixed a leak in `CosmosClient` instantiation when endpoint uri is invalid.
- Improved `CPU History` diagnostics.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md#440-beta1-2020-08-27))

#### 4.4.0-beta.1 (2020-08-27)

#### New Features
- Added new API to efficiently load many documents (via list of pk/id pairs or all documents for a set of pk values).
- Added new `deleteItem` API.
- Enabled query metrics by default.

#### Key Bug Fixes
- Fixed NPE in `GatewayAddressCache`.
- Fixing query metric issue for zero item response.
- Improved performance (reduced CPU usage) for address parsing and Master-Key authentication.

#### Bug Fixes

- Changed `Fluent` annotations to `Immutable` when the class is immutable.

### Azure Spring Boot ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/spring/azure-spring-boot/CHANGELOG.md#235-2020-09-14))

#### Key Bug Fixes
- Exclude disabled secrets when getting Key Vault secrets
- Get full list of groups the user belongs to from Graph API

### Azure Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_5.1.0-beta.1/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta1-2020-09-17))

#### New features
- Added `offset` and `length` properties for `CategorizedEntity`, `LinkedEntityMatch` and `SentenceSentiment`
  - `length` is the number of characters in the text of these models
  - `offset` is the offset of the text from the start of the document
- Updated Text Analytics SDK's default service API version to `v3.1-preview.2` from `v3.0`.
- Added support for Personally Identifiable Information(PII) entity recognition feature.
  To use this feature, you need to make sure you are using the service's v3.1-preview.1 API.
- Added support for the Opinion Mining feature. To use this feature, you need to make sure you are using the 
service's v3.1-preview.1 and above API. To get this support pass `includeOpinionMining` as `true` in 
`AnalyzeSentimentOptions` when calling the sentiment analysis endpoints.
- Add property `bingEntitySearchApiId` to the `LinkedEntity` class. This property is only available for v3.1-preview.2
and up, and it is to be used in conjunction with the Bing Entity Search API to fetch additional relevant information
about the returned entity.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
