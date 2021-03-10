---
title: Azure SDK for Python (March 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-communication-identity
pip install azure-communication-chat 
pip install azure-communication-sms
pip install azure-communication-phonenumbers 
```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Azure Communication Administration was deprecated
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Phone Numbers 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/communication/azure-communication-phonenumbers/CHANGELOG.md#100b4-2021-03-09)

##### New Features 

- Added `PhoneNumbersAdministrationClient` (originally was part of the `azure.communication.administration` package).

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100b5-2021-03-09)

##### New Features 

- Removed nullable references from method signatures.

#### Breaking Changes

- Added support for communication identifiers instead of raw strings.
- Changed return type of `create_chat_thread`: `ChatThreadClient -> CreateChatThreadResult`
- Changed return types `add_participants`: `None -> list[(ChatThreadParticipant, CommunicationError)]`
- Added check for failure in `add_participant`

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/communication/azure-communication-identity/CHANGELOG.md#100b5-2021-03-09)

#### Breaking Changes

- CommunicationIdentityClient's (synchronous and asynchronous) `issue_token` function is now renamed to `get_token`.
- The CommunicationIdentityClient constructor uses type `TokenCredential` and `AsyncTokenCredential` for the credential parameter.

### Azure Communication SMS 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/communication/azure-communication-sms/CHANGELOG.md#100b5-2021-03-09)

### New Features

- Added support for Azure Active Directory authentication.
- Added support for 1:N SMS messaging.
- Added support for SMS idempotency.
- Send method series in SmsClient are idempotent under retry policy.
- Added support for tagging SMS messages.
- The SmsClient constructor uses type `TokenCredential` and `AsyncTokenCredential` for the credential parameter.

#### Breaking Changes

- Send method takes in strings for phone numbers instead of `PhoneNumberIdentifier`.
- Send method returns a list of `SmsSendResult`s instead of a `SendSmsResponse`.




## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
