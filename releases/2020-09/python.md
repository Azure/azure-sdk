---
title: Azure SDK for Python (September 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the September 2020 client library release.

#### GA

- Form Recognizer
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

#### Preview

- Management Library - Authorization
- Management Library - Cosmos DB
- Management Library - Container Instance
- Management Library - Container Registry
- Management Library - Container Service
- Management Library - Digital Twins
- Management Library - Redis Cache
- Management Library - Service Bus
- Management Library - SQL


## Installation Instructions

To install the latest version of the packages (preview versions contains "--pre"), copy and paste the following commands into a terminal:

```bash
pip install azure-ai-formrecognizer
pip install azure-mgmt-compute
pip install azure-mgmt-network
pip install azure-mgmt-resource
pip install azure-mgmt-storage
pip install azure-mgmt-monitor
pip install azure-mgmt-appconfiguration
pip install azure-mgmt-eventhub
pip install azure-mgmt-keyvault
pip install --pre azure-mgmt-authorization
pip install --pre azure-mgmt-cosmosdb
pip install --pre azure-mgmt-containerinstance
pip install --pre azure-mgmt-containerregistry
pip install --pre azure-mgmt-containerservice
pip install --pre azure-mgmt-monitor
pip install --pre azure-mgmt-digtaltwins
pip install --pre azure-mgmt-redis
pip install --pre azure-mgmt-servicebus
pip install --pre azure-mgmt-sql
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300-2020-08-20)

- Generally available, stable version 3.0.0 released

### Management Libraries
We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Python](https://azure.github.io/azure-sdk/python/guidelines/). In addition, more management libraries are now in Public Preview to provide better Azure service coverage. These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more.
You can find the list of new packages [on this page](https://azure.github.io/azure-sdk/releases/latest/python.html). Documentation and code samples for these new libraries can be found [here](https://azure.github.io/azure-sdk-for-python)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
