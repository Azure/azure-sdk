---
title: Azure SDK for iOS (October 2020)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our October 2020 client library releases.

#### Beta

- Azure Communication Services Chat
- Azure Communication Services Common
- Azure Core

## Installation Instructions

To install the latest GA and beta libraries, use the [Swift Package Manager](https://swift.org/package-manager/).

### Xcode

Follow the instructions in [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app):

With your project open in Xcode 11 or later, select **File > Swift Packages > Add Package Dependency...** Enter the clone URL of this repository: *https://github.com/Azure/azure-sdk-for-ios.git* and click **Next**. For the version rule, specify the exact version or version range you wish to use with your application and click **Next**. Finally, place a checkmark next to each client library you wish to use with your application, ensure your application target is selected in the **Add to target** dropdown, and click **Finish**.

### Swift CLI

Follow the example in [Importing Dependencies](https://swift.org/package-manager/#importing-dependencies):

Open your project's `Package.swift` file and add a new package dependency to your project's `dependencies` section, specifying the clone URL of the repository and the version specifier you wish to use:

```swift
    dependencies: [
        ...
        .package(url: "https://github.com/Azure/azure-sdk-for-ios.git", from: "1.0.0-beta.2")
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
                "AzureCommunicationChat",
                "AzureCore",
                ...
            ]
        )
    ]
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-ios/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Azure Communication Services Chat

#### 1.0.0-beta.2 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.2/CHANGELOG.md#100-beta2-2020-10-05))

- Initial Preview release for Azure Communication Services Chat

### Azure Communication Services Common

#### 1.0.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.2/CHANGELOG.md#100-beta1-2020-09-21))

- Initial Preview release for Azure Communication Services Common

### Azure Core

#### 1.0.0-beta.1 ([Changelog](https://github.com/Azure/azure-sdk-for-ios/blob/1.0.0-beta.2/CHANGELOG.md#100-beta1-2020-09-21))

- Initial Preview release for Azure Core

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
