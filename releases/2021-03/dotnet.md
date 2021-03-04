---
title: Azure SDK for .NET (March 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

<!--
Azure.MixedReality.Authentication:1.0.0
Azure.MixedReality.RemoteRendering:1.0.0-beta.3
Azure.MixedReality.ObjectAnchors.Conversion:0.1.0-beta.1
Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring:3.2.0-preview.4

[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to announce our March 2021 client library releases.

#### GA
- Azure Mixed Reality Authentication

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta
- Azure Remote Rendering
- Azure Object Anchors Conversion
- LUIS - Authoring

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet install Azure.MixedReality.Authentication --version 1.0.0
$> dotnet install Azure.MixedReality.RemoteRendering --version 1.0.0-beta.3
$> dotnet install Azure.MixedReality.ObjectAnchors.Conversion --version 0.1.0-beta.1
$> dotnet install Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring --version 3.2.0-preview.4

```

[pattern]: # ($> dotnet install ${PackageName} --version ${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights
### Azure Mixed Reality Authentication 1.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.Authentication_1.0.0/sdk/mixedreality/Azure.MixedReality.Authentication/CHANGELOG.md#100-2021-02-23)
- First stable release.

### Azure Remote Rendering 1.0.0-beta.3 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.RemoteRendering_1.0.0-beta.3/sdk/remoterendering/Azure.MixedReality.RemoteRendering/CHANGELOG.md#100-beta3-2021-02-24)
- Allow the STS endpoint to be customized.
- Changed constructors to align with guidance.

### Azure Object Anchors Conversion 0.1.0-beta.1 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Azure.MixedReality.ObjectAnchors.Conversion_0.1.0-beta.1/sdk/objectanchors/Azure.MixedReality.ObjectAnchors.Conversion/CHANGELOG.md#010-beta1-2021-02-26)
- Initial client

### LUIS - Authoring 3.2.0-preview.4 [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring_3.2.0-preview.4/sdk/cognitiveservices/Microsoft.Azure.CognitiveServices.Language.LUIS.Authoring/CHANGELOG.md#320-preview4-2021-02-25)
#### Fixed
- ExampleId attribute in label APIs could not hold int values
- ArmTokenParameter parameter name had a typo

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
