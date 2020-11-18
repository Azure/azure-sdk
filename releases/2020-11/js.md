---
title: Azure SDK for JavaScript (November 2020)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the November 2020 client library release.

#### GA

- Azure Identity
- Azure Tables
- Azure Storage Blob
- Azure Storage Data Lake
- Azure Storage File Share

#### Updates

- Azure Event Hubs
- Azure Storage Queue

#### Beta

- Azure Communication Administration
- Azure Communication Chat
- Azure Communication Common
- Azure Communication Sms
- Azure Service Bus
- Azure Metrics Advisor
- Azure Form Recognizer

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/communication-administration@next
$> npm install @azure/communication-chat@next
$> npm install @azure/communication-common@next
$> npm install @azure/communication-sms@next
$> npm install @azure/identity
$> npm install @azure/tables
$> npm install @azure/storage-blob
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/storage-queue@latest
$> npm install @azure/event-hubs@latest
$> npm install @azure/service-bus@next
$> npm install @azure/ai-metrics-advisor@next
$> npm install @azure/ai-form-recognizer@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues).

## Release highlights

### Communication

#### @azure/communication-administration [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-administration/CHANGELOG.md#100-beta3-2020-11-16)

#### New Features on @azure/communication-administration@1.0.0-beta.3

- Added support for long-running operations. See details under Breaking Changes.

#### Breaking Changes on @azure/communication-administration@1.0.0-beta.3

##### Model types

- Renamed `CancelSearchOptions` to `CancelReservationOptions`.
- Removed `GetReleaseOptions`.
- Removed `GetSearchOptions`.
- Replaced `CreateSearchOptions` with `BeginReservePhoneNumbersOptions`.
- Replaced `PurchaseSearchOptions` with `BeginPurchaseReservationOptions`.
- Replaced `ReleasePhoneNumbersOptions` with `BeginReleasePhoneNumbersOptions`.
- Renamed `PhoneNumberSearch` to `PhoneNumberReservation`.

##### `PhoneNumberReservation`

- Renamed `searchId` property to `reservationId`.

##### `PhoneNumberAdministrationClient`

- Renamed `cancelSearch` to `cancelReservation`.
- Removed `getRelease` and `GetReleaseOptions`.
- Removed `getSearch` and `GetSearchOptions`.
- Replaced `createSearch` with `beginReservePhoneNumbers` which returns a poller for the long-running operation.
- Replaced `purchaseSearch` with `beginPurchaseReservation` which returns a poller for the long-running operation.
- Replaced `releasePhoneNumbers` with `beginReleasePhoneNumbers` which returns a poller for the long-running operation.

#### @azure/communication-chat [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-chat/CHANGELOG.md#100-beta3-2020-11-16)

This release contains minor fixes.

#### @azure/communication-common [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-common/CHANGELOG.md#100-beta3-2020-11-16)

This release contains minor fixes.

#### @azure/communication-sms [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-sms/CHANGELOG.md#100-beta3-2020-11-16)

This release contains minor fixes.

### Identity

#### @azure/identity [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/identity/identity/CHANGELOG.md)

We're glad to announce a new major release of our Identity package. This release includes standardized `ManagedIdentityCredential` support across languages, as well as improvements to `VisualStudioCodeCredential`, `DeviceCodeCredential` and `InteractiveBrowserCredential`.

##### New Features on @azure/identity@1.2.0

- A new dependency has been added: the Microsoft Authentication Library (MSAL). MSAL allows us to provide secure and reliable implementations for `InteractiveBrowserCredential` and `DeviceCodeCredential`.
- `InteractiveBrowserCredential` now works for Node, which spawns the user's browser and connects via a browser-based auth code flow.
- With 1.2, we've added support for Azure Arc to our Managed Identity credential.
- Identity now supports Subject Name/Issuer (SNI) as part of authentication for ClientCertificateCredential.
- Added Active Directory Federation Services authority host support to the node credentials.
- Added support for multiple clouds on `VisualStudioCodeCredential`.
- Added support for authenticating with user assigned identities on Azure App Service.

### Azure Tables

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/tables/data-tables/CHANGELOG.md).

We're releasing a new preview of our Azure Tables library. System properties `odata.etag` and `Timestamp` are renamed to `etag` and `timestamp` to be more idiomatic with the JavaScript ecosystem.

### Azure Storage

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-blob/CHANGELOG.md)

We are releasing to add support for new service features in Azure Storage Service API version 2020-02-10.

##### New Features on @azure/storage-blob@12.3.0

- Added `BlockBlobClient.uploadData(data: Buffer | Blob | ArrayBuffer | ArrayBufferView, options)` for parallel uploading. It's available in both Node.js and browsers.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### Major Fixes on @azure/storage-file-datalake@12.2.0

- Fixed an issue where `DataLakePathClient.move()` will give an `InvalidSourceUri` error when the copy source name contains characters that need to be URL encoded.

#### @azure/storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features on @azure/storage-file-share@12.3.0

- Added `ShareClient.setProperties()`, which can be used to set both Share Tier and Share Quota.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/storage/storage-queue/CHANGELOG.md)

##### New Features on @azure/storage-queue@12.2.0

- Updated Azure Storage Service API version to 2020-02-10.

### Event Hubs

#### @azure/event-hubs [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/eventhub/event-hubs/CHANGELOG.md).

We're releasing an Azure Event Hubs client patch update with bug fixes.

##### Major Fixes on @azure/event-hubs@3.5.1

