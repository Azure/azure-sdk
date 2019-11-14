---
title: "General Guidelines: Azure Core"
keywords: guidelines
permalink: general_azurecore.html
folder: general
sidebar: general_sidebar
---

Azure Core is a library that provides cross-cutting services to other client libraries.  These services include:

* The HTTP pipeline
* Global configuration
* Credentials

The following sections define the requirements for the Azure Core library.  If you are implementing a client library in a language that already has an Azure Core library, you do not need to read this section.  It is primarily targeted at developers who work on the Azure Core library.

## The HTTP pipeline

The HTTP pipeline consists of a HTTP transport that is wrapped by multiple policies.  Each policy is a control point during which the pipeline can modify either the request and/or response.  We use a default set of policies to standardize how client libraries interact with Azure services.

- Telemetry
- Unique request ID
- Retry
- Authentication
- Response downloader
- Distributed tracing
- Logging
- Proxy

In general, the client library will only need to configure these policies.  However, if you are producing a new Azure Core library (for a new language), you will need to understand the requirements for each policy.

### Telemetry policy

Client library usage telemetry is used by service teams (not consumers) to monitor what SDK language, client library version, and language/platform info a client is using to call into their service. Clients can prepend additional information indicating the name and version of the client application.

{% include requirement/MUST id="azurecore-http-telemetry-useragent" %} send telemetry information in the [User-Agent header] using the following format:

```
[<application_id> ]azsdk-<sdk_language>-<package_name>/<package_version> <platform_info>
```

- `<application_id>`: optional application-specific string. May contain a slash, but must not contain a space. The string is supplied by the user of the client library, e.g. "AzCopy/10.0.4-Preview"
- `<sdk_language>`: SDK's language name (all lowercase): "net", "python", "java", or "js"
- `<package_name>`: client library package name as it appears to the developer, replacing slashes with dashes and removing the Azure indicator.  For example, "Security.KeyVault" (.NET), "security.keyvault" (Java), "keyvault" (JavaScript & Python)
- `<package_version>`: the version of the package. Note: this is not the version of the service
- `<platform_info>`: information about the currently executing language runtime and OS, e.g. "(NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"

For example, if we re-wrote `AzCopy` in each language using the Azure Blob Storage client library, we may end up with the following user-agent strings:

- (.NET) `AzCopy/10.0.4-Preview azsdk-net-Storage.Blobs/11.0.0 (.NET Standard 2.0; Windows_NT 10.0.14393)`
- (JavaScript) `AzCopy/10.0.4-Preview azsdk-js-storage-blob/11.0.0 (Node 10.16.0; Ubuntu; Linux x86_64; rv:34.0)`
- (Java) `AzCopy/10.0.4-Preview azsdk-java-storage.blobs/11.0.0 (Java/1.8.0_45; Macintosh; Intel Mac OS X 10_10; rv:33.0)`
- (Python) `AzCopy/10.0.4-Preview azsdk-python-storage/4.0.0 Python/3.7.3 (Ubuntu; Linux x86_64; rv:34.0)`

{% include requirement/MUST id="azurecore-http-telemetry-appid" %} allow the consumer of the library to set the application ID.  This allows the consumer to obtain cross-service telemetry for their app.  The application ID should be settable in the relevant `ClientOptions` object.

{% include requirement/MUST id="azurecore-http-telemetry-appid-length" %} enforce that the application ID is no more than 24 characters in length.  Shorter application IDs allows service teams to include diagnostic information in the "platform information" section of the user agent, while still allowing the consumer to obtain telemetry information for their own application.

{% include requirement/SHOULD id="azurecore-http-telemetry-x-ms-useragent" %} send telemetry information that is normally sent in the `User-Agent` header in the `X-MS-UserAgent` header when the platform does not support changing the `User-Agent` header.  Note that services will need to configure log gathering to capture the `X-MS-UserAgent` header in such a way that it can be queried through normal analytics systems.

{% include requirement/SHOULD id="azurecore-http-telemetry-dynamic" %} send additional (dynamic) telemetry information as a semi-colon separated set of key-value types in the `X-MS-AZSDK-Telemetry` header.  For example:

```http
X-MS-AZSDK-Telemetry: class=BlobClient;method=DownloadFile;blobType=Block
```

The content of the header is a semi-colon key=value list.  The following keys have specific meaning:

* `class` is the name of the type within the client library that the consumer called to trigger the network operation.
* `method` is the name of the method within the client library type that the consumer called to trigger the network operation.

Any other keys that are used should be common across all client libraries for a specific service.  **DO NOT** include personally identifiable information (even encoded) in this header.  Services need to configure log gathering to capture the `X-MS-SDK-Telemetry` header in such a way that it can be queried through normal analytics systems.

