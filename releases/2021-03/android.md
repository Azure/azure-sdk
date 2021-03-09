---
title: Azure SDK for Android (March 2021)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

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
    implementation 'com.azure.android:azure-communication-chat:1.0.0-beta.7'
    implementation 'com.azure.android:azure-communication-common:1.0.0-beta.7'
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-communication-chat:1.0.0-beta.7")
    implementation("com.azure.android:azure-communication-common:1.0.0-beta.7")
}
```

### Maven

```xml
...
<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.7</version>
  <type>aar</type>
</dependency>

<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.7</version>
  <type>aar</type>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Release highlights

### Azure Communication Services Common

#### 1.0.0-beta.7 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta7-2021-03-09))

##### Breaking Changes

- Credential `getToken` returns the newly added `CommunicationAccessToken` object instead of `AccessToken`.
- Renamed 'getRefreshProactively' to 'isRefreshProactively' in 'CommunicationTokenRefreshOptions'
- Removed constructor 'MicrosoftTeamsUserIdentifier(String userId, boolean isAnonymous, CommunicationCloudEnvironment cloudEnvironment)' in 'MicrosoftTeamsUserIdentifier'
- A few classes are made final 'CommunicationTokenCredential', 'CommunicationTokenRefreshOptions', 'CommunicationUserIdentifier', 'MicrosoftTeamsUserIdentifier', 'PhoneNumberIdentifier', 'UnknownIdentifier', 'CommunicationAccessToken'

##### New Features

- Introduce new class `CommunicationAccessToken`.

### Azure Communication Services Chat

#### 1.0.0-beta.7 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/master/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta7-2021-03-09))

##### Added

- Support real time notifications with new methods in ChatClient/ChatAsyncClient: 
    - startRealtimeNotifications
    - stopRealtimeNotifications
    - on(chatEventId, listenerId, listener) 
    - off(chatEventId, listenerId) 
- Add a sample chat app under folder samples for testing and playing around chat functionality purpose.

##### Breaking Changes

- Change remove participant API to /chat/threads/{chatThreadId}/participants/:remove
- user id in following classes changed from type CommunicationUserIdentifier to type CommunicationIdentifierModel.
- property initiator in ChatMessageContent renamed to initiatorCommunicationIdentifier.
- property senderId in ChatMessage and ChatMessageReadReceipt renamed to senderCommunicationIdentifier.
- property identifier in ChatParticipant renamed to communicationIdentifier.
- property createdBy in ChatThread renamed to createdByCommunicationIdentifier.
- repeatability-Request-ID in header renamed to repeatability-Request-Id.
  
## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
