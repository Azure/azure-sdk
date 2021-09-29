---
title: Azure SDK for iOS (November 2020)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our November 2020 client library releases.

#### Beta

- Azure Communication Services Calling
- Azure Communication Services Chat
- Azure Communication Services Common
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
        .package(url: "https://github.com/Azure/azure-sdk-for-ios.git", from: "1.0.0-beta.6")
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
                "AzureCommunicationChat",
                ...
            ]
        )
    ]
```

### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective C and Swift projects. You can install it with the following command:

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
  pod 'AzureCommunication', '~> 1.0.0-beta.6'
  pod 'AzureCommunicationCalling', '~> 1.0.0-beta.6'
  pod 'AzureCommunicationChat', '~> 1.0.0-beta.6'
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

### 1.0.0-beta.6 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.6/CHANGELOG.md#100-beta6-2020-11-23))

#### Azure Communication Services Calling

##### Key Bug Fixes

- Fixed crash on calling `Call.hangup()`.
- Fixed invalid values for `CFBundleVersion` and `CFBundleShortVersionString` in `Info.plist`.

### 1.0.0-beta.5 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.5/CHANGELOG.md#100-beta5-2020-11-18))

#### Azure Communication Services Calling

##### New features

- Added a Cocoapods spec for this library.

##### Breaking Changes

- Swift applications will not see the `ACS` prefix for classes and enums. For example, `ACSCallAgent` is now `CallAgent` when the library is imported in a Swift application.
- Parameter labels are now mandatory for all API calls from Swift applications.
- Except for the first parameter, parameter labels are now mandatory for all other parameters to delegate methods in Swift applications.
- An exception is now thrown if an application tries to render video/camera twice.

##### Key Bug Fixes

- Fixed a deadlock when deleting an `ACSCallAgent` object.
- The `Call.hangup()` method will return only after all necessary events are delivered to the app.
- The `Call.hangup()` method now terminates a call if the call is in the Connecting or Ringing state.
- The library was raising a `RemoteVideoStream Removed` event when app stopped rendering a stream. The library now also raises a follow-up `RemoteVideoStream Added` event once the stream is ready to be rendered again.

#### Azure Communication Services Chat

##### New Features

- Added a Cocoapods spec for this library.

##### Breaking Changes

- The `baseUrl` parameter has been renamed to `endpoint` in the `AzureCommunicationChatClient` initializers.

#### Azure Communication Services Common

##### New Features

- Added a Cocoapods spec for this library. 

#### Azure Core

##### New Features

- Added a Cocoapods spec for this library.

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
