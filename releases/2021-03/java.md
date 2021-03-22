---
title: Azure SDK for Java (March 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
azure-resourcemanager-eventgrid:1.0.0-beta.2
azure-resourcemanager-resources:2.2.0
azure-resourcemanager-eventhubs:2.2.0
azure-resourcemanager-redis:2.2.0
azure-mixedreality-remoterendering:1.0.0-beta.1
azure-resourcemanager-iothub:1.0.0-beta.1
azure-resourcemanager-containerservice:2.2.0
azure-resourcemanager-storagecache:1.0.0-beta.1
azure-resourcemanager-network:2.2.0
azure-digitaltwins-core:1.0.3
azure-resourcemanager-dns:2.2.0
azure-resourcemanager-compute:2.2.0
azure-resourcemanager-search:2.2.0
azure-resourcemanager-cosmos:2.2.0
azure-resourcemanager-mediaservices:1.0.0-beta.2
azure-resourcemanager:2.2.0
azure-resourcemanager-storage:2.2.0
azure-resourcemanager-hybridkubernetes:1.0.0-beta.1
azure-resourcemanager-msi:2.2.0
azure-sdk-bom:1.0.2
azure-mixedreality-authentication:1.0.0-beta.1
azure-resourcemanager-containerinstance:2.2.0
azure-resourcemanager-appplatform:2.2.0
azure-resourcemanager-authorization:2.2.0
azure-resourcemanager-keyvault:2.2.0
azure-resourcemanager-appservice:2.2.0
azure-resourcemanager-cdn:2.2.0
azure-resourcemanager-privatedns:2.2.0
azure-resourcemanager-containerregistry:2.2.0
azure-resourcemanager-digitaltwins:1.0.0-beta.1
azure-resourcemanager-monitor:2.2.0
azure-mixedreality-authentication:1.0.0
azure-resourcemanager-trafficmanager:2.2.0
azure-resourcemanager-servicebus:2.2.0
azure-resourcemanager-netapp:1.0.0-beta.1
azure-resourcemanager-redisenterprise:1.0.0-beta.2
azure-resourcemanager-redisenterprise:1.0.0-beta.1
azure-resourcemanager-sql:2.2.0
azure-resourcemanager-datadog:1.0.0-beta.1
azure-resourcemanager-storagecache:1.0.0-beta.2
azure-ai-textanalytics:5.0.4
azure-analytics-synapse-artifacts:1.0.0-beta.3
azure-search-documents:11.3.0
azure-ai-textanalytics:5.1.0-beta.5
azure-spring-cloud-starter-eventhubs-kafka:2.2.0
azure-core-http-okhttp:1.6.0
azure-core-serializer-json-gson:1.1.0
azure-spring-boot-starter:3.2.0
azure-core-management:1.2.0
azure-spring-boot-starter-storage:3.2.0
azure-core-http-netty:1.9.0
azure-spring-cloud-messaging:2.2.0
azure-communication-common:1.0.0-beta.6
azure-spring-data-cosmos:3.5.0
azure-mixedreality-remoterendering:1.0.0
azure-spring-integration-storage-queue:2.2.0
azure-communication-sms:1.0.0-beta.4
azure-spring-cloud-autoconfigure:2.2.0
azure-spring-cloud-stream-binder-test:2.2.0
azure-core-serializer-json-jackson:1.2.0
azure-spring-cloud-starter-eventhubs:2.2.0
azure-core-experimental:1.0.0-beta.11
azure-communication-identity:1.0.0-beta.5
azure-identity:1.3.0-beta.2
azure-spring-boot-starter-keyvault-secrets:3.2.0
azure-core:1.14.0
azure-spring-cloud-telemetry:2.2.0
azure-data-appconfiguration:1.1.10
azure-cosmos:4.13.0
azure-communication-chat:1.0.0-beta.6
azure-messaging-servicebus:7.1.0
azure-security-keyvault-keys:4.3.0-beta.5
azure-spring-boot-starter-keyvault-certificates:3.0.0-beta.4
azure-spring-cloud-starter-storage-queue:2.2.0
azure-communication-phonenumbers:1.0.0-beta.6
azure-core-amqp:2.0.3
azure-communication-chat:1.0.0-beta.5
azure-core-tracing-opentelemetry:1.0.0-beta.8
azure-spring-cloud-starter-servicebus:2.2.0
azure-spring-cloud-stream-binder-servicebus-queue:2.2.0
azure-spring-cloud-stream-binder-servicebus-core:2.2.0
azure-spring-cloud-context:2.2.0
azure-security-keyvault-secrets:4.3.0-beta.4
azure-ai-formrecognizer:3.0.6
azure-security-keyvault-certificates:4.2.0-beta.4
azure-spring-integration-core:2.2.0
azure-core-test:1.6.0
azure-security-keyvault-jca:1.0.0-beta.4
azure-core-serializer-avro-apache:1.0.0-beta.8
azure-spring-cloud-starter-cache:2.2.0
azure-spring-cloud-stream-binder-eventhubs:2.2.0
azure-resourcemanager-netapp:1.0.0-beta.2
azure-spring-integration-test:2.2.0
azure-security-keyvault-administration:4.0.0-beta.5
azure-messaging-eventhubs:5.6.0
azure-monitor-opentelemetry-exporter:1.0.0-beta.4
azure-spring-cloud-stream-binder-servicebus-topic:2.2.0
azure-spring-cloud-storage:2.2.0
azure-spring-boot-starter-active-directory:3.2.0
azure-iot-deviceupdate:1.0.0-beta.1
azure-spring-boot-starter-active-directory-b2c:3.2.0
azure-communication-identity:1.0.0-beta.6
azure-spring-boot-starter-cosmos:3.2.0
azure-messaging-eventhubs-checkpointstore-blob:1.5.1
azure-data-tables:12.0.0-beta.5
azure-communication-common:1.0.0-beta.5
azure-spring-boot-starter-servicebus-jms:3.2.0
azure-spring-boot:3.2.0
azure-spring-integration-eventhubs:2.2.0
azure-spring-integration-servicebus:2.2.0
azure-identity-spring:1.2.0
azure-storage-file-datalake:12.4.1
azure-storage-common:12.10.1
azure-storage-blob:12.10.1

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA
- Resource Management - Resources
- Resource Management - Event Hubs
- Resource Management - Redis
- Resource Management - Container Service
- Resource Management - Network
- Resource Management - DNS
- Resource Management - Virtual Machines
- Resource Management - Cognitive Search
- Resource Management - Cosmos DB
- Resource Management
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
- Azure Mixed Reality Authentication
- Resource Management - Traffic Manager
- Resource Management - Service Bus
- Resource Management - SQL
- Cognitive Search
- Azure Spring Cloud Starter Event Hubs Kafka
- Core - HTTP OkHttp
- Core Serializer GSON JSON
- Azure Spring Boot Starter
- Management - Core
- Azure Spring Boot Starter Storage
- Core - HTTP Netty
- Azure Spring Cloud Messaging
- Spring Data Cosmos
- Azure Remote Rendering
- Azure Spring Cloud Integration Storage Queue
- Azure Spring Cloud Autoconfigure
- Azure Spring Cloud Stream Binder Test
- Core Serializer Jackson JSON
- Azure Spring Cloud Starter Event Hubs
- Azure Spring Boot Starter Key Vault Secrets
- Core
- Azure Spring Cloud Telemetry
- Cosmos DB
- Service Bus
- Azure Spring Cloud Starter Storage Queue
- Azure Spring Cloud Starter Service bus
- Azure Spring Cloud Stream Binder Service bus Queue
- Azure Spring Cloud Stream Binder Service bus Core
- Azure Spring Cloud Context
- Azure Spring Cloud Integration Core
- Core - Test
- Azure Spring Cloud Starter Cache
- Azure Spring Cloud Stream Binder Event Hubs
- Azure Spring Cloud Integration Test
- Event Hubs
- Azure Spring Cloud Stream Binder Service bus Topic
- Azure Spring Cloud Storage
- Azure Spring Boot Starter Active Directory
- Azure Spring Boot Starter Active Directory B2C
- Azure Spring Boot Starter Cosmos
- Azure Spring Boot Starter Service bus Jms
- Azure Spring Boot AutoConfigure
- Azure Spring Cloud Integration Event Hubs
- Azure Spring Cloud Integration Service Bus
- Azure Identity Spring

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Digital Twins - Core
- SDK - Bill of Materials
- Text Analytics
- App Configuration
- Core - AMQP
- Form Recognizer
- Event Hubs - Azure Blob Storage Checkpoint Store
- Storage - Files Data Lake
- Storage - Common
- Storage - Blobs

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Resource Management - Event Grid
- Azure Remote Rendering
- azure-resourcemanager-iothub
- Resource Management - Storage Cache
- Resource Management - Media Services
- azure-resourcemanager-hybridkubernetes
- Azure Mixed Reality Authentication
- azure-resourcemanager-digitaltwins
- Resource Management - NetApp Files
- Resource Management - Redis Enterprise
- Resource Management - Redis Enterprise
- azure-resourcemanager-datadog
- Resource Management - Storage Cache
- Synapse - Artifacts
- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS
- Text Analytics
- Communication Common
- Communication Sms
- Core Experimental
- Communication Identity
- Identity
- Communication Chat
- Key Vault - Keys
- Azure Spring Boot Starter Key Vault Certificates
- azure-communication-phonenumbers
- Communication Chat
- Tracing OpenTelemetry Plugin
- Key Vault - Secrets
- Key Vault - Certificates
- Key Vault - JCA
- Core Serializer Apache Avro
- Resource Management - NetApp Files
- Key Vault - Administration
- Monitor Exporter for OpenTelemetry
- azure-iot-deviceupdate
- Communication Identity
- Tables
- Communication Common

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventgrid</artifactId>
  <version>1.0.0-beta.2</version>
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
  <groupId>com.azure</groupId>
  <artifactId>azure-mixedreality-remoterendering</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-iothub</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerservice</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-storagecache</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-network</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-digitaltwins-core</artifactId>
  <version>1.0.3</version>
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
  <artifactId>azure-resourcemanager-mediaservices</artifactId>
  <version>1.0.0-beta.2</version>
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
  <artifactId>azure-resourcemanager-hybridkubernetes</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-msi</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-sdk-bom</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-mixedreality-authentication</artifactId>
  <version>1.0.0-beta.1</version>
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
  <artifactId>azure-resourcemanager-digitaltwins</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-mixedreality-authentication</artifactId>
  <version>1.0.0</version>
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
  <artifactId>azure-resourcemanager-netapp</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redisenterprise</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redisenterprise</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-datadog</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-storagecache</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-artifacts</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.6</version>
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
  <artifactId>azure-search-documents</artifactId>
  <version>11.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.1.0-beta.5</version>
</dependency>
<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.6.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.1.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-storage</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.9.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-messaging</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-data-cosmos</artifactId>
  <version>3.5.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-mixedreality-remoterendering</artifactId>
  <version>1.0.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-integration-storage-queue</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-autoconfigure</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-stream-binder-test</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.11</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-identity</artifactId>
  <version>1.3.0-beta.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core</artifactId>
  <version>1.14.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-telemetry</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.10</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.13.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-messaging-servicebus</artifactId>
  <version>7.1.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.5</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-keyvault-certificates</artifactId>
  <version>3.0.0-beta.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-starter-storage-queue</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-phonenumbers</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.3</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.8</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-starter-servicebus</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-core</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-context</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.3.0-beta.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.6</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.2.0-beta.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-integration-core</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.6.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.8</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-resourcemanager-netapp</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-integration-test</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.5</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-messaging-eventhubs</artifactId>
  <version>5.6.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-monitor-opentelemetry-exporter</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-cloud-storage</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-active-directory</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-iot-deviceupdate</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-active-directory-b2c</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-cosmos</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-messaging-eventhubs-checkpointstore-blob</artifactId>
  <version>1.5.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.5</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot-starter-servicebus-jms</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-boot</artifactId>
  <version>3.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-integration-eventhubs</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-spring-integration-servicebus</artifactId>
  <version>2.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-identity-spring</artifactId>
  <version>1.2.0</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.4.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.10.1</version>
</dependency>


<dependency>
  <groupId></groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.10.1</version>
</dependency>



```

[pattern]: # (<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>`n`n)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights
### Resource Management - Event Grid 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventgrid_1.0.0-beta.2/sdk/eventgrid/azure-resourcemanager-eventgrid/CHANGELOG.md#100-beta2-2021-02-22)
- Azure Resource Manager EventGrid client library for Java. This package contains Microsoft Azure SDK for EventGrid Management SDK. Azure EventGrid Management Client. Package tag package-2020-10-preview. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

##### `models.Topics` was modified

* `regenerateKeyWithResponse(java.lang.String,java.lang.String,models.TopicRegenerateKeyRequest,com.azure.core.util.Context)` was removed

#### New Feature

* `models.ExtensionTopic` was added

* `models.CreatedByType` was added

* `models.PartnerNamespaces` was added

* `models.SystemTopic` was added

* `models.StringNotBeginsWithAdvancedFilter` was added

* `models.EventSubscriptionIdentity` was added

* `models.PartnerNamespaceSharedAccessKeys` was added

* `models.PartnerTopicTypeAuthorizationState` was added

* `models.EventChannel` was added

* `models.Sku` was added

* `models.PartnerNamespace` was added

* `models.NumberInRangeAdvancedFilter` was added

* `models.DeadLetterWithResourceIdentity` was added

* `models.IsNotNullAdvancedFilter` was added

* `models.PartnerRegistration$UpdateStages` was added

* `models.PartnerRegistration$Update` was added

* `models.EventChannel$Definition` was added

* `models.UserIdentityProperties` was added

* `models.SystemTopic$Definition` was added

* `models.EventChannels` was added

* `models.EventChannelDestination` was added

* `models.IsNullOrUndefinedAdvancedFilter` was added

* `models.PartnerTopicUpdateParameters` was added

* `models.ResourceSku` was added

* `models.ResourceKind` was added

* `models.PartnerRegistration$DefinitionStages` was added

* `models.EventChannelProvisioningState` was added

* `models.NumberNotInRangeAdvancedFilter` was added

* `models.PartnerTopicEventSubscriptions` was added

* `models.SystemData` was added

* `models.PartnerNamespace$Update` was added

* `models.EventChannel$DefinitionStages` was added

* `models.IdentityInfo` was added

* `models.EventChannelSource` was added

* `models.PartnerTopicReadinessState` was added

* `models.PartnerNamespacesListResult` was added

* `models.SystemTopic$UpdateStages` was added

* `models.DeliveryAttributeListResult` was added

* `models.DeliveryAttributeMapping` was added

* `models.PartnerRegistration$Definition` was added

* `models.StringNotEndsWithAdvancedFilter` was added

* `models.EventChannel$Update` was added

* `models.PartnerTopicActivationState` was added

* `models.SystemTopicUpdateParameters` was added

* `models.PartnerRegistrationProvisioningState` was added

* `models.DeliveryAttributeMappingType` was added

* `models.PartnerTopicType` was added

* `models.PartnerNamespaceUpdateParameters` was added

* `models.IdentityType` was added

* `models.StaticDeliveryAttributeMapping` was added

* `models.PartnerTopics` was added

* `models.DeliveryWithResourceIdentity` was added

* `models.TopicTypePropertiesSupportedScopesForSourceItem` was added

* `models.PartnerRegistrationsListResult` was added

* `models.PartnerRegistrationUpdateParameters` was added

* `models.DynamicDeliveryAttributeMapping` was added

* `models.ExtensionTopics` was added

* `models.EventChannelsListResult` was added

* `models.PartnerRegistration` was added

* `models.SystemTopicsListResult` was added

* `models.PartnerRegistrationVisibilityState` was added

* `models.EventSubscriptionIdentityType` was added

* `models.PartnerNamespace$DefinitionStages` was added

* `models.StringNotContainsAdvancedFilter` was added

* `models.SystemTopic$Update` was added

* `models.EventChannelFilter` was added

* `models.SystemTopic$DefinitionStages` was added

* `models.PartnerNamespaceProvisioningState` was added

* `models.PartnerTopicProvisioningState` was added

* `models.PartnerTopicsListResult` was added

* `models.EventChannel$UpdateStages` was added

* `models.PartnerTopic` was added

* `models.SystemTopics` was added

* `models.ExtendedLocation` was added

* `models.PartnerNamespace$Definition` was added

* `models.PartnerRegistrations` was added

* `models.PartnerNamespaceRegenerateKeyRequest` was added

* `models.PartnerNamespace$UpdateStages` was added

* `models.SystemTopicEventSubscriptions` was added

##### `models.Topics` was modified

* `regenerateKey(java.lang.String,java.lang.String,models.TopicRegenerateKeyRequest,com.azure.core.util.Context)` was added

##### `models.Topic` was modified

* `regenerateKey(models.TopicRegenerateKeyRequest,com.azure.core.util.Context)` was added
* `listSharedAccessKeys()` was added
* `sku()` was added
* `listSharedAccessKeysWithResponse(com.azure.core.util.Context)` was added
* `regenerateKey(models.TopicRegenerateKeyRequest)` was added
* `identity()` was added
* `extendedLocation()` was added
* `kind()` was added

##### `models.EventSubscriptionFilter` was modified

* `enableAdvancedFilteringOnArrays()` was added
* `withEnableAdvancedFilteringOnArrays(java.lang.Boolean)` was added

##### `models.WebhookEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.StorageQueueEventSubscriptionDestination` was modified

* `queueMessageTimeToLiveInSeconds()` was added
* `withQueueMessageTimeToLiveInSeconds(java.lang.Long)` was added

##### `models.EventSubscription$Definition` was modified

* `withDeliveryWithResourceIdentity(models.DeliveryWithResourceIdentity)` was added
* `withDeadLetterWithResourceIdentity(models.DeadLetterWithResourceIdentity)` was added

##### `models.ServiceBusQueueEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.TopicUpdateParameters` was modified

* `identity()` was added
* `withSku(models.ResourceSku)` was added
* `sku()` was added
* `withIdentity(models.IdentityInfo)` was added

##### `models.Domain$Update` was modified

* `withIdentity(models.IdentityInfo)` was added
* `withSku(models.ResourceSku)` was added

##### `models.Topic$Definition` was modified

* `withSku(models.ResourceSku)` was added
* `withKind(models.ResourceKind)` was added
* `withExtendedLocation(models.ExtendedLocation)` was added
* `withIdentity(models.IdentityInfo)` was added

##### `models.ServiceBusTopicEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.DomainUpdateParameters` was modified

* `sku()` was added
* `withIdentity(models.IdentityInfo)` was added
* `withSku(models.ResourceSku)` was added
* `identity()` was added

##### `models.Topic$Update` was modified

* `withSku(models.ResourceSku)` was added
* `withIdentity(models.IdentityInfo)` was added

##### `models.EventSubscription` was modified

* `deadLetterWithResourceIdentity()` was added
* `getDeliveryAttributes()` was added
* `getFullUrl()` was added
* `getDeliveryAttributesWithResponse(com.azure.core.util.Context)` was added
* `deliveryWithResourceIdentity()` was added
* `getFullUrlWithResponse(com.azure.core.util.Context)` was added
* `systemData()` was added

##### `models.Domain` was modified

* `listSharedAccessKeysWithResponse(com.azure.core.util.Context)` was added
* `identity()` was added
* `regenerateKey(models.DomainRegenerateKeyRequest)` was added
* `listSharedAccessKeys()` was added
* `regenerateKeyWithResponse(models.DomainRegenerateKeyRequest,com.azure.core.util.Context)` was added
* `sku()` was added

##### `models.AzureFunctionEventSubscriptionDestination` was modified

* `deliveryAttributeMappings()` was added
* `withDeliveryAttributeMappings(java.util.List)` was added

##### `models.EventSubscription$Update` was modified

* `withDeadLetterWithResourceIdentity(models.DeadLetterWithResourceIdentity)` was added
* `withDeliveryWithResourceIdentity(models.DeliveryWithResourceIdentity)` was added

##### `models.HybridConnectionEventSubscriptionDestination` was modified

* `withDeliveryAttributeMappings(java.util.List)` was added
* `deliveryAttributeMappings()` was added

##### `models.TopicTypeInfo` was modified

* `supportedScopesForSource()` was added

##### `models.EventHubEventSubscriptionDestination` was modified

* `deliveryAttributeMappings()` was added
* `withDeliveryAttributeMappings(java.util.List)` was added

##### `models.EventSubscriptions` was modified

* `getDeliveryAttributes(java.lang.String,java.lang.String)` was added
* `getDeliveryAttributesWithResponse(java.lang.String,java.lang.String,com.azure.core.util.Context)` was added

##### `EventGridManager` was modified

* `partnerTopics()` was added
* `eventChannels()` was added
* `partnerRegistrations()` was added
* `partnerTopicEventSubscriptions()` was added
* `extensionTopics()` was added
* `systemTopics()` was added
* `systemTopicEventSubscriptions()` was added
* `partnerNamespaces()` was added

##### `models.Domain$Definition` was modified

* `withIdentity(models.IdentityInfo)` was added
* `withSku(models.ResourceSku)` was added

##### `models.EventSubscriptionUpdateParameters` was modified

* `withDeliveryWithResourceIdentity(models.DeliveryWithResourceIdentity)` was added
* `deadLetterWithResourceIdentity()` was added
* `withDeadLetterWithResourceIdentity(models.DeadLetterWithResourceIdentity)` was added
* `deliveryWithResourceIdentity()` was added

### Resource Management - Resources 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resources_2.2.0/sdk/resourcemanager/azure-resourcemanager-resources/CHANGELOG.md#220-2021-02-24)
- Supported locks with API version `2016-09-01`. Added `ManagementLock` and related classes.

### Resource Management - Event Hubs 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventhubs_2.2.0/sdk/resourcemanager/azure-resourcemanager-eventhubs/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Redis 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redis_2.2.0/sdk/resourcemanager/azure-resourcemanager-redis/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-06-01`

### Azure Remote Rendering 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-remoterendering_1.0.0-beta.1/sdk/remoterendering/azure-mixedreality-remoterendering/CHANGELOG.md#100-beta1-2021-02-23)
This is the initial release of Azure Mixed Reality RemoteRendering library. For more information, please see the [README][read_me] and [samples][samples].

This is a Public Preview version, so breaking changes are possible in subsequent releases as we improve the product. To provide feedback, please submit an issue in our [Azure SDK for Java GitHub repo](https://github.com/Azure/azure-sdk-for-java/issues).

<!-- LINKS -->
[read_me]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/remoterendering/azure-mixedreality-remoterendering/README.md
[samples]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/remoterendering/azure-mixedreality-remoterendering/src/samples/java/com/azure/mixedreality/remoterendering

### azure-resourcemanager-iothub 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-iothub_1.0.0-beta.1/sdk/iothub/azure-resourcemanager-iothub/CHANGELOG.md#100-beta1-2021-03-02)
- Azure Resource Manager IotHub client library for Java. This package contains Microsoft Azure SDK for IotHub Management SDK. Use this API to manage the IoT hubs in your Azure subscription. Package tag package-2020-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Container Service 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerservice_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerservice/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-11-01`
- Removed `withNodeImageVersion` method in `ManagedClusterAgentPoolProfileProperties`
- Removed unused class `Components1Q1Og48SchemasManagedclusterAllof1`
- Removed unused class `ComponentsQit0EtSchemasManagedclusterpropertiesPropertiesIdentityprofileAdditionalproperties`, it is same as its superclass `UserAssignedIdentity`

### Resource Management - Storage Cache 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storagecache_1.0.0-beta.1/sdk/storagecache/azure-resourcemanager-storagecache/CHANGELOG.md#100-beta1-2021-02-22)
- Azure Resource Manager StorageCache client library for Java. This package contains Microsoft Azure SDK for StorageCache Management SDK. A Storage Cache provides scalable caching service for NAS clients, serving data from either NFSv3 or Blob at-rest storage (referred to as "Storage Targets"). These operations allow you to manage Caches. Package tag package-2020-10-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Network 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-network_2.2.0/sdk/resourcemanager/azure-resourcemanager-network/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-08-01`
- Removed field `GCM_AES_128` and `GCM_AES_256` from class `ExpressRouteLinkMacSecCipher`
- Changed return type from `Integer` to `Long` for `ConnectionStateSnapshot::avgLatencyInMs()`, `ConnectionStateSnapshot::maxLatencyInMs()`, `ConnectionStateSnapshot::minLatencyInMs()`, `ConnectionStateSnapshot::probesFailed()`, `ConnectionStateSnapshot::probesSent()`
- Changed return type from `Integer` to `Long` for `HopLink::roundTripTimeAvg()`, `HopLink::roundTripTimeMax()`, `HopLink::roundTripTimeMin()`
- Changed return type from `Integer` to `Long` for `PacketCaptureParameters::bytesToCapturePerPacket()`, `PacketCaptureParameters::totalBytesPerSession()`
- Changed return type from `int` to `long` for `PacketCapture::bytesToCapturePerPacket()`, `PacketCapture::totalBytesPerSession()`
- Changed return type from `Resource` to `String` for `EffectiveRoutesParameters::resourceId()`

### Digital Twins - Core 1.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-digitaltwins-core_1.0.3/sdk/digitaltwins/azure-digitaltwins-core/CHANGELOG.md#103-2021-02-24)
#### Dependency Updates

- Upgraded `jackson-annotations` dependency from `2.11.3` to `2.12.1` 
- Upgraded `azure-identity` dependency from `1.2.2` to `1.2.3` 
  - [azure-identity changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/identity/azure-identity/CHANGELOG.md#123-2021-02-09)
- Upgraded `azure-core` dependency from `1.12.0` to `1.13.0` 
  - [azure-core changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#1130-2021-02-05)
- Upgraded `azure-core-http-netty` dependency from `1.7.1` to `1.8.0` 
  - [azure-core-http-netty changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-netty/CHANGELOG.md#180-2021-02-05)
- Upgraded `azure-core-serializer-json-jackson` dependency from `1.1.1` to `1.1.2` 
  - [azure-core-serializer-json-jackson changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#112-2021-02-05)

### Resource Management - DNS 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-dns_2.2.0/sdk/resourcemanager/azure-resourcemanager-dns/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Virtual Machines 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-compute_2.2.0/sdk/resourcemanager/azure-resourcemanager-compute/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-12-01`
- Supported force deletion on virtual machines and virtual machine scale sets
- Removed container service as it is deprecated in compute, please use `KubernetesCluster` from `azure-resourcemanager-containerservice`

### Resource Management - Cognitive Search 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-search_2.2.0/sdk/resourcemanager/azure-resourcemanager-search/CHANGELOG.md#220-2021-02-24)
- Migrated from previous sdk and updated `api-version` to `2020-08-01`.

### Resource Management - Cosmos DB 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cosmos_2.2.0/sdk/resourcemanager/azure-resourcemanager-cosmos/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-09-01`
- Deprecated `ipRangeFilter` and `withIpRangeFilter`, replaced by `ipRules` and `withIpRules`

### Resource Management - Media Services 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-mediaservices_1.0.0-beta.2/sdk/mediaservices/azure-resourcemanager-mediaservices/CHANGELOG.md#100-beta2-2021-02-22)
- Azure Resource Manager Mediaservices client library for Java. This package contains Microsoft Azure SDK for Mediaservices Management SDK. This Swagger was generated by the API Framework. Package tag package-2020-05. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### New Feature

* `models.InputFile` was added

* `models.FaceRedactorMode` was added

* `models.FromEachInputFile` was added

* `models.TrackDescriptor` was added

* `models.H265Video` was added

* `models.SelectVideoTrackById` was added

* `models.H265Complexity` was added

* `models.JobInputSequence` was added

* `models.SelectAudioTrackById` was added

* `models.AttributeFilter` was added

* `models.FromAllInputFile` was added

* `models.TrackAttribute` was added

* `models.VideoTrackDescriptor` was added

* `models.CreatedByType` was added

* `models.H265Layer` was added

* `models.InputDefinition` was added

* `models.BlurType` was added

* `models.H265VideoLayer` was added

* `models.SystemData` was added

* `models.SelectVideoTrackByAttribute` was added

* `models.ChannelMapping` was added

* `models.SelectAudioTrackByAttribute` was added

* `models.AudioTrackDescriptor` was added

* `models.H265VideoProfile` was added

##### `models.FaceDetectorPreset` was modified

* `withMode(models.FaceRedactorMode)` was added
* `blurType()` was added
* `mode()` was added
* `withBlurType(models.BlurType)` was added

##### `models.MediaService` was modified

* `syncStorageKeysWithResponse(models.SyncStorageKeysInput,com.azure.core.util.Context)` was added
* `listEdgePolicies(models.ListEdgePoliciesInput)` was added
* `syncStorageKeys(models.SyncStorageKeysInput)` was added
* `systemData()` was added
* `listEdgePoliciesWithResponse(models.ListEdgePoliciesInput,com.azure.core.util.Context)` was added

##### `models.AssetFilter` was modified

* `systemData()` was added

##### `models.LiveEvent` was modified

* `allocate()` was added
* `start()` was added
* `stop(models.LiveEventActionInput)` was added
* `reset()` was added
* `allocate(com.azure.core.util.Context)` was added
* `reset(com.azure.core.util.Context)` was added
* `systemData()` was added
* `start(com.azure.core.util.Context)` was added
* `stop(models.LiveEventActionInput,com.azure.core.util.Context)` was added

##### `models.AccountFilter` was modified

* `systemData()` was added

##### `models.Asset` was modified

* `getEncryptionKey()` was added
* `listContainerSas(models.ListContainerSasInput)` was added
* `systemData()` was added
* `listStreamingLocators()` was added
* `listStreamingLocatorsWithResponse(com.azure.core.util.Context)` was added
* `listContainerSasWithResponse(models.ListContainerSasInput,com.azure.core.util.Context)` was added
* `getEncryptionKeyWithResponse(com.azure.core.util.Context)` was added

##### `models.StreamingLocator` was modified

* `listContentKeysWithResponse(com.azure.core.util.Context)` was added
* `systemData()` was added
* `listPaths()` was added
* `listPathsWithResponse(com.azure.core.util.Context)` was added
* `listContentKeys()` was added

##### `models.MetricSpecification` was modified

* `lockAggregationType()` was added

##### `models.StreamingPolicy` was modified

* `systemData()` was added

##### `models.StreamingEndpoint` was modified

* `start()` was added
* `systemData()` was added
* `stop(com.azure.core.util.Context)` was added
* `scale(models.StreamingEntityScaleUnit,com.azure.core.util.Context)` was added
* `scale(models.StreamingEntityScaleUnit)` was added
* `stop()` was added
* `start(com.azure.core.util.Context)` was added

##### `models.ContentKeyPolicy` was modified

* `getPolicyPropertiesWithSecretsWithResponse(com.azure.core.util.Context)` was added
* `systemData()` was added
* `getPolicyPropertiesWithSecrets()` was added

##### `models.JobInputClip` was modified

* `withInputDefinitions(java.util.List)` was added
* `inputDefinitions()` was added

##### `models.JobInputAsset` was modified

* `withInputDefinitions(java.util.List)` was added
* `withInputDefinitions(java.util.List)` was added

##### `models.JobInputHttp` was modified

* `withInputDefinitions(java.util.List)` was added
* `withInputDefinitions(java.util.List)` was added

##### `models.Job` was modified

* `cancelJobWithResponse(com.azure.core.util.Context)` was added
* `cancelJob()` was added
* `systemData()` was added

##### `models.Transform` was modified

* `systemData()` was added

### Resource Management 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager_2.2.0/sdk/resourcemanager/azure-resourcemanager/CHANGELOG.md#220-2021-02-24)
- Improved performance of `PagedIterable`

### Resource Management - Storage 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storage_2.2.0/sdk/resourcemanager/azure-resourcemanager-storage/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2021-01-01`
- Return type of `Identity.type()` changed from `String` to `IdentityType`

### azure-resourcemanager-hybridkubernetes 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-hybridkubernetes_1.0.0-beta.1/sdk/hybridkubernetes/azure-resourcemanager-hybridkubernetes/CHANGELOG.md#100-beta1-2021-03-01)
- Azure Resource Manager HybridKubernetes client library for Java. This package contains Microsoft Azure SDK for HybridKubernetes Management SDK. Hybrid Kubernetes Client. Package tag package-2021-03-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Managed Service Identity 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-msi_2.2.0/sdk/resourcemanager/azure-resourcemanager-msi/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### SDK - Bill of Materials 1.0.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-sdk-bom_1.0.2/sdk/boms/azure-sdk-bom/CHANGELOG.md#102-2021-02-25)
#### Dependency Updates

- Updated Azure SDK dependency versions to more recent releases.
- Transitioned loose dependencies of Jackson, Netty, and Reactor to using their BOMs.

### Azure Mixed Reality Authentication 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-authentication_1.0.0-beta.1/sdk/mixedreality/azure-mixedreality-authentication/CHANGELOG.md#100-beta1-2021-02-23)
This is the initial release of Azure Mixed Reality Authentication library. For more information, please see the [README][read_me] and [samples][samples].

This is a Public Preview version, so breaking changes are possible in subsequent releases as we improve the product. To provide feedback, please submit an issue in our [Azure SDK for Java GitHub repo](https://github.com/Azure/azure-sdk-for-java/issues).

<!-- LINKS -->
[read_me]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/mixedreality/azure-mixedreality-authentication/README.md
[samples]: https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/mixedreality/azure-mixedreality-authentication/src/samples/java/com/azure/mixedreality/authentication

### Resource Management - Container Instances 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerinstance_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerinstance/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Spring Cloud 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appplatform_2.2.0/sdk/resourcemanager/azure-resourcemanager-appplatform/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-11-01-preview`

### Resource Management - Authorization 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-authorization_2.2.0/sdk/resourcemanager/azure-resourcemanager-authorization/CHANGELOG.md#220-2021-02-24)
- Supported `listByServicePrincipal` in `RoleAssignments`
- Updated API from `AAD Graph` to `Microsoft Graph`. New permission needs to be granted before calling the API, [Reference](https://docs.microsoft.com/graph/permissions-reference)
- Removed `applicationPermissions` in `ActiveDirectoryApplication`
- Removed `signInName` in `ActiveDirectoryUser`
- Removed `withPasswordValue` in `PasswordCredential.Definition`
- Supported `withPasswordConsumer` in `PasswordCredential.Definition` to consume the password value.

### Resource Management - Key Vault 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-keyvault_2.2.0/sdk/resourcemanager/azure-resourcemanager-keyvault/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - App Service 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appservice_2.2.0/sdk/resourcemanager/azure-resourcemanager-appservice/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Content Delivery Network 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cdn_2.2.0/sdk/resourcemanager/azure-resourcemanager-cdn/CHANGELOG.md#220-2021-02-24)
- Updated `api-version` to `2020-09-01`
- Removed `UrlSigningActionParametersOdataType`
- Type of property `odataType` in `UrlSigningActionParameters` changed from `UrlSigningActionParametersOdataType` to `String`
- Type of property `keyId` in `UrlSigningActionParameters` removed

### Resource Management - Private DNS 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-privatedns_2.2.0/sdk/resourcemanager/azure-resourcemanager-privatedns/CHANGELOG.md#220-2021-02-24)
- Improved performance on `PrivateDnsZone` update

### Resource Management - Container Registry 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerregistry_2.2.0/sdk/resourcemanager/azure-resourcemanager-containerregistry/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### azure-resourcemanager-digitaltwins 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-digitaltwins_1.0.0-beta.1/sdk/digitaltwins/azure-resourcemanager-digitaltwins/CHANGELOG.md#100-beta1-2021-03-02)
- Azure Resource Manager AzureDigitalTwins client library for Java. This package contains Microsoft Azure SDK for AzureDigitalTwins Management SDK. Azure Digital Twins Client for managing DigitalTwinsInstance. Package tag package-2020-12. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Monitor 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-monitor_2.2.0/sdk/resourcemanager/azure-resourcemanager-monitor/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Azure Mixed Reality Authentication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-authentication_1.0.0/sdk/mixedreality/azure-mixedreality-authentication/CHANGELOG.md#100-2021-02-26)
This is the initial stable release of Azure Mixed Reality Authentication library. For more information, please see the [README][read_me] and [samples][samples].

### Resource Management - Traffic Manager 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-trafficmanager_2.2.0/sdk/resourcemanager/azure-resourcemanager-trafficmanager/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - Service Bus 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-servicebus_2.2.0/sdk/resourcemanager/azure-resourcemanager-servicebus/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources

### Resource Management - NetApp Files 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-netapp_1.0.0-beta.1/sdk/netapp/azure-resourcemanager-netapp/CHANGELOG.md#100-beta1-2021-02-22)
- Azure Resource Manager NetAppFiles client library for Java. This package contains Microsoft Azure SDK for NetAppFiles Management SDK. Microsoft NetApp Files Azure Resource Provider specification. Package tag package-netapp-2020-11-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Redis Enterprise 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redisenterprise_1.0.0-beta.2/sdk/redisenterprise/azure-resourcemanager-redisenterprise/CHANGELOG.md#100-beta2-2021-03-02)
- Azure Resource Manager RedisEnterprise client library for Java. This package contains Microsoft Azure SDK for RedisEnterprise Management SDK. REST API for managing Redis Enterprise resources in Azure. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Redis Enterprise 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redisenterprise_1.0.0-beta.1/sdk/redisenterprise/azure-resourcemanager-redisenterprise/CHANGELOG.md#100-beta1-2021-02-23)
- Azure Resource Manager RedisEnterprise client library for Java. This package contains Microsoft Azure SDK for RedisEnterprise Management SDK. REST API for managing Redis Enterprise resources in Azure. Package tag package-preview-2021-02. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - SQL 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-sql_2.2.0/sdk/resourcemanager/azure-resourcemanager-sql/CHANGELOG.md#220-2021-02-24)
- Updated core dependency from resources
### azure-resourcemanager-datadog 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-datadog_1.0.0-beta.1/sdk/datadog/azure-resourcemanager-datadog/CHANGELOG.md#100-beta1-2021-03-08)
- Azure Resource Manager MicrosoftDatadog client library for Java. This package contains Microsoft Azure SDK for MicrosoftDatadog Management SDK.  Package tag package-2020-02-preview. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Storage Cache 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storagecache_1.0.0-beta.2/sdk/storagecache/azure-resourcemanager-storagecache/CHANGELOG.md#100-beta2-2021-03-08)
- Azure Resource Manager StorageCache client library for Java. This package contains Microsoft Azure SDK for StorageCache Management SDK. A Storage Cache provides scalable caching service for NAS clients, serving data from either NFSv3 or Blob at-rest storage (referred to as "Storage Targets"). These operations allow you to manage Caches. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.ClfsTargetProperties` was removed

* `models.Nfs3TargetProperties` was removed

* `models.StorageTargetProperties` was removed

* `models.UnknownTargetProperties` was removed

##### `models.UnknownTarget` was modified

* `withUnknownMap(java.util.Map)` was removed
* `unknownMap()` was removed

#### New Feature

* `models.Condition` was added

* `models.BlobNfsTarget` was added

##### `models.StorageTarget` was modified

* `blobNfs()` was added
* `targetType()` was added
* `dnsRefresh(com.azure.core.util.Context)` was added
* `dnsRefresh()` was added

##### `models.CacheHealth` was modified

* `conditions()` was added

##### `models.StorageTarget$Update` was modified

* `withTargetType(models.StorageTargetType)` was added
* `withBlobNfs(models.BlobNfsTarget)` was added

##### `models.CacheNetworkSettings` was modified

* `dnsSearchDomain()` was added
* `withDnsSearchDomain(java.lang.String)` was added
* `dnsServers()` was added
* `ntpServer()` was added
* `withDnsServers(java.util.List)` was added
* `withNtpServer(java.lang.String)` was added

##### `models.UnknownTarget` was modified

* `withAttributes(java.util.Map)` was added
* `attributes()` was added

##### `models.StorageTargets` was modified

* `dnsRefresh(java.lang.String,java.lang.String,java.lang.String)` was added
* `dnsRefresh(java.lang.String,java.lang.String,java.lang.String,com.azure.core.util.Context)` was added

##### `models.StorageTarget$Definition` was modified

* `withTargetType(models.StorageTargetType)` was added
* `withBlobNfs(models.BlobNfsTarget)` was added
### Text Analytics 5.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_5.0.4/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#504-2021-03-09)
#### Dependency updates
- Update dependency version, `azure-core` to 1.14.0 and `azure-core-http-netty` to 1.9.0.

### Synapse - Artifacts 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-artifacts_1.0.0-beta.3/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md#100-beta3-2021-03-09)
- Add new APIs in `LibraryClient` and `LibraryAsyncClient`

### Azure Communication Administration is deprecated

- `PhoneNumberAdministrationClient` and `PhoneNumberAdministrationAsyncClient` is moved into the new package `azure-communication-phonenumbers` and replaced by `PhoneNumbersClient` and `PhoneNumbersAsyncClient`, respectively.

### Azure Communication Phone Numbers 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100-beta6-2021-03-09)

#### New Features

- Added `PhoneNumbersClient` and `PhoneNumbersAsyncClient` (originally was part of the `azure.communication.administration` package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes

- `PhoneNumberAsyncClient` has been replaced with `PhoneNumbersAsyncClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersAsyncClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/README.md).
- `PhoneNumberClient` has been replaced with `PhoneNumbersClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/README.md).

### Azure Communication Common 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta6-2021-03-09)

#### Breaking Changes

- Renamed `CommunicationTokenRefreshOptions.getRefreshProactively()` to `CommunicationTokenRefreshOptions.isRefreshProactively()`
- Constructor for `CommunicationCloudEnvironment` has been removed and now to set an environment value, the `fromString()` method must be called
- `CommunicationCloudEnvironment`, `CommunicationTokenRefreshOptions `, `CommunicationUserIdentifier`, `MicrosoftTeamsUserIdentifier`,
`PhoneNumberIdentifier`, `UnknownIdentifier`, are all final classes now.

### Azure Communication Chat  1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta6-2021-03-09)

#### New Features

- Updated azure-communication-chat version.

### Azure Communication Identity 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta6-2021-03-09)

#### New Features

- Added a retryPolicy() chain method to the `CommunicationIdentityClientBuilder`.

#### Breaking Changes

- `CommunicationIdentityClient.createUserWithToken` and `CommunicationIdentityAsyncClient.createUserWithToken` have been renamed to
`CommunicationIdentityClient.createUserAndToken` and `CommunicationIdentityAsyncClient.createUserAndToken`.
- `CommunicationIdentityClient.createUserWithTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserWithTokenWithResponse` have been renamed to
`CommunicationIdentityClient.createUserAndTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserAndTokenWithResponse`.
- `CommunicationUserIdentifierWithTokenResult` class has been renamed to `CommunicationUserIdentifierAndToken`.

### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta4-2021-03-09)

#### New Features

- Added Azure Active Directory authentication support.
- Support for creating SmsClient with TokenCredential.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- Send method series in SmsClient are idempotent under retry policy.
- Added `SmsOptions`.

#### Breaking Changes

- Updated `public Mono<SendSmsResponse> sendMessage(PhoneNumberIdentifier from, PhoneNumberIdentifier to, String message)` to `public Mono<SendSmsResponse> send(String from, String to, String message)`.
- Updated `public Mono<Response<SendSmsResponse>> sendMessageWithResponse(PhoneNumberIdentifier from,List<PhoneNumberIdentifier> to, String message, SendSmsOptions smsOptions, Context context)` to `Mono<Response<SmsSendResult>> sendWithResponse(String from, String to, String message, SmsSendOptions options, Context context)`.
- Replaced `SendSmsResponse` with `SmsSendResult`.
### Cognitive Search 11.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-search-documents_11.3.0/sdk/search/azure-search-documents/CHANGELOG.md#1130-2021-03-10)
#### Dependency Updates

- Updated `azure-core` from `1.13.0` to `1.14.0`.
- Updated Jackson from `2.11.3` ro `2.12.1`.
- Updated Reactor from `3.3.12.RELEASE` to `3.4.3`.
- Updated Reactor Netty from `0.9.15.RELEASE` to `1.0.4`.

### Text Analytics 5.1.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_5.1.0-beta.5/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta5-2021-03-10)
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
### Azure Spring Cloud Starter Event Hubs Kafka 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-eventhubs-kafka_2.2.0/sdk/spring/azure-spring-cloud-starter-eventhubs-kafka/CHANGELOG.md#220-2021-03-03)


### Core - HTTP OkHttp 1.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-http-okhttp_1.6.0/sdk/core/azure-core-http-okhttp/CHANGELOG.md#160-2021-03-08)
#### Dependency Updates

- Upgraded `azure-core` from `1.13.0` to `1.14.0`.

### Core Serializer GSON JSON 1.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-json-gson_1.1.0/sdk/core/azure-core-serializer-json-gson/CHANGELOG.md#110-2021-03-08)
#### Dependency Updates

- Updated `azure-core` from `1.13.0` to `1.14.0`.

### Azure Spring Boot Starter 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter_3.2.0/sdk/spring/azure-spring-boot-starter/CHANGELOG.md#320-2021-03-03)


### Management - Core 1.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-management_1.2.0/sdk/core/azure-core-management/CHANGELOG.md#120-2021-03-08)
#### New Features

- Added `SystemData`.

#### Dependency Updates

- Upgraded `azure-core` from `1.13.0` to `1.14.0`.

### Azure Spring Boot Starter Storage 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-storage_3.2.0/sdk/spring/azure-spring-boot-starter-storage/CHANGELOG.md#320-2021-03-03)


### Core - HTTP Netty 1.9.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-http-netty_1.9.0/sdk/core/azure-core-http-netty/CHANGELOG.md#190-2021-03-08)
#### Dependency Updates

- Upgraded `azure-core` from `1.13.0` to `1.14.0`.
- Upgraded Netty from `4.1.54.Final` to `4.1.59.Final`.
- Upgraded Reactor Netty from `0.9.15.RELEASE` to `1.0.4`.

### Azure Spring Cloud Messaging 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-messaging_2.2.0/sdk/spring/azure-spring-cloud-messaging/CHANGELOG.md#220-2021-03-03)


### Communication Common 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-common_1.0.0-beta.6/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta6-2021-03-09)
#### Breaking Changes
- Renamed `CommunicationTokenRefreshOptions.getRefreshProactively()` to `CommunicationTokenRefreshOptions.isRefreshProactively()`
- Constructor for `CommunicationCloudEnvironment` has been removed and now to set an environment value, the `fromString()` method must be called
- `CommunicationCloudEnvironment`, `CommunicationTokenRefreshOptions `, `CommunicationUserIdentifier`, `MicrosoftTeamsUserIdentifier`,
`PhoneNumberIdentifier`, `UnknownIdentifier`, are all final classes now.

### Spring Data Cosmos 3.5.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-data-cosmos_3.5.0/sdk/cosmos/azure-spring-data-cosmos/CHANGELOG.md#350-2021-03-11)


### Azure Remote Rendering 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-mixedreality-remoterendering_1.0.0/sdk/remoterendering/azure-mixedreality-remoterendering/CHANGELOG.md#100-2021-03-05)
* Release client.

### Azure Spring Cloud Integration Storage Queue 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-storage-queue_2.2.0/sdk/spring/azure-spring-integration-storage-queue/CHANGELOG.md#220-2021-03-03)


### Communication Sms 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-sms_1.0.0-beta.4/sdk/communication/azure-communication-sms/CHANGELOG.md#100-beta4-2021-03-09)
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

### Azure Spring Cloud Autoconfigure 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-autoconfigure_2.2.0/sdk/spring/azure-spring-cloud-autoconfigure/CHANGELOG.md#220-2021-03-03)
#### New Features
 - Support `ServiceBusMessageConverter` as a bean to support customize `ObjectMapper`.

### Azure Spring Cloud Stream Binder Test 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-test_2.2.0/sdk/spring/azure-spring-cloud-stream-binder-test/CHANGELOG.md#220-2021-03-03)


### Core Serializer Jackson JSON 1.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-json-jackson_1.2.0/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#120-2021-03-08)
#### Dependency Updates

- Updated `azure-core` from `1.13.0` to `1.14.0`.
- Updated Jackson from `2.11.3` to `2.12.1`.

### Azure Spring Cloud Starter Event Hubs 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-eventhubs_2.2.0/sdk/spring/azure-spring-cloud-starter-eventhubs/CHANGELOG.md#220-2021-03-03)


### Core Experimental 1.0.0-beta.11 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-experimental_1.0.0-beta.11/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta11-2021-03-08)
#### New Features

- Added `ARMChallengeAuthenticationPolicy` as an implementation of `BearerTokenAuthenticationChallengePolicy`.

#### Breaking Changes

- Modified implementations of `onBeforeRequest` and `onChallenge` in `BearerTokenAuthenticationChallengePolicy`.

#### Dependency Updates

- Upgraded `azure-core` from `1.13.0` to `1.14.0`.

### Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-identity_1.0.0-beta.5/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta5-2021-03-02)
#### Breaking
- `CommunicationIdentityAsyncClient.issueToken` and `CommunicationIdentityClient.issueToken` is renamed to `CommunicationIdentityAsyncClient.getToken` and `CommunicationIdentityClient.getToken`.
- `CommunicationIdentityAsyncClient.issueTokenWithResponse` and `CommunicationIdentityClient.issueTokenWithResponse` is renamed to `CommunicationIdentityAsyncClient.getTokenWithReponse` and `CommunicationIdentityClient.getTokenWithReponse`.

### Identity 1.3.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity_1.3.0-beta.2/sdk/identity/azure-identity/CHANGELOG.md#130-beta2-2021-03-10)
#### New Features
- Added the support to enable and configure Persistent Token Cache via `TokenCachePersistenceOptions` API on `InteractiveBrowserCredentialBuilder`, `AuthorizationCodeCredentialBuilder`, `UsernamePasswordCredentialBuilder`, `DeviceCodeCredentialBuilderBuilder` `ClientSecretCredentialBuilder`, `ClientCertificateCredentialBuilder` and `SharedTokenCacheCredentialBuilder`.
- Added new APIs for authenticating users with `DeviceCodeCredential`,  `InteractiveBrowserCredential` and `UsernamePasswordCredential`.
    - Added method `authenticate` which pro-actively interacts with the user to authenticate if necessary and returns a serializable `AuthenticationRecord`
- Added following configurable options in classes `DeviceCodeCredentialBuilder` and `InteractiveBrowserCredentialBuilder`
    - `authenticationRecord` enables initializing a credential with an `AuthenticationRecord` returned from a prior call to `Authenticate`
    - `disableAutomaticAuthentication` disables automatic user interaction causing the credential to throw an `AuthenticationRequiredException` when interactive authentication is necessary.

#### Dependency Updates
- Upgraded `azure-core` dependency to 1.14.0
- Upgraded `msal4j` dependency to 1.9.1
- Upgraded `msal4j-persistence-extension` to 1.1.0

### Azure Spring Boot Starter Key Vault Secrets 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-keyvault-secrets_3.2.0/sdk/spring/azure-spring-boot-starter-keyvault-secrets/CHANGELOG.md#320-2021-03-03)


### Core 1.14.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core_1.14.0/sdk/core/azure-core/CHANGELOG.md#1140-2021-03-08)
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

#### Dependency Updates

- Upgraded Jackson from `2.11.3` to `2.12.1`.
- Upgraded Netty from `4.1.54.Final` to `4.1.59.Final`.
- Upgraded Reactor from `3.3.12.RELEASE` to `3.4.3`.
- Upgraded Reactor Netty from `0.9.15.RELEASE` to `1.0.4`.

### Azure Spring Cloud Telemetry 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-telemetry_2.2.0/sdk/spring/azure-spring-cloud-telemetry/CHANGELOG.md#220-2021-03-03)


### App Configuration 1.1.10 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-appconfiguration_1.1.10/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md#1110-2021-03-09)
#### Dependency updates
- Update dependency version, `azure-core` to 1.14.0 and `azure-core-http-netty` to 1.9.0.

### Cosmos DB 4.13.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos_4.13.0/sdk/cosmos/azure-cosmos/CHANGELOG.md#4130-2021-03-11)


### Communication Chat 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-chat_1.0.0-beta.6/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta6-2021-03-09)
Updated `azure-communication-chat` version

### Service Bus 7.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-servicebus_7.1.0/sdk/servicebus/azure-messaging-servicebus/CHANGELOG.md#710-2021-03-10)
#### Bug Fixes
- Continue to receive messages regardless of user not settling the received message in PEEK_LOCK mode [#19247](https://github.com/Azure/azure-sdk-for-java/issues/19247).
- Update to end the trace span regardless of the scope instance type for process operation tracing spans.
- Removed logs that leaked secrets when connection string is invalid. [#19249](https://github.com/Azure/azure-sdk-for-java/issues/19249)

#### Dependency Updates
- Upgraded `azure-core` dependency to `1.14.0`.
- Upgraded `azure-core-amqp` dependency to `2.0.3`.

### Key Vault - Keys 4.3.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.3.0-beta.5/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta5-2021-03-12)
#### Breaking Changes
- Removed local support for encryption and decryption using AESGCM, as per guidance of Microsoft's cryptography board. Remote encryption and decryption using said algorithm is still supported.

#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

#### Bug fixes
- Fixed issue that caused a `NullPointerException` when attempting to use a `CryptographyClient` for symmetric key encryption operations after the first one.
- Fixed issue where `JsonWebKey` byte array contents would get serialized/deserialized using Base64 instead of URL-safe Base64.
- Fixed issue where properties of responses received when using a `CryptographyClient` for encryption/decryption were not populated on the `EncryptResult` and `DecryptResult` classes.

#### Dependency Updates
- Upgraded `azure-core` dependency to `1.14.0`
- Upgraded `azure-core-http-netty` dependency to `1.9.0`
- Upgraded `azure-core-http-okhttp` dependency to `1.6.0`
- Upgraded `azure-identity` dependency to `1.2.4`

### Azure Spring Boot Starter Key Vault Certificates 3.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-keyvault-certificates_3.0.0-beta.4/sdk/spring/azure-spring-boot-starter-keyvault-certificates/CHANGELOG.md#300-beta4-2021-03-03)


### Azure Spring Cloud Starter Storage Queue 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-storage-queue_2.2.0/sdk/spring/azure-spring-cloud-starter-storage-queue/CHANGELOG.md#220-2021-03-03)


### azure-communication-phonenumbers 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-phonenumbers_1.0.0-beta.6/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100-beta6-2021-03-09)
#### Added
- Added PhoneNumbersClient and PhoneNumbersAsyncClient (originally was part of the azure.communication.administration package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes
- PhoneNumberAsyncClient has been replaced with PhoneNumbersAsyncClient, which has the same functionality but different APIs. To learn more about how PhoneNumbersAsyncClient works, refer to the [README.md][https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/README.md].
- PhoneNumberClient has been replaced with PhoneNumbersClient, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md][https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/communication/azure-communication-phonenumbers/README.md].

### Core - AMQP 2.0.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-amqp_2.0.3/sdk/core/azure-core-amqp/CHANGELOG.md#203-2021-03-09)
#### Bug Fixes

- Fixed a bug where using a proxy the SSL peer hostname was set incorrect.
- Removed logs that leaked secrets. [#19249](https://github.com/Azure/azure-sdk-for-java/issues/19249)

#### Version Updates

- Upgraded Reactor from `3.3.12.RELEASE` to `3.4.3`.

### Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-chat_1.0.0-beta.5/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta5-2021-03-02)
#### Breaking Changes

- ChatMessage - `senderId` renamed to `senderCommunicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatMessageReadReceipt - `senderId` renamed to `senderCommunicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatParticipant - `user` renamed to `communicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatThread - `createdBy` renamed to `createdByCommunicationIdentifier`, changed type to `CommunicationIdentifier`.
- ChatMessageContent - `initiator` renamed to `initiatorCommunicationIdentifier`, changed type to `CommunicationIdentifier`.

### Tracing OpenTelemetry Plugin 1.0.0-beta.8 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opentelemetry_1.0.0-beta.8/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta8-2021-03-08)
#### Dependency Updates

- Updated `azure-core` from `1.13.0` to `1.14.0`.
- Updated versions of `opentelemetry-api` to `1.0.0` version.
  More detailed information about the new OpenTelemetry API version can be found in [OpenTelemetry changelog](https://github.com/open-telemetry/opentelemetry-java/blob/main/CHANGELOG.md#version-100---2021-02-26).

### Azure Spring Cloud Starter Service bus 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-servicebus_2.2.0/sdk/spring/azure-spring-cloud-starter-servicebus/CHANGELOG.md#220-2021-03-03)
#### New Features
 - Support `ServiceBusMessageConverter` as a bean to support customize `ObjectMapper`.

### Azure Spring Cloud Stream Binder Service bus Queue 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-servicebus-queue_2.2.0/sdk/spring/azure-spring-cloud-stream-binder-servicebus-queue/CHANGELOG.md#220-2021-03-03)


### Azure Spring Cloud Stream Binder Service bus Core 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-servicebus-core_2.2.0/sdk/spring/azure-spring-cloud-stream-binder-servicebus-core/CHANGELOG.md#220-2021-03-03)


### Azure Spring Cloud Context 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-context_2.2.0/sdk/spring/azure-spring-cloud-context/CHANGELOG.md#220-2021-03-03)


### Key Vault - Secrets 4.3.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-secrets_4.3.0-beta.4/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#430-beta4-2021-03-12)
#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

#### Dependency Updates
- Upgraded `azure-core` dependency to `1.14.0`
- Upgraded `azure-core-http-netty` dependency to `1.9.0`
- Upgraded `azure-core-http-okhttp` dependency to `1.6.0`
- Upgraded `azure-identity` dependency to `1.2.4`

### Form Recognizer 3.0.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-formrecognizer_3.0.6/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#306-2021-03-10)
#### Dependency updates
- Update dependency version, `azure-core` to `1.14.0`, `azure-core-http-netty` to `1.9.0` and `azure-identity` to `1.2.4`.

### Key Vault - Certificates 4.2.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-certificates_4.2.0-beta.4/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta4-2021-03-12)
#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

#### Dependency Updates
- Upgraded `azure-core` dependency to `1.14.0`
- Upgraded `azure-core-http-netty` dependency to `1.9.0`
- Upgraded `azure-core-http-okhttp` dependency to `1.6.0`
- Upgraded `azure-identity` dependency to `1.2.4`

### Azure Spring Cloud Integration Core 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-core_2.2.0/sdk/spring/azure-spring-integration-core/CHANGELOG.md#220-2021-03-03)


### Core - Test 1.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-test_1.6.0/sdk/core/azure-core-test/CHANGELOG.md#160-2021-03-08)
#### Dependency Updates

- Updated `azure-core` from `1.13.0` to `1.14.0`.

### Key Vault - JCA 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-jca_1.0.0-beta.4/sdk/keyvault/azure-security-keyvault-jca/CHANGELOG.md#100-beta4-2021-03-03)


### Core Serializer Apache Avro 1.0.0-beta.8 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-avro-apache_1.0.0-beta.8/sdk/core/azure-core-serializer-avro-apache/CHANGELOG.md#100-beta8-2021-03-08)
#### Dependency Updates

- Updated `azure-core` from `1.13.0` to `1.14.0`.

### Azure Spring Cloud Starter Cache 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-cache_2.2.0/sdk/spring/azure-spring-cloud-starter-cache/CHANGELOG.md#220-2021-03-03)


### Azure Spring Cloud Stream Binder Event Hubs 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-eventhubs_2.2.0/sdk/spring/azure-spring-cloud-stream-binder-eventhubs/CHANGELOG.md#220-2021-03-03)


### Resource Management - NetApp Files 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-netapp_1.0.0-beta.2/sdk/netapp/azure-resourcemanager-netapp/CHANGELOG.md#100-beta2-2021-03-15)
- Azure Resource Manager NetAppFiles client library for Java. This package contains Microsoft Azure SDK for NetAppFiles Management SDK. Microsoft NetApp Files Azure Resource Provider specification. Package tag package-netapp-2020-12-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.KeySource` was removed

* `models.CreatedByType` was removed

* `models.SystemData` was removed

##### `models.SnapshotPolicyPatch` was modified

* `namePropertiesName()` was removed

##### `models.NetAppAccount` was modified

* `models.SystemData systemData()` -> `com.azure.core.management.SystemData systemData()`

##### `models.AccountEncryption` was modified

* `models.KeySource keySource()` -> `java.lang.String keySource()`
* `withKeySource(models.KeySource)` was removed

#### New Feature

* `models.BackupStatus` was added

* `models.VolumeBackupStatus` was added

##### `models.Volume` was modified

* `ldapEnabled()` was added

##### `models.ActiveDirectory` was modified

* `withAllowLocalNfsUsersWithLdap(java.lang.Boolean)` was added
* `allowLocalNfsUsersWithLdap()` was added

##### `NetAppFilesManager` was modified

* `volumeBackupStatus()` was added

##### `models.Backup` was modified

* `volumeName()` was added

##### `models.Volume$Definition` was modified

* `withLdapEnabled(java.lang.Boolean)` was added

##### `models.BackupPatch` was modified

* `volumeName()` was added

##### `models.AccountEncryption` was modified

* `withKeySource(java.lang.String)` was added

### Azure Spring Cloud Integration Test 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-test_2.2.0/sdk/spring/azure-spring-integration-test/CHANGELOG.md#220-2021-03-03)


### Key Vault - Administration 4.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-administration_4.0.0-beta.5/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta5-2021-03-12)
#### Changed
- Changed logging level in `onRequest` and `onSuccess` calls for service operations from `INFO` to `VERBOSE`.

#### Dependency Updates
- Upgraded `azure-core` dependency to `1.14.0`
- Upgraded `azure-core-http-netty` dependency to `1.9.0`
- Upgraded `azure-core-http-okhttp` dependency to `1.6.0`
- Upgraded `azure-identity` dependency to `1.2.4`

### Event Hubs 5.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs_5.6.0/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#560-2021-03-10)
#### Bug Fixes
- Update to end the trace span regardless of the scope instance type for process operation tracing spans.

#### Dependency Updates
- Update `azure-core` dependency to `1.14.0`.
- Update `azure-core-amqp` dependency to `2.0.3`.

### Monitor Exporter for OpenTelemetry 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-monitor-opentelemetry-exporter_1.0.0-beta.4/sdk/monitor/azure-monitor-opentelemetry-exporter/CHANGELOG.md#100-beta4-2021-03-10)
#### New Features
- `AzureMonitorExporterBuilder` now supports reading connection string from `APPLICATIONINSIGHTS_CONNECTION_STRING
` environment variable.

#### Dependency Updates
- Updated versions of `opentelemetry-api` and `opentelemetry-sdk` to `1.0.0` version.
  More detailed information about the new OpenTelemetry API version can be found in [OpenTelemetry changelog](https://github.com/open-telemetry/opentelemetry-java/blob/main/CHANGELOG.md#version-100---2021-02-26).
- Updated `azure-core` version to 1.14.0.
- Updated `azure-core-http-netty` version to 1.9.0.

### Azure Spring Cloud Stream Binder Service bus Topic 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-servicebus-topic_2.2.0/sdk/spring/azure-spring-cloud-stream-binder-servicebus-topic/CHANGELOG.md#220-2021-03-03)


### Azure Spring Cloud Storage 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-storage_2.2.0/sdk/spring/azure-spring-cloud-storage/CHANGELOG.md#220-2021-03-03)


### Azure Spring Boot Starter Active Directory 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-active-directory_3.2.0/sdk/spring/azure-spring-boot-starter-active-directory/CHANGELOG.md#320-2021-03-03)


### azure-iot-deviceupdate 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-iot-deviceupdate_1.0.0-beta.1/sdk/deviceupdate/azure-iot-deviceupdate/CHANGELOG.md#100-beta1-2021-03-02)
This is the initial release of Azure Device Update for IoT Hub library. For more information, please see the [README](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/deviceupdate/azure-iot-deviceupdate/README.md) 
and [samples](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/deviceupdate/azure-iot-deviceupdate/src/samples/README.md).

This is a Public Preview version, so breaking changes are possible in subsequent releases as we improve the product. To provide feedback, please submit an issue in our [Azure SDK for Java GitHub repo](https://github.com/Azure/azure-sdk-for-java/issues).

### Azure Spring Boot Starter Active Directory B2C 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-active-directory-b2c_3.2.0/sdk/spring/azure-spring-boot-starter-active-directory-b2c/CHANGELOG.md#320-2021-03-03)


### Communication Identity 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-identity_1.0.0-beta.6/sdk/communication/azure-communication-identity/CHANGELOG.md#100-beta6-2021-03-09)
#### Added
- Added a retryPolicy() chain method to the `CommunicationIdentityClientBuilder`.

#### Breaking
- `CommunicationIdentityClient.createUserWithToken` and `CommunicationIdentityAsyncClient.createUserWithToken` have been renamed to
`CommunicationIdentityClient.createUserAndToken` and `CommunicationIdentityAsyncClient.createUserAndToken`.
- `CommunicationIdentityClient.createUserWithTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserWithTokenWithResponse` have been renamed to
`CommunicationIdentityClient.createUserAndTokenWithResponse` and `CommunicationIdentityAsyncClient.createUserAndTokenWithResponse`.
- `CommunicationUserIdentifierWithTokenResult` class has been renamed to `CommunicationUserIdentifierAndToken`.

### Azure Spring Boot Starter Cosmos 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-cosmos_3.2.0/sdk/spring/azure-spring-boot-starter-cosmos/CHANGELOG.md#320-2021-03-03)


### Event Hubs - Azure Blob Storage Checkpoint Store 1.5.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-messaging-eventhubs-checkpointstore-blob_1.5.1/sdk/eventhubs/azure-messaging-eventhubs-checkpointstore-blob/CHANGELOG.md#151-2021-03-10)
#### Dependency Updates
- Update `azure-messaging-eventhubs` dependency to `5.5.1`.

### Tables 12.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-tables_12.0.0-beta.5/sdk/tables/azure-data-tables/CHANGELOG.md#1200-beta5-2021-03-10)
#### New Features

- Added support to specify whether or not a pipeline policy should be added per call or per retry.
- Added support for passing Azure Core's `ClientOptions` to client builders.

#### Dependency Updates

- Updated dependency version of `azure-core` to 1.14.0.

### Communication Common 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-common_1.0.0-beta.5/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta5-2021-03-02)
- Updated `azure-communication-common` version

### Azure Spring Boot Starter Service bus Jms 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-servicebus-jms_3.2.0/sdk/spring/azure-spring-boot-starter-servicebus-jms/CHANGELOG.md#320-2021-03-03)
#### Breaking Changes
- Require new property of `spring.jms.servicebus.pricing-tier` to set pricing tier of Azure Service Bus. Supported values are `premium`, `standard` and `basic`.

#### New Features
- Enable MessageConverter bean customization.
- Update the underpinning JMS library for the Premium pricing tier of Service Bus to JMS 2.0.

### Azure Spring Boot AutoConfigure 3.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot_3.2.0/sdk/spring/azure-spring-boot/CHANGELOG.md#320-2021-03-03)
#### Breaking Changes
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
#### New Features
- Enable MessageConverter bean customization.
- Update the underpinning JMS library for the Premium pricing tier of Service Bus to JMS 2.0.

### Azure Spring Cloud Integration Event Hubs 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-eventhubs_2.2.0/sdk/spring/azure-spring-integration-eventhubs/CHANGELOG.md#220-2021-03-03)


### Azure Spring Cloud Integration Service Bus 2.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-servicebus_2.2.0/sdk/spring/azure-spring-integration-servicebus/CHANGELOG.md#220-2021-03-03)
#### New Features
 - Support `ServiceBusMessageConverter` as a bean to support customize `ObjectMapper`.

### Azure Identity Spring 1.2.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity-spring_1.2.0/sdk/spring/azure-identity-spring/CHANGELOG.md#120-2021-03-03)
### Storage - Files Data Lake 12.4.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-datalake_12.4.1/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1241-2021-03-19)
- Updated `azure-storage-blob` version to `12.10.1` to pickup fixes for blob output stream.

### Storage - Common 12.10.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-common_12.10.1/sdk/storage/azure-storage-common/CHANGELOG.md#12101-2021-03-19)
- Removed a deep copy in PayloadSizeGate

### Storage - Blobs 12.10.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.10.1/sdk/storage/azure-storage-blob/CHANGELOG.md#12101-2021-03-19)
- Removed a deep copy in the general upload path to reduce memory consumption and increase perf
- Added a deep copy immediately after calling BlobOutputStream.write to prevent overwriting data in the case of reusing a single buffer to write to an output stream


[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
