---
title: Azure SDK for Embedded C (October 2020)
layout: post
tags: c
sidebar: releases_sidebar
repository: azure/azure-sdk-for-c
---

The Azure SDK team is pleased to make available the October 2020 client library release.

#### GA

- Azure Core
- Azure IoT

#### Updates

- Azure Core

## Installation Instructions

To install any of our packages, copy and paste the following commands into a terminal:

```bash
git clone https://github.com/Azure/azure-sdk-for-c

git checkout <tag_name>
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

## Changelog

### Azure Core [Changelog](https://github.com/Azure/azure-sdk-for-c/blob/main/CHANGELOG.md)

#### New Features

- Added an az_log_classification_filter_fn callback function type along with a setter az_log_set_classification_filter_callback(), allowing the caller to filter log messages.

#### Bug Fixes

- Fix bounds check while processing incomplete JSON string containing escaped characters to avoid out-of-range access.
- Fix Windows to use /MT when building the CRT and static libraries.
- Fail gracefully on invalid/incomplete HTTP response processing by avoiding reading from size 0 span.

#### Other Changes and Improvements

- Add precondition check to validate clients are initialized before passed in to public APIs.
- Add high-level and simplified az_core.h and az_iot.h files for simpler include experience for customers.

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

{% include refs.md %}
