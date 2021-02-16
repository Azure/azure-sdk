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
- Text Analytics
- Azure Communication Identity 1.0.0b4
- Azure Communication Chat 1.0.0b4

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-eventhub
pip install azure-ai-metricsadvisor --pre
pip install azure-synapse-managedprivateendpoints
pip install azure-synapse-accesscontrol
pip install azure-search-documents
pip install azure-ai-formrecognizer --pre
pip install azure-ai-textanalytics --pre
pip install azure-communication-identity
pip install --pre azure-communication-chat
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

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md#100b3-2021-02-09)

#### New Features

- AAD support authentication
- `MetricsAdvisorKeyCredential` support for rotating the subscription and api keys to update long-lived clients

#### Breaking Changes

- `list_dimension_values` has been renamed to `list_anomaly_dimension_values`
- Update methods now return None
- Updated DataFeed.metric_ids to be a dict rather than a list

### Synapse

#### Access Control [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/synapse/azure-synapse-accesscontrol/CHANGELOG.md#050-2021-02-09)

- Update to API version 2020-08-01

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md#1110-2021-02-10)

#### Breaking Changes

- `IndexDocumentsBatch` does not support `enqueue_action` any longer. `enqueue_actions` takes a single action too.
- `max_retries` of `SearchIndexingBufferedSender` is renamed to `max_retries_per_action`.
- `SearchClient` does not support `get_search_indexing_buffered_sender` any longer

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310b3-2021-02-09)

- `Appearance` is renamed to `TextAppearance`.
- `Style` is renamed to `TextStyle`.
- Client property `api_version` is no longer exposed. Pass keyword argument `api_version` into the client to select the API version.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b5-2021-02-10)

- Redesigned `begin_analyze` and renamed it to `begin_analyze_batch_actions`. Now takes as input a list of actions and documents, and returns the outputted
actions results in the same order.
- Redesigned `begin_analyze_healthcare` and renamed it to `begin_analyze_healthcare_entities`. To help with navigation of related entities, we have also
added property `related_entities` for each entity returned from this call.

### Azure Communication Administration will be deprecated

- Identity client is moved to new package Azure Communication Identity.
- Phone number administration will be moved into a new package Azure Communication Phone Numbers.

### Azure Communication Identity 1.0.0b4 [ChangeLog](https://github.com/Azure/azure-sdk-for-python/blob/azure-communication-identity_1.0.0b4/sdk/communication/azure-communication-identity/CHANGELOG.md#100b4-2021-02-09)

#### New Features

- Added CommunicationIdentityClient (originally was part of the azure.communication.administration package).
- Added ability to create a user and issue token for it at the same time.

#### Breaking Changes

- CommunicationIdentityClient.revoke_tokens now revoke all the currently issued tokens instead of revoking tokens issued prior to a given time.
- CommunicationIdentityClient.issue_tokens returns an instance of `azure.core.credentials.AccessToken` instead of `CommunicationUserToken`.

### Azure Communication Chat 1.0.0b4 [ChangeLog](https://github.com/Azure/azure-sdk-for-python/blob/azure-communication-chat_1.0.0b4/sdk/communication/azure-communication-chat/CHANGELOG.md#100b4-2021-02-09)

### New Features

- Support for CreateChatThreadResult and AddChatParticipantsResult to handle partial errors in batch calls.
- Added idempotency identifier parameter for chat creation calls.
- Added support for readreceipts and getparticipants pagination.
- Added new model for messages anc ontent types : Text, Html, ParticipantAdded, ParticipantRemoved, TopicUpdated.
- Added new model for errors (CommunicationError).
- Added `MicrosoftTeamsUserIdentifier`.

#### Breaking Changes

- Uses `CommunicationUserIdentifier` and `CommunicationIdentifier` in place of `CommunicationUser`, and `CommunicationTokenCredential` instead of `CommunicationUserCredential`.
- Removed priority field (ChatMessage.Priority).
- Renamed PhoneNumber to PhoneNumberIdentifier.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
