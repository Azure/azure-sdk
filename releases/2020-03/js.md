---
title: Azure SDK for JavaScript (March 2020)
layout: post
date: March 2020
tags: javascript typescript
sidebar: releases_sidebar
repository: azure/azure-sdk-for-js
---

The Azure SDK team is pleased to make available the March 2020 client library release. This represents the seventh release of the ground-up rewrite of the client libraries to ensure consistency, idiomatic design, and excellent developer experience and productivity. This release includes:

- Update for Azure Cosmos
- Update for Azure Event Hubs
- Update for Azure Blob Storage
- New preview for Azure Text Analytics

## Installation Instructions
To install the packages, copy and paste the below into a terminal.

    $> npm install @azure/event-hubs
    $> npm install @azure/storage-blob
    $> npm install @azure/storage-file-share
    $> npm install @azure/storage-file-datalake
    $> npm install @azure/storage-queue
    $> npm install @azure/ai-text-analytics
    $> npm install @azure/cosmos

## Feedback
If you have a bug or feature request for one of the libraries, please post an issue at the [azure-sdk-for-js repository](https://github.com/azure/azure-sdk-for-js/issues)

## Changelog

Detailed change logs for each of the libraries can be found in the source repository linked to in the Quick Links table.
Below are some noteworthy changes in the current release.

<!--TODO -->

## Latest Releases

{% assign packages = site.data.releases.latest.js-packages %}
{% include js-packages.html %}

{% include refs.md %}
