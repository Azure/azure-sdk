---
title: Azure SDK for JavaScript (July 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the July 2020 client library release.

#### GA

- Azure Cognitive Search

#### Updates

- Azure App Configuration
- Core libraries
- Azure Event Hubs

#### Preview

- Azure Event Hubs
- Azure Cognitive Form Recognizer
- Azure Key Vault Certificates/Keys/Secrets
- Azure Service Bus

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/app-configuration
$> npm install @azure/event-hubs
$> npm install @azure/event-hubs@next
$> npm install @azure/search-documents
$> npm install @azure/ai-form-recognizer
$> npm install @azure/keyvault-certificates
$> npm install @azure/keyvault-keys
$> npm install @azure/keyvault-secrets
$> npm install @azure/service-bus@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Search

This is the first stable release version of the Cognitive Search library.

#### New Features

- *TODO*

#### Breaking Changes from Last Preview

- *TODO*

#### Key Bug Fixes

- *TODO*

### App Configuration

#### New Features

- Added browser support for the latest versions of Chrome, Edge and Firefox.

### Event Hubs

Updates to last stable release

#### New Features

- *TODO*

#### Breaking Changes

- *TODO*

#### Key Bug Fixes

- *TODO*

New preview version

#### New Features

- *TODO*

#### Breaking Changes from Last Preview

- *TODO*

#### Key Bug Fixes

- *TODO*

### Identity

#### New Features

- *TODO*

#### Breaking Changes from Last Preview

- *TODO*

#### Key Bug Fixes

- *TODO*

### Key Vault Certificates/Keys/Secrets

#### New Features

- *TODO*

#### Breaking Changes from Last Preview

- *TODO*

#### Key Bug Fixes

- *TODO*

### Form Recognizer

#### New Features

- *TODO*

#### Breaking Changes from Last Preview

- *TODO*

#### Key Bug Fixes

- *TODO*

### Service Bus

#### New Features

- Adds abortSignal support throughout Sender and non-session Receivers.
- (Receiver|SessionReceiver).subscribe() now returns a closeable object which will stop new messages from arriving but still leave the receiver open so they can be settled via methods like complete().
- `OperationOptions` has been added for the methods under `ServiceBusManagementClient`, this adds support for abortSignal, requestOptions when creating and sending HTTP requests.

#### Breaking Changes from Last Preview

- *TODO*

#### Key Bug Fixes

- Fixed the bug where the messages scheduled in parallel with the `scheduleMessage` method have the same sequence number in response.
- Fixed the bug where the `userProperties` in a correlation filter are not populated in the rule while using the `ServiceBusManagementClient.createRule()` method.

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
