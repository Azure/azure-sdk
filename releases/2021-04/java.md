---
title: Azure SDK for Java (April 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
azure-resourcemanager-trafficmanager:2.3.0
azure-spring-boot-starter:3.3.0
azure-spring-cloud-stream-binder-eventhubs:2.3.0
azure-resourcemanager-monitor:2.3.0
azure-spring-cloud-messaging:2.3.0
azure-spring-boot-starter-active-directory:3.3.0
azure-cosmos-spark_3-1_2-12:4.0.0-alpha.1
azure-resourcemanager-keyvault:2.3.0
azure-storage-blob-nio:12.0.0-beta.4
azure-communication-sms:1.0.0
azure-resourcemanager-apimanagement:1.0.0-beta.1
azure-resourcemanager-search:2.3.0
azure-resourcemanager-storage:2.3.0
azure-resourcemanager-loganalytics:1.0.0-beta.2
azure-resourcemanager-resources:2.3.0
azure-spring-cloud-starter-eventhubs:2.3.0
azure-spring-cloud-autoconfigure:2.3.0
azure-storage-internal-avro:12.0.3-beta.2
azure-storage-blob-cryptography:12.11.0-beta.2
azure-resourcemanager-cosmos:2.3.0
azure-spring-boot:3.3.0
azure-spring-cloud-starter-storage-queue:2.3.0
azure-core:1.14.1
azure-resourcemanager:2.3.0
azure-storage-file-share:12.9.0-beta.2
azure-resourcemanager-privatedns:2.3.0
azure-storage-blob-batch:12.9.0-beta.2
azure-resourcemanager-network:2.3.0
azure-resourcemanager-cdn:2.3.0
azure-storage-blob:12.10.2
azure-resourcemanager-changeanalysis:1.0.0-beta.1
azure-spring-integration-core:2.3.0
azure-resourcemanager-communication:1.0.0-beta.1
azure-spring-boot-starter-keyvault-secrets:3.3.0
azure-storage-file-datalake:12.4.1
azure-resourcemanager-resourcegraph:1.0.0-beta.1
azure-resourcemanager-containerinstance:2.3.0
azure-spring-boot-starter-storage:3.3.0
azure-core-serializer-json-jackson:1.2.1
azure-storage-common:12.11.0-beta.2
azure-cosmos:4.13.1
azure-resourcemanager-servicebus:2.3.0
azure-spring-cloud-storage:2.3.0
azure-resourcemanager-eventhubs:2.3.0
azure-resourcemanager-containerregistry:2.3.0
azure-cosmos-spark_3-1_2-12:4.0.0-beta.1
azure-storage-queue:12.9.0-beta.2
azure-iot-modelsrepository:1.0.0-beta.1
azure-communication-phonenumbers:1.0.0-beta.7
azure-spring-boot-starter-active-directory-b2c:3.3.0
azure-storage-blob:12.11.0-beta.2
azure-resourcemanager-appplatform:2.3.0
azure-identity-spring:1.3.0
azure-resourcemanager-appservice:2.3.0
azure-resourcemanager-dns:2.3.0
azure-spring-integration-test:2.3.0
azure-resourcemanager-datadog:1.0.0-beta.2
azure-resourcemanager-authorization:2.3.0
azure-resourcemanager-containerservice:2.3.0
azure-spring-integration-eventhubs:2.3.0
azure-communication-chat:1.0.0
azure-spring-integration-servicebus:2.3.0
azure-communication-identity:1.0.0
azure-spring-cloud-starter-cache:2.3.0
azure-resourcemanager-msi:2.3.0
azure-security-keyvault-jca:1.0.0-beta.5
azure-spring-cloud-stream-binder-servicebus-queue:2.3.0
azure-spring-boot-starter-cosmos:3.3.0
azure-spring-cloud-stream-binder-servicebus-topic:2.3.0
azure-storage-file-datalake:12.5.0-beta.2
azure-storage-blob:12.10.1
azure-spring-boot-starter-keyvault-certificates:3.0.0-beta.5
azure-resourcemanager-sql:2.3.0
azure-resourcemanager-redis:2.3.0
azure-spring-cloud-context:2.3.0
azure-storage-common:12.10.1
azure-spring-cloud-stream-binder-test:2.3.0
azure-spring-cloud-starter-eventhubs-kafka:2.3.0
azure-resourcemanager-delegatednetwork:1.0.0-beta.1
azure-spring-integration-storage-queue:2.3.0
azure-resourcemanager-compute:2.3.0
azure-spring-cloud-stream-binder-servicebus-core:2.3.0
azure-communication-common:1.0.0
azure-spring-data-cosmos:3.5.1
azure-spring-cloud-starter-servicebus:2.3.0
azure-spring-boot-starter-servicebus-jms:3.3.0
azure-spring-cloud-telemetry:2.3.0
azure-core-test:1.6.1
azure-core:1.15.0
azure-core-experimental:1.0.0-beta.12
azure-core-serializer-avro-apache:1.0.0-beta.9
azure-core-management:1.2.1
azure-core-tracing-opentelemetry:1.0.0-beta.9
azure-core-serializer-json-gson:1.1.1
azure-core-serializer-json-jackson:1.2.2
azure-core-http-okhttp:1.6.1
azure-ai-formrecognizer:3.1.0-beta.3
azure-ai-textanalytics:5.0.5
azure-search-documents:11.4.0-beta.1
azure-cosmos:4.14.0
azure-ai-textanalytics:5.1.0-beta.6
azure-analytics-synapse-accesscontrol:1.0.0-beta.3
azure-analytics-synapse-monitoring:1.0.0-beta.3
azure-spring-data-cosmos:3.6.0
azure-analytics-synapse-spark:1.0.0-beta.3
azure-analytics-synapse-managedprivateendpoints:1.0.0-beta.3
azure-analytics-synapse-artifacts:1.0.0-beta.4
azure-resourcemanager-synapse:1.0.0-beta.1
azure-resourcemanager-costmanagement:1.0.0-beta.2
azure-resourcemanager-communication:1.0.0
azure-resourcemanager-resourcehealth:1.0.0-beta.1

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our April 2021 client library releases.

#### GA
- Resource Management - Traffic Manager
- Azure Spring Boot Starter
- Azure Spring Cloud Stream Binder Event Hubs
- Resource Management - Monitor
- Azure Spring Cloud Messaging
- Azure Spring Boot Starter Active Directory
- Resource Management - Key Vault
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Identity
- Azure Communication SMS
- Resource Management - Communication
- Resource Management - Cognitive Search
- Resource Management - Storage
- Resource Management - Resources
- Azure Spring Cloud Starter Event Hubs
- Azure Spring Cloud Autoconfigure
- Resource Management - Cosmos DB
- Azure Spring Boot AutoConfigure
- Azure Spring Cloud Starter Storage Queue
- Resource Management
- Resource Management - Private DNS
- Resource Management - Network
- Resource Management - Content Delivery Network
- Azure Spring Cloud Integration Core
- Azure Spring Boot Starter Key Vault Secrets
- Resource Management - Container Instances
- Azure Spring Boot Starter Storage
- Resource Management - Service Bus
- Azure Spring Cloud Storage
- Resource Management - Event Hubs
- Resource Management - Container Registry
- Azure Spring Boot Starter Active Directory B2C
- Resource Management - Spring Cloud
- Azure Identity Spring
- Resource Management - App Service
- Resource Management - DNS
- Azure Spring Cloud Integration Test
- Resource Management - Authorization
- Resource Management - Container Service
- Azure Spring Cloud Integration Event Hubs
- Azure Spring Cloud Integration Service Bus
- Azure Spring Cloud Starter Cache
- Resource Management - Managed Service Identity
- Azure Spring Cloud Stream Binder Service bus Queue
- Azure Spring Boot Starter Cosmos
- Azure Spring Cloud Stream Binder Service bus Topic
- Resource Management - SQL
- Resource Management - Redis
- Azure Spring Cloud Context
- Azure Spring Cloud Stream Binder Test
- Azure Spring Cloud Starter Event Hubs Kafka
- Azure Spring Cloud Integration Storage Queue
- Resource Management - Compute
- Azure Spring Cloud Stream Binder Service bus Core
- Azure Spring Cloud Starter Service bus
- Azure Spring Boot Starter Service bus Jms
- Azure Spring Cloud Telemetry
- Core
- Cosmos DB
- Spring Data Cosmos

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Core
- Storage - Blobs
- Storage - Files Data Lake
- Core Serializer Jackson JSON
- Cosmos DB
- Storage - Blobs
- Storage - Common
- Spring Data Cosmos
- Core - Test
- Management - Core
- Core Serializer GSON JSON
- Core Serializer Jackson JSON
- Core - HTTP OkHttp
- Text Analytics

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- azure-cosmos-spark_3-1_2-12
- Storage - Blobs NIO
- Resource Management - Api Management
- Resource Management - Log Analytics
- Resource Management - Communication
- Storage - Internal Avro
- Storage - Blobs Cryptography
- Storage - Files Shares
- Storage - Blobs Batch
- Resource Management - Change Analysis
- Resource Management - Resource Graph
- Storage - Common
- azure-cosmos-spark_3-1_2-12
- Storage - Queues
- azure-iot-modelsrepository
- Azure Communication Phone Numbers
- Storage - Blobs
- Resource Management - Datadog
- Key Vault - JCA
- Storage - Files Data Lake
- Azure Spring Boot Starter Key Vault Certificates
- Resource Management - Delegated Network
- Core Experimental
- Core Serializer Apache Avro
- Tracing OpenTelemetry Plugin
- Form Recognizer
- Cognitive Search
- Text Analytics
- Synapse - AccessControl
- Synapse - Monitoring
- Synapse - Spark
- Synapse - Managed Private Endpoints
- Synapse - Artifacts
- azure-resourcemanager-synapse
- Resource Management - Cost Management
- azure-resourcemanager-resourcehealth

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-messaging</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-active-directory</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.cosmos.spark</groupId>
  <artifactId>azure-cosmos-spark_3-1_2-12</artifactId>
  <version>4.0.0-alpha.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-keyvault</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-nio</artifactId>
  <version>12.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-identity</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-sms</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
    <groupId>com.azure.resourcemanager</groupId>
    <artifactId>azure-resourcemanager-communication</artifactId>
    <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-communication-phonenumbers</artifactId>
  <version>1.0.0-beta.7</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-apimanagement</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-search</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-storage</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-loganalytics</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-autoconfigure</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.3-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-cryptography</artifactId>
  <version>12.11.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cosmos</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-storage-queue</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.14.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-share</artifactId>
  <version>12.9.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob-batch</artifactId>
  <version>12.9.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-network</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.10.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-changeanalysis</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-core</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-keyvault-secrets</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.4.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resourcegraph</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-storage</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.2.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.11.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.13.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-storage</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.cosmos.spark</groupId>
  <artifactId>azure-cosmos-spark_3-1_2-12</artifactId>
  <version>4.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.9.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-iot-modelsrepository</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-active-directory-b2c</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.11.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-identity-spring</artifactId>
  <version>1.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-dns</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-test</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-datadog</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-authorization</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerservice</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-eventhubs</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-servicebus</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-msi</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-jca</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-cosmos</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-file-datalake</artifactId>
  <version>12.5.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-blob</artifactId>
  <version>12.10.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-keyvault-certificates</artifactId>
  <version>3.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-context</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-common</artifactId>
  <version>12.10.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-test</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-delegatednetwork</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-integration-storage-queue</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-compute</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-core</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-spring-data-cosmos</artifactId>
  <version>3.5.1</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-servicebus</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-boot-starter-servicebus-jms</artifactId>
  <version>3.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-telemetry</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.6.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.15.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.12</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-avro-apache</artifactId>
  <version>1.0.0-beta.9</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-management</artifactId>
  <version>1.2.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.9</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.1.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.2.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.6.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.1.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.0.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.4.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-cosmos</artifactId>
  <version>4.14.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>5.1.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-accesscontrol</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-monitoring</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-spring-data-cosmos</artifactId>
  <version>3.6.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-spark</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-managedprivateendpoints</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-analytics-synapse-artifacts</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-synapse</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-costmanagement</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resourcehealth</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>


```

[pattern]: # (<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>`n)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights
### Resource Management - Traffic Manager 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-trafficmanager_2.3.0/sdk/resourcemanager/azure-resourcemanager-trafficmanager/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Spring Boot Starter 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter_3.3.0/sdk/spring/azure-spring-boot-starter/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Azure Spring Cloud Stream Binder Event Hubs 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-eventhubs_2.3.0/sdk/spring/azure-spring-cloud-stream-binder-eventhubs/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `azure-messaging-eventhubs` [5.6.0](https://github.com/azure-sdk/azure-sdk-for-java/blob/master/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#560-2021-03-10).

