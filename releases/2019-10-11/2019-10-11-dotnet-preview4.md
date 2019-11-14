---
title: Azure SDK for .NET (October 2019 Preview)
layout: post
date: 11 Oct 2019
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
permalink: /releases/2019-10-11/dotnet.html
---

The Azure SDK team is pleased to announce our September 2019 client library preview.  This represents the first release of a ground-up rewrite of our client libraries to ensure consistency, idiomatic design, productivity, and an excellent developer experience.  This preview includes new libraries for Storage (Blobs, Queues, and Files), Key Vault (Secrets and Keys), Event Hubs, Cosmos, and Identity.

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.Storage.Blobs --version 12.0.0-preview.4
    $> dotnet add package Azure.Storage.Blobs.Batching --version 12.0.0-preview.4
    $> dotnet add package Azure.Storage.Queues --version 12.0.0-preview.4
    $> dotnet add package Azure.Storage.Files --version 12.0.0-preview.4

    $> dotnet add package Azure.Security.KeyVault.Secrets --version 4.0.0-preview.5
    $> dotnet add package Azure.Security.KeyVault.Keys --version 4.0.0-preview.5
    $> dotnet add package Azure.Security.KeyVault.Certificates --version 4.0.0-preview.5

    $> dotnet add package Azure.Messaging.EventHubs --version 5.0.0-preview.4

    $> dotnet add package Azure.Identity --version 1.0.0-preview.4

    $> dotnet add package Azure.Data.AppConfiguration --version 1.0.0-preview.2

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

- New client libraries were created using the [Azure SDK Design Guidelines for .NET](https://azure.github.io/azure-sdk/dotnet_introduction.html) resulting in consistent API patterns and shared features like automatic retries, authentication, logging, configurable transport pipelines, exceptions, mocking, etc.
- Support for Azure Active Directory credentials using our new Identity library that embrace the future of authentication across Azure services.
- Parity across synchronous and asynchronous APIs offering a choice appropriate to your application.
- Updated dependencies on the latest (preview-7) version of `Azure.Core` library.

### Storage

- Batching multiple Delete or SetAccessTier operations in a single request
- Customer Provided Key server side encryption
- Support for geo-redundant read from secondary location on failure
- CreateIfNotExists and DeleteIfNotExists convenience methods for Blobs
- Convenient resource Name properties on all clients
- Verification of echoed client request IDs
- `FileClient.PutRangeFromUri` operation
- A variety of bug fixes and API improvements

### Azure Identity

- Added new user credential types, allowing authentication within client applications.

### Event Hubs

- Fixed date parsing for time zones ahead of UTC in the Event Hub Consumer when tracking of the last event was disabled.
- Improved stability and performance with refactorings around hot paths and areas of technical debt.
- Included the Event Hubs namespace as part of the checkpoint key, ensuring that there is no conflict between Event Hubs instances in different regions using the same Event Hub and consumer group names.

### Key Vault

- `CryptographyClient` now supports AES key wrap, EC, and RSA cryptographic algorithms.
- `CryptographyClient` will verify key operations are supported locally or call into Key Vault if not.
- Many methods have been renamed to be consistent across service libraries.
- Various bug fixes and API improvements based on customer feedback.

### App Configuration

- Enabled conditional requests.
- Added support for setting x-ms-client-request-id, x-ms-correlation-request-id, and correlation-context headers.
- Added SetReadOnly/ClearReadOnly methods.
- Enabled setting service version.
- Added support for Sync-Token headers.
- Updated authorization header format.
- Removed Update methods.

## Quick Links

See [Nov Release](..\2019-11\dotnet.html)

{% include refs.md %}
