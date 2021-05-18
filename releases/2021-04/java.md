---
title: Azure SDK for Java (April 2021)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

<!--
azure-resourcemanager-trafficmanager:2.3.0
azure-resourcemanager-monitor:2.3.0
azure-cosmos-spark_3-1_2-12:4.0.0-alpha.1
azure-resourcemanager-keyvault:2.3.0
azure-communication-sms:1.0.0
azure-resourcemanager-apimanagement:1.0.0-beta.1
azure-resourcemanager-search:2.3.0
azure-resourcemanager-storage:2.3.0
azure-resourcemanager-loganalytics:1.0.0-beta.2
azure-resourcemanager-resources:2.3.0
azure-resourcemanager-cosmos:2.3.0
azure-core:1.14.1
azure-resourcemanager:2.3.0
azure-resourcemanager-privatedns:2.3.0
azure-resourcemanager-network:2.3.0
azure-resourcemanager-cdn:2.3.0
azure-resourcemanager-changeanalysis:1.0.0-beta.1
azure-resourcemanager-communication:1.0.0-beta.1
azure-resourcemanager-resourcegraph:1.0.0-beta.1
azure-resourcemanager-containerinstance:2.3.0
azure-core-serializer-json-jackson:1.2.1
azure-cosmos:4.13.1
azure-resourcemanager-servicebus:2.3.0
azure-resourcemanager-eventhubs:2.3.0
azure-resourcemanager-containerregistry:2.3.0
azure-cosmos-spark_3-1_2-12:4.0.0-beta.1
azure-communication-phonenumbers:1.0.0-beta.7
azure-resourcemanager-appplatform:2.3.0
azure-resourcemanager-appservice:2.3.0
azure-resourcemanager-dns:2.3.0
azure-resourcemanager-datadog:1.0.0-beta.2
azure-resourcemanager-authorization:2.3.0
azure-resourcemanager-containerservice:2.3.0
azure-communication-chat:1.0.0
azure-communication-identity:1.0.0
azure-resourcemanager-msi:2.3.0
azure-resourcemanager-sql:2.3.0
azure-resourcemanager-redis:2.3.0
azure-resourcemanager-delegatednetwork:1.0.0-beta.1
azure-resourcemanager-compute:2.3.0
azure-communication-common:1.0.0
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
azure-resourcemanager-frontdoor:1.0.0-beta.1
azure-resourcemanager-postgresql:1.0.0
azure-resourcemanager-databricks:1.0.0-beta.1
azure-resourcemanager-eventgrid:1.0.0
azure-resourcemanager-databoxedge:1.0.0-beta.1
azure-resourcemanager-mysql:1.0.0
azure-resourcemanager-mediaservices:1.0.0
azure-resourcemanager-automation:1.0.0-beta.1
azure-data-appconfiguration:1.2.0-beta.1
azure-security-keyvault-administration:4.0.0-beta.6
azure-security-keyvault-secrets:4.3.0-beta.5
azure-security-keyvault-keys:4.3.0-beta.6
azure-security-keyvault-certificates:4.2.0-beta.5
azure-security-keyvault-jca:1.0.0-beta.6
spring-cloud-azure-appconfiguration-config-web:1.3.0
spring-cloud-azure-appconfiguration-config:1.3.0
spring-cloud-azure-feature-management-web:1.3.0
spring-cloud-azure-feature-management:1.3.0
spring-cloud-starter-azure-appconfiguration-config:1.3.0
azure-identity-spring:1.4.0
azure-spring-boot-bom:3.4.0
azure-spring-boot-starter-active-directory-b2c:3.4.0
azure-spring-boot-starter-active-directory:3.4.0
azure-spring-boot-starter-cosmos:3.4.0
azure-spring-boot-starter-keyvault-certificates:3.0.0-beta.6
azure-spring-boot-starter-keyvault-secrets:3.4.0
azure-spring-boot-starter-servicebus-jms:3.4.0
azure-spring-boot-starter-storage:3.4.0
azure-spring-boot-starter:3.4.0
azure-spring-boot:3.4.0
azure-spring-cloud-dependencies:2.4.0
azure-spring-cloud-autoconfigure:2.4.0
azure-spring-cloud-context:2.4.0
azure-spring-cloud-messaging:2.4.0
azure-spring-cloud-starter-cache:2.4.0
azure-spring-cloud-starter-eventhubs-kafka:2.4.0
azure-spring-cloud-starter-eventhubs:2.4.0
azure-spring-cloud-starter-servicebus:2.4.0
azure-spring-cloud-starter-storage-queue:2.4.0
azure-spring-cloud-storage:2.4.0
azure-spring-cloud-stream-binder-eventhubs:2.4.0
azure-spring-cloud-stream-binder-servicebus-core:2.4.0
azure-spring-cloud-stream-binder-servicebus-queue:2.4.0
azure-spring-cloud-stream-binder-servicebus-topic:2.4.0
azure-spring-cloud-stream-binder-test:2.4.0
azure-spring-cloud-telemetry:2.4.0
azure-spring-integration-core:2.4.0
azure-spring-integration-eventhubs:2.4.0
azure-spring-integration-servicebus:2.4.0
azure-spring-integration-storage-queue:2.4.0
azure-spring-integration-test:2.4.0
azure-resourcemanager-resourcemover:1.0.0-beta.1
azure-resourcemanager-datafactory:1.0.0-beta.1
azure-resourcemanager-kubernetesconfiguration:1.0.0-beta.1
azure-resourcemanager-hdinsight:1.0.0-beta.2
azure-resourcemanager-advisor:1.0.0-beta.1
azure-resourcemanager-appconfiguration:1.0.0-beta.1
azure-resourcemanager-avs:1.0.0-beta.1
azure-resourcemanager-attestation:1.0.0-beta.1
azure-resourcemanager-azurestackhci:1.0.0-beta.1
azure-core-amqp:2.0.4
azure-resourcemanager-consumption:1.0.0-beta.1
azure-resourcemanager-azurestack:1.0.0-beta.1

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our April 2021 client library releases.

