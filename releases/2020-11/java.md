---
title: Azure SDK for Java (November 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### GA

- Storage
- Azure Service Bus

#### Updates

- Azure App Configuration
- Azure Core
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure Identity
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Azure Search Documents
- Azure Form Recognizer
- Azure Text Analytics
- Azure Storage

#### Beta

- Azure Communication Administration
- Azure Communication Chat
- Azure Communication Common
- Azure Communication SMS
- Azure Digital Twins
- Azure Form Recognizer
- Azure Metrics Advisor
- Azure Key Vault Administration
- Azure Key Vault JCA Provider
- Azure Key Vault Keys
- Azure Tables
- Azure Eventhubs
- Azure Service Bus
- Azure Spring Cloud
- Azure Spring Boot
- Azure Text Analytics
- Microsoft Opentelemetry Exporter Azuremonitor

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-metricsadvisor</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.1.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-administration</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.11.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.7.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.7.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.7.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-digitaltwins-core</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.7</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.4.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0-beta.7</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.2.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.7.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.7.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.7.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>microsoft-opentelemetry-exporter-azuremonitor</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
```
To use Azure Spring Cloud starters and binders, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.

```xml
 <dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.0.0-beta.1</version>
</dependency>
```

To use Azure Spring Boot starters, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate.
```xml
<dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>com.azure.spring</groupId>
        <artifactId>azure-spring-boot-bom</artifactId>
        <version>3.0.0-beta.1</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
</dependencyManagement>

<dependencies>
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot</artifactId>
    </dependency>

    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-starter</artifactId>
    </dependency>

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
  <version>1.0.0-beta.2</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Ai Formrecognizer 3.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310-beta1-2020-11-23)

#### Breaking changes

- Defaults to the latest supported API version, which currently is `2.1-preview.2`.

#### New Features

- Added support for pre-built business card recognition.
- Added support for pre-built invoices recognition.
- Added implementation support to create a composed model from the `FormTrainingClient` by calling method `beginCreateComposedModel`.
- Added `language` to `RecognizeContentOptions` for users to specify a preferred language to process the document.
- Added support to `beginRecognizeContent` to recognize selection marks such as check boxes and radio buttons.
- Added support to train and recognize custom forms with selection marks such as check boxes and radio buttons.
This functionality is only available in trained with labels scenarios.
- When passing `includeFieldElements` as true in `RecognizeCustomFormsOptions`, the property `fieldElements` on `FieldData`
and `FormTableCell` will also be populated with any selection marks found on the page.
- Added support for providing locale info when recognizing receipts and business cards.
Supported locales include support EN-US, EN-AU, EN-CA, EN-GB, EN-IN.
- Added property `Appearance` to `FormLine` to indicate the style of the extracted text, for example, "handwriting" or "other".
- Added support for `FormContentType` `image/bmp` in recognize content and prebuilt models.
- Added property `Pages` to `RecognizeContentOptions` to specify the page numbers to analyze.
- Added property `BoundingBox` to `FormTable`.

### Azure Ai Metricsadvisor 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md#100-beta2-2020-11-10)

#### Breaking changes

- Updated `createdDataFeed` method to take one `DataFeed` object.
- Moved `startTime` and `endTime` to positional arguments on several methods as they are required.
- Renamed `listValuesOfDimensionWithAnomalies` method to `listDimensionValuesWithAnomalies`.
- Renamed model `ListValuesOfDimensionWithAnomaliesOptions` method to `ListDimensionValuesWithAnomaliesOptions`.
- Renamed Data feed ingestion granularity type to `"PerMinute"` and `"PerSecond"` instead of `"Minutely"` and `"Secondly"`.
- Renamed Feedback api's from `createMetricFeedback`, `getMetricFeedback` and `listMetricFeedbacks`
to `addFeedback`, `getFeedback` and `listFeedback` respectively.

### Azure Communication Administration 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-administration_1.0.0-beta.3/sdk/communication/azure-communication-administration/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support directly passing connection string to the CommunicationIdentityClientBuilder.
- Added support for sync and async long-running operations
  - beginCreateReservation
  - beginPurchaseReservation
  - beginReleasePhoneNumber

#### Breaking Changes

