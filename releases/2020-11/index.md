---
title: Azure SDK (November 2020)
layout: post
tags: release
sidebar: releases_sidebar
permalink: /releases/2020-11/index.html
---

Thank you for your interest in the new Azure SDKs! We release new features, improvements, and bug fixes every month. Please subscribe to our [Azure SDK Blog RSS Feed](https://devblogs.microsoft.com/azure-sdk/feed) to get notified when a new release is available.

You can find links to packages, code, and docs on our [Azure SDK Releases page](https://aka.ms/azsdk/releases).

## Release Highlights

### Identity

We're glad to announce a new major release of our Identity package. This release includes standardized Managed Identity Credential support across languages, through which we add support to Azure Arc and Azure Service Fabric. This release also includes improvements to Visual Studio Code Credential, Device Code Credential and Interactive Browser Credential.

### Service Bus

The new version 7 of the Service Bus libraries for C#, Python, Java and JavaScript provide the ability to share in some of the cross-service improvements made to the Azure development experience, such as using the new Azure Identity library to share a single authentication between clients and a unified diagnostics pipeline offering a common view of the activities across each of the client libraries. These libraries come with a single top level client called `ServiceBusClient` in contrast with multiple entry points from before, and a new `ServiceBusAdministrationClient` to perform CRUD operations on service bus entities. These libraries also include many updates, improvements, and a great deal of restructuring when compared to the previous versions, refer to the migration guides to hop on to the latest versions.

### Form Recognizer

We're releasing a new beta version of Form Recognizer. This version includes support for two new prebuilt recognition models for invoices and business cards, support for selection marks as a new fundamental form element, support for the bitmap image format in prebuilt model recognition and content recognition, language and locale arguments added to process document in different languages, and other additional properties added to response models.

### Text Analytics

We're releasing a new beta version of Text Analytics. This version includes support for batch task processing and for the recognition of  various healthcare entities such as medication name, dosage, and frequency.
## Release Notes

* [All release notes](index.md)
* [.NET release notes](dotnet.md)
* [Java release notes](java.md)
* [JavaScript/TypeScript release notes](js.md)
* [Python release notes](python.md)
* [C++ release notes](cpp.md)
* [Embedded C release notes](c.md)
* [Android release notes](android.md)
* [iOS release notes](ios.md)