#### GA
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Identity
- Azure Communication SMS
- Azure Core
- Azure Cosmos DB
- Azure Spring Data Cosmos
- Azure EventGrid
- Azure Spring Boot
- Azure Spring Cloud
- Resource Management - Traffic Manager
- Resource Management - Monitor
- Resource Management - Key Vault
- Resource Management - Communication
- Resource Management - Cognitive Search
- Resource Management - Storage
- Resource Management - Resources
- Resource Management - Cosmos DB
- Resource Management - Private DNS
- Resource Management - Network
- Resource Management - Content Delivery Network
- Resource Management - Container Instances
- Resource Management - Service Bus
- Resource Management - Event Hubs
- Resource Management - Container Registry
- Resource Management - Spring Cloud
- Resource Management - App Service
- Resource Management - DNS
- Resource Management - Authorization
- Resource Management - Container Service
- Resource Management - Managed Service Identity
- Resource Management - SQL
- Resource Management - Redis
- Resource Management - Compute
- Resource Management - PostgreSQL
- Resource Management - Event Grid
- Resource Management - MySQL
- Resource Management - Media Services

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates
- Azure Core
- Azure Core AMQP
- Azure Core Serializer Jackson JSON
- Azure Core - Test
- Azure Core Serializer GSON JSON
- Azure Core Serializer Jackson JSON
- Azure Core - HTTP OkHttp
- Azure Cosmos DB
- Azure Spring Data Cosmos
- Azure AI Text Analytics
- Azure AI Form Recognizer
- Azure App Configuration
- Azure Key Vault - Administration
- Azure Key Vault - Secrets
- Azure Key Vault - Keys
- Azure Key Vault - Certificates
- Resouce Management - Core

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Azure Cosmos Spark
- Storage - Blobs NIO
- Azure Communication Phone Numbers
- Azure Core Experimental
- Azure Core Serializer Apache Avro
- Azure Tracing OpenTelemetry Plugin
- Azure AI Form Recognizer
- Azure Cognitive Search
- Azure AI Text Analytics
- Azure Synapse - AccessControl
- Azure Synapse - Monitoring
- Azure Synapse - Spark
- Azure Synapse - Managed Private Endpoints
- Azure Synapse - Artifacts
- Azure App Configuration
- Azure Key Vault - Administration
- Azure Key Vault - Secrets
- Azure Key Vault - Keys
- Azure Key Vault - Certificates
- Azure Key Vault - JCA
- Resource Management - Datadog
- Resource Management - Delegated Network
- Resource Management - Api Management
- Resource Management - Log Analytics
- Resource Management - Communication
- Resource Management - Change Analysis
- Resource Management - Resource Graph
- Resource Management - Synapse
- Resource Management - Cost Management
- Resource Management - Resource Health
- Resource Management - Frontdoor
- Resource Management - Databricks
- Resource Management - Databoxedge
- Resource Management - Automation
- Resource Management - Resourcemover
- Resource Management - Datafactory
- Resource Management - Kubernetesconfiguration
- Resource Management - HDInsight
- Resource Management - Advisor
- Resource Management - Appconfiguration
- Resource Management - Avs
- Resource Management - Attestation
- Resource Management - Azurestackhci
- Resource Management - Consumption
- Resource Management - Azurestack

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
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-monitor</artifactId>
  <version>2.3.0</version>
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
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-internal-avro</artifactId>
  <version>12.0.3-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cosmos</artifactId>
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
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.3.0</version>
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
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-changeanalysis</artifactId>
  <version>1.0.0-beta.1</version>
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
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.2.1</version>
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
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.3.0</version>
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
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-msi</artifactId>
  <version>2.3.0</version>
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
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-delegatednetwork</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-compute</artifactId>
  <version>2.3.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-spring-data-cosmos</artifactId>
  <version>3.5.1</version>
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

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-frontdoor</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-postgresql</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-databricks</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventgrid</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-databoxedge</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-mysql</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-mediaservices</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-automation</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.2.0-beta.1</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-data-appconfiguration</artifactId>
    <version>1.1.11</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-administration</artifactId>
  <version>4.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-secrets</artifactId>
  <version>4.3.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-keys</artifactId>
  <version>4.3.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-security-keyvault-certificates</artifactId>
  <version>4.2.0-beta.5</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.2.7</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-keys</artifactId>
    <version>4.2.7</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-certificates</artifactId>
    <version>4.1.7/version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resourcemover</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-datafactory</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-kubernetesconfiguration</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-hdinsight</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-advisor</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appconfiguration</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-avs</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-attestation</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-azurestackhci</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>2.0.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-consumption</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-azurestack</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>
