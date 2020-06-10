---
title: Azure SDK for Java (June 2020)
layout: post
tags: java azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-java
---

The Azure SDK team is pleased to announce our June 2020 client library releases.

#### GA

- Core
- Core - AMQP
- Core - Http - Netty
- Core - Http - OkHttp
- Text Analytics

#### Updates

#### Preview

- Form Recognizer
- Tracing OpenTelemetry

## Installation Instructions

To use the GA and beta libraries, refer to the Maven dependency information below, which may be copied into your projects Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

```xml
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.5.1</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-amqp</artifactId>
  <version>1.2.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-netty</artifactId>
  <version>1.5.2</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.2.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-tracing-opentelemetry</artifactId>
  <version>1.0.0-beta.5</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-formrecognizer</artifactId>
  <version>1.0.0-beta.3</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-ai-textanalytics</artifactId>
  <version>1.0.0</version>
</dependency>

<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.2</version
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-java/issues).

## Changelog

### App Configuration ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/appconfiguration/azure-data-appconfiguration/CHANGELOG.md#112-2020-06-09))

- Update dependency version, `azure-core` to 1.5.1 and `azure-core-http-netty` to 1.5.2.

### Core ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core/CHANGELOG.md#151-2020-06-08))

#### Bug fixes

- Better handling of custom `Content-Type` headers, ex `application/custom+json`.

### Core - AMQP ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-amqp/CHANGELOG.md#120-2020-06-08))

#### New features

- Added support for AMQP transactions.

#### Bug fixes

- Fixed receiver recovery after losing network connection.
- Fixed triggering multiple retries occuring when creating a new AMQP channel.
- Fixed adding credits to new AMQP receive links upon creation.

### Core - Http - Netty ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-http-netty/CHANGELOG.md#152-2020-06-08))

#### Bug fixes

- Fixed incorrect handling of environment inferred proxies when they don't use authentication.

### Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#100-beta3-2020-06-10))

Here are some of the highlights:

#### Breaking changes

- Method `getFormTrainingClient()` is removed from `FormRecognizerClient` and `getFormRecognizerClient()` is added to `FormTrainingClient`
- `USReceipt` and related types have been removed. Information about a `RecognizedReceipt` must now be extracted from its `RecognizedForm`.
- Other method and property renaming detailed in changelog

#### New features

- Added support to copy a custom model from one Form Recognizer resource to another.
- Added support for authentication using Azure Active Directory credential.

### Text Analytics
 1.0.0 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100-2020-06-09))
- Initial release of `azure-ai-textanalytics` version 1.0.0 which targets Azure Text Analytics service API version v3.0.

 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100-beta5-2020-05-27))

#### New features
- Added Text property and `getText()` to `SentenceSentiment`.
- `Warnings` property added to each document-level response object returned from the endpoints. It is a list of `TextAnalyticsWarnings`.
- Added `getWarnings()` to `CategorizedEntityCollection`, `KeyPhrasesCollection`, `LinkedEntityCollection` to retrieve warnings. 
- Text analytics SDK update the service to version `v3.0` from `v3.0-preview.1`.

#### Breaking changes
- Removed pagination feature, which removed `TextAnalyticsPagedIterable`, `TextAnalyticsPagedFlux` and `TextAnalyticsPagedResponse`
- Removed overload methods for API that takes a list of String, only keep max-overload API that has a list of String, language or country hint, and `TextAnalyticsRequestOption`.
- Renamed `apiKey()` to `credential()` on TextAnalyticsClientBuilder.
- Removed `getGraphemeLength()` and `getGraphemeOffset()` from `CategorizedEntity`, `SentenceSentiment`, and `LinkedEntityMatch`.
- Deprecated `TextDocumentInput(String id, String text, String language)` constructor, but added `setLanguage()` setter since `language` is optional.

### Tracing OpenTelemetry ([Changelog](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md#100-beta5-2020-06-08))

#### Breaking changes

- Changed `Tracer` loading from using all on classpath to only using the first.

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
