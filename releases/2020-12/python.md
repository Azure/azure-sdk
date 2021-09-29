---
title: Azure SDK for Python (December 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the December 2020 client library release.

#### GA

- Management Library - App Service
- Management Library - Authorization
- Management Library - Cosmos DB
- Management Library - Container Instance
- Management Library - Container Service
- Management Library - Redis Cache
- Management Library - Service Bus
- Management Library - SQL

#### Updates

- _Add packages_

#### Beta

- Synapse

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-mgmt-appplatform
pip install azure-mgmt-authorization
pip install azure-mgmt-cosmosdb
pip install azure-mgmt-containerinstance
pip install azure-mgmt-containerservice
pip install azure-mgmt-redis
pip install azure-mgmt-servicebus
pip install azure-mgmt-sql
pip install azure-synapse-monitoring
pip install azure-synapse-managedprivateendpoints
pip install azure-synapse-accesscontrol
pip install azure-synapse-spark
pip install azure-synapse-artifacts
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Management Libraries
We are excited to announce the GA releases of management libraries that follow the [Azure SDK Design Guidelines for Python](https://azure.github.io/azure-sdk/python/guidelines/). These new libraries provide a number of core capabilities that are shared amongst all Azure SDKs, including the intuitive Azure Identity library, an HTTP Pipeline with custom policies, error-handling, distributed tracing, and much more. Documentation and code samples for these new libraries can be found [here](http://aka.ms/azsdk/python/mgmt)

### Synapse

#### Managed Private Endpoints [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/synapse/azure-synapse-managedprivateendpoints/CHANGELOG.md)

- Initial Release

#### Monitoring [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/synapse/azure-synapse-monitoring/CHANGELOG.md)

- Initial Release

#### Artifacts [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/synapse/azure-synapse-artifacts/CHANGELOG.md)

- Add Workspace git repo management operations
- Add rename method for data flow, dataset, linked service, notebook, pipeline, spark job definition, sql script operations

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
