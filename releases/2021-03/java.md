---
title: Azure SDK for Java (March 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA

- Azure Core
- Azure Core HTTP Nettty
- Azure Core HTTP OkHttp
- Azure Core Serializer Json Gson
- Azure Core Serializer Json Jackson
- Azure Core Test
- Azure Cosmos
- Azure Spring Data Cosmos
- Azure Search Documents
- Azure Messaging Event Hubs
- Azure Messaging Event Grid
- Azure Messaging Service Bus
- Azure Spring Boot
- Azure Spring Cloud
- Resource Management - Core
- Resource Management - Resources
- Resource Management - Event Hubs
- Resource Management - Redis
- Resource Management - Container Service
- Resource Management - Network
- Resource Management - DNS
- Resource Management - Virtual Machines
- Resource Management - Cognitive Search
- Resource Management - Cosmos DB
- Resource Management - Storage
- Resource Management - Managed Service Identity
- Resource Management - Container Instances
- Resource Management - Spring Cloud
- Resource Management - Authorization
- Resource Management - Key Vault
- Resource Management - App Service
- Resource Management - Content Delivery Network
- Resource Management - Private DNS
- Resource Management - Container Registry
- Resource Management - Monitor
- Resource Management - Traffic Manager
- Resource Management - Service Bus
- Resource Management - SQL

#### Updates
- Azure AI Text Analytics
- Azure AI Form Recognizer
- Azure Core AMQP
- Azure Data Appconfiguration
- Azure Event Hubs Checkpoint Store for Storage Blob
- Azure Identity
- Azure Security Key Vault Certificates
- Azure Security Key Vault Keys
- Azure Security Key Vault Secrets
- Digital Twins - Core
- SDK - Bill of Materials

#### Beta

- Azure AI Form Recognizer
- Azure AI Text Analytics
- Azure Analytics Synapse Artifacts
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS
- Azure Core Experimental
- Azure Core Serializer Avro Apache
- Azure Core Tracing Opentelemetry
- Azure Data Tables
- Azure Identity
- Azure Monitor Opentelemetry Exporter
- Azure Security Key Vault Administration
- Azure Security Key Vault Certificates
- Azure Security Key Vault JCA
- Azure Security Key Vault Keys
- Azure Security Key Vault Secrets
- Resource Management - Event Grid
- Resource Management - IoT Hub
- Resource Management - Storage Cache
- Resource Management - Media Services
- Resource Management - Hybrid Kubernetes
- Resource Management - Digital Twins
- Resource Management - NetApp Files
- Resource Management - Redis Enterprise
- Resource Management - Datadog

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.14.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.13.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-spring-data-cosmos</artifactId>
  <version>3.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.6.0</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-messaging-eventgrid</artifactId>
    <version>4.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.1.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-digitaltwins-core</artifactId>
  <version>1.0.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-sdk-bom</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.10</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.5.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.2.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.1.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.2.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.2.6</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerservice</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-network</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-dns</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-compute</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-search</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cosmos</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-storage</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-msi</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-authorization</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-keyvault</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-storagecache</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-mediaservices</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventgrid</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-artifacts</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.8</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.8</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-datadog</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-iot-deviceupdate</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-digitaltwins</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-phonenumbers</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.11</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-redisenterprise</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-hybridkubernetes</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.3.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-iothub</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.2.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.3.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-monitor-opentelemetry-exporter</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-resourcemanager-netapp</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.1.0-beta.5</version>
</dependency>
```

To use **Azure Spring Boot** starters, refer to the Maven dependency information below, which may be copied into your projects Maven pom.xml file as appropriate.
```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-bom</artifactId>
      <version>3.3.0</version>
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

To use **Azure Spring Cloud** starters and binders, refer to the Maven dependency information below, which may be copied into your projects Maven pom.xml file as appropriate.

```xml
<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.3.0</version>
</dependency>

 <dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-storage-queue</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.3.0</version>
</dependency>
```

To use JCA Provider for Azure Key Vault, refer to the Maven dependency information below, which may be copied into your projects Maven pom.xml file as appropriate.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>
```

[pattern]: # (<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>`n)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights


### Azure Core 1.14.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core/CHANGELOG.md#1140-2021-03-08)

