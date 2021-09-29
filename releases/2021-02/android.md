---
title: Azure SDK for Android (February 2021)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our February 2021 client library releases.

#### Beta

- Azure Communication Services Chat
- Azure Communication Services Common

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

### Gradle

#### Java

```gradle
dependencies {
    ...
    implementation 'com.azure.android:azure-communication-chat:1.0.0-beta.5'
    implementation 'com.azure.android:azure-communication-common:1.0.0-beta.5'
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-communication-chat:1.0.0-beta.5")
    implementation("com.azure.android:azure-communication-common:1.0.0-beta.5")
}
```

### Maven

```xml
...
<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.5</version>
  <type>aar</type>
</dependency>

<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.5</version>
  <type>aar</type>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Release highlights

### Azure Communication Services Common

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta5-2021-02-08))

##### Breaking Changes

- Removed `CallingApplicationIdentifier`.
- Removed `getId` method in `CommunicationIdentifier` class.

##### New Features

- Added a new `MicrosoftTeamsUserIdentifier` constructor that takes a non-null `CommunicationCloudEnvironment` parameter.
- Added the following classes:
    - `CommunicationCloudEnvironment`
    - `CommunicationCloudEnvironmentModel`
    - `CommunicationIdentifierSerializer`
    - `CommunicationIdentifierModel`
    - `MicrosoftTeamsUserIdentifierModel`
    - `PhoneNumberIdentifierModel`
    - `CommunicationUserIdentifierModel`


#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta4-2021-01-28))

##### Breaking Changes

- Renamed `CommunicationUserCredential` to `CommunicationTokenCredential`.
- Renamed `PhoneNumber` to `PhoneNumberIdentifier`.
- Renamed `CommunicationUser` to `CommunicationUserIdentifier`.
- Renamed `CallingApplication` to `CallingApplicationIdentifier`.

##### New Features

- Added class `MicrosoftTeamsUserIdentifier`.

### Azure Communication Services Chat

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta5-2021-02-08))

##### New Features

- Added support for three more types of chat message content.
- Added support for adding a user agent HTTP header in the chat client.
- Added the following classes:
    - `CommunicationError`
    - `CommunicationErrorResponse`
    - `CommunicationErrorResponseException`

##### Breaking Changes

- Split the `ChatClient` class into `ChatClient` and `ChatThreadClient`.
- Changed the "add participants" with a `/:add` at the end.
- Removed `priority` from `message`.
- Changed request and response types to more specific types.
- `listChatParticipantsPages` and `listChatReadReceiptsPages` now take now two additional parameters: `maxPageSize` and `skip`.
- Renamed `retrieveNextThreadPages` to `listChatThreadsNext`.
- Renamed `retrieveNextThreadPages` to `listChatThreadsNext`.
- Renamed `retrieveNextMessagePages` to `listChatMessagesNext`.
- Renamed `retrieveNextParticipantsPages` to `listChatParticipantsNext`.
- Renamed `retrieveNextReceiptsPages` to `listChatReadReceiptsNext`.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta4-skipped))

##### New Features

- Added support for Rich Text Chat message content.
- Added the following classes:
    - `ChatMessageContent`
    - `ChatMessageType`
    - `AddChatParticipantsErrors`
    - `AddChatParticipantsResult`
    - `ChatMessageType`

##### Breaking Changes

- `ChatMessage` properties are now all required.
- `ChatMessage` type is no longer a `String` type but an extendable `Enum` type: `ChatMessageType`.
- `ChatMessage` content is no longer a `String` type but an object of type `ChatMessageContent`.
- All `OffsetDateTime` properties are now in RFC3339 format instead of ISO8601 format.

#### 1.0.0-beta.3 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta4-skipped))

##### Breaking Changes

- Methods that returned `SendChatMessageResult` now return `messageId` instead.
- Renamed the class `ReadReceipt` to `ChatMessageReadReceipt`.
- Renamed the class `UpdateChatThreadRequest` to `UpdateTopicRequest`.
- Renamed the method `updateChatThread` to `updateTopic`.
- Renamed the parameters `member` and `threadMember` to `participant`.

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
