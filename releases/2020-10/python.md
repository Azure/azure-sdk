---
title: Azure SDK for Python (October 2020)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### GA

- _Add packages_

#### Updates

- App Configuration

#### Beta

- Service Bus
- Search
- Text Analytics

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-servicebus --pre
pip install azure-search-documents --pre
pip install azure-appconfiguration
pip install azure-ai-textanalytics --pre
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed changelogs are linked from the [Quick Links](#quick-links) below. Here are some of the highlights:

### Service Bus [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md)

#### Breaking changes

* Passing any type other than `ReceiveMode` as parameter `receive_mode` now throws a `TypeError` instead of `AttributeError`.
* Administration Client calls now take only entity names, not `<Entity>Descriptions` as well to reduce ambiguity in which entity was being acted on. TypeError will now be thrown on improper parameter types (non-string).
* `AMQPMessage` (`Message.amqp_message`) properties are now read-only, changes of these properties would not be reflected in the underlying message.  This may be subject to change before GA.

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md)

#### Features

- Added auto_flush_interval support for SearchIndexingBufferedSender

#### Breaking Changes

- Renamed SearchIndexDocumentBatchingClient to SearchIndexingBufferedSender
- Renamed SearchIndexDocumentBatchingClient.add_upload_actions to SearchIndexingBufferedSender.upload_documents
- Renamed SearchIndexDocumentBatchingClient.add_delete_actions to SearchIndexingBufferedSender.delete_documents
- Renamed SearchIndexDocumentBatchingClient.add_merge_actions to SearchIndexingBufferedSender.merge_documents
- Renamed SearchIndexDocumentBatchingClient.add_merge_or_upload_actions to SearchIndexingBufferedSender.merge_or_upload_documents
- Stopped supporting window kwargs for SearchIndexingBufferedSender
- Split kwarg hook into on_new, on_progress, on_error, on_remove for SearchIndexingBufferedSender

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b2-2020-10-06)

#### Breaking changes

* Removed extra property `length` from relevant models. Originally, this property represented the length of the `text` property in those same models. To get the length of the text in these models, just call `len()` on the text property.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
