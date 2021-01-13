---
title: Azure SDK for .NET (January 2021)
layout: post
tags: dotnet
sidebar: releases_sidebar
repository: azure/azure-sdk-for-net
---

The Azure SDK team is pleased to announce our January 2021 client library releases.

#### GA

- Newtonsoft.Json support for Azure.Core
- Newtonsoft.Json support for Microsoft.Spatial
- System.Text.Json support for Microsoft.Spatial

#### Updates

- _Add packages_

#### Beta

- Azure.Security.Attestation

## Installation Instructions

To install any of our packages, please search for them via `Manage NuGet Packages...` in Visual Studio (with `Include prerelease` checked) or copy these commands into your terminal:

```bash
$> dotnet add package Microsoft.Azure.Core.NewtonsoftJson --version 1.0.0
$> dotnet add package Microsoft.Azure.Core.Spatial --version 1.0.0
$> dotnet add package Microsoft.Azure.Core.Spatial.NewtonsoftJson --version 1.0.0
$> dotnet add package Azure.Security.Attestation --version 1.0.0-beta.1
```

## Feedback

If you have a bug or feature request for one of the libraries, please [file an issue in our repo](https://github.com/Azure/azure-sdk-for-net/issues/new/choose).

## Release highlights

### Newtonsoft.Json support for Azure.Core [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.NewtonsoftJson_1.0.0/sdk/core/Microsoft.Azure.Core.NewtonsoftJson/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.NewtonsoftJson to use Newtonsoft.Json for serialization.

### Newtonsoft.Json support for Microsoft.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.Spatial.NewtonsoftJson_1.0.0/sdk/core/Microsoft.Azure.Core.Spatial.NewtonsoftJson/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.Spatial.NewtonsoftJson to use Newtonsoft.Json to serialize supported Microsoft.Spatial types.

### System.Text.Json support for Microsoft.Spatial [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/Microsoft.Azure.Core.Spatial_1.0.0/sdk/core/Microsoft.Azure.Core.Spatial/CHANGELOG.md)

- Initial release of Microsoft.Azure.Core.Spatial to use `System.Text.Json` to serialize supported Microsoft.Spatial types.

### Azure.Security.Attestation [Changelog](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/attestation/Azure.Security.Attestation/CHANGELOG.md)

  - Initial release of Azure.Security.Attestation Beta version to support data-plane operations of Microsoft Azure Attestation.

## Latest Releases

View all the latest versions of .NET packages [here][dotnet-latest-releases].

{% include refs.md %}