### Resource Management - Monitor 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-monitor_2.3.0/sdk/resourcemanager/azure-resourcemanager-monitor/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Spring Cloud Messaging 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-messaging_2.3.0/sdk/spring/azure-spring-cloud-messaging/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Azure Spring Boot Starter Active Directory 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-active-directory_3.3.0/sdk/spring/azure-spring-boot-starter-active-directory/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Security` [5.4.5](https://github.com/spring-projects/spring-security/releases/tag/5.4.5).
- Support creating `GrantedAuthority` by "roles" claim from id-token for web application.

### azure-cosmos-spark_3-1_2-12 4.0.0-alpha.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos-spark_3-1_2-12_4.0.0-alpha.1/sdk/cosmos/azure-cosmos-spark_3-1_2-12/CHANGELOG.md#400-alpha1-2021-03-17)
* Cosmos DB Spark 3.1.1 Connector Test Release.

### Resource Management - Key Vault 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-keyvault_2.3.0/sdk/resourcemanager/azure-resourcemanager-keyvault/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Storage - Blobs NIO 12.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-nio_12.0.0-beta.4/sdk/storage/azure-storage-blob-nio/CHANGELOG.md#1200-beta4-2021-03-29)
- Made AzurePath.toBlobClient public
- Added support for Azurite
- Change FileSystem configuration to accept an endpoint and credential types instead of a string for the account name, key, and token

### Resource Management - Api Management 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-apimanagement_1.0.0-beta.1/sdk/apimanagement/azure-resourcemanager-apimanagement/CHANGELOG.md#100-beta1-2021-03-23)
- Azure Resource Manager ApiManagement client library for Java. This package contains Microsoft Azure SDK for ApiManagement Management SDK. ApiManagement Client. Package tag package-2020-12. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Cognitive Search 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-search_2.3.0/sdk/resourcemanager/azure-resourcemanager-search/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Storage 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-storage_2.3.0/sdk/resourcemanager/azure-resourcemanager-storage/CHANGELOG.md#230-2021-03-30)
- Updated `api-version` to `2021-02-01`
- Storage account default to Transport Layer Security (TLS) 1.2 for HTTPS

### Resource Management - Log Analytics 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-loganalytics_1.0.0-beta.2/sdk/loganalytics/azure-resourcemanager-loganalytics/CHANGELOG.md#100-beta2-2021-03-30)
- Azure Resource Manager LogAnalytics client library for Java. This package contains Microsoft Azure SDK for LogAnalytics Management SDK. Operational Insights Client. Package tag package-2020-08. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### New Feature

##### `models.Workspace$Update` was modified

* `withForceCmkForQuery(java.lang.Boolean)` was added
* `withFeatures(java.util.Map)` was added

##### `models.Workspace$Definition` was modified

* `withFeatures(java.util.Map)` was added
* `withForceCmkForQuery(java.lang.Boolean)` was added

