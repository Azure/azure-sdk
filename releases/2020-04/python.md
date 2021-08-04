---
title: Azure SDK for Python (April 2020)
layout: post
date: 2020-04-14
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the April 2020 client library GA release.

This release includes the following:

#### Preview

- Text Analytics
- Service Bus
- Event Hubs
- Search Documents
- Identity
- Form Recognizer


## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-appconfiguration
pip install --pre azure-eventhub
pip install azure-eventhub-checkpointstoreblob
pip install azure-eventhub-checkpointstoreblob-aio
pip install azure-storage-blob
pip install azure-storage-file-datalake
pip install azure-storage-file-share
pip install azure-storage-queue
pip install azure-keyvault-certificates
pip install azure-keyvault-keys
pip install azure-keyvault-secrets
pip install --pre azure-identity
pip install --pre azure-ai-textanalytics
pip install --pre azure-search-documents
pip install --pre azure-servicebus
pip install azure-ai-formrecognizer
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#change-log-azure-ai-textanalytics)

- We are no longer supporting the `recognize_pii_entities` endpoint for this release
- We are removing `TextAnalyticsApiKeyCredential` and are now using `AzureKeyCredential` from azure.core.credentials as our API key credential.

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/servicebus/azure-servicebus/CHANGELOG.md)

- This release simplifies the client hierarchy and many common flows, such as spawning senders and receivers directly from the `ServiceBusClient`.  Recommend reading migration guide and full changelog for details.
- Support for Azure Identity based authentication.
- Exception hierarchy has been overhauled and made more precise to better denote failure reasons.
- Batch creation is now initiated off of the sender via `create_batch`.
- Users should be aware that this is a preview release with only support for queues, full featureset will be included in upcoming previews.

### Event Hubs [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/eventhub/azure-eventhub/CHANGELOG.md)

- Added `EventHubConsumerClient.receive_batch()` to receive and process events in batches instead of one by one. #9184
- `EventHubConsumerCliuent.receive()` has a new param `max_wait_time`.
`on_event` is called every `max_wait_time` when no events are received and `max_wait_time` is not `None` or 0.
- Param event of `PartitionContext.update_checkpoint` is now optional. The last received event is used when param event is not passed in.
- `EventData.system_properties` has added missing properties when consuming messages from IoT Hub. #10408

### Search Documents [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/search/azure-search-documents/CHANGELOG.md)

- Added index service client
- Accepted an array of `RegexFlags` for `PatternAnalyzer` and `PatternTokenizer`
- Removed `SearchApiKeyCredential` and now using `AzureKeyCredential` from azure.core.credentials as key credential

### Identity [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/identity/azure-identity/CHANGELOG.md)

- All `get_token` methods consistently require at least one scope argument, raising an error when none is passed. Although `get_token()` may sometimes have succeeded in prior versions, it couldn't do so consistently because its behavior was undefined, and dependened on the credential's type and internal state.
- The host of the Active Directory endpoint credentials should use can be set in the environment variable `AZURE_AUTHORITY_HOST`. See `azure.identity.KnownAuthorities` for a list of common values.

### Form Recognizer [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/main/sdk/formrecognizer/azure-ai-formrecognizer/CHANGELOG.md)

- The first preview with new API design for the Azure Cognitive Services Form Recognizer client library
- New namespace/package `azure-ai-formrecognizer` which replaces the package `azure-cognitiveservices-formrecognizer`
- Adds `FormRecognizerClient` to analyze custom forms, receipts, and form content/layout
- Adds `FormTrainingClient` to train custom models (with/without labels), and manage the custom models on your account
- Asynchronous APIs added under `azure.ai.formrecognizer.aio`
- Authentication with API key supported using `AzureKeyCredential("<api_key>")` from `azure.core.credentials`
- For stream methods, `content-type` is automatically detected

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
