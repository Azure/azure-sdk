---
title: Azure SDK for Java (July 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our July 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- Azure-Cosmos
- Core
- Core - AMQP
- Core - Http Netty
- Core - Http OkHttp
- Core - Test

#### Preview

- Core - Experimental
- Management Library - Compute
- Management Library - Network
- Management Library - Storage
- Management Library - Resources
- Management Library - Managed Identity
- Management Library - Authorization
- Management Library - Insight
- Management Library - AppService
- Management Library - SQL
- Management Library - CosmosDB
- Management Library - Key Vault
- Schema Registry
- Schema Registry - Avro-Specific

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
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
  <version>4.1.0</version>
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
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-storage-queue</artifactId>
  <version>12.6.0-beta.1</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#160-2020-07-02))

#### New Features

- Added utility class `UserAgentUtil` which constructs User-Agent headers following SDK guidelines.

### Azure Core AMQP ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-amqp/CHANGELOG.md#130-2020-07-02))

#### New Features

- Added `createProducer` constructor which takes an additional parameter for link properties.

#### Key Bug Fixes

- Fixed `User-Agent` string to follow guidelines.

### Azure Core Experimental ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta1-2020-07-02))

#### New Features

- Added `ObjectSerializer` interface containing generic serializer APIs.
- Added `JsonSerializer` interface containing JSON specific serializer APIs.
- Added `JsonNode`, and subclasses, which are strongly type representations of a JSON tree.
- Added `GeoJSON` classes and serializers.

### Azure Cosmos ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md#410-2020-06-25))

## 4.1.0 (2020-06-25)

### New Features

- Added support for `GROUP BY` query.
- Increased the default value of maxConnectionsPerEndpoint to 130 in DirectConnectionConfig.
- Increased the default value of maxRequestsPerConnection to 30 in DirectConnectionConfig.

### Key Bug Fixes

- Fixed issues with order by query returning duplicate results when resuming by using continuation token.
- Fixed issues with value query returning null values for nested object.
- Fixed null pointer exception on request manager in RntbdClientChannelPool.

### Azure Schema Registry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/schemaregistry/azure-data-schemaregistry/CHANGELOG.md#100-beta2-2020-06-19))

## 1.0.0-beta.2 (2020-06-19)

### Key Bug Fixes

- Fix 4xx HTTP response handling

### Azure Schema Registry Avro ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/schemaregistry/azure-data-schemaregistry-avro/CHANGELOG.md#100-beta2-2020-06-19))

## 1.0.0-beta.2 (2020-06-19)

### Key Bug Fixes

- Fix null max schema map size parameter behavior

### Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob/CHANGELOG.md)
- Added support for Blob Tags, Blob Versioning, Jumbo Blobs, and more
- Fixed a variety of bugs to improve the experience of using this library

#### Blob ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-blob-changefeed/CHANGELOG.md)
- Added a preview version of this library to support change feed

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)
- Added support to query a file
- Added support to increase max size of data that can be sent via append

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-file-share/CHANGELOG.md)
- Added support for restoring file share

#### Queue [Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/storage/azure-storage-queue/CHANGELOG.md)

### New Management Libraries

A new set of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/) are now in Public Preview. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/management)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

{% assign packages = site.data.releases.latest.java-packages %}
{% include java-packages.html %}

{% include refs.md %}
