---
title: Azure SDK for Java (September 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our September 2020 client library releases.

#### GA

- Form Recognizer
- Management Library - AppService
- Management Library - Authorization
- Management Library - Compute
- Management Library - Container Service
- Management Library - CosmosDB
- Management Library - Insight
- Management Library - Key Vault
- Management Library - Managed Identity
- Management Library - Network
- Management Library - Resources
- Management Library - Storage

#### Updates

- _Add packages_

#### Preview

- Anomaly Detector
- Management Library - CDN
- Management Library - Container Instance
- Management Library - Container Registry
- Management Library - DNS
- Management Library - Event Hubs
- Management Library - Private DNS
- Management Library - Redis
- Management Library - Service Bus
- Management Library - Spring Cloud
- Management Library - SQL
- Management Library - Traffic Manager

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
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.0</version>
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
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-dns</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.0.0-beta.4</version>
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
  <version>2.0.0-beta.4</version>
</dependency>

```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-formrecognizer_3.0.0/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-2020-08-20))

- Generally available, stable version 3.0.0 released targetting v2.0 GA version of the Form Recognizer service

#### Breaking changes
- Renamed `BoundingBox` model to `FieldBoundingBox`

### Anomaly Detector ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-anomalydetector_3.0.0-beta.1/sdk/anomalydetector/azure-ai-anomalydetector/CHANGELOG.md#300-beta1-2020-08-27))

- Initial preview release for Anomaly Detector 

### Management Libraries

We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/resourcemanager)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``

### _Package name_

- Major changes only!

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