```

To use **Azure Spring Boot** starters, refer to the Maven dependency information below, which may be copied into your projects Maven pom.xml file as appropriate.
```xml
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-boot-bom</artifactId>
      <version>3.4.0</version>
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
<dependencyManagement>
  <dependencies>
    <dependency>
      <groupId>com.azure.spring</groupId>
      <artifactId>azure-spring-cloud-dependencies</artifactId>
      <version>2.4.0</version>
      <type>pom</type>
      <scope>import</scope>
    </dependency>
  </dependencies>
</dependencyManagement>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-eventhubs-kafka</artifactId>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-eventhubs</artifactId>
</dependency>

 <dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-queue</artifactId>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-stream-binder-servicebus-topic</artifactId>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-storage-queue</artifactId>
</dependency>

<dependency>
  <groupId>com.azure.spring</groupId>
  <artifactId>azure-spring-cloud-starter-cache</artifactId>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-starter-azure-appconfiguration-config</artifactId>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-appconfiguration-config</artifactId>
</dependency>

<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>spring-cloud-azure-appconfiguration-config-web</artifactId>
</dependency>
```

[pattern]: # (<dependency>`n  <groupId>${GroupId}</groupId>`n  <artifactId>${PackageName}</artifactId>`n  <version>${PackageVersion}</version>`n</dependency>`n)

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

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

### Resource Management - Traffic Manager 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-trafficmanager_2.3.0/sdk/resourcemanager/azure-resourcemanager-trafficmanager/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Monitor 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-monitor_2.3.0/sdk/resourcemanager/azure-resourcemanager-monitor/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### azure-cosmos-spark_3-1_2-12 4.0.0-alpha.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-cosmos-spark_3-1_2-12_4.0.0-alpha.1/sdk/cosmos/azure-cosmos-spark_3-1_2-12/CHANGELOG.md#400-alpha1-2021-03-17)
* Cosmos DB Spark 3.1.1 Connector Test Release.

