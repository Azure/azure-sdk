---
title: Azure SDK for .NET (March 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

[pattern.beta]: # (- ${PackageFriendlyName})

- Communication Chat
- Communication Common
- Communication Identity
- Communication Phone Numbers
- Communication SMS
 
## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Azure.Communication.Chat --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.Common --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.Identity --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.PhoneNumbers --version 1.0.0-beta.5
$> dotnet add package Azure.Communication.SMS --version 1.0.0-beta.5
```

[pattern]: # ($> dotnet install ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)


### Azure Communication Administration is deprecated

- `PhoneNumberAdministrationClient` is moved into the new package `Azure.Communication.PhoneNumbers` and replaced by `PhoneNumberClient`.

### Azure Communication Phone Numbers 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.PhoneNumbers/CHANGELOG.md#100-beta5-2021-03-09)

#### New Features

- Added `PhoneNumbersClient` (originally was part of the `Azure.Communication.Administration` package).
- Added support for Azure Active Directory Authentication.

#### Breaking Changes

- `PhoneNumberAdministrationClient` has been replaced with `PhoneNumbersClient`, which has the same functionality but different APIs. To learn more about how PhoneNumbersClient works, refer to the [README.md](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.PhoneNumbers/README.md)

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Chat/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- Added support for communication identifiers instead of raw strings.
- Removed support for nullable reference types.

### Azure Communication Common  1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Common/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- Updated `CommunicationTokenRefreshOptions(bool refreshProactively, Func<CancellationToken, string> tokenRefresher,  Func<CancellationToken, ValueTask<string>> asyncTokenRefresher = null, string initialToken = null)`
to `CommunicationTokenRefreshOptions(bool refreshProactively, Func<CancellationToken, string> tokenRefresher)`. `asyncTokenRefresher` and `initialToken` are updated to become public properties.

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Identity/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- `CommunicationIdentityClient.IssueToken` and `CommunicationIdentityClient.IssueTokenAsync` are renamed to `GetToken` and `GetTokenAsync`, respectively
- `CommunicationIdentityClient.CreateUserWithToken` and `CommunicationIdentityClient.CreateUserWithTokenAsync` are renamed to `CreateUserAndToken` and `CreateUserAndTokenAsync`, respectively. Their return value is also changed from `Tuple<CommunicationUserIdentifier, string>` to `CommunicationUserIdentifierAndToken`.

### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/communication/Azure.Communication.Sms/CHANGELOG.md#100-beta4-2021-03-09)

#### New Features

- Added support to create SmsClient with AzureKeyCredential.
- Support for creating SmsClient with TokenCredential.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- Send method series in SmsClient are idempotent under retry policy.

#### Breaking Changes

- Updated `Task<Response<SendSmsResponse>> SendAsync(PhoneNumberIdentifier from, PhoneNumberIdentifier to, string message, SendSmsOptions sendSmsOptions = null, CancellationToken cancellationToken = default)`
to `Task<Response<SmsSendResult>> SendAsync(string from, string to, string message, SmsSendOptions options = default)`
- Replaced `SendSmsResponse` with `SmsSendResult`

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
