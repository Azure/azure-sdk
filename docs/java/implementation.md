---
title: "Java Guidelines: Implementation"
keywords: guidelines java
permalink: java_implementation.html
folder: java
sidebar: general_sidebar
---

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools.

{% include requirement/MUSTNOT id="java-namespaces-implementation" %} allow implementation code (that is, code that doesn't form part of the public API) to be mistaken as public API. There are two valid arrangements for implementation code, which in order of preference are the following:

1. Implementation classes can be made package-private and placed within the same package as the consuming class.
2. Implementation classes can be placed within a subpackage named `implementation`.

CheckStyle checks ensure that classes within an `implementation` package aren't exposed through public API, but it is better that the API not be public in the first place, so preferring to have package-private is the better approach where practicable.

### Service Client

#### Async Service Client

{% include requirement/MUSTNOT id="java-async-blocking" %} include blocking calls inside async client library code. Use [BlockHound] to detect blocking calls in async APIs.

#### Annotations

Include the following annotations on the service client class.  For example, this code sample shows a sample class demonstrating the use of these two annotations:

```java
@ServiceClient(builder = ConfigurationAsyncClientBuilder.class, isAsync = true, service = ConfigurationService.class)
public final class ConfigurationAsyncClient {

    @ServiceMethod(returns = ReturnType.COLLECTION)
    public Mono<Response<ConfigurationSetting>> addSetting(String key, String value) {
        ...
    }
}
```

| Annotation | Location | Description |
|:-----------|:---------|:------------|
| `@ServiceClient` | Service Client | Specifies the builder responsible for instantiating the service client, whether the API is asynchronous, and a reference back to the service interface (the interface annotated with `@ServiceInterface`). |
| `@ServiceMethod` | Service Method | Placed on all methods that do network operations, regardless of whether it is a client class or not. |

#### Service Client Builder

##### Annotations

The `@ServiceClientBuilder` annotation should be placed on any class that is responsible for instantiating service clients (that is, instantiating classes annotated with `@ServiceClient`). For example:

```java
@ServiceClientBuilder(serviceClients = {ConfigurationClient.class, ConfigurationAsyncClient.class})
public final class ConfigurationClientBuilder { ... }
```

This builder states that it can build instances of `ConfigurationClient` and `ConfigurationAsyncClient`.

### Supporting Types

#### Model Types

##### Annotations

There are two annotations of note that should be applied on model classes, when applicable:

* The `@Fluent` annotation is applied to all model classes that are expected to provide a fluent API to end users.
* The `@Immutable` annotation is applied to all immutable classes.

## SDK Feature Implementation

### Logging

Client libraries must make use of the robust logging mechanisms in azure core, so that the consumers can adequately diagnose issues with method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

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

{% include requirement/MUST id="java-logging-log-and-throw" %} throw all exceptions created within the client library code through one of the logger APIs - `ClientLogger.logThrowableAsError()`, `ClientLogger.logThrowableAsWarning()`, `ClientLogger.logExceptionAsError()` or `ClientLogger.logExceptionAsWarning()`.

For example:

```java
// NO!!!!
if (priority != null && priority < 0) {
    throw new IllegalArgumentException("'priority' cannot be a negative value. Please specify a zero or positive long value.");
}

// Good

// Log any Throwable as error and throw the exception
if (!file.exists()) {
    throw logger.logThrowableAsError(new IOException("File does not exist " + file.getName()));
}

// Log any Throwable as warning and throw the exception
if (!file.exists()) {
    throw logger.logThrowableAsWarning(new IOException("File does not exist " + file.getName()));
}

// Log a RuntimeException as error and throw the exception
if (priority != null && priority < 0) {
    throw logger.logExceptionAsError(new IllegalArgumentException("'priority' cannot be a negative value. Please specify a zero or positive long value."));
}

// Log a RuntimeException as warning and throw the exception
if (numberOfAttempts < retryPolicy.getMaxRetryCount()) {
    throw logger.logExceptionAsWarning(new RetryableException("A transient error occurred. Another attempt will be made after " + retryPolicy.getDelay()));
}
```

### Distributed tracing

Distributed tracing mechanisms allow the consumer to trace their code from frontend to backend.  Distributed tracing libraries creates spans - units of unique work.  Each span is in a parent-child relationship.  As you go deeper into the hierarchy of code, you create more spans.  These spans can then be exported to a suitable receiver as needed.  To keep track of the spans, a _distributed tracing context_ (called a context in the remainder of this section) is passed into each successive layer.  For more information on this topic, visit the [OpenTelemetry] topic on tracing.

The Azure core library provides a service provider interface (SPI) for adding pipeline policies at runtime. The pipeline policy is used to enable tracing on consumer deployments. Pluggable pipeline policies must be supported in all client libraries to enable distributed tracing. Additional metadata can be specified on a per-service-method basis to provide a richer tracing experience for consumers.  

{% include requirement/MUST id="java-tracing-pluggable" %} support pluggable pipeline policies as part of the HTTP pipeline instantiation. This enables developers to include a tracing plugin and have its pipeline policy automatically injected into all client libraries that they are using.

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

{%include requirement/MUST id="java-tracing-tracerproxy" %} use the Azure core `TracerProxy` API to set additional metadata that should be supplied along with the tracing span. In particular, use the `setAttribute(String key, String value, Context context)` method to set a new key/value pair on the tracing context.

{%include requirement/MUST id="java-tracing-tracing-context" %} pass all `Context` objects received as service method arguments through to the generated service interface methods in all cases.

## Testing

{% include requirement/MUST id="java-testing-params" %} parameterize all applicable unit tests to make use of all available HTTP clients and service versions. Parameterized runs of all tests must occur as part of live tests. Shorter runs, consisting of just Netty and the latest service version, can be run whenever PR validation occurs.

> TODO refer to cases where this is done in Java today

{% include refs.md %}
{% include_relative refs.md %}
