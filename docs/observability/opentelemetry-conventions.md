---
title: "OpenTelemetry Semantic Conventions for Azure Client Libraries"
permalink: opentelemetry_conventions.html
keywords: opentelemetry conventions
folder: general
sidebar: general_sidebar
---

Semantic conventions are the contract between Azure client libraries and tracing providers such as
Azure Monitor, Jaeger, and others. They describe and standardize spans, events, metrics, and their attributes
for common span types: HTTP, DB, messaging and others.

Observability vendors use conventions to build visualizations and may be very
sensitive to them.

Custom Azure client library conventions are described in [Azure client library semantic conventions](#azure-client-library-semantic-conventions)
section below.

When writing instrumentation in Azure client libraries or Core:

Follow [distributed tracing implementation policy][distributed tracing policy].

{% include requirement/MUST id="general-semantic-convention-use-otel" %} use applicable [OpenTelemetry](https://opentelemetry.io/docs/specs/semconv/) or [Azure client library](#azure-client-library-semantic-conventions) semantic conventions whenever possible. Conventions SHOULD be applied at the span, metric, or event level. Individual attributes
from OpenTelemetry SHOULD NOT be used in isolation - only include them when they are explicitly referenced in a span, metric, or event definition. For example, OpenTelemetry defines `cloud.resource_id` attribute, which could apply broadly across Azure client libraries. However, it SHOULD NOT be added to Azure client library spans unless the corresponding span (or metric or event) definition includes it.

{% include requirement/MUST id="general-semantic-convention-describe-attributes" %} update [Azure client library semantic conventions](#azure-client-library-semantic-conventions) when adding new Azure-specific attributes.

{% include requirement/MUST id="general-semantic-convention-attribute-naming" %} follow [OpenTelemetry attribute naming conventions](https://opentelemetry.io/docs/specs/semconv/general/how-to-define-semantic-conventions/) and use the `azure.{service-family}.` prefix when adding new Azure-specific attributes.

> [!NOTE]
> Azure Semantic Conventions defined here include a deprecated set of `az.*` attributes, which was renamed to `azure.*` in OpenTelemetry to
> align with the [naming policy](https://opentelemetry.io/docs/specs/semconv/general/naming/#choosing-a-system-name).
> Azure client libraries and core implementations SHOULD NOT use the new `azure.*` attributes at least until these new attributes reach stability
> and then MAY start adopting them in new code if and only if it is possible without breaking backward compatibility.

{% include requirement/SHOULD id="general-semantic-convention-set-library-info" %} set Azure Client Library name, version, and [Schema URL](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer) when [creating OpenTelemetry tracer](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer), meter, or logger. Library name SHOULD be the language-specific fully qualified artifact name and the version SHOULD be the version of this artifact.

{% include requirement/SHOULD id="general-semantic-convention-new-otel" %} contribute new conventions (or patch existing ones) to OpenTelemetry when there is no suitable one or some scenarios are missing.

# Azure client library semantic conventions

Azure client libraries support distributed tracing with OpenTelemetry. Some client libraries support
OpenTelemetry metrics and logging.

## Semantic conventions for Azure client library spans

**Status**: [Mixed][DocumentStatus]

This document describes tracing semantic conventions adopted by Azure client libraries.
Azure client libraries are instrumented natively (or via a plugin), so the instrumentation code
is a part of each library. Depending on the language, users may need to
install a plugin to enable collection with OpenTelemetry. Check out tracing
documentation for your language to get more details.

- [Java](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/core/azure-core-tracing-opentelemetry)
- [JavaScript](https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/core/core-tracing)
- [Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/core/azure-core-tracing-opentelemetry)
- [.NET](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/samples/Diagnostics.md#activitysource-support)
- [Go](https://github.com/Azure/azure-sdk-for-go/blob/main/sdk/tracing/azotel)
- [C++](https://github.com/Azure/azure-sdk-for-cpp/tree/main/sdk/core/azure-core-tracing-opentelemetry)
- [Rust](https://github.com/Azure/azure-sdk-for-rust/tree/main/sdk/core/azure_core_opentelemetry)

The Azure client libraries produce spans for public API calls and nested HTTP client spans.
AMQP and other transport-level calls are not traced.

This section describes generic conventions for client libraries that don't have
additional conventions established in OpenTelemetry.

In cases where OpenTelemetry defines a semantic convention for a specific technology
(e.g. databases, generative AI, or messaging), the standard OpenTelemetry conventions
SHOULD be used instead.

See [Azure Messaging](https://opentelemetry.io/docs/specs/semconv/messaging/azure-messaging/),
[Azure CosmosDB conventions](https://opentelemetry.io/docs/specs/semconv/database/cosmosdb/),
[Azure AI Inference](https://opentelemetry.io/docs/specs/semconv/gen-ai/azure-ai-inference/)
for details.

## Versioning

Azure client libraries follow OpenTelemetry semantic conventions versioning when applicable,
but adopt new versions of conventions at their own pace.

Azure client libraries SHOULD depend on stable attributes and conventions
and SHOULD NOT introduce breaking changes to the end users.

For example, when OpenTelemetry introduces `azure.resource_provider.namespace` attribute
and deprecates `az.namespace`, Azure client libraries that use the latter
should continue using it in the current major version despite it being deprecated.

Once `azure.resource_provider.namespace` becomes stable in OpenTelemetry conventions,
new Azure client libraries (and core implementations) MAY start leveraging the
new attribute in new code.

Client libraries SHOULD populate [SchemaURL](https://opentelemetry.io/docs/specs/otel/schemas/#schema-url)
to record the version of semantic conventions being emitted.

## Public API calls

<!-- semconv azure.sdk.api -->
<!-- NOTE: THIS TEXT IS AUTOGENERATED. DO NOT EDIT BY HAND. -->
<!-- see templates/registry/markdown/snippet.md.j2 -->
<!-- prettier-ignore-start -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->

**Status:** ![Stable](https://img.shields.io/badge/-stable-lightgreen)

Describes Azure client library service method call - a public API that involves communication with Azure services.

In cases where OpenTelemetry defines semantic convention for a given area
(for example, messaging, database or GenAI), the standard OpenTelemetry
name SHOULD be used instead of the generic ones defined in this section.

**Span name** SHOULD match the `{Namespace}.{Interface}.{OperationName}` pattern
following the corresponding operation definition in TypeSpec. When an interface
is not defined, the name SHOULD be `{Namespace}.{MethodName}`. This pattern matches
the operation's `crossLanguageDefinitionId` in the generated TypeSpec code model.

The span name SHOULD be consistent across all languages.

> [!NOTE]
>
> The previous version of this document recommended using the
> `{client.method}` pattern for span names matching language-specific
> public API called by the application code.
>
> This recommendation is now deprecated in favor of the `{Namespace}.{Interface}.{OperationName}`
> pattern.
> Azure code generators and client libraries SHOULD use the new pattern
> as long as it does not introduce breaking changes to existing stable libraries
> and SHOULD use the old pattern only for backward compatibility.

**Span kind** SHOULD be `INTERNAL`.

**Span status:** MUST be left unset if the API call was successful.
If the API call failed with an error or exception, span status SHOULD be set to `Error`.

Span status description SHOULD be set to the error or exception message.

Refer to the [Recording Errors](https://github.com/open-telemetry/semantic-conventions/blob/main/docs/general/recording-errors.md)
document for general considerations on how to record span status.

Azure client libraries SHOULD NOT record exceptions on spans and SHOULD record them using logging.

When a client method creates a new span and internally calls into other public client methods of
the same or different Azure client library, spans created for inner client methods are suppressed by
Azure Core implementation. See [Distributed tracing policy] for the details.

**Span duration:** SHOULD cover the full duration of the method call and, when possible,
SHOULD include input argument validation and (de)serialization of the request and response.

| Attribute  | Type | Description  | Examples  | [Requirement Level](https://opentelemetry.io/docs/specs/semconv/general/attribute-requirement-level/) | Stability |
|---|---|---|---|---|---|
| [`az.schema_url`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/azure.md) | string | OpenTelemetry Schema URL including schema version [1] | `https://opentelemetry.io/schemas/1.23.0` | `Conditionally Required` [2] | ![Deprecated](https://img.shields.io/badge/-deprecated-red)<br>Obsoleted. |
| [`error.type`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/error.md) | string | Describes a class of error the operation ended with. [3] | `java.net.UnknownHostException`; `System.Threading.Tasks.OperationCanceledException`; `azure.core.exceptions.ServiceRequestError` | `Conditionally Required` if and only if an error occurred. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`az.namespace`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/azure.md) | string | The [Azure Resource Provider Namespace](https://learn.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers) for the service being called. For example, `Microsoft.Storage` for Azure Storage. [4] | `Microsoft.Storage`; `Microsoft.KeyVault`; `Microsoft.ServiceBus` | `Recommended` | ![Deprecated](https://img.shields.io/badge/-deprecated-red)<br>Replaced by `azure.resource_provider.namespace`. |

**[1] `az.schema_url`:** This attribute is deprecated in favor of a SchemaURL argument provided when creating OpenTelemetry tracers or meters.
Azure client libraries and core implementations that populate it, SHOULD keep populating it for backward compatibility, but it is NOT RECOMMENDED to use it in new code.
The attribute MAY also be populated when using non-OpenTelemetry tracing or metrics implementations that do not support setting SchemaURL as a dedicated argument.

**[2] `az.schema_url`:** if and only if OpenTelemetry in a given language doesn't provide a standard way to set `SchemaURL` (.NET)

**[3] `error.type`:** This attribute SHOULD be set if an error occurred during the API call and
the method returns an error or throws an exception.

If Azure service defines a set of error types, it is RECOMMENDED to use
the service-defined fully qualified service error type as the value of
this attribute.

When there is no service-defined error type, it is RECOMMENDED to use
the fully qualified type of the exception or error thrown by the client library.

**[4] `az.namespace`:** This attribute is deprecated in favor of `azure.resource_provider.namespace`, but it is still RECOMMENDED to be used until `azure.resource_provider.namespace` becomes stable in the OpenTelemetry Semantic Conventions.

---

`error.type` has the following list of well-known values. If one of them applies, then the respective value MUST be used; otherwise, a custom value MAY be used.

| Value  | Description | Stability |
|---|---|---|
| `_OTHER` | A fallback error value to be used when the instrumentation doesn't define a custom value. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- END AUTOGENERATED TEXT -->
<!-- endsemconv -->

## HTTP client spans

Azure client libraries implement a valid subset of the stable part of [OpenTelemetry HTTP spans conventions](https://github.com/open-telemetry/semantic-conventions/blob/main/docs/http/http-spans.md).

HTTP policy SHOULD propagate [W3C Trace context](https://w3c.github.io/trace-context/)
along with service-specific `x-ms-request*` headers.
Custom propagation formats are not currently supported.

<!-- semconv azure.sdk.http -->
<!-- NOTE: THIS TEXT IS AUTOGENERATED. DO NOT EDIT BY HAND. -->
<!-- see templates/registry/markdown/snippet.md.j2 -->
<!-- prettier-ignore-start -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable -->

**Status:** ![Stable](https://img.shields.io/badge/-stable-lightgreen)

This span represents an outbound HTTP request. Azure client libraries implement a valid subset of [OpenTelemetry HTTP client span conventions](https://github.com/open-telemetry/semantic-conventions/blob/main/docs/http/http-spans.md).

The instrumentations SHOULD create an HTTP span for each attempt and redirect
when sending an HTTP request over the wire.

**Span name:** SHOULD be {http.request.method}.

**Span kind** MUST be `CLIENT`.

**Span status:** MUST be left unset if HTTP status code was in the 1xx, 2xx or
3xx ranges, unless there was another error (e.g., network error receiving the
response body; or 3xx codes with max redirects exceeded), in which case status
MUST be set to `Error`.

For HTTP status codes in the 4xx or 5xx range as well as any other code the
client failed to interpret, span status SHOULD be set to `Error`.

> [!Note]
> The classification of an HTTP status code as an error depends on the context.
> For example, a 404 "Not Found" status code indicates an error if the application
> expected the resource to be available. However, it is not an error when
> the application is simply checking whether the resource exists.
>
> Instrumentations that have additional context about a specific request MAY
> use this context to set the span status more precisely.
> Instrumentations that don't have any additional context MUST follow the
> guidelines in this section.

Don't set the span status description if the reason can be inferred from
`http.response.status_code`.

An HTTP request may fail if it was cancelled or an error occurred preventing
the client or server from sending/receiving the request/response fully.

When an instrumentation detects such errors it SHOULD set span status to `Error`
and SHOULD set the `error.type` attribute.

Azure client libraries SHOULD NOT record exceptions on spans and SHOULD record
them in logging.

| Attribute  | Type | Description  | Examples  | [Requirement Level](https://opentelemetry.io/docs/specs/semconv/general/attribute-requirement-level/) | Stability |
|---|---|---|---|---|---|
| [`http.request.method`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/http.md) | string | HTTP request method. [1] | `GET`; `POST`; `HEAD` | `Required` | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`server.address`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/server.md) | string | Server domain name if available without reverse DNS lookup; otherwise, IP address or Unix domain socket name. [2] | `example.com`; `10.1.2.80`; `/tmp/my.sock` | `Required` | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`url.full`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/url.md) | string | Absolute URL describing a network resource according to [RFC3986](https://www.rfc-editor.org/rfc/rfc3986) [3] | `https://www.foo.bar/search?q=OpenTelemetry#SemConv`; `//localhost` | `Required` | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`az.client_request_id`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/azure.md) | string | Unique identifier for the request sent by the client which stays the same if the request is retried. [4] | `eb178587-c05a-418c-a695-ae9466c5303c` | `Conditionally Required` if available. | ![Deprecated](https://img.shields.io/badge/-deprecated-red)<br>Replaced by `azure.client.request.id`. |
| [`az.schema_url`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/azure.md) | string | OpenTelemetry Schema URL including schema version [5] | `https://opentelemetry.io/schemas/1.23.0` | `Conditionally Required` [6] | ![Deprecated](https://img.shields.io/badge/-deprecated-red)<br>Obsoleted. |
| [`error.type`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/error.md) | string | Describes a class of error the operation ended with. [7] | `timeout`; `java.net.UnknownHostException`; `server_certificate_invalid`; `500` | `Conditionally Required` If and only if an error occurred. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`http.response.status_code`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/http.md) | int | [HTTP response status code](https://tools.ietf.org/html/rfc7231#section-6). | `200` | `Conditionally Required` If and only if one was received/sent. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`az.namespace`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/azure.md) | string | The [Azure Resource Provider Namespace](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-services-resource-providers) for the service being called. For example, `Microsoft.Storage` for Azure Storage. [8] | `Microsoft.Storage`; `Microsoft.KeyVault`; `Microsoft.ServiceBus` | `Recommended` | ![Deprecated](https://img.shields.io/badge/-deprecated-red)<br>Replaced by `azure.resource_provider.namespace`. |
| [`az.service_request_id`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/azure.md) | string | Unique identifier for the response returned by the service in response to a request attempt. [9] | `00000000-0000-0000-0000-000000000000` | `Recommended` | ![Deprecated](https://img.shields.io/badge/-deprecated-red)<br>Replaced by `azure.service.request.id`. |
| [`http.request.resend_count`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/http.md) | int | The ordinal number of request resending attempt (for any reason, including redirects). [10] | `3` | `Recommended` [11] | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| [`server.port`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/server.md) | int | Server port number. [12] | `80`; `8080`; `443` | `Recommended` | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |

**[1] `http.request.method`:** HTTP request method value SHOULD be "known" to the instrumentation.
By default, this convention defines "known" methods as the ones listed in [RFC9110](https://www.rfc-editor.org/rfc/rfc9110.html#name-methods)
and the PATCH method defined in [RFC5789](https://www.rfc-editor.org/rfc/rfc5789.html).

If the HTTP request method is not known to instrumentation, it MUST set the `http.request.method` attribute to `_OTHER`.

If the HTTP instrumentation could end up converting valid HTTP request methods to `_OTHER`, then it MUST provide a way to override
the list of known HTTP methods. If this override is done via environment variable, then the environment variable MUST be named
OTEL_INSTRUMENTATION_HTTP_KNOWN_METHODS and support a comma-separated list of case-sensitive known HTTP methods
(this list MUST be a full override of the default known method, it is not a list of known methods in addition to the defaults).

HTTP method names are case-sensitive and `http.request.method` attribute value MUST match a known HTTP method name exactly.
Instrumentations for specific web frameworks that consider HTTP methods to be case insensitive, SHOULD populate a canonical equivalent.
Tracing instrumentations that do so, MUST also set `http.request.method_original` to the original value.

**[2] `server.address`:** In HTTP/1.1, when the [request target](https://www.rfc-editor.org/rfc/rfc9112.html#name-request-target)
is passed in its [absolute-form](https://www.rfc-editor.org/rfc/rfc9112.html#section-3.2.2),
the `server.address` SHOULD match the host component of the request target.

In all other cases, `server.address` SHOULD match the host component of the
`Host` header in HTTP/1.1 or the `:authority` pseudo-header in HTTP/2 and HTTP/3.

**[3] `url.full`:** For network calls, URL usually has `scheme://host[:port][path][?query][#fragment]` format, where the fragment
is not transmitted over HTTP, but if it is known, it SHOULD be included nevertheless.

`url.full` MUST NOT contain credentials passed via URL in form of `https://username:password@www.example.com/`.
In such cases username and password SHOULD be redacted and attribute's value SHOULD be `https://REDACTED:REDACTED@www.example.com/`.

`url.full` SHOULD capture the absolute URL when it is available (or can be reconstructed).

Sensitive content provided in `url.full` SHOULD be scrubbed when instrumentations can identify it.
Azure client libraries SHOULD redact sensitive content in `url.full` by default consistently
across distributed tracing and logging.

**[4] `az.client_request_id`:** This attribute is deprecated in favor of `azure.client.request.id`, but it is still RECOMMENDED to be used until `azure.client.request.id` becomes stable in the OpenTelemetry Semantic Conventions.

**[5] `az.schema_url`:** This attribute is deprecated in favor of a SchemaURL argument provided when creating OpenTelemetry tracers or meters.
Azure client libraries and core implementations that populate it, SHOULD keep populating it for backward compatibility, but it is NOT RECOMMENDED to use it in new code.
The attribute MAY also be populated when using non-OpenTelemetry tracing or metrics implementations that do not support setting SchemaURL as a dedicated argument.

**[6] `az.schema_url`:** if and only if OpenTelemetry in a given language doesn't provide a standard way to set `SchemaURL` (.NET)

**[7] `error.type`:** If the request fails with an error before a response status code was received,
`error.type` SHOULD be set to an exception type (its fully-qualified class name, if applicable)
or a component-specific low cardinality error identifier.

If response status code was sent or received and status indicates an
error according to [HTTP span status definition](https://github.com/open-telemetry/semantic-conventions/blob/main/docs/http/http-spans.md),
`error.type` SHOULD be set to the status code number (represented as a string),
an exception type (if thrown) or a component-specific error identifier.

If the request has completed successfully, instrumentations SHOULD NOT set `error.type`.

**[8] `az.namespace`:** This attribute is deprecated in favor of `azure.resource_provider.namespace`, but it is still RECOMMENDED to be used until `azure.resource_provider.namespace` becomes stable in the OpenTelemetry Semantic Conventions.
This attribute SHOULD be set according to the client library's best knowledge and may not match the actual service being called.

**[9] `az.service_request_id`:** This attribute is deprecated in favor of `azure.service.request.id`, but it is still RECOMMENDED to be used until `azure.service.request.id` becomes stable in the OpenTelemetry Semantic Conventions.

**[10] `http.request.resend_count`:** The resend count SHOULD be updated each time an HTTP request gets resent by the client, regardless of what was the cause of the resending (e.g. redirection, authorization failure, 503 Server Unavailable, network issues, or any other).

**[11] `http.request.resend_count`:** if and only if the request was retried or redirected (i.e. if the value is greater than 0).

**[12] `server.port`:** In the case of HTTP/1.1, when the [request target](https://www.rfc-editor.org/rfc/rfc9112.html#name-request-target)
is passed in its [absolute-form](https://www.rfc-editor.org/rfc/rfc9112.html#section-3.2.2),
the `server.port` SHOULD match the port component of the request target.

In all other cases, `server.port` SHOULD match the port component of the
`Host` header in HTTP/1.1 or the `:authority` pseudo-header in HTTP/2 and HTTP/3.

The following attributes can be important for making sampling decisions
and SHOULD be provided **at span creation time** (if provided at all):

* [`http.request.method`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/http.md)
* [`server.address`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/server.md)
* [`server.port`](https://github.com/open-telemetry/semantic-conventions/tree/v1.36.0/docs/registry/attributes/server.md)

---

`error.type` has the following list of well-known values. If one of them applies, then the respective value MUST be used; otherwise, a custom value MAY be used.

| Value  | Description | Stability |
|---|---|---|
| `_OTHER` | A fallback error value to be used when the instrumentation doesn't define a custom value. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |

---

`http.request.method` has the following list of well-known values. If one of them applies, then the respective value MUST be used; otherwise, a custom value MAY be used.

| Value  | Description | Stability |
|---|---|---|
| `_OTHER` | Any HTTP method that the instrumentation has no prior knowledge of. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `CONNECT` | CONNECT method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `DELETE` | DELETE method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `GET` | GET method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `HEAD` | HEAD method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `OPTIONS` | OPTIONS method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `PATCH` | PATCH method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `POST` | POST method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `PUT` | PUT method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |
| `TRACE` | TRACE method. | ![Stable](https://img.shields.io/badge/-stable-lightgreen) |

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- END AUTOGENERATED TEXT -->
<!-- endsemconv -->

[Distributed tracing policy]: {{ site.baseurl }}{% link docs/general/implementation.md %}#distributed-tracing
[DocumentStatus]: https://github.com/open-telemetry/opentelemetry-specification/tree/v1.47.0/specification/document-status.md
