---
title: Azure SDK for JavaScript (January 2020)
layout: post
date: 2020-01-13
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the January 2020 client library release. This represents the seventh release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This release includes:
- libraries that are moving out of the preview stage.
    - Azure Event Hubs
    - Azure Key Vault for Certificates
    - Azure App Configuration
- new preview for Azure Text Analytics

## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/app-configuration
    $> npm install @azure/keyvault-certificates
    $> npm install @azure/keyvault-keys
    $> npm install @azure/keyvault-secrets
    $> npm install @azure/event-hubs
    $> npm install @azure/eventhubs-checkpointstore-blob
    $> npm install @azure/storage-blob
    $> npm install @azure/storage-file-share
    $> npm install @azure/storage-file-datalake
    $> npm install @azure/storage-queue
    $> npm install @azure/ai-text-analytics

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed change logs for each of the libraries can be found in the source repository linked to in the Quick Links table.
Below are some noteworthy changes in the current release.

### Event Hubs

This release marks the general availability of the `@azure/event-hubs` library and the companion `@azure/eventhubs-checkpointstore-blob` package.
Notable changes since the last preview are
- Usage of the new `code` property on the `MessagingError` rather than `name` to identify the different kinds of errors that can occur when sending or receiving events.
- The Event Hubs library now respects the values set in the environment variable `AZURE_LOG_LEVEL` to control the logging levels.
- Event position is now passed via options to the `subscribe()` method to specify the starting position when receiving events in the absence of checkpoint store.
- Improved retry and error handling when subscribing to events. The client will call your error handler when retry attempts are exhausted and then resume receiving events from the last checkpointed position.

### Text Analytics

- The new `@azure/ai-text-analytics` library supports only the Text Analytics Service v3.0-preview.1 API.
The previous `@azure/cognitiveservices-textanalytics` library supported only earlier service versions.
- Added support for:
  - Subscription key and AAD authentication.
  - Separation of Entity Recognition and Entity Linking.
  - Identification of Personally Identifiable Information.
  - Analyze Sentiment APIs including analysis for mixed sentiment.

### Storage (File Shares, File Data Lake, Blobs, Queues)
  - Name properties on clients now support more kinds of endpoints(IPv4/v6 hosts, single word domains).
  


## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include shared/refs.md %}
