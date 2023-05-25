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
- Azure Service Bus

#### Updates

- Azure Event Hubs
- Azure Storage Queue

#### Beta

- Azure Communication Administration
- Azure Communication Chat
- Azure Communication Common
- Azure Communication SMS
- Azure Metrics Advisor
- Azure Form Recognizer
- Azure Text Analytics

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/identity
$> npm install @azure/tables
$> npm install @azure/storage-blob
$> npm install @azure/storage-file-datalake
$> npm install @azure/storage-file-share
$> npm install @azure/service-bus
$> npm install @azure/storage-queue
$> npm install @azure/event-hubs
$> npm install @azure/communication-administration@next
$> npm install @azure/communication-chat@next
$> npm install @azure/communication-common@next
$> npm install @azure/communication-sms@next
$> npm install @azure/ai-metrics-advisor@next
$> npm install @azure/ai-form-recognizer@next
$> npm install @azure/ai-text-analytics@next
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues).

## Release highlights

### Service Bus

#### @azure/service-bus [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/CHANGELOG.md)

This release marks the general availability of version 7 of the `@azure/service-bus` package.

##### Breaking Changes on @azure/service-bus@7.0.0

- Please see the [migration guide to move from Service Bus V1 to Service Bus V7](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/migrationguide.md) to understand the major breaking changes.
- For all the updates in version `7.0.0`(since version `1.1.x`) across multiple previews, check out the [Service Bus changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/servicebus/service-bus/CHANGELOG.md#700-2020-11-23)

##### New Features on @azure/service-bus@7.0.0

- A new `ServiceBusAdministrationClient` to perform operations like create/get/list/update/delete on queues/topics/subscriptions/rules. These were already available as part of a separate package `@azure/arm-servicebus` that uses Azure Resource Manager APIs but had the drawback of not supporting connection strings.
- Ability to create a batch of messages with the smarter `ServiceBusSender.createBatch()` and `ServiceBusMessageBatch.tryAddMessage()` APIs. This will help you manage the messages to be sent in the most optimal way.
- Ability to configure the retry policy used by the operations on the client, sender and receivers.
- Ability to cancel async operations on the client, sender and receivers and the management operations using the abort signal from @azure/abort-controller.

### Identity

#### @azure/identity [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/identity/identity/CHANGELOG.md)

We're glad to announce a new major release of our Identity package. This release includes standardized `ManagedIdentityCredential` support across languages, as well as improvements to `VisualStudioCodeCredential`, `DeviceCodeCredential` and `InteractiveBrowserCredential`.

##### New Features on @azure/identity@1.2.0

- A new dependency has been added: the Microsoft Authentication Library (MSAL). MSAL allows us to provide secure and reliable implementations for `InteractiveBrowserCredential` and `DeviceCodeCredential`.
- `InteractiveBrowserCredential` now works for Node, which spawns the user's browser and connects via a browser-based auth code flow.
- With 1.2, we've added support for Azure Arc to our Managed Identity credential.
- Identity now supports Subject Name/Issuer (SNI) as part of authentication for ClientCertificateCredential.
- Added Active Directory Federation Services authority host support to the node credentials.
- Added support for multiple clouds on `VisualStudioCodeCredential`.
- Added support for authenticating with user assigned identities on Azure App Service.

### Azure Storage

#### @azure/storage-blob [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-blob/CHANGELOG.md)

We are releasing to add support for new service features in Azure Storage Service API version 2020-02-10.

##### New Features on @azure/storage-blob@12.3.0

- Added `BlockBlobClient.uploadData(data: Buffer | Blob | ArrayBuffer | ArrayBufferView, options)` for parallel uploading. It's available in both Node.js and browsers.

#### @azure/storage-file-datalake [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-datalake/CHANGELOG.md)

##### Major Fixes on @azure/storage-file-datalake@12.2.0

- Fixed an issue where `DataLakePathClient.move()` will give an `InvalidSourceUri` error when the copy source name contains characters that need to be URL encoded.

#### @azure/storage-file-share [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-file-share/CHANGELOG.md)

##### New Features on @azure/storage-file-share@12.3.0

- Added `ShareClient.setProperties()`, which can be used to set both Share Tier and Share Quota.

#### storage-queue [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/storage/storage-queue/CHANGELOG.md)

##### New Features on @azure/storage-queue@12.2.0

- Updated Azure Storage Service API version to 2020-02-10.

### Event Hubs

#### @azure/event-hubs [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/eventhub/event-hubs/CHANGELOG.md).

We're releasing an Azure Event Hubs client patch update with bug fixes.

##### Major Fixes on @azure/event-hubs@3.5.1

- Fixes an issue where the `processEvents` handler passed to `EventHubConsumerClient.subscribe()` could ignore the `maxWaitTimeInSeconds` parameter after a disconnection, resulting in `processEvents` being invoked rapidly without events.

### Azure Tables

#### @azure/data-tables [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/tables/data-tables/CHANGELOG.md).

We're releasing a new preview of our Azure Tables library. System properties `odata.etag` and `Timestamp` are renamed to `etag` and `timestamp` to be more idiomatic with the JavaScript ecosystem.

### Metrics Advisor

#### @azure/ai-metrics-advisor [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md)

This version 1.0.0-beta.2  incorporates feedback from UX Studies and Architecture Board Review.

##### New Features on @azure/ai-metrics-advisor@1.0.0-beta.2

- Parameters of `Date` type now also accept strings
- Handle potential new data feed source types gracefully

##### Breaking Changes on @azure/ai-metrics-advisor@1.0.0-beta.2

- Various renames of types, methods, and properties to improve the API surface.  Please see the [CHANGELOG](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/metricsadvisor/ai-metrics-advisor/CHANGELOG.md) for more details.

### Communication

#### @azure/communication-administration [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-administration_1.0.0-beta.3/sdk/communication/communication-administration/CHANGELOG.md#100-beta3-2020-11-16)

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

#### @azure/communication-chat [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-chat/CHANGELOG.md#100-beta3-2020-11-16)

This release contains minor fixes.

#### @azure/communication-common [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-common/CHANGELOG.md#100-beta3-2020-11-16)

This release contains minor fixes.

#### @azure/communication-sms [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/communication/communication-sms/CHANGELOG.md#100-beta3-2020-11-16)

This release contains minor fixes.

### Form Recognizer

#### @azure/ai-form-recognizer [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/formrecognizer/ai-form-recognizer/CHANGELOG.md)

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

### Text Analytics

#### @azure/ai-text-analytics [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/main/sdk/textanalytics/ai-text-analytics/CHANGELOG.md)

This beta package targets Azure Text Analytics API version  `3.1-preview.3`, and introduces support for its new text analytics features, including:

##### New Features on @azure/ai-text-analytics@5.1.0-beta.3

- Support for the new API for batch tasks processing through the `beginAnalyze` method. The currently supported tasks are Named Entity Recognition, Personally identifiable Information, and Key Phrase Extraction.
- Support for the recognition of healthcare entities API with the introduction of the `beginAnalyzeHealthcare` method. Since the Health API is currently only available in a gated preview, you need to have your subscription on the service's allow list. Also, note that since this is a gated preview, AAD is not supported. For more information, see [the Text Analytics for Health documentation](https://docs.microsoft.com/azure/cognitive-services/text-analytics/how-tos/text-analytics-for-health?tabs=ner#request-access-to-the-public-preview).

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
