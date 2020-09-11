---
title: Azure SDK for Java (September 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our September 2020 client library releases.

#### GA

- Azure Core Serializer GSON JSON
- Azure Core Serializer Jackson JSON
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

- Azure App Configuration
- Azure Core
- Azure Core Http Netty
- Azure Core Http OkHttp
- Azure Search Documents
- Form Recognizer

#### Preview

- Azure Core Experimental
- Azure Core Serializer Apache Avro
- Anomaly Detector
- Event Grid
- Azure Search Documents
- Azure Tables
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
  <artifactId>azure-data-tables</artifactId>
  <version>12.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>3.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.8.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.4</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.6.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.3.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-avro-apache</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.0.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.5</version>
</dependency>

<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-messaging-eventgrid</artifactId>
    <version>2.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.0</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.2.0-beta.1</version>
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

### Azure Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#181-2020-09-08))

#### New Features

- New `InputStream` and `OutputStream` APIs for serialization and deserialization.
- Added logging for the request attempt count to better correlate when requests are retried.
- Updated `reactor-core` version to `3.3.9.RELEASE`.
- Updated FasterXML Jackson versions to `2.11.2`.

#### Bug Fixes

- General performance fixes for serialization, URL modification and parsing, and more.
- Improved request and response body logging performance by using bulk `ByteBuffer` reading instead of byte by byte reading.
- Fixed bug where header logging checked for a log level of not equals `verbose` instead of equals `verbose`.

### Azure Core Experimental ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta4-2020-09-08))

#### New Features

- Added `AvroSerializer` interface containing Avro specific serializer APIs.
- Added `AvroSerializerProvider` interface as a service provider for `AvroSerializer`.

### Azure Core Http Netty ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-netty/CHANGELOG.md#161-2020-09-08))

#### New Features

- Added new APIs to configure request write timeout, response timeout, and response body read timeout.
- Updated `reactor-core` version to `3.3.9.RELEASE`.
- Updated `reactor-netty` version to `0.9.11.RELEASE`.

#### Breaking Changes

- Changed default timeouts from infinite to 60 seconds.

### Azure Core Http OkHttp ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-okhttp/CHANGELOG.md#131-2020-09-08))

#### New Features

- Updated `okhttp` dependency from `4.2.2` to `4.8.1`.
- Added request timeout configuration.

#### Breaking Changes

- Changed default connect timeout from 60 seconds to 10 and default read timeout from 120 seconds to 60 seconds.

#### Bug Fixes

- Fixed bug where `Configuration` proxy would lead to a `NullPointerException` when set.

### Azure Core Serializer Apache Avro ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-avro-apache/CHANGELOG.md#100-beta3-2020-09-08))

#### New Features

- Updated `ApacheAvroSerializer` to implement `AvroSerializer` instead of `ObjectSerializer`.
- Added implementation for `AvroSerializerProvider`.

### Azure Core Serializer JSON GSON ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-json-gson/CHANGELOG.md#101-2020-09-08))

- General availability.

### Azure Core Serializer JSON Jackson ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-serializer-json-jackson/CHANGELOG.md#101-2020-09-08))

- General availability.

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-formrecognizer_3.0.0/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-2020-08-20))

- General availability, stable version 3.0.0 released targetting v2.0 GA version of the Form Recognizer service

#### Breaking changes

- Renamed `BoundingBox` model to `FieldBoundingBox`

### Anomaly Detector ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-ai-anomalydetector_3.0.0-beta.1/sdk/anomalydetector/azure-ai-anomalydetector/CHANGELOG.md#300-beta1-2020-08-27))

- Initial preview release for Anomaly Detector.

### Azure Search Documents 11.1.0 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#1110-2020-09-09))

#### New Features

- GA release of `buildSearchFields` on `SearchIndexClient` and `SearchIndexAsyncClient`.
- GA release of `JsonSerializer` functionality for `SearchClient` and `SearchAsyncClient`.
- GA release of default `HttpLogOptions` on client builders.

#### Breaking Changes

- Renamed `SearchableFieldProperty` to `SearchableField` and `SimpleFieldProperty` to `SimpleField`.
- Renamed `FieldBuilderOptions.setConverter` to `FieldBuilderOptions.setJsonSerializer`.
- Replaced `ObjectSerializer` setters in builders with `JsonSerializer` to better represent the type requirement.

#### Bug Fixes

- Deprecated getter `OcrSkill.setShouldDetectOrientation()` and replaced with correct Javabeans named `isShouldDetectOrientation()`.

### Azure Search Documents 11.2.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#1120-beta1-2020-09-09))

#### New Features

- Added `SearchBatchClient` and `SearchBatchAsyncClient` which handle automatically creating and sending document batches.
- Added `IndexingHook` interface to provide callback functionality when indexing documents with batching clients.
- Added `IndexingParametersConfiguration`, and related enums, to offer strongly type configuration for `IndexingParameters`.
- Added `ScoringStatistics` and `SessionId` to `SearchOptions`.

#### Breaking Changes

- Updated Jackson annotations to include `required = true` when service must receive or return the property.

### Event Grid ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/eventgrid/azure-messaging-eventgrid/CHANGELOG.md#200-beta1-2020-09-09))

- Initial Preview release for Event Grid 

### Tables ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/azure-data-tables_12.0.0-beta.1/sdk/tables/azure-data-tables/CHANGELOG.md#1200-beta1-2020-09-10))

- Initial preview release for Azure Tables

### Management Libraries

We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Java](https://azure.github.io/azure-sdk/java/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a higher-level, object-oriented API for managing Azure resources, that is optimized for ease of use, succinctness and consistency. You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/java.html). Detailed documentation and code samples for these new libraries can be [found here](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/resourcemanager)

These new packages share the same groupId ``com.azures.resourcemanager`` and artifactId share the same prefix of ``azure-resourcemanager``

#### Bug Fixes

- Changed `Fluent` annotations to `Immutable` when the class is immutable.

## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
