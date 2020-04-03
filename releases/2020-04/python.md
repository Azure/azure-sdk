---
title: Azure SDK for Python (April 2020)
layout: post
date: April 2020
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the April 2020 client library GA release.

#### Preview

- Text Analytics


## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install --pre azure-ai-textanalytics
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

Detailed change logs are linked to in the Quick Links below. Here are some critical call outs.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#change-log-azure-ai-textanalytics)

- We are no longer supporting the `recognize_pii_entities` endpoint for this release
- We are removing `TextAnalyticsApiKeyCredential` and are now using `AzureKeyCredential` from azure.core.credentials as our API key credential.


## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
