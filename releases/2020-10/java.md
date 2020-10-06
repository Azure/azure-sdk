---
title: Azure SDK for Java (October 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- Azure Core
- Azure Core Experimental
- Azure Core Http OkHttp
- Azure Core Http Netty
- Azure Core Serializer JSON GSON
- Azure Core Serializer JSON Jackson
- Azure Core Test
- Azure Search Documents

#### Beta

- Azure Search Documents

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.9.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-experimental</artifactId>
  <version>1.0.0-beta.6</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.3.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.6.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-gson</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-serializer-json-jackson</artifactId>
  <version>1.0.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-test</artifactId>
  <version>1.5.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.1.1</version>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-search-documents</artifactId>
  <version>11.2.0-beta.2</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Core ([CHANGELOG](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#190-2020-10-01))

#### New Features

- Added `ServiceClientProtocal` to allow the client to indicate which networking protocol it will use.
- Added `HttpPipelinePosition` which allows `HttpPipelinePolicy`s to indicate their position when used in a client builder.
- Added default interface method `HttpPipelinePolicy.getPipelinePosition` that returns `HttpPipelinePosition.PER_RETRY`.

#### Key Bug Fixes

- Fixed a bug where calling `UrlBuilder.parse` could result in an exception. [#15013](https://github.com/Azure/azure-sdk-for-java/issues/15013)
- Changed `ContinuablePagedIterable` implementation to use a custom iterable to prevent additional, unrequested pages from being retrieved. [#15575](https://github.com/Azure/azure-sdk-for-java/issues/15575)

### Azure Core Experimental ([CHANGELOG](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-experimental/CHANGELOG.md#100-beta6-2020-10-06))

#### New Features

- Added `JsonPatchDocument` to support JSON Patch functionality.
- Added `BinaryData` abstraction to represent binary data and supports serialization through `ObjectSerializer`.

### Azure Core Test ([CHANGELOG](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-test/CHANGELOG.md#150-2020-10-01))

#### New Features

- Enhanced playback recording to use test class name plus test name to identify records.

#### Key Bug Fixes

- Added additional response data redaction.
- Updated handling of `HttpClient` retrieval from the classpath to no longer require dependent libraries to `add-opens` in Java 9+.

### Azure Search Documents

#### 11.2.0-beta.2 ([CHANGELOG](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#1120-beta2-2020-10-06))

##### New Features

- Added `SearchFilter` to help aid creation of OData filter expressions.
- Added required parameter `documentKeyRetriever` to `SearchIndexingBufferedSender` to better correlate response documents to sent documents.
- Added `ClientOptions` to all builders to support setting `applicationId` in `User-Agent` string and headers that need to be applied to each request.
- Added support for `HttpPipelinePosition` in client builders to determine when an `HttpPipelinePolicy` will be invoked.

##### Breaking Changes

- Renamed `SearchBatchClient` and `SearchBatchAsyncClient` to `SearchIndexingBufferedSender` and `SearchIndexingBufferedAsyncSender`.
- Removed `SearchBatchClientBuilder` for options bag `SearchIndexingBufferedSenderOptions`.
- Renamed `getSearchBatchClient` to `getSearchIndexingBufferedSender` in `SearchClient`.
- Made `SearchIdexingBufferedSender` generic typed.
- Removed `IndexingHooks` in favor of individual callbacks.
- Removed the ability to configure `batchSize` on buffered sender and changed the default to 500 instead of 1000.
- Changed `onActionRemoved` to `onActionSent`.
  
## Need help

- For reference documentation visit the [Azure SDK for Java documentation](https://azure.github.io/azure-sdk-for-java/).
- For tutorials, samples, quick starts and other documentation, visit [Azure for Java Developers](https://docs.microsoft.com/java/azure/).
- For build reports on code quality, test coverage, etc, visit [Azure Java SDK](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/index.html).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-java/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-java-sdk) or ask new ones on StackOverflow using `azure-java-sdk` tag.

## Latest Releases

View all the latest versions of Java packages [here][java-latest-releases].

{% include refs.md %}