- Removed credential(CommunicationClientCredential credential) and replaced with
accessKey(String accessKey) within CommunicationIdentityClientBuilder.
- Replaced`createSearch`with to `beginCreateReservation` which returns a poller for the long-running operation.
- Replaced `purchaseSearch`renamed to `beginPurchaseReservation` which returns a poller for the long-running operation.
- Replaced `releasePhoneNumber`renamed to `beginReleasePhoneNumber` which returns a poller for the long-running operation.

### Azure Communication SMS 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features

- Support directly passing connection string to the SmsClientBuilder using connectionString().

#### Breaking Change

- Removed credential(CommunicationClientCredential credential) and replaced with
accessKey(String accessKey) within CommunicationIdentityClientBuilder.

### Azure Core 1.11.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#1110-2020-11-24)

#### New Features

- Added `BinaryData` which allows for a format agnostic representation of binary information and supports
 `ObjectSerializer` for serialization and deserialization.
- Added functionality to eagerly read HTTP response bodies into memory when they will be deserialized into a POJO.

### Azure Core Amqp 1.7.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#170-beta2-2020-11-10)

#### New Features

- Optionally enable idempotency of a send link to send AMQP messages with producer group id, producer owner level and producer sequence number in the message annotations.

### Azure Core Amqp 2.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#200-2020-11-30)

#### New Features
- Added 'AmqpAddress' as a type to support 'AmqpMessageProperties#replyTo' and 'AmqpMessageProperties#to' properties.
- Added 'AmqpMessageId' as a type to support 'AmqpMessageProperties#correlationId' and 'AmqpMessageProperties#messageId'
  properties.
- Added static methods to instantiate 'AmqpMessageBody' for example 'AmqpMessageBody#fromData(byte[])'.

### Breaking Changes
- Changed  'AmqpMessageBody' from interface to a class. User can use 'getBodyType()' to know what is the 'AmqpBodyType'
  of the message.
- Changed type of 'AmqpMessageProperties#correlationId' and 'AmqpMessageProperties#messageId' from 'String'
  to 'AmqpMessageId'.
- Changed type of 'AmqpMessageProperties#replyTo' and 'AmqpMessageProperties#to' from 'String' to 'AmqpAddress'.
- Removed copy constructor for 'AmqpAnnotatedMessage'.
- Renamed 'AmqpBodyType' to 'AmqpMessageBodyType'.

### Azure Core HTTP OkHttp 1.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-okhttp/CHANGELOG.md#140-2020-11-24)

#### New Features

- Added functionality to eagerly read HTTP response bodies into memory when they will be deserialized into a POJO.

### Azure Core HTTP Netty 1.7.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-netty/CHANGELOG.md#170-2020-11-24)

#### New Features

- Added functionality to eagerly read HTTP response bodies into memory when they will be deserialized into a POJO.

### Azure Data Tables 12.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/tables/azure-data-tables/CHANGELOG.md#1200-beta3-2020-11-12)

#### New Features

- Developers can now perform multiple insert, update, or delete entity operations as part of a transactional batch.

#### Key Bug Fixes

