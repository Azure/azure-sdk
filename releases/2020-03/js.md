---
title: Azure SDK for JavaScript (March 2020)
layout: post
date: 2020-03-17
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the March 2020 client library release. This represents the seventh release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This release includes:

- Update for Azure Event Hubs
- New preview for Azure Key Vault libraries
- New preview for Azure Text Analytics
- First preview of Azure Cognitive Search


## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/event-hubs
    $> npm install @azure/keyvault-certificates
    $> npm install @azure/keyvault-keys
    $> npm install @azure/keyvault-secrets
    $> npm install @azure/ai-text-analytics
    $> npm install @azure/search

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed change logs for each of the libraries can be found in the source repository linked to in the Quick Links table.
Below are some noteworthy changes in the current release.

### Event Hubs

This release contains bug fixes to improve quality.

### Key Vault (Certificates, Keys, Secrets)

- Add support to the 7.1-preview service API version.

- The clients (Certificates/Keys/Secrets) now support multiple service API versions. The latest supported version (7.1-preview) is used by default.

- The Certificate client now imports certificates with `application/x-pem-file` content-type as is, without modifications.

### Text Analytics

- [Breaking] Renamed `id` to `dataSourceEntityId` in the `LinkedEntity` type.
- Added special handling for the string `"none"` as the `countryHint` parameter of the `TextAnalyticsClient.detectLanguage`. `"none"` is now treated the same as the empty string, and indicates that the default language detection model should be used.
- [Breaking] Renamed `offset` to `graphemeOffset` and `length` to `graphemeLength` in fields of response objects as appropriate in order to make it clear that the offsets and lengths are in units of Unicode graphemes.
- [Breaking] Renamed `sentimentScores` on both `DocumentSentiment` and `SentenceSentiment` to `confidenceScores`, and renamed the type `SentimentScorePerLabel` to `SentimentConfidenceScores`.
- [Breaking] Renamed `characterCount` to `graphemeCount` in the `DocumentStatistics` interface, to align with the change to using `grapheme` in the lengths/offsets of response objects.

### Cognitive Search

- Initial implementation of the data-plane Cognitive Search Client. The version number starts at 11 to align with client libraries in other languages.
- This first preview has support for document operations on an index, such as querying and document management.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
