---
title: Azure SDK for .NET (July 2019 Preview)
date: 10 Jul 2019
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
permalink: /releases/2019-07-10/dotnet.html
---

The Azure SDK team is pleased to announce our July 2019 client library preview.  This represents the first release of a ground-up rewrite of our client libraries to ensure consistency, idiomatic design, productivity, and an excellent developer experience.  This preview includes new libraries for Storage (Blobs, Queues, and Files), Key Vault (Secrets and Keys), Event Hubs, Cosmos, and Identity.

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

    $> dotnet add package Azure.Storage.Blobs --version 12.0.0-preview.1
    $> dotnet add package Azure.Storage.Queues --version 12.0.0-preview.1
    $> dotnet add package Azure.Storage.Files --version 12.0.0-preview.1

    $> dotnet add package Azure.Security.KeyVault.Secrets --version 4.0.0-preview.1
    $> dotnet add package Azure.Security.KeyVault.Keys --version 4.0.0-preview.1

    $> dotnet add package Azure.Messaging.EventHubs --version 5.0.0-preview.1

    $> dotnet add package Microsoft.Azure.Cosmos --version 3.0.0.19-preview

    $> dotnet add package Azure.Identity --version 1.0.0-preview.2

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

- New client libraries were created using the [Azure SDK Design Guidelines for .NET][dotnet-guidelines] resulting in consistent API patterns and shared features like automatic retries, authentication, logging, configurable transport pipelines, exceptions, mocking, etc.
- Support for Azure Active Directory credentials using our new Identity library that embrace the future of authentication across Azure services.
- Parity across synchronous and asynchronous APIs offering a choice appropriate to your application.

## Quick Links

See [Nov Release](..\2019-11\dotnet.html)

{% include refs.md %}