---
title: Azure SDK for JavaScript (September 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the September 2020 client library release.

#### GA

- Azure Form Recognizer

#### Updates

- Core Libraries
- Azure Storage
- Azure Event Hubs

#### Preview

- Identity
- Azure Event Grid
- Azure Key Vault
- Azure Service Bus
- Azure Tables
- Azure Text Analytics
- Azure Storage Blob Changefeed

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/storage-blob-changefeed
$> npm install @azure/storage-queue
$> npm install @azure/storage-file-share
$> npm install @azure/storage-datalake
$> npm install @azure/storage-blob
$> npm install @azure/ai-form-recognizer
$> npm install @azure/event-hubs
$> npm install @azure/identity@next
$> npm install @azure/eventgrid@next
$> npm install @azure/keyvault-keys@next
$> npm install @azure/keyvault-secrets@next
$> npm install @azure/keyvault-certificates@next
$> npm install @azure/keyvault-admin@next
$> npm install @azure/service-bus@next
$> npm install @azure/data-tables@next
$> npm install @azure/ai-text-analytics@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

---

=== COPY THIS AND ADD THE INFORMATION OF YOUR PACKAGE: ===

Keep in mind that:

- Including the package name in the headers makes the URL links work for multiple packages.
- Only include customer-facing changes.
- The format of this file will be cleaned up once all of your proposals are in.

---

### _Package name_

#### _Package name_ [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/<service-folder>/<package-folder>/CHANGELOG.md)

(leave blank)

##### Breaking Changes on _Package name_

- _Add one or more, or remove the "Breaking Changes on ..." entire section._

##### New Features on _Package name_

- _Add one or more, or remove the "New Features on ..." section._

##### Major Fixes on _Package name_

- _Add one or more, or remove the "Major Fixes on ..." section._

## Latest Releases

### @azure/event-hubs@5.3.0

#### @azure/event-hubs@5.3.0 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventhub/event-hubs/CHANGELOG.md)

#### New Features in @azure/event-hubs@5.3.0

- Adds `loadBalancingOptions` to the `EventHubConsumerClient` to add control around
  how aggressively the client claims partitions while load balancing.
  ([PR 9706](https://github.com/Azure/azure-sdk-for-js/pull/9706)).
- Support using the SharedAccessSignature from the connection string.
  ([PR 10951](https://github.com/Azure/azure-sdk-for-js/pull/10951)).

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
