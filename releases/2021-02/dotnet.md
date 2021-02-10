---
title: Azure SDK for .NET (February 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our February 2021 client library releases.

#### GA

- Event Hubs
- Search

#### Updates

- _Add packages_

#### Beta

- Metrics Advisor
- Form Recognizer
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.AI.MetricsAdvisor --version 1.0.0-beta.3

$> dotnet add package Azure.Messaging.EventHubs
$> dotnet add package Azure.Messaging.EventHubs.Processor

$> dotnet add package Azure.Search.Documents

$> dotnet add package Azure.AI.FormRecognizer --version 3.1.0-beta.2
$> dotnet add package Azure.AI.TextAnalytics --version 5.1.0-beta.4
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

#### New Features

- Connection strings can now be parsed into their key/value pairs using the `EventHubsConnectionStringProperties` class.

- The body of an event has been moved to the `EventData.EventBody` property and makes use of the new `BinaryData` type.  To preserve backwards compatibility, the existing `EventData.Body` property has been preserved with the current semantics.

- It is now possible to specify a custom endpoint to use for establishing the connection to the Event Hubs service in the `EventHubConnectionOptions` used by each of the clients.

#### Key Bug Fixes

- Upgraded the `Microsoft.Azure.Amqp` library to resolve crashes occurring in .NET 5.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

#### New Features

- Additional options for tuning load balancing have been added to the `EventProcessorClientOptions`.

- It is now possible to specify a custom endpoint to use for establishing the connection to the Event Hubs service in the `EventHubConnectionOptions` for the processor.

- Interactions with Blob Storage have been tuned for better performance and more efficient resource use.  This will also improve start-up time, especially when using the `Greedy` load balancing strategy.

#### Key Bug Fixes

- Upgraded the `Microsoft.Azure.Amqp` library to resolve crashes occurring in .NET 5.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/search/Azure.Search.Documents/CHANGELOG.md#1120-2021-02-10)

#### New Features
- Added setters for `MaxLength` and `MinLength` in `LengthTokenFilter`.
- Added a public constructor for `SearchIndexingBufferedSender<T>`.
- Added `IndexActionEventArgs<T>` to track indexing actions.
- Added `IndexActionCompletedEventArgs<T>` to track the completion of an indexing action.
- Added `IndexActionFailedEventArgs<T>` to track the failure of an indexing action.

#### Breaking Changes

- Renamed `SearchIndexingBufferedSenderOptions<T>.MaxRetries` to `SearchIndexingBufferedSenderOptions<T>.MaxRetriesPerIndexAction`.
- Renamed `SearchIndexingBufferedSenderOptions<T>.MaxRetryDelay` to `SearchIndexingBufferedSenderOptions<T>.MaxThrottlingDelay`.
- Renamed `SearchIndexingBufferedSenderOptions<T>.RetryDelay` to `SearchIndexingBufferedSenderOptions<T>.ThrottlingDelay`.
- Removed the helper method `SearchClient.CreateIndexingBufferedSender<T>()`. Instead, callers are expected to use the public constructor of `SearchIndexingBufferedSender<T>`.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/metricsadvisor/Azure.AI.MetricsAdvisor/CHANGELOG.md#100-beta3-2021-02-09)

#### New Features

- Added support for AAD authentication in `MetricsAdvisorClient` and `MetricsAdvisorAdministrationClient`.

#### Breaking Changes

- The constructors of multiple classes, including `DataFeed`, `AnomalyDetectionConfiguration`, `AnomalyAlertConfiguration`, `EmailNotificationHook`, and `WebNotificationHook` are now parameterless. To see the full list of constructors affected, please check the Changelog.
- Collection properties are not settable anymore.
- `Create` and `Add` methods won't return the ID of the created entity anymore. A full object will be returned instead.

#### Key Bug Fixes

- Fixed a bug in which setting `WebNotificationHook.CertificatePassword` would actually set the property `Username` instead.
- Fixed a bug in which an `ArgumentNullException` was thrown when getting a data feed from the service as a viewer.
- Fixed a bug in which a data feed's administrators and viewers could not be set during creation.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#310-beta2-2021-02-09)

#### Breaking Changes

- Renamed the model `Appearance` to `TextAppearance`.
- Renamed the model `Style` to `TextStyle`.
- Renamed the extensible enum `TextStyle` to `TextStyleName`.
- Changed object type for property `Pages` under `RecognizeContentOptions` from `IEnumerable` to `IList`.
- Changed model type of `Locale` from `string` to `FormRecognizerLocale` in `RecognizeBusinessCardsOptions`, `RecognizeInvoicesOptions`, and `RecognizeReceiptsOptions`.
- Changed model type of `Language` from `string` to `FormRecognizerLanguage` in `RecognizeContentOptions`.

### Text Analytics  [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#510-beta4-2021-02-10)

#### New Features

- Added property `Length` to `CategorizedEntity`, `SentenceSentiment`, `LinkedEntityMatch`, `AspectSentiment`, `OpinionSentiment`, and `PiiEntity`.
- `StringIndexType` has been added to all endpoints that expose the new properties `Offset` and `Length` to determine the encoding the service should use. It is added into the `TextAnalyticsRequestOptions` class and default for this SDK is `UTF-16`.
- `AnalyzeHealthcareEntitiesOperation` now exposes the properties `CreatedOn`, `ExpiresOn`, `LastModified`, and `Status`.
- `AnalyzeBatchActionsOperation ` now exposes the properties `CreatedOn`, `ExpiresOn`, `LastModified`, `Status`, `ActionsFailed`, `ActionsInProgress`,  `ActionsSucceeded`, `DisplayName` and `TotalActions`.

#### Breaking Changes

- Analyze healthcare was redesigned. It can be accessed now by calling the `StartHealthcareEntities` and `StartHealthcareEntitiesAsync` methods. All operations now support result pagination. Renames and structure overall changed. For more information, please see the changelog notes.
- Analyze operation batch was redesigned. It can be accessed now by calling the `StartAnalyzeBatchActions` and `StartAnalyzeBatchActionsAsync` methods. All operations now support result pagination. Renames and structure overall changed. For more information, please see the changelog notes.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
