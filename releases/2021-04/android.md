---
title: Azure SDK for Android (April 2021)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our April 2021 client library releases.

#### Beta

- Azure Communication Services Chat
- Azure Communication Services Common
- Azure Core
- Azure Core Credential
- Azure Core Http
- Azure Core Http HttpUrlConnection
- Azure Core Http OkHttp
- Azure Core Jackson
- Azure Core Logging
- Azure Core Rest
- Azure Core Test

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

### Gradle

#### Java

```gradle
dependencies {
    ...
    implementation 'com.azure.android:azure-communication-chat:1.0.0-beta.8'
    implementation 'com.azure.android:azure-communication-common:1.0.0-beta.8'
    implementation 'com.azure.android:azure-core:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-credential:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-hhtp:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-http-httpurlconnection:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-http-okhttp:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-jackson:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-logging:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-rest:1.0.0-beta.5'
    implementation 'com.azure.android:azure-core-test:1.0.0-beta.5'
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-communication-chat:1.0.0-beta.8")
    implementation("com.azure.android:azure-communication-common:1.0.0-beta.8")
    implementation("com.azure.android:azure-core:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-credential:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-hhtp:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-http-httpurlconnection:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-http-okhttp:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-jackson:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-logging:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-rest:1.0.0-beta.5")
    implementation("com.azure.android:azure-core-test:1.0.0-beta.5")
}
```

### Maven

```xml
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-communication-chat</artifactId>
    <version>1.0.0-beta.8</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-communication-common</artifactId>
    <version>1.0.0-beta.8</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-credential</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-http</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-http-httpurlconnection</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-http-okhttp</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-jackson</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-logging</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-rest</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core-test</artifactId>
    <version>1.0.0-beta.5</version>
    <type>aar</type>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Release highlights

### Azure Communication Services Chat

#### 1.0.0-beta.8 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta8-2021-03-29))

##### Breaking Changes

- `ChatThreadAsyncClient`:
  - Renamed `getChatThreadProperties` to `getProperties`.
  - Renamed `getChatThreadPropertiesWithResponse` to `getPropertiesWithResponse`.
  - Changed `addParticipant` and `addParticipantWithResponse` to throw `InvalidParticipantException` for failure instead of returning `AddChatParticipantsResult`.
  - Changed `sendMessage` and `sendMessageWithResponse` to return `SendChatMessageResult`.
- `ChatThreadClient`:
  - Renamed `getChatThreadProperties` to `getProperties`.
  - Renamed `getChatThreadPropertiesWithResponse` to `getPropertiesWithResponse`.
  - Changed `addParticipant` and `addParticipantWithResponse` to throw `InvalidParticipantException` for failure instead of returning `AddChatParticipantsResult`.
  - Changed `sendMessage` and `sendMessageWithResponse` to return `SendChatMessageResult`.
- Renamed `ChatThread` to `ChatThreadProperties`.
- Renamed `CommunicationError` to `ChatError`.
- Removed `CommunicationErrorResponse`.
- Renamed `CommunicationErrorResponseException` to `ChatErrorResponseException`.
- Renamed `repeatabilityRequestId` renamed to `idempotencyToken` in `CreateChatThreadOptions`.
- Renamed `chatThread` to `chatThreadProperties` in `CreateChatThreadResult`.
- Removed the `azure-communication-chat.properties` file.

### Azure Communication Services Common

#### 1.0.0-beta.8 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta8-2021-03-29))

##### Breaking Changes

- Changed `UserCredential.getToken()` to return `CompletableFuture<CommunicationAccessToken>` instead of `Future<CommunicationAccessToken>`.
- Invoking `getToken` on a disposed `UserCredential` returns a failed `CompletableFuture` instead of cancelled `Future`.
- Removed the `fromString` method from `CommunicationCloudEnvironment` given the same result can be achieved using the existing public constructor.
- Renamed the `getToken` method in `CommunicationTokenRefreshOptions` to `getInitialToken`.

### Azure Core

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta4-2021-03-18))

##### Breaking Changes

- Split Azure Core into smaller modules:
  - azure-core
  - azure-core-credential
  - azure-core-http
  - azure-core-http-httpurlconnection
  - azure-core-http-okhttp
  - azure-core-jackson
  - azure-core-logging
  - azure-core-rest
  - azure-core-test

### Azure Core Credential

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-credential/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-credential/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library provides shared primitives, abstractions, and helpers for authentication and authorization.

### Azure Core HTTP

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-http/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-http/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library provides shared primitives, abstractions, and helpers for concrete `HttpClient` implementations used in the Android Azure SDK client libraries.

### Azure Core HTTP HttpUrlConnection

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-http-httpurlconnection/CHANGELOG.md#100-beta5-2021-03-26))

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-http-httpurlconnection/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library provides an implementation of the Azure Core HTTP's `HttpClient` using `HttpUrlConnection`.

### Azure Core HTTP OkHttp

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-http-okhttp/CHANGELOG.md#100-beta5-2021-03-26))

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-http-okhttp/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library provides an implementation of the Azure Core HTTP's `HttpClient` using `HttpUrlConnection`.

### Azure Core Jackson

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-jackson/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-jackson/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library provides support for serialization and deserialization using Jackson

### Azure Core Logging

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-logging/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-logging/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This libraries provides shared primitives, abstractions, and helpers for logging in Android Azure SDK client libraries.

### Azure Core REST

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-rest/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-rest/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library provides client abstractions to make HTTP REST Calls.

### Azure Core Test

#### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-test/CHANGELOG.md#100-beta5-2021-03-26))

##### Breaking Changes

- Removed the `azure-core.properties` file.

#### 1.0.0-beta.4 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core-test/CHANGELOG.md#100-beta4-2021-03-18))

##### New Features

- Initial release. This library contains classes used to test Azure SDK client libraries.

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
