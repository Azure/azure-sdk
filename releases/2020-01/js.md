---
title: Azure SDK for JavaScript (January 2020)
layout: post
date: January 2020
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the January 2020 client library release. This represents the seventh release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This release includes:
- libraries that are moving out of the preview stage.
    - Azure Event Hubs
    - Azure Key Vault for Certificates
    - Azure App Configuration
- new preview for Azure Text Analytics

## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/app-configuration
    $> npm install @azure/keyvault-certificates
    $> npm install @azure/keyvault-keys
    $> npm install @azure/keyvault-secrets
    $> npm install @azure/event-hubs
    $> npm install @azure/eventhubs-checkpointstore-blob
    $> npm install @azure/storage-blob
    $> npm install @azure/storage-file-share
    $> npm install @azure/storage-file-datalake
    $> npm install @azure/storage-queue
    $> npm install @azure/ai-text-analytics

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

- Storage (File Shares, File Data Lake, Blobs, Queues)
  - Name properties on clients now support more kinds of endpoints(IPv4/v6 hosts, single word domains).
  - Service clients now share a single HTTP client instance by default.

  For more details, please see [Storage Blob](https://github.com/Azure/azure-sdk-for-js/blob/%40azure/storage-blob_12.0.2/sdk/storage/storage-blob/CHANGELOG.md#1202-202001) change log.

Detailed change logs for other libraries can be found in the source repository linked to in the Quick Links below.

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
