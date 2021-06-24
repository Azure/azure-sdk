---
title: Azure SDK for iOS (June 2021)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our June 2021 client library releases.

#### Beta

- Azure Communication Services Calling
- Azure Communication Services Chat

## Installation Instructions

To install the latest GA and beta libraries, we recommend you use the [Swift Package Manager](https://swift.org/package-manager/). As an alternative, you may also integrate the libraries using [CocoaPods](https://cocoapods.org/).

### Xcode

To add the Azure SDK for iOS to your application, follow the instructions in [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app):

With your project open in Xcode 11 or later, select **File > Swift Packages > Add Package Dependency...** Enter the clone URL of the Swift Package Manager mirror repository for the library you wish to include (it will have the form `SwiftPM-<NAME>`, i.e.: *https://github.com/Azure/SwiftPM-AzureCore.git*) and click **Next**. For the version rule, specify the exact version or version range you wish to use with your application and click **Next**. Finally, place a checkmark next to each client library you wish to use with your application, ensure your application target is selected in the **Add to target** dropdown, and click **Finish**.

### Swift CLI

To add the Azure SDK for iOS to your application, follow the example in [Importing Dependencies](https://swift.org/package-manager/#importing-dependencies):

Open your project's `Package.swift` file and add a new package dependency to your project's `dependencies` section, specifying the clone URL of the Swift Package Manager mirror repository and the version specifier you wish to use:

```swift
// swift-tools-version:5.3
    dependencies: [
        ...
        .package(name: "AzureCommunicationChat", url: "https://github.com/Azure/SwiftPM-AzureCommunicationChat.git", from: "1.0.0-beta.12")
    ],
```

Next, add each client library you wish to use in a target to the target's array of `dependencies`:

```swift
    targets: [
        ...
        .target(
            name: "MyTarget",
            dependencies: ["AzureCommunicationChat", ...])
    ]
)
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
    pod 'AzureCommunicationCalling', '1.1.0-beta.1'
    pod 'AzureCommunicationChat', '1.0.0-beta.12'
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

#### 1.1.0-beta.1(https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationCalling/CHANGELOG.md#110-beta1-2021-06-04)

##### New features
- Support for CallKit (**Preview mode**)
  - Use the API `createCallAgentWithCallKitOptions` to create `CallAgent` with `CallKit` enabled and the SDK will report to `CallKit` about incoming calls, outgoing calls and all other call operations like `mute`, `unmute`, `hold`, `resume` as part of the API calls.
  - When the app is in the killed state and an incoming call is received use the API `reportToCallKit`.
- `CallAgent` and `CallClient` now have `dispose` APIs to explicitly delete these objects instead of relying on ARC.
- Get `CorrelationId` from the `CallInfo` object in a `Call` to get the id required for the recording feature.
- Support for starting a recording by an ACS endpoint.

##### Bug fixes
- Fix issue where layout was off after a device rotation.
- Fix resizing issue for animating streams.
- Creating multiple CallAgents with same token will throw error.

### Azure Communication Services Chat

#### 1.0.0-beta.12(https://github.com/Azure/azure-sdk-for-ios/blob/main/sdk/communication/AzureCommunicationChat/CHANGELOG.md#100-beta12-2021-06-07)

##### Breaking Changes
- Changed the way in which options are instantiated for the following classes: `CreateChatThreadOptions`, `DeleteChatThreadOptions`,  `ListChatThreadsOptions`, `AddChatParticipantsOptions`, `DeleteChatMessageOptions`, `GetChatMessageOptions`, `GetChatThreadPropertiesOptions`, `ListChatMessagesOptions`, `ListChatParticipantsOptions`, `ListChatReadReceiptsOptions`, `RemoveChatParticipantOptions`, `SendChatMessageOptions`, `SendChatReadReceiptOptions`, `SendTypingNotificationOptions`, `UpdateChatMessageOptions`, `UpdateChatThreadPropertiesOptions`.
    - old:
        `let options = Chat.CreatChatThreadOptions()`
    - new:
        `let options = CreateChatThreadOptions()`
- Moved `AzureCommunicationChatClient.ApiVersion` to `AzureCommunicationChatClientOptions.ApiVersion`.
- Renamed `CommunicationError` to `ChatError`.
- Removed following classes:  `CreateChatThreadResult`, `CreateChatThreadRequest`, `ChatMessage`, `ChatMessageContent`, `ChatParticipant`, `ChatMessageReadReceipt`, `ChatThreadProperties`.
- Removed Any type in TrouterEventUtil, and create a new enum TrouterEvent.
- Signaling event handlers now only accept a single enum argument, `TrouterEvent` instead of type Any and a ChatEventId. This eliminates the need to cast event payloads. Instead, developers can simply using a switch/case statement on the relevant `TrouterEvent` values.
- The TrouterEventUtil.create method now returns the strongly-typed enum `TrouterEvent` instead of Any.

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
