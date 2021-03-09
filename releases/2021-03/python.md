---
title: Azure SDK for Python (March 2021)
layout: post
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

<!--
[pattern]: # (${PackageName}:${PackageVersion})
-->

The Azure SDK team is pleased to make available the March 2021 client library release.

#### GA

[pattern.ga]: # (- ${PackageFriendlyName})

#### Updates

- Service Bus

#### Beta

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-servicebus
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Service Bus 7.1.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/servicebus/azure-servicebus/CHANGELOG.md#710-2021-03-09)

This version will be the last version to officially support Python 3.5, future versions will require Python 2.7 or Python 3.6+.

#### New Features

- Updated the following methods so that lists and single instances of Mapping representations are accepted for corresponding strongly-typed object arguments (PR #14807, thanks @bradleydamato):
  - `update_queue`, `update_topic`, `update_subscription`, and `update_rule` on `ServiceBusAdministrationClient` accept Mapping representations of `QueueProperties`, `TopicProperties`, `SubscriptionProperties`, and `RuleProperties`, respectively.
  - `send_messages` and `schedule_messages` on both sync and async versions of `ServiceBusSender` accept a list of or single instance of Mapping representations of `ServiceBusMessage`.
  - `add_message` on `ServiceBusMessageBatch` now accepts a Mapping representation of `ServiceBusMessage`.

#### Bug Fixes 

- Operations failing due to `uamqp.errors.LinkForceDetach` caused by no activity on the connection for 10 minutes will now be retried internally except for the session receiver case.
- `uamqp.errors.AMQPConnectionError` errors with condition code `amqp:unknown-error` are now categorized into `ServiceBusConnectionError` instead of the general `ServiceBusError`.
- The `update_*` methods on `ServiceBusManagementClient` will now raise a `TypeError` rather than an `AttributeError` in the case of unsupported input type.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
