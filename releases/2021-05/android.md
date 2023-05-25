---
title: Azure SDK for Android (May 2021)
layout: post
tags: android azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-android
---

The Azure SDK team is pleased to announce our May 2021 client library releases.

#### GA

- Azure Communication Services Calling
- Azure Communication Services Common

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

### Gradle

#### Java
```gradle
dependencies {
    ...
    implementation 'com.azure.android:azure-communication-calling:1.0.0'
    implementation 'com.azure.android:azure-communication-common:1.0.0'
}
```

#### Kotlin

```gradle
dependencies {
    ...
    implementation("com.azure.android:azure-communication-calling:1.0.0")
    implementation("com.azure.android:azure-communication-common:1.0.0")
}
```

### Maven

```xml
<dependency>
 <groupId>com.azure.android</groupId>
 <artifactId>azure-communication-calling</artifactId>
 <version>1.0.0</version>
 <type>aar</type>
</dependency>
<dependency>
    <groupId>com.azure.android</groupId>
    <artifactId>azure-communication-common</artifactId>
    <version>1.0.0</version>
    <type>aar</type>
</dependency>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

## Release highlights

### Azure Communication Services Calling

#### 1.0.1-beta.1 ([Changelog](https://github.com/Azure/Communication/blob/master/releasenotes/acs-calling-android-sdk-release-notes.md#v101-beta1-2021-04-29))

## New Features:
- Teams meeting interop features post GA release are included in this release and are currently in `Preview` mode.

#### 1.0.0 ([Changelog](https://github.com/Azure/Communication/blob/master/releasenotes/acs-calling-android-sdk-release-notes.md#v101-beta1-2021-04-29))

## New Features:
- Gson is now a transitive dependency and is not needed to be pulled in separately.
- `VideoStreamRenderer.createView()` now uses `ScalingMode.CROP` by default.

## Bug fixes
- `CallEndReason` is correctly populated upon `Call` termination.

## Breaking API changes
- Teams meeting interop features have been removed and will NOT be available from the official drop as this capability is currently in `Preview` mode. Please use libraries marked with the `-beta` suffix for these features.

#### 1.0.0-beta.10 ([Changelog](https://github.com/Azure/Communication/blob/master/releasenotes/acs-calling-android-sdk-release-notes.md#v100-beta10-2021-04-12))

##### New Features
- `DeviceManager` obtention is decoupled from `CallAgent` creation.
- Added `OnIsMuted` event to the `Call` class. The event will be triggered when the call is locally or remotely muted.

##### Breaking Changes
- Blocked `CallAgent` creation with same user.
- Renamed multiple properties and methods:
    - `Call` class:
        - Renamed method `getCallDirection()` to `getDirection()`
        - Renamed method `isMicrophoneMuted()` to `isMuted()`
- Method `startVideo(LocalVideoStream)` now takes an additional context object for permission check and is now `startVideo(Context, LocalVideoStream)`.
- Method `stopVideo(LocalVideoStream)` now takes an additional context object for permission check and is now `stopVideo(Context, LocalVideoStream)`.
- Method `mute()` now takes an additional context object for permission check and is now `mute(Context)`.
- Method `unmute()` now takes an additional context object for permission check and is now `unmute(Context)`.

##### Bug Fixes
- Fixed an issue causing crashes when another guest user joins a Teams meeting with video on.
- Turning the local video off/on no longer quickly shows a blank local video.
- Answering an incoming call with video now properly renders the receiver's video stream.
- The video stream of remote participants from a web client is now centred/cropped on Android.
- `OnRemoteParticipantsUpdated` event no longer updates the participant state to `Idle` when the participant is `InLobby`.
- Speaking Change Listeners are no longer triggered unexpectedly.
- `Call.AddParticipant(...)` no longer fails with a `NullPointerException`.
- Permission checks of SDK APIs have been fixed to respect only the required permission.

### Azure Communication Services Common

#### 1.0.0 ([Changelog](https://github.com/Azure/azure-sdk-for-android/blob/main/sdk/communication/azure-communication-common/CHANGELOG.md#100-2021-04-20))

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

{% include refs.md %}
