---
title: Azure SDK Releases (March 2020)
date: 2020-03-17
sidebar: releases_sidebar
repository: azure/azure-sdk
---

Welcome to the March release of the Azure SDK.  We have updated the following libraries:

* App Configuration (Java only).
* Event Hubs.
* KeyVault Certificates, Keys, and Secrets v4.0.
* Storage Blobs, File Shares, and Queues.
* Storage Data Lake (new GA release).

These are ready to use in your production applications.  You can find details of all released libraries on [our releases page]({{site.baseurl}}{% link releases/latest/index.md %}).

New preview releases:

* Azure Identity.
* Azure Cognitive Search.
* Cosmos (Java only).
* Key Vault v4.1
* Text Analytics.

In addition, we have released a new preview for the Java distributed tracing client, and a new GA release for the Python distributed tracing client.  The distributed tracing client allows you to trace a request from the SDK entry-point through to the service using Azure Monitor.

We believe these are ready for you to use and experiment with, but not yet ready for production.  Between now and the GA release, these libraries may undergo API changes.  We'd love your feedback!  If you use these libraries and like what you see, or you want to see changes, let us know in GitHub issues. 

## Getting Started

Use the links below to get started with your language of choice.  You will notice that all the preview libraries are tagged with "preview".

* [.NET release notes]({{site.baseurl}}{% link releases/2020-03/dotnet.md %})
* [Java release notes]({{site.baseurl}}{% link releases/2020-03/java.md %})
* [Python release notes]({{site.baseurl}}{% link releases/2020-03/python.md %})
* [JavaScript release notes]({{site.baseurl}}{% link releases/2020-03/js.md %})

If you want to dive deep into the content, the release notes linked above and the change logs they point to give more details on what has changed.

## Introducing Azure Cognitive Search

This month, we are introducing a preview of the Azure Cognitive Search client. [Azure Cognitive Search](https://azure.microsoft.com/services/search) is search-as-a-service, allowing developers to add a rich search experience over private, heterogenous content in web, mobile, and enterprise applications.  You've probably seen this type of search experience in action when you use a product search capability within an e-commerce site.  Let's take a look at how you can implement the search capability in your own client applications.  For this demonstration, I'm going to be using JavaScript and the React framework.

> We recommend that most applications use an intermediary web API service to protect the API key.  You can write your web API using Azure Functions and Node.js.  The same JavaScript API is used to access Azure Cognitive Search.

Start by creating a singleton service client:

```javascript
import { SearchIndexClient, SearchApiKeyCredential } from '@azure/search';
import searchClientConfiguration from './searchConfig.json';

const searchClient = new SearchIndexClient(
  searchClientConfiguration.endpoint,
  searchClientConfiguration.indexName,
  new SearchApiKeyCredential(searchClientConfiguration.apiKey)
);

export default searchClient;
```

Now, let's imagine a search page with a search box at the top and a list of results:

```javascript
import React, { useState } from 'react';
import searchClient from './searchClient';

const SearchPage = () => {
  const [results, setResults] = useState([]);
  const [searchString, setSearchString] = useState("");

  const searchProducts = async (value) => {
    setSearchString(value);
    const searchResponse = await searchClient.search({
      searchText: value,
      orderBy: [ "price desc" ],
      select: [ "productName", "price" ],
      top: 20,
      skip: 0
    });
    const searchResults = [];
    for await (const result of searchResponse.results) {
      searchResults.push(result);
    }
    setResults(searchResults);
  };

  return (
    <>
      <SearchInputBox onSearch={(value) => searchProducts(value)} />
      <FacetDisplay search={searchString} />
      <div className="searchResult">
        <ul>
          {results.map(result => <li>{result}</li>)}
        </ul>
      </div>
    </>
  );
};
```

When the user enters something in the `SearchInputBox` component, the `onSearch` method is called.  This is asynchronous, allowing your application to be responsive to more user inputs.  The search string is stored in state (re-rendering the component to update the `FacetDisplay`), then a search is executed against the Azure Cognitive Search service.  In this case, we are taking a single page of 20 results (as specified by the `top` and `skip` values).  If you wish to implement paging, you would increment the `skip` value to skip that number of entries.  In this case, successive values of `skip` would be 20, 40, 60, and so on.

[Facets](https://docs.microsoft.com/azure/search/search-filters-facets) allow you to display buckets that assist the user to further refine their search.  If you are searching for a chair, you might want to refine your search based on location, rating, or color.  Here is an example component:

```javascript
import React, { useEffect, useState } from 'react';
import searchClient from './searchClient';

const SearchPage = ({ searchString }) => {
  const [locations, setLocations] = useState([]);
  const [rating, setRating] = useState([]);

  useEffect(() => {
    const runFacetQuery = async () => {
      const response = await searchClient.search({
        searchText: searchString,
        facets: [
          "location,count:3,sort:count",
          "rating,count:5,sort:count",
          "color,count:3,sort:count"
        ]
      });

      setLocations(facets.location.map(v => v.value));
      setRating(facets.rating.map(v => v.value));
    };

    runFacetQuery();
  });

  return (
    <>
      <SearchInputBox onSearch={(value) => searchProducts(value)} />
      <FacetDisplay search={searchString} />
      <div className="searchResult">
        <h2>Location</h2>
        <ul>
          {locations.map(result => <li key={result}>{result}</li>)}
        </ul>
        <h2>Rating</h2>
        <ul>
          {rating.map(result => <li key={result}>{result}</li>)}
        </ul>
      </div>
    </>
  );
};
```

Although both the search page and the facet display components both do searches, you can combine the searches into one operation.  Once the user clicks on a facet, you will want to refine the search using an OData search filter.  For example, let's say the user clicked on the `Location=US` facet.  You can perform that search as follows:

```javascript
import { odata } from '@azure/search';

// In this case $facetLocation = 'US'
const response = await searchClient.search({
  searhcText: searchString,
  filter: odata`location eq ${facetLocation}`,
  orderBy: [ "price desc" ],
  select: [ "productName", "price" ],
  top: 20,
  skip: 0
  facets: [
    "location,count:3,sort:count",
    "rating,count:5,sort:count",
    "color,count:3,sort:count"
  ]
});
```

The `odata` formatter ensures that the variables you use are quoted properly.

Let's turn our attention to the search input box.  One of the features of any good product search is an autocompleter.  Azure Cognitive Search provides [suggesters](https://docs.microsoft.com/azure/search/index-add-suggesters) to allow the search service to suggest records you might be interested in.  You can use this to implement an autocomplete feature:

```javascript
const response = await searchClient.autocomplete({
  searchText: searchString,
  suggesterName: 'sg'
});
const suggestions = response.results || [];
```

You can then use the suggestions to populate the drop-down autocomplete box.

For more information on the Azure Cognitive Search SDK for JavaScript, check out the [API documentation](https://azuresdkdocs.blob.core.windows.net/$web/javascript/azure-search/11.0.0-preview.1/index.html).  The Azure Cognitive Search SDK is also available for [Python](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-search/1.0.0b1/index.html), [Java](https://azuresdkdocs.blob.core.windows.net/$web/java/azure-search/11.0.0-beta.1/index.html), and [.NET](https://azuresdkdocs.blob.core.windows.net/$web/dotnet/Azure.Search/11.0.0-preview.1/api/index.html).

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback ranging from documentation issues to API surface area change requests to pointing out failure cases.  Please keep that coming.  We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@azuresdk](https://twitter.com/AzureSDK) on Twitter.
