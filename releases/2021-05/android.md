---
title: Azure SDK for Android (May 2021)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our May 2021 client library releases.

#### GA

- Azure Communication Services Common
- Azure Communication Services Calling
- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Azure Communication Services Calling
- _Add packages_

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

### Gradle

#### Java
```gradle
dependencies {
    ...
    implementation 'com.azure.android:azure-communication-common:1.0.0'
    implementation 'com.azure.android:azure-communication-calling:1.0.0'
    implementation 'com.azure.android:azure-communication-calling:1.0.1-beta.1'
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-communication-common:1.0.0")
    implementation("com.azure.android:azure-communication-calling:1.0.0")
    implementation("com.azure.android:azure-communication-calling:1.0.1-beta.1")
}
```

### Maven

```xml
<!-- Insert dependencies -->
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-communication-common</artifactId>
    <version>1.0.0</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-communication-calling</artifactId>
    <version>1.0.0</version>
    <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-communication-calling</artifactId>
    <version>1.0.1-beta.1</version>
    <type>aar</type>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Release highlights

### Azure Communication Services Common

#### 1.0.0 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/master/sdk/communication/azure-communication-common/CHANGELOG.md#100-2021-04-20))
- Release GA version; includes all changes from 1.0.0-beta.1 to 1.0.0.beta.8.

### Azure Communication Services Common

#### v1.0.1-beta.1 ([Changelog](https://github.com/Azure/Communication/blob/master/releasenotes/acs-calling-android-sdk-release-notes.md#v101-beta1-2021-04-29))

##### New Features:
- Teams meeting interop features post GA release are included in this release and is currently in `Preview` mode.

##### Breaking API changes
- Teams interop and all other preview APIs are no longer available in the mainstream SDK drop. Please use libraries marked with the -beta suffix for these features.

#### v1.0.0 ([Changelog](https://github.com/Azure/Communication/blob/master/releasenotes/acs-calling-android-sdk-release-notes.md#v100-2021-04-27)

We have releases our first General Availability (GA) SDK
APIs for preview features, such as Teams Interop, will only be available in the new libraries marked with the -beta suffix.
GA and Preview SDK(s) will both be available through maven central as per usual.

##### New Features:
- Teams meeting interop features have been removed and will NOT be available from the official drop as this capability is currently in `Preview` mode.

##### Bug fixes
- Teams interop and all other preview APIs are no longer available in the mainstream SDK drop. Please use libraries marked with the -beta suffix for these features.
- CallEndReason is correctly populated upon Call termination.

## Breaking API changes
- Teams interop and all other preview APIs are no longer available in the mainstream SDK drop. Please use libraries marked with the -beta suffix for these features.

### _Package name_

- Major changes only!

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