### Resource Management - Key Vault 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-keyvault_2.3.0/sdk/resourcemanager/azure-resourcemanager-keyvault/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

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

### Resource Management - Cosmos DB 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cosmos_2.3.0/sdk/resourcemanager/azure-resourcemanager-cosmos/CHANGELOG.md#230-2021-03-30)
- Updated `api-version` to `2021-03-15`
- Removed `PrivateEndpointConnectionAutoGenerated` and `PrivateLinkServiceConnectionStatePropertyAutoGenerated`, they are duplicate class of `PrivateEndpointConnection` and `PrivateLinkServiceConnectionStateProperty`, respectively.

### Resource Management 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager_2.3.0/sdk/resourcemanager/azure-resourcemanager/CHANGELOG.md#230-2021-03-30)
- Added client-side validation for `getByResourceGroup`, `listByResourceGroup`, `deleteByResourceGroup` methods.

### Resource Management - Private DNS 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-privatedns_2.3.0/sdk/resourcemanager/azure-resourcemanager-privatedns/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Network 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-network_2.3.0/sdk/resourcemanager/azure-resourcemanager-network/CHANGELOG.md#230-2021-03-30)
- Supported `PrivateEndpoint` and `PrivateDnsZone`

### Resource Management - Content Delivery Network 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-cdn_2.3.0/sdk/resourcemanager/azure-resourcemanager-cdn/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Change Analysis 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-changeanalysis_1.0.0-beta.1/sdk/changeanalysis/azure-resourcemanager-changeanalysis/CHANGELOG.md#100-beta1-2021-03-26)
- Azure Resource Manager AzureChangeAnalysis client library for Java. This package contains Microsoft Azure SDK for AzureChangeAnalysis Management SDK.  Package tag package-2021-04-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Resource Graph 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resourcegraph_1.0.0-beta.1/sdk/resourcegraph/azure-resourcemanager-resourcegraph/CHANGELOG.md#100-beta1-2021-03-24)
- Azure Resource Manager ResourceGraph client library for Java. This package contains Microsoft Azure SDK for ResourceGraph Management SDK. Azure Resource Graph API Reference. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).
- Azure Resource Manager ResourceGraph client library for Java. This package contains Microsoft Azure SDK for ResourceGraph Management SDK. Azure Resource Graph API Reference. Package tag package-2019-04. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Container Instances 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-containerinstance_2.3.0/sdk/resourcemanager/azure-resourcemanager-containerinstance/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Core Serializer Jackson JSON 1.2.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-serializer-json-jackson_1.2.1/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#121-2021-03-19)
#### Bug Fixes

