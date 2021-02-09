---
title: Azure SDK for Python (February 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the February 2021 client library release.

#### GA

- _Add packages_

#### Updates

- Event Hubs

#### Beta

- _Add packages_

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-eventhub
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventhub/azure-eventhub/CHANGELOG.md#530-2021-02-08)

- Added a `parse_connection_string` method which parses a connection string into a properties bag, `EventHubConnectionStringProperties`, containing its component parts.
- The constructor and `from_connection_string` method of `EventHubConsumerClient` and `EventHubProducerClient` now accept two new optional arguments:
  - `custom_endpoint_address` which allows for specifying a custom endpoint to use when communicating with the Event Hubs service,
and is useful when your network does not allow communicating to the standard Event Hubs endpoint.
  - `connection_verify` which allows for specifying the path to the custom CA_BUNDLE file of the SSL certificate which is used to authenticate
the identity of the connection endpoint.
- Updated uAMQP dependency to 1.2.14.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
