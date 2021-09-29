---
title: Azure SDK for Android (January 2021)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our January 2021 client library releases.

#### Beta

- Azure Core

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

### Gradle

#### Java

```gradle
dependencies {
    ...
    implementation "com.azure.android:azure-core:1.0.0-beta.3"
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-core:1.0.0-beta.3")
}
```

### Maven

```xml
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-core</artifactId>
    <version>1.0.0-beta.3</version>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Release highlights

### Azure Core

#### 1.0.0-beta.3 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/core/azure-core/CHANGELOG.md#100-beta3-2021-01-15))

##### New Features

- Added `ClientOptions`, `RequestOptions` and `TransportOptions`.

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