##### `models.WorkspacePatch` was modified

* `withFeatures(java.util.Map)` was added
* `createdDate()` was added
* `withForceCmkForQuery(java.lang.Boolean)` was added
* `features()` was added
* `modifiedDate()` was added
* `forceCmkForQuery()` was added

##### `models.Workspace` was modified

* `createdDate()` was added
* `features()` was added
* `modifiedDate()` was added
* `forceCmkForQuery()` was added

### Resource Management - Resources 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resources_2.3.0/sdk/resourcemanager/azure-resourcemanager-resources/CHANGELOG.md#230-2021-03-30)
- Added client-side validation for `getByResourceGroup`, `listByResourceGroup`, `deleteByResourceGroup` methods.
- Added method overload of `getById` and `deleteById` in `GenericResources` to take `apiVersion` parameters. It is always recommended for user to provide the `apiVersion` parameter for consistency across service versions.
- Supported `TagOperations`

### Azure Spring Cloud Starter Event Hubs 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-eventhubs_2.3.0/sdk/spring/azure-spring-cloud-starter-eventhubs/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `azure-messaging-eventhubs` [5.6.0](https://github.com/azure-sdk/azure-sdk-for-java/blob/master/sdk/eventhubs/azure-messaging-eventhubs/CHANGELOG.md#560-2021-03-10).

### Azure Spring Cloud Autoconfigure 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-autoconfigure_2.3.0/sdk/spring/azure-spring-cloud-autoconfigure/CHANGELOG.md#230-2021-03-22)
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Storage - Internal Avro 12.0.3-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-internal-avro_12.0.3-beta.2/sdk/storage/azure-storage-internal-avro/CHANGELOG.md#1203-beta2-2021-03-29)
- Update `azure-storage-common` to version `12.11.0-beta.2`

### Storage - Blobs Cryptography 12.11.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-cryptography_12.11.0-beta.2/sdk/storage/azure-storage-blob-cryptography/CHANGELOG.md#12110-beta2-2021-03-29)
- Update `azure-storage-blob` to version `12.11.0-beta.2`

### Resource Management - Cosmos DB 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cosmos_2.3.0/sdk/resourcemanager/azure-resourcemanager-cosmos/CHANGELOG.md#230-2021-03-30)
- Updated `api-version` to `2021-03-15`
- Removed `PrivateEndpointConnectionAutoGenerated` and `PrivateLinkServiceConnectionStatePropertyAutoGenerated`, they are duplicate class of `PrivateEndpointConnection` and `PrivateLinkServiceConnectionStateProperty`, respectively.

### Azure Spring Boot AutoConfigure 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot_3.3.0/sdk/spring/azure-spring-boot/CHANGELOG.md#330-2021-03-22)
#### New Features
Updated to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

#### Key Bug Fixes
- Fix bug of using closed `MessageProducer` and `MessageConsumer` when a link is force detached in azure-spring-boot-starter-servicebus-jms.

#### New Features
- Support creating `GrantedAuthority` by "roles" claim of id-token for web application in azure-spring-boot-starter-active-directory.

### Azure Spring Cloud Starter Storage Queue 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-storage-queue_2.3.0/sdk/spring/azure-spring-cloud-starter-storage-queue/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Core 1.14.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core_1.14.1/sdk/core/azure-core/CHANGELOG.md#1141-2021-03-19)
#### Bug Fixes

