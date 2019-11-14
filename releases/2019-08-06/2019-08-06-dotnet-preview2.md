---
title: Azure SDK for .NET (August 2019 Preview)
layout: post
date: 6 Aug 2019
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
permalink: /releases/2019-08-06/dotnet.html
---

The Azure SDK team is pleased to announce our August 2019 client library preview.  This represents the first release of a ground-up rewrite of our client libraries to ensure consistency, idiomatic design, productivity, and an excellent developer experience.  This preview includes new libraries for Storage (Blobs, Queues, and Files), Key Vault (Secrets and Keys), Event Hubs, Cosmos, and Identity.

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.Storage.Blobs --version 12.0.0-preview.2
    $> dotnet add package Azure.Storage.Queues --version 12.0.0-preview.2
    $> dotnet add package Azure.Storage.Files --version 12.0.0-preview.2

    $> dotnet add package Azure.Security.KeyVault.Secrets --version 4.0.0-preview.3
    $> dotnet add package Azure.Security.KeyVault.Keys --version 4.0.0-preview.2

    $> dotnet add package Azure.Messaging.EventHubs --version 5.0.0-preview.2

    $> dotnet add package Azure.Identity --version 1.0.0-preview.3

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

- New client libraries were created using the [Azure SDK Design Guidelines for .NET][dotnet-guidelines] resulting in consistent API patterns and shared features like automatic retries, authentication, logging, configurable transport pipelines, exceptions, mocking, etc.
- Support for Azure Active Directory credentials using our new Identity library that embrace the future of authentication across Azure services.
- Parity across synchronous and asynchronous APIs offering a choice appropriate to your application.
- Updated dependencies on the latest (preview-7) version of `Azure.Core` library.

### Azure Identity

- Added new user credential types, allowing authentication within client applications.

### Event Hubs

- Expanded support for sending multiple messages in a single call by adding the ability to create a batch which avoids the error scenario of exceeding size limits. Users having bandwidth concerns can control the batch size as desired.
- Introduced a new model for consuming events via the `EventProcessor` class. This simplifies the process of checkpointing today and will handle load balancing across partitions in upcoming updates.
- Enabled the ability to subscribe to the events exposed by an `EventHubConsumer` in the form of an asynchronous iterator. With the iterator, consumers are able to use the familiar `foreach` pattern to receive events as they are available and to process them.

### Key Vault

- Added support for cryptographic operations (such as sign, verify, encrypt, and decrypt) using KeyVault keys.
- Added support for challenge based authentication.

## Quick Links

See [Nov Release](..\2019-11\dotnet.html)

{% include refs.md %}