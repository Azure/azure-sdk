---
title: Azure SDK for Python (November 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the November 2020 client library release.

#### GA

- _Add packages_

#### Updates

- _Add packages_

#### Beta

- Service Bus
- Search
- Metrics Advisor
- Eventgrid
- Form Recognizer

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-servicebus --pre
pip install azure-search-documents --pre
pip install azure-ai-metricsadvisor --pre
pip install azure-eventgrid --pre
pip install azure-ai-formrecognizer --pre
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md)

#### New Features

* Addition of `timeout` paramter to sending, lock renewel, and settlement functions.
* Addition of `auto_lock_renewer` parameter when getting a receiver to opt-into auto-registration of lock renewal for messages on receipt (or, if a session receiver, the session on open).

#### Breaking changes

* Significant renames across parameter, entity, and exception types such as utilizing a ServiceBus prefix, e.g. `ServiceBusMessage`.
* Refactors all service-impacting operations from the `ServiceBusMessage` object onto the `ServiceBusReceiver` object itself, e.g. lock renewal and settlement.
* `get_*_session_receiver` functions have been incorporated into their `get_*_receiver` counterparts, activated by passing a `session_id` parameter.
* Continued Exception behavior cleanup, normalization, and documentation, as well as naming polish in line with the broad name prefix alignment.

### Metrics Advisor [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md)

#### Breaking Changes

- Significant renames across parameters and methods. Please go to the [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/metricsadvisor/azure-ai-metricsadvisor/CHANGELOG.md) for detail information.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md)

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

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
