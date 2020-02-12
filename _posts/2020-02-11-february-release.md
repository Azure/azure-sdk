---
title: Azure SDK Releases (February 2020)
layout: post
date: 11 Feb 2020
sidebar: releases_sidebar
repository: azure/azure-sdk
---

Welcome to the February release of the Azure SDK.  We have updated the following libraries:

* Storage (Blobs, Files, and Queues).
* Event Hubs (Java and JavaScript).
* Key Vault (Python only).

These are ready to use in your production applications.  You can find details of all released libraries on [our releases page](https://azure.github.io/azure-sdk/releases/latest/).

New preview releases:

* Cosmos (Java only).
* Key Vault Keys (Java only).
* Storage Blob Cryptography.
* Storage Data Lake Files.
* Text Analytics.

We believe these are ready for your use, but not yet ready for production.  Between now and the GA release, these libraries may undergo API changes.  We'd love your feedback!  If you use these libraries and like what you see, or you want to see changes, let us know in the GitHub issues for the appropriate language. 

## Getting Started

Use the links below to get started with your language of choice.  You will notice that all the preview libraries are tagged with "preview".

* [.NET release notes]({{site.baseurl}}/releases/2020-01/dotnet.html)
* [Java release notes]({{site.baseurl}}/releases/2020-01/java.html)
* [Python release notes]({{site.baseurl}}/releases/2020-01/python.html)
* [JavaScript release notes]({{site.baseurl}}/releases/2020-01/js.html)

If you want to dive deep into the content, the release notes linked above and the change logs they point to give more details on what has changed.

## Logging 

One of the main advantages of the new Azure SDK is that common developer concerns are treated the same, irrespective of which client library you are using.  In this issue, we will tackle logging and show you how to enable logging on each platform.  

## .NET libraries

All .NET client libraries emit events to ETW (Event Tracing for Windows) via the `EventSource` class.  This system has been a part of the .NET framework for a long time.  Event sources allow you to use structured logging in your application code with a minimal performance overhead.

Although you can use out-of-process tools (such as [PerfView](https://github.com/Microsoft/perfview) or [dotnet trace](https://docs.microsoft.com/en-us/dotnet/core/diagnostics/dotnet-trace)), a [core tenet of our libraries](https://azure.github.io/azure-sdk/general_implementation.html#general-logging-console-logger) includes the ability to easily send logs to the console.  When developing your app, you should be able to view the logs in real time without much overhead.  You can accomplish this with a one-liner at the top of your application:

```csharp
using AzureEventSourceListener listener = AzureEventSourceListener.CreateConsoleLogger();
```

## Java libraries

The Java client libraries all use [SLF4J](https://www.slf4j.org/) under the covers for logging.  There are many mechanisms for [configuring SLF4J](https://dzone.com/articles/how-configure-slf4j-different) to get just the right logging for you application.  However, we are looking at the simplest mechanism today.  There is a built-in logger for temporary debugging purposes.  As long as you have not already included the SLF4J library, just set the `AZURE_LOG_LEVEL` environment variable to "verbose".  For example, in bash:

```bash
export AZURE_LOG_LEVEL="verbose"
```

Or, in PowerShell:

```bash
$env:AZURE_LOG_LEVEL="verbose"
```

Then run your application as normal.  The logs will be emitted on the console.  For more information on the Java logging system, refer to [our wiki](https://github.com/Azure/azure-sdk-for-java/wiki/Logging-with-Azure-SDK).

## JavaScript and TypeScript libraries

There are two easy ways to enable logging for your Node applications.  You can set the `AZURE_LOG_LEVEL` to "verbose".  In this case, the logs will be output to stderr (for Node applications) or the console (for browser applications).  For example, in bash:

```bash
export AZURE_LOG_LEVEL="verbose"
```

Or, in PowerShell:

```bash
$env:AZURE_LOG_LEVEL="verbose"
```

If you want to do the same thing in code, you can use the `@azure/logger` module:

```javascript
import { setLogLevel } from "@azure/logger";

setLogLevel("verbose");
```

This allows you to be more dynamic in your logging.  For example, you might want to enable logging on a single client library, or replace the logger with your own implementation.  For more information, check out the [logger library](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/core/logger).

## Python libraries

Python uses the [standard logging module](https://docs.python.org/3/howto/logging.html).  This makes it relly easy to configure just like you would any other Python library:

```python
import logging
logging.basicConfig()

# Enable DEBUG logging for all azure libraries
azure_root_logger = logging.getLogger('azure')
azure_root_logger.setLevel(logging.DEBUG)
```

You can see more configuration examples in the [logging cookbook](https://docs.python.org/3/howto/logging-cookbook.html).

As you can see, the same logging features are provided in each language, but how each language accomplishes them is idiomatic to the language.  How you work with these features should feel very natural in your language of choice.

If it doesn't, let us know!

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback ranging from documentation issues to API surface area change requests to pointing out failure cases.  Please keep that coming.  We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk/)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@azuresdk](https://twitter.com/AzureSDK) on Twitter.
