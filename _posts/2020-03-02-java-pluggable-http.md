---
title: Pluggable HTTP Modules in the Azure SDK for Java
layout: post
date: 02 Mar 2020
sidebar: releases_sidebar
repository: azure/azure-sdk
---

When we re-imagined the Azure SDK, we came up with [some key principles](https://azure.github.io/azure-sdk/general_introduction.html) that we would use when writing the SDK:

* **Idiomatic** - they should feel like they were meant for the language.
* **Consistent** - each service should be configured the same way.
* **Approachable** - getting off the ground should be easy.
* **Diagnosable** - developers should understand what is going on.
* **Dependable** - avoid breaking changes.

There are more details behind these simple principles, but these are our guides when designing the client libraries.  When we designed the initial HTTP pipeline for the Azure SDK for Java, we made specific choices that are well known for service developers who use the Spring Framework - [Project Reactor](https://projectreactor.io/) provides the asynchronous reactive library that allows us to build non-blocking applications, and [Netty](https://netty.io/) provides the HTTP transport layer.  These are the same choices used by the Spring Framework.  If you are developing Spring applications, then these will be familiar choices.

What if you aren't using the Spring Framework?  One of the hallmarks of Java development is the rich ecosystem of libraries that are available to you.  You might be using one of the other HTTP transport providers like [OkHttp](https://square.github.io/okhttp/), for instance.  The Azure SDK for Java supports these cases (as do our other languages) with a pluggable HTTP provider.

## Selecting OkHttp as the HTTP transport

> TODO: Write the blog post!

## Want to hear more?

Follow us on [Twitter](https://twitter.com/AzureSDK).  We'll be covering more best practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDK. 