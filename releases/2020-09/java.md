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

#### Updates

- Azure App Configuration

#### Preview

- Anomaly Detector

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
  <groupId>com.azure</groupId>
  <artifactId>azure-data-appconfiguration</artifactId>
  <version>1.1.5</version>
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
