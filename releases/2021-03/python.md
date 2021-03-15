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
- EventGrid

#### Updates

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

[pattern.beta]: # (- ${PackageFriendlyName})

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-eventgrid==4.0.0
```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

[pattern]: # (### ${PackageFriendlyName} ${PackageVersion} [Changelog]${ChangelogUrl}`n${HighlightsBody}`n)

### Event Grid 4.0.0 [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-eventgrid_4.0.0/sdk/eventgrid/azure-eventgrid/CHANGELOG.md#400-2021-03-09)

This is the first stable release of our efforts to create a user-friendly and Pythonic client library for Azure EventGrid. Users migrating from `v1.x` are advised to view the [migration guide](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/eventgrid/azure-eventgrid/migration_guide.md).

**New Features**
  - `azure-eventgrid` package now supports `azure.core.messaging.CloudEvent` which honors the CNCF CloudEvent spec.
  - `azure.eventgrid.SystemEventNames` can be used to get the event model type mapping for system events.
  - Implements the `EventGridPublisherClient` for the publish flow for EventGrid Events, CloudEvents and Custom schema events.

**Breaking Changes**
  - `azure.eventgrid.models` namespace along with all the models in it are now removed.:
      - JSON documentation on the events is available here: https://docs.microsoft.com/azure/event-grid/system-topics
      - `azure.eventgrid.SystemEventNames` provides the list of available events name for easy switching.
  - `azure.eventgrid.event_grid_client.EventGridClient` is now removed in favor of `azure.eventgrid.EventGridPublisherClient`.
  - `azure.eventgrid.event_grid_client.EventGridClientConfiguration` is now removed.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
