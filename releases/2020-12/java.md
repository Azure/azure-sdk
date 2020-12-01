---
title: Azure SDK for Java (December 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our December 2020 client library releases.

#### GA

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

#### Updates

- Management Library - App Services
- Management Library - Resources

#### Beta

- _Add packages_

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-cdn</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerinstance</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-containerregistry</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-eventhubs</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-privatedns</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-redis</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-servicebus</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appplatform</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-sql</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-trafficmanager</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-appservice</artifactId>
  <version>2.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager-resources</artifactId>
  <version>2.1.0</version>
</dependency>
```

For resource management libraries, we also provide a wrapper package that contains all available services
```xml
<dependency>
  <groupId>com.azure.resourcemanager</groupId>
  <artifactId>azure-resourcemanager</artifactId>
  <version>2.1.0</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Release highlights

### Management Libraries

We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](http://aka.ms/azsdk/java/mgmt)

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