- Fix a bug where `ClassNotFoundException` or `MethodNotFoundException` was thrown when Jackson 2.11 is resolved
  instead of Jackson 2.12. [#19897](https://github.com/Azure/azure-sdk-for-java/issues/19897)

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

### Resource Management - Communication 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-communication_1.0.0-beta.1/sdk/communication/azure-resourcemanager-communication/CHANGELOG.md#100-beta1-2021-03-23)
- Azure Resource Manager Communication client library for Java. This package contains Microsoft Azure SDK for Communication Management SDK. REST API for Azure Communication Services. Package tag package-2020-08-20. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Spring Cloud 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appplatform_2.3.0/sdk/resourcemanager/azure-resourcemanager-appplatform/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - App Service 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appservice_2.3.0/sdk/resourcemanager/azure-resourcemanager-appservice/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - DNS 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-dns_2.3.0/sdk/resourcemanager/azure-resourcemanager-dns/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

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

### Resource Management - Managed Service Identity 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-msi_2.3.0/sdk/resourcemanager/azure-resourcemanager-msi/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - SQL 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-sql_2.3.0/sdk/resourcemanager/azure-resourcemanager-sql/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Redis 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-redis_2.3.0/sdk/resourcemanager/azure-resourcemanager-redis/CHANGELOG.md#230-2021-03-30)
- Updated core dependency from resources

### Resource Management - Delegated Network 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-delegatednetwork_1.0.0-beta.1/sdk/delegatednetwork/azure-resourcemanager-delegatednetwork/CHANGELOG.md#100-beta1-2021-03-26)
- Azure Resource Manager DelegatedNetwork client library for Java. This package contains Microsoft Azure SDK for DelegatedNetwork Management SDK. DNC web api provides way to create, get and delete dnc controller. Package tag package-2021-03-15. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Compute 2.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-compute_2.3.0/sdk/resourcemanager/azure-resourcemanager-compute/CHANGELOG.md#230-2021-03-30)
- Updated `api-version` to `2021-03-01`
- Corrected class type for `EncryptionImages`, `GalleryImageVersionStorageProfile`, `GalleryImageVersionUpdate`, `ImageDataDisk`, `ManagedDiskParameters`, `VirtualMachineScaleSetManagedDiskParameters`

### Spring Data Cosmos 3.5.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-data-cosmos_3.5.1/sdk/cosmos/azure-spring-data-cosmos/CHANGELOG.md#351-2021-03-24)
##### Key Bug Fixes
* Updated `azure-cosmos` to hotfix version 4.13.1.

### Core - Test 1.6.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-test_1.6.1/sdk/core/azure-core-test/CHANGELOG.md#161-2021-04-02)
#### Dependency Updates

- Upgraded `azure-core` from `1.14.0` to `1.15.0`.

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

### azure-resourcemanager-resourcehealth 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resourcehealth_1.0.0-beta.1/sdk/resourcehealth/azure-resourcemanager-resourcehealth/CHANGELOG.md#100-beta1-2021-04-08)
- Azure Resource Manager ResourceHealth client library for Java. This package contains Microsoft Azure SDK for ResourceHealth Management SDK. The Resource Health Client. Package tag package-2018-07-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-frontdoor 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-frontdoor_1.0.0-beta.1/sdk/frontdoor/azure-resourcemanager-frontdoor/CHANGELOG.md#100-beta1-2021-04-09)
- Azure Resource Manager FrontDoor client library for Java. This package contains Microsoft Azure SDK for FrontDoor Management SDK. FrontDoor Client. Package tag package-2020-11. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - PostgreSQL 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-postgresql_1.0.0/sdk/postgresql/azure-resourcemanager-postgresql/CHANGELOG.md#100-2021-04-09)
- Azure Resource Manager PostgreSql client library for Java. This package contains Microsoft Azure SDK for PostgreSql Management SDK. The Microsoft Azure management API provides create, read, update, and delete functionality for Azure PostgreSQL resources including servers, databases, firewall rules, VNET rules, security alert policies, log files and configurations with new business model. Package tag package-2020-01-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.ErrorAdditionalInfo` was removed

#### New Feature

* `models.ServerSecurityAlertPolicyListResult` was added

##### `models.ServerSecurityAlertPolicies` was modified

* `listByServer(java.lang.String,java.lang.String)` was added
* `listByServer(java.lang.String,java.lang.String,com.azure.core.util.Context)` was added

### azure-resourcemanager-databricks 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-databricks_1.0.0-beta.1/sdk/databricks/azure-resourcemanager-databricks/CHANGELOG.md#100-beta1-2021-04-08)
- Azure Resource Manager Databricks client library for Java. This package contains Microsoft Azure SDK for Databricks Management SDK. ARM Databricks. Package tag package-2018-04-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - Event Grid 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-eventgrid_1.0.0/sdk/eventgrid/azure-resourcemanager-eventgrid/CHANGELOG.md#100-2021-04-09)
- Azure Resource Manager EventGrid client library for Java. This package contains Microsoft Azure SDK for EventGrid Management SDK. Azure EventGrid Management Client. Package tag package-2020-06. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-databoxedge 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-databoxedge_1.0.0-beta.1/sdk/databoxedge/azure-resourcemanager-databoxedge/CHANGELOG.md#100-beta1-2021-04-09)
- Azure Resource Manager DataBoxEdge client library for Java. This package contains Microsoft Azure SDK for DataBoxEdge Management SDK.  Package tag package-2019-08. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - MySQL 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-mysql_1.0.0/sdk/mysql/azure-resourcemanager-mysql/CHANGELOG.md#100-2021-04-09)
- Azure Resource Manager MySql client library for Java. This package contains Microsoft Azure SDK for MySql Management SDK. The Microsoft Azure management API provides create, read, update, and delete functionality for Azure MySQL resources including servers, databases, firewall rules, VNET rules, log files and configurations with new business model. Package tag package-2020-01-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `models.ErrorAdditionalInfo` was removed

#### New Feature

* `models.ServerSecurityAlertPolicyListResult` was added

##### `models.ServerSecurityAlertPolicies` was modified

* `listByServer(java.lang.String,java.lang.String,com.azure.core.util.Context)` was added
* `listByServer(java.lang.String,java.lang.String)` was added

### Resource Management - Media Services 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-mediaservices_1.0.0/sdk/mediaservices/azure-resourcemanager-mediaservices/CHANGELOG.md#100-2021-04-09)
- Azure Resource Manager MediaServices client library for Java. This package contains Microsoft Azure SDK for MediaServices Management SDK. This Swagger was generated by the API Framework. Package tag package-2020-05. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### Breaking Change

* `MediaservicesManager` was removed
* `models.CreatedByType` was removed
* `MediaservicesManager$Configurable` was removed
* `models.SystemData` was removed

#### New Feature

* `MediaServicesManager` was added
* `MediaServicesManager$Configurable` was added

##### `models.JpgFormat` was modified

* `withFilenamePattern(java.lang.String)` was added

##### `models.PngFormat` was modified

* `withFilenamePattern(java.lang.String)` was added

### azure-resourcemanager-automation 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-automation_1.0.0-beta.1/sdk/automation/azure-resourcemanager-automation/CHANGELOG.md#100-beta1-2021-04-09)
- Azure Resource Manager Automation client library for Java. This package contains Microsoft Azure SDK for Automation Management SDK. Automation Client. Package tag package-2019-06. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### App Configuration 1.2.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-appconfiguration_1.2.0-beta.1/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md#120-beta1-2021-04-09)
#### New Features
- Added updateSyncToken() to be able to provide external synchronization tokens to both
  `ConfigurationAsyncClient` and `ConfigurationClient` clients.
- Added new `SecretReferenceConfigurationSetting` and `FeatureFlagConfigurationSetting`
  types to represent configuration settings that references KeyVault Secret reference and
  feature flag respectively.
- Added new convenience overload APIs that take `ConfigurationSetting`:
  `addConfigurationSetting(ConfigurationSetting setting)`
  `getConfigurationSetting(ConfigurationSetting setting)`
  `setConfigurationSetting(ConfigurationSetting setting)`
  `deleteConfigurationSetting(ConfigurationSetting setting)`
  `setReadOnly(ConfigurationSetting setting, boolean isReadOnly)`
- Added a new method that accepts `ClientOptions` in `ConfigurationClientBuilder`.

### Key Vault - Keys 4.2.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.7/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#427-2021-04-08)
#### Breaking Changes
##### Behavioral Changes
- NullPointerExceptions thrown by client builders when setting configuration properties are now properly logger at the ERROR level.


### Key Vault - Secrets 4.2.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.7/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#427-2021-04-08)
#### Breaking Changes
##### Behavioral Changes
- NullPointerExceptions thrown by client builders when setting configuration properties are now properly logger at the ERROR level.


### Key Vault - Certificates 4.1.7 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.2.7/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#417-2021-04-08)
#### Breaking Changes
##### Behavioral Changes
- NullPointerExceptions thrown by client builders when setting configuration properties are now properly logger at the ERROR level.

### Key Vault - Administration 4.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-administration_4.0.0-beta.6/sdk/keyvault/azure-security-keyvault-administration/CHANGELOG.md#400-beta6-2021-04-09)
#### New features
- Added support for service version `7.2`.
- Added support to specify whether or not a pipeline policy should be added per call or per retry.

### Key Vault - Secrets 4.3.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-secrets_4.3.0-beta.5/sdk/keyvault/azure-security-keyvault-secrets/CHANGELOG.md#430-beta5-2021-04-09)
#### New features
- Added support for service version `7.2`.
- Added support to specify whether or not a pipeline policy should be added per call or per retry.

#### Breaking Changes
- Changed `KeyVaultSecretIdentifier` so it is instantiated via its constructor as opposed to via a `parse()` factory method.


### Key Vault - Keys 4.3.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-keys_4.3.0-beta.6/sdk/keyvault/azure-security-keyvault-keys/CHANGELOG.md#430-beta6-2021-04-09)
#### Breaking Changes
- Renamed `EncryptOptions` to `EncryptParameters`.
- Renamed `DecryptOptions` to `DecryptParameters`.
- Changed `KeyVaultKeyIdentifier` so it is instantiated via its constructor as opposed to via a `parse()` factory method.
- Removed the following classes:
    - `LocalCryptographyAsyncClient`
    - `LocalCryptographyClient`
    - `LocalCryptographyClientBuilder`
    - `LocalKeyEncryptionKeyClient`
    - `LocalKeyEncryptionKeyAsyncClient`
    - `LocalKeyEncryptionKeyClientBuilder`

#### New features
- Added support for service version `7.2`.
- Made all `JsonWebKey` properties settable.
- Added support to specify whether or not a pipeline policy should be added per call or per retry.
- Added convenience class `CreateOctKeyOptions`.
- Added support for building local-only cryptography clients by providing a `JsonWebKey` for local operations:
    - `CryptograhpyClientBuilder.jsonWebKey(JsonWebKey)`
- Added support for building local-only key encryption key clients by providing a `JsonWebKey` for local operations:
    - `KeyEncryptionKeyClientBuilder.buildKeyEncryptionKey(JsonWebKey)`
    - `KeyEncryptionKeyClientBuilder.buildAsyncKeyEncryptionKey(JsonWebKey)`
- `CryptograhpyClientBuilder.keyIdentifier(String)` now throws a `NullPointerException` if a `null` value is provided as an argument.

### Key Vault - Certificates 4.2.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-certificates_4.2.0-beta.5/sdk/keyvault/azure-security-keyvault-certificates/CHANGELOG.md#420-beta5-2021-04-09)
#### New features
- Added support for service version `7.2`.
- Added support to specify whether or not a pipeline policy should be added per call or per retry.

#### Breaking Changes
- Changed `KeyVaultCertificateIdentifier` so it is instantiated via its constructor as opposed to via a `parse()` factory method.

### Key Vault - JCA 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-security-keyvault-jca_1.0.0-beta.6/sdk/keyvault/azure-security-keyvault-jca/CHANGELOG.md#100-beta6-2021-04-19)
#### Breaking Changes
- Remove configurable property of azure.keyvault.aad-authentication-url which is configured according to azure.keyvault.uri automatically [#20530](https://github.com/Azure/azure-sdk-for-java/pull/20530)


### azure-resourcemanager-resourcemover 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-resourcemover_1.0.0-beta.1/sdk/resourcemover/azure-resourcemanager-resourcemover/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager ResourceMover client library for Java. This package contains Microsoft Azure SDK for ResourceMover Management SDK. A first party Azure service orchestrating the move of Azure resources from one Azure region to another or between zones within a region. Package tag package-2021-01-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-datafactory 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-datafactory_1.0.0-beta.1/sdk/datafactory/azure-resourcemanager-datafactory/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager DataFactory client library for Java. This package contains Microsoft Azure SDK for DataFactory Management SDK. The Azure Data Factory V2 management API provides a RESTful set of web services that interact with Azure Data Factory V2 services. Package tag package-2018-06. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-kubernetesconfiguration 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-kubernetesconfiguration_1.0.0-beta.1/sdk/kubernetesconfiguration/azure-resourcemanager-kubernetesconfiguration/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager SourceControlConfiguration client library for Java. This package contains Microsoft Azure SDK for SourceControlConfiguration Management SDK. KubernetesConfiguration Client. Package tag package-2021-03. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Resource Management - HDInsight 1.0.0-beta.2 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-hdinsight_1.0.0-beta.2/sdk/hdinsight/azure-resourcemanager-hdinsight/CHANGELOG.md#100-beta2-2021-04-12)
- Azure Resource Manager HDInsight client library for Java. This package contains Microsoft Azure SDK for HDInsight Management SDK. HDInsight Management Client. Package tag package-2018-06-preview. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

#### New Feature

* `models.AsyncOperationResult` was added
* `models.VmSizeProperty` was added
* `models.ServiceSpecification` was added
* `models.NameAvailabilityCheckRequestParameters` was added
* `models.Dimension` was added
* `models.ValidationErrorInfo` was added
* `models.ClusterCreateValidationResult` was added
* `models.MetricSpecifications` was added
* `models.ExcludedServicesConfig` was added
* `models.OperationProperties` was added
* `models.NameAvailabilityCheckResult` was added
* `models.ClusterCreateRequestValidationParameters` was added
* `models.AaddsResourceDetails` was added
* `models.UpdateClusterIdentityCertificateParameters` was added


### azure-resourcemanager-advisor 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-advisor_1.0.0-beta.1/sdk/advisor/azure-resourcemanager-advisor/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager Advisor client library for Java. This package contains Microsoft Azure SDK for Advisor Management SDK. REST APIs for Azure Advisor. Package tag package-2020-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-appconfiguration 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-appconfiguration_1.0.0-beta.1/sdk/appconfiguration/azure-resourcemanager-appconfiguration/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager AppConfiguration client library for Java. This package contains Microsoft Azure SDK for AppConfiguration Management SDK.  Package tag package-2020-06-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-avs 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-avs_1.0.0-beta.1/sdk/avs/azure-resourcemanager-avs/CHANGELOG.md#100-beta1-2021-04-13)
- Azure Resource Manager Avs client library for Java. This package contains Microsoft Azure SDK for Avs Management SDK. Azure VMware Solution API. Package tag package-2020-03-20. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-attestation 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-attestation_1.0.0-beta.1/sdk/attestation/azure-resourcemanager-attestation/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager Attestation client library for Java. This package contains Microsoft Azure SDK for Attestation Management SDK. Various APIs for managing resources in attestation service. This primarily encompasses per-provider management. Package tag package-2020-10-01. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-azurestackhci 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-azurestackhci_1.0.0-beta.1/sdk/azurestackhci/azure-resourcemanager-azurestackhci/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager AzureStackHci client library for Java. This package contains Microsoft Azure SDK for AzureStackHci Management SDK. Azure Stack HCI management service. Package tag package-2020-10. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Core - AMQP 2.0.4 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-core-amqp_2.0.4/sdk/core/azure-core-amqp/CHANGELOG.md#204-2021-04-12)
#### Bug Fixes

- Fixed recovery of AMQP connection and receiver after a disconnect or a transient error occurs.
- Closing AMQP sender/receiver when it is no longer authorized.
- Fixed bug where the same endpoint state would not be emitted.
- Decreased the number of duplicated and verbose logs.
- Fixed NullPointerExceptions where there is no connection to initialize.
- Fixed issue with contending threads trying to use the same drain loop via 'wip' in ReactorDispatcher.

### azure-resourcemanager-consumption 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-consumption_1.0.0-beta.1/sdk/consumption/azure-resourcemanager-consumption/CHANGELOG.md#100-beta1-2021-04-13)
- Azure Resource Manager Consumption client library for Java. This package contains Microsoft Azure SDK for Consumption Management SDK. Consumption management client provides access to consumption resources for Azure Enterprise Subscriptions. Package tag package-2019-10. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### azure-resourcemanager-azurestack 1.0.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-resourcemanager-azurestack_1.0.0-beta.1/sdk/azurestack/azure-resourcemanager-azurestack/CHANGELOG.md#100-beta1-2021-04-12)
- Azure Resource Manager AzureStack client library for Java. This package contains Microsoft Azure SDK for AzureStack Management SDK. Azure Stack. Package tag package-preview-2020-06. For documentation on how to use this package, please see [Azure Management Libraries for Java](https://aka.ms/azsdk/java/mgmt).

### Azure Spring Boot [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-spring-boot_3.4.0/sdk/spring/azure-spring-boot/CHANGELOG.md#340-2021-04-19)

#### Key Bug Fixes
- Fix bug of Keyvault refresh Timer task blocking application termination. ([#20014](https://github.com/Azure/azure-sdk-for-java/pull/20014))
- Fix bug that user-name-attribute cannot be configured. ([#20209](https://github.com/Azure/azure-sdk-for-java/issues/20209))

### Azure Spring Cloud [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/spring-cloud-starter-azure-appconfiguration-config_1.3.0/sdk/appconfiguration/spring-cloud-starter-azure-appconfiguration-config/CHANGELOG.md#130-2021-04-19)

#### New Features
- Upgrade to `Spring Boot` [2.4.3](https://github.com/spring-projects/spring-boot/releases/tag/v2.4.3).

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