- Fix a bug where `ClassNotFoundException` or `MethodNotFoundException` was thrown when Jackson 2.11 is resolved
  instead of Jackson 2.12. [#19897](https://github.com/Azure/azure-sdk-for-java/issues/19897)

### Resource Management 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager_2.3.0/sdk/resourcemanager/azure-resourcemanager/CHANGELOG.md#230-2021-03-30)
- Added client-side validation for `getByResourceGroup`, `listByResourceGroup`, `deleteByResourceGroup` methods.

### Storage - Files Shares 12.9.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-share_12.9.0-beta.2/sdk/storage/azure-storage-file-share/CHANGELOG.md#1290-beta2-2021-03-29)
- Updated azure-storage-common and azure-core dependencies.

### Resource Management - Private DNS 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-privatedns_2.3.0/sdk/resourcemanager/azure-resourcemanager-privatedns/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Storage - Blobs Batch 12.9.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob-batch_12.9.0-beta.2/sdk/storage/azure-storage-blob-batch/CHANGELOG.md#1290-beta2-2021-03-29)
- Update `azure-storage-blob` to version `12.11.0-beta.2`

### Resource Management - Network 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-network_2.3.0/sdk/resourcemanager/azure-resourcemanager-network/CHANGELOG.md#230-2021-03-30)
- Supported `PrivateEndpoint` and `PrivateDnsZone`

### Resource Management - Content Delivery Network 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cdn_2.3.0/sdk/resourcemanager/azure-resourcemanager-cdn/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Storage - Blobs 12.10.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.10.2/sdk/storage/azure-storage-blob/CHANGELOG.md#12102-2021-03-26)
- Fixed a bug where BlobInputStream would not use request conditions when doing the initial getProperties call in openInputStream.

### Resource Management - Change Analysis 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-changeanalysis_1.0.0-beta.1/sdk/changeanalysis/azure-resourcemanager-changeanalysis/CHANGELOG.md#100-beta1-2021-03-26)
- Azure Resource Manager AzureChangeAnalysis client library for Java. This package contains Microsoft Azure SDK for AzureChangeAnalysis Management SDK.  Package tag package-2021-04-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Spring Cloud Integration Core 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-core_2.3.0/sdk/spring/azure-spring-integration-core/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Integration` [5.4.4](https://github.com/spring-projects/spring-integration/releases/tag/v5.4.4).

### Azure Spring Boot Starter Key Vault Secrets 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-keyvault-secrets_3.3.0/sdk/spring/azure-spring-boot-starter-keyvault-secrets/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Storage - Files Data Lake 12.4.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-datalake_12.4.1/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1241-2021-03-19)
- Updated `azure-storage-blob` version to `12.10.1` to pickup fixes for blob output stream.

### Resource Management - Resource Graph 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resourcegraph_1.0.0-beta.1/sdk/resourcegraph/azure-resourcemanager-resourcegraph/CHANGELOG.md#100-beta1-2021-03-24)
- Azure Resource Manager ResourceGraph client library for Java. This package contains Microsoft Azure SDK for ResourceGraph Management SDK. Azure Resource Graph API Reference. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).
- Azure Resource Manager ResourceGraph client library for Java. This package contains Microsoft Azure SDK for ResourceGraph Management SDK. Azure Resource Graph API Reference. Package tag package-2019-04. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Container Instances 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerinstance_2.3.0/sdk/resourcemanager/azure-resourcemanager-containerinstance/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Spring Boot Starter Storage 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-storage_3.3.0/sdk/spring/azure-spring-boot-starter-storage/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Core Serializer Jackson JSON 1.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-json-jackson_1.2.1/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#121-2021-03-19)
#### Bug Fixes

- Fix a bug where `ClassNotFoundException` or `MethodNotFoundException` was thrown when Jackson 2.11 is resolved
  instead of Jackson 2.12. [#19897](https://github.com/Azure/azure-sdk-for-java/issues/19897)

### Storage - Common 12.11.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-common_12.11.0-beta.2/sdk/storage/azure-storage-common/CHANGELOG.md#12110-beta2-2021-03-29)
- Update `azure-core` to version `1.14.1`

### Cosmos DB 4.13.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos_4.13.1/sdk/cosmos/azure-cosmos/CHANGELOG.md#4131-2021-03-22)
##### Key Bug Fixes
* Fixed issue preventing recovery from 410 status code and 0 sub status code due to stale Gateway caches when threads in parallel scheduler are starved.
* Fixed warning caused because of afterburner module usage in `CosmosDiagnostics`.
* Query performance improvements.

### Resource Management - Service Bus 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-servicebus_2.3.0/sdk/resourcemanager/azure-resourcemanager-servicebus/CHANGELOG.md#230-2021-03-30)
- Updated `api-version` to `2017-04-01`
- Parameter of `regenerateKey` method changed from `Policykey` to `KeyType`
- Removed class `Policykey`, use `RegenerateKeysParameters` class instead
- Class `SkuName`, `SkuTier`, `UnavailableReason` changed to enum

### Azure Spring Cloud Storage 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-storage_2.3.0/sdk/spring/azure-spring-cloud-storage/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Resource Management - Event Hubs 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventhubs_2.3.0/sdk/resourcemanager/azure-resourcemanager-eventhubs/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Container Registry 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerregistry_2.3.0/sdk/resourcemanager/azure-resourcemanager-containerregistry/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### azure-cosmos-spark_3-1_2-12 4.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos-spark_3-1_2-12_4.0.0-beta.1/sdk/cosmos/azure-cosmos-spark_3-1_2-12/CHANGELOG.md#400-beta1-2021-03-22)
* Cosmos DB Spark 3.1.1 Connector Preview `4.0.0-beta.1` Release.
#### Features
* Supports Spark 3.1.1 and Scala 2.12.
* Integrated against Spark3 DataSourceV2 API.
* Devloped ground up using Cosmos DB Java V4 SDK.
* Added support for Spark Query, Write, and Streaming.
* Added support for Spark3 Catalog metadata APIs.
* Added support for Java V4 Throughput Control.
* Added support for different partitioning strategies.
* Integrated against Cosmos DB TCP protocol.
* Added support for Databricks automated Maven Resolver.
* Added support for broadcasting CosmosClient caches to reduce bootstrapping RU throttling.
* Added support for unified jackson ObjectNode to SparkRow Converter.
* Added support for Raw Json format.
* Added support for Config Validation.
* Added support for Spark application configuration consolidation.
* Integrated against Cosmos DB FeedRange API to support Partition Split Proofing.
* Automated CI testing on DataBricks and Cosmos DB live endpoint.
* Automated CI Testing on Cosmos DB Emulator.

#### Known limitations
* Spark structured streaming (micro batches) for consuming change feed has been implemented but not tested end-to-end fully so is considered experimental at this point.
* No support for continuous processing (change feed) yet.
* No perf tests / optimizations have been done yet - we will iterate on perf in the next preview releases. So usage should be limited to non-production environments with this preview.

### Storage - Queues 12.9.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-queue_12.9.0-beta.2/sdk/storage/azure-storage-queue/CHANGELOG.md#1290-beta2-2021-03-29)
- Updated azure-storage-common and azure-core dependencies.

#### Support for binary data, custom shapes and Base64 encoding
This release adds a convenient way to send and receive binary data and custom shapes as a payload.
Additionally, support for Base64 encoding in HTTP requests and responses has been added that makes interoperability with V11 and prior Storage SDK easier to implement.

The `QueueClient.sendMessage` and `QueueAsyncClient.sendMessage` consume `com.azure.core.util.BinaryData` in addition to `String`.
`QueueMessageItem` and `PeekedMessageItem` expose new property `getBody()` of `com.azure.core.util.BinaryData` type to access message payload and should be used instead of `getMessageText()`.

See [BinaryData](https://docs.microsoft.com/java/api/com.azure.core.util.binarydata?view=azure-java-stable) for more information about handling `String`, binary data and custom shapes.

##### Receiving message as string
Before:
```java
QueueMessageItem message = queueClient.receiveMessage();
String messageText = message.getMessageText();
```

After:
```java
QueueMessageItem message = queueClient.receiveMessage();
BinaryData body = message.getBody();
String messageText = body.toString();
```

### azure-iot-modelsrepository 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-iot-modelsrepository_1.0.0-beta.1/sdk/modelsrepository/azure-iot-modelsrepository/CHANGELOG.md#100-beta1-2021-03-30)
#### New features

- Initial preview of Azure Models Repository SDK

#### Breaking changes

- N/A

#### Added

- N/A

#### Fixes and improvements

- N/A

### Azure Communication Chat 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-chat_1.0.0/sdk/communication/azure-communication-chat/CHANGELOG.md#100-2021-03-29)
#### Breaking Changes

- Renamed `ChatThread` to `ChatThreadProperties`
- Renamed `ChatThreadInfo` to `ChatThreadItem`
- Renamed `repeatabilityRequestId` to `idempotencyToken`
- SendMessage returns `SendChatMessageResult` instead of string ID
- Renamed `CommunicationError` to `ChatError`
- Renamed `CommunicationErrorResponse` to `ChatErrorResponse`
- Moved `getChatThread` to `ChatThreadClient` and renamed to `getProperties`
- Removed `AddChatParticipantsOptions`
- Changed `addParticipants` to take `Iterable<ChatParticipant>` instead of `AddChatParticipantsOptions`
- Added `context` parameter to the max overloads of `listParticipants`, `listReadReceipts`
- `CreateChatThreadOptions` constructor now requires `topic`
- Removed `setTopic` from `CreateChatThreadOptions`

#### Added

- Added `ChatThreadClientBuilder`

### Azure Communication Common 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-common_1.0.0/sdk/communication/azure-communication-common/CHANGELOG.md#100-2021-03-29)
#### Breaking Changes
- Updated `CommunicationCloudEnvironment(String environmentValue)` constructor to `CommunicationCloudEnvironment()`.
- Updated `public CommunicationCloudEnvironment fromString(String environmentValue)` to `public static CommunicationCloudEnvironment fromString(String environmentValue)`.
- Renamed `TokenRefresher.getTokenAsync()` to `TokenRefresher.getToken()`.

### Azure Communication Identity 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-identity_1.0.0/sdk/communication/azure-communication-identity/CHANGELOG.md#100-2021-03-29)
Updated `azure-communication-identity` version

### Azure Communication SMS 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-sms_1.0.0/sdk/communication/azure-communication-sms/CHANGELOG.md#100-2021-03-29)
Updated `azure-communication-sms` version

### Resource Management - Communication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-communication_1.0.0/sdk/communication/azure-resourcemanager-communication/CHANGELOG.md#100-2021-04-08)
- Azure Resource Manager Communication client library for Java. This package contains Microsoft Azure SDK for Communication Management SDK. REST API for Azure Communication Services. Package tag package-2020-08-20. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.ErrorAdditionalInfo` was removed

### Azure Communication Phone Numbers 1.0.0-beta.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-communication-phonenumbers_1.0.0-beta.7/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100-beta7-2021-03-29)
#### Added
- Added `PollerFlux<PhoneNumberOperation, PhoneNumberSearchResult> beginSearchAvailablePhoneNumbers(String countryCode, PhoneNumberType phoneNumberType, PhoneNumberAssignmentType assignmentType, PhoneNumberCapabilities capabilities)` in PhoneNumbersAsyncClient.
- Added `PagedIterable<PurchasedPhoneNumber> listPurchasedPhoneNumbers()` in PhoneNumbersClient.
- Added `SyncPoller<PhoneNumberOperation, PhoneNumberSearchResult> beginSearchAvailablePhoneNumbers(String countryCode, PhoneNumberType phoneNumberType, PhoneNumberAssignmentType assignmentType, PhoneNumberCapabilities capabilities)` in PhoneNumbersClient.
- Added `SyncPoller<PhoneNumberOperation, PurchasePhoneNumbersResult> beginPurchasePhoneNumbers(String searchId)` in PhoneNumbersClient.
- Added `SyncPoller<PhoneNumberOperation, ReleasePhoneNumberResult> beginReleasePhoneNumber(String phoneNumber)` in PhoneNumbersClient.
- Added `SyncPoller<PhoneNumberOperation, PurchasedPhoneNumber> beginUpdatePhoneNumberCapabilities(String phoneNumber, PhoneNumberCapabilities capabilities)` in PhoneNumbersClient.
- Added `PurchasePhoneNumbersResult`.
- Added `ReleasePhoneNumbersResult`.

#### Breaking Changes
- Renamed AcquiredPhoneNumber to PurchasedPhoneNumber.
- Renamed PhoneNumbersAsyncClient.getPhoneNumber and PhoneNumbersClient.getPhoneNumber to PhoneNumbersAsyncClient.getPurchasedPhoneNumber and PhoneNumbersClient.getPurchasedPhoneNumber.
- Renamed PhoneNumbersAsyncClient.getPhoneNumberWithResponse and PhoneNumbersClient.getPhoneNumberWithResponse to
PhoneNumbersAsyncClient.getPurchasedPhoneNumberWithResponse and PhoneNumbersClient.getPurchasedPhoneNumberWithResponse.
- Renamed PhoneNumbersAsyncClient.listPhoneNumbers and PhoneNumbersClient.listPhoneNumbers to PhoneNumbersAsyncClient.listPurchasedPhoneNumbers and PhoneNumbersClient.listPurchasedPhoneNumbers.
- Updated `PollerFlux<PhoneNumberOperation, Void> beginPurchasePhoneNumbers` to `PollerFlux<PhoneNumberOperation, PurchasePhoneNumbersResult> beginPurchasePhoneNumbers` in PhoneNumbersAsyncClient.
- Updated `PollerFlux<PhoneNumberOperation, Void> beginReleasePhoneNumber` to `public PollerFlux<PhoneNumberOperation, ReleasePhoneNumberResult> beginReleasePhoneNumber` in PhoneNumbersAsyncClient.
- Updated `SyncPoller<PhoneNumberOperation, Void> beginPurchasePhoneNumbers` to ` SyncPoller<PhoneNumberOperation, PurchasePhoneNumbersResult> beginPurchasePhoneNumbers` in PhoneNumbersClient.
- Updated `SyncPoller<PhoneNumberOperation, Void> beginReleasePhoneNumber` to `SyncPoller<PhoneNumberOperation, ReleasePhoneNumberResult> beginReleasePhoneNumber` in PhoneNumbersClient.
- Updated `PollerFlux<PhoneNumberOperation, PurchasedPhoneNumber> beginUpdatePhoneNumberCapabilities(String phoneNumber, PhoneNumberCapabilitiesRequest capabilitiesUpdateRequest)` to `PollerFlux<PhoneNumberOperation, PurchasedPhoneNumber> beginUpdatePhoneNumberCapabilities(String phoneNumber, PhoneNumberCapabilities capabilities)`.
- Updated `SyncPoller<PhoneNumberOperation, PurchasedPhoneNumber> beginUpdatePhoneNumberCapabilities(String phoneNumber, PhoneNumberCapabilitiesRequest capabilitiesUpdateRequest)` to `SyncPoller<PhoneNumberOperation, PurchasedPhoneNumber> beginUpdatePhoneNumberCapabilities(String phoneNumber, PhoneNumberCapabilities capabilities)`.
- Removed `CommunicationError`.
- Removed `PhoneNumberCapabilitiesRequest`.
- Moved `ReservationStatus` to the `models` folder.

### Resource Management - Communication 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-communication_1.0.0-beta.1/sdk/communication/azure-resourcemanager-communication/CHANGELOG.md#100-beta1-2021-03-23)
- Azure Resource Manager Communication client library for Java. This package contains Microsoft Azure SDK for Communication Management SDK. REST API for Azure Communication Services. Package tag package-2020-08-20. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Spring Boot Starter Active Directory B2C 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-active-directory-b2c_3.3.0/sdk/spring/azure-spring-boot-starter-active-directory-b2c/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Security` [5.4.5](https://github.com/spring-projects/spring-security/releases/tag/5.4.5).

### Storage - Blobs 12.11.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.11.0-beta.2/sdk/storage/azure-storage-blob/CHANGELOG.md#12110-beta2-2021-03-29)
- Fixed a bug where downloading would throw a NPE on large downloads due to a lack of eTag.
- Fixed a bug where more data would be buffered in buffered upload than expected due to Reactor's concatMap operator.
- Added upload and download methods on BlobClient and BlobAsyncClient that work with BinaryData.
- Fixed a bug that ignored the page size when calling PagedIterable.byPage(pageSize)

### Resource Management - Spring Cloud 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appplatform_2.3.0/sdk/resourcemanager/azure-resourcemanager-appplatform/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Identity Spring 1.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-identity-spring_1.3.0/sdk/spring/azure-identity-spring/CHANGELOG.md#130-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Resource Management - App Service 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appservice_2.3.0/sdk/resourcemanager/azure-resourcemanager-appservice/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - DNS 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-dns_2.3.0/sdk/resourcemanager/azure-resourcemanager-dns/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Spring Cloud Integration Test 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-test_2.3.0/sdk/spring/azure-spring-integration-test/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Integration` [5.4.4](https://github.com/spring-projects/spring-integration/releases/tag/v5.4.4).

### Resource Management - Datadog 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-datadog_1.0.0-beta.2/sdk/datadog/azure-resourcemanager-datadog/CHANGELOG.md#100-beta2-2021-03-30)
- Azure Resource Manager MicrosoftDatadog client library for Java. This package contains Microsoft Azure SDK for MicrosoftDatadog Management SDK.  Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### New Feature

##### `models.DatadogMonitorResource` was modified

* `systemData()` was added

##### `models.DatadogSingleSignOnResource` was modified

* `systemData()` was added

##### `models.MonitoringTagRules` was modified

* `systemData()` was added

##### `models.DatadogAgreementResource` was modified

* `systemData()` was added

### Resource Management - Authorization 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-authorization_2.3.0/sdk/resourcemanager/azure-resourcemanager-authorization/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Container Service 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerservice_2.3.0/sdk/resourcemanager/azure-resourcemanager-containerservice/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Spring Cloud Integration Event Hubs 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-eventhubs_2.3.0/sdk/spring/azure-spring-integration-eventhubs/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Integration` [5.4.4](https://github.com/spring-projects/spring-integration/releases/tag/v5.4.4).

### Azure Spring Cloud Integration Service Bus 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-servicebus_2.3.0/sdk/spring/azure-spring-integration-servicebus/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Integration` [5.4.4](https://github.com/spring-projects/spring-integration/releases/tag/v5.4.4).

### Azure Spring Cloud Starter Cache 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-cache_2.3.0/sdk/spring/azure-spring-cloud-starter-cache/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Resource Management - Managed Service Identity 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-msi_2.3.0/sdk/resourcemanager/azure-resourcemanager-msi/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Key Vault - JCA 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-jca_1.0.0-beta.5/sdk/keyvault/azure-security-keyvault-jca/CHANGELOG.md#100-beta5-2021-03-22)


### Azure Spring Cloud Stream Binder Service bus Queue 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-servicebus-queue_2.3.0/sdk/spring/azure-spring-cloud-stream-binder-servicebus-queue/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Support setting service-bus message-id ([#20005](https://github.com/Azure/azure-sdk-for-java/issues/20005)).

### Azure Spring Boot Starter Cosmos 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-cosmos_3.3.0/sdk/spring/azure-spring-boot-starter-cosmos/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `azure-spring-data-cosmos` [3.5.0](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/cosmos/azure-spring-data-cosmos/CHANGELOG.md#350-2021-03-11)

### Azure Spring Cloud Stream Binder Service bus Topic 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-servicebus-topic_2.3.0/sdk/spring/azure-spring-cloud-stream-binder-servicebus-topic/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Support setting service-bus message-id ([#20005](https://github.com/Azure/azure-sdk-for-java/issues/20005)).

### Storage - Files Data Lake 12.5.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-file-datalake_12.5.0-beta.2/sdk/storage/azure-storage-file-datalake/CHANGELOG.md#1250-beta2-2021-03-29)
- Fixed a bug where files/directories in root directories could not be renamed.
- Fixed a bug where more data would be buffered in buffered upload than expected due to Reactor's concatMap operator.

### Storage - Blobs 12.10.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-blob_12.10.1/sdk/storage/azure-storage-blob/CHANGELOG.md#12101-2021-03-19)
- Removed a deep copy in the general upload path to reduce memory consumption and increase perf
- Added a deep copy immediately after calling BlobOutputStream.write to prevent overwriting data in the case of reusing a single buffer to write to an output stream

### Azure Spring Boot Starter Key Vault Certificates 3.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-keyvault-certificates_3.0.0-beta.5/sdk/spring/azure-spring-boot-starter-keyvault-certificates/CHANGELOG.md#300-beta5-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Resource Management - SQL 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-sql_2.3.0/sdk/resourcemanager/azure-resourcemanager-sql/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Redis 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redis_2.3.0/sdk/resourcemanager/azure-resourcemanager-redis/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Azure Spring Cloud Context 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-context_2.3.0/sdk/spring/azure-spring-cloud-context/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Storage - Common 12.10.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-storage-common_12.10.1/sdk/storage/azure-storage-common/CHANGELOG.md#12101-2021-03-19)
- Removed a deep copy in PayloadSizeGate

### Azure Spring Cloud Stream Binder Test 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-test_2.3.0/sdk/spring/azure-spring-cloud-stream-binder-test/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Azure Spring Cloud Starter Event Hubs Kafka 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-eventhubs-kafka_2.3.0/sdk/spring/azure-spring-cloud-starter-eventhubs-kafka/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Resource Management - Delegated Network 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-delegatednetwork_1.0.0-beta.1/sdk/delegatednetwork/azure-resourcemanager-delegatednetwork/CHANGELOG.md#100-beta1-2021-03-26)
- Azure Resource Manager DelegatedNetwork client library for Java. This package contains Microsoft Azure SDK for DelegatedNetwork Management SDK. DNC web api provides way to create, get and delete dnc controller. Package tag package-2021-03-15. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Spring Cloud Integration Storage Queue 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-integration-storage-queue_2.3.0/sdk/spring/azure-spring-integration-storage-queue/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
- Upgrade to `Spring Integration` [5.4.4](https://github.com/spring-projects/spring-integration/releases/tag/v5.4.4).

### Resource Management - Compute 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-compute_2.3.0/sdk/resourcemanager/azure-resourcemanager-compute/CHANGELOG.md#230-2021-03-30)
- Updated `api-version` to `2021-03-01`
- Corrected class type for `EncryptionImages`, `GalleryImageVersionStorageProfile`, `GalleryImageVersionUpdate`, `ImageDataDisk`, `ManagedDiskParameters`, `VirtualMachineScaleSetManagedDiskParameters`

### Azure Spring Cloud Stream Binder Service bus Core 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-stream-binder-servicebus-core_2.3.0/sdk/spring/azure-spring-cloud-stream-binder-servicebus-core/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Spring Data Cosmos 3.5.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-data-cosmos_3.5.1/sdk/cosmos/azure-spring-data-cosmos/CHANGELOG.md#351-2021-03-24)
##### Key Bug Fixes
* Updated `azure-cosmos` to hotfix version 4.13.1.

### Azure Spring Cloud Starter Service bus 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-starter-servicebus_2.3.0/sdk/spring/azure-spring-cloud-starter-servicebus/CHANGELOG.md#230-2021-03-22)
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Azure Spring Boot Starter Service bus Jms 3.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot-starter-servicebus-jms_3.3.0/sdk/spring/azure-spring-boot-starter-servicebus-jms/CHANGELOG.md#330-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).
#### Key Bug Fixes
- Fix bug of using closed `MessageProducer` and `MessageConsumer` when a link is force detached.

### Azure Spring Cloud Telemetry 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-cloud-telemetry_2.3.0/sdk/spring/azure-spring-cloud-telemetry/CHANGELOG.md#230-2021-03-22)
#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

### Core - Test 1.6.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-test_1.6.1/sdk/core/azure-core-test/CHANGELOG.md#161-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Core 1.15.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core_1.15.0/sdk/core/azure-core/CHANGELOG.md#1150-2021-04-02)
#### New Features

- Added `Binary.toByteBuffer` which returns a read-only view of the `BinaryData`.
- Added `ProxyOptions.fromConfiguration(Configuration, boolean)` which allows for configuring if the returned proxy
  is resolved.
- Added a default `JsonSerializer` implementation which is optionally used when creating a `JsonSerializer` with
  `JsonSerializerProviders` by passing the flag `useDefaultIfAbset`.
- Added the ability to configure HTTP logging level without making code changes by configuring environment property
  `AZURE_HTTP_LOG_DETAIL_LEVEL`.
- Added constructor overloads to `PagedFlux` which allows for the paging implements to consume the `byPage` page size value.
- Added `AzureNamedKey` and `AzureNamedKeyCredential` to support authentication using a named key.
- Added overloads to `SerializerAdapter` which use `byte[]` instead of `String` or `InputStream`/`OutputStream`.

#### Bug Fixes

- Fixed a bug where Unix timestamps were not being properly deserialized to `OffsetDateTime`.
- Fixed edge cases where response bodies would be eagerly read into a `byte[]` when they shouldn't.

#### Dependency Updates

- Upgraded Jackson from `2.12.1` to `2.12.2`.
- Upgraded Netty from `4.1.59.Final` to `4.1.60.Final`.

### Core Experimental 1.0.0-beta.12 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-experimental_1.0.0-beta.12/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta12-2021-04-02)
#### New Features

- Added positional coordinate getter to `GeoBoundingBox`.
- Overloaded `toString` for `GeoBoundingBox` and `GeoPosition`.
- Added `getOuterRing` to `GeoPolygon`.
- Added `DynamicRequest` and `DynamicResponse` to enable making REST API calls without a service client.

#### Breaking Changes

- Removed `GeoArray` from public API.
- Changed `GeoBoundingBox` constructor to use `double` instead of `Double` when including altitude values.
- Renamed `GeoLine` to `GeoLineString` and `GeoLineCollection` to `GeoLineStringCollection`.
- Changed `getCoordinates` of `GeoLineString` and `GeoLinearRing` to return `List` instead of `GeoArray`.
- Removed `getCoordinates` from `GeoLineStringCollection`, `GeoPointCollection`, `GeoPolygon`, and `GeoPolygonCollection`.

#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Core Serializer Apache Avro 1.0.0-beta.9 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-avro-apache_1.0.0-beta.9/sdk/core/azure-core-serializer-avro-apache/CHANGELOG.md#100-beta9-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Management - Core 1.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-management_1.2.1/sdk/core/azure-core-management/CHANGELOG.md#121-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Tracing OpenTelemetry Plugin 1.0.0-beta.9 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-tracing-opentelemetry_1.0.0-beta.9/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta9-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Core Serializer GSON JSON 1.1.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-json-gson_1.1.1/sdk/core/azure-core-serializer-json-gson/CHANGELOG.md#111-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Core Serializer Jackson JSON 1.2.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-json-jackson_1.2.2/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#122-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.1` to `1.15.0`.

### Core - HTTP OkHttp 1.6.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-http-okhttp_1.6.1/sdk/core/azure-core-http-okhttp/CHANGELOG.md#161-2021-04-02)
#### Bug Fixes

- Fixed a bug where a proxy's address is only resolved during construction of the client, now it is resolved per connection. [#19497](https://github.com/Azure/azure-sdk-for-java/issues/19497)

#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

### Form Recognizer 3.1.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-formrecognizer_3.1.0-beta.3/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310-beta3-2021-04-06)
- Defaults to the latest supported API version, which currently is `2.1-preview.3`.
- Added property `Pages` to `RecognizeReceiptsOptions`, `RecognizeInvoicesOptions`, `RecognizeBusinessCardsOptions`
  and `RecognizeCustomFormOptions` to specify the page numbers to analyze.
- Added support for `FormContentType` `image/bmp` when analyzing custom forms.
- Added support for pre-built ID documents recognition.
- Added property `ReadingOrder` to `RecognizeContentOptions` to specify the order in which recognized text lines are returned.

### Text Analytics 5.0.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_5.0.5/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#505-2021-04-06)
#### Dependency updates
- Update dependency version, `azure-core` to 1.15.0 and `azure-core-http-netty` to 1.9.1.

### Cognitive Search 11.4.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-search-documents_11.4.0-beta.1/sdk/search/azure-search-documents/CHANGELOG.md#1140-beta1-2021-04-06)
#### New Features

- Clients now default to using service version `2020-06-30-Preview`.
- Added support for `Edm.GeographyPoint` in `FieldBuilder` when property has type `GeoPoint`.
- Added support for geography based filtering in `SearchFilter` when `GeoPosition`, `GeoPoint`, `GeoLineString`, or
  `GeoPolygon` are used as formatting arguments.
- Added support for Normalizers in `SearchField` and `SearchIndex` with `CustomNormalizer` and `LexicalNormalizer`.
- Added new skills `CustomEntityLookupSkill` and `DocumentExtractionSkill` and new skill versions for 
  `KeyPhraseExtractionSkill` and `LanguageDetectionSkill`.
- Added support for the ADLS Gen 2 Indexer data source type.
- Added skillset counts to `SearchServiceCounters`.  
- Added additional log messages to `SearchIndexingBufferedSender` and `SearchIndexingBufferedAsyncSender`.

#### Dependency Updates

- Updated `azure-core` from `1.14.0` to `1.15.0`.
- Updated Jackson from `2.12.1` to `2.12.2`.

#### Breaking Changes

- Updated Jackson annotations to include `required = true` when service must receive or return the property.

### Cosmos DB 4.14.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos_4.14.0/sdk/cosmos/azure-cosmos/CHANGELOG.md#4140-2021-04-06)
##### New Features
* General Availability for `readMany()` API in `CosmosAsyncContainer` and `CosmosContainer`.
* General Availability for `handle()` API in `CosmosPagedFlux` and `CosmosPagedIterable`.
* Upgraded Jackson to patch version 2.12.2.
* Exposed `getDocumentUsage` and `getDocumentCountUsage()` APIs in `FeedResponse` to retrieve document count metadata.

##### Key Bug Fixes
* Allowed `CosmosPagedFlux#handle()` and `CosmosPagedIterable#handle()` API for chaining.
* Removed `AfterBurner` module usage from `CosmosException` causing the warning logs.
* Fixed issue of duplicate processing of items on the same Change Feed Processor instance.
* Return `RequestTimeoutException` on client side timeout for write operations.

### Text Analytics 5.1.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-textanalytics_5.1.0-beta.6/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510-beta6-2021-04-06)
#### Breaking changes
- Removed the input parameter `Context` from non-max-overload healthcare synchronous API, `beginAnalyzeHealthcareEntities()`.

### Synapse - AccessControl 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-accesscontrol_1.0.0-beta.3/sdk/synapse/azure-analytics-synapse-accesscontrol/CHANGELOG.md#100-beta3-2021-04-06)
#### Breaking Changes
- `listRoleAssignmentsWithResponse()` now returns `RoleAssignmentsListRoleAssignmentsResponse`

#### Dependency Updates
- Update azure-core to 1.15.0

### Synapse - Monitoring 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-monitoring_1.0.0-beta.3/sdk/synapse/azure-analytics-synapse-monitoring/CHANGELOG.md#100-beta3-2021-04-06)
#### Dependency Updates
- Update azure-core to 1.15.0

### Spring Data Cosmos 3.6.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-data-cosmos_3.6.0/sdk/cosmos/azure-spring-data-cosmos/CHANGELOG.md#360-2021-04-06)
##### New Features
* Updated `azure-cosmos` to version 4.14.0.

### Synapse - Spark 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-spark_1.0.0-beta.3/sdk/synapse/azure-analytics-synapse-spark/CHANGELOG.md#100-beta3-2021-04-06)
#### Breaking Changes
- Remove `SparkServiceVersion` class

#### Dependency Updates
- Update azure-core to 1.15.0

### Synapse - Managed Private Endpoints 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-managedprivateendpoints_1.0.0-beta.3/sdk/synapse/azure-analytics-synapse-managedprivateendpoints/CHANGELOG.md#100-beta3-2021-04-06)
#### Dependency Updates
- Update azure-core to 1.15.0

### Synapse - Artifacts 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-analytics-synapse-artifacts_1.0.0-beta.4/sdk/synapse/azure-analytics-synapse-artifacts/CHANGELOG.md#100-beta4-2021-04-06)
#### New Features
- Update with Azure Data Factory(ADF) swagger changes/2019-06-01-preview

#### Breaking Changes
- `DataFlowDebugSessionClient#createDataFlowDebugSessionWithResponse()` now returns `DataFlowDebugSessionsCreateDataFlowDebugSessionResponse`
- `DataFlowDebugSessionClient#executeCommandWithResponse()` now returns `DataFlowDebugSessionsExecuteCommandResponse`
- `LibraryAsyncClient#getOperationResultWithResponse()` now returns `Mono<Response<LibraryResource>>`
- `LibraryAsyncClient#getOperationResult()` now returns `Mono<Response<LibraryResource>>`
- `LibraryClient#getOperationResultWithResponse()` now returns `Response<LibraryResource>`
- `LibraryClient#getOperationResult()` now returns `Response<LibraryResource>`
- `AvroDataset.avroCompressionCodec` property is now of type `Object`
- `CommonDataServiceForAppsLinkedService.servicePrincipalCredentialType` property is now of type `Object`
- `DatasetDeflateCompression.level` property is now of type `Object`
- `DatasetGZipCompression.level` property is now of type `Object`
- `DatasetZipDeflateCompression.level` property is now of type `Object`
- `DelimitedTextDataset.compressionCoded` property is now of type `CompressionCodec`
- `DelimitedTextDataset.compressionLevel` property is now of type `Object`
- `DynamicsCrmLinkedService.servicePrincipalCredentialType` property is now of type `Object`
- `DynamicsLinkedService.hostName` property is now of type `Object`
- `DynamicsLinkedService.port` property is now of type `Object`
- `DynamicsLinkedService.serviceUri` property is now of type `Object`
- `DynamicsLinkedService.organizationName` property is now of type `Object`
- `ParquetDataset.compressionCodec` property is now of type `Object`
- `RerunTumblingWindowTrigger.maxCurrency` property is renamed to `rerunCurrency`
- `WaitActivity.waitTimeInSeconds` property is now of type `Object`

#### Dependency Updates
- Update azure-core to 1.15.0

### azure-resourcemanager-synapse 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-synapse_1.0.0-beta.1/sdk/synapse/azure-resourcemanager-synapse/CHANGELOG.md#100-beta1-2021-04-07)
- Azure Resource Manager Synapse client library for Java. This package contains Microsoft Azure SDK for Synapse Management SDK. Azure Synapse Analytics Management Client. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Cost Management 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-costmanagement_1.0.0-beta.2/sdk/costmanagement/azure-resourcemanager-costmanagement/CHANGELOG.md#100-beta2-2021-04-07)
- Azure Resource Manager CostManagement client library for Java. This package contains Microsoft Azure SDK for CostManagement Management SDK.  Package tag package-2019-11. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.ReportConfigFilterAutoGenerated` was removed

* `models.ExportTimePeriod` was removed

* `models.ExportDatasetConfiguration` was removed

* `models.ForecastDataset` was removed

* `models.ReportConfigDatasetAutoGenerated` was removed

* `models.ExportDataset` was removed

##### `models.View$Update` was modified

* `withDataset(models.ReportConfigDataset)` was removed

##### `models.View` was modified

* `dataset()` was removed

##### `models.Export` was modified

* `nextRunTimeEstimate()` was removed
* `runHistory()` was removed

##### `models.ExportExecution` was modified

* `models.ExecutionType executionType()` -> `models.ExecutionType executionType()`
* `models.CommonExportProperties runSettings()` -> `models.CommonExportProperties runSettings()`
* `java.lang.String fileName()` -> `java.lang.String fileName()`
* `java.lang.String submittedBy()` -> `java.lang.String submittedBy()`
* `etag()` was removed
* `java.time.OffsetDateTime processingStartTime()` -> `java.time.OffsetDateTime processingStartTime()`
* `models.ExecutionStatus status()` -> `models.ExecutionStatus status()`
* `type()` was removed
* `error()` was removed
* `java.time.OffsetDateTime submittedTime()` -> `java.time.OffsetDateTime submittedTime()`
* `name()` was removed
* `id()` was removed
* `java.time.OffsetDateTime processingEndTime()` -> `java.time.OffsetDateTime processingEndTime()`
* `innerModel()` was removed

##### `models.ForecastDefinition` was modified

* `models.ForecastDataset dataset()` -> `models.QueryDataset dataset()`
* `withDataset(models.ForecastDataset)` was removed

##### `models.QueryFilter` was modified

* `dimension()` was removed
* `withTag(models.QueryComparisonExpression)` was removed
* `withNot(models.QueryFilter)` was removed
* `tag()` was removed
* `withDimension(models.QueryComparisonExpression)` was removed
* `not()` was removed

##### `models.Export$Update` was modified

* `withRunHistory(fluent.models.ExportExecutionListResultInner)` was removed

##### `models.ExportDefinition` was modified

* `withDataSet(models.ExportDataset)` was removed
* `withTimePeriod(models.ExportTimePeriod)` was removed
* `models.ExportTimePeriod timePeriod()` -> `models.QueryTimePeriod timePeriod()`
* `models.ExportDataset dataSet()` -> `models.QueryDatasetAutoGenerated dataSet()`

##### `models.View$Definition` was modified

* `withDataset(models.ReportConfigDataset)` was removed

##### `models.CommonExportProperties` was modified

* `models.ExportDefinition definition()` -> `models.ExportDefinition definition()`
* `innerModel()` was removed
* `runHistory()` was removed
* `models.ExportDeliveryInfo deliveryInfo()` -> `models.ExportDeliveryInfo deliveryInfo()`
* `nextRunTimeEstimate()` was removed
* `models.FormatType format()` -> `models.FormatType format()`

##### `models.Exports` was modified

* `listWithResponse(java.lang.String,java.lang.String,com.azure.core.util.Context)` was removed
* `getByIdWithResponse(java.lang.String,java.lang.String,com.azure.core.util.Context)` was removed
* `getWithResponse(java.lang.String,java.lang.String,java.lang.String,com.azure.core.util.Context)` was removed

##### `models.Export$Definition` was modified

* `withRunHistory(fluent.models.ExportExecutionListResultInner)` was removed

##### `models.ReportConfigFilter` was modified

* `withNot(models.ReportConfigFilter)` was removed
* `dimension()` was removed
* `tag()` was removed
* `not()` was removed
* `withDimension(models.ReportConfigComparisonExpression)` was removed
* `withTag(models.ReportConfigComparisonExpression)` was removed

##### `models.ExportProperties` was modified

* `withRunHistory(fluent.models.ExportExecutionListResultInner)` was removed
* `fluent.models.CommonExportPropertiesInner withFormat(models.FormatType)` -> `models.CommonExportProperties withFormat(models.FormatType)`
* `fluent.models.CommonExportPropertiesInner withDefinition(models.ExportDefinition)` -> `models.CommonExportProperties withDefinition(models.ExportDefinition)`
* `fluent.models.CommonExportPropertiesInner withDeliveryInfo(models.ExportDeliveryInfo)` -> `models.CommonExportProperties withDeliveryInfo(models.ExportDeliveryInfo)`
* `withRunHistory(fluent.models.ExportExecutionListResultInner)` was removed

#### New Feature

* `models.GenerateReservationDetailsReports` was added

* `models.GenerateReservationDetailsReportsByBillingProfileIdHeaders` was added

* `models.GenerateReservationDetailsReportsByBillingAccountIdResponse` was added

* `models.Status` was added

* `models.Setting` was added

* `models.GenerateReservationDetailsReportsByBillingAccountIdHeaders` was added

* `models.OperationStatusType` was added

* `models.QueryFilterAutoGenerated` was added

* `models.ProxySettingResource` was added

* `models.GenerateReservationDetailsReportsByBillingProfileIdResponse` was added

* `models.Settings` was added

* `models.SettingsListResult` was added

* `models.OperationStatus` was added

* `models.QueryDatasetAutoGenerated` was added

##### `CostManagementManager` was modified

* `settings()` was added
* `generateReservationDetailsReports()` was added

##### `models.View$Update` was modified

* `withDataSet(models.ReportConfigDataset)` was added

##### `models.View` was modified

* `currency()` was added
* `includeMonetaryCommitment()` was added
* `dataSet()` was added
* `dateRange()` was added

##### `models.Export` was modified

* `executeWithResponse(com.azure.core.util.Context)` was added
* `execute()` was added

##### `models.ExportExecution` was modified

* `withSubmittedBy(java.lang.String)` was added
* `tags()` was added
* `withSubmittedTime(java.time.OffsetDateTime)` was added
* `withExecutionType(models.ExecutionType)` was added
* `withRunSettings(models.CommonExportProperties)` was added
* `validate()` was added
* `withStatus(models.ExecutionStatus)` was added
* `withProcessingStartTime(java.time.OffsetDateTime)` was added
* `withFileName(java.lang.String)` was added
* `withProcessingEndTime(java.time.OffsetDateTime)` was added

##### `models.ForecastDefinition` was modified

* `withDataset(models.QueryDataset)` was added

##### `models.QueryFilter` was modified

* `withTags(models.QueryComparisonExpression)` was added
* `dimensions()` was added
* `withDimensions(models.QueryComparisonExpression)` was added
* `tags()` was added

##### `models.ExportDefinition` was modified

* `withTimePeriod(models.QueryTimePeriod)` was added
* `withDataSet(models.QueryDatasetAutoGenerated)` was added

##### `models.View$Definition` was modified

* `withDataSet(models.ReportConfigDataset)` was added

##### `models.CommonExportProperties` was modified

* `validate()` was added
* `withDeliveryInfo(models.ExportDeliveryInfo)` was added
* `withFormat(models.FormatType)` was added
* `withDefinition(models.ExportDefinition)` was added

##### `models.Exports` was modified

* `getWithResponse(java.lang.String,java.lang.String,com.azure.core.util.Context)` was added
* `getByIdWithResponse(java.lang.String,com.azure.core.util.Context)` was added
* `listWithResponse(java.lang.String,com.azure.core.util.Context)` was added

##### `models.ReportConfigFilter` was modified

* `tagKey()` was added
* `dimensions()` was added
* `withDimensions(models.ReportConfigComparisonExpression)` was added
* `tags()` was added
* `withTagKey(models.ReportConfigComparisonExpression)` was added
* `tagValue()` was added
* `withTags(models.ReportConfigComparisonExpression)` was added
* `withTagValue(models.ReportConfigComparisonExpression)` was added

##### `models.QueryResult` was modified

* `sku()` was added
* `etag()` was added
* `location()` was added
### azure-resourcemanager-resourcehealth 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resourcehealth_1.0.0-beta.1/sdk/resourcehealth/azure-resourcemanager-resourcehealth/CHANGELOG.md#100-beta1-2021-04-08)
- Azure Resource Manager ResourceHealth client library for Java. This package contains Microsoft Azure SDK for ResourceHealth Management SDK. The Resource Health Client. Package tag package-2018-07-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).


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
