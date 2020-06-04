---
title: Azure SDK for JavaScript (June 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the June 2020 client library release.

- Updates for Core libraries
- Update for Azure Event Hubs
- New preview of Azure Identity
- New preview of Azure Cognitive Search
- New preview of Azure Cognitive Form Recognizer
- New preview of Azure Cognitive Text Analytics
- New preview of Azure Service Bus

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/event-hubs
$> npm install @azure/identity
$> npm install @azure/search-documents
$> npm install @azure/ai-form-recognizer
$> npm install @azure/ai-text-analytics
$> npm install @azure/service-bus@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Event Hubs

#### Key Bug Fixes

- Fixed an issue where a `TypeError` was sometimes thrown as an uncaught exception.

### Identity

#### Breaking Changes

- TODO

#### New Features

- TODO

#### Key Bug Fixes

- TODO

- TODO

### Search

#### Breaking Changes

- TODO

#### New Features

- TODO

#### Key Bug Fixes

- TODO

### Text Analytics

#### Breaking Changes

- Renamed all result array types that extend JavaScript's base `Array` class to end with the word `Array` instead of `Collection` (e.g. `AnalyzeSentimentResultCollection` is now `AnalyzeSentimentResultArray`)
- Renamed `score` to `confidenceScore` in the `Match`, `Entity`, and `DetectedLanguage` types.
- Removed the `graphemeOffset` and `graphemeLength` properties of the `Match`, `Entity`, and `SentenceSentiment` types.
- Renamed the `graphemeCount` property of `TextDocumentStatistics` back to `characterCount`
- Removed the `warnings` property of `SentenceSentiment`.

#### New Features

- The library now uses the Text Analytics v3.0 (General Availability) service endpoint.
- Added a `text` property to `SentenceSentiment` that contains the sentence text
- Added `warnings` property to every document response object containing a list of `TextAnalyticsWarning` objects relevant to the corresponding document.


### Form Recognizer

#### Breaking Changes


- Recognition and training methods now return results directly, instead of wrapping the result in a response object.
- Rename refactoring for many public APIs for cross-language consistency.
- Remove `USReceipt` and related types.

#### New Features

- Add support to copy custom model from one Form Recognizer resource to another.
- Add support for Azure Active Directory credential.


### Service Bus

#### Breaking Changes

- TODO

#### New Features

- TODO

#### Key Bug Fixes


- TODO

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
