---
title: Azure SDK for JavaScript (February 2020)
layout: post
date: 2020-02-11
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the February 2020 client library release. This represents the seventh release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This release includes:

- Update for Azure Cosmos
- Update for Azure Event Hubs
- Update for Azure Blob Storage
- New preview for Azure Text Analytics

## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/event-hubs
    $> npm install @azure/storage-blob
    $> npm install @azure/storage-file-share
    $> npm install @azure/storage-file-datalake
    $> npm install @azure/storage-queue
    $> npm install @azure/ai-text-analytics
    $> npm install @azure/cosmos

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed change logs for each of the libraries can be found in the source repository linked to in the Quick Links table.
Below are some noteworthy changes in the current release.

### Cosmos
- Added support for spatial indexing, bounding boxes, and geospatial configuration

### Event Hubs
- Improved bundling support of this library for web browsers.

### Storage (File Shares, File Data Lake, Blobs, Queues)
- Added support for new features introduced in `2019-07-07` Azure Storage Service API version.
- Added a new type `ShareLeaseClient` to manage File Share leases.

### Text Analytics
- Added support for rotating API keys via the `TextAnalyticsApiKeyCredential.updateKey` method.
- Added a discriminant type for `TextAnalyticsResult.error` to allow for easy differentiation between success and error types using `if (result.error) { ... }` in both TypeScript and JavaScript.
- [Breaking] Removed the `Entity` type and added new return types `CategorizedEntity` and `PiiEntity` for the `recognizeEntities` and `recognizePiiEntities` methods respectively. These types are equivalent to the previous `Entity` type.
- [Breaking] Removed the `detectedLanguages` property from `DetectLanguageResult`, as the service currently only returns one language.
- [Breaking] Renamed the `detectLanguages` method to `detectLanguage`, as the `detectedLanguages` property was removed from the `DetectLanguageResult` return type.
- [Breaking] Renamed `documentScores` and `sentenceScores` on the `DocumentSentiment` and `SentenceSentiment` types both to `sentimentScores`.
- [Breaking] Renamed `type` and `subtype` to `category` and `subcategory` respectively in the `CategorizedEntity` and `PiiEntity` types.
- [Breaking] Renamed `DocumentSentimentValue` and `SentenceSentimentValue` to `DocumentSentimentLabel` and `SentenceSentimentLabel` respectively.
- [Breaking] Renamed `SentimentConfidenceScorePerLabel` to `SentimentScorePerLabel`.
- [Breaking] Refactored `TextAnalyticsError` to flatten the error hierarchy and remove `innerError`. The new error model has properties for `code`, `message`, and an optional `target` only. The `code` property of `TextAnalyticsError` can now contain all of the codes from the previous `InnerErrorCodeValue` as well as those from the top-level `ErrorCodeValue`.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
