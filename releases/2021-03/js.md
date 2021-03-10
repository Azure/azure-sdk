---
title: Azure SDK for JavaScript (March 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
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

- Azure Communication Common
- Azure Communication Identity
- Azure Communication Chat
- Azure Communication Phone Numbers
- Azure Communication SMS

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/communication-common@next
$> npm install @azure/communication-identity@next
$> npm install @azure/communication-chat@next
$> npm install @azure/communication-phone-numbers@next
$> npm install @azure/communication-sms@next
```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

### Azure Communication Administration was deprecated

- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Phone Numbers 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-phone-numbers/CHANGELOG.md#100-beta4-2021-03-09)

#### Breaking Changes

-  Removed `dist-browser` from the output folders. To bundle the Azure SDK libraries, please read our bundling guide: [link](https://github.com/Azure/azure-sdk-for-js/blob/master/documentation/Bundling.md)

### Azure Communication Chat 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-chat/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes

- Removed `_response` from returned models.
- Updated to @azure/communication-common@1.0.0-beta.6. Now uses `CommunicationIdentifier` in place of `CommunicationUserIdentifier`.
- Swap the parameter order in `ChatThreadClient` constructor.
- Generates `repeatabilityRequestId` if not populated in `createChatThread` operation.

### Azure Communication Common 1.0.0-beta.6 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-common/CHANGELOG.md#100-beta6-2021-03-09)

##### New Features 

- Updated @azure/communication-common version.

### Azure Communication Identity 1.0.0-beta.5 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-identity/CHANGELOG.md#100-beta5-2021-03-09)

#### Breaking Changes 

- `CommunicationIdentityClient` method `issueToken` renamed to `getToken`.
- `CommunicationIdentityClient` method `createUserWithToken` renamed to `createUserAndToken`.
- Renamed `CommunicationIdentityOptions` to `CommunicationIdentityClientOptions`.
- Removed `_response` from returned models.
- Removed `dist-browser` from the output folders. To bundle the Azure SDK libraries, please read our bundling guide: [link](https://github.com/Azure/azure-sdk-for-js/blob/master/documentation/Bundling.md).

### Azure Communication SMS 1.0.0-beta.4 [Changelog](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/communication/communication-sms/CHANGELOG.md#100-beta4-2021-03-09)

##### New Features 

- `SmsClient` added a constructor that supports `TokenCredential`.
- Added support for 1:N SMS messaging.
- Added support for tagging SMS messages.
- `send` method in `SmsClient` is idempotent under retry policy.
- 
#### Breaking Changes 

- `SendRequest` renamed to `SmsSendRequest`.
- `SendOptions` renamed to `SmsSendOptions` and now has an additional field `tag` to add a custom tag to delivery reports (when enabled).
- `send` no longer returns `RestResponse`, now returns an array of `SmsSendResults`. This contains fields to validate success/failure of each sent message.


## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}
