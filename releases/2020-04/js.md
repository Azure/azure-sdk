---
title: Azure SDK for JavaScript (April 2020)
layout: post
date: 2020-04-14
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the April 2020 client library release.

- Updates for Core libraries
- Update for Azure Event Hubs
- New preview for Azure Text Analytics
- New preview of Azure Cognitive Search
- New preview of Azure Identity
- Initial preview of Azure Service Bus v7

## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/event-hubs
    $> npm install @azure/ai-text-analytics
    $> npm install @azure/identity
    $> npm install @azure/search-documents
    $> npm install @azure/service-bus@next

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed change logs for each of the libraries can be found in the source repository linked to in the Quick Links table.
Below are some noteworthy changes in the current release.

### Core libraries

- `@azure/core-auth` - add `KeyCredential`, `AzureKeyCredential` and its respective request policy.
- `@azure/core-http` - improve cross-version compatibility by adding new interfaces `WebResourceLike` and `HttpHeadersLike`.

### Event Hubs

- Additional known AMQP message properties are now accessible on received events' `systemProperties`.

### Text Analytics

- [Breaking] Removed PII entity detection methods from `TextAnalyticsClient` as well as all associated samples and documentation.
- [Breaking] Replaced `TextAnalyticsApiKeyCredential` with `AzureKeyCredential` (re-exported through this package from `@azure/core-auth`).

### Cognitive Search

- [Breaking] Package renamed to `@azure/search-documents` and version number reset to `1.0.0-preview.2`.
- Support for index management operations using the `SearchServiceClient`.
- [Breaking] `indexDocuments` on `SearchIndexClient` now takes an `IndexDocumentsBatch` object instead of a raw action array. This new type helps compose an array of actions to be performed on the index.
- [Breaking] In `SearchIndexClient`, removed options `mergeIfExists` and `uploadIfNotExists` on `uploadDocuments` and `mergeDocuments` and replaced them with new helper `mergeOrUploadDocuments`.
- The type `IndexAction` was renamed to `IndexDocumentsAction`.
- [Breaking] Removed `SearchApiKeyCredential` and replaced with `AzureKeyCredential`.
- [Breaking] Search results accessed `byPage` now have an opaque `continuationToken` in place of `nextLink` and `nextPageParameters`.

### Azure Identity

- Add support of authentication using Visual Studio Code credentials.

### Service Bus

- Initial preview of Azure Service Bus client library version 7.
- This version of library has been designed based on the [Azure SDK Design Guidelines for TypeScript]({{ site.baseurl }}{% link docs/typescript/introduction.md %}) to ensure consistency, idiomatic design, and excellent developer experience and productivity.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
