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

- _Add packages_

#### Beta

- Service Bus

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-servicebus --pre
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

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
