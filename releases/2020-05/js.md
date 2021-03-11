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

- The `EventHubProducerClient.sendBatch()` method now has an overload that takes an array of events.
If you know beforehand that your events would fit under the message size restrictions, this is an easier way to send events instead of creating an `EventDataBatch` and filling it one by one.
- Improved efficiency of the `EventDataBatch.tryAdd()` method which will improve your send performance when adding many events to the batch.

### Cognitive Search

- Added support for Indexers API (Create, Get, List, etc.)
- Added support for Datasources API.(Create, Get, List, etc.)

### Form Recognizer

We released a new `@azure/ai-form-recognizer` library in late April that supports the Form Recognizer Service v2.0-preview API. The previous `@azure/cognitiveservices-formrecognizer` library supports earlier service versions. This new version added support for:
- Training custom form models
- Listing/retrieving/deleting existing models
- Form content/layout recognition
- Custom form recognition
- USA receipt recognition.

### Service Bus

The second preview for Service Bus (7.0.0-preview.2) has the below improvements:

- The `ServiceBusSender.send()` method now has an overload that takes an array of events.
If you know beforehand that your messages would fit under the message size restrictions, this is an easier way to send events instead of creating an `ServiceBusMessageBatch` and filling it one by one.
- When not using sessions, messages can now be settled even after the receiver has been closed.
- The `createSender` and `createSessionReceiver` methods are now async. The promise returned by them are resolved after the link is successfully established with the service.
- New sample to demonstrate how to receive messages from multiple sessions in a queue or subscription using session receivers.
- Improved reliability of connection recovery and error reporting when receiving messages via the subscribe() method.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
