---
title: Azure SDK for Java (July 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our July 2020 client library releases.

#### GA

- Azure Search

#### Updates

- Azure-Cosmos
- App Configuration
- Core
- Core - AMQP
- Core - Http Netty
- Core - Http OkHttp
- Core - Test
- KeyVault (Certificates, Keys, Secrets)
- Text Analytics

#### Preview

- Core - Experimental
- Form Recognizer
- KeyVault (Certificates, Keys, Secrets)
- Management Library - AppService
- Management Library - Authorization
- Management Library - Compute
- Management Library - CosmosDB
- Management Library - Insight
- Management Library - Key Vault
- Management Library - Managed Identity
- Management Library - Network
- Management Library - Resources
- Management Library - SQL
- Management Library - Storage
- Schema Registry
- Schema Registry - Avro-Specific
- Storage - Blob
- Storage - Blob ChangeFeed
- Storage - File DataLake
- Storage - File Share
- Service Bus

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.6.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.3.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.5.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.2.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.3.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.2.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.3</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.0.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-schemaregistry</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-schemaregistry-avro</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.1.0-beta.6</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.0.8</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.0-beta.4</version>
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
  <artifactId>azure-resourcemanager-sql</artifactId>
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
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.0.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.0.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-schemaregistry</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-schemaregistry-avro</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.8.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.2.0-beta.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.6.0-beta.1</version>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.0.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.0-beta.4</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.1.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.0-beta.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.1.5</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.0-beta.4</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#160-2020-07-02))

#### New Features

- Added utility class `UserAgentUtil` which constructs User-Agent headers following SDK guidelines.

### Azure Core AMQP ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#130-2020-07-02))

#### New Features

- Added `createProducer` constructor which takes an additional parameter for link properties.

#### Key Bug Fixes

- Fixed `User-Agent` string to follow guidelines.

### Azure Core Experimental ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta1-2020-07-02))

#### New Features

- Added `ObjectSerializer` interface containing generic serializer APIs.
- Added `JsonSerializer` interface containing JSON specific serializer APIs.
- Added `JsonNode`, and subclasses, which are strongly type representations of a JSON tree.
- Added `GeoJSON` classes and serializers.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#420-2020-07-14))

#### 4.2.0 (2020-07-14)

#### New Features

- Added script logging enabled API to `CosmosStoredProcedureRequestOptions`.
- Updated `DirectConnectionConfig` default `idleEndpointTimeout` to 1h and default `connectTimeout` to 5s.

#### Key Bug Fixes

- Fixed issue where `GatewayConnectionConfig` `idleConnectionTimeout` was overriding `DirectConnectionConfig` `idleConnectionTimeout`.
- Fixed `responseContinuationTokenLimitInKb` get and set APIs in `CosmosQueryRequestOptions`.
- Fixed issue in query and change feed when recreating the collection with same name.
- Fixed issue with top query throwing ClassCastException.
- Fixed issue with order by query throwing NullPointerException.
- Fixed issue in handling of cancelled requests in direct mode causing reactor `onErrorDropped` being called.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#410-2020-06-25))

#### 4.1.0 (2020-06-25)

#### New Features

- Added support for `GROUP BY` query.
- Increased the default value of maxConnectionsPerEndpoint to 130 in DirectConnectionConfig.
- Increased the default value of maxRequestsPerConnection to 30 in DirectConnectionConfig.

#### Key Bug Fixes

- Fixed issues with order by query returning duplicate results when resuming by using continuation token.
- Fixed issues with value query returning null values for nested object.
- Fixed null pointer exception on request manager in RntbdClientChannelPool.

### Azure Identity ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#110-beta6-2020-07-10)

#### 1.1.0-beta.6 (2020-07-10)

- Added .getCredentials() method to DefaultAzureCredential and ChainedTokenCredential and added option .addAll(Collection<? extends TokenCredential>) on ChainedtokenCredentialBuilder.
- Added logging information in credentials and improved error messages in DefaultAzureCredential.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#700-beta4-2020-07-10)

#### Breaking Changes
- Add Message/Messages suffix to Peek/Send/Receive/Abandon/Defer/Complete/DeadLetter methods.
- Message settlement methods take a lock token string rather than `MessageLockToken`.
- Remove `MessageLockToken` interface. `ServiceBusReceivedMessage` no longer uses interface.
- Remove `ServiceBusReceiverAsyncClient.receive(int)` method; use `receive().take(int)` instead.

#### New Features
- Add `ServiceBusDeadLetterReceiverClientBuilder` to receive messages from dead-letter queue.
- Add support to send message via another entity.

### Azure Search [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/search/azure-search-documents/CHANGELOG.md#1100-2020-07-13)
- Changed to GA version 11.0.0.
- Removed preview version `SearchClientOptions.ServiceVersion.V2019_05_06_Preview` and added version `SearchClientOptions.ServiceVersion.V2020_06_30`.

#### New Features

- Added `IndexDocumentsOptions` used to configure document operations.

#### Breaking Changes

- Moved search result metadata to `SearchPagedFlux` and `SearchPagedIterable` from `SearchPagedResponse`.
- Changed many model classes from fluent setter pattern to immutable constructor pattern.
- Removed `RequestOptions` from APIs, instead use pipeline context to pass per method contextual information.
- Removed strongly type GeoJSON classes.

#### Bug Fixes
- Removed `implementation` classes from APIs.

### Azure Schema Registry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/schemaregistry/azure-data-schemaregistry/CHANGELOG.md#100-beta2-2020-06-19))

## 1.0.0-beta.2 (2020-06-19)

### Key Bug Fixes

- Fix 4xx HTTP response handling

### Azure Schema Registry Avro ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-schemaregistry-avro_1.0.0-beta.3/sdk/schemaregistry/azure-data-schemaregistry-avro/CHANGELOG.md#100-beta2-2020-06-19))

## 1.0.0-beta.2 (2020-06-19)

### Key Bug Fixes

- Fix null max schema map size parameter behavior

### Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md)

##### New Features
- Added support for Blob Tags, Blob Versioning, Jumbo Blobs, and more

#### Blob ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-changefeed/CHANGELOG.md)

##### New Features
- Added a preview version of this library to support change feed

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

##### New Features
- Added support to query a file
- Added support to increase max size of data that can be sent via append

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

##### New Features
- Added support for restoring file share


### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#100-beta4-2020-07-07))

## 1.0.0-beta.4 (2020-07-07)
### Breaking changes
- `beginRecognizeReceipt` APIs now return a `RecognizedForm` model instead of a `RecognizedReceipt`.
- Model and property renaming detailed in changelog

### Key Bug Fixes
- Fixed `textAngle` to be returned between `(-180, 180]`.


### New Management Libraries

A new set of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/) are now in Public Preview. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/resourcemanager)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
