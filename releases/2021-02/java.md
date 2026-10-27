---
title: Azure SDK for Java (February 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our February 2021 client library releases.

#### GA
- Azure Core
- Azure Core HTTP Nettty
- Azure Core HTTP OkHttp
- Azure Cosmos
- Azure Search Documents
- Azure Messaging Event Hubs
- Azure Spring Boot
- Azure Spring Cloud

#### Updates
- Azure AI Text Analytics
- Azure AI Form Recognizer
- Azure Core AMQP
- Azure Core Serializer Json Jackson
- Azure Core Serializer Json Gson
- Azure Core Test
- Azure Data Appconfiguration
- Azure Event Hubs Checkpoint Store for Storage Blob
- Azure Identity
- Azure Messaging Service Bus
- Azure Security Key Vault Certificates
- Azure Security Key Vault Keys
- Azure Security Key Vault Secrets
- Management Library - Core

#### Beta
- Azure AI Form Recognizer
- Azure AI Text Analytics
- Azure Analytics Synapse Access Control
- Azure Analytics Synapse Artifacts
- Azure Analytics Synapse Managed Private Endpoints
- Azure Analytics Synapse Monitoring
- Azure Analytics Synapse Spark
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Core Experimental
- Azure Core Serializer Avro Apache
- Azure Core Tracing Opentelemetry
- Azure Data Tables
- Azure Identity
- Azure Monitor Opentelemetry Exporter
- Azure Security Key Vault JCA
- Azure Security Key Vault Administration
- Azure Security Key Vault Certificates
- Azure Security Key Vault Keys
- Azure Security Key Vault Secrets
- Azure Storage Blob
- Azure Storage Blob Batch
- Azure Stroage Blob Cryptography
- Azure Storage Blob Nio
- Azure Storage Common
- Azure Storage File Datalake
- Azure Storage File Share
- Azure Storage File Datalake
- Azure Storage Internal Avro
- Azure Storage Queue
- Azure Quantum Jobs
- Management Library - Digital Twins
- Management Library - Healthbot Management

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<!-- Insert dependencies -->
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.11.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.11.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-nio</artifactId>
  <version>12.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.11.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.5.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.3-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.9.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-accesscontrol</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-artifacts</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-managedprivateendpoints</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-monitoring</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-spark</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.1.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.5.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.7</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.12.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-digitaltwins</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.1.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.1.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.9</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.13.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.10</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.8.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.7</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.3.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-healthbot</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-monitor-opentelemetry-exporter</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-quantum-jobs</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.1.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.3.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.3.0-beta.3</version>
</dependency>
```
To use Azure Spring Cloud starters and binders, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.

```xml
<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.2.0</version>
</dependency>

 <dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-storage-queue</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>spring-cloud-azure-appconfiguration-config</artifactId>
    <version>1.2.9</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-appconfiguration-config-web</artifactId>
  <version>1.2.9</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-feature-management</artifactId>
  <version>1.2.9</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-feature-management-web</artifactId>
  <version>1.2.9</version>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-starter-azure-appconfiguration-config</artifactId>
  <version>1.2.9</version>
</dependency>
```

To use Azure Spring Boot starters, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.
```xml
<dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>com.azure.spring</groupId>
        <artifactId>azure-spring-boot-bom</artifactId>
        <version>3.2.0</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-active-directory</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-active-directory-b2c</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-cosmos</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-servicebus-jms</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter-storage</artifactId>
    </dependency>
</dependencies>
```

To use JCA Provider for Azure Key Vault, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.
```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>
```
## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Search Documents 11.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/search/azure-search-documents/CHANGELOG.md#1120-2021-02-10)

#### New Features
- Released SearchIndexingBufferedSender<T> which handles batching and indexing documents.
- Added SearchIndexingBufferedSenderBuilder<T> which handles building SearchIndexingBufferSender<T>.
- Added ClientOptions to all builders to allow setting and re-using common client configurations.

#### Breaking Changes
- Removed SearchIndexingBufferedSenderOptions<T> and SearchClient APIs which used it.


### Azure Messaging Event Hubs 5.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#550-2020-02-15)

#### New Features

- Expose BinaryData in EventData.
- Expose EventHubClientBuilder.customEndpointAddress to connect to an alternative endpoint.

### Azure Messaging Event Hubs Checkpoint Store Blob 1.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/CHANGELOG.md#150-2020-02-15)

- Updates dependencies for azure-core-amqp and azure-storage-blob.


### Azure Storage Blob 12.11.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md#12110-beta1-2021-02-10)
- Added support for the 2020-06-12 service version.
- Added support to lock on version id by specifying a consistent read control when opening a BlobInputStream.
- Removed a deep copy in the general upload path to reduce memory consumption and increase perf
- Added a deep copy immediately after calling BlobOutputStream.write to prevent overwriting data in the case of reusing a single buffer to write to an output stream

### Azure Storage Blob Batch 12.9.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-batch/CHANGELOG.md#1290-beta1-2021-02-10)
- Added support for the 2020-06-12 service version.
- Added support to create a BlobBatchClient from a BlobContainerClient to perform container level operations.

### Azure Storage Blob Cryptography 12.11.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md#12110-beta1-2021-02-10)
- Updated azure-storage-common and azure-storage-blob dependencies to add support for the 2020-06-12 service version.

### Azure Storage Blob Nio 12.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-nio/CHANGELOG.md#1200-beta3-2021-02-10)
- Added support for FileSystemProvider.checkAccess method
- Added support for file key on AzureBasicFileAttributes and AzureBlobFileAttributes
- Added support for SeekableByteChannel

### Azure Storage Common 12.11.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-common/CHANGELOG.md#12110-beta1-2021-02-10)
- Added support to log retries
- Removed a deep copy in PayloadSizeGate
- Fixed a bug that would throw if uploading using a stream that returned a number > 0 from available() after the stream had ended

### Azure Storage File Datalake 12.5.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1250-beta1-2021-02-10)
- Added support for the 2020-06-12 service version.
- Added support to undelete a file system.

### Azure Storage File Share 12.9.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md#1290-beta1-2021-02-10)
- Added support for the 2020-06-12 service version.

### Azure Storage Queue 12.9.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-queue/CHANGELOG.md#1290-beta1-2021-02-10)
- Added support for the 2020-06-12 service version.

### Azure Analytics Synapse Accesscontrol 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-accesscontrol/CHANGELOG.md#100-beta2-2021-02-09)

- Support specifying the service API version. (AutoRest update)
- Send missing "Accept" request headers

### Azure Analytics Synapse Artifacts 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md#100-beta2-2021-02-09)

- Support specifying the service API version. (AutoRest update)
- Send missing "Accept" request headers

**Breaking changes:**

- `isHaveLibraryRequirementsChanged()` and `setHaveLibraryRequirementsChanged()` methods on `BigDataPoolResourceInfo` are removed.
- `getProjectConnectionManagers()` and `getPackageConnectionManagers()` now return `Map<String, Map<String, SsisExecutionParameter>>` instead of `Map<String, Object>`.

### Azure Analytics Synapse Managedprivateendpoints 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-managedprivateendpoints/CHANGELOG.md#100-beta2-2021-02-09)

- Support specifying the service API version. (AutoRest update)
- Send missing "Accept" request headers

### Azure Analytics Synapse Monitoring 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-monitoring/CHANGELOG.md#100-beta2-2021-02-09)

- Support specifying the service API version. (AutoRest update)
- Send missing "Accept" request headers

### Azure Analytics Synapse Spark 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-spark/CHANGELOG.md#100-beta2-2021-02-09)

- Support specifying the service API version. (AutoRest update)
- Send missing "Accept" request headers

**Breaking changes:**
- `getMsg()` renamed to `getMessage()` on `SparkStatementCancellationResult`
- `setMsg()` renamed to `setMessage()` on `SparkStatementCancellationResult`

### Azure Core Tracing Opentelemetry 1.0.0-beta.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta7-2021-02-05)

#### Dependency Updates
- Updated versions of `opentelemetry-api` to `0.14.1` version.
  More detailed information about the new OpenTelemetry API version can be found in [OpenTelemetry changelog](https://github.com/open-telemetry/opentelemetry-java/blob/master/CHANGELOG.md#version-0141---2021-01-14)

### Azure Cosmos 4.12.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#4120-2021-02-09)
##### New Features
* Added connection endpoint rediscovery feature to help reduce and spread-out high latency spikes.
* Added changeFeed pull model beta API.
* Added support for resuming query from a pre split continuation token after partition split.
* Optimized query execution time by caching query plan for single partition queries with filters and orderby.

##### Key Bug Fixes
* Fixed telemetry deserialization issue.
* Skip session token for query plan, trigger and UDF.
* Improved session timeout 404/1002 exception handling.

### Azure Resourcemanager Digitaltwins 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/digitaltwins/azure-resourcemanager-digitaltwins/CHANGELOG.md#100-beta1-2021-02-09)

- Azure Resource Manager AzureDigitalTwins client library for Java. This package contains Microsoft Azure SDK for AzureDigitalTwins Management SDK. Azure Digital Twins Client for managing DigitalTwinsInstance. Package tag package-2020-12. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Ai Formrecognizer 3.1.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310-beta2-2021-02-10)

#### Breaking Changes
- Renamed `Appearance`, `Style` and `TextStyle` models to `TextAppearance`, `TextStyle` and `TextStyleName` respectively.
- Changed the type of `Locale` from `String` to `FormRecognizerLocale` in `RecognizeBusinessCardsOptions`, `RecognizeInvoicesOptions`, and `RecognizeReceiptsOptions`.
- Changed the type of `Language` from `String` to `FormRecognizerLanguage` in `RecognizeContentOptions`.

### Azure Core Management 1.1.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-management/CHANGELOG.md#111-2021-02-05)

- Fixed long-running operation, PUT method, response 200 and Azure-AsyncOperation.

### Azure Communication Administration will be deprecated

- Identity client is moved to new package Azure Communication Identity.
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Common 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-common_1.0.0-beta.4/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta4-2021-02-09)

#### Breaking Changes

- Renamed `CommunicationUserCredential` to `CommunicationTokenCredential`.
- Replaced constructor `CommunicationTokenCredential(TokenRefresher tokenRefresher, String initialToken, boolean refreshProactively)` and `CommunicationTokenCredential(TokenRefresher tokenRefresher)` with `CommunicationTokenCredential(CommunicationTokenRefreshOptions tokenRefreshOptions)`.
- Renamed `PhoneNumber` to `PhoneNumberIdentifier`.
- Renamed `CommunicationUser` to `CommunicationUserIdentifier`.
- Renamed `CallingApplication` to `CallingApplicationIdentifier`.

#### New Features

- Added `MicrosoftTeamsUserIdentifier`

### Azure Communication Identity 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-identity_1.0.0-beta.4/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta4-2021-02-09)

#### Breaking Changes

- `pstn` token scope is removed.
- `revokeTokens` now revoke all the currently issued tokens instead of revoking tokens issued prior to a given time.
- `issueToken` returns an instance of `core.credential.AccessToken` instead of `CommunicationUserToken`.

#### New Features

- Added CommunicationIdentityClient and CommunicationIdentityAsyncClient (originally was part of the azure-communication-aministration package).
- Added support for Azure Active Directory Authentication.
- Added ability to create a user and issue token for it at the same time.

### Azure Communication Chat 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-chat_1.0.0-beta.4/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta4-2021-02-09)

#### Breaking Changes

- Updated to azure-communication-common version 1.0.0-beta.4. Now uses `CommunicationUserIdentifier` and `CommunicationIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed `Priority` field from `ChatMessage`.

### Azure Core 1.13.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#1130-2021-02-05)

#### New Features

- Added `setPollInterval` to `PollerFlux` and `SyncPoller` to allow mutating how often a long-running request is polled.
- Added `HttpClientOptions` to allow for reusable `HttpClient` configurations to be passed into SPIs and client builders.
- Added the ability to disable tracing for individual network requests.

#### Deprecations

- Deprecated `HttpHeaders.put` and replaced with `HttpHeaders.set`.

### Azure Core Amqp 2.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#202-2021-02-05)

#### New Features

- Add support for connecting to an alternative hostname for the AMQP message broker.

### Azure Core Experimental 1.0.0-beta.10 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta10-2021-02-05)

#### New Features

- Added challenge based authentication support via `BearerTokenAuthenticationChallengePolicy` and `AccessTokenCache` classes.

### Azure Core Http Netty 1.8.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-netty/CHANGELOG.md#180-2021-02-05)

#### New Features

- Exposed service provider interfaces used to create `HttpClient` instances.

#### Bug Fixes

- Fixed a bug where authenticated proxies would use different DNS resolution than non-authenticated proxies. [#17930](https://github.com/Azure/azure-sdk-for-java/issues/17930)

### Azure Core Http Okhttp 1.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-okhttp/CHANGELOG.md#150-2021-02-05)

#### New Features

- Exposed service provider interfaces used to create `HttpClient` instances.

### Azure Monitor Opentelemetry Exporter 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/monitor/azure-monitor-opentelemetry-exporter/CHANGELOG.md#100-beta3-2021-02-09)

#### Breaking changes
- Renamed artifact to `azure-monitor-opentelemetry-exporter`.

#### Dependency Updates
- Updated versions of `opentelemetry-api` and `opentelemetry-sdk` to `0.14.1` version.

### Azure Quantum Jobs 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/quantum/azure-quantum-jobs/CHANGELOG.md#100-beta1-2021-02-02)

#### New features
Initial release of azure-quantum-jobs. See [Getting Started](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/quantum/azure-quantum-jobs/README.md#getting-started) for more details.

### Azure Ai Textanalytics 5.1.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta4-2021-02-10)
#### New features
- Added new classes, `StringIndexType`, `RecognizeEntitiesOptions`, `RecognizeLinkedEntitiesOptions`.
- Added new options to control how the offset and length are calculated by the service.
- Added new APIs to recognize batched entities and linked batch entities.

#### Breaking changes
##### Analysis healthcare entities
- The healthcare entities returned by `beginAnalyzeHealthcareEntities` are now organized as a directed graph where the
  edges represent a certain type of healthcare relationship between the source and target entities. Edges are stored
  in the `relatedEntities` property.

##### Analyze multiple actions
- The word "action" are used consistently in our names and documentation instead of "task".

### Azure Security Key Vault Keys 4.3.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta4-2021-02-11)

#### Key Bug Fixes

- Fixed issue where cryptographic operations would be attempted locally for symmetric keys that were missing their key material ('k' component).

### Azure Security Key Vault Keys 4.2.5 [ChangeLog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#425-2021-02-11)

#### Key Bug Fixes

- Fixed issue where cryptographic operations would be attempted locally for symmetric keys that were missing their key material ('k' component).

### Azure Spring Cloud

### New Features
 - Support `ServiceBusMessageConverter` as a bean to support customize `ObjectMapper`.

### Azure Spring Boot

### Breaking Changes
- Remove `azure.activedirectory.b2c.oidc-enabled` property.
- Add `azure.activedirectory.b2c.login-flow` property.
- Change the type of `azure.activedirectory.b2c.user-flows` to map and below is the new structure:
    ```yaml
    azure:
      activedirectory:
        b2c:
          login-flow: ${your-login-user-flow-key}               # default to sign-up-or-sign-in, will look up the user-flows map with provided key.
          user-flows:
            ${your-user-flow-key}: ${your-user-flow-name-defined-on-azure-portal}
    ```
- Require new property of `spring.jms.servicebus.pricing-tier` to set pricing tier of Azure Service Bus. Supported values are `premium`, `standard` and `basic`.
### New Features
- Enable MessageConverter bean customization.
- Update the underpinning JMS library for the Premium pricing tier of Service Bus to JMS 2.0.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
