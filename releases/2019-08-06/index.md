---
title: Azure SDK August 2019 Preview and a dive into Consistency
layout: post
date: 2019-08-06
tags: release
sidebar: releases_sidebar
permalink: /releases/2019-08-06/index.html
---

The second previews of Azure SDKs which follow the latest Azure API Guidelines and Patterns are now available ([.NET], [Java], [JavaScript], [Python]). These previews contains bug fixes, new features, and additional work towards guidelines adherence.

## What’s new

The SDKs have many new features, bug fixes, and improvements. Some of the new features are below but please read the release notes linked above and changelogs they point at for details.

* Storage Libraries for Java now include Files and Queues support
* Storage Libraries for Python have added Async versions of the APIs for Files, Queues, and Blobs
* Event Hubs libraries across languages have expanded support for sending multiple messages in a single call by adding the ability to create a batch avoiding the error scenario where a call exceeds size limits and giving batch size control to developers with bandwidth concerns
* Event Hubs libraries across languages have introduced a new model for consuming events via the EventProcessor class which simplifies the process of checkpointing today and will handle load balancing across partitions in upcoming previews

## Diving deeper into the Guidelines: Consistency

These Azure SDKs represent a cross-organizational effort to provide an ergonomic experience to every developer using every platform and as mentioned in the [previous blog post]({{site.baseurl}}{% link releases/2019-07-10/index.md %}) developers feedback helped define the following set of principles:

* Idiomatic
* Consistent
* Approachable
* Diagnosable
* Compatible

Today we will deep dive into consistency.

## Consistent

Feedback from developers and user studies has shown that APIs which are consistent are generally easier to learn and remember. To guide SDKs from Azure to be consistent the guidelines contain [the consistency principle]({{ "/general_introduction.html#consistent" | relative_url }}):

* Client libraries should be consistent within the language, consistent with the service and consistent between all target languages. In cases of conflict, consistency within the language is the highest priority and consistency between all target languages is the lowest priority.
* Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent. The developer should not have to relearn service-agnostic concepts as they move between client libraries.
* Consistency of terminology between the client library and the service is a good thing that aids in diagnosability.
* All differences between the service and client library must have a good (articulated) reason for existing, rooted in idiomatic usage rather than whim.
* The Azure SDK for each target language feels like a single product developed by a single team.
* There should be feature parity across target languages. This is more important than feature parity with the service.

Looking at the second bullet point – “Service-agnostic concepts such as logging, HTTP communication, and error handling should be consistent.” Developers pointed out APIs that worked nicely on their own but which weren’t always perfectly consistent with each other. For examples:

**Blob storage used a skip/take style of paging, while returning a sync iterator as the result set**:

```js
let market = undefined;
do {
    const listBlobsResponse = await containerURL.listBlobFlatSegment(Aborter.none, marker);
    marker = listBlobsResponse.nextMarker;
    for (const blob of listBlobsResponse.segment.blobItems) {
        console.log(`Blob: ${blob.name}`);
    }
} while (marker);
```

**Cosmos used an async iterator to return results**:

```js
for await (const results of this.container.items.query(querySpec).getAsyncIterator()) {
    console.log(results.result);
}
```

**Event Hubs used a 'take' style call that returned an array of results of a specified size**:

```js
const myEvents = await client.receiveBatch("my-partitionId", 10);
for (const e of myEvents) {
    console.log(e);
}
```

When using all three of these services together, developers indicated they had to work to remember more or refresh their memory by reviewing code samples.

## The Consistency SDK Guideline

The [JavaScript guidelines]({{ site.baseurl }}{% link docs/typescript/introduction.md %}) specify how to handle this situation in the section [Modern and Idiomatic JavaScript]({{ "/typescript_design.html#ts-modern-javascript" | relative_url }}):

{% include requirement/SHOULD id="ts-use-async-functions" %} _use `async` functions for implementing asynchronous library APIs._

_If you need to support ES5 and are concerned with library size, use `async` when combining asynchronous code with control flow constructs.  Use promises for simpler code flows.  `async` adds code bloat (especially when targeting ES5) when transpiled._

{% include requirement/MUST id="ts-use-iterators" %} _use [Iterators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Iterators_and_Generators) and [Async Iterators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for-await...of) for sequences and streams of all sorts._

_Both iterators and async iterators are built into JavaScript and easy to consume. Other streaming interfaces (such as node streams) may be used where appropriate as long as they're idiomatic._

In a nutshell, it says when there is an asynchronous call that is a sequence (AKA list), Async Iterators are preferred. In practice, this is how that principle is applied in the latest Azure SDK Libraries for Storage, Cosmos, and Event Hubs.

**Storage, using an async iterator to list blobs**:

```js
for await (const blob of containerClient.listBlobsFlat()) {
    console.log(`Blob: ${blob.name}`);
}
```

**Cosmos, still using async iterators to list items**:

```js
for await(const r of resources.container.items.readAll({ maxItemCount: 20 }).getAsyncIterator()) {
    console.log(r.doc.id);
}
```

**Event Hubs, now using an async iterator to process events**:

```js
for await (const e of consumer.getEventIterator()) {
    console.log(e);
}
```

As you can see, a service-agnostic concept - in this case, paging - has been standardized across all three services.

## Feedback

If you have feedback on consistency or think you've found a bug after trying the August 2019 Preview ([.NET], [Java], [JavaScript], [Python]), then file an issue or pull request on GitHub ([.NET](https://github.com/azure/azure-sdk-for-net/), [Java](https://github.com/azure/azure-sdk-for-java), [JavaScript](https://github.com/azure/azure-sdk-for-js), [Python](https://github.com/azure/azure-sdk-for-python)) or reach out to [@AzureSDK](https://twitter.com/AzureSDK) on Twitter.  We welcome contributions to these guidelines and libraries!

[Python]: {{site.baseurl}}{% link releases/2019-08-06/2019-08-06-python-preview2.md %}
[Java]: {{site.baseurl}}{% link releases/2019-08-06/2019-08-06-java-preview2.md %}
[JavaScript]: {{site.baseurl}}{% link releases/2019-08-06/2019-08-06-js-preview2.md %}
[.NET]: {{site.baseurl}}{% link releases/2019-08-06/2019-08-06-dotnet-preview2.md %}
