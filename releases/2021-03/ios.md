---
title: Azure SDK for iOS (March 2021)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Azure Communication Services Calling
- Azure Communication Services Chat
- Azure Communication Services Common


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
        .package(url: "https://github.com/Azure/azure-sdk-for-ios.git", from: "1.0.0-beta.9")
    ],
```

Next, add each client library you wish to use in a target to the target's array of `dependencies`:

```swift
    targets: [
        ...
        .target(
            name: "MyTarget",
            dependencies: [
                "AzureCommunication",
                "AzureCommunicationCalling",
                "AzureCommunicationChat"
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
    pod 'AzureCommunication', '~> 1.0.0-beta.9'
    pod 'AzureCommunicationCalling', '~> 1.0.0-beta.9'
    pod 'AzureCommunicationChat', '~> 1.0.0-beta.9'
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

### 1.0.0-beta.9 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.9/CHANGELOG.md#100-beta9-2021-03-10))
#### Azure Communication
##### Breaking Changes
- **Remove `CommunicationCloudEnvironment.fromModel()` method from Azure Communication package**.
- **Remove `identifier` label in `CommunicationUserIdentifier` and `UnknownIdentifier` from Azure Communication package**.
- `CommunicationIdentifierModel` and `CommunicationIdentifierSerializer` are **no longer part of the Azure Communication package*, they have been moved to `AzureCommunicationChat` package.

#### Azure Communication Chat

##### Breaking Changes
- On `ChatClient` `create(thread)` method, renamed `repeatabilityRequestID` to `repeatabilityRequestId`
- `ChatThreadClient` `remove(participant)` method now accepts `CommunicationIdentifier` instead of a string
- For `Participant` renamed `user` property to `id`

#### Azure Communication Calling

### New Features
- SDK is now shipped as a XCFramework instead of a FAT framework created using `lipo`.
- Improved caching of objects. 
- Added new call state `Hold` when a remote participant puts the call on hold.

##### Breaking Changes
- `Renderer` renamed to `VideoStreamRenderer`.
- `AudioDeviceInfo` removed from `DeviceManager`, please use iOS system API's in your application to switch between audio devices.
- `CallAgent` raises a new event `onIncomingCall` when a new incoming call is received. 
- `CallAgent` raises a new event `onCallEnded` event is raised when the incoming call wasn't answered.
- `Accept` and `Reject` can now be done on `IncomingCall` object and removed from `Call` object.
- For parsing of push notification payload `IncomingCallPushNotification` has been renamed to `PushNotificationInfo`.
- `CallerInfo` class created which provides information about the caller in an incoming call. Can be retrieved from `IncomingCall` and `Call` objects. 

#### Key Bug Fixes
- `OnCallsUpdated` event is raised when the call collection on `CallAgent` is updated for outgoing calls.
- `Hold` and `Resume` of an active call is fixed. 

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
