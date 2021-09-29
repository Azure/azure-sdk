---
title: Azure SDK for iOS (April 2021)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our April 2021 client library releases.

#### Updates

- Azure Communication Services Common
- Azure Communication Chat

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
        .package(url: "https://github.com/Azure/azure-sdk-for-ios.git", from: "1.0.0-beta.11")
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
    pod 'AzureCommunication', '1.0.0-beta.11'
    pod 'AzureCommunicationCalling', '1.0.0-beta.11'
    pod 'AzureCommunicationChat', '1.0.0-beta.11'
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

### 1.0.0-beta.11 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/releases/tag/1.0.0-beta.11))

#### Azure Communication

##### Breaking Changes

- Updated the Objective-C initializer for `CommunicationUserIdentifier` and `UnknownIdentifier` to be `initWithIdentifier:`. Making it align more with Objective-C guidelines. 
- Updated `CommunicationTokenCredential` init method from `init(with:)` to `init(withOptions:)`. Objective-c method will change from `initWith: error:]` to `initWithOptions: error:]`. 
- Removed `CommunicationPolicyTokenCredential`.
- Typealias `TokenRefreshOnCompletion` renamed to `TokenRefreshHandler`.
- Typealias `TokenRefresherClosure` renamed to `TokenRefresher`.

#### Azure Communication Chat

### New Features

- `ChatClient` now supports Realtime Notifications for Chat events
- Following methods added to `ChatClient`:
  - `startRealtimeNotifications()`
  - `stopRealtimeNotifications()`
  - `register(event, handler)` registers handlers for Chat events
  - `unregister(event)` unregisters handlers for Chat events

##### Breaking Changes

- Build setting `ENABLE_BITCODE` is no longer supported for `AzureCommunicationChat`. It must be set to NO.
- Renamed `Participant` to `ChatParticipant`
- Renamed `Message` to `ChatMessage`
- Renamed `MessageContent` to `ChatMessageContent`
- Renamed `ReadReceipt` to `ChatMessageReadReceipt`
- Renamed `Thread` to `ChatThreadProperties`
- Renamed `CreateThreadRequest` to `CreateChatThreadRequest`
- Renamed `CreateThreadResult` to `CreateChatThreadResult`
- Renamed `CommunicationError` to `ChatError`
- ChatThreadClient `update()` message accepts a string for the message content instead of an object
- The method for getting thread properties has been moved from `ChatClient` to `ChatThreadClient` and renamed `getProperties()`
- Participants are now optional when creating a thread, the creator of the thread is added automatically

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
