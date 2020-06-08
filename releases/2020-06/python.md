---
title: Azure SDK for Python (June 2020)
layout: post
date: 2020-06-01
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the {{ page.date | date: "%B %Y" }} client library GA release.

This release includes the following:

#### GA

- Cosmos DB

#### Preview

- Text Analytics
- Form Recognizer

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-cosmos
pip install --pre azure-ai-textanalytics
pip install azure-ai-formrecognizer
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

### Cosmos DB [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md)

- Stable release.
- Added HttpLoggingPolicy to pipeline to enable passing in a custom logger for request and response headers.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100b6-2020-05-27)

- We are now targeting the service's v3.0 API, instead of the v3.0-preview.1 API
- Updated the models to correspond with service changes

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md#100b3-2020-06-09)

#### Breaking changes

- All asynchronous long running operation methods now return an instance of an AsyncLROPoller from azure-core
- All asynchronous long running operation methods have been renamed with the `begin_` prefix to indicate that they return a poller object
- Method `get_form_training_client()` is removed from `FormRecognizerClient` and `get_form_recognizer_client()` is added to `FormTrainingClient`
- Other method and property renaming detailed in changelog

#### New Features

- Support to copy a custom model from one Form Recognizer resource to another
- Authentication using azure-identity credentials now supported
- All long running operation methods now accept the keyword argument `continuation_token` to restart the poller from a saved state

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md)

- This release continues to move towards feature parity with the existing sdk.  Recommend reading migration guide and full changelog for details.
- Support for management of Queue entities; creation, deletion, and fetching of metadata.
- Support for dead letter receivers against both Queues and Subscriptions.
- Includes a version bump of the internal UAMQP package to support passing both reason and description when deadlettering a message.

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
