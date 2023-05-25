---
title: Azure SDK for Java (January 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our January 2021 client library releases.

#### GA

- Azure Storage Blob
- Azure Storage Blob Batch
- Azure Storage Blob Changefeed
- Azure Storage Blob Cryptography
- Azure Storage File Datalake
- Azure Storage File Share
- Azure Storage Queue
- Azure Storage Internal Avro
- Azure Identity Spring
- Java Spring Boot
- Java Spring Boot AAD B2C Starter
- Java Spring Boot AAD Starter
- Java Spring Boot Cosmos db Starter
- Java Spring Boot KeyVault Secrets Starter
- Java Spring Boot ServiceBus Jms Starter
- Java Spring Boot Starter
- Java Spring Boot Storage Starter
- Java Spring Cloud Autoconfigure
- Java Spring Cloud Context
- Java Spring Cloud Event Hub Binder
- Java Spring Cloud Messaging
- Java Spring Cloud Service Bus Queue Stream Binder
- Java Spring Cloud Service Bus Stream Binder Core
- Java Spring Cloud Service Bus Topic Stream Binder
- Java Spring Cloud Starter Cache
- Java Spring Cloud Starter Event Hub Kafka
- Java Spring Cloud Starter Event Hubs
- Java Spring Cloud Starter Service Bus
- Java Spring Cloud Storage
- Java Spring Cloud Storage Queue Starter
- Java Spring Cloud Stream Binder Test
- Java Spring Cloud Telemetry
- Java Spring Integration Core
- Java Spring Integration Event Hubs
- Java Spring Integration Service Bus
- Java Spring Integration Storage Queue
- Java Spring Integration Test

#### Updates

- Azure Cosmos
- Azure Identity
- Azure Spring Data Cosmos
- Azure App Configuration
- Azure Core
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure Identity
- Azure Key Vault Certificates
- Azure Key Vault Keys
- Azure Key Vault Secrets
- Azure Search Documents
- Azure Eventhubs
- Azure Form Recognizer
- Azure Text Analytics
- Azure Service Bus

#### Beta

- Microsoft Azure Attestation (coming soon)
- Microsoft Opentelemetry Exporter Azuremonitor
- Management Library - Healthbot Management
- Management Library - Confluent
- Java Keyvault JCA
- Java Spring Boot KeyVault Certificates Starter

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.10.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.8.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-changefeed</artifactId>
  <version>12.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.10.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.10.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.8.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.8.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.7.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.4.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.1.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.5.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.11.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.9</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.8</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>microsoft-azure-batch</artifactId>
  <version>9.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-confluent</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.12.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.4.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-healthbot</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-opentelemetry-exporter-azuremonitor</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-keyvault-certificates</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-identity-spring</artifactId>
  <version>1.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-active-directory-b2c</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-active-directory</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-cosmos</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-servicebus-jms</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-storage</artifactId>
  <version>3.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-autoconfigure</artifactId>
  <version>2.1.0</version>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-context</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-messaging</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-core</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-servicebus</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-storage</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-storage-queue</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-test</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-telemetry</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-core</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-eventhubs</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-servicebus</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-storage-queue</artifactId>
  <version>2.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-test</artifactId>
  <version>2.1.0</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Azure Storage Blob 12.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md#12100-2021-01-14)
- GA release

### Azure Storage Blob Batch 12.8.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-batch/CHANGELOG.md#1280-2021-01-14)
- GA release

### Azure Storage Blob Cryptography 12.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md#12100-2021-01-14)
- GA release

### Azure Storage Common 12.10.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-common/CHANGELOG.md#12100-2021-01-14)
- GA release

### Azure Storage File Datalake 12.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1240-2021-01-14)
- GA release
- Fixed bug where getFileClient and getSubDirectoryClient on DirectoryClient would throw IllegalArgumentException if either resource had special characters.

### Azure Storage File Share 12.8.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md#1280-2021-01-14)
- GA release

### Azure Storage Internal Avro 12.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-internal-avro/CHANGELOG.md#1202-2021-01-14)
- GA release

### Azure Storage Queue 12.8.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storage/azure-storage-queue/CHANGELOG.md#1280-2021-01-14)
- GA release

### Azure Core Http Netty 1.7.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-netty/CHANGELOG.md#171-2021-01-11)

#### Bug Fixes
- Fixed a bug where environment proxy configurations were not sanitizing the non-proxy host string into a valid `Pattern` format. [#18156](https://github.com/Azure/azure-sdk-for-java/issues/18156)

#### Dependency Updates
- Upgraded Netty from `4.1.53.Final` to `4.1.54.Final`.
- Upgraded `reactor-netty` from `0.9.13.RELEASE` to `0.9.15.RELEASE`.

### Azure Core Http Okhttp 1.4.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-http-okhttp/CHANGELOG.md#141-2021-01-11)

#### Bug Fixes
- Fixed a bug where environment proxy configurations were not sanitizing the non-proxy host string into a valid `Pattern` format. [#18156](https://github.com/Azure/azure-sdk-for-java/issues/18156)

### Azure Core Management 1.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-management/CHANGELOG.md#110-2021-01-11)

#### New Features
- Added `MICROSOFT_GRAPH` to `AzureEnvironment`.

#### Bug Fixes
- Fixed long-running operation, PUT method, response 201 and Location, succeeded without poll.

### Azure Cosmos 4.11.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#4110-2021-01-15)

#### New Features
- Added Beta API for Patch support.
- Updated reactor-core library version to `3.3.12.RELEASE`.
- Updated reactor-netty library version to `0.9.15.RELEASE`.
- Updated netty library version to `4.1.54.Final`.

#### Key Bug Fixes
- Fixed RntbdServiceEnpoint close issue.
- Improved the latency and throughput for writes when multiplexing.

### Azure Core Experimental 1.0.0-beta.9 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta9-2021-01-11)

#### Breaking Changes
- Moved `BinaryData` to `azure-core`.

### Microsoft Azure Batch 9.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/batch/microsoft-azure-batch/CHANGELOG.md#900-2021-01-08)

#### New Features
- Adds support for task slots
  - `JobOperations.getTaskSlotCounts()` returns task slot counts
  - `JobOperations.getTaskCountsResult()` returns a `TaskCountsResult` object containing both task and slot counts
- Adds property `requiredSlots` to `CloudTask`, allowing the user to specify how many slots on a node they should take up
- Exposes a `BatchClient` factory method

#### Breaking Changes
- Property `maxTasksPerNode` is replaced with `taskSlotsPerNode`, which allows nodes to consume a dynamic amount of slots for more fine-grained control over resource consumption
  - `CloudPool.maxTasksPerNode` &rarr; `CloudPool.taskSlotsPerNode`
  - `PoolAddParameter.maxTasksPerNode` &rarr; `PoolAddParameter.taskSlotsPerNode`
  - `PoolSpecification.maxTasksPerNode` &rarr; `PoolSpecification.taskSlotsPerNode`


### Azure Resourcemanager Confluent 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/confluent/azure-resourcemanager-confluent/CHANGELOG.md#100-beta1-2021-01-14)

- Azure Resource Manager Confluent client library for Java. This package contains Microsoft Azure SDK for Confluent Management SDK.  Package tag package-2020-03-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Core 1.12.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#1120-2021-01-11)

#### New Features
- Added `AzureSasCredential` and `AzureSasCredentialPolicy` to standardize the ability to add SAS tokens to HTTP requests.

#### Bug Fixes
- Fixed a bug where environment proxy configurations were not sanitizing the non-proxy host string into a valid `Pattern` format. [#18156](https://github.com/Azure/azure-sdk-for-java/issues/18156)

#### Dependency Updates
- Updated `reactor-core` from `3.3.11.RELEASE` to `3.3.12.RELEASE`.
- Updated `netty-tcnative-boringssl-static` from `2.0.34.Final` to `2.0.35.Final`.

### Azure Core Amqp 2.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#201-2021-01-11)

#### New Features
- Changed connections from sharing the global `Schedulers.single()` to having a `Scheduler.newSingle()` per connection to improve performance.

### Azure Messaging Eventhubs 5.4.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#540-2021-01-14)
#### New features
- Add `clientOptions` to `EventProcessorClientBuilder` to support setting user's application id used in user-agent
 property of the amqp connection.

#### Dependency Updates
- Update `azure-core` dependency to `1.12.0`.
- Update `azure-core-amqp` dependency to `2.0.1`.
- Update `azure-identity` dependency to `1.2.2`.

### Azure Resourcemanager Healthbot 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/healthbot/azure-resourcemanager-healthbot/CHANGELOG.md#100-beta1-2021-01-07)

- Azure Resource Manager Healthbot client library for Java. This package contains Microsoft Azure SDK for Healthbot Management SDK. Microsoft Healthcare Bot is a cloud platform that empowers developers in Healthcare organizations to build and deploy their compliant, AI-powered virtual health assistants and health bots, that help them improve processes and reduce costs. Package tag package-2020-12-08. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Opentelemetry Exporter Azuremonitor 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-opentelemetry-exporter-azuremonitor_1.0.0-beta.2/sdk/monitor/azure-opentelemetry-exporter-azuremonitor/CHANGELOG.md#100-beta2-2021-01-12)
#### Breaking changes
- Renamed artifact to `azure-opentelemetry-exporter-azuremonitor`.
- Replaced `instrumentationKey()` with `connectionString()` in the `AzureMonitorExporterBuilder`.

### Azure Service Bus 7.0.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#701-2021-01-15)
- Improve performance because by upgrading azure-core-amqp dependency to 2.0.1.

### Java Keyvault JCA 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-jca/CHANGELOG.md#100-beta3-2021-01-20)

####Key Bug Fixes
- Fix NullPointerException in KeyVaultKeyManagerFactory.

####New Features
- Support properties named in hyphens style, like "azure.keyvault.tenant-id".

### Java Spring Boot KeyVault Certificates Starter 3.0.0-beta.3
- Beta release

### Azure Identity Spring 1.1.0
- GA release

### Java Spring Boot 3.1.0
- GA release

### Java Spring Boot AAD B2C Starter 3.1.0md#310-2021-01-20)

#### Breaking Changes
- Exposed userNameAttributeName to configure the user's name.

### Java Spring Boot AAD Starter 3.1.0
- GA release

### Java Spring Boot Cosmos db Starter 3.1.0
- GA release

### Java Spring Boot KeyVault Secrets Starter 3.1.0
- GA release

### Java Spring Boot ServiceBus Jms Starter 3.1.0
- GA release

### Java Spring Boot Starter 3.1.0

#### Breaking Changes
- Exposed userNameAttributeName to configure the user's name.

### Java Spring Boot Storage Starter 3.1.0
- GA release

### Java Spring Cloud Autoconfigure 2.1.0
- GA release

### Java Spring Cloud Context 2.1.0
- GA release

### Java Spring Cloud Event Hub Binder 2.1.0
- GA release

### Java Spring Cloud Messaging 2.1.0
- GA release

### Java Spring Cloud Service Bus Queue Stream Binder 2.1.0
- GA release

### Java Spring Cloud Service Bus Stream Binder Core 2.1.0
- GA release

### Java Spring Cloud Service Bus Topic Stream Binder 2.1.0
- GA release

### Java Spring Cloud Starter Cache 2.1.0
- GA release

### Java Spring Cloud Starter Event Hub Kafka 2.1.0
- GA release

### Java Spring Cloud Starter Event Hubs 2.1.0
- GA release

### Java Spring Cloud Starter Service Bus 2.1.0
- GA release

### Java Spring Cloud Storage 2.1.0
- GA release

### Java Spring Cloud Storage Queue Starter 2.1.0
- GA release

### Java Spring Cloud Stream Binder Test 2.1.0
- GA release

### Java Spring Integration Core 2.1.0
- GA release

### Java Spring Integration Event Hubs 2.1.0
- GA release

### Java Spring Integration Service Bus 2.1.0
- GA release

### Java Spring Integration Storage Queue 2.1.0
- GA release

### Java Spring Integration Test 2.1.0
- GA release

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
