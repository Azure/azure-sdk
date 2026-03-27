---
title: "iOS Guidelines: Implementation"
keywords: guidelines ios
permalink: ios_implementation.html
folder: ios
sidebar: general_sidebar
---

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools.

{% include requirement/MUSTNOT id="ios-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. Implementation code can be made internal or file-private and placed within the same source file as the consuming code.

### Service Client

Service clients are the main starting points for developers calling Azure services with the Azure SDK. Each client library should have at least one client, so it’s easy to discover. The guidelines in this section describe patterns for the design of a service client. Because for iOS only asynchronous service clients are required, the sections below are organized into general service client guidance.

#### Service Methods

Service methods are the methods on the client that invoke operations on the service.

##### Using the HTTP Pipeline

The Azure SDK team has provided an `AzureCore` library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="ios-requests-use-pipeline" %} use the HTTP pipeline component within `AzureCore` for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services.  The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="ios-requests-implement-policies" %} include the following policies provided by `AzureCore` when constructing the HTTP pipeline:

- Telemetry
- Unique Request ID
- Retry
- Authentication
- Response downloader
- Logging

{% include requirement/SHOULD id="ios-requests-use-azurecore-impl" %} use the policy implementations in `AzureCore` whenever possible.  Do not try to "write your own" policy unless it is doing something unique to your service.  If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

### Supporting Types

#### Model Types

##### Attributes

The following guidance applies to Swift [attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) :

{% include requirement/SHOULD id="ios-attr-objc" %} use the `@objc` and `@objMembers` attributes ONLY when a Swift object must be exposed to ObjectiveC.

{% include requirement/MUST id="ios-attr-available-for-os-versions" %} use the `@available` attribute when implementation is contingent upon differences in supported OS or Swift versions.

{% include requirement/MUST id="ios-attr-available-for-breaking-changes" %} use the `@available` attribute to manage breaking changes and transition customers away from deprecated APIs. For example:
```swift
// usable but will issue a warning
@available(*, deprecated, message: "Optional message here...")
func myFunction() { ... }

// unusable -- will issue a compiler error
@available(*, unavailable, message: "Optional message here...")
func myUnavailableFunc() { ... }

// usable but will issue a warning
@available(*, deprecated, renamed: "BetterProtocolName")
typealias BadProtocolName = BetterProtocolName
```
{% include requirement/MUST id="ios-attr-escaping" %} use `@escaping` on completion handler closures.

{% include requirement/MUST id="ios-attr-unspecified" %} contact the Azure SDK team if you are using an attribute not specified here.

## SDK Feature Implementation

### Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

#### Client configuration

{% include requirement/MUST id="ios-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="ios-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="ios-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="ios-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="general-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Telemetry on/off, which must take effect immediately across the Azure SDK.

> TODO: Update these guidelines to specify exactly how to do these things in Swift

#### Service-specific configuration

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

### Logging

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
> * allowHeaders & allowQueryParams

> TBD:
> * Hook in to HockeyApp

### Distributed tracing

Distributed tracing is uncommon in a mobile context. If you feel like you need to support distributed tracing, contact the [Azure SDK mobile team](mailto:azuresdkmobileteam@microsoft.com) for advice.

### Testing

{% include requirement/MUST id="ios-testing-unit-xctest" %} use the built-in `XCTest` framework for unit testing.
{% include requirement/MUST id="ios-testing-e2e-azuretest" %} use the AzureTest static framework for end-to-end testing.
{% include requirement/SHOULDNOT id="ios-testing-nomocks" %} mock service calls for end-to-end tests due to the inherent complexity. Instead, AzureTest should be used for most end-to-end scenario tests.
{% include requirement/MAY id="ios-testing-ohhttpstubs" %} use `OHHTTPStubs` to perform mocking for abnormal network conditions such as dropped connectivity.

{% include refs.md %}
{% include_relative refs.md %}
