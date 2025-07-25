---
title: "General Guidelines: Implementation"
keywords: guidelines
permalink: general_implementation.html
folder: general
sidebar: general_sidebar
---

Once you have worked through an acceptable API surface, you can start implementing the service clients.

## Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

### Client configuration

{% include requirement/MUST id="general-config-global-config" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="general-config-for-different-clients" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="general-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="general-config-global-overrides" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="general-config-behaviour-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

### Service-specific environment variables

{% include requirement/MUST id="general-config-envvars-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MAY id="general-config-envvars-use-client-specific" %} use client library-specific environment variables for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="general-config-envvars-get-approval" %} get approval from the [Architecture Board] for every new environment variable.

{% include requirement/MUST id="general-config-envvars-format" %} use this syntax for environment variables specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="general-config-envvars-posix-compatible" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

## Parameter validation

The service client will have methods that send requests to the service. These methods take two kinds of parameters: _service parameters_ and _client parameters_. _Service parameters_ are sent across the wire to the service as URL segments, query parameters, request header values, and request bodies (typically JSON or XML).  _Client parameters_ are used solely within the client library and are not sent to the service; examples are path parameters, CancellationTokens or file paths.  If, for example, a path parameter is not validated, it could result in sending a request to a malformed URI, which could prevent the service from having the opportunity to do validation on it.

{% include requirement/MUST id="general-params-client-validation" %} validate client parameters.  This includes checks for null values for required path parameters, and checks for empty string values if a required path parameter declares a `minLength` greater than zero.

{% include requirement/MUSTNOT id="general-params-server-validation" %} validate service parameters.  This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUSTNOT id="general-params-server-defaults" %} encode default values for service parameters.  Service parameter default values can change between api-versions.  Required parameters should require a value to be passed to the client interface, and optional parameters should be elided if not specified so that the service will use default values for the requested api-version.

{% include requirement/MUST id="general-params-check-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service.  If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

## Network requests

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="general-requests-use-pipeline" %} use the HTTP pipeline component within Azure Core for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services.  The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="general-requests-implement-policies" %} implement the following policies in the HTTP pipeline:

* Telemetry
* Unique Request ID
* Retry
* Authentication
* Response downloader
* Distributed tracing
* Logging

{% include requirement/SHOULD id="general-requests-use-azurecore-impl" %} use the policy implementations in Azure Core whenever possible.  Do not try to "write your own" policy unless it is doing something unique to your service.  If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

## Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage.  Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected.  Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="general-authimpl-no-persisting" %} persist, cache, or reuse security credentials.  Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (that is, a credential system that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="general-authimpl-provide-auth-policy" %} provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.  This includes custom connection strings, if supported.

## Native code

Some languages support the development of platform-specific native code plugins.  These cause compatibility issues and require additional scrutiny.  Certain languages compile to a machine-native format (for example, C or C++), whereas most modern languages opt to compile to an intermediary format to aid in cross-platform support.

{% include requirement/SHOULD id="general-no-nativecode" %} write platform-specific / native code unless the language compiles to a machine-native format.

## Error handling

Error handling is an important aspect of implementing a client library.  It is the primary method by which problems are communicated to the consumer.  There are two methods by which errors are reported to the consumer.  Either the method throws an exception, or the method returns an error code (or value) as its return value, which the consumer must then check.  In this section we refer to "producing an error" to mean returning an error value or throwing an exception, and "an error" to be the error value or exception object.

{% include requirement/SHOULD id="general-errors-prefer-exceptions" %} prefer the use of exceptions over returning an error value when producing an error.

{% include requirement/MUST id="general-errors-for-failed-requests" %} produce an error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code. These errors should also be logged as errors.

{% include requirement/MUST id="general-errors-include-request-response" %} ensure that the error produced contains the HTTP response (including status code and headers) and originating request (including URL, query parameters, and headers).

In the case of a higher-level method that produces multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="general-errors-rich-info" %} ensure that if the service returns rich error information (via the response headers or body), the rich information must be available via the error produced in service-specific properties/fields.

{% include requirement/SHOULDNOT id="general-errors-no-new-types" %} create a new error type unless the developer can perform an alternate action to remediate the error.  Specialized error types should be based on existing error types present in the Azure Core package.

