---
title: "Go Guidelines: Implementation"
keywords: guidelines golang
permalink: golang_implementation.html
folder: golang
sidebar: golang_sidebar
---

{% include draft.html content="The Go Language guidelines are in DRAFT status" %}

# Client Configuration

{% include requirement/MUST id="golang-config-global" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="golang-config-client" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="golang-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="golang-config-global-override" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="golang-config-behavior-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

# Service-specific Environment Variables

{% include requirement/MUST id="golang-envvars-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MAY id="golang-envvars-client-prefix" %} use client library-specific environment variables for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="golang-envvars-approval" %} get approval from the [Architecture Board] for every new environment variable. 

{% include requirement/MUST id="golang-envvars-syntax" %} use this syntax for environment variables specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="golang-envvars-posix-compliance" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

# Network Requests

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="golang-network-use-http-pipeline" %} use the HTTP pipeline component within `azcore` library for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services. The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="golang-network-policies" %} implement the following policies in the HTTP pipeline:

- Telemetry
- Unique Request ID
- Retry
- Authentication
- Response downloader
- Distributed tracing
- Logging
- The HTTP transport itself

{% include requirement/SHOULD id="golang-network-azure-core-policies" %} use the policy implementations in Azure Core whenever possible. Do not try to "write your own" policy unless it is doing something unique to your service. If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

# Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="golang-auth-persistence" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations. 

{% include requirement/MUST id="golang-auth-policy-impl" %} provide a suitable authentication policy policy if your service implements a non-standard authentication system (that is, an authentication system that is not supported by Azure Core).  You also need to produce an authentication policy for the HTTP pipeline that can add credentials to requests given the alternative authentication mechanism provided by the service.  Custom credentials will need to implement the `azcore.Credentials` interface.

# Error Handling

{% include requirement/MUST id="golang-errors" %} return an error if a method fails to perform its intended functionality.  For methods that return multiple items, the error object is always the last item in the return signature.

{% include requirement/SHOULD id="golang-errors-wrapping" %} wrap an error with another error if it would help in the diagnosis of the underlying failure.  Expect consumers to use [error helper functions](https://blog.golang.org/go1.13-errors) like `errors.As()` and `errors.Is()`.

```go
err := xml.Unmarshal(resp.Payload, v)
if err != nil {
	return fmt.Errorf("unmarshalling type %s: %w", reflect.TypeOf(v).Elem().Name(), err)
}
```

{% include requirement/MUST id="golang-errors-on-request-failed" %} return a service-specific error type when an HTTP request fails with an unsuccessful HTTP status code as defined by the service.  The error type MUST be composed of `azcore.RequestError` as an anonymous field.

```go
type APIError struct {
	azcore.RequestError
	Code AnomalyDetectorErrorCodes
	Message string
}
```

{% include requirement/MUST id="golang-errors-include-response" %} include the HTTP response and originating request in the returned error.

In the case of a method that makes multiple HTTP requests, the first error encountered should stop the remainder of the operation and this error (or another error wrapping it) should be returned.

{% include requirement/MUST id="golang-errors-distinct-types" %} return distinct error types so that consumers can distinguish between a client error (incomplete/incorrect API parameter values) and other SDK failures (failure to send the request, marshalling/unmarshalling, parsing errors).

{% include requirement/MUST id="golang-errors-documentation" %} document the error types that are returned by each method.  Don't document commonly returned error types, for example `context.DeadlineExceeded` when an HTTP request times out.

{% include requirement/MUSTNOT id="golang-errors-other-types" %} create arbitrary error types.  Use error types provided by the standard library or `azcore`.

# Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="golang-log-api" %} use the Logger API provided within `azcore` as the sole logging API throughout all client libraries.

{% include requirement/MUST id="golang-log-classification" %} define constant classification strings using the `azcore.LogClassification` type, then log using these values.

{% include requirement/MUST id="golang-log-inclue" %} log HTTP request line, response line, and all header/query parameter names.

{% include requirement/MUSTNOT id="golang-log-exclude" %} log payloads or HTTP header/query parameter values that aren't on the white list.  For header/query parameters not on the white list use the value `<REDACTED>` in place of the real value.

# Distributed Tracing

{% include requirement/MUST id="golang-tracing-abstraction" %} abstract the underlying tracing facility, allowing consumers to use the tracing implementation of their choice.

{% include requirement/MUST id="golang-tracing-span-per-call" %} create a new trace span for each API call.  New spans must be children of the context that was passed in.

{% include requirement/MUST id="golang-tracing-span-name" %} use `<package name>.<type name>.<method name>` as the name of the span.

{% include requirement/MUST id="golang-tracing-propagate" %} propagate tracing context on each outgoing service request through the appropriate headers to support a tracing service like [Azure Monitor](https://azure.microsoft.com/en-us/services/monitor/) or [ZipKin](https://zipkin.io/).  This is generally done with the HTTP pipeline.

# Service-specific Common Library Code

There are occasions when common code needs to be shared between several client libraries. For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="golang-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="golang-commonlib-minimize-code" %} minimize the code within a common library. Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/MUST id="golang-commonlib-namespace" %} store the common library in the same namespace as the associated client libraries.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries. The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library. This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries return a `BoundingBox` model to indicate where an object was detected in an image. There is no linkage between the `BoundingBox` model in each client library, and it is not passed into another client library. This is not a good candidate for creation of a common library (although you may wish to place this model in a common library if one exists for the namespace already). Instead, produce two different models - one in each client library.

{% include refs.md %}
{% include_relative refs.md %}
