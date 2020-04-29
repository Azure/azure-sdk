---
title: Azure SDK for JavaScript (May 2020)
layout: post
date: 2020-05-12
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the May 2020 client library release.

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

Detailed change logs for each of the libraries can be found in the source repository linked to in the Quick Links table.
Below are some noteworthy changes in the current release.

### Core libraries

- `@azure/core-tracing`
  - [BREAKING] Migrate to OpenTelemetry 0.6 using the new `@opentelemetry/api` package. There were a few breaking changes:
    - `SpanContext` now requires traceFlags to be set.
    - `Tracer` has removed `recordSpanData`, `getBinaryFormat`, and `getHttpTextFormat`.
    - `Tracer.getCurrentSpan` returns `undefined` instead of `null` when unset.
    - `Link` objects renamed `spanContext` property to `context`.
- `@azure/core-auth`
  - Removed the below interfaces from the public API of this package as they are defined elsewhere.
    - OperationOptions
    - OperationRequestOptions
    - OperationTracingOptions
    - AbortSignalLike
- `@azure/core-http`
  - Added support for `text/plain` endpoints.
  - Updated to use OpenTelemetry 0.6 via `@azure/core-tracing`.
- `@azure/core-amqp`
  - Added compatiblity with TypeScript versions 3.1 through 3.6+.
  - Added a new method `refreshConnection()` on the `ConnectionContextBase` to replace the `connection` property on it with a new rhea-promise `Connection` object.
- `@azure/core-lro` - Moved `@opentelemetry/types` to the `devDependencies`.

### Event Hubs

- Updated `EventHubProducerClient.sendBatch()` to allow sending an array of events.
- Improved performance of `EventDataBatch.tryAdd()` method.

### Azure Identity

- [TODO]

### Cognitive Search

- [TODO]

### Form Recognizer

- Fixed an issue in reference docs.

### Service Bus

7.0.0-preview.2

- send() can now send an array of messages which will transparently batch and send them to Service Bus
- Message settlement can now use the management link, allowing for settlement even when the original receiver has been closed
- New sample to demonstrate how to round-robin sessions in a queue or subscription

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