{% include requirement/MUSTNOT id="general-errors-use-system-types" %} create a new error type when a language-specific error type will suffice.  Use system-provided error types for validation.

{% include requirement/MUST id="general-errors-documentation" %} document the errors that are produced by each method (with the exception of commonly thrown errors that are generally not documented in the target language).

## Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

In general, our advice to consumers of these libraries is to establish logging in their preferred manner at the `WARNING` level or above in production to capture problems with the application, and this level should be enough for customer support situations.  Informational or verbose logging can be enabled on a case-by-case basis to assist with issue resolution.

{% include requirement/MUST id="general-logging-pluggable-logger" %} support pluggable log handlers.

{% include requirement/MUST id="general-logging-console-logger" %} make it easy for a consumer to enable logging output to the console. The specific steps required to enable logging to the console must be documented.

{% include requirement/MUST id="general-logging-levels" %} use one of the following log levels when emitting logs: `Verbose` (details), `Informational` (things happened), `Warning` (might be a problem or not), and `Error`.

{% include requirement/MUST id="general-logging-failure" %} use the `Error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="general-logging-warning" %} use the `Warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MAY id="general-logging-slowlinks" %} log the request and response (see below) at the `Warning` when a request/response cycle (to the start of the response body) exceeds a service-defined threshold.  The threshold should be chosen to minimize false-positives and identify service issues.

{% include requirement/MUST id="general-logging-info" %} use the `Informational` logging level when a function operates normally.

{% include requirement/MUST id="general-logging-verbose" %} use the `Verbose` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUST id="general-logging-no-sensitive-info" %} only log headers and query parameters that are in a service-provided "allow-list" of approved headers and query parameters.  All other headers and query parameters must have their values redacted.

{% include requirement/MUST id="general-logging-requests" %} log request line and headers as an `Informational` message. The log should include the following information:

* The HTTP method.
* The URL.
* The query parameters (redacted if not in the allow-list).
* The request headers (redacted if not in the allow-list).
* An SDK provided request ID for correlation purposes.
* The number of times this request has been attempted.

{% include requirement/MUST id="general-logging-responses" %} log response line and headers as an `Informational` message.  The format of the log should be the following:

* The SDK provided request ID (see above).
* The status code.
* Any message provided with the status code.
* The response headers (redacted if not in the allow-list).
* The time period between the first attempt of the request and the first byte of the body.

{% include requirement/MUST id="general-logging-cancellations" %} log an `Informational` message if a service call is cancelled.  The log should include:

* The SDK provided request ID (see above).
* The reason for the cancellation (if available).

{% include requirement/MUST id="general-logging-exceptions" %} log exceptions thrown as a `Warning` level message. If the log level set to `Verbose`, append stack trace information to the message.

## Distributed Tracing

Distributed tracing mechanisms allow the consumer to trace their code from frontend to backend. The distributed tracing library creates spans - units of unique work.  Each span is in a parent-child relationship.  As you go deeper into the hierarchy of code, you create more spans.  These spans can then be exported to a suitable receiver as needed.  To keep track of the spans, a _distributed tracing context_ (called a context in the remainder of this section) is passed into each successive layer.  For more information on this topic, visit the [OpenTelemetry] topic on tracing.

{% include requirement/MUST id="general-tracing-opentelemetry" %} support [OpenTelemetry] for distributed tracing.

{% include requirement/MUST id="general-tracing-accept-context" %} accept a context from calling code to establish a parent span.

