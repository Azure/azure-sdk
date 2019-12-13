---
title: "Android Guidelines: Implementation"
keywords: guidelines android
permalink: android_implementation.html
folder: android
sidebar: android_sidebar
---

{% include draft.html content="The Android guidelines are in DRAFT status" %}

## Library considerations

Android Java developers need to concern themselves with the runtime environment they are running in.  The Android ecosystem is fragmented, with a wide variety of runtimes deployed.

{% include requirement/MUST id="android-library-sync-support" %} support API level 23 and later (Android 6.0 Marshmallow).

{% include requirement/MUST id="android-library-async-support" %} support async HTTP at API level 26.

{% include requirement/MUST id="android-library-separate-libraries" %} release separate client libraries for sync and async versions.

There are two settings that are of concern when discussing the minimum API level to choose:

1. The minimum API level that Google supports.
2. The reach of selecting a particular API level.

We require the minimum API level that Google supports that reaches 70% of Android devices (as listed on the [Android distribution dashboard](https://developer.android.com/about/dashboards/)).  This is currently API level 23.

{% include requirement/MUST id="android-library-target-sdk-version" %} set the `targetSdkVersion` to be API level 26.

As of November 2018, all existing apps are required to target API level 26 or higher.  For more information, see [Improving app security and performance on Google Play for years to come](https://android-developers.googleblog.com/2017/12/improving-app-security-and-performance.html).

{% include requirement/MUST id="android-library-max-sdk-version" %} set the `maxSdkVersion` to be the latest API level that you have run tests on.  This should be the latest API level that is supported by Google at the point at which the SDK is released.

{% include requirement/MUST id="android-library-java-version" %} use Java 7, with the following Java 8 features:

* Lambda expressions
* Method references
* Type annotations (except `TYPE_USE` and `TYPE_PARAMETER`)
* Default and static interface methods
* Repeating annotations

{% include requirement/MUST id="android-library-source-compat" %} use source and target compatibility set to 1.8.

{% include requirement/MUST id="android-library-shrink-code" %} [shrink your code](https://developer.android.com/studio/build/shrink-code.html#shrink-code)

{% include requirement/MUST id="android-library-64bit" %} Release the library as a 64-bit AAR.

{% include requirement/MUST id="android-library-resoiurce-prefix" %} define a `resourcePrefix` of `azure_<service>` in the `build.gradle` android section if using resources.

{% include requirement/MUST id="android-library-proguard" %} use `consumerProguardFiles` if you need to change Proguard settings to support the client library.

## Configuration

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

### Client configuration

{% include requirement/MUST id="android-config-global" %} use relevant global configuration settings either by default or when explicitly requested to by the user, for example by passing in a configuration object to a client constructor.

{% include requirement/MUST id="android-config-client" %} allow different clients of the same type to use different configurations.

{% include requirement/MUST id="android-config-optout" %} allow consumers of your service clients to opt out of all global configuration settings at once.

{% include requirement/MUST id="android-config-override" %} allow all global configuration settings to be overridden by client-provided options. The names of these options should align with any user-facing global configuration keys.

{% include requirement/MUSTNOT id="android-config-immutable-client" %} change behavior based on configuration changes that occur after the client is constructed. Hierarchies of clients inherit parent client configuration unless explicitly changed or overridden. Exceptions to this requirement are as follows:

1. Log level, which must take effect immediately across the Azure SDK.
2. Tracing on/off, which must take effect immediately across the Azure SDK.

{% include requirement/MUSTNOT id="android-config-envvars" %} rely on environment variables or other environment configuration to configure the SDK.  The user of a mobile app does not have access to environment variables.  Use the Azure Core configuration API instead.

## Parameter validation

The service client will have several methods that perform requests on the service. _Service parameters_ are directly passed across the wire to an Azure service. _Client parameters_ are not passed directly to the service, but used within the client library to fulfill the request.  Examples of client parameters include values that are used to construct a URI, or a file that needs to be uploaded to storage.

{% include requirement/MUST id="android-params-client-validation" %} validate client parameters.

{% include requirement/MUSTNOT id="android-params-service-validation" %} validate service parameters. This includes null checks, empty strings, and other common validating conditions. Let the service validate any request parameters.

{% include requirement/MUST id="android-params-devex" %} validate the developer experience when the service parameters are invalid to ensure appropriate error messages are generated by the service. If the developer experience is compromised due to service-side error messages, work with the service team to correct prior to release.

## Network requests

Each supported language has an Azure Core library that contains common mechanisms for cross cutting concerns such as configuration and doing HTTP requests.

{% include important.html content="The Azure Core library for Android is separate and distinct from the Azure Core library for Java." %}

{% include requirement/MUST id="android-network-use-azure-core" %} use the HTTP pipeline component within `com.azure.core` library for communicating to service REST endpoints.

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies. Each policy is a control point during which the pipeline can modify either the request and/or response. We prescribe a default set of policies to standardize how client libraries interact with Azure services. The order in the list is the most sensible order for implementation.

{% include requirement/MUST id="android-network-use-policies" %} implement the following policies in the HTTP pipeline:

- Telemetry
- Unique Request ID
- Retry
- Authentication
- Response downloader
- Distributed tracing
- Logging

{% include requirement/SHOULD id="android-network-use-azure-core-policies" %} use the policy implementations in Azure Core whenever possible. Do not try to "write your own" policy unless it is doing something unique to your service. If you need another option to an existing policy, engage with the [Architecture Board] to add the option.

## Authentication

When implementing authentication, don't open up the consumer to security holes like PII (personally identifiable information) leakage or credential leakage. Credentials are generally issued with a time limit, and must be refreshed periodically to ensure that the service connection continues to function as expected. Ensure your client library follows all current security recommendations and consider an independent security review of the client library to ensure you're not introducing potential security problems for the consumer.

{% include requirement/MUSTNOT id="android-auth-never-persist" %} persist, cache, or reuse security credentials. Security credentials should be considered short lived to cover both security concerns and credential refresh situations.

If your service implements a non-standard credential system (that is, a credential system that is not supported by Azure Core), then you need to produce an authentication policy for the HTTP pipeline that can authenticate requests given the alternative credential types provided by the client library.

{% include requirement/MUST id="android-auth-policy" %} provide a suitable authentication policy that authenticates the HTTP request in the HTTP pipeline when using non-standard credentials.

{% include requirement/MUSTNOT id="andorid-auth-connection-strings" %} support connection strings.  They are insecure within the context of an Android mobile app.

## Native code

Native code plugins cause compatibility issues and require additional scrutiny. Certain languages compile to a machine-native format (for example, C or C++), whereas most modern languages opt to compile to an intermediary format to aid in cross-platform support.

{% include requirement/MUSTNOT id="android-no-native-code" %} write platform-specific / native code.

## Error handling

Error handling is an important aspect of implementing a client library. It is the primary method by which problems are communicated to the consumer. There are two methods by which errors are reported to the consumer. Either the method throws an exception, or the method returns an error code (or value) as its return value, which the consumer must then check. In this section we refer to "producing an error" to mean returning an error value or throwing an exception, and "an error" to be the error value or exception object.

{% include requirement/SHOULD id="android-errors-prefer-exceptions" %} prefer the use of exceptions over returning an error value when producing an error.

{% include requirement/MUST id="android-errors-for-failed-request" %} produce an error when any HTTP request fails with an HTTP status code that is not defined by the service/Swagger as a successful status code. These errors should also be logged as errors.

{% include requirement/MUST id="android-errors-use-unchecked-exceptions" %} use unchecked exceptions for HTTP requests. Java offers checked and unchecked exceptions, where checked exceptions force the user to introduce verbose `try .. catch` code blocks and handle each specified exception. Unchecked exceptions avoid verbosity and improve scalability issues inherent with checked exceptions in large apps.

{% include requirement/MUST id="android-errors-contents" %} ensure that the error produced contains the HTTP response (including status code and headers) and originating request (including URL, query parameters, and headers).

In the case of a higher-level method that produces multiple HTTP requests, either the last exception or an aggregate exception of all failures should be produced.

{% include requirement/MUST id="android-errors-rich-info" %} ensure that if the service returns rich error information (via the response headers or body), the rich information must be available via the error produced in service-specific properties/fields.

{% include requirement/MUSTNOT id="android-errors-no-new-types" %} create a new error type when a language-specific error type will suffice. Use system-provided error types for validation.

{% include requirement/MUST id="android-errors-standard-types" %} use the following standard Java exceptions for pre-condition checking:

| Exception                       | When to use                                                    |
|---------------------------------|----------------------------------------------------------------|
| `IllegalArgumentException`      | When a method argument is non-null, but inappropriate          |
| `IllegalStateException`         | When the object state means method invocation can't continue   |
| `NullPointerException`          | When a method argument is `null` and `null` is unexpected      |
| `UnsupportedOperationException` | When an object doesn't support method invocation               |

{% include requirement/MUST id="android-errors-documentation" %} document the errors that are produced by each method (with the exception of commonly thrown errors that are generally not documented in the target language).

{% include requirement/MUST id="android-errors-javadoc" %} specify all checked and unchecked exceptions thrown in a method within the JavaDoc documentation on the method as `@throws` statements.

{% include requirement/MUST id="android-errors-exception-tree" %} use the existing exception types present in the Azure core library for service request failures. Avoid creating new exception types. The following list outlines all available exception types (with indentation indicating exception type hierarchy):

- `AzureException`: Never use directly. Throw a more specific subtype.
  - `ServiceRequestException`: Thrown for an invalid response with custom error information.
    - `ReadTimeoutException`: Thrown when the server didn't send any data in the allotted amount of time.
    - `ConnectException`: Thrown by the pipeline if a connection to a service fails or is refused remotely.
    - `HttpRequestException`: Thrown when an unsuccessful response (4xx, 5xx) is returned from the service.
      - `ServerException`: Thrown when there's a server error with status code of 5XX.
      - `TooManyRedirectsException`: Thrown when an HTTP request has reached the maximum number of redirect attempts.
      - `ClientRequestException`: Thrown when there's an invalid client request with status code of 4XX.
        - `ClientAuthenticationException`: Thrown when there's a failure to authenticate against the service.
        - `ResourceExistsException`: Thrown when an HTTP request tried to create an already existing resource.
        - `ResourceModifiedException`: Thrown for invalid resource modification with status code of 4XX, typically 412 Conflict.
        - `ResourceNotFoundException`: Thrown when a resource is not found, typically triggered by a 412 response (for PUT) or 404 (for GET/POST).
  - `ServiceResponseException`: Thrown when the request was sent to the service, but the client library wasn't able to understand the response.
    - `DecodeException`: Thrown when there's an error during response deserialization.

## Logging

Client libraries must support robust logging mechanisms so that the consumer can adequately diagnose issues with the method calls and quickly determine whether the issue is in the consumer code, client library code, or service.

{% include requirement/MUST id="android-logging-clientlogger" %} use the `ClientLogger` API provided within Azure Core as the sole logging API throughout all client libraries. Internally, `ClientLogger` logs to the ADB console.

{% include requirement/MUST id="android-logging-create-new" %} create a new instance of a `ClientLogger` per instance of all relevant classes. For example, the code below will create a `ClientLogger` instance for the `ConfigurationAsyncClient`:

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

Don't create static logger instances. Static logger instances are shared among all client library instances running in a JVM instance.

{% include requirement/MUST id="android-logging-levels" %} use one of the following log levels when emitting logs: `Logger.trace` (details), `Logger.info` (things happened), `Logger.warn` (might be a problem or not), and `Logger.error`.

{% include requirement/MUST id="android-logging-errors" %} use the `Logger.error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="android-logging-warn" %} use the `Logger.warn` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception.  Do not include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MUST id="android-logging-info" %} use the `Logger.info` logging level when a function operates normally.

{% include requirement/MUST id="android-logging-trace" %} use the `Logger.trace` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUSTNOT id="android-logging-sensitive-info" %} send sensitive information in log levels other than `Logger.trace`. For example, remove account keys when logging headers.

{% include requirement/MUST id="android-logging-request" %} log request line, response line, and headers, as a `Logger.info` message.

{% include requirement/MUST id="android-logging-cancellation" %} use `Logger.info` if a service call is cancelled.

{% include requirement/MUST id="android-logging-throws" %} throw all exceptions created within the client library code through the `ClientLogger.logAndThrow()` API.

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

## Distributed tracing

Distributed tracing mechanisms allow the consumer to trace their code from frontend to backend.  The distributed tracing library creates spans - units of unique work.  Each span is in a parent-child relationship.  As you go deeper into the hierarchy of code, you create more spans.  These spans can then be exported to a suitable receiver as needed.  To keep track of the spans, a _distributed tracing context_ (called a context in the remainder of this section) is passed into each successive layer.  For more information on this topic, visit the [OpenTelemetry] topic on tracing.

The Azure core library provides a service provider interface (SPI) for adding pipeline policies at runtime. The pipeline policy is used to enable tracing on consumer deployments. Pluggable pipeline policies must be supported in all client libraries to enable distributed tracing. Additional metadata can be specified on a per-service-method basis to provide a richer tracing experience for consumers.

{% include requirement/MUST id="android-tracing-pluggable" %} support pluggable pipeline policies as part of the HTTP pipeline instantiation.

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

{% include requirement/MUST id="android-tracing-accept-context" %} accept a context from calling code to establish a parent span.

{% include requirement/MUST id="android-tracing-pass-context" %} pass the context to the backend service through the appropriate headers (`traceparent`, `tracestate`, etc.) to support [Azure Monitor].  This is generally done with the HTTP pipeline.

{% include requirement/MUST id="android-tracing-new-span-per-method" %} create a new span for each method that user code calls.  New spans must be children of the context that was passed in.  If no context was passed in, a new root span must be created.

{% include requirement/MUST id="android-tracing-new-span-per-rest-call" %} create a new span (which must be a child of the per-method span) for each REST call that the client library makes.  This is generally done with the HTTP pipeline.

{%include requirement/MUST id="android-tracing-use-tracerproxy" %} use the Azure core `TracerProxy` API to set additional metadata that should be supplied along with the tracing span. In particular, use the `setAttribute(String key, String value, Context context)` method to set a new key/value pair on the tracing context.

Some of these requirements will be handled by the HTTP pipeline.  However, as a client library writer, you must handle the incoming context appropriately.

## Dependencies

Dependencies bring in many considerations that are often easily avoided by avoiding the dependency.

- **Versioning** - Many programming languages do not allow a consumer to load multiple versions of the same package. So, if we have an client library that requires v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot build their application. This means that client libraries should not have dependencies by default.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="android-dependencies-azure-core" %} depend on the Android `com.azure.core` library for functionality that is common across all client libraries.  This library includes APIs for HTTP connectivity, global configuration, logging, and credential handling.

{% include requirement/MUSTNOT id="android-dependencies-approved" %} be dependent on any other packages within the client library distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

{% include requirement/MUSTNOT id="android-dependencies-introduction" %} introduce new dependencies on third-party libraries that are already referenced from the parent POM, without first discussing with the [Architecture Board].

{% include requirement/MUSTNOT id="android-dependencies-pom" %} specify or change dependency versions in your client library POM file. All dependency versioning must be centralized through the common parent POM.

{% include requirement/MUSTNOT id="android-dependencies-snapshot" %} include dependencies on external libraries that are -SNAPSHOT versions. All dependencies must be released versions.

{% include requirement/SHOULD id="android-dependencies-vendoring" %} consider copying or linking required code into the client library in order to avoid taking a dependency on another package that could conflict with the ecosystem. Make sure that you are not violating any licensing agreements and consider the maintenance that will be required of the duplicated code. ["A little copying is better than a little dependency"][1] (YouTube).

{% include requirement/MUSTNOT id="android-dependencies-concrete" %} depend on concrete logging, dependency injection, or configuration technologies (except as implemented in the `com.azure.core` library).  The client library will be used in applications that might be using the logging, DI, and configuration technologies of their choice.

## Service-specific common library code

There are occasions when common code needs to be shared between several client libraries. For example, a set of cooperating client libraries may wish to share a set of exceptions or models.

{% include requirement/MUST id="android-commonlib-archboard" %} gain [Architecture Board] approval prior to implementing a common library.

{% include requirement/MUST id="android-commonlib-minimize-code" %} minimize the code within a common library. Code within the common library is available to the consumer of the client library and shared by multiple client libraries within the same namespace.

{% include requirement/MUST id="android-commonlib-namespace" %} store the common library in the same namespace as the associated client libraries.

A common library will only be approved if:

* The consumer of the non-shared library will consume the objects within the common library directly, AND
* The information will be shared between multiple client libraries.

Let's take two examples:

1. Implementing two Cognitive Services client libraries, we find a model is required that is produced by one Cognitive Services client library and consumed by another Coginitive Services client library, or the same model is produced by two client libraries. The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client library vs. that produced by another client library. This is a good candidate for choosing a common library.

2. Two Cognitive Services client libraries throw an `ObjectNotFound` exception to indicate that an object was not detected in an image. The user might trap the exception, but otherwise will not operate on the exception. There is no linkage between the `ObjectNotFound` exception in each client library. This is not a good candidate for creation of a common library (although you may wish to place this exception in a common library if one exists for the namespace already). Instead, produce two different exceptions - one in each client library.

## Testing

One of the key things we want to support is to allow consumers of the library to easily write repeatable unit-tests for their applications without activating a service. This allows them to reliable and quickly test their code without worrying about the vagaries of the underlying service implementation (including, for example, network conditions or service outages). Mocking is also helpful to simulate failures, edge cases, and hard to reproduce situations (for example: does code work on February 29th).

{% include requirement/MUST id="android-testing-mocking" %} support mocking of network operations.

{% include refs.md %}
{% include_relative refs.md %}