### Unique request ID policy

> **TODO** Add Unique Request ID Policy Requirements

### Retry policy

There are many reasons why failure can occur when a client application attempts to send a network request to a service. Some examples are timeout, network infrastructure failures, service rejecting the request due to throttle/busy, service instance terminating due to service scale-down, service instance going down to be replaced with another version, service crashing due to an unhandled exception, etc. By offering a built-in retry mechanism (with a default configuration the consumer can override), our SDKs and the consumer's application become resilient to these kinds of failures. Note that some services charge real money for each try and so consumers should be able to disable retries entirely if they prefer to save money over resiliency.

For more information, see [Transient fault handling].

The HTTP Pipeline provides this functionality.

{% include requirement/MUST id="azurecore-http-retry-options" %} offer the following configuration settings:

- Retry policy type (exponential or fixed)
- Maximum number of retries
- Delay between retries (timespan/duration; this is the delay for fixed policy, the delay is increased exponentially by this amount for the exponential policy)
- Maximum retry delay (timespan/duration)
- List of HTTP status codes that would cause a retry (default is "all service errors that are retryable")

{% include requirement/MAY id="azurecore-http-retry-mechanisms" %} offer additional retry mechanisms if supported by the service.  For example, the Azure Storage Blob service supports retrying read operations against a secondary datacenter, or recommends the use of a per-try timeout for resilience.

{% include requirement/MUST id="azurecore-http-retry-reset-data-stream" %} reset (or seek back to position 0) any request data stream before retrying a request

{% include requirement/MUST id="azurecore-http-retry-honor-cancellation" %} honor any cancellation mechanism passed in to the caller which can terminate the request before retries have been attempted.

{% include requirement/MUST id="azurecore-http-retry-update-queryparams" %} update any query parameter or request header that gets sent to the service telling it how much time the service has to process the individual request attempt.

{% include requirement/MUST id="azurecore-http-retry-hardware-failure" %} retry in the case of a hardware network failure as it may self-correct.

{% include requirement/MUST id="azurecore-http-retry-service-not-found" %} retry in the case of a "service not found" error. The service may be coming back online or a load balancer may be reconfiguring itself.

{% include requirement/MUST id="azurecore-http-retry-throttling" %} retry if the service successfully responds indicating that it is throttling requests (for example, with an "x-ms-delay-until" header or similar metadata).

{% include requirement/MUSTNOT id="azurecore-http-retry-after" %} retry if the service responds with a 400-level response code unless a retry-after header is also returned.

{% include requirement/MUSTNOT id="azurecore-http-retry-requestid" %} change any client-side generated request-id when retrying the request. Th request ID represents the logical operation and should be the same across all physical retries of this operation.  When looking at server logs, multiple entries with the same client request ID show each retry

{% include requirement/SHOULD id="azurecore-http-retry-defaults" %} implement a default policy that starts at 3 retries with a 0.8s delay with exponential (plus jitter) backoff.

### Authentication policy

Services across Azure use a variety of different authentication schemes to authenticate clients. Conceptually there are two entities responsible for authenticating service client requests, a credential and an authentication policy.  Credentials provide confidential authentication data needed to authenticate requests.  Authentication policies use the data provided by a credential to authenticate requests to the service. It is essential that credential data can be updated as needed across the lifetime of a client, and authentication policies must always use the most current credential data.

{% include requirement/MUSTNOT id="azurecore-http-auth-persistence" %} persist, cache, or reuse tokens returned from the token credential. This is __CRITICAL__ as credentials generally have a short validity period and the token credential is
responsible for refreshing these.

{% include requirement/MUST id="azurecore-http-auth-bearer-token" %} implement Bearer authorization policy (which accepts a token credential and
scope).

### Response downloader policy

The response downloader is required for most (but not all) operations to change whatever is returned by the service into a model that the consumer code can use.  An example of a method that does not deserialize the response payload is a method that downloads a raw blob within the Blob Storage client library.  In this case, the raw data bytes are required.  For most operations, the body must be downloaded in totality before deserialization. This pipeline policy must implement the following requirements:

{% include requirement/MUST id="azurecore-http-response-body" %} download the entire response body and pass the complete downloaded body up to the operation method for methods that deserialize the response payload.  If a network connection fails while reading the body, the retry policy must automatically retry the operation.

### Distributed tracing policy

Distributed tracing allows the consumer to trace their code from frontend to backend.  The distributed tracing library creates spans (units of unique work) to facilitate tracing.  Each span is in a parent-child relationship.  As you go deeper into the hierarchy of code, you create more spans.  These spans can then be exported to a suitable receiver as needed.  To keep track of the spans, a _distributed tracing context_ (called a context within the rest of this section) is passed into each successive layer.  For more information on this topic, visit the [OpenTelemetry]topic on tracing.

