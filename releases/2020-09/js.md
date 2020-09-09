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

#### @azure/eventgrid@3.0.0-beta.1  [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventgrid/eventgrid/CHANGELOG.md)

(leave blank)

##### Breaking Changes on @azure/eventgrid@3.0.0-beta.1

- The Event Grid SDK has been updated to follow the new Azure SDK Design Guidelines.

##### New Features on @azure/eventgrid@3.0.0-beta.1

- The Event Grid SDK now supports sending and deseriazing events using the Cloud Events 1.0 schema.

### @azure/service-bus@7.0.0-preview.6

#### @azure/service-bus@7.0.0-preview.6 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

#### Breaking Changes in @azure/service-bus@7.0.0-preview.6

- API Changes
  - `SessionReceiver.sessionLockedUntilUtc` is readonly and never undefined.
    [PR 10625](https://github.com/Azure/azure-sdk-for-js/pull/10625)
  - `ServiceBusClient.createDeadLetterReceiver()` has been absorbed into `createReceiver()`.
    To create a dead letter receiver:

    ```typescript
    // this same method will work with subscriptions as well.
    serviceBusClient.createReceiver(<queue>, {
      subQueue: "deadLetter"
    });
    ```

- Renames
  - The `ServiceBusManagementClient` has been renamed to `ServiceBusAdministrationClient`. See
    [Issue 11012](https://github.com/Azure/azure-sdk-for-js/issues/11012) for more details.
  - All senders and receivers are now prefixed with `ServiceBus`: `ServiceBusSender`, `ServiceBusReceiver`, `ServiceBusSessionReceiver`
  - Lock duration fields for receivers have been renamed to apply to message locks and session locks:
    - `maxMessageAutoRenewLockDurationInMs` to `maxAutoRenewLockDurationInMs`
    - `autoRenewLockDurationInMs` -> `maxAutoRenewLockDurationInMs`
  - `SessionReceiver.{get,set}State` has been renamed to `SessionReceiver.{get,set}SessionState`
  - Administration API:
    - Property `defaultMessageTtl` renamed to `defaultMessageTimeToLive` (Wherever applicable)
    - `updatedAt` renamed to `modifiedAt`
    - `ServiceBusManagementClientOptions` for `ServiceBusManagementClient` is replaced by `PipelineOptions` from `@azure/core-http`
    - `AuthorizationRule.accessRights` type has been changed to be a string union with the available rights.
 
#### New Features in @azure/service-bus@7.0.0-preview.6
  
- Support using the SharedAccessSignature from the connection string.
  ([PR 10951](https://github.com/Azure/azure-sdk-for-js/pull/10951)).
- Added a new field `amqpAnnotatedMessage` to the received message which will hold the received
  message in its raw form, complete with all parts of the message as per the [AMQP spec](https://www.amqp.org/sites/amqp.org/files/amqp.pdf).
- Added `ServiceBusAdministrationClient.ruleExists()`
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
