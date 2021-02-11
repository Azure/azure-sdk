---
title: Azure SDK for Python (February 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the February 2021 client library release.

#### GA

- Search

#### Updates

- Event Hubs

#### Beta

- Metrics Advisor
- Synapse
- Form Recognizer

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-eventhub
pip install azure-ai-metricsadvisor --pre
pip install azure-synapse-managedprivateendpoints
pip install azure-synapse-accesscontrol
pip install azure-search-documents
pip install azure-ai-formrecognizer --pre
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

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md)

#### New Features

- AAD support authentication
- `MetricsAdvisorKeyCredential` support for rotating the subscription and api keys to update long-lived clients

#### Breaking Changes

- `list_dimension_values` has been renamed to `list_anomaly_dimension_values`
- Update methods now return None
- Updated DataFeed.metric_ids to be a dict rather than a list

### Synapse

#### Access Control [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/synapse/azure-synapse-accesscontrol/CHANGELOG.md)

- Update to API version 2020-08-01

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md)

#### Breaking Changes

- `IndexDocumentsBatch` does not support `enqueue_action` any longer. `enqueue_actions` takes a single action too.
- `max_retries` of `SearchIndexingBufferedSender` is renamed to `max_retries_per_action`.
- `SearchClient` does not support `get_search_indexing_buffered_sender` any longer

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310b3-2021-02-09)

- `Appearance` is renamed to `TextAppearance`.
- `Style` is renamed to `TextStyle`.
- Client property `api_version` is no longer exposed. Pass keyword argument `api_version` into the client to select the API version.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
