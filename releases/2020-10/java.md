
title: Azure SDK for Java (October 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- Management Library - AppService
- Management Library - Authorization
- Management Library - Compute
- Management Library - Container Service
- Management Library - CosmosDB
- Management Library - DNS
- Management Library - Insight (Monitor)
- Management Library - Key Vault
- Management Library - Managed Identity
- Management Library - Network
- Management Library - Resources
- Management Library - Storage

#### Updates

- Azure App Configuration
- Azure Core
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure Core Amqp
- Azure Event Hubs
- Azure Identity
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Azure Search Documents
- Form Recognizer

#### Beta

- Azure Storage
- Azure Core Experimental
- Azure Core Serializer Apache Avro
- Azure Communication Administration
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Sms
- Azure Digitial Twins
- Azure Identity
- Azure Key Vault Administration
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Event Grid
- Management Library - CDN
- Management Library - Container Instance
- Management Library - Container Registry
- Management Library - Event Hubs
- Management Library - Private DNS
- Management Library - Redis
- Management Library - Service Bus
- Management Library - Spring Cloud
- Management Library - SQL
- Management Library - Traffic Manager
- Azure Metrics Advisor
- Azure Search Documents
- Azure Service Bus
- Azure Storage Blob Batch
- Azure Storage Blob Blob
- Azure Storage Blob Cryptography
- Azure Storage Blob Changefeed
- Azure Storage File Datalake
- Azure Storage File Share
- Azure Storage Queue
- Azure Tables
- Azure Text Analytics
- Opentelemetry exporter Azure monitor
- Azure Spring Boot

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.1.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-metricsadvisor</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-administration</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.7</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.6.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.3.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-digitaltwins-core</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventgrid</artifactId>
  <version>2.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.2.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.2.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.3.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.9.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.7.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.9.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.3.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.7.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.7.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.1-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.1-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.7.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>opentelemetry-exporters-azuremonitor</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-storage</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-keyvault</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-authorization</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-msi</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-network</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-compute</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cosmos</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-dns</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerservice</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.0.0-beta.5</version>
</dependency>
```

If you are using multiple management libraries in your project and want to import all libraries altogether, you can also choose to use the following wrapper package

```xml

<!-- This package contains all currently available management libraries that are stable-->
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.0.0</version>
</dependency>

<!-- This package contains both stable and preview management libraries -->
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.0.0-beta.5</version>
```

To use Azure Spring Boot starters, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.
```xml
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>azure-servicebus-jms-spring-boot-starter</artifactId>
  <version>2.3.6-beta.1</version>
</dependency>
```
## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Ai Textanalytics 5.1.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta2-2020-10-06)
#### Breaking changes
- Removed property `length` from `CategorizedEntity`, `SentenceSentiment`, `LinkedEntityMatch`, `AspectSentiment`,
`OpinionSentiment`, and `PiiEntity` because the length information can be accessed from the text property itself
 using the string's length property.

### Azure Ai Metrics advisor 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md#100-beta1-2020-10-07)

#### New Features:
- Initial preview release of Metrics advisor.
- Two client design:
    - `MetricsAdvisorAdministrationClient` to perform creation, updation and deletion of Metrics Advisor resources.
    - `MetricsAdvisorClient` helps with querying API's to helps with listing incidents, listing root causes of incidents
    and adding feedback to tune your model.
- Authentication with API key supported using `MetricsAdvisorKeyCredential("<subscription_key>", "<api_key>")`.
- Reactive streams support using [Project Reactor](https://projectreactor.io/).

### Azure Core Test 1.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-test/CHANGELOG.md#150-2020-10-01)

#### New Features

- Enhanced playback recording to use test class name plus test name to identify records.


### Azure Core 1.9.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#190-2020-10-01)

#### New Features

- Added `ServiceClientProtocal` to allow the client to indicate which networking protocol it will use.
- Added `HttpPipelinePosition` which allows `HttpPipelinePolicy`s to indicate their position when used in a client builder.
- Added default interface method `HttpPipelinePolicy.getPipelinePosition` that returns `HttpPipelinePosition.PER_RETRY`.

#### Bug Fixes

- Fixed a bug where calling `UrlBuilder.parse` could result in an exception. [#15013](https://github.com/Azure/azure-sdk-for-java/issues/15013)
- Changed `ContinuablePagedIterable` implementation to use a custom iterable to prevent additional, unrequested pages from being retrieved. [#15575](https://github.com/Azure/azure-sdk-for-java/issues/15575)

### Azure Core Amqp 1.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-amqp_1.6.0/sdk/core/azure-core-amqp/CHANGELOG.md#160-2020-10-12)

#### New Features
- Added peer certificate verification options when connecting to an AMQP endpoint.

#### Breaking Changes
- Removed `BinaryData` type which was used for `AmqpAnnotatedMessage`.


### Azure Core Experimental 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta6-2020-10-06)

#### New Features
- Added `BinaryData` abstraction to represent binary data and supports serialization through `ObjectSerializer`.

### Azure Core Experimental 1.0.0-beta.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta7-2020-10-08)

#### New Features
- Added APIs to `JsonPatchDocument` which accept pre-serialized JSON.

### Azure Core Experimental 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta5-2020-10-01)

#### New Features
- Added `JsonPatchDocument` to support JSON Patch functionality.

### Azure Data Tables 12.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/tables/azure-data-tables/CHANGELOG.md#1200-beta2-2020-10-06)

#### New Features

- Developers can now subclass `TableEntity` and decorate the subclass with properties, rather than adding properties
  manually by calling `addProperty()`.
- The `getEntity` methods have gained the `select` query option to allow for more efficient existence checks for a table
  entity.

#### Breaking Changes

- The non-functional `TableClient.listEntities(options, timeout)` method was removed.

#### Bug Fixes

- TableClientBuilder's constructor is now a public API.
- The `TableClient.updateEntity(entity)` method was mistakenly performing an upsert operation rather than an update.
- The `TableAsyncClient.updateEntity(entity)` method always returned an empty result.

### Azure Digitaltwins Core 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/digitaltwins/azure-digitaltwins-core/CHANGELOG.md#100-beta3-2020-10-01)

#### Bug Fixes
- Fixed issue with pagination APIs that support max-item-count where the item count was not respected from the second page forward.

### Azure Identity 1.2.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#120-beta2-2020-10-06)

#### New Features
- Added the methods `pfxCertificate(InputStream certificate, String clientCertificatePassword)` and `pemCertificate(InputStream certificate)` in `ClientCertificateCredentialBuilder`.
- Added `includeX5c(boolean)` method in `ClientCertificateCredentialBuilder` to enable subject name / issuer based authentication.
- Added a default `challengeConsumer` in `DeviceCodeCredentialBuilder` which prints the device code information to console. The `challengeConsumer` configuration is no longer required in `DeviceCodeCredentialBuilder`.

### Azure EventHubs 5.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#530-2020-10-12)
#### New Features
- Add `clientOptions` to `EventHubClientBuilder` to support for setting user's application id in the user-agent property
of the amqp connection.

### Azure Search Documents 11.2.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/search/azure-search-documents/CHANGELOG.md#1120-beta2-2020-10-06)

#### New Features

- Added `SearchFilter` to help aid creation of OData filter expressions.
- Added required parameter `documentKeyRetriever` to `SearchIndexingBufferedSender` to better correlate response documents to sent documents.
- Added `ClientOptions` to all builders to support setting `applicationId` in `User-Agent` string and headers that need to be applied to each request.
- Added support for `HttpPipelinePosition` in client builders to determine when an `HttpPipelinePolicy` will be invoked.

#### Breaking Changes

- Made `SearchIdexingBufferedSender` generic typed.
- Removed `IndexingHooks` in favor of individual callbacks.
- Removed the ability to configure `batchSize` on buffered sender and changed the default to 500 instead of 1000.
- Removed `SearchBatchClientBuilder` for options bag `SearchIndexingBufferedSenderOptions`.
- Renamed `SearchBatchClient` and `SearchBatchAsyncClient` to `SearchIndexingBufferedSender` and `SearchIndexingBufferedAsyncSender`.
- Renamed `getSearchBatchClient` to `getSearchIndexingBufferedSender` in `SearchClient`.
- Renamed `onActionRemoved` to `onActionSent`.

### Azure Security Keyvault Administration 4.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta2-2020-10-09)

#### New Features
- Added the new public APIs `getBackupOperation` and `getRestoreOperation` for querying the status of long-running operations in `KeyVaultBackupClient` and `KeyVaultBackupAsyncClient`.
- Added API overloads that allow for passing specific polling intervals for long-running operations:
    - `KeyVaultBackupAsyncClient`
        - `beginBackup(String, String, Duration)`
        - `beginRestore(String, String, String, Duration)`
        - `beginSelectiveRestore(String, String, String, String, Duration)`
    - `KeyVaultBackupClient`
        - `beginBackup(String, String, Duration)`
        - `beginRestore(String, String, String, Duration)`
        - `beginSelectiveRestore(String, String, String, String, Duration)`
- Added support for `com.azure.core.util.ClientOptions` in client builders.

### Azure Security Keyvault Certificates 4.2.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta2-2020-10-09)

#### New Features
- Added `KeyVaultCertificateIdentifier`.
- Added API overloads that allow for passing specific polling intervals for long-running operations:
    - `CertificateAsyncClient`
        - `beginCreateCertificate(String, CertificatePolicy, Boolean, Map<String, String>, Duration)`
        - `getCertificateOperation(String, Duration)`
        - `beginDeleteCertificate(String, Duration)`
        - `beginRecoverDeletedCertificate(String, Duration)`
    - `CertificateClient`
        - `beginCreateCertificate(String, CertificatePolicy, Boolean, Map<String, String>, Duration)`
        - `getCertificateOperation(String, Duration)`
        - `beginDeleteCertificate(String, Duration)`
        - `beginRecoverDeletedCertificate(String, Duration)`
- Added support for `com.azure.core.util.ClientOptions` in client builders.

### Azure Security Keyvault Keys 4.3.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta2-2020-10-09)

#### New Features
- Added `KeyVaultKeyIdentifier`.
- Added API overloads that allow for passing specific polling intervals for long-running operations:
    - `KeyAsyncClient`
        - `beginDeleteKey(String, Duration)`
        - `beginRecoverDeletedKey(String, Duration)`
    - `KeyClient`
        - `beginDeleteKey(String, Duration)`
        - `beginRecoverDeletedKey(String, Duration)`
- Added support for `com.azure.core.util.ClientOptions` in client builders.

#### Bug Fixes
- Fixed an issue that prevented the `tags` and `managed` members of `KeyProperties` from getting populated when retrieving a single key using `KeyClient`, `KeyAsyncClient`, `CryptographyClient` and `CryptographyAsyncClient`.


### Azure Security Keyvault Secrets 4.3.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#430-beta2-2020-10-09)

#### New Features
- Added `KeyVaultSecretIdentifier`.
- Added API overloads that allow for passing specific polling intervals for long-running operations:
    - `SecretAsyncClient`
        - `beginDeleteSecret(String, Duration)`
        - `beginRecoverDeletedSecret(String, Duration)`
    - `SecretClient`
        - `beginDeleteSecret(String, Duration)`
        - `beginRecoverDeletedSecret(String, Duration)`
- Added support for `com.azure.core.util.ClientOptions` in client builders.

### Azure Storage Blob 12.9.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md#1290-beta1-2020-10-01)
#### New Features
- Added support for the 2020-02-10 service version.
- Added support to specify Arrow Output Serialization when querying a blob.
- Added support to undelete a container.
- Added support to set BlobParallelUploadOptions.computeMd5 so the service can perform an md5 verification.
- Added support to specify block size when using BlobInputStream.

#### Bug Fixes
- Fixed a bug where users could not download more than 5000MB of data in one shot in the downloadToFile API.
- Fixed a bug where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where Default Azure Credential would not work with Azurite.
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.
- Fixed a bug where BlockBlobOutputStream would not handle certain errors.

### Azure Storage Blob 12.9.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md#1290-beta2-2020-10-08)
#### New Features
- Added support to specify whether or not a pipeline policy should be added per call or per retry.


### Azure Storage Blob Cryptography 12.9.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md#1290-beta1-2020-10-01)
#### New Features
- Added support to set BlobParallelUploadOptions.computeMd5 so the service can perform an md5 verification.
- Added support to specify 'requiresEncryption' on the EncryptedBlobClientBuilder to specify whether or not to enforce that the blob is encrypted on download.

#### Bug Fixes
- Fixed a bug where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.

### Azure Storage File Datalake 12.3.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1230-beta1-2020-10-01)
#### New Features
- Added support for the 2020-02-10 service version.
- Added support for setting, modifying, and removing ACLs recursively.
- Added support to schedule file expiration.
- Added support to specify Arrow Output Serialization when querying a file.
- Added support to generate directory SAS and added support to specify additional user ids and correlation ids for user delegation SAS.
- Added support to upload data to a file from an InputStream.
- Added support to specify permissions and umask when uploading a file.

#### Bug Fixes

- Fixed a bug where users could not download more than 5000MB of data in one shot in the readToFile API.
- Fixed a bug where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where an empty string would be sent with the x-ms-properties header when metadata was null or empty.
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.


### Azure Storage File Share 12.7.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md#1270-beta1-2020-10-01)
#### New Features
- Added support for the 2020-02-10 service version.
- Added support to getFileRanges on a previous snapshot by adding the getFileRangesDiff API.
- Added support to set whether or not smb multichannel is enabled.
- Added support to lease shares and snapshot shares.
- Added support to specify a lease id for share operations.

#### Bug Fixes
- Fixed a bug where getProperties on a file client would throw a HttpResponseException instead of ShareStorageException.
- Fixed a bug where snapshot would be appended to a share snapshot instead of sharesnapshot.
- Fixed a bug that would cause auth failures when building a client by passing an endpoint which had a sas token with protocol set to https,http
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.

### Azure Storage Queue 12.7.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-queue/CHANGELOG.md#1270-beta1-2020-10-01)
#### New Features
- Added support for the 2020-02-10 service version.

#### Bug Fixes
- Fixed a bug where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where Default Azure Credential would not work with Azurite.
- Fixed a bug that would cause message text to be erased when only updating the visibility timeout
- Fixed a bug that would cause auth failures when building a client by passing an endpoint which had a sas token with protocol set to https,http
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.

### Opentelemetry Exporters Azuremonitor 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/opentelemetry-exporters-azuremonitor_1.0.0-beta.1/sdk/monitor/opentelemetry-exporters-azuremonitor/CHANGELOG.md)

#### New Features
- Initial release. Please see the README and wiki for information on the new design.

- Major changes only!

### Azure Storage Blob [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md)

#### New Features
- Added support to undelete a container.
- Added support to specify Arrow Output Serialization when querying a blob.
- Added support to set `BlobParallelUploadOptions.computeMd5` so the service can perform an md5 verification.
- Added support to specify block size when using `BlobInputStream`

#### Key Bug Fixes
- Fixed bug where users could not download more than 5000MB of data in one shot in the `downloadToFile` API.
- Fixed but where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where Default Azure Credential would not work with Azurite.
- Fixed a bug where a custom application ID in `HttpLogOptions` would not be added to the User Agent String.
- Fixed a bug where `BlockBlobOutputStream` would not handle certain errors.

### Azure Storage File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

#### New Features
- Added support for setting, modifying, and removing ACLs recursively.
- Added support to schedule file expiration.
- Added support to specify Arrow Output Serialization when querying a file.
- Added support to generate directory SAS and added support to specify additional user ids and correlation ids for user delegation SAS.
- Added support to upload data to a file from an InputStream.
- Added support to specify permissions and umask when uploading a file.

#### Key Bug Fixes
- Fixed a bug where users could not download more than 5000MB of data in one shot in the `readToFile` API.
- Fixed a bug where the TokenCredential scope would be incorrect for custom URLs.
- Fixed a bug where an empty string would be sent with the x-ms-properties header when metadata was null or empty.
- Fixed a bug where a custom application id in HttpLogOptions would not be added to the User Agent String.

### Azure Storage File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

#### New Features
- Added support for the 2020-02-10 service version.
- Added support to getFileRanges on a previous snapshot by adding the `getFileRangesDiff` API.
- Added support to set whether or not SMB multichannel is enabled.
- Added support to lease shares and snapshot shares.
- Added support to specify a lease id for share operations.

#### Key Bug Fixes
- Fixed a bug where getProperties on a file client would throw a HttpResponseException instead of ShareStorageException.
- Fixed a bug where snapshot would be appended to a share snapshot instead of sharesnapshot.
- Fixed a bug that would cause authentication failures when building a client by passing an endpoint which had a SAS token with protocol set to https,http
- Fixed a bug where a custom application ID in HttpLogOptions would not be added to the User Agent String.

### Azure Spring Boot ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/feature/spring-jms-servicebus/sdk/spring/azure-spring-boot/CHANGELOG.md#236-beta1-2020-10-14))

#### New Features
- upgrade jms underlying library with azure-servicebus-jms.

### Management Libraries

We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](https://aka.ms/azsdk/java/mgmt)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``

More details of recent management library release annoucements as well as future roadmap can be found at [this blog post](https://devblogs.microsoft.com/azure-sdk/october-2020-management-ga/)

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
