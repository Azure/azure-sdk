---
title: "Java Guidelines: Implementation"
keywords: guidelines java
permalink: java_implementation.html
folder: java
sidebar: general_sidebar
---

## API Implementation

### Service Client

#### Network requests

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include requirement/MUST id="java-network-use-http-pipeline" %} use the HTTP pipeline component within `azure-core` library for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services. The order in the list is the most sensible order for implementation.

{% include requirement/SHOULD id="java-network-azure-core-policies" %} use the policy implementations in Azure Core whenever possible. Do not try to "write your own" policy unless it is doing something unique to your service. If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

{% include requirement/MUST id="java-network-azure-core-policies-public" %} make all custom policies (HTTP or otherwise) available as public API. This enables developers who choose to implement their own pipeline to reuse the policy rather than write it themselves.

#### Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="java-auth-persistence" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations. 

If your service implements a non-standard credential system (that is, a credential system that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="java-auth-policy-impl" %} provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials. This includes custom connection strings, if supported.

## SDK Feature Implementation

### Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

#### Client configuration

{% include requirement/MUST id="java-config-global" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="java-config-client" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="java-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="java-config-global-override" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="java-config-behavior-changes" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

#### Service-specific environment variables

{% include requirement/MUST id="java-envvars-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MAY id="java-envvars-client-prefix" %} use client library-specific environment variables for portal-configured settings which are provided as parameters to your client library. This generally includes credentials and connection details. For example, Service Bus could support the following environment variables:

* `AZURE_SERVICEBUS_CONNECTION_STRING`
* `AZURE_SERVICEBUS_NAMESPACE`
* `AZURE_SERVICEBUS_ISSUER`
* `AZURE_SERVICEBUS_ACCESS_KEY`

Storage could support:

* `AZURE_STORAGE_ACCOUNT`
* `AZURE_STORAGE_ACCESS_KEY`
* `AZURE_STORAGE_DNS_SUFFIX`
* `AZURE_STORAGE_CONNECTION_STRING`

{% include requirement/MUST id="java-envvars-approval" %} get approval from the [Architecture Board] for every new environment variable. 

{% include requirement/MUST id="java-envvars-syntax" %} use this syntax for environment variables specific to a particular Azure service:

* `AZURE_<ServiceName>_<ConfigurationKey>`

where _ServiceName_ is the canonical shortname without spaces, and _ConfigurationKey_ refers to an unnested configuration key for that client library.

{% include requirement/MUSTNOT id="java-envvars-posix-compliance" %} use non-alpha-numeric characters in your environment variable names with the exception of underscore. This ensures broad interoperability.

### Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="java-logging-clientlogger" %} use the `ClientLogger` API provided within Azure Core as the sole logging API throughout all client libraries. Internally, `ClientLogger` wraps [SLF4J], so all external configuration that is offered through SLF4J is valid.  We encourage you to expose the SLF4J configuration to end users. For more information, see the [SLF4J user manual].

{% include requirement/MUST id="java-logging-new-clientlogger" %} create a new instance of a `ClientLogger` per instance of all relevant classes, except in situations where performance is critical, the instances are short-lived (and therefore the cost of unique loggers is excessive), or in static-only classes (where there is no instantiation of the class allowed). In these cases, it is acceptable to have a shared (or static) logger instance. For example, the code below will create a `ClientLogger` instance for the `ConfigurationAsyncClient`:

```java
public final class ConfigurationAsyncClient {
    private final ClientLogger logger = new ClientLogger(ConfigurationAsyncClient.class);

    // example async call to a service that uses the Project Reactor APIs to log request, success, and error
    // information out to the service logger instance
    public Mono<Response<ConfigurationSetting>> setSetting(ConfigurationSetting setting) {
        return service.setKey(serviceEndpoint, setting.key(), setting.label(), setting, getETagValue(setting.etag()), null)
            .doOnRequest(ignoredValue -> logger.info("Setting ConfigurationSetting - {}", setting))
            .doOnSuccess(response -> logger.info("Set ConfigurationSetting - {}", response.value()))
            .doOnError(error -> logger.warning("Failed to set ConfigurationSetting - {}", setting, error));
    }
}
```

Note that static loggers are shared among all client library instances running in a JVM instance. Static loggers should be used carefully and in short-lived cases only.

{% include requirement/MUST id="java-logging-levels" %} use one of the following log levels when emitting logs: `Verbose` (details), `Informational` (things happened), `Warning` (might be a problem or not), and `Error`.

{% include requirement/MUST id="java-logging-errors" %} use the `Error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="java-logging-warn" %} use the `Warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MAY id="java-logging-slowlinks" %} log the request and response (see below) at the `Warning` logging level when a request/response cycle (to the start of the response body) exceeds a service-defined threshold.  The threshold should be chosen to minimize false-positives and identify service issues.

{% include requirement/MUST id="java-logging-info" %} use the `Informational` logging level when a function operates normally.

{% include requirement/MUST id="java-logging-verbose" %} use the `Verbose` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUST id="java-logging-no-sensitive-info" %} only log headers and query parameters that are in a service-provided "allow-list" of approved headers and query parameters.  All other headers and query parameters must have their values redacted.

{% include requirement/MUST id="java-logging-requests" %} log request line and headers as an `Informational` message. The log should include the following information:

* The HTTP method.
* The URL.
* The query parameters (redacted if not in the allow-list).
* The request headers (redacted if not in the allow-list).
* An SDK provided request ID for correlation purposes.
* The number of times this request has been attempted.

This happens within azure-core by default, but users can configure this through the builder `httpLogOptions` configuration setting.

{% include requirement/MUST id="java-logging-responses" %} log response line and headers as an `Informational` message.  The format of the log should be the following:

* The SDK provided request ID (see above).
* The status code.
* Any message provided with the status code.
* The response headers (redacted if not in the allow-list).
* The time period between the first attempt of the request and the first byte of the body.

{% include requirement/MUST id="java-logging-cancellations" %} log an `Informational` message if a service call is cancelled.  The log should include:

* The SDK provided request ID (see above).
* The reason for the cancellation (if available).

{% include requirement/MUST id="java-logging-exceptions" %} log exceptions thrown as a `Warning` level message. If the log level set to `Verbose`, append stack trace information to the message.

{% include requirement/MUST id="java-logging-log-and-throw" %} throw all exceptions created within the client library code through the `ClientLogger.logAndThrow()` API.

For example:

```java
// NO!!!!
if (priority != null && priority < 0) {
    throw new IllegalArgumentException("'priority' cannot be a negative value. Please specify a zero or positive long value.");
}

// Good
if (priority != null && priority < 0) {
    logger.logAndThrow(new IllegalArgumentException("'priority' cannot be a negative value. Please specify a zero or positive long value."));
}
```

### Distributed tracing

Distributed tracing mechanisms allow the consumer to trace their code from frontend to backend.  The distributed tracing library creates spans - units of unique work.  Each span is in a parent-child relationship.  As you go deeper into the hierarchy of code, you create more spans.  These spans can then be exported to a suitable receiver as needed.  To keep track of the spans, a _distributed tracing context_ (called a context in the remainder of this section) is passed into each successive layer.  For more information on this topic, visit the [OpenTelemetry] topic on tracing.

The Azure core library provides a service provider interface (SPI) for adding pipeline policies at runtime. The pipeline policy is used to enable tracing on consumer deployments. Pluggable pipeline policies must be supported in all client libraries to enable distributed tracing. Additional metadata can be specified on a per-service-method basis to provide a richer tracing experience for consumers.  

{% include requirement/MUST id="java-tracing-pluggable" %} support pluggable pipeline policies as part of the HTTP pipeline instantiation.

Review the code sample below, in which a service client builder creates an `HttpPipeline` from its set of policies.  At the same time, the builder allows plugins to add 'before retry' and 'after retry' policies with the lines `HttpPolicyProviders.addBeforeRetryPolicies(policies)` and `HttpPolicyProviders.addAfterRetryPolicies(policies)`:

```java
public ConfigurationAsyncClient build() {
    ...

    // Closest to API goes first, closest to wire goes last.
    final List<HttpPipelinePolicy> policies = new ArrayList<>();
    policies.add(new UserAgentPolicy(AzureConfiguration.NAME, AzureConfiguration.VERSION, buildConfiguration));
    policies.add(new RequestIdPolicy());
    policies.add(new AddHeadersPolicy(headers));
    policies.add(new AddDatePolicy());
    policies.add(new ConfigurationCredentialsPolicy(buildCredentials));
    HttpPolicyProviders.addBeforeRetryPolicies(policies);
    policies.add(retryPolicy);
    policies.addAll(this.policies);
    HttpPolicyProviders.addAfterRetryPolicies(policies);
    policies.add(new HttpLoggingPolicy(httpLogDetailLevel));

    ...
}
```

{% include requirement/MUST id="java-tracing-accept-context" %} accept a context from calling code to establish a parent span.

{% include requirement/MUST id="java-tracing-pass-context" %} pass the context to the backend service through the appropriate headers (`traceparent`, `tracestate`, etc.) to support [Azure Monitor].  This is generally done with the HTTP pipeline.

{% include requirement/MUST id="java-tracing-new-span-per-method" %} create a new span for each method that user code calls.  New spans must be children of the context that was passed in.  If no context was passed in, a new root span must be created.

{% include requirement/MUST id="java-tracing-new-span-per-rest-call" %} create a new span (which must be a child of the per-method span) for each REST call that the client library makes.  This is generally done with the HTTP pipeline.

{%include requirement/MUST id="java-tracing-tracerproxy" %} use the Azure core `TracerProxy` API to set additional metadata that should be supplied along with the tracing span. In particular, use the `setAttribute(String key, String value, Context context)` method to set a new key/value pair on the tracing context.

Some of these requirements will be handled by the HTTP pipeline.  However, as a client library writer, you must handle the incoming context appropriately.

## Testing

One of the key things we want to support is to allow consumers of the library to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliable and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

{% include requirement/MUST id="java-testing-mocking" %} support mocking of network operations.

{% include requirement/MUST id="java-testing-params" %} parameterize all applicable unit tests to make use of all available HTTP clients and service versions. Parameterized runs of all tests must occur as part of live tests. Shorter runs, consisting of just Netty and the latest service version, can be run whenever PR validation occurs.

## Java-Specific Guidance

{% include requirement/MUSTNOT id="java-async-blocking" %} include blocking calls inside async client library code. Use [BlockHound] to detect blocking calls in async APIs.

{% include requirement/MUSTNOT id="java-namespaces-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. There are two valid arrangements for implementation code:

1. Implementation classes can be placed within a subpackage named `implementation`.
2. Implementation classes can be made package-private and placed within the same package as the consuming class.

CheckStyle checks ensure that classes within an `implementation` package aren't exposed through public API.

### Annotations

A number of annotations are defined in the Azure core library. A few annotations enable runtime functionality.  Most of the annotations are used as part of the [Azure Java SDK code linting tools](#java-tooling).

{% include requirement/MUST id="java-annotations-azure-core" %} use the Azure core library annotations outlined below in all applicable places. Use annotations eagerly as part of the initial code design.  The code linters will ensure continued conformance to some of the rules outlined in this specification.

{% include requirement/MUSTNOT id="java-annotations-format" %} include spaces in annotation string values, unless the description below states it's allowed.

#### Service interface

A service interface defines the REST endpoints for a service, but isn't part of the public API.  It's hidden behind the service client class. For example, here is the service interface for one method within the `ConfigurationService`:

```java
@Host("{url}")
@ServiceInterface("AppConfig")
interface ConfigurationService {
    @Get("kv/{key}")
    @ExpectedResponses({200})
    @UnexpectedResponseExceptionType(code = {404}, value = ResourceNotFoundException.class)
    @UnexpectedResponseExceptionType(HttpResponseException.class)
    Mono<Response<ConfigurationSetting>> getKeyValue(
            @HostParam("url") String url, @PathParam("key") String key, @QueryParam("label") String label,
            @QueryParam("$select") String fields, @HeaderParam("Accept-Datetime") String acceptDatetime,
            @HeaderParam("If-Match") String ifMatch, @HeaderParam("If-None-Match") String ifNoneMatch,
            Context context);
    ...
}
```

| Annotation | Location | Description |
|:-----------|:---------|:------------|
| `@ServiceInterface` | Service Interface | This interface represents a REST endpoint for the service.  The argument will be used as the service name in policies (such as telemetry and tracing). The argument must be short, alphanumeric, without spaces, and fit for public consumption. |
| `@Host` | Service Interface | The host name of the REST service.  The `{url}` maps with the `@HostParam` annotation. |
| `@<Method>` | Service Method | The HTTP method and endpoint used for the HTTP request. |
| `@ExpectedResponses` | Service Method | The list of HTTP status codes that the method expects to receive on success. |
| `@UnexpectedResponseExceptionType` | Method | Enables different exceptions to be thrown based on the status code returned. |
| `@BodyParam` | Argument | Places this argument into the body of the outgoing HTTP request. |
| `@HeaderParam` | Argument | Places this argument into the header of the outgoing HTTP request. |
| `@PathParam` | Argument | Places the argument into the endpoint path. |
| `@QueryParam` | Argument | Places the argument into the query string of the outgoing HTTP request. |

When specifying strings, you may use `{argument}` to do string replacement from arguments.  For example, the `@PathParam("key")` annotation replaces the `{key}` segment in the method annotation in the above example.

#### Service client

Include the following annotations on the service client class.  For example, this code sample shows a sample class demonstrating the use of these two annotations:

```java
@ServiceClient(builder = ConfigurationAsyncClientBuilder.class, isAsync = true, service = ConfigurationService.class)
public final class ConfigurationAsyncClient {

    @ServiceMethod
    public Mono<Response<ConfigurationSetting>> addSetting(String key, String value) {
        ...
    }
}
```

| Annotation | Location | Description |
|:-----------|:---------|:------------|
| `@ServiceClient` | Service Client | Specifies the builder responsible for instantiating the service client, whether the API is asynchronous, and a reference back to the service interface (the interface annotated with `@ServiceInterface`). |
| `@ServiceMethod` | Service Method | Placed on all service client methods that do network operations. |

#### Service Client Builder

The `@ServiceClientBuilder` annotation should be placed on any class that is responsible for instantiating service clients (that is, instantiating classes annotated with `@ServiceClient`). For example:

```java
@ServiceClientBuilder(serviceClients = {ConfigurationClient.class, ConfigurationAsyncClient.class})
public final class ConfigurationClientBuilder { ... }
```

This builder states that it can build instances of `ConfigurationClient` and `ConfigurationAsyncClient`.

#### Model Classes

There are two annotations of note that should be applied on model classes, when applicable:

* The `@Fluent` annotation is given to all model classes that are expected to provide a fluent API to end users.
* The `@Immutable` annotation is given to all immutable classes.

{% include refs.md %}
{% include_relative refs.md %}
