---
title: Azure SDK for JavaScript (February 2021)
layout: post
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the February 2021 client library release.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

[pattern.beta]: # (- ${PackageFriendlyName})

- Azure Communication Common 1.0.0-beta.5
- Azure Communication Identity 1.0.0-beta.4
- Azure Communication Chat 1.0.0-beta.4

## Installation Instructions

To install the packages, copy and paste the below into a terminal.

```bash
$> npm install @azure/communication-common
$> npm install @azure/communication-identity
$> npm install @azure/communication-chat
```

[pattern]: # ($> npm install ${PackageName}@${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Release highlights

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

### Azure Communication Administration will be deprecated

- Identity client is moved to new package Azure Communication Identity.
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Common 1.0.0-beta.5 [ChangeLog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-common_1.0.0-beta.5/sdk/communication/communication-common/CHANGELOG.md#100-beta5-2021-02-09)

#### Breaking Changes

- Removed `CallingApplicationIdentifier` and `isCallingApplicationIdentifier`.
- Removed `id` from `CommunicationUserIdentifier`.
- Renamed `id` to `rawId` in `PhoneNumberIdentifier`.
- Renamed `id` to `rawId` in `MicrosoftTeamsUserIdentifier`.

### Azure Communication Identity 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-identity_1.0.0-beta.4/sdk/communication/communication-identity/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Added `CommunicationIdentityClient` (originally part of the `@azure/communication-administration` package).
- `CommunicationIdentityClient` added a constructor that supports `TokenCredential`.
- `CommunicationIdentityClient` added a new method `createUserWithToken`.

#### Breaking Changes

- Replaced `CommunicationUser` with `CommunicationUserIdentifier`.
- `CommunicationIdentityClient` method `revokeTokens` no longer accepts `tokensValidFrom` as an argument.
- `pstn` is removed from `TokenScope`
- `issueToken` no longer returns the `CommunicationUser` alongside the token.

### Azure Communication Chat 1.0.0-beta.4 [ChangeLog](https://github.com/Azure/azure-sdk-for-js/blob/@azure/communication-chat_1.0.0-beta.4/sdk/communication/communication-chat/CHANGELOG.md#100-beta4-2021-02-09)

#### New Features

- Added support for `CreateChatThreadResult` and `AddChatParticipantsResult` to handle partial errors in batch calls.
- Added idempotency identifier parameter for chat creation calls.
- Added support for `listReadReceipts` and `listParticipants` pagination.
- Added new model for messages an content types : `Text`, `Html`, `ParticipantAdded`, `ParticipantRemoved`, `TopicUpdated`.
- Added new model for errors (`CommunicationError`)
- Added notifications for thread level changes.

#### Breaking Changes

- Updated to @azure/communication-common@1.0.0-beta.5. Now uses `CommunicationUserIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed `priority` field from `ChatMessage`.

## Latest Releases

View all the latest versions of JavaScript packages [here][js-latest-releases].

{% include refs.md %}

