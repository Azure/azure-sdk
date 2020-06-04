---
title: Azure SDK Releases (June 2020)
layout: post
date: 2020-06-16
sidebar: releases_sidebar
repository: azure/azure-sdk
author_github: JeffreyRichter
---

Welcome to the June release of the Azure SDK.  We have updated the following libraries:

* Cosmos (Java)
* Event Hubs
* Azure Storage (Java, Python)
* Text Analytics

These are ready to use in your production applications.  You can find details of all released libraries on [our releases page]({{site.baseurl}}{% link releases/latest/index.md %}).

New preview releases:

* Azure.Identity
* Azure Search
* Form Recognizer
* Service Bus

In addition, we've released a new preview of the Azure SDK for Embedded C.  See below for details.

We believe these are ready for you to use and experiment with, but not yet ready for production.  Between now and the GA release, these libraries may undergo API changes.  We'd love your feedback!  If you use these libraries and like what you see, or you want to see changes, let us know in GitHub issues.

## Getting Started

Use the links below to get started with your language of choice.  You will notice that all the preview libraries are tagged with "preview".

* [.NET release notes]({{site.baseurl}}{% link releases/2020-06/dotnet.md %})
* [Java release notes]({{site.baseurl}}{% link releases/2020-06/java.md %})
* [Python release notes]({{site.baseurl}}{% link releases/2020-06/python.md %})
* [JavaScript release notes]({{site.baseurl}}{% link releases/2020-06/js.md %})

If you want to dive deep into the content, the release notes linked above and the change logs they point to give more details on what has changed.

## Introducing the Azure SDK for Embedded Devices

The [Azure Embedded C SDK](https://github.com/Azure/azure-sdk-for-c) is designed to allow small embedded (IoT) devices to communicate with Azure services.  Since we expect the client library code to run on microcontrollers that have slower CPUs and very limited amounts of flash, the Embedded C SDK is architected very differently than the Azure SDKs we offer in other languages.

To properly address the needs of the embedded developer:

* The SDK is distributed as source code and compiled alongside your code.
* We target the [C99 standard](http://www.open-std.org/jtc1/sc22/wg14/) and test with gcc, clang, and the Microsoft Visual C compilers.
* We offer very few abstractions, making the code easy to understand and debug.
* The SDK is non-allocating.  Customers must allocate all data structures where they desire (for example, choosing between global memory, stack, heap, and so on) and then pass the address of the allocated structure into the functions that perform the various operations.  This ensures out of memory errors are handled in user code.
* Unlike other languages, many common tasks (such as composing an [HTTP pipeline of communication policies](https://channel9.msdn.com/Shows/On-NET/Understanding-the-AzureCore-library)) are done in source code as opposed to runtime.  This reduces code size, improves execution speed, and locks in behavior, reducing the chance of bugs at runtime.
* We support microcontrollers with no operating system, microcontrollers with a real-time operating system (like [Azure RTOS](https://azure.microsoft.com/en-us/services/rtos/)), Linux, and Windows.  You can implement your own "platform layer" to use the SDK on devices that are not supported "out-of-the-box".  The platform layer requires minimal functionality (such as a clock, sleep, atomic compare exchange, and an HTTP stack adapter).  We provide some platform layers, and more will be added over time.

### SDK architecture

At the heart of the SDK is what we refer to as _Azure Core_.  This code defines several data types and functions for use by the client libraries such as the Azure IoT client libraries and the Azure Blob Storage client library.  Some of the features you will use directly:

* A **Span** represents a byte buffer and is used for string manipulation, HTTP requests and responses, and for building and parsing JSON payloads.  It allows us to return a substring within a larger string without any memory allocations.
* As the SDK performs operations, it can send log messages to an application-defined callback through the **Logging** feature.  You can enable this to assist with debugging.
* **Context**s offer an I/O cancellation mechanism.  Multiple contexts can be composed together in your application call tree.  When a context is cancelled, its children are also cancelled.
* We provide a non-allocating **JSON builder** and **JSON parser**.
* We provide non-allocating **HTTP request and response** handlers.
* The SDK validates function arguments and invokes a callback when validation fails.  By default, this callback suspends the calling thread _forever_.  However, you can ovrride this behaviour.  Further, you can disable argument validation in production builds to obtain smaller and faster code.

By utilizing Azure Core, Azure client libraries will share a common implementation and many features will behave identically across the suite of clinet libraries.  For example, the standard HTTP pipeline unifies the handling of authentication, logging, retry, and telemetry.


### Example: Uploading a blob to Azure Storage

The code below demonstrates how to upload ASCII text to an Azure Storage blob using the Azure Embedded C SDK.  The sample also shows how to enable logging.  

```clang
#include <az_context.h>
#include <az_storage_blobs.h>
#include <curl/curl.h> // libcurl is our HTTP stack
#include <stdio.h>
#include <stdlib.h>

static void log_func(az_log_classification classification, az_span message)
{
  (void)classification;
  printf("%.*s\n", az_span_size(message), az_span_ptr(message));
}

int main()
{
  // Initialize libcurl
  if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
  {
    printf("Couldn't init libcurl\n");
    return 1;
  }
  // Set up libcurl cleaning callback as to be called before ending program
  atexit(curl_global_cleanup);

  // Enable SDK logging:
  az_log_classification const classifications[] = { AZ_LOG_HTTP_RESPONSE, AZ_LOG_END_OF_LIST };
  az_log_set_classifications(classifications);
  az_log_set_callback(log_func);

  // Allocate & initialize client using Blob URL (with SAS) from environment variable
  az_storage_blobs_blob_client client;
  if (az_storage_blobs_blob_client_init(
          &client, az_span_from_str(getenv("AZURE_STORAGE_URL")), AZ_CREDENTIAL_ANONYMOUS, NULL)
      != AZ_OK)
  {
    printf("Failed to initialize blob client\n");
    return 1;
  }

  // Allocate a buffer to hold HTTP responses; reused by each HTTP request
  uint8_t response_buffer[1024 * 4] = { 0 };

  // Allocate & initialize an HTTP response structure pasing it the HTTP response buffer
  az_http_response http_response;
  if (az_http_response_init(&http_response, AZ_SPAN_FROM_BUFFER(response_buffer)) != AZ_OK)
  {
    printf("Failed to init http response\n");
    return 1;
  }

  // Upload bytes to the blob
  az_result blob_upload_result = az_storage_blobs_blob_upload(
      &client, &az_context_app, AZ_SPAN_FROM_STR("Some content"), NULL, &http_response);
  if (az_failed(blob_upload_result))
  {
    printf("Failed to upload blob\n");
    return 1;
  }

  // Show HTTP response information
  az_http_response_status_line status_line;
  if (az_failed(az_http_response_get_status_line(&http_response, &status_line)))
  {
    printf("Failed to get status line\n");
    return 1;
  }

  printf("HTTP Status Code: %d\n", status_line.status_code);
  return 0;
}
```

While this example demonstrates how to use `libcurl` as an HTTP stack, you can modify the code to use a different HTTP stack.  See the [GitHub repository](https://github.com/Azure/azure-sdk-for-c) for more information.

### More information

For more information on using the Azure Embedded C SDK for IoT, check out the introductory video: [Introduction to the new Embedded C SDK for Azure IoT](https://channel9.msdn.com/Shows/Internet-of-Things-Show/Introduction-to-the-new-Embedded-C-SDK-for-Azure-IoT).

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback ranging from documentation issues to API surface area change requests to pointing out failure cases.  Please keep that coming.  We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk/)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@AzureSDK](https://twitter.com/AzureSDK) on Twitter.
