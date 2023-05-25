---
title: Azure SDK for iOS (May 2021)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our May 2021 client library releases.

#### GA

- Azure Communication Services Calling
- Azure Communication Services Common

#### Beta

- Azure Core

## Installation Instructions

To install the latest GA and beta libraries, we recommend you use the [Swift Package Manager](https://swift.org/package-manager/). As an alternative, you may also integrate the libraries using [CocoaPods](https://cocoapods.org/).

### Xcode

To add the Azure SDK for iOS to your application, follow the instructions in [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app):

With your project open in Xcode 11 or later, select **File > Swift Packages > Add Package Dependency...** Enter the clone URL of this repository: *https://github.com/Azure/azure-sdk-for-ios.git* and click **Next**. For the version rule, specify the exact version or version range you wish to use with your application and click **Next**. Finally, place a checkmark next to each client library you wish to use with your application, ensure your application target is selected in the **Add to target** dropdown, and click **Finish**.

### Swift CLI

To add the Azure SDK for iOS to your application, follow the example in [Importing Dependencies](https://swift.org/package-manager/#importing-dependencies):

Open your project's `Package.swift` file and add a new package dependency to your project's `dependencies` section, specifying the clone URL of the repository and the version specifier you wish to use:

```swift
dependencies: [
    ...
    .package(url: "https://github.com/Azure/SwiftPM-AzureCommunicationCommon", from: "1.0.0")
    .package(url: "https://github.com/Azure/SwiftPM-AzureCommunicationChat", .branch("master"))
    .package(url: "https://github.com/Azure/SwiftPM-AzureCore", from: "1.0.0-beta.12")
],

],
```

Next, add each client library you wish to use in a target to the target's array of `dependencies`:

```swift
targets: [
    ...
    .target(
        name: "MyTarget",
        dependencies: [
            "AzureCommunicationChat"
            "AzureCommunicationCommon",
            "AzureCore",
            ...
        ]
    )
]
```

### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C and Swift projects. You can install it with the following command:

```bash
$ [sudo] gem install cocoapods
```

> CocoaPods 1.5+ is required.

To integrate one or more client libraries into your project using CocoaPods, specify them in your [Podfile](https://guides.cocoapods.org/using/the-podfile.html), providing the version specifier you wish to use. To ensure compatibility when using multiple client libraries in the same project, use the same version specifier for all Azure SDK client libraries within the project:

```ruby
platform :ios, '12.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

target 'MyTarget' do
    pod 'AzureCommunicationCalling', '1.0.1'
    pod 'AzureCommunicationChat', '1.0.0-beta.11'
    pod 'AzureCommunicationCommon', '1.0.0'
    pod 'AzureCore', '1.0.0-beta.12'
    ...
end
```

Then, run the following command:

```bash
$ pod install
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-ios/issues).

## Release highlights

### Azure Communication Services Calling

#### 1.0.1 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationCalling/CHANGELOG.md#101-2021-05-03))

##### Bug fixes
- Missing required key bundle version for `1.0.0`.

#### 1.0.0 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationCalling/CHANGELOG.md#100-2021-04-27))

##### Breaking changes
- Video removed/added event are not raised when application stops rendering an incoming video.
- Teams interop and all other preview APIs are no longer available in the mainstream SDK drop. Please use libraries marked with the -beta suffix for these features.

#### 1.0.0-beta.12 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationCalling/CHANGELOG.md#100-beta12-2021-04-13))

##### New features
- A `DeviceManager` instance can be obtained irrespective of `CallAgent` creation.

##### Breaking changes
- Added `Nullability` annotations for parameters in delegate methods, properties and return types in init. (e.g. this removes the need for the application to force un-wrap objects created by the SDK where applicable).
- Renamed delegate method signatures to conform with Swift guidelines. Similar to [UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate).
- Blocked `CallAgent` creation with same user.
- Added `IsMuted` event to the `Call` class. The event will be triggered when the call is locally or remotely muted.
- Renamed multiple properties and methods:
    - `Call` class:
        - Renamed the `callDirection` property to `direction`.
        - Renamed the `isMicrophoneMuted` property to `isMuted`.
    - `VideoOptions` class:
        - Renamed the `LocalVideoStream` property to `LocalVideoStreams`, making it also an array.
        - The constructor for `VideoOptions` now takes an array of `LocalVideoStream` as a parameter.
- Renamed `RenderingOptions` to `CreateViewOptions`.
- `startCall` and `join` API's on `CallAgent` are now asynchronous.
- Made mandatory to pass a completion handler block for all async APIs.

##### Bug fixes
- Fixed an issue causing crashes when another guest user joins a Teams meeting with video on.
- Fixed an issue causing crashes if the user provided an invalid teams meeting link.
- Fixed an issue causing crashes when joining a call with muted and audio permission was not granted.
- Fixed an issue causing crashes when another video guest user joined a Teams meeting from Web/App.
- Turning the local video off/on no longer quickly shows a blank local video.
- Video calls now properly show the video stream of the device's camera to the user.
- Answering an incoming call with video now properly renders the receiver's video stream.
- Answering an incoming call with video now properly renders the caller's video stream.
- `OnRemoteParticipantsUpdated` event no longer updates the participant state to `Idle` when the participant is `InLobby`.
- Speaking Change Listeners are no longer triggered unexpectedly.

### Azure Communication Services Common

#### 1.0.0 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationCommon/CHANGELOG.md#100-2021-04-26))

#### Breaking Changes

- `AzureCommunication` has been renamed `AzureCommunicationCommon`.

#### 1.0.0-beta.12 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationCommon/CHANGELOG.md#100-beta12-2021-04-26))

##### Breaking Changes

- Marking `AzureCommunication` as deprecated in favor of `AzureCommunicationCommon`.

### Azure Core

#### 1.0.0-beta.12 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/core/AzureCore/CHANGELOG.md#100-beta12-2021-04-22))

#### 1.0.0-beta.11 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/core/AzureCore/CHANGELOG.md#100-beta11-2021-04-07))

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
