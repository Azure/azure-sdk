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
$> npm install @azure/search-documents
$> npm install @azure/ai-form-recognizer
$> npm install @azure/keyvault-certificates
$> npm install @azure/keyvault-keys
$> npm install @azure/keyvault-secrets
$> npm install @azure/service-bus@next
```

To install the stable version of the Event Hubs library:

```bash
$> npm install @azure/event-hubs
```
To install the preview version of the Event Hubs library:

```bash
$> npm install @azure/event-hubs@next
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

We have released two versions of the Event Hubs library this time: updates to the stable version, and a new preview version.

Updates to last stable release

#### Key Bug Fixes

- Improved the reliability of closing `EventHubConsumerClient` and `Subscriptions`.

New preview version

#### New Features

- The `EventHubConsumerClient` now supports configuring `loadBalancingOptions` for more control over performance tuning while load balancing.

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

- Standardized methods on senders and receivers to use the `Messages` suffix, removed dedicated methods dealing with a single message to reduce API surface.
- Standardized methods that peek and receive a given number of messages to use a similar signature.
  Old: `peekMessages(options);` and `receiveMessages(maxMessages, options);`
  New: `peekMessages(maxMessageCount, options);` and `receiveMessages(maxMessageCount, options);`
- Removed `isReceivingMessages` method on the `Receiver`.
- Management api updates

  - Renamed `createdOn`, `accessedOn` and `modifiedOn` properties to `createdAt`, `accessedAt` and `modifiedAt`, updated the corresponding type from `ISO-8601 timestamp string` to the `Date` type in the responses for the `runtimeInfo` methods for Queue, Topic and Subscription.
  - The property `top` in the options passed to any of the methods that get information for multiple entities like `getQueues` or `getQueuesRuntimeInfo` is renamed to `maxCount`.
  - The "update" methods (`updateQueue`, `updateTopic` and `updateSubscription`) now require all properties on the given queue/topic/subscription object to be set though only a subset of them are actually updatable. Therefore, the suggested flow is to use the "get" methods to get the queue/topic/subscription object, update as needed, and then pass it to the "update" methods.

#### Key Bug Fixes

- Fixed the bug where the messages scheduled in parallel with the `scheduleMessage` method have the same sequence number in response.
- Fixed the bug where the `userProperties` in a correlation filter are not populated in the rule while using the `ServiceBusManagementClient.createRule()` method.

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
