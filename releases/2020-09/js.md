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
npm install @azure/ai-form-recognizer
npm install @azure/storage-queue
npm install @azure/storage-file-share
npm install @azure/storage-file-datalake
npm install @azure/storage-blob
npm install @azure/event-hubs
npm install @azure/identity@next
npm install @azure/eventgrid@next
npm install @azure/keyvault-keys@next
npm install @azure/keyvault-secrets@next
npm install @azure/keyvault-certificates@next
npm install @azure/keyvault-admin@next
npm install @azure/service-bus@next
npm install @azure/data-tables@next
npm install @azure/ai-text-analytics@next
npm install @azure/storage-blob-changefeed@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

### Azure Form Recognizer ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md))

We are pleased to announce the general availability (GA) of the `@azure/ai-form-recognizer` package version 3.0.0.

#### Features
- Train and utilize custom and/or predefined AI models to extract information from text document images.
- Uses the Azure Form Recognizer v2.0 (GA) endpoint for the latest service features.

### Azure Storage

#### Major Fixes

- Reverted the workaround for axios where the Content-Length header is removed before the request is passed to underlying http client. The workaround leads to HMAC signature miss-match for users using http clients like the default node http client which do not set the header themselves.

#### New Features in Azure Storage Blob ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md))

- Supported [Tags Conditional Operations](https://docs.microsoft.com/rest/api/storageservices/specifying-conditional-headers-for-blob-service-operations#tags-conditional-operations). Now you can specify conditions against the tags on a blob resource for several read and write operations.
- The Static Website Service now supports a DefaultIndexDocumentPath for a global HTTP 200 route within the static website. You can get it by `BlobServiceClient.getProperties()` and set it via `blobServiceClient.setProperties()`.
- High level upload functions `BlockBlobClient.uploadFile()`, `BlockBlobClient.uploadStream()` and `BlockBlobClient.uploadBrowserData()` now support setting tier like `Hot`, `Cool` or `Archive` via the `tier` option.

#### New Features in Azure Data Lake Storage ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md))

- Supported Query Blob Contents. Added a new API `DataLakeFileClient.query()`. This API applies a simple Structured Query Language (SQL) statement on a blob's contents and returns only the queried subset of the data. You can also call Query Blob Contents to query the contents of a version or snapshot. Learn more at [Query Blob Content REST API](https://docs.microsoft.com/rest/api/storageservices/query-blob-contents)

#### New Features in Azure Storage File Share ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md))

- Supported share soft delete. Added `undeleteShare` to `ShareServiceClient`. `listShares` now can return deleted shares. Note: share soft delete only take effect on accounts with share soft delete feature enabled.

#### New Features in Azure Storage Blob Change Feed ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob-changefeed/CHANGELOG.md))

- Added new constructor overloads for the `BlobChangeFeedClient` to support initializing with storage account credentials.

### Azure Event Hubs ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/eventhub/event-hubs/CHANGELOG.md))

#### New Features

- Added `loadBalancingOptions` to the `EventHubConsumerClient` to add control around how aggressively the client claims partitions while load balancing.
- Support a new key-value pair in the connection string for the Shared Access Signature. The key to use is `SharedAccessSignature`.

#### Azure Event Grid ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/eventgrid/eventgrid/CHANGELOG.md))

We're releasing a new preview for the Azure Event Grid client, with some API improvements. This release is a preview of our efforts to create a client library that is user friendly and idiomatic to the JavaScript ecosystem. The reasons for most of the changes in this update can be found in the [Azure SDK Design Guidelines for TypeScript](https://azure.github.io/azure-sdk/typescript_introduction.html).

##### New Features

- The Event Grid SDK now supports sending and deserializing events using the [Cloud Events 1.0 schema](https://cloudevents.io/).

#### Azure Key Vault

We are introducing a new package `@azure/keyvault-admin` that provides support for:
- role-based access control (RBAC) operations like assigning, deleting and retrieving role assignments, and retrieving role definitions.
- backup/restore operations for whole Key Vault instances, and selective restores of keys.

For Key Vault Keys, Secrets and Certificates packages, we are releasing a beta for the next version that exports a function to parse the key/secret/certificate id and return the different components like the vault url, name and version of the key/secret/certificate.

#### Changelogs

- [Key Vault Keys](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/keyvault/keyvault-keys/CHANGELOG.md)
- [Key Vault Secrets](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/keyvault/keyvault-secrets/CHANGELOG.md)
- [Key Vault Certificates](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/keyvault/keyvault-certificates/CHANGELOG.md)
- [Key Vault Administration](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/keyvault/keyvault-admin/CHANGELOG.md)

### Azure Service Bus ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/CHANGELOG.md))

We're releasing a new preview for the Azure Service Bus, with some API changes and new features.

#### Breaking Changes

- API Changes:
  - `SessionReceiver.sessionLockedUntilUtc` is readonly and never undefined.
  - `ServiceBusClient.createDeadLetterReceiver()` has been absorbed into `createReceiver()`.
    To create a dead letter receiver:

    ```typescript
    // this same method will work with subscriptions as well.
    serviceBusClient.createReceiver(<queue>, {
      subQueue: "deadLetter"
    });
    ```

- Renames:
  - The `ServiceBusManagementClient` has been renamed to `ServiceBusAdministrationClient`. See
    [Issue 11012](https://github.com/Azure/azure-sdk-for-js/issues/11012) for more details.
  - Sender, Receivers, and the ReceivedMessage interfaces are now prefixed with `ServiceBus`: `ServiceBusSender`, `ServiceBusReceiver`, `ServiceBusSessionReceiver`, `ServiceBusReceivedMessage` and `ServiceBusReceivedMessageWithLock`.
  - Lock duration fields for receivers have been renamed to apply to message locks and session locks:
    - `maxMessageAutoRenewLockDurationInMs` to `maxAutoRenewLockDurationInMs`
    - `autoRenewLockDurationInMs` -> `maxAutoRenewLockDurationInMs`
  - `SessionReceiver.{get,set}State` has been renamed to `SessionReceiver.{get,set}SessionState`
  - Administration API:
    - Property `defaultMessageTtl` renamed to `defaultMessageTimeToLive` (Wherever applicable)
    - `updatedAt` renamed to `modifiedAt`
    - `ServiceBusManagementClientOptions` for `ServiceBusManagementClient` is replaced by `PipelineOptions` from `@azure/core-http`
    - `AuthorizationRule.accessRights` type has been changed to be a string union with the available rights.

#### New Features

- Support a new key-value pair in the connection string for the Shared Access Signature. The key to use is `SharedAccessSignature`.
- Added a new field `amqpAnnotatedMessage` to the received message which will hold the received
  message in its raw form, complete with all parts of the message as per the [AMQP spec](https://www.amqp.org/sites/amqp.org/files/amqp.pdf).
- Added `ServiceBusAdministrationClient.ruleExists()`
- Options to create a queue and topic now support `enableExpress` boolean property. `enableExpress` indicates whether Express Entities are enabled on a queue or topic. An express queue holds a message in memory temporarily before writing it to persistent storage.

### Azure Tables ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/tables/data-tables/CHANGELOG.md))

We're releasing the first beta version of the new Azure Tables client, following our [guidelines](https://azure.github.io/azure-sdk/typescript_introduction.html) which ensures it is idiomatic, consistent, and diagnosable. It supports essential operations of the service, such as creating and deleting tables, as well as querying, creating, reading, updating and deleting entities.

### Azure Text Analytics ([Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/textanalytics/ai-text-analytics/CHANGELOG.md))

##### New Features

- We are now targeting the service's v3.1-preview.2 API as the default instead of v3.0.
- We have added support for opinion mining feature of Sentiment Analysis. To get this support, pass `includeOpinionMining` as True when calling the `analyzeSentiment` endpoint.
- We have added the `recognizePiiEntities` API which returns entities containing personal information for a batch of documents and also returns the redacted text.
- The `length` and `offset` properties are added to the `SentenceSentiment`, `Entity`, `Match`, `PiiEntity` and `CategorizedEntity` interfaces to represent the length of the sentence's text and its offset from the start of the document. The unit of distance used is UTF-16 code points.
- `bingEntitySearchApiId` property is now returned for entities returned by `recognizeLinkedEntities` API and is added to the `LinkedEntity` interface. This property is to be used in conjunction with the Bing Entity Search API to fetch additional relevant information about the returned entity.

## Latest Releases

View all the [latest versions of JavaScript packages][js-latest-releases].

{% include refs.md %}
