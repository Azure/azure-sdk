---
title: Pluggable HTTP Modules with the Azure SDK for Java
layout: post
date: 03 Mar 2020
sidebar: releases_sidebar
repository: azure/azure-sdk
---

When we re-imagined the Azure SDK, we came up with [some key principles](https://aka.ms/azsdkguide) that we would use when writing the SDK:

* **Idiomatic** - they should feel like they were meant for the language.
* **Consistent** - similar concepts should be exposed in similar ways.
* **Approachable** - getting started should be easy.
* **Diagnosable** - developers should understand how to debug their app.
* **Dependable** - avoid breaking changes.

There are more details behind these simple principles, but these are our guides when designing the client libraries.  When we designed the initial HTTP pipeline for the Azure SDK for Java, we made specific choices that are well known for service developers who use the Spring Framework. [Project Reactor](https://projectreactor.io/) provides the asynchronous reactive library that allows us to build non-blocking applications, and [Netty](https://netty.io/) provides the HTTP transport layer.  These are the same choices used by the Spring Framework.  If you are developing Spring applications, then these will be familiar choices.

What if you aren't using the Spring Framework?  One of the hallmarks of Java development is the rich ecosystem of libraries that are available to you.  You might be using one of the other HTTP transport providers like [OkHttp](https://square.github.io/okhttp/), for instance.  The Azure SDK for Java supports these cases (as do our other languages) with a pluggable HTTP provider.

## Selecting OkHttp as the HTTP transport

Every HTTP-based Azure service library depends on the Azure Core library to provide the HTTP transport.  This is done through a service provider interface (SPI) called `HttpClientProvider`.  We don't build an implementation into Azure Core.  Instead, the implementation is provided by a dependency.  In the default case, that is `azure-core-http-netty`.

The Azure team provides an alternate implementation based on OkHttp.  To use it, simply exclude the default version and include the OkHttp version.  For example, let's say you want to use the Key Vault
Secrets library, you would provide the following in your `pom.xml` file:

```xml
<dependency>
    <groupId>com.azure</groupId>
    <artifactId>azure-security-keyvault-secrets</artifactId>
    <version>4.1.0</version>
    <exclusions>
      <exclusion>
        <groupId>com.azure</groupId>
        <artifactId>azure-core-http-netty</artifactId>
      </exclusion>
    </exclusions>
</dependency>
<dependency>
  <groupId>com.azure</groupId>
  <artifactId>azure-core-http-okhttp</artifactId>
  <version>1.1.0</version>
</dependency>
```

If the default dependency is removed (via the exclusion), but no implementation is given in its place, the application will fail to start.

## Configuring the HTTP transport

All services rely on this transport layer, which makes it a great option to set global settings that your organization needs.  For example, let's say you have a HTTP proxy in your enterprise.  You can create your own HTTP transport:

```java
InetSocketAddress proxyService = new InetSocketAddress(proxyHost, proxyPort);
ProxyOptions proxyOptions = new ProxyOptions(ProxyOptions.Type.HTTP, proxyService)
    .setCredentials(proxyUser, proxyPassword);
HttpClient httpClient = new OkHttpAsyncHttpClientBuilder()
    .proxy(proxyOptions)
    .build();
```

You can also use `NettyAsyncHttpClientBuilder` for this same functionality.  You can now pass the resulting `HttpClient` object into any service builder:

```java
SecretClient client = new SecretClientBuilder()
        .vaultUrl(keyVaultUrl)
        .credential(new DefaultAzureCredentialBuilder().build())
        .httpClient(httpClient)
        .buildClient();
```

If OkHttp and Netty doesn't fit your requirements, you can also [write your own HTTP client plugin](https://github.com/Azure/azure-sdk-for-java/wiki/Custom-HTTP-clients).  Let us know if you do this. We'd love to hear why and how the process went.

## Want to hear more?

Follow us on [Twitter](https://twitter.com/AzureSDK).  We'll be covering more best practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDK. 

_Contributors to this blog post: Alan Zimmer_.
