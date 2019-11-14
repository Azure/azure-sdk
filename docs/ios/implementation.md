---
title: "iOS Guidelines: Implementation"
keywords: guidelines ios
permalink: ios_implementation.html
folder: ios
sidebar: ios_sidebar
---

## Library considerations

iOS developers need to concern themselves with the runtime environment they are running in.  The iOS ecosystem enjoys little fragmentation, but multiple versions and form factors are still prevalent.

{% include requirement/MUST id="ios-library-support" %} support the following versions of iOS:

* All currently available patch builds in the minor release
* The last patch build for the previous minor release
* The last patch build for the previous major release.

For example, as of writing, iOS 13.1.3 has just been released.  We expect support for 12.4.2 (the last patch release in the previous major release), iOS 13.0.0 (the last patch release in the previous minor release), iOS 13.1.0, 13.1.1, 13.1.2, and 13.1.3 (all the patch releases for the current minor release).

{% include requirement/MUST id="ios-swift-support" %} support Swift 5.  This ensures the maximum ABI compatibility going forward.

{% include requirement/MAY id="ios-swift4-support" %} support Swift 4.

{% include requirement/MAY id="ios-objc-support" %} support Objective-C.

{% include requirement/MUST id="ios-platform-support" %} support iPhone and iPad form factors.

{% include requirement/SHOULD id="ios-opt-platform-support" %} support other Apple platforms such as WatchOS and TvOS.

Only support Objective-C and Swift 4 if you have a business justification for doing so.  Optimize for applications written using Swift 5.

{% include requirement/MUST id="ios-library-same-libraries" %} release all clients within a single distributable package.

## Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

### Client configuration

{% include requirement/MUST id="ios-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="ios-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="ios-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="ios-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="general-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

### Service-specific configuration

For iOS applications, configuration is applied using `Info.plist` and directly mirrors the environment variables within a service written in other languages.

{% include requirement/MUST id="ios-config-plist-key-prefix" %} prefix Azure-specific plist keys with `AZURE_`.

{% include requirement/MAY id="ios-config-plist-key-use-client-specific" %} use client library-specific plist keys set in `Info.plist` for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="ios-config-plist-key-get-approval" %} get approval from the [Architecture Board] for every new plist key.  If an environment variable has been approved for the same client library within a different language, a key by the same name is approved for iOS. 

{% include requirement/MUST id="ios-config-plist-key-format" %} use this syntax for `Info.plist` keys specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="ios-config-plist-key-posix-compatible" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

## Parameter validation

The service client will have several methods that perform requests on the service.  _Service parameters_ are directly passed across the wire to an Azure service.  _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="general-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="general-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="general-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

## Network requests

The Azure SDK team has provided an `AzureCore` library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="ios-requests-use-pipeline" %} use the HTTP pipeline component within `AzureCore` for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services.  The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="ios-requests-implement-policies" %} implement the following policies in the HTTP pipeline:

- Telemetry
- Unique Request ID
- Retry
- Authentication
- Response downloader
- Logging

{% include requirement/SHOULD id="ios-requests-use-azurecore-impl" %} use the policy implementations in `AzureCore` whenever possible.  Do not try to "write your own" policy unless it is doing something unique to your service.  If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

## Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage.  Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="ios-authimpl-no-persisting" %} persist, cache, or reuse security credentials.  Security credentials should be considered short lived to cover both security concerns and credential refresh situations.  

If your service implements a non-standard credential system (that is, a credential system that is not supported by `AzureCore`), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="ios-authimpl-provide-auth-policy" %} provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials. 

{% include requirement/SHOULDNOT id="ios-authimpl-no-connection-strings" %} support connection strings with embedded secrets.  iOS apps are not cryptographically secure and may be distributed to millions of devices.  You should assume that any credential you have placed in an iOS app is compromised.

If it shouldn't go in a public GitHub repository, it shouldn't go in an iOS app.

## Native code