The Distributed Tracing policy is responsible for:

* Creating a SPAN per REST call.
* Passing the context to the backend service.

> There is also a distributed tracing topic for implementing a client library.

{% include requirement/MUST id="azurecore-http-tracing-opentelemetry" %} support [OpenTelemetry] for distributed tracing.

{% include requirement/MUST id="azurecore-http-tracing-accept-context" %} accept a context from calling code to establish a parent span.

{% include requirement/MUST id="azurecore-http-tracing-pass-context" %} pass the context to the backend service through the appropriate headers (`traceparent`, `tracestate`, etc.) to support [Azure Monitor].

{% include requirement/MUST id="azurecore-http-tracing-create-span" %} create a new span (which must be a child of the per-method span) for each REST call that the client library makes.

### Logging policy

Many logging requirements within Azure Core mirror the same requirements for logging within the client library.

{% include requirement/MUST id="azurecore-http-logging-handlers" %} allow the client library to set the log handler and log settings.

{% include requirement/MUST id="azurecore-http-logging-levels" %} use one of the following log levels when emitting logs: `Verbose` (details), `Informational` (things happened), `Warning` (might be a problem or not), and `Error`.

{% include requirement/MUST id="azurecore-http-logging-error" %} use the `Error` logging level for failures that the application is unlikely to recover from (out of memory, etc.).

{% include requirement/MUST id="azurecore-http-logging-warning" %} use the `Warning` logging level when a function fails to perform its intended task. This generally means that the function will raise an exception. Don't include occurrences of self-healing events (for example, when a request will be automatically retried).

{% include requirement/MUST id="azurecore-http-logging-info" %} use the `Informational` logging level when a function operates normally.

{% include requirement/MUST id="azurecore-http-logging-verbose" %} use the `Verbose` logging level for detailed troubleshooting scenarios. This is primarily intended for developers or system administrators to diagnose specific failures.

{% include requirement/MUSTNOT id="azurecore-http-logging-sensitive-info" %} send sensitive information in log levels other than `Verbose`. For example, remove account keys when logging headers.

{% include requirement/MUST id="azurecore-http-logging-request-line" %} log request line, response line, and headers as an `Informational` message.

{% include requirement/MUST id="azurecore-http-logging-cancellation" %} log an `Informational` message if a service call is cancelled.

{% include requirement/MUST id="azurecore-http-logging-exceptions" %} log exceptions thrown as a `Warning` level message. If the log level set to `Verbose`, append stack trace information to the message.

{% include requirement/MUST id="azurecore-http-logging-configuration" %} include information about relevant configuration when the HTTP pipeline throws an error if there is a relevant configuration setting that would alleviate the problem.  Not all errors can be fixed with a configuration change.

### Proxy policy

Apps that integrate the Azure SDK need to operate in common enterprises.  It is a common practice to implement HTTP proxies for control and caching purposes.  Proxies are generally configured at the machine level and, as such, are part of the environment.  However, there are reasons to adjust proxies (for example, testing may use a proxy to rewrite URLs to a test environment instead of a production environment).  The Azure SDK and all client libraries should operate in those environments.

There are a number of common methods for proxy configuration.  However, they fall into four groups:

1. Inline, no authentication (filtering only)
2. Inline, with authentication
3. Out-of-band, no authentication
4. Out of band, with authentication

For inline/no-auth proxy, nothing needs to be done.  The Azure SDK will work without any proxy configuration.  For inline/auth proxy, the connection may receive a `407 Proxy Authentication Required` status code.  This will include a scheme, realm, and potentially other information (such as a `nonce` for digest authentication).  The client library must resubmit the request with a `Proxy-Authorization` header that provides authentication information suitably encoded for the scheme.  The most common schemes are Basic, Digest, and NTLM.

For an out-of-band/no-auth proxy, the client will send the entire request URL to the proxy instead of the service.  For example, if the client is communicating to `https://foo.blob.storage.azure.net/path/to/blob`, it will connect to the `HTTPS_PROXY` and send a `GET https://foo.blob.storage.azure.net/path/to/blob HTTP/1.1`.   For an out-of-band/auth proxy, the client will send the entire request URL just as in the out-of-band/no-auth proxy version, but it may send back a `407 Proxy Authentication Required` status code (as with the inline/auth proxy).

WebSockets can normally be tunneled through an HTTP proxy, in which case the proxy authentication happens during the CONNECT call.  This is the preferred mechanism for tunneling non-HTTP traffic to the Azure service.  However, there are other types of proxies.  The most notable is the SOCKS proxy used for non-HTTP traffic (such as AMQP or MQTT).  We make no recommendation (for or against) support of SOCKS.  It is explicitly not a requirement to support SOCKS proxy within the client library.

