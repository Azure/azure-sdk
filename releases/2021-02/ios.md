---
title: Azure SDK for iOS (February 2021)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our February 2021 client library releases.

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
        .package(url: "https://github.com/Azure/azure-sdk-for-ios.git", from: "1.0.0-beta.8")
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
    pod 'AzureCommunication', '~> 1.0.0-beta.8'
    pod 'AzureCommunicationCalling', '~> 1.0.0-beta.8'
    pod 'AzureCommunicationChat', '~> 1.0.0-beta.8'
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

### 1.0.0-beta.8 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.8/CHANGELOG.md#100-beta8-2021-02-09))
#### Azure Communication Services Common

##### Breaking Changes
 - Renamed the type `CommunicationUserCredential` to `CommunicationTokenCredential`, as it represents a token.
 - Communication identifier `MicrosoftTeamsUserIdentifier` property `identifier` renamed to `userId` since identifier was too generic.
 - Communication identifier `MicrosoftTeamsUserIdentifier` property `id` renamed to `rawId` to represent full MRI.
 - Communication identifier `PhoneNumberIdentifier` property `id` renamed to `rawId` to represent full MRI.
 - Removed `CallingApplicationIdentifier` as it is currently unused by any service.
 - The protocol `CommunicationTokenCredential` has likewise been renamed to `CommunicationTokenCredentialProviding`.
 - All types that conform to the `CommunicationIdentifier` protocol now use the suffix `Identifier`. For example, the `PhoneNumber` type used to represent a phone number identifier is now named `PhoneNumberIdentifier`.
 - Updated the `CommunicationTokenCredential` initializer that automatically refreshes the token to accept a single
    `CommunicationTokenRefreshOptions` object instead of multiple parameters.
- Removes `CommunicationUserCredentialPolicy`. This policy was a duplicate of `AzureCore.BearerTokenCredentialPolicy`. Communication now has new ability to create `BearerTokenCredentialPolicy` using the new `CommunicationPolicyTokenCredential`. 

#### Azure Communication Services Calling

##### New Features
 - Added ability to join a Teams meeting.
 - New event on `Call` `OnIsRecordingActiveChanged` to indicate when the recording has been started and stopped and new property `IsRecordingActive` to indicate if currently the recording is active or not.

##### Key Bug Fixes
 - Fix wrong `callId` on the incoming `Call` object.
 - When placing outgoing call or joining a group call event will be raised `OnCallsUpdated` when call list is updated.
 - Throw `IllegalArgumentException` if `null` camera is passed to constructor of `LocalVideoStream`.
 - Fixed video freezing in landscape mode.
 - `RendererView` layout is no longer off after a device rotation.
 - `RendererView` is no longer blank when not added to the window right away.
 - Fixed `RendererView` issues when joining a call with a reused `groupId`.

#### Azure Communication Services Chat

##### New Features
 - Introduced `ChatClient` and `ChatThreadClient` to split operations on threads and operations within a particular thread.
 - Create thread sets repeatability-Request-ID for idempotency if not provided.
 - Introduced `MessageContent` model to replace string content property.

##### Breaking Changes
 - `ChatThreadMember` renamed to `Participant`, uses `CommunicationUserIdentifier`.
 - `ChatMessage` renamed to `Message`, uses `CommunicationUserIdentifier`.
 - `ChatThread` renamed to `Thread`, uses `CommunicationUserIdentifier`.

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
