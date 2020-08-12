---
title: Azure SDK for .NET (August 2020)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our August 2020 client library releases.

#### GA

- Key Vault (Certificates, Keys, Secrets)
- Search

#### Updates

- _Add packages_

#### Preview

- Event Hubs
- Form Recognizer

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
 $> dotnet add package Azure.AI.FormRecognizer --version 3.0.0-preview.1

 $> dotnet add package Azure.Core.Experimental --version 0.1.0-preview.3

 $> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Blobs
 $> dotnet add package Azure.Extensions.AspNetCore.DataProtection.Keys

 $> dotnet add package Azure.Messaging.EventHubs --version 5.2.0-preview.2
 $> dotnet add package Azure.Messaging.EventHubs.Processor --version 5.2.0-preview.2

 $> dotnet add package Azure.Search.Documents

 $> dotnet add package Azure.Security.KeyVault.Certificates
 $> dotnet add package Azure.Security.KeyVault.Key
 $> dotnet add package Azure.Security.KeyVault.Secrets

 $> dotnet add package Microsoft.Azure.Core.NewtonsoftJson --version 1.0.0-preview.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

### Azure.Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/CHANGELOG.md#140-2020-08-06)

#### Added
- Added `ObjectSerializer` base class for serialization.
- Added `JsonObjectSerializer` that implements `ObjectSerializer` for `System.Text.Json`.

#### Fixed
- Connection leak for retried non-buffered requests on .NET Framework.

### Azure.Core.Experimental [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core.Experimental/CHANGELOG.md#010-preview3-2020-08-06)

#### Breaking Changes
- `ObjectSerializer`: Moved to `Azure.Core`.

### Microsoft.Azure.Core.NewtonsoftJson [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Microsoft.Azure.Core.NewtonsoftJson/CHANGELOG.md#100-preview1-2020-08-07)

- First release of `Newtonsoft.Json` serialization adapter package.

### Azure.Extensions.AspNetCore.DataProtection.Blobs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Blobs/CHANGELOG.md#101-2020-08-06)

#### Fixed

- Transient error in key refresh (#12415).

### Azure.Extensions.AspNetCore.DataProtection.Keys [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/extensions/Azure.Extensions.AspNetCore.DataProtection.Keys/CHANGELOG.md#101-2020-08-06)

#### Fixed

- Deadlock on .NET Framework (#12605)

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs/CHANGELOG.md)

- This release contains several fixes for minor issues as well as a collection of performance enhancements.

### Event Hubs Processor [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/eventhub/Azure.Messaging.EventHubs.Processor/CHANGELOG.md)

- This release contains several fixes for minor issues as well as a collection of performance enhancements.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/formrecognizer/Azure.AI.FormRecognizer/CHANGELOG.md#300-preview1-2020-08-11)

#### Breaking changes

- The library now targets the service's v2.0 API, instead of the v2.0-preview.1 API.
- Updated version number from `1.0.0-preview.5` to `3.0.0-preview.1`.
- Added models `RecognizeCustomFormsOptions`, `RecognizeReceiptsOptions`, and `RecognizeContentOptions` instead of a generic `RecognizeOptions` to support passing configurable options to recognize APIs.
- Added model `TrainingOptions` to support passing configurable options to training APIs. This type now includes `TrainingFileFilter`.

#### New Features

- Added diagnostics functionality to the `FormRecognizerClient`, to the `FormTrainingClient` and to long-running operation types.

#### Fixes

- Made the `TrainingFileFilter` constructor public.

### Azure Key Vault

#### Certificates 4.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Certificates_4.1.0/sdk/keyvault/Azure.Security.KeyVault.Certificates/CHANGELOG.md#410-2020-08-11)

- Default service version is now 7.1.
- Added `RecoverableDays` property to `CertificateProperties`.

#### Keys 4.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Keys_4.1.0/sdk/keyvault/Azure.Security.KeyVault.Keys/CHANGELOG.md#410-2020-08-11)

- Default service version is now 7.1.
- Added "import" value to `KeyOperation` enumeration.
- Added `RecoverableDays` property to `KeyProperties`.

#### Secrets 4.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.Security.KeyVault.Secrets_4.1.0/sdk/keyvault/Azure.Security.KeyVault.Secrets/CHANGELOG.md#410-2020-08-11)

- Default service version is now 7.1.
- Added `RecoverableDays` property to `SecretProperties`.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/search/Azure.Search.Documents/CHANGELOG.md#1110-2020-08-11)

#### New Features
- Added `SearchClientOptions.Serializer` to set which `ObjectSerializer` to use for serialization.
- Added `FieldBuilder` to easily create `SearchIndex` fields from a model type.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
