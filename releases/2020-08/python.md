---
title: Azure SDK for Python (August 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the August 2020 client library release.

#### GA

- _Add packages_

#### Updates

- Identity

#### Preview

- _Add packages_

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-identity
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/CHANGELOG.md)

#### Breaking Changes
- User authentication and cache configuration APIs added since 1.4.0b1 have been removed (see the full changelog for details). They will return in 1.5.0b1.
- Renamed `VSCodeCredential` to `VisualStudioCodeCredential`

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
