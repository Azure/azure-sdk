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

- Storage
- Azure Event Hubs
- Azure Cognitive Form Recognizer
- Azure Service Bus

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/storage-blob
$> npm install @azure/storage-blob-changfeed
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/storage-queue
$> npm install @azure/app-configuration
$> npm install @azure/search-documents
$> npm install @azure/ai-form-recognizer
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

### Storage

#### Blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md)

##### New Features
- Added support for Blob Tags, Blob Versioning, Quick Query, Jumbo Blobs, and more
- Added convenience method `createIfNotExists` for `ContainerClient`, `AppendBlobClient`, and `PageBlobClient`
- Added convenience method `deleteIfExists` for `ContainerClient` and `BlobClients`

#### Blob ChangeFeed [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob-changefeed/CHANGELOG.md)

##### New Features
- Added a preview version of this library to support change feed

#### File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### New Features
- Block size is increased to 4 GB max
- Added more mapping for Blob and DFS endpoints

#### File Share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features
- Supports 4 TB files

### Search ([CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/search/search-documents/CHANGELOG.md#1100-2020-07-06))

This is the first stable GA release of the Cognitive Search library.

#### Breaking Changes from Last Preview

- In Suggest API & Search API return values, a new property called `document` is introduced. All user-defined fields are moved inside this `document` property.
- In `analyzeText` API, the `text` parameter is moved from method level to inside `options` bag.
- In `search` API, `includeTotalResultCount` property is renamed to `includeTotalCount`.
- In `ServiceCounters`, the `skillsetCounter` property has been removed.
- Modified the names of several properties. Please refer [#9321](https://github.com/Azure/azure-sdk-for-js/issues/9321) for a detailed list of renames.

### App Configuration ([CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/appconfiguration/app-configuration/CHANGELOG.md#110-2020-07-07))

#### New Features

- Added browser support for the latest versions of Chrome, Edge and Firefox.

### Event Hubs ([CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/eventhub/event-hubs/CHANGELOG.md#530-preview1-2020-07-07))

We have released two versions of the Event Hubs library this time. An update to the stable version with bug fixes, and a preview version with new features.

#### Key Bug Fixes

- The update to the stable version i.e version 5.2.2 has improved the application reliability when closing `EventHubConsumerClient` and `Subscriptions`.

#### New Features

- The preview version 5.3.0-preview.1 now supports configuring `loadBalancingOptions` when constructing the `EventHubConsumerClient` for more control over performance tuning while load balancing.

### Form Recognizer ([CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md#100-preview4-2020-07-07))

#### New Features

- Added an `expiresOn` property to the `CopyAuthorization` type containing the time that the Copy Authorization will expire encoded as a JavaScript `Date` type.

#### Breaking Changes from Last Preview

- Replace `RecognizedReceiptArray` with the more generic `RecognizedFormArray` in the Poller response type returned by `beginRecognizeReceipts` and `beginRecognizeReceiptsFromUrl`.
- Rename the `textContent` field of the `FieldData` and `FormTableCell` types to `fieldElements` to mirror the change in its type.
- Rename the `FormField` type's `labelText` and `valueText` fields to `labelData` and `valueData` respectively, to mirror the change of their type to `FieldData`;
- Rename the `includeTextContent` request option to `includeFieldElements` to mirror the change to `FieldData` and `FormElement`.
- Rename `FieldText` to `FieldData` and `FormContent` to `FormElement` to reflect that fields may contain more than textual information.
- Rename `includeTextDetails` to `includeTextContent` in custom form and receipt recognition options to be consistent with other languages.
- Rename properties `requestedOn` to `trainingStartedOn` and `completedOn` to `trainingCompletedOn` in `CustomFormModel` and `CustomFormModelInfo` types.

### Service Bus ([CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/CHANGELOG.md#700-preview4-2020-07-07))

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

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