{% include requirement/MUST id="general-tracing-pass-context" %} pass the context to the backend service through the appropriate headers (`traceparent` and `tracestate` per [W3C Trace-Context](https://www.w3.org/TR/trace-context/) standard) to support [Azure Monitor].  This is generally done with the HTTP pipeline.

{% include requirement/MUST id="general-tracing-new-span-per-method" %} create only one span for client method that user code calls.  New spans must be children of the context that was passed in.  If no context was passed in, a new root span must be created.

{% include requirement/MUST id="general-tracing-suppress-client-spans-for-inner-methods" %} When client method creates a new span and internally calls into other public client methods of the same or different Azure SDK, spans created for inner client methods MUST be suppressed, their attributes and events ignored.  Nested spans created for REST calls MUST be the children of the outer client call span.  Suppression is generally done by Azure Core.

{% include requirement/MUST id="general-tracing-new-span-per-method-conventions" %} populate span properties according to [OpenTelemetry Conventions].

{% include requirement/MUST id="general-tracing-new-span-per-method-naming" %} for service methods, use the language-agnostic naming format `{Namespace}.{Interface}.{OperationName}`,
based on the underlying TypeSpec operation definition, as the span name for each method, without an async suffix. For instrumented convenience methods that do not map to a single service operation, use `{Namespace}.{Interface}.{Method}`, also without the async suffix. Note: Earlier version of guidance recommended a language-specific `<client> <method>` pattern.
The new format may be used in new code, provided it does not introduce backward-incompatible changes in stable libraries.

{% include requirement/MUST id="general-tracing-new-span-per-method-duration" %} start per-method spans before sending the request or calling any significantly time consuming code that might fail. End the span only after all network, IO or other unreliable and time consuming operations are complete.

{% include requirement/MUST id="general-tracing-new-span-per-method-failure" %} If method throws exception, record error details on span. Do not record exception if exception is handled within service method.

{% include requirement/MUST id="general-tracing-new-span-per-rest-call" %} create a new span (which must be a child of the per-method span) for each REST call that the client library makes.  This is generally done with the HTTP pipeline.

Some of these requirements will be handled by the HTTP pipeline.  However, as a client library writer, you must handle the incoming context appropriately.

## Dependencies

Azure services should not require customers to use more than HTTP and JSON (where a JSON string is either a "pure" string or else parseable/formattable as either an RFC 3339 Date/Time, a UUID, or a Base-64 encoded bytes).  This is in order to minimize the learning curve for customers, increase potential customer reach, as well as reduce support costs for Microsoft (a tenet that the Azure review boards are chartered to oversee and manage).  Azure SDK Languages have already selected libraries to assist with these technologies.

If a service needs a technology beyond that which has already been selected, the following process can be used:

* First, the service team can petition the Azure API Stewardship Board to approve technologies that require client-side components.  This must be done early in the design process.  The petitioning team must gather relevant data to justify the critical business need (e.g. competitive advantage, widespread adoption and/or support in the community, improved performance, etc.), why that need cannot reasonably be fulfilled via REST & JSON, the future viability and sustainability of the technology, as well as documentation for the cases/conditions where use of the new technology is indicated.   Evaluation includes a discussion of impact across all languages, especially those supported by Azure SDKs.

* Having gained approval, then to avoid issues with SDKs taking hard dependencies on 3rd party libraries such as versioning, quality, and security issues in code that Microsoft does not own and cannot control, SDKs can offer an extensibility point allowing the end-customer to integrate the 3rd-party library and version they desire into the SDK.  In this case, the SDK’s documentation must have examples showing a customer how to do this correctly for each SDK language.

The following are considerations that will be discussed in any petition to include additional technologies:

* **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
* **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
* **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
* **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
* **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="general-dependencies-azure-core" %} depend on the Azure Core library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, and credential handling.

{% include requirement/MUSTNOT id="general-dependencies-approved-only" %} be dependent on any other packages within the client library distribution package. Dependencies are by-exception and need a thorough vetting through architecture review.  This does not apply to build dependencies, which are acceptable and commonly used.

{% include requirement/SHOULD id="general-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="general-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the Azure Core library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

The above considerations may differ in degree between languages, and so it's important to check the approved dependencies and guidelines for any given language early in the design phase.  (Also note that, in some rare cases, the Azure SDK Architecture Board may opt to take a hard dependency on an additional third party library if, after substantial vetting, the board believes that there is minimal risk to supporting our customers in a sustained manner by doing so.)

## Service-specific common library code

There are occasions when common code needs to be shared between several client libraries.  For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="general-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="general-commonlib-minimize-code" %} minimize the code within a common library.  Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/MUST id="general-commonlib-namespace" %} store the common library in the same namespace as the associated client libraries.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries.  The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library.  This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image.  The user might trap the exception, but otherwise will not operate on the exception.  There is no linkage between the `ObjectNotFound` exception in each client library.  This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already).  Instead, produce two different exceptions - one in each client library.

## Testing

Software testing provides developers a safety net. Investing in tests upfront saves time overall due to increased certainty over the development process that changes are not resulting in divergence from stated requirements and specifications. The intention of these testing guidelines is to focus on the complexities around testing APIs that are backed by live services when in their normal operating mode. We want to enable open source development of our client libraries, with certainty that regardless of the developer making code changes there always remains conformance to the initial design goals of the code. Additionally, our goal is to ensure that developers building atop the Azure client libraries can meaningfully test their own code, without incurring additional complexity or expense through unnecessary interactions with a live Azure service.

{% include requirement/MUST id="general-testing-1" %} write tests that ensure all APIs fulfil their contract and algorithms work as specified. Focus particular attention on client functionality, and places where payloads are serialized and deserialized.

{% include requirement/MUST id="general-testing-2" %} ensure that client libraries have appropriate unit test coverage, [focusing on quality tests][2], using code coverage reporting tools to identify areas where more tests would be beneficial. Each client library should define its minimum level of code coverage, and ensure that this is maintained as the code base evolves.

{% include requirement/MUST id="general-testing-3" %} use unique, descriptive test case names so test failures in CI (especially external PRs) are readily understandable.

{% include requirement/MUST id="general-testing-4" %} ensure that users can run all tests without needing access to Microsoft-internal resources. If internal-only tests are necessary, these should be a separate test suite triggered via a separate command, so that they are not executed by users who will then encounter test failures that they cannot resolve.

{% include requirement/MUSTNOT id="general-testing-5" %} rely on pre-existing test resources or infrastructure and **DO NOT** leave test resources around after tests have completed. Anything needed for a test should be initialized and cleaned up as part of the test execution (whether by running an ARM template prior to starting tests, or by setting up and tearing down resources in the tests themselves).

### Recorded tests

{% include requirement/MUST id="general-testing-6" %} ensure that all tests work without the need for any network connectivity or access to Azure services.

{% include requirement/MUST id="general-testing-7" %} write tests that use a mock service implementation, with a set of recorded tests per service version supported by the client library. This ensures that the service client continues to properly consume service responses as APIs and implementations evolve. Recorded tests must be run using the language-appropriate trigger to enable the specific service version support in the client library.

{% include requirement/MUST id="general-testing-8" %} recreate recorded tests for latest service version when notified by the service team of any changes to the endpoint APIs for that service version. In the absence of this notification, recordings should not be updated needlessly. When the service team requires recorded tests to be recreated, or when a recorded test begins to fail unexpectedly, notify the architecture board before recreating the tests.

{% include requirement/MUST id="general-testing-9" %} enable all network-mocked tests to also connect to live Azure service. The test assertions should remain unchanged regardless of whether the service call is mocked or not.

{% include requirement/MUSTNOT id="general-testing-10" %} include sensitive information in recorded tests.

### Testability

As outlined above, writing tests that we can run constantly is critical for confidence in our client library offering, but equally critical is enabling users of the Azure client libraries to write tests for their applications and libraries. End users want to be certain that their code is performing appropriately, and in cases where this code interacts with the Azure client libraries, end users do not want complex or costly Azure interactions to prevent their ability to test their software.

{% include requirement/MUST id="general-testing-mocking" %} support mocking of service client methods through standard mocking frameworks or other means.

{% include requirement/MUST id="general-testing-11" %} support the ability to instantiate and set all properties on model objects, such that users may return these from their code.

{% include requirement/MUST id="general-testing-12" %} support user tests to operate in a network-mocked manner without the need for network access.

{% include requirement/MUST id="general-testing-13" %} provide clear documentation on how users should instantiate the client library such that it can be mocked.

{% include refs.md %}

[OpenTelemetry]: https://opentelemetry.io
[Azure Monitor]: https://azure.microsoft.com/services/monitor/
[1]: https://www.youtube.com/watch?v=PAAkCSZUG1c&t=9m28s
[2]: https://martinfowler.com/bliki/TestCoverage.html
[OpenTelemetry Conventions]: {{ site.baseurl }}{% link docs/observability/opentelemetry-conventions.md %}
