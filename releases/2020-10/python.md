---
title: Azure SDK for Python (October 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### GA

- Management Library - Compute
- Management Library - Network
- Management Library - Resource
- Management Library - Storage
- Management Library - Monitor
- Management Library - AppConfiguration
- Management Library - Event Hubs
- Management Library - KeyVault

#### Updates

- _Add packages_

#### Beta

- _Add packages_

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-mgmt-compute
pip install azure-mgmt-network
pip install azure-mgmt-resource
pip install azure-mgmt-storage
pip install azure-mgmt-monitor
pip install azure-mgmt-appconfiguration
pip install azure-mgmt-eventhub
pip install azure-mgmt-keyvault
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Management Libraries
We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Python](https://azure.github.io/azure-sdk/python/guidelines/). These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. Documentation and code samples for these new libraries can be found [here](http://aka.ms/azsdk/python/mgmt)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
