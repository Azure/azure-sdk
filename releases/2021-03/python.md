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

[pattern.patch]: # (- ${PackageFriendlyName})

#### Beta

- Text Analytics

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-ai-textanalytics --pre
```

[pattern]: # ($> pip install ${PackageName}==${PackageVersion})

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#510b6-2021-03-09)

- Using the service's v3.1-preview.4 API as default.
- `begin_analyze_healthcare_entities` relations redesign, now exposed through `entity_relations`
- Adding linked entity recognition to `begin_analyze_batch_actions`


## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
