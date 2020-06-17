---
title: Previewing Azure Management SDKs that follow new Azure API Standards
layout: post
date: 2020-06-30
sidebar: releases_sidebar
author_github: nickzhums
repository: azure/azure-sdk
---
We’re excited to announce that a new set of Azure management libraries for Java, .NET and Python are now in Public Preview. These libraries follow the [new Azure SDK guidelines](https://aka.ms/azure-sdk-site) and share a number of core features such as authentication protocols, HTTP retries, logging, transport protocols, etc., which we believe will make libraries easier to learn and integrate into your management scenarios. You can get these libraries today from your favorite package manager, and we would love to hear your feedback on Github. 

The services we support for these new management libraries are: 
| Java             | .NET                                  | Python                                        |
| ---------------- | ------------------------------------- | --------------------------------------------- |
| <ul><li>Compute</li><li>Network</li><li>Storage</li><li>Resource Management</li><li>Managed Identity</li><li>Authorization</li><li>Insight</li><li>AppService</li><li>SQL</li><li>CosmosDB</li><li>Key Vault</li> | <ul><li>Compute</li><li>Network</li><li>Storage</li><li>Resource Management</li><li>App Configuration</li><li>Event Hubs</li><li>Key Vault</li></ul> | <ul><li>Compute</li><li>Network</li><li>Storage</li><li>Resource Management</li><li>Insight</li><li>App Configuration</li><li>Event Hubs</li><li>Key Vault</li></ul> |

To get started follow the links linked below: 

[Java Release Notes](https://azure.github.io/azure-sdk/releases/2020-06/java.html) 

[.NET Release Notes](https://azure.github.io/azure-sdk/releases/2020-06/dotnet.html) 

[Python Release Notes](https://azure.github.io/azure-sdk/releases/2020-06/python.html)

### Why are we doing this? 

The goal of our management libraries is to enhance the productivity of developers managing Azure resources and provide idiomatic, consistent, approachable, diagnosable, and dependable code to easily integrate with Azure resources. We’ve been listening to your feedback and we’ve made sure that our new effort has incorporated your suggestions and requests. Finally, we understand that ease of use, service coverage, documentation and consistency are equally important when it comes to resource management with Azure SDKs.  

### What's Different?

The team will go into details in follow-up blog posts but to get started, the big changes came from a set of objectives we defined based on your feedback. Those were: 

- Create easy to use APIs with productivity on par with the best libraries of the language ecosystems. 
- Provide APIs that are idiomatic to the language and ecosystem they are used in. 
- Evolve over time in a very compatible fashion. 
- Focus as much on documentation and samples, as on APIs. 
- Change how we create the libraries at their core. 

### Idiomatic libraries 

A key piece of feedback we heard while talking with developers was that our APIs didn’t always feel ergonomic in a language. To fix that, we explicitly established as one of our core principles that the libraries we author should follow the patterns of that language. For these preview libraries, we’ve made sure that they follow the guidelines for each language so that developers feel natural when they use the libraries 

### Service Coverage 

Coverage of Azure services is an important aspect in management libraries. We understand that developers usually use management SDKs to provision a variety of Azure services as the services sometimes have connections with each other. For this preview release, we’ve selected the most common and core services in Azure based on the feedback we heard. We will also fasten the pace of covering more services while we continue to improve the quality of our preview libraries 

### Compatibility

Compatibility has always been a value at Microsoft. Developers put significant time and money into solutions and should be able to count on them continuing to work. There is a tension here. For some cases we have had to make breaking changes to get to a better foundation. We believe aligning on that foundation will help meet the productivity goals outlined above, and once it’s set we intend to provide a high degree of compatibility. As a final note on compatibility, we’ve looked at the dependencies that we took and tried to minimize them as much as possible to reduce future incompatibilities and versioning complexities which should make upgrading libraries and using other pieces of software alongside these libraries easier. 

### Documentation

Having good documentation and samples could be considered an aspect of productivity but we wanted to call it out as its own goal because many developers rate it as the top factor in choosing what technologies to use. Much like the usability studies we’re doing on the APIs themselves, we have been doing the same on Azure Quickstarts to ensure that new developers can begin to experiment with Azure Services quickly. We have also heard feedback that both API Reference code snippets and samples get out-of-date and we have been building the tooling to build API Reference code snippets and samples regularly from GitHub and publish those into documentation. 

We have provided these quick-start guides for the new preview libraries.

- [Quickstart for Java](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/management)
- [Quickstart for .NET](https://github.com/Azure/azure-sdk-for-net/blob/master/doc/mgmt_preview_quickstart.md)
- [Quickstart for Python](https://github.com/Azure/azure-sdk-for-python/blob/master/doc/sphinx/mgmt_preview_quickstart.rst)


### What should I do? 

We are pleased to be sharing the preview release of the new Azure management libraries that conform to many of the principles outlined above. We would like to encourage you to download and try the new SDKs today. To help you along the way, we are providing release notes describing what’s new in each library, how to get the packages, and how to file Github issues specific to the preview releases.  

[Java Github Repo](https://github.com/Azure/azure-sdk-for-java) 

[.NET Github Repo](https://github.com/Azure/azure-sdk-for-net) 

[Python Github Repo](https://github.com/Azure/azure-sdk-for-python)

Please use the "Preview" tag when filing an issue.

In addition to filing GitHub issues, feel free to also follow and tweet us @AzureSDK. We look forward to receiving your feedback so we can improve the libraries, and make it easier for you to create great software and solve problems with Azure. 
