---
title: Azure SDK for Android (October 2020)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### Beta

- Azure Communication Services Chat
- Azure Communication Services Common
- Azure Core

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

### Gradle

#### Java
```gradle
dependencies {
    ...
    implementation "com.azure.android:azure-communication-chat:1.0.0-beta.2"
    implementation "com.azure.android:azure-communication-common:1.0.0-beta.1"
    implementation "com.azure.android:azure-core:1.0.0-beta.2"
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-communication-chat:1.0.0-beta.2")
    implementation("com.azure.android:azure-communication-common:1.0.0-beta.1")
    implementation("com.azure.android:azure-core:1.0.0-beta.2")
}
```

### Maven

```xml
<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-communication-chat</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>

<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-communication-common</artifactId>
  <version>1.0.0-beta.1</version>
</dependency>

<dependency>
  <groupId>com.azure.android</groupId>
  <artifactId>azure-core</artifactId>
  <version>1.0.0-beta.2</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Communication Services Chat

#### 1.0.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100-beta2-2020-10-06))

- Initial Preview release for Azure Communication Services Chat

### Azure Communication Services Common

#### 1.0.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-common/CHANGELOG.md#100-beta1-2020-09-22))

- Initial Preview release for Azure Communication Services Common

### Azure Core

#### 1.0.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta2-2020-10-05))

##### New Features

- Added `PagedDataCollection`, `PagedDataResponseCollection`, `AsyncPagedDataCollection` and associated types to support pagination APIs.

#### 1.0.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta1-2020-09-17))

- Initial Preview release for Azure Core

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