iOS supports the development of platform-specific native code in C++.  These can cause compatibility issues across different versions of iOS and platforms.  You should only include such native code in the iOS library if:

* You distribute full source and it is compiled in the context of the customer code.
* You hide the implementation code behind a Swift-based facade.
* You are doing so for performance reasons.  No other reason is acceptable.

## Error handling

> TODO: Error handling (see general guidelines)

> TBD: 
> * Hook in to HockeyApp

## Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="ios-logging-pluggable-logger" %} support pluggable log handlers.  This should be provided by allowing the consumer to specify a `logger` parameter in the client options.  The `logger` parameter points to an instance of the `AzureCoreLogger` protocol.

{% include requirement/MUST id="ios-logging-console-logger" %} make it easy for a consumer to enable logging output to the console. This is done by setting the `logger` client option to a new instance of the `AzureCoreOSLogger`.

{% include requirement/MUST id="ios-logging-levels" %} use one of the following log levels when emitting logs: `Verbose` (details), `Informational` (things happened), `Warning` (might be a problem or not), and `Error`.  This are provided by the enum `AzureCoreLogLevels`.

{% include requirement/MUST id="ios-logging-failure" %} use the `Error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="ios-logging-warning" %} use the `Warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MUST id="ios-logging-info" %} use the `Informational` logging level when a function operates normally.

{% include requirement/MUST id="ios-logging-verbose" %} use the `Verbose` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

The client library can log using the following:

{% highlight swift %}
logger.writeLog(for: "MyClient", withLevel: AzureCoreLogLevels.Verbose, message: "A message")
{% endhighlight %}

{% include requirement/MUSTNOT id="ios-logging-no-sensitive-info" %} send sensitive information in log levels other than `Verbose`. For example, remove account keys when logging headers.  Headers and query parameters must be redacted using the `loggingAllowedHeaders` array and `loggingAllowedQueryParams` array specified within the client options

{% include requirement/MUST id="ios-logging-default-allowedlist" %} set reasonable defaults for the `loggingAllowedHeaders` and `loggingAllowedQueryParams` properties in the client options.

{% include requirement/MUST id="ios-logging-requests" %} log request line, response line, and headers, as `Informational` message.

{% include requirement/MUST id="ios-logging-cancellations" %} log an `Informational` message if a service call is cancelled.

{% include requirement/MUST id="ios-logging-exceptions" %} log exceptions thrown as a `Warning` level message. If the log level set to `Verbose`, append stack trace information to the message.

> TODO: Logging (see general guidelines)
> * Provide abstracted logger in AzureCore
> * Use os_logger unless over-ridden
> * whitelistHeaders & whitelistQueryParams

> TBD:
> * Hook in to HockeyApp

## Distributed tracing

Distributed tracing is not common within the mobile ecosystem, so we don't expect that consumers will implement distributed tracing within a mobile app.  However, the consumer should not be prevented from implementing distributed tracing if they so desire.

> TODO: What would we need to do to enable distributed tracing?

## Dependencies

Dependencies bring in many considerations that are often easily avoided by avoiding the dependency. 

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default. 
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="ios-dependencies-azure-core" %} depend on the iOs `AzureCore` library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="ios-dependencies-approved" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

> TODO: 
> * How can we use a common approved depedencies list.

{% include requirement/MUSTNOT id="ios-dependencies-snapshot" %} include dependencies on external pre-relases (or beta) libraries that are -SNAPSHOT versions. All dependencies must be approved for general use.

{% include requirement/SHOULD id="ios-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="ios-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the `AzureCore` library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

## Service-specific common library code

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="general-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="general-commonlib-minimize-code" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

The common library should use the `Common` suffix.  For example, if Azure Storage has a common library, it would be called `AzureStorageCommon`.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries.  The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library.  This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception.  There is no linkage between the `ObjectNotFound` exception in each client library.  This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already).  Instead, produce two different exceptions - one in each client library.

## Testing

> TODO: Say something about mocking of the requests and how to design for it.

{% include refs.md %}
{% include_relative refs.md %}