---
title: Azure SDK for iOS (December 2020)
layout: post
tags: ios azure
sidebar: releases_sidebar
repository: azure/azure-sdk-for-ios
---

The Azure SDK team is pleased to announce our December 2020 client library releases.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- _Add packages_

## Installation Instructions

To install the latest GA and beta libraries, use the [Swift Package Manager](https://swift.org/package-manager/).

### Xcode

Follow the instructions in [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app):

With your project open in Xcode 11 or later, select **File > Swift Packages > Add Package Dependency...** Enter the clone URL of this repository: *https://github.com/Azure/azure-sdk-for-ios.git* and click **Next**. For the version rule, specify the exact version or version range you wish to use with your application and click **Next**. Finally, place a checkmark next to each client library you wish to use with your application, ensure your application target is selected in the **Add to target** dropdown, and click **Finish**.

### Swift CLI

Follow the example in [Importing Dependencies](https://swift.org/package-manager/#importing-dependencies):

Open your project's `Package.swift` file and add a new package dependency to your project's `dependencies` section, specifying the clone URL of the repository and the version specifier you wish to use:

```swift
// Insert dependencies here
```

Next, add each client library you wish to use in a target to the target's array of `dependencies`:

```swift
// Insert dependencies here
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-ios/issues).

## Release highlights

### _Package name_

- Major changes only!

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

{% include refs.md %}
