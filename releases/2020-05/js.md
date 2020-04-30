---
title: Azure SDK for JavaScript (May 2020)
layout: post
date: 2020-05-01
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the {{ page.date | date: "%B %Y" }} client library release.

- Updates for Core libraries
- Update for Azure Event Hubs
- New preview of Azure Identity
- New preview of Azure Cognitive Search
- New preview of Azure Cognitive Form Recognizer
- New preview of Azure Service Bus

## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/event-hubs
    $> npm install @azure/identity
    $> npm install @azure/search-documents
    $> npm install @azure/ai-form-recognizer
    $> npm install @azure/service-bus@next

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

### Event Hubs

- Updated `EventHubProducerClient.sendBatch()` to allow sending an array of events.
- Improved performance of `EventDataBatch.tryAdd()` method.

### Azure Identity

- This release contains bug fixes to environment variables and quality of service improvements.

### Cognitive Search

- Added support for Indexers API (Create, Get, List, etc.)
- Added support for Datasources API.(Create, Get, List, etc.)

### Form Recognizer

- We released a new `@azur/ai-form-recognizer` library in late April that supports the Form Recognizer Service v2.0-preview API. The previous `@azure/cognitiveservices-formrecognizer` library supports earlier service versions. This new version added support for:
  - Training custom form models
  - Listing/retriving/deleting existing models
  - Form content/layout recognition
  - Custom form recognition
  - USA receipt recognition.

### Service Bus

7.0.0-preview.2

- send() can now send an array of messages which will transparently batch and send them to Service Bus
- Message settlement can now use the management link, allowing for settlement even when the original receiver has been closed
- New sample to demonstrate how to round-robin sessions in a queue or subscription

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
