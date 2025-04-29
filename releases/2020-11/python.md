---
title: Azure SDK for Python (November 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the November 2020 client library release.

#### GA

- Storage

#### Updates

- _Add packages_

#### Beta

- Communication Administration
- Communication Chat
- Communication SMS
- Service Bus
- Search
- Management Library - Communication
- Metrics Advisor
- Eventgrid
- Form Recognizer
- Text Analytics

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-communication-administration --pre
pip install azure-communication-chat --pre
pip install azure-communication-sms --pre
pip install azure-servicebus --pre
pip install azure-search-documents --pre
pip install azure-ai-metricsadvisor --pre
pip install azure-eventgrid --pre
pip install azure-storage-blob
pip install azure-storage-file-datalake
pip install azure-storage-file-share
pip install azure-storage-queue
pip install azure-ai-formrecognizer --pre
pip install azure-mgmt-communication --pre
pip install azure-ai-textanalytics --pre
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Communication Administration [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-communication-administration_1.0.0b3/sdk/communication/azure-communication-administration/CHANGELOG.md#100b3-2020-11-16)

#### New Features

##### `PhoneNumberAdministrationClient`

- Added long-running operation polling methods `ReservePhoneNumberPolling`, `PurchaseReservationPolling`, `ReleasePhoneNumberPolling`.

#### Breaking Changes

##### `PhoneNumberSearch` renamed to `PhoneNumberReservation`.

##### `PhoneNumberReservation`

- `search_id` has been renamed to `reservation_id`.

##### `PhoneNumberAdministrationClient`

- `get_search_by_id` has been renamed to `get_reservation_by_id`.
- `create_search` has been renamed to `begin_reserve_phone_numbers`.
- `begin_reserve_phone_numbers` now takes either `options`, or `continuation_token` keywords as input.
- `begin_reserve_phone_numbers` now returns `LROPoller[PhoneNumberReservation]`.
- `release_phone_numbers` has been renamed to `begin_release_phone_numbers`.
- `begin_release_phone_numbers` now takes either `phone_numbers`, or `continuation_token` keywords as input.
- `begin_release_phone_numbers` now returns `LROPoller[PhoneNumberRelease]`.
- `purchase_search` has been renamed to `begin_purchase_reservation`.
- `begin_purchase_reservation` now takes either `reservation_id`, or `continuation_token` keywords as input.
- `begin_purchase_reservation` now returns `LROPoller[PurchaseReservationPolling]`.
- `cancel_search` has been renamed to `cancel_reservation`.

### Communication Chat [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-chat/CHANGELOG.md#100b3-2020-11-16)

This release contains minor bug fixes and improvements.

### Communication SMS [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-communication-sms/CHANGELOG.md#100b4-2020-11-16)

This release contains minor bug fixes and improvements.

### Management Library - Communication [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/communication/azure-mgmt-communication/CHANGELOG.md#100b4-2020-11-16)

This release contains minor bug fixes and improvements.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/servicebus/azure-servicebus/CHANGELOG.md)

#### New Features

* Addition of `timeout` paramter to sending, lock renewel, and settlement functions.
* Addition of `auto_lock_renewer` parameter when getting a receiver to opt-into auto-registration of lock renewal for messages on receipt (or, if a session receiver, the session on open).

#### Breaking changes

* Significant renames across parameter, entity, and exception types such as utilizing a ServiceBus prefix, e.g. `ServiceBusMessage`.
* Refactors all service-impacting operations from the `ServiceBusMessage` object onto the `ServiceBusReceiver` object itself, e.g. lock renewal and settlement.
* `get_*_session_receiver` functions have been incorporated into their `get_*_receiver` counterparts, activated by passing a `session_id` parameter.
* Continued Exception behavior cleanup, normalization, and documentation, as well as naming polish in line with the broad name prefix alignment.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/3f1ad07b16d73107bb6c465859d224c44b6a3f55/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md)

#### Breaking Changes

- Significant renames across parameters and methods. Please go to the [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/3f1ad07b16d73107bb6c465859d224c44b6a3f55/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md) for detail information.

### Azure Storage Blob [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-blob/CHANGELOG.md)

#### New Features
- GA the following preview features: ArrowDialect as output format of `query_blob`, `undelete_container` on `BlobServiceClient`, and Last Access Time.

#### Key Bug Fixes
- Fixed the expired Authorization token problem during retry.
- Catch exceptions thrown by async download.

### Azure Storage File Share [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-share/CHANGELOG.md)

#### New Features
- GA support for enabling SMB Multichannel for the share service and `get_ranges` on `ShareFileClient`.
- Added `set_share_properties` which allows setting share tier.

### Azure Storage File DataLake [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-file-datalake/CHANGELOG.md)

#### New Features
- GA support for set/update/remove access control recursively, `set_file_expiry` on `DataLakeFileClient`. and feature generating directory level SAS.

#### Key Bug Fixes
- Fixed session closure of filesystem.

### Azure Storage Queue [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/storage/azure-storage-queue/CHANGELOG.md)

#### New Features
- Added `receive_message` on `QueueClient` to support receiving one message from queue.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#310b1-2020-11-23)

This version of the SDK defaults to the latest supported API version, which currently is v2.1-preview.

#### New Features

- Support for two new prebuilt recognition models for invoices and business cards through the
`begin_recognize_invoices()` and  `begin_recognize_business_cards()` methods (as well as their `from_url` counterparts)
of `FormRecognizerClient`.
- Support for selection marks as a new fundamental form element. This type is supported in content recognition and in
training/recognizing custom forms (labeled only).
- Support for creating composed models from a collection of existing models (trained with labels) through the
`begin_create_composed_model()` method of `FormTrainingClient`.
- A `model_name` keyword argument added for model training (both `begin_training()` and `begin_create_composed_model()`) that
can specify a human-readable name for a model.
- Support for the bitmap image format (with content type "image/bmp") in prebuilt model recognition and content recognition.
- A `locale` keyword argument added for all prebuilt model methods, allowing for the specification of a document's origin to assist the
service with correct analysis of the document's content.
- A `language` keyword argument added for the content recognition method `begin_recognize_content()` that specifies which
language to process the document in.
- A `pages` keyword argument added for the content recognition method `begin_recognize_content()` that specifies which pages
in a multi-page document should be analyzed.
- Additional properties added to response models - see Changelog for detailed information.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b3-2020-11-19)

#### New Features
- Support for the service's long-running batch analysis `Analyze` API.
- Support for the service's `Health` API. Since this is a gated preview, you will need to have your subscription put on an allow list to use.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
