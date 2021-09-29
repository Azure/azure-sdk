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
- Key Vault Administration
- Key Vault Keys
- Azure Communication Identity
- Azure Communication Chat
- Azure EventGrid
- Azure Monitor Opentelemetry Exporter

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
pip install azure-communication-chat --pre
pip install azure-keyvault-administration --pre
pip install azure-keyvault-keys --pre
pip install azure-eventgrid --pre
pip install azure-monitor-opentelemetry-exporter --pre
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventhub_5.3.0/sdk/eventhub/azure-eventhub/CHANGELOG.md#530-2021-02-08)

- Added a `parse_connection_string` method which parses a connection string into a properties bag, `EventHubConnectionStringProperties`, containing its component parts.
- The constructor and `from_connection_string` method of `EventHubConsumerClient` and `EventHubProducerClient` now accept two new optional arguments:
  - `custom_endpoint_address` which allows for specifying a custom endpoint to use when communicating with the Event Hubs service,
and is useful when your network does not allow communicating to the standard Event Hubs endpoint.
  - `connection_verify` which allows for specifying the path to the custom CA_BUNDLE file of the SSL certificate which is used to authenticate
the identity of the connection endpoint.
- Updated uAMQP dependency to 1.2.14.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-metricsadvisor_1.0.0b3/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md#100b3-2021-02-09)

#### New Features

- AAD authentication support
- `MetricsAdvisorKeyCredential` support for rotating the subscription and api keys to update long-lived clients

#### Breaking Changes

- `list_dimension_values` has been renamed to `list_anomaly_dimension_values`
- Update methods now return None
- Updated DataFeed.metric_ids to be a dict rather than a list

### Synapse

#### Access Control [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-synapse-accesscontrol_0.5.0/sdk/synapse/azure-synapse-accesscontrol/CHANGELOG.md#050-2021-02-09)

- Update to API version 2020-08-01

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-search-documents_11.1.0/sdk/search/azure-search-documents/CHANGELOG.md#1110-2021-02-10)

#### Breaking Changes

- `IndexDocumentsBatch` does not support `enqueue_action` any longer. `enqueue_actions` takes a single action too.
- `max_retries` of `SearchIndexingBufferedSender` is renamed to `max_retries_per_action`.
- `SearchClient` does not support `get_search_indexing_buffered_sender` any longer

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-formrecognizer_3.1.0b3/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310b3-2021-02-09)

- `Appearance` is renamed to `TextAppearance`.
- `Style` is renamed to `TextStyle`.
- Client property `api_version` is no longer exposed. Pass keyword argument `api_version` into the client to select the API version.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-textanalytics_5.1.0b5/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b5-2021-02-10)

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

### Key Vault Administration [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-administration_4.0.0b3/sdk/keyvault/azure-keyvault-administration/CHANGELOG.md#400b3-2021-02-09)

#### New Features
- `KeyVaultAccessControlClient` supports managing custom role definitions

#### Breaking Changes
- Renamed `KeyVaultBackupClient.begin_full_backup()` to `.begin_backup()`
- Renamed `KeyVaultBackupClient.begin_full_restore()` to `.begin_restore()`
- Renamed `KeyVaultPermission` attributes
- Renamed `KeyVaultRoleScope` enum values

### Key Vault Keys [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-keyvault-keys_4.4.0b2/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#440b1-2021-2-10)

#### New Features
- Support for Key Vault API version 7.2-preview
([#16566](https://github.com/Azure/azure-sdk-for-python/pull/16566))
- Updated default API version to 7.2-preview

### Azure Eventgrid 2.0.0b5 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventgrid_2.0.0b5/sdk/eventgrid/azure-eventgrid/CHANGELOG.md#200b5-2021-02-10)

- `EventGridSharedAccessSignatureCredential` is deprecated in favor of `AzureSasCredential`.
- `azure.eventgrid.models` namespace along with all the models in it are now removed. `azure.eventgrid.SystemEventNames` can be used to get the event model type mapping.
- `topic_hostname` is renamed to `endpoint` in the `EventGridPublisherClient`.
- `azure.eventgrid.generate_shared_access_signature` method is now renamed to `generate_sas`.
- `EventGridConsumer`is now removed. Please see the samples to see how events can be deserialized.
- `CustomEvent` model is removed. Dictionaries must be used to send a custom schema.

### Azure Monitor Opentelemetry Exporter 1.0.0b3 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-monitor-opentelemetry-exporter_1.0.0b3/sdk/monitor/azure-monitor-opentelemetry-exporter/CHANGELOG.md#100b3-2021-02-11)

- The package `azure-opentelemetry-exporter-azuremonitor` has been renamed to `azure-monitor-opentelemetry-exporter`
- Removed `ExporterOptions` to favor keyword only args.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