Most proxy configuration will be done by adopting the HTTP pipeline that is common to all Azure service client libraries.

{% include requirement/MUST id="azurecore-http-proxy-global-config" %} support proxy configuration via common global configuration directives configured on a platform or runtime basis.

- Linux and macOS generally use the `HTTPS_PROXY` (and associated) environment variables to configure proxies.
- Windows environments generally use the WinHTTP proxy configuration to configure proxies.
- Other options (such as loading from configuration files) may exist on a platform and runtime basis.

{% include requirement/MUST id="azurecore-http-proxy-azure-sdk-config" %} support Azure SDK-wide configuration directives for proxy configuration, including disabling the proxy functionality.

{% include requirement/MUST id="azurecore-http-proxy-client-config" %} support client library-specific configuration directives for proxy configuration, including disabling the proxy functionality.

{% include requirement/MUST id="azurecore-http-proxy-logging" %} log `407 Proxy Authentication Required` requests and responses.

{% include requirement/MUST id="azurecore-http-proxy-always-log" %} indicate in logging if the request is being sent to the service via a proxy, even if proxy authentication is not required.

{% include requirement/MUST id="azurecore-http-proxy-support" %} support Basic and Digest authentication schemes.

{% include requirement/SHOULD id="azurecore-http-proxy-ntlm-support" %} support the NTLM authentication scheme.

There is no requirement to support SOCKS at this time.  We recommend services adopt a WebSocket connectivity option (for example, AMQP or MQTT over WebSockets) to ensure compatibility with proxies.

## Global configuration

The Azure SDK can be configured by a variety of sources, some of which are necessarily language-dependent.  This will generally be codified in the Azure Core library.  The configuration sources include:

1. System settings
2. Environment variables
3. Global configuration store (code)
4. Runtime parameters

{% include requirement/MUST id="azurecore-config-ordering" %} apply configuration in the order above by default, such that subsequent items in the list override settings from previous items in the list.

{% include requirement/MAY id="azurecore-config-opt-in" %} support configuration systems that users opt in to that do not follow the above ordering.

{% include requirement/MUST id="azurecore-config-consistent-naming" %} be consistent with naming between environment variables and configuration keys.

{% include requirement/MUST id="azurecore-config-log-config-settings" %} log when a configuration setting is found somewhere in the environment or global configuration store.

{% include requirement/MAY id="azurecore-config-ignore-irrelevant-config" %} ignore configuration settings that are irrelevant for your client library.

### System settings

{% include requirement/SHOULD id="azurecore-config-respect-the-system" %} respect system settings for proxies.

### Environment variables

Environment variables are a well-known method for IT administrators to configure basic settings when running code in the cloud.

{% include requirement/MUST id="azurecore-config-envvars-system-list" %}  load relevant configuration settings from the environment variables listed in the table below:

{% include tables/environment_variables.md %}

{% include requirement/MUST id="azurecore-config-envvars-azure-prefix" %} prefix Azure-specific environment variables with `AZURE_`.

{% include requirement/MUST id="azurecore-config-envvars-no-proxy-cidr" %} support [CIDR notation] for `NO_PROXY`.

### Global configuration

Global configuration refers to configuration settings that are applied to all applicable client constructors in some manner.

{% include requirement/MUST id="azurecore-config-shared-pipeline-policies" %} support global configuration of shared pipeline policies including:

* Logging: Log level, swapping out logger implementation
* HTTP: Proxy settings, max retries, timeout, swapping out transport implementation
* Telemetry: enabled/disabled
* Tracing: enabled/disabled

{% include requirement/MUST id="azurecore-config-override-global-config" %} provide configuration keys for setting or overriding every configuration setting inherited from the system or environment variables.

{% include requirement/MUST id="azurecore-config-opt-out" %} provide a method of opting out from importing system settings and environment variables into the configuration.

## Authentication and credentials

OAuth token authentication, obtained via Managed Security Identities (MSI) or Azure Identity is the preferred mechanism for authenticating service requests, and the only authentication credentials supported by the Azure Core library.

{% include requirement/MUST id="azurecore-auth-token-credential" %} provide a token credential type that can fetch an OAuth-compatible token needed to authenticate a request to the service in a non-blocking atomic manner.

{% include refs.md %}

[User-Agent header]: https://tools.ietf.org/html/rfc7231#section-5.5.3
[Transient fault handling]: https://docs.microsoft.com/en-us/azure/architecture/best-practices/transient-faults
[OpenTelemetry]: https://opentelemetry.io/
[Azure Monitor]: https://azure.microsoft.com/services/monitor/
[CIDR notation]: https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing