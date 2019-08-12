---
title: Previewing Azure SDKs following new Azure SDK API Standards
date: 10 Jul 2019
layout: post
tags: release
sidebar: releases_sidebar
permalink: /releases/2019-07-10/index.html
---

Today we’re happy to share a new set of libraries for working with Azure Storage,  Azure Cosmos DB, Azure Key Vault, and Azure Event Hubs in Java, Python, JavaScript or TypeScript, and .NET. These libraries provide access to new service features, and represent the first step towards applying a [new set of standards](https://azure.github.io/azure-sdk/) across the Azure SDKs that we believe will make the libraries easier to learn and integrate into your software. You can get these libraries today from your favorite package manager, and we would love to hear your feedback on [GitHub](https://github.com/azure/azure-sdk/issues/). To get started follow the instructions linked below:

* [Python Release Notes](python.html)
* [Java Release Notes](java.html)
* [JavaScript Release Notes](js.html)
* [.NET Release Notes](dotnet.html)

## Why are we doing this?

Much like moving software from the client or on-premises to the cloud is a paradigm shift, we too have been going through a period of rapid innovation in Azure’s capabilities and learning about how best to expose it to developers. Now that some Azure services have matured and been adopted into business-critical enterprise applications, we have been learning what patterns and practices were critical to developer productivity around these services. In addition, we’ve been listening to your feedback and we’ve made sure that our new effort has incorporated your suggestions and requests. Finally, we understand that consistency, ease of use, and discoverability are equally important to the identified patterns when it comes to working with the Azure SDKs.

## What's different?

The team will go into much of what I am about to outline in follow-up blog posts but to get started, the big changes came from a set of objectives we defined based on your feedback. Those were:

* Create easy to use APIs with productivity on par with the best libraries of the language ecosystems.
* Provide APIs that are idiomatic to the language and ecosystem they are used in.
* Evolve over time in a very compatible fashion.
* Focus as much on documentation and samples, as on APIs.
* Change how we create the libraries at their core.

## Ease of use and productivity

Productivity is a multifaceted topic on its own, but two main elements of it are consistency and usability.

To help reach consistency, we codified the things we learned while working with Azure developers into a set of API design guidelines. The guidelines themselves are built in the open on [our GitHub repository](https://azure.github.io/azure-sdk/) and consist of a section of principles that goes into more detail on how we approached this space, a set of general guidelines, and language specific guidelines for Java, Python, .NET, and JavaScript. By applying the guidelines we believe that these libraries will be easier to use and easier to learn. When you learn a pattern or API shape in one library you should be able to count on it being the same in others.

To help drive usability, we tweaked how we gather user feedback. We continue to do many of the standard practices in the industry such as releasing previews, working directly with developers on their projects, and responding to issues in many different community forums but the next step for us was to usability test the libraries. For each of the libraries we are releasing today, we have brought developers into a lab and had them work through different use cases while we observed them. That feedback was instrumental to shape both the guidelines as well as the API shape of the libraries.

## Idiomatic libraries

A key piece of feedback we heard while talking with developers was that our APIs didn’t always feel ergonomic in a language. To fix that, we explicitly established as one of our core principles that the libraries we author should follow the patterns of that language. In addition, as we update each service’s libraries to follow guidelines, we are ensuring that we always release libraries for those services in each of the following languages: Java, Python, JavaScript, and .NET.

## Compatibility

Compatibility has always been a value at Microsoft. Developers put significant time and money into solutions and should be able to count on them continuing to work. There is a tension here. For some cases we have had to make breaking changes to get to a better foundation. We believe aligning on that foundation will help meet the productivity goals outlined above, and once it’s set we intend to provide a high degree of compatibility. As a final note on compatibility, we’ve looked at the dependencies that we took and tried to minimize them as much as possible to reduce future incompatibilities and versioning complexities which should make upgrading libraries and using other pieces of software alongside these libraries easier.

## Documentation

Having good documentation and samples could be considered an aspect of productivity but we wanted to call it out as its own goal because many developers rate it as the top factor in choosing what technologies to use. Much like the usability studies we’re doing on the APIs themselves, we have been doing the same on Azure Quickstarts to ensure that new developers can begin to experiment with Azure Services quickly. We have also heard feedback that both API Reference code snippets and samples get out-of-date and we have been building the tooling to build API Reference code snippets and samples regularly from GitHub and publish those into documentation.

## Change how we build

We also found we needed to change how we work with and engage the community and what we build on top of. To that end, we’ve begun work to restructure and centralize our development effort into a few key repositories:

* [Azure-sdk](https://github.com/azure/azure-sdk): As a central location to start from and a place for high level topics like the design guidelines.
* Repositories for each language: 
    * [azure-sdk-for-python](https://github.com/azure/azure-sdk-for-python)
    * [azure-sdk-for-java](https://github.com/azure/azure-sdk-for-java)
    * [azure-sdk-for-js](https://github.com/azure/azure-sdk-for-js)
    * [azure-sdk-for-net](https://github.com/azure/azure-sdk-for-net)

Finally, we built a new core library that is helping us provide common features like identity and authentication, both synchronous and asynchronous APIs, logging, error handling, networking retries and more across all libraries.

## What should I do?

We are very pleased to be sharing the preview release of the new Azure libraries that conform to many of the principles outlined above. We would like to encourage you to download and try the new SDKs today. To help you along the way, we are providing release notes describing what’s new in each library, how to get the packages, and how to file GitHub issues specific to the previews.

* [Python Release Notes](python.html)
* [Java Release Notes](java.html)
* [JavaScript Release Notes](js.html)
* [.NET Release Notes](dotnet.html)

In addition to filing GitHub issues, feel free to also follow and tweet us [@AzureSDK](https://twitter.com/AzureSDK). We look forward to receiving your feedback so we can improve the libraries, and make it easier for you to create great software and solve problems with Azure.
