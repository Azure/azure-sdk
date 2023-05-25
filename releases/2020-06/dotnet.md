---
title: Azure SDK for .NET (June 2020)
layout: post
date: 2020-06-09
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our {{ page.date | date: "%B %Y" }} client library releases.

#### GA

- Text Analytics

#### Updates


#### Preview

- Form Recognizer
- Identity
- Search
- Service Bus
- Text Analytics

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
 $> dotnet add package Azure.AI.FormRecognizer --version 1.0.0-preview.3

 $> dotnet add package Azure.AI.TextAnalytics
 $> dotnet add package Azure.AI.TextAnalytics --version 1.0.0-preview.5

 $> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Blobs
 $> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Keys
 $> dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets

 $> dotnet add package Azure.Identity --version 1.2.0-preview.4

 $> dotnet add package Azure.Messaging.ServiceBus --version 7.0.0-preview.3

 $> dotnet add package Azure.Search.Documents --version 1.0.0-preview.4
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure.Extensions.AspNetCore.DataProtection.Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.DataProtection.Blobs_1.0.0/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Blobs/CHANGELOG.md)

- General availability release.

### Azure.Extensions.AspNetCore.DataProtection.Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.DataProtection.Keys_1.0.0/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Keys/CHANGELOG.md)

- General availability release.

### Azure.Extensions.AspNetCore.Configuration.Secrets [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Extensions.AspNetCore.Configuration.Secrets_1.0.0/sdk/extensions/Azure.Extensions.AspNetCore.Configuration.Secrets/CHANGELOG.md)

- General availability release.

### Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core_1.2.2/sdk/core/Azure.Core/CHANGELOG.md)

#### Key Bug Fixes
- Retry server timeouts on .NET Framework.

### Core Experimental [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Core.Experimental_0.1.0-preview.1/sdk/core/Azure.Core.Experimental/CHANGELOG.md)

#### New Features
- Added serialization primitives: `ObjectSerializer`,`JsonObjectSerializer`
- Added spatial geometry types.
- Added `BinaryData` type.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#100-preview3-06-10-2020)

#### Breaking Changes
- All long running operation objects now return a `xxxCollection` object instead of a list.
- `USReceipt` and related types have been removed. Information about a `RecognizedReceipt` must now be extracted from its `RecognizedForm`.
- Method `GetFormTrainingClient` has been removed from `FormRecognizerClient` and `GetFormRecognizerClient` has been added to `FormTrainingClient`.
- Other method and property renaming detailed in changelog.

#### New Features
- Support to copy a custom model from one Form Recognizer resource to another.
- Authentication using azure-identity credentials now supported.

#### Key Bug Fixes
- `FormRecognizerClient.StartRecognizeCustomFormsFromUri` now works with URIs that contain blank spaces, encoded or not ([#11564](https://github.com/Azure/azure-sdk-for-net/issues/11564)).
- Custom form recognition without labels can now handle multipaged forms ([#11881](https://github.com/Azure/azure-sdk-for-net/issues/11881)).

 ### Identity [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/identity/Azure.Identity/CHANGELOG.md#120-preview4)

#### New Features
- Makes `AzureCliCredential`, `VisualStudioCredential` and `VisualStudioCodeCredential` public to allow direct usage.
- Added `Authenticate` methods to `UsernamePasswordCredential`

#### Key Bug Fixes
- Fix `SharedTokenCacheCredential` account filter to be case-insensitive (Issue [#10816](https://github.com/Azure/azure-sdk-for-net/issues/10816))
- Update `VisualStudioCodeCredential` to properly throw `CredentialUnavailableException` when re-authentication is needed. (Issue [#11595](https://github.com/Azure/azure-sdk-for-net/issues/11595))

 ### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md#100-preview4-2020-06-09)

#### Breaking Changes
 - Split `SearchServiceClient` into `SearchIndexClient` for managing indexes, and `SearchIndexerClient` for managing indexers, both of which are now in `Azure.Search.Documents.Indexes`.
 - Moved models for managing indexes, indexers, and skillsets to `Azure.Search.Documents.Indexes.Models`.
 - Made collection- and dictionary-type properties read-only, i.e. has only get-accessors.
 - Removed `dynamic` support from `SearchDocument` for the time being.
 - Please see the [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/search/Azure.Search.Documents/CHANGELOG.md#100-preview4-2020-06-09) for additional type, method, and parameter renames.

#### New Features
 - Referencing `Azure.Core.Experimental` which brings new spatial types and custom serializers.
 - Added `SearchClientBuilderExtensions` to integrate with ASP.NET Core.
 - Added `SearchModelFactory` to mock output model types.

 ### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/CHANGELOG.md#700-preview3-2020-06-08)

#### Breaking Changes
- Introduce ServiceBusSessionReceiverOptions/ServiceBusSessionProcessorOptions for creating ServiceBusSessionReceiver/ServiceBusSessionProcessor.
- Make ServiceBusReceivedMessage.Properties IReadOnlyDictionary rather than IDictionary.

#### New Features
- Add the ServiceBusManagementClient for CRUD operations on a namespace.
- Add constructor for ServiceBusMessage taking a string.
- Use the BinaryData type for ServiceBusMessage.Body.
- Add diagnostic tracing.

### Text Analytics

#### 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-2020-06-09)

- General availability release.

#### 1.0.0-preview.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/textanalytics/Azure.AI.TextAnalytics/CHANGELOG.md#100-preview5-2020-05-27)

##### Breaking Changes
- Updated the models to correspond with service changes.

##### New Features
- Client library now targets the service's v3.0 API, instead of the v3.0-preview.1 API.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