- The table client returned from a service client's `getTableClient(tableName)` method was incorrectly configured,
  causing operations to fail. [#16292](https://github.com/Azure/azure-sdk-for-java/issues/16292)
- Passing a `TokenCredential` to a client builder mistakenly assumed it was always a shared key credential.
- Client methods that accept a `timeout` and/or `context` parameter will use default values if either parameter is set
  to `null`. [#16386](https://github.com/Azure/azure-sdk-for-java/issues/16386)

### Azure Digitaltwins Core 1.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/digitaltwins/azure-digitaltwins-core/CHANGELOG.md#101-2020-11-05)

#### Key Bug Fixes

- Removed logic to determine authorization scope based on digital twins instance URI.

### Azure Identity 1.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#120-2020-11-09)

#### New Features

- Added Azure Service Fabric Managed Identity support to `ManagedIdentityCredential`
- Added Azure Arc Managed Identity support to `ManagedIdentityCredential`
- Added support for Docker Containers in `DefaultAzureCredential`

#### Key Bug Fixes

- Prevent `VisualStudioCodeCredential` using invalid authentication data when no user is signed in to Visual Studio Code

### Azure Messaging Servicebus 7.0.0-beta.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-beta7-2020-11-06)

#### New Features

- Added automatic message and session lock renewal feature on the receiver clients. By default, this will be done for 5 minutes.
- Added auto complete feature to the async receiver clients. Once the client completes executing the user provided callback for a message, the message will be completed. If the user provided callback throws an error, the message will be abandoned. This feature is enabled by default and can be disabled by calling `disableAutoComplete()` on builder.
- An intermediate `ServiceBusSessionReceiverClient` is introduced to act as the factory which can then be used to accept sessions from the service. Accepting a session would give you the familiar receiver client tied to a single session.
- Added `ServiceBusProcessorClient` which takes your callbacks to process messages and errors in an infinite loop. This also supports working with sessions where you can provide the maximum number of sessions to work with concurrently.
- Added `BinaryData` in `ServiceBusReceivedMessage` and `ServiceBusMessage`. `BinaryData` is convenience wrapper over byte array and provides object serialization functionality.
- Added `ServicebusReceiverException` and `ServiceBusErrorSource` to provide better handling of errors while receiving messages.

#### Breaking Changes

- Changed `receiveMessages` API to return `ServiceBusReceivedMessage` instead of ServiceBusReceivedMessageContext in `ServiceBusReceiverAsynClient` and `ServiceBusReceiverClient`.
- Removed `SendVia` option from `ServiceBusClientBuilder`.
- Removed `sessionId` setting from `ServiceBusSessionReceiverClientBuilder` as creating receiver clients bound to a single session is now a feature in the new intermediate clients `ServiceBusSessionReceiverClient` and `ServiceBusSessionReceiverAsyncClient`.
- Moved the `maxConcurrentSessions` setting from `ServiceBusSessionReceiverClientBuilder` to
`ServiceBusSessionProcessorClientBuilder` as the feature of receiving messages from multiple sessions is moved from the receiver client to the new `ServiceBusSessionProcessorClient`.

#### Bug Fixes

- `ServiceBusAdministrationClient`: Fixes serialization bug for creating and deserializing rules.

### Azure Messaging Servicebus 7.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-2020-11-30)

#### New Features
- Exposing enum 'ServiceBusFailureReason' in 'ServiceBusException' which contains set of well-known reasons for an
  Service Bus operation failure that was the cause of an exception.
- Added 'BinaryData' support to  'ServiceBusReceivedMessage' and 'ServiceBusMessage'. It provides an easy abstraction
  over many different ways that binary data can be represented. It also provides support for serialize and deserialize
  Object.
- Introducing 'ServiceBusProcessorClient': It provides a push-based mechanism that invokes the message processing
  callback when a message is received or the error handler when an error occurs when receiving messages. It supports
  auto-settlement of messages by default.

#### Breaking Changes
- Renamed all the 'peekMessageAt()' API to 'peekMessage()' in 'ServiceBusReceiverAsyncClient' and
  'ServiceBusReceiverClient'.
- Rename 'getAmqpAnnotatedMessage()' to 'getRawAmqpMessage()' in 'ServiceBusReceivedMessage' and 'ServiceBusMessage'.

#### Bug Fixes
- Set the default 'prefetch' to 0 instead of 1 in both 'RECEIVE_AND_DELETE' and 'PEEK_LOCK' mode. User can set this
  value in builder.

### Azure Messaging Eventhub 5.4.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#540-beta1-2020-11-12)

#### Breaking Changes

- Removed `ObjectBatch` and related `createBatch()` and `send()` operations in favor of supporting `BinaryData` in `EventData`.

### Azure Search Documents 11.2.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/search/azure-search-documents/CHANGELOG.md#1120-beta3-2020-11-10)

#### New Features

- Added encryption key to `SearchIndexer`, `SearchIndexerDataSourceConnection`, and `SearchIndexerSkillset`.
- Added ability to configure initial batch size and retry back-offs to `SearchIndexingBufferedSenderOptions`.

#### Breaking Changes

- Removed `SearchIndexingBufferedSender.getBatchSize()`.
- `SearchIndexingBufferedSenderOptions` now throws on invalid values instead of falling back to default.

### Azure Security Keyvault Administration 4.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta3-2020-11-12)

#### New Features

- Added support for passing a `ServiceVersion` in clients and their builders.

#### Breaking Changes

- Removed exposure of `implementation` (internal) package types via `module-info.java`
- Renamed `KeyVaultRoleAssignmentScope` to `KeyVaultRoleScope` to be in line with other languages.
- Changed the `KeyVaultRoleScope` enum from using `URI` to `URL` and added an overload that accepts a `String` representation of a `URL` too.
- Renamed the `scope` property of `KeyVaultRoleAssignment` to `roleScope` to align with the access client APIs.
- Renamed the `name` parameter to `roleAssignmentName` in role assignment-related APIs, as well as its type from `UUID` to `String`.
- Removed APIs for re-hydrating long-running operations as the guidelines regarding such methods are a still a work in progress
- Annotated read-only classes with `@Immutable`.
- Renamed `actions` and `dataActions` to `allowedActions` and `allowedDataActions` in `KeyVaultPermission`.

### Azure Security Keyvault Keys 4.3.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta3-2020-11-12)

#### New Features

- Added support for encrypting and decrypting AES-GCM and AES-CBC keys.
- Added `KeyType.OCT_HSM` to support "oct-HSM" key operations.

### Azure Security Keyvault Jca 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-jca/CHANGELOG.md#100-beta2-2020-11-17)

- Add support for PEM based certificates.

### Azure Storage Blob 12.9.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md#1290-2020-11-11)

#### New Features

- GA all features from previous release.
- Added support for move and execute permissions on blob SAS and container SAS, and list permissions on blob SAS.
- Added support to specify a preauthorized user id and correlation id for user delegation SAS.
- Renamed `BlobDownloadToFileOptions.rangeGetContentMd5` to `BlobDownloadToFileOptions.retrieveContentRangeMd5`

#### Bug Fixes

- Fixed a bug where interspersed element types returned by page listing would deserialize incorrectly.
- Fixed a bug where BlobInputStream would not eTag lock on the blob, resulting in undesirable behavior if the blob was modified in the middle of reading.

### Azure Storage File Datalake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

#### New Features
- GA all features from previous release.
- Added support to specify whether or not a pipeline policy should be added per -call or per retry.
- Modified DataLakeAclChangeFailedException to extend AzureException

#### Bug Fixes

- Fixed a bug where the endpoint would be improperly converted if the account name contained the word dfs.

### Azure Storage File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

#### New Features

- GA all features from previous release.
- Added support to specify whether or not a pipeline policy should be added per call or per retry.
- Added support for setting access tier on a share through ShareClient.create, ShareClient.setAccessTier.
- Added support for getting access tier on a share through ShareClient.getProperties, ShareServiceClient.listShares
- Renamed setAccessTier to setProperties and deprecated setQuotaInGb in favor of setProperties.
Renamed DeleteSnapshotsOptionType to ShareSnapshotsDeleteOptionType in ShareClient.delete
Removed ability to create a ShareLeaseClient for a Share or Share Snapshot. This feature has been rescheduled for future release.

#### Bug Fixes

- Fixed a bug where interspersed element types returned by range diff listing would deserialize incorrectly.

### Azure Storage Queue [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-queue/CHANGELOG.md)

#### New Features

- Added support to specify whether or not a pipeline policy should be added per call or per retry.

#### Bug Fixes

- Fixed a bug that would cause a NPE when visibilityTimeout was set to null in QueueClient.updateMessage

### Azure Ai Textanalytics 5.1.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta3-2020-11-19)

#### New features

- Added support for healthcare recognition feature. It is represented as a long-running operation. Cancellation supported.
- Added support for analyze tasks feature, It analyzes multiple tasks (such as, entity recognition, PII entity recognition
and key phrases extraction) simultaneously in a list of document.
- Currently, Azure Active Directory (AAD) is not supported in the Healthcare recognition feature.

### Microsoft Opentelemetry Exporter Azuremonitor 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-opentelemetry-exporter-azuremonitor_1.0.0-beta.2/sdk/monitor/azure-opentelemetry-exporter-azuremonitor/CHANGELOG.md)

#### Breaking changes

- Moved this package to `com.microsoft` Maven group.
- Renamed artifact to `microsoft-opentelemetry-exporter-azuremonitor`.
- Replaced `instrumentationKey()` with `connectionString()` in the `AzureMonitorExporterBuilder`.

### Azure Spring Cloud

#### Breaking Changes
- Change group id from com.microsoft.azure to com.azure.spring.
- Change artifact id from spring-cloud-azure-autoconfigure to azure-spring-cloud-autoconfigure.

### Azure Spring Boot

#### Breaking Changes

*   Update `com.azure` group id to `com.azure.spring`.
*   Deprecated azure-spring-boot-metrics-starter.
*   Change group id from `com.microsoft.azure` to `com.azure.spring`.

### JCA Provider for Azure Key Vault ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-jca/CHANGELOG.md#100-beta2-2020-11-17))

- Add support for PEM based certificates.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