#### New Features
- Added `Class<T>` overloads of `BinaryData.toObject` and `BinaryData.toObjectAsync`.
- Added defaulted interface API `Tracer.addEvent`.
- Added `FluxUtil.collectBytesInByteBufferStream(Flux, int)` and `FluxUtil.collectBytesFromNetworkResponse(Flux, HttpHeaders)`
  to allow for performance optimizations when the resulting `byte[]` size in known.
- Added handling to collect a `Flux<ByteBuffer>` into a `byte[]` with less array duplications.
- Added default interface API overloads to `ObjectSerializer` which take or return `byte[]` instead of `InputStream` or
  `OutputStream` allowing for performance optimizations by removing array copies.
- Added default interface API `SerializerAdapter.serializeIterable` which handles serializing generic collections.
- Added `CloudEvent` model which conforms to the [Cloud Event Specification](https://github.com/cloudevents/spec/blob/v1.0.1/spec.md).

### Azure Messaging Servicebus 7.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#710-2021-03-10)
#### Bug Fixes
- Continue to receive messages regardless of user not settling the received message in PEEK_LOCK mode [#19247](https://github.com/Azure/azure-sdk-for-java/issues/19247).
- Update to end the trace span regardless of the scope instance type for process operation tracing spans.
- Removed logs that leaked secrets when connection string is invalid. [#19249](https://github.com/Azure/azure-sdk-for-java/issues/19249)

### Azure Event Grid 4.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventgrid/azure-messaging-eventgrid/CHANGELOG.md#400-2020-03-11)

### New Features
- added `sendEvent` to `EventGridPublisherClient` and `EventGridPublisherAsyncClient` to send a single event.

### Azure Core Management 1.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-management/CHANGELOG.md#120-2021-03-08)

#### New Features
- Added `SystemData`.

### Azure Cosmos 4.13.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/cosmos/azure-cosmos/CHANGELOG.md#4130-2021-03-11)

#### New Features
* Added `Diagnostics` for queries.
* Throughput Control (Client side RU Limiting) Beta feature.
* Added Beta API for `FeedRange` based query.
* Added Beta API for `Conditional Patch`.
* Added `FeedRange` Beta API to `CosmosQueryRequestOptions`.

#### Key Bug Fixes
* Fixed `OrderBy` for mixed and undefined types for cross partition queries.
* Fixed `readAllItems` with resourceToken.
* Fixed issue with `resourceToken` usage in `Gateway` connection mode.
* Fixed issues with point operations with permissions in `Gateway` connection mode.

### Azure Spring Data Cosmos 3.5.0

#### New Features
* Added support for `org.springframework.data.domain.Persistable` entity type.
* Added support to log SQL Queries.
* Added support for `Pageable` and `Sort` for `@query` annotated queries.

#### Key Bug Fixes
* Fixed issue when using automatic id generation with the auditable framework.
* Fixed query deserialization issue with `@query` annotated queries.

### Azure Messaging Eventhubs 5.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#560-2021-03-10)
#### Bug Fixes
- Update to end the trace span regardless of the scope instance type for process operation tracing spans.

### Azure Core Amqp 2.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-amqp/CHANGELOG.md#203-2021-03-09)

#### Bug Fixes
- Fixed a bug where using a proxy the SSL peer hostname was set incorrect.
- Removed logs that leaked secrets. [#19249](https://github.com/Azure/azure-sdk-for-java/issues/19249)

### Resource Management - Resources 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resources_2.2.0/sdk/resourcemanager/azure-resourcemanager-resources/CHANGELOG.md#220-2021-02-24)
- Supported locks with API version `2016-09-01`. Added `ManagementLock` and related classes.

### Resource Management - Event Hubs 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventhubs_2.2.0/sdk/resourcemanager/azure-resourcemanager-eventhubs/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Redis 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redis_2.2.0/sdk/resourcemanager/azure-resourcemanager-redis/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-06-01`

### Resource Management - Container Service 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerservice_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerservice/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-11-01`
- Removed `withNodeImageVersion` method in `ManagedClusterAgentPoolProfileProperties`
- Removed unused class `Components1Q1Og48SchemasManagedclusterAllof1`
- Removed unused class `ComponentsQit0EtSchemasManagedclusterpropertiesPropertiesIdentityprofileAdditionalproperties`, it is same as its superclass `UserAssignedIdentity`

### Resource Management - Network 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-network_2.2.0/sdk/resourcemanager/azure-resourcemanager-network/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-08-01`
- Removed field `GCM_AES_128` and `GCM_AES_256` from class `ExpressRouteLinkMacSecCipher`

### Resource Management - Virtual Machines 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-compute_2.2.0/sdk/resourcemanager/azure-resourcemanager-compute/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-12-01`
- Supported force deletion on virtual machines and virtual machine scale sets
- Removed container service as it is deprecated in compute, please use `KubernetesCluster` from `azure-resourcemanager-containerservice`

### Resource Management - Cognitive Search 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-search_2.2.0/sdk/resourcemanager/azure-resourcemanager-search/CHANGELOG.md#220-2021-02-24)
- Migrated from previous sdk and updated `api-version` to `2020-08-01`.

### Resource Management - Cosmos DB 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cosmos_2.2.0/sdk/resourcemanager/azure-resourcemanager-cosmos/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-09-01`
- Deprecated `ipRangeFilter` and `withIpRangeFilter`, replaced by `ipRules` and `withIpRules`

### Resource Management 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager_2.2.0/sdk/resourcemanager/azure-resourcemanager/CHANGELOG.md#220-2021-02-24)
- Improved performance of `PagedIterable`

### Resource Management - Storage 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storage_2.2.0/sdk/resourcemanager/azure-resourcemanager-storage/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2021-01-01`
- Return type of `Identity.type()` changed from `String` to `IdentityType`

### Resource Management - Managed Service Identity 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-msi_2.2.0/sdk/resourcemanager/azure-resourcemanager-msi/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Authorization 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-authorization_2.2.0/sdk/resourcemanager/azure-resourcemanager-authorization/CHANGELOG.md#220-2021-02-24)
- Supported `listByServicePrincipal` in `RoleAssignments`
- Updated API from `AAD Graph` to `Microsoft Graph`. New permission needs to be granted before calling the API, [Reference](https://docs.microsoft.com/graph/permissions-reference)
- Removed `applicationPermissions` in `ActiveDirectoryApplication`
- Removed `signInName` in `ActiveDirectoryUser`
- Removed `withPasswordValue` in `PasswordCredential.Definition`
- Supported `withPasswordConsumer` in `PasswordCredential.Definition` to consume the password value.

### Resource Management - Content Delivery Network 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cdn_2.2.0/sdk/resourcemanager/azure-resourcemanager-cdn/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-09-01`
- Removed `UrlSigningActionParametersOdataType`
- Type of property `odataType` in `UrlSigningActionParameters` changed from `UrlSigningActionParametersOdataType` to `String`
- Type of property `keyId` in `UrlSigningActionParameters` removed

### Resource Management - Private DNS 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-privatedns_2.2.0/sdk/resourcemanager/azure-resourcemanager-privatedns/CHANGELOG.md#220-2021-02-24)
- Improved performance on `PrivateDnsZone` update

### Azure Resourcemanager Storagecache 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/storagecache/azure-resourcemanager-storagecache/CHANGELOG.md#100-beta2-2021-03-08)

- Azure Resource Manager StorageCache client library for Java. This package contains Microsoft Azure SDK for StorageCache Management SDK. A Storage Cache provides scalable caching service for NAS clients, serving data from either NFSv3 or Blob at-rest storage (referred to as "Storage Targets"). These operations allow you to manage Caches. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change
* `models.ClfsTargetProperties`, `models.Nfs3TargetProperties` , `models.StorageTargetProperties` and `models.UnknownTargetProperties` were removed.

#### New Feature
* `models.Condition` and `models.BlobNfsTarget` were added.

### Azure Analytics Synapse Artifacts 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md#100-beta3-2021-03-09)

- Add new APIs in `LibraryClient` and `LibraryAsyncClient`

### Azure Data Tables 12.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/tables/azure-data-tables/CHANGELOG.md#1200-beta5-2021-03-10)

#### New Features
- Added support to specify whether or not a pipeline policy should be added per call or per retry.
- Added support for passing Azure Core's `ClientOptions` to client builders.

### Azure Resourcemanager Datadog 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/datadog/azure-resourcemanager-datadog/CHANGELOG.md#100-beta1-2021-03-08)

- Azure Resource Manager MicrosoftDatadog client library for Java. This package contains Microsoft Azure SDK for MicrosoftDatadog Management SDK.  Package tag package-2020-02-preview. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure IoT DeviceUpdate 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/deviceupdate/azure-iot-deviceupdate/CHANGELOG.md#100-beta1-2021-03-02)
This is the initial release of Azure Device Update for IoT Hub library.

### Azure Resourcemanager Digitaltwins 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/digitaltwins/azure-resourcemanager-digitaltwins/CHANGELOG.md#100-beta1-2021-03-02)

- Azure Resource Manager AzureDigitalTwins client library for Java. This package contains Microsoft Azure SDK for AzureDigitalTwins Management SDK. Azure Digital Twins Client for managing DigitalTwinsInstance. Package tag package-2020-12. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta5-2021-03-02)

#### Breaking Changes
- ChatMessage - `senderId` renamed to `senderCommunicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatMessageReadReceipt - `senderId` renamed to `senderCommunicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatParticipant - `user` renamed to `communicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatThread - `createdBy` renamed to `createdByCommunicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatMessageContent - `initiator` renamed to `initiatorCommunicationIdentifier`, changed type to `CommunicationIdentifier`.

### Azure Communication Common 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta6-2021-03-09)

#### Breaking Changes
- Renamed `CommunicationTokenRefreshOptions.getRefreshProactively()` to `CommunicationTokenRefreshOptions.isRefreshProactively()`
- Constructor for `CommunicationCloudEnvironment` has been removed and now to set an environment value, the `fromString()` method must be called
- `CommunicationCloudEnvironment`, `CommunicationTokenRefreshOptions `, `CommunicationUserIdentifier`, `MicrosoftTeamsUserIdentifier`,
`PhoneNumberIdentifier`, `UnknownIdentifier`, are all final classes now.

### Azure Communication Identity 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta6-2021-03-09)

#### Added
- Added a retryPolicy() chain method to the `CommunicationIdentityClientBuilder`.

#### Breaking
- `CommunicationIdentityClient.createUserWithToken` and `CommunicationIdentityAsyncClient.createUserWithToken` have been renamed to
`CommunicationIdentityClient.createUserAndToken` and `CommunicationIdentityAsyncClient.createUserAndToken`.
- `CommunicationIdentityClient.createUserWithTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserWithTokenWithResponse` have been renamed to
`CommunicationIdentityClient.createUserAndTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserAndTokenWithResponse`.
- `CommunicationUserIdentifierWithTokenResult` class has been renamed to `CommunicationUserIdentifierAndToken`.

### Azure Communication Phonenumbers 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100-beta6-2021-03-09)

#### Added
- Added PhoneNumbersClient and PhoneNumbersAsyncClient (originally was part of the azure.communication.administration package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes
- PhoneNumberAsyncClient has been replaced with PhoneNumbersAsyncClient, which has the same functionality but different APIs. To learn more about how PhoneNumbersAsyncClient works, refer to the [README.md][https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-phonenumbers/README.md].
- PhoneNumberClient has been replaced with PhoneNumbersClient, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md][https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-phonenumbers/README.md].

### Azure Communication Sms 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta4-2021-03-09)

#### Added
- Added Azure Active Directory authentication support
- Support for creating SmsClient with TokenCredential.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- Send method series in SmsClient are idempotent under retry policy.
- Added `SmsOptions`

#### Breaking Change
- Updated `public Mono<SendSmsResponse> sendMessage(PhoneNumberIdentifier from, PhoneNumberIdentifier to, String message)` to `public Mono<SendSmsResponse> send(String from, String to, String message)`.
- Updated `public Mono<Response<SendSmsResponse>> sendMessageWithResponse(PhoneNumberIdentifier from,List<PhoneNumberIdentifier> to, String message, SendSmsOptions smsOptions, Context context)` to `Mono<Response<SmsSendResult>> sendWithResponse(String from, String to, String message, SmsSendOptions options, Context context)`.
- Replaced `SendSmsResponse` with `SmsSendResult`.

### Azure Core Experimental 1.0.0-beta.11 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta11-2021-03-08)

#### New Features
- Added `ARMChallengeAuthenticationPolicy` as an implementation of `BearerTokenAuthenticationChallengePolicy`.

#### Breaking Changes
- Modified implementations of `onBeforeRequest` and `onChallenge` in `BearerTokenAuthenticationChallengePolicy`.

### Azure Resourcemanager Redisenterprise 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/redisenterprise/azure-resourcemanager-redisenterprise/CHANGELOG.md#100-beta2-2021-03-02)

- Azure Resource Manager RedisEnterprise client library for Java. This package contains Microsoft Azure SDK for RedisEnterprise Management SDK. REST API for managing Redis Enterprise resources in Azure. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Resourcemanager Hybridkubernetes 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/hybridkubernetes/azure-resourcemanager-hybridkubernetes/CHANGELOG.md#100-beta1-2021-03-01)

- Azure Resource Manager HybridKubernetes client library for Java. This package contains Microsoft Azure SDK for HybridKubernetes Management SDK. Hybrid Kubernetes Client. Package tag package-2021-03-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Identity 1.3.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/identity/azure-identity/CHANGELOG.md#130-beta2-2021-03-10)

#### New Features
- Added the support to enable and configure Persistent Token Cache via `TokenCachePersistenceOptions` API on `InteractiveBrowserCredentialBuilder`, `AuthorizationCodeCredentialBuilder`, `UsernamePasswordCredentialBuilder`, `DeviceCodeCredentialBuilderBuilder` `ClientSecretCredentialBuilder`, `ClientCertificateCredentialBuilder` and `SharedTokenCacheCredentialBuilder`.
- Added new APIs for authenticating users with `DeviceCodeCredential`,  `InteractiveBrowserCredential` and `UsernamePasswordCredential`.
    - Added method `authenticate` which pro-actively interacts with the user to authenticate if necessary and returns a serializable `AuthenticationRecord`
- Added following configurable options in classes `DeviceCodeCredentialBuilder` and `InteractiveBrowserCredentialBuilder`
    - `authenticationRecord` enables initializing a credential with an `AuthenticationRecord` returned from a prior call to `Authenticate`
    - `disableAutomaticAuthentication` disables automatic user interaction causing the credential to throw an `AuthenticationRequiredException` when interactive authentication is necessary.

### Azure Resourcemanager IoT Hub 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/iothub/azure-resourcemanager-iothub/CHANGELOG.md#100-beta1-2021-03-02)

- Azure Resource Manager IoT Hub client library for Java. This package contains Microsoft Azure SDK for IoT Hub Management SDK. Use this API to manage the IoT hubs in your Azure subscription. Package tag package-2020-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Security Keyvault Administration 4.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta5-2021-03-12)

#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

### Azure Security Keyvault Certificates 4.2.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta4-2021-03-12)

#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

### Azure Security Keyvault Keys 4.3.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta5-2021-03-12)

#### Breaking Changes
- Removed local support for encryption and decryption using AESGCM, as per guidance of Microsoft's cryptography board. Remote encryption and decryption using said algorithm is still supported.

#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

#### Bug fixes
- Fixed issue that caused a `NullPointerException` when attempting to use a `CryptographyClient` for symmetric key encryption operations after the first one.
- Fixed issue where `JsonWebKey` byte array contents would get serialized/deserialized using Base64 instead of URL-safe Base64.
- Fixed issue where properties of responses received when using a `CryptographyClient` for encryption/decryption were not populated on the `EncryptResult` and `DecryptResult` classes.

### Azure Security Keyvault Secrets 4.3.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#430-beta4-2021-03-12)

#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

### Azure Monitor Opentelemetry Exporter 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/monitor/azure-monitor-opentelemetry-exporter/CHANGELOG.md#100-beta4-2021-03-10)

#### New Features
- `AzureMonitorExporterBuilder` now supports reading connection string from `APPLICATIONINSIGHTS_CONNECTION_STRING
` environment variable.

### Azure Resourcemanager Netapp 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/netapp/azure-resourcemanager-netapp/CHANGELOG.md#100-beta2-2021-03-15)

- Azure Resource Manager NetAppFiles client library for Java. This package contains Microsoft Azure SDK for NetAppFiles Management SDK. Microsoft NetApp Files Azure Resource Provider specification. Package tag package-netapp-2020-12-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change
* `models.KeySource`, `models.CreatedByType` and `models.SystemData` were removed.

#### New Feature
* `models.BackupStatus` and `models.VolumeBackupStatus` were added.

### Azure Ai Textanalytics 5.1.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta5-2021-03-10)
- We are now targeting the service's v3.1-preview.4 API as the default instead of v3.1-preview.3.

#### New features
- Added a new property `categoriesFilter` to `RecognizePiiEntitiesOptions`. The PII entity recognition endpoint will return
  the result with categories only match the given `categoriesFilter` list.
- Added `normalizedText` property to `HealthcareEntity`.
- `AnalyzeHealthcareEntitiesResult` now exposes the property `entityRelations`, which is a list of `HealthcareEntityRelation`.
- Added `HealthcareEntityRelation` class which will determine all the different relations between the entities as `Roles`.
- Added `HealthcareEntityRelationRole`, which exposes `name` and `entity` of type `String` and `HealthcareEntity` respectively.
- `beginAnalyzeBatchActions` can now process recognize linked entities actions.
- `recognizePiiEntities` takes a new option, `categoriesFilter`, that specifies a list of PII categories to return.
- Added new classes, `RecognizeLinkedEntitiesActionResult`, `PiiEntityCategory`.

#### Breaking changes
- Removed `PiiEntity` constructor and `PiiEntity`'s `category` property is no longer a type of `EntityCategory` but use a new introduced type `PiiEntityCategory`.
- Replace `isNegated` by `HealthcareEntityAssertion` to `HealthcareEntity` which further exposes `EntityAssociation`, `EntityCertainity` and `EntityConditionality`.
- Renamed classes,
  `AspectSentiment` to `TargetSentiment`, `OpinionSentiment` to `AssesssmentSentiment`, `MinedOpinion` to `SentenceOpinion`.
- Renamed
  `SentenceSentiment`'s method, `getMinedOpinions()` to `getOpinions()`.
  `MinedOpinion`'s methods, `getAspect()` to `getTarget()`, `getOpinions()` to `getAssessments()`.
- Removed property, `relatedEntities` from `HealthcareEntity`.
- Removed constructors,
  `SentenceSentiment(String text, TextSentiment sentiment, SentimentConfidenceScores confidenceScores, IterableStream<MinedOpinion> minedOpinions, int offset)`,
  `AspectSentiment(String text, TextSentiment sentiment, int offset, SentimentConfidenceScores confidenceScores)`,
  `OpinionSentiment(String text, TextSentiment sentiment, int offset, boolean isNegated, SentimentConfidenceScores confidenceScores)`

#### Known Issues
- `beginAnalyzeHealthcareEntities` is currently in gated preview and can not be used with AAD credentials.
  For more information, see [the Text Analytics for Health documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-for-health?tabs=ner#request-access-to-the-public-preview).

### Azure Spring Boot

#### New features
- Upgraded to Spring Boot [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgraded to Spring Security [5.4.5](https://github.com/spring-projects/spring-security/releases/tag/5.4.5).
- Upgraded to `azure-spring-data-cosmos`
- Supported creating `GrantedAuthority` by "roles" claim of id-token for web application in `azure-spring-boot-starter-active-directory`.

#### Bug fixes
- Fix bug of using closed `MessageProducer` and `MessageConsumer` when a link is force detached in `azure-spring-boot-starter-servicebus-jms`.

### Azure Spring Cloud

#### New features
- Upgraded to Spring Boot [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgraded to Spring Integration [5.4.4](https://github.com/spring-projects/spring-integration/releases/tag/v5.4.4).
- Tested with Spring Cloud [2020.0.1](https://spring.io/blog/2021/01/28/spring-cloud-2020-0-1-aka-ilford-is-available).
- Supported setting Service Bus message ID ([#200005](https://github.com/Azure/azure-sdk-for-java/issues/20005)).


## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
