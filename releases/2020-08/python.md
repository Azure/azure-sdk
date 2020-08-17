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

- App Configuration
- Identity
- Text Analytics
- Key Vault

#### Preview

 - Service Bus
 - Form Recognizer
 - Search

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install azure-identity
pip install azure-ai-textanalytics
pip install --pre azure-servicebus
pip install azure-ai-formrecognizer
pip install --pre azure-search-documents
pip install azure-keyvault-certificates
pip install azure-keyvault-keys
pip install azure-keyvault-secrets
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/azure-identity/CHANGELOG.md)

#### Breaking Changes
- User authentication and cache configuration APIs added since 1.4.0b1 have been removed (see the full changelog for details). They will return in 1.5.0b1.
- Renamed `VSCodeCredential` to `VisualStudioCodeCredential`

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#500-2020-07-27)

- Re-released GA version 1.0.0 under new version 5.0.0

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md)

#### New Features

- This release continues to move towards feature parity with the existing sdk.  Recommend reading migration guide and full changelog for details.
- Added properties to Message, PeekMessage and ReceivedMessage such as `content_type`, `label`, `message_id`, `dead_letter_error_description` and `delivery_count`.
Please refer to the docstring for further information, and service bus changelog for full enumeration.
- Added new supported value types int, float, datetime and timedelta for `CorrelationFilter.properties`.
- Added new properties `parameters` and `requires_preprocessing` to `SqlRuleFilter` and `SqlRuleAction`.
- Added an explicit method to fetch the continuous receiving iterator, `get_streaming_message_iter()` such that `max_wait_time` can be specified as an override.
- Added support for sending received messages via `ServiceBusSender.send_messages`.
- Added `on_lock_renew_failure` as a parameter to `AutoLockRenew.register`, taking a callback for when the lock is lost non-intentially (e.g. not via settling, shutdown, or autolockrenew duration completion).

#### Breaking changes

- Removed/Renamed several properties and instance variables on Message, PeekMessage, and ReceivedMessage, such as renaming `user_properties` -> `properties` and removing `annotations` `settled` and `expired`.
Please refer to the service bus changelog for a full enumeration.
- `AutoLockRenew.sleep_time` and `AutoLockRenew.renew_period` have been made internal as `_sleep_time` and `_renew_period` respectively, as it is not expected a user will have to interact with them.
- `AutoLockRenew.shutdown` is now `AutoLockRenew.close` to normalize with other equivalent behaviors.
- Management objects have been renamed (e.g. `QueueDescription` -> `QueueProperties`) and had their method parameters adjusted accordingly, with `create_*` now taking a `name` parameter instead of a description object, and `update_*` explicitly taking a properties object (as obtained from `get_*`) to guard against partial updates.
As before, please refer to the official changelog for a more complete enumeration.
- Renamed `idle_timeout` in `get_<queue/subscription>_receiver()` to `max_wait_time` to normalize with naming elsewhere.
- Updated uAMQP dependency to 1.2.10 such that the receiver does not shut down when generator times out, and can be received from again.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#300b1-2020-08-11)

#### Breaking changes

- Version of this package bumped to `3.0.0b1` and now targets the service's stable v2.0 API
- Values are now capitalized for enums `FormContentType`, `LengthUnit`, `TrainingStatus`, and `CustomFormModelStatus`
- `document_name` renamed to `name` on `TrainingDocumentInfo`
- Keyword argument `include_sub_folders` renamed to `include_subfolders` on `begin_training` methods

#### New features

- `FormField` now has attribute `value_type` which contains the semantic data type of the field value. The options for
`value_type` are described in the enum `FieldValueType`


### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md)

#### New Features

- new SearchIndexDocumentBatchingClient

SearchIndexDocumentBatchingClient supports handling document indexing actions in an automatic way. It can trigger the flush method automatically based on pending tasks and idle time.

### Key Vault

- All Key Vault libraries now target the service's 7.1 API version
#### Keys [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-keys/CHANGELOG.md#420-2020-08-11)
#### Secrets [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-secrets/CHANGELOG.md#420-2020-08-11)
#### Certificates [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/keyvault/azure-keyvault-certificates/CHANGELOG.md#420-2020-08-11)

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

### Azure Cosmos DB Python SDK

#### Version 4.1.0 (2020-08-10) Released

**New features**
- Added the ability to set the analytical storage TTL when creating a new container.

**Bug fixes**
- Added deprecation warning for "lazy" indexing mode. The backend no longer allows creating containers with this mode and will set them to consistent instead.
- Fixed support for dicts as inputs for get_client APIs.
- Fixed Python 2/3 compatibility in query iterators.
- Fixed type hint error. Issue #12570 - thanks @sl-sandy.
- Fixed bug where options headers were not added to upsert_item function. Issue #11791 - thank you @aalapatirvbd.
- Fixed error raised when a non string ID is used in an item. It now raises TypeError rather than AttributeError. Issue #11793 - thank you @Rabbit994.


{% include refs.md %}
