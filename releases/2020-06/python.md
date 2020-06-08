---
title: Azure SDK for Python (June 2020)
layout: post
date: 2020-06-01
tags: python
sidebar: releases_sidebar
repository: azure/azure-sdk-for-python
---

The Azure SDK team is pleased to make available the {{ page.date | date: "%B %Y" }} client library GA release.

This release includes the following:

#### GA

- Cosmos DB

#### Preview

- Text Analytics
- Search

## Installation Instructions

To install the latest preview version of the packages, copy and paste the following commands into a terminal:

```bash
pip install azure-cosmos
pip install --pre azure-ai-textanalytics
pip install --pre azure-search-documents
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-python/issues).

## Changelog

### Cosmos DB [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/cosmos/azure-cosmos/CHANGELOG.md)

- Stable release.
- Added HttpLoggingPolicy to pipeline to enable passing in a custom logger for request and response headers.

### Text Analytics [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/textanalytics/azure-ai-textanalytics/CHANGELOG.md#100b6-2020-05-27)

- We are now targeting the service's v3.0 API, instead of the v3.0-preview.1 API
- Updated the models to correspond with service changes

### Search [Changelog](https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/search/azure-search-documents/CHANGELOG.md)

- Reorganized `SearchServiceClient` into `SearchIndexClient` & `SearchIndexerClient`
- Split searchindex.json and searchservice.json models and operations into separate namespaces
- Renamed `edm` to `SearchFieldDataType`
- Now Search Synonym Map creation/update returns a model
- Renaming:

  SearchIndexerDataSource -> SearchIndexerDataSourceConnection

  SearchField.SynonymMaps -> SearchField.SynonymMapNames

  SearchField.Analyzer -> SearchField.AnalyzerName

  SearchField.IndexAnalyzer -> SearchField.IndexAnalyzerName

  SearchField.SearchAnalyzer -> SearchField.SearchAnalyzerName

  SearchableField.SynonymMaps -> SearchableField.SynonymMapNames

  SearchableField.Analyzer -> SearchableField.AnalyzerName

  SearchableField.IndexAnalyzer -> SearchableField.IndexAnalyzerName

  SearchableField.SearchAnalyzer -> SearchableField.SearchAnalyzerName

  Similarity -> SimilarityAlgorithm

  Suggester -> SearchSuggester

  PathHierarchyTokenizerV2 -> PathHierarchyTokenizer

  DataSource -> DataSourceConnection

  AnalyzeRequest -> AnalyzeTextOptions

- Autocomplete & suggest methods now takes arguments search_text & suggester_name rather than query objects
- Create_or_updates methods does not support partial updates
- Renamed Batch methods

## Latest Releases

{% assign packages = site.data.releases.latest.python-packages %}
{% include python-packages.html %}

{% include refs.md %}
