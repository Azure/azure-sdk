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

- Synapse

## Installation Instructions

To install the latest beta version of the packages, copy and paste the following commands into a terminal:

```bash
$> pip install azure-synapse-monitoring==0.2.0
$> pip install azure-synapse-managedprivateendpoints==0.3.0
$> pip install azure-synapse-accesscontrol==0.6.0
$> pip install azure-synapse-spark==0.5.0
$> pip install azure-synapse-artifacts==0.5.0
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Release highlights

### Synapse

Synapse packages stop Python 3.5 support.

#### Artifacts [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/azure-synapse-artifacts_0.5.0/sdk/synapse/azure-synapse-artifacts/CHANGELOG.md)

- Add library operations.
- Change create_or_update_sql_script, delete_sql_script, rename_sql_script to long running operations.

## Latest Releases

View all the latest versions of Python packages [here][python-latest-releases].

{% include refs.md %}