- Fixes an issue where the `processEvents` handler passed to `EventHubConsumerClient.subscribe()` could ignore the `maxWaitTimeInSeconds` parameter after a disconnection, resulting in `processEvents` being invoked rapidly without events.

### Service Bus

#### @azure/service-bus [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md)

This is the last preview version of the Azure Service Bus client library before releasing it for general availability later this month, this release includes improvements in error handling, various interface/method/type updates and internal improvements in terms of memory consumption.

##### Breaking Changes on @azure/service-bus@7.0.0-preview.8

- The `processError` passed to `Receiver.subscribe` now receives a `ProcessErrorArgs` instead of just an error. This parameter provides additional context that can make it simpler to distinguish errors that were thrown from your callback (via the `errorSource` member of `ProcessErrorArgs`) as well as giving you some information about the entity that generated the error.
- The methods to complete, abandon, defer and deadletter a message along with the method to renew message lock have been moved from the message to the receiver. With this, we now have additional validation to ensure that a peeked message cannot be used with these methods.
- Returned responses from the methods under the `ServiceBusAdministrationClient` now use a generic type `WithResponse<T>` for a cleaner API surface. The raw responses(`_response`) have been updated to return only the `{request, status, headers}`, properties such as `parsedHeaders`, `parsedBody` have been removed.
- Removed `AmqpAnnotatedMessage`, `AmqpMessageHeaders`, `AmqpMessageProperties` interfaces in favour of the ones from `@azure/core-amqp`. This is part of the move from `@azure/core-amqp` version update from 1.1.x to 2.0.0. As part of this, `userId` will not be made available as part of `AmqpMessageProperties` until its type is fixed in the upstream `rhea` library.
- Many other updates to methods, interfaces, types, and names based on user studies and internal reviews, more info at [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/CHANGELOG.md#700-preview8-2020-11-04).

##### New Features on @azure/service-bus@7.0.0-preview.8

- A helper method parseServiceBusConnectionString has been added which validates and parses a given connection string for Azure Service Bus. You can use this to extract the namespace and entityPath details from the connection string.
- Tracing, using [@azure/core-tracing](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/core/core-tracing/README.md), has been added for sending and receiving of messages.

### Metrics Advisor

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md)

This version 1.0.0-beta.2  incorporates feedback from UX Studies and Architecture Board Review.

##### New Features on @azure/ai-metrics-advisor@1.0.0-beta.2

- Parameters of `Date` type now also accept strings
- Handle potential new data feed source types gracefully

##### Breaking Changes on @azure/ai-metrics-advisor@1.0.0-beta.2

- Various renames of types, methods, and properties to improve the API surface.  Please see the [CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md) for more details.

### Form Recognizer

#### @azure/ai-form-recognizer [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md)

This beta package targets Azure Form Recognizer API version  `2.1-preview.2`, and introduces support for its new form recognition features, including:

##### New Features on @azure/ai-form-recognizer@3.1.0-beta.1

- Support for two new prebuilt recognition models for invoices and business cards through the `beginRecognizeInvoices` and `beginRecognizeBusinessCards` methods (as well as their `FromUrl` counterparts) of `FormRecognizerClient`.
- Support for "Selection Marks" as a new fundamental form element. A selection mark is a mark such as a checkbox or a radio button on a form that can be either "selected" or "unselected". This type is supported in content recognition where it is a new type of `FormElement` as well as in custom and prebuilt model recognition where it is a new type of `FormField`.
- Support for the bitmap image format (with content type "image/bmp") in prebuilt model recognition and content recognition. Custom form recognition does not currently support bitmap images.
- A `locale` option for all prebuilt model methods, allowing for the specification of a document's origin to assist the service with correct analysis of the documents contents.
- A `language` option for the content recognition method `beginRecognizeContent` that specifies the document's language (the service supports language auto-detection, so this option allows for forcing the service to use a particular language).
- A `pages` option for the content recognition method `beginRecognizeContent` that specifies which pages in a multi-page document (a document with a content type of "application/pdf" or "image/tiff") should be analyzed, allowing for the analysis of only certain pages of a document.
- Two new response fields:
  - A `boundingBox` property on recognized `FormTable` objects that indicates the extent of the entire table on the page (previously, only individual elements had `boundingBox`).
  - An `appearance` property of `FormLine` objects that contains information about the line's appearance in the document such as its style (e.g. "handwritten"). 
  
In addition to the above form recognition features, there is also a new set of model training features, including:

- Creating composed models from an array of model GUIDs through the `beginCreateComposedModel` method of `FormTrainingClient`. Composed models combine a set of custom labeled models into a single model with a unique model GUID, and when the new composed model is used for recognition, it will insert a classification step that determines the most appropriate of its submodels to use for recognition. This feature also encompasses some new fields, including:
  - A `properties` field of `CustomFormModelInfo` and `CustomFormModel` that may optionally contain extra properties of the custom model. Currently, the only such property is `isComposedModel`, which indicates that the model is a composed model rather than a standard trained model.
  - A `modelId` property of `RecognizedForm` that contains the GUID of the specific submodel that was used to analyze the form and generate the result.
  - A `formTypeConfidence` property of `RecognizedForm` that represents the service's confidence that it chose  the correct submodel to use during analysis (and therefore the correct value of `formType`).
- A `modelName` option for model training (both `beginTraining` and `beginCreateComposedModel`) that can specify a human-readable name for a model. The model name does not have to be unique, and because models are immutable it cannot be changed. The `modelName` field of `CustomFormModelInfo` and `CustomFormModel` will now contain the name of the model, if one was associated during model creation.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
