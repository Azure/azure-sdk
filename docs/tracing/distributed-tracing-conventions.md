---
title: "Distributed Tracing Conventions"
permalink: distributed_tracing_conventions.html
keywords: opentelemetry conventions
folder: general
sidebar: general_sidebar
---

Conventions are the contract between Azure SDK and tracing providers such as Azure Monitor, Jaeger and others.  They describe and standardize attributes, events and relationships for common span types: HTTP, DB, messaging and others.  Observability vendors use conventions to build visualizations and may be very sensitive to them.  Custom Azure SDK conventions are described in [Azure SDK semantic conventions](#azure-sdk-semantic-conventions) section below.

When writing instrumentation in Azure SDK or Core:

{% include requirement/MUST id="general-tracing-convention-use-otel" %} use existing [OpenTelemetry](https://opentelemetry.io/docs/specs/semconv/general/trace/) or [Azure SDK](#azure-sdk-semantic-conventions) semantic conventions whenever possible.

{% include requirement/MUST id="general-tracing-convention-describe-attributes" %} update [Azure SDK semantic conventions](#azure-sdk-semantic-conventions) when adding new Azure-specific attributes.

{% include requirement/MUST id="general-tracing-convention-attribute-naming" %} follow [OpenTelemetry attribute naming conventions](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/common/attribute-naming.md) and use the `az.{service-family}.` prefix when adding new Azure-specific attributes.

{% include requirement/MUST id="general-tracing-convention-set-schema-version" %} set OpenTelemetry [Schema URL](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/schemas/README.md) when [creating OpenTelemetry tracer](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer).

{% include requirement/SHOULD id="general-tracing-convention-set-library" %} set Azure Client Library name and version [Schema URL](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer) when [creating OpenTelemetry tracer](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer).

{% include requirement/SHOULD id="general-tracing-convention-new-otel" %} contribute new conventions (or patch existing ones) to OpenTelemetry when there is no suitable one or some scenarios are missing.

# Azure SDK semantic conventions

<!--TODO: move to https://github.com/open-telemetry/semantic-conventions repo-->

**Status**: [Mixed][DocumentStatus]

This document describes tracing semantic conventions adopted by Azure SDK. Instrumentations live in Azure SDK repos and are shipped along with Azure SDK artifacts.

- [Java](https://github.com/Azure/azure-sdk-for-java/tree/main/sdk/core/azure-core-tracing-opentelemetry)
- [JavaScript](https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/core/core-tracing)
- [Python](https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/core/azure-core-tracing-opentelemetry)
- [.NET](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/core/Azure.Core/samples/Diagnostics.md#activitysource-support)
- [Go](https://github.com/Azure/azure-sdk-for-go/blob/main/sdk/tracing/azotel)
- [C++](https://github.com/Azure/azure-sdk-for-cpp/tree/main/sdk/core/azure-core-tracing-opentelemetry)

Azure SDK produces spans for public API calls and nested HTTP client spans. AMQP transport-level calls are not traced.

## Versioning

Azure SDKs follow OpenTelemetry semantic conventions when applicable, but adopt new versions of conventions at their own pace. Telemetry consumers MAY use [SchemaUrl](https://opentelemetry.io/docs/specs/otel/schemas/#schema-url) to detect which version of semantic conventions are emitted by Azure SDKs.

## Public API calls

**Status**: [Stable][DocumentStatus]

Azure SDK SHOULD create a span for each call to service methods, that is, public APIs that involve communication with Azure services.

- Spans representing public API calls SHOULD have names following `client.method` pattern and are language-specific. In case OpenTelemetry defines semantic convention for span name (for example, in messaging or database conventions), standard OpenTelemetry name SHOULD be used instead.
- For HTTP-based SDKs, public API spans SHOULD have `INTERNAL` kind.

See [Messaging](#messaging-sdks) section below and [CosmosDB conventions](/docs/database/cosmosdb.md) for non-HTTP semantics.

API-level spans produced by Azure SDK have the following attributes:

<!-- semconv azure.sdk.api(full) -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.namespace` | string | [Namespace](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers) of Azure service request is made against. [1] | `Microsoft.Storage`; `Microsoft.KeyVault`; `Microsoft.ServiceBus` | Required |
| `az.schema_url` | string | OpenTelemetry Schema URL including schema version. Only 1.23.0 is supported. | `https://opentelemetry.io/schemas/1.23.0` | Conditionally Required: [2] |
| `error.type` | string | Describes a class of error the operation ended with. [3] | `java.net.UnknownHostException`; `System.Threading.Tasks.OperationCanceledException`; `azure.core.exceptions.ServiceRequestError` | Recommended |

**[1]:** This SHOULD be set as an instrumentation scope attribute when creating a `Tracer` as long as OpenTelemetry in a given language allows to do so.

**[2]:** if and only if OpenTelemetry in a given language doesn't provide a standard way to set `schema_url` (.NET)

**[3]:** The `error.type` SHOULD be predictable and SHOULD have low cardinality.
Instrumentations SHOULD document the list of errors they report.

The cardinality of `error.type` within one instrumentation library SHOULD be low.
Telemetry consumers that aggregate data from multiple instrumentation libraries and applications
should be prepared for `error.type` to have high cardinality at query time when no
additional filters are applied.

If the operation has completed successfully, instrumentations SHOULD NOT set `error.type`.

If a specific domain defines its own set of error identifiers (such as HTTP or gRPC status codes),
it's RECOMMENDED to:

* Use a domain-specific attribute
* Set `error.type` to capture all errors, regardless of whether they are defined within the domain-specific set or not.

`error.type` has the following list of well-known values. If one of them applies, then the respective value MUST be used, otherwise a custom value MAY be used.

| Value  | Description |
|---|---|
| `_OTHER` | A fallback error value to be used when the instrumentation doesn't define a custom value. |
<!-- endsemconv -->

In addition to common attributes listed in the table above, certain Azure client libraries in .NET emit other library-specific attributes.

### Azure Application Configuration attributes

<!-- semconv azure.sdk.appconfiguration -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.appconfiguration.key` | string | Value of the Azure Application Configuration property [key](https://learn.microsoft.com/azure/azure-app-configuration/concept-key-value). | `AppName:Service1:ApiEndpoint` | Recommended |
<!-- endsemconv -->

### Azure Cognitive Language Question Answering SDK attributes

<!-- semconv azure.sdk.cognitivelanguage -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.cognitivelanguage.deployment.name` | string | Name of the [Azure Questions Answering](https://learn.microsoft.com/azure/ai-services/language-service/question-answering) deployment. | `production` | Recommended |
| `az.cognitivelanguage.project.name` | string | Name of the [Azure Questions Answering](https://learn.microsoft.com/azure/ai-services/language-service/question-answering) project. | `production` | Recommended |
<!-- endsemconv -->

### Azure Digital Twins attributes

<!-- semconv azure.sdk.digitaltwins -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.digitaltwins.component.name` | string | The name of the digital twin component. | `thermostat` | Recommended |
| `az.digitaltwins.event_route.id` | string | The [event route](https://learn.microsoft.com/azure/digital-twins/concepts-route-events) identifier used by the digital twin. | `6f8741b1` | Recommended |
| `az.digitaltwins.job.id` | string | Digital twin job id. | `test-job` | Recommended |
| `az.digitaltwins.message.id` | string | A unique message identifier (in the scope of the digital twin id) used to de-duplicate telemetry messages. | `a40896c5ab954ab1` | Recommended |
| `az.digitaltwins.model.id` | string | The digital twin model id. | `dtmi:example:Room23;1` | Recommended |
| `az.digitaltwins.query` | string | Digital twin graph query. | `SELECT * FROM DIGITALTWINS WHERE Name = "DSouza"` | Recommended |
| `az.digitaltwins.relationship.name` | string | The name of the relationship between twins. | `contains` | Recommended |
| `az.digitaltwins.twin.id` | string | The unique identifier of the [digital twin](https://learn.microsoft.com/azure/digital-twins/concepts-twins-graph). | `edf41622` | Recommended |
<!-- endsemconv -->

### Azure KeyVault attributes

#### Azure KeyVault Certificates attributes

<!-- semconv azure.sdk.keyvault.certificates -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.keyvault.certificate.issuer.name` | string | Azure KeyVault certificate version. | `issuer01` | Recommended |
| `az.keyvault.certificate.name` | string | Azure KeyVault certificate name. | `selfSignedCert01` | Recommended |
| `az.keyvault.certificate.version` | string | Azure KeyVault certificate version. | `c3d31d7b36c942ad83ef36fc0785a4fc` | Recommended |
<!-- endsemconv -->

#### Azure KeyVault Keys attributes

<!-- semconv azure.sdk.keyvault.keys -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.keyvault.key.id` | string | Azure KeyVault key id (full URL). | `"https://myvault.vault.azure.net/keys/CreateSoftKeyTest/78deebed173b48e48f55abf87ed4cf71` | Recommended |
| `az.keyvault.key.name` | string | Azure KeyVault key name. | `test-key` | Recommended |
| `az.keyvault.key.version` | string | Azure KeyVault key version. | `3d31e6e5c4c14eaf9be8d42c00225088` | Recommended |
<!-- endsemconv -->

#### Azure KeyVault Secrets attributes

<!-- semconv azure.sdk.keyvault.secrets -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.keyvault.secret.name` | string | Azure KeyVault secret name. | `test-secret` | Recommended |
| `az.keyvault.secret.version` | string | Azure KeyVault secret version. | `4387e9f3d6e14c459867679a90fd0f79` | Recommended |
<!-- endsemconv -->

#### Azure Mixed Reality Remote Rendering attributes

<!-- semconv azure.sdk.remoterendering -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.remoterendering.conversion.id` | string | A conversion id uniquely identifying the conversion for the given [Azure Remote Rendering](https://learn.microsoft.com/windows/mixed-reality/develop/mixed-reality-cloud-services#azure-remote-rendering) account. | `contoso-conversion-6fae2bfb754e` | Recommended |
| `az.remoterendering.session.id` | string | A session id uniquely identifying the conversion for the given [Azure Remote Rendering](https://learn.microsoft.com/windows/mixed-reality/develop/mixed-reality-cloud-services#azure-remote-rendering) account. | `contoso-session-8c28813adc28` | Recommended |
<!-- endsemconv -->

## HTTP Client spans

**Status**: [Stable][DocumentStatus]

Azure SDK implements a valid subset of stable part of [OpenTelemetry HTTP spans conventions](/docs/http/http-spans.md) and create a span per HTTP call (attempt).

<!-- semconv azure.sdk.http -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.client_request_id` | string | Value of the [x-ms-client-request-id] header (or other request-id header, depending on the service) sent by the client. | `eb178587-c05a-418c-a695-ae9466c5303c` | Conditionally Required: only if present. |
| `az.namespace` | string | [Namespace](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers) of Azure service request is made against. [1] | `Microsoft.Storage`; `Microsoft.KeyVault`; `Microsoft.ServiceBus` | Required |
| `az.schema_url` | string | OpenTelemetry Schema URL including schema version. Only 1.23.0 is supported. | `https://opentelemetry.io/schemas/1.23.0` | Conditionally Required: [2] |
| `az.service_request_id` | string | Value of the [x-ms-request-id]  header (or other request-id header, depending on the service) sent by the server in response. | `3f828ae5-ecb9-40ab-88d9-db0420af30c6` | Conditionally Required: if and only if one was received |
| `error.type` | string | Describes a class of error the operation ended with. [3] | `timeout`; `java.net.UnknownHostException`; `server_certificate_invalid`; `500` | Conditionally Required: If request has ended with an error. |
| [`http.request.method`](../attributes-registry/http.md) | string | HTTP request method. [4] | `GET`; `POST`; `HEAD` | Required |
| [`http.request.resend_count`](../attributes-registry/http.md) | int | The ordinal number of request resending attempt (for any reason, including redirects). [5] | `3` | Recommended |
| [`http.response.status_code`](../attributes-registry/http.md) | int | [HTTP response status code](https://tools.ietf.org/html/rfc7231#section-6). | `200` | Conditionally Required: If and only if one was received/sent. |
| [`server.address`](../general/attributes.md) | string | Host identifier of the ["URI origin"](https://www.rfc-editor.org/rfc/rfc9110.html#name-uri-origin) HTTP request is sent to. [6] | `example.com`; `10.1.2.80`; `/tmp/my.sock` | Required |
| [`server.port`](../general/attributes.md) | int | Port identifier of the ["URI origin"](https://www.rfc-editor.org/rfc/rfc9110.html#name-uri-origin) HTTP request is sent to. [7] | `80`; `8080`; `443` | Required |
| [`url.full`](../attributes-registry/url.md) | string | Absolute URL describing a network resource according to [RFC3986](https://www.rfc-editor.org/rfc/rfc3986) [8] | `https://www.foo.bar/search?q=OpenTelemetry#SemConv`; `//localhost` | Recommended |

**[1]:** This SHOULD be set as an instrumentation scope attribute when creating a `Tracer` as long as OpenTelemetry in a given language allows to do so.

**[2]:** if and only if OpenTelemetry in a given language doesn't provide a standard way to set `schema_url` (.NET)

**[3]:** If the request fails with an error before response status code was sent or received,
`error.type` SHOULD be set to exception type (its fully-qualified class name, if applicable)
or a component-specific low cardinality error identifier.

If response status code was sent or received and status indicates an error according to [HTTP span status definition](/docs/http/http-spans.md),
`error.type` SHOULD be set to the status code number (represented as a string), an exception type (if thrown) or a component-specific error identifier.

The `error.type` value SHOULD be predictable and SHOULD have low cardinality.
Instrumentations SHOULD document the list of errors they report.

The cardinality of `error.type` within one instrumentation library SHOULD be low, but
telemetry consumers that aggregate data from multiple instrumentation libraries and applications
should be prepared for `error.type` to have high cardinality at query time, when no
additional filters are applied.

If the request has completed successfully, instrumentations SHOULD NOT set `error.type`.

**[4]:** Azure SDKs support HTTP methods listed in [RFC9110](https://www.rfc-editor.org/rfc/rfc9110.html#name-methods) and the `PATCH`` method defined in [RFC5789](https://www.rfc-editor.org/rfc/rfc5789.html)

**[5]:** The resend count SHOULD be updated each time an HTTP request gets resent by the client, regardless of what was the cause of the resending (e.g. redirection, authorization failure, 503 Server Unavailable, network issues, or any other).

**[6]:** Describes host component of Azure service endpoint.

**[7]:** Describes port component of Azure service endpoint.

**[8]:** For network calls, URL usually has `scheme://host[:port][path][?query][#fragment]` format, where the fragment is not transmitted over HTTP, but if it is known, it SHOULD be included nevertheless.
`url.full` MUST NOT contain credentials passed via URL in form of `https://username:password@www.example.com/`. In such case username and password SHOULD be redacted and attribute's value SHOULD be `https://REDACTED:REDACTED@www.example.com/`.
`url.full` SHOULD capture the absolute URL when it is available (or can be reconstructed) and SHOULD NOT be validated or modified except for sanitizing purposes.

The following attributes can be important for making sampling decisions and SHOULD be provided **at span creation time** (if provided at all):

* `az.namespace`
* `az.schema_url`
* [`http.request.method`](../attributes-registry/http.md)
* [`server.address`](../general/attributes.md)
* [`server.port`](../general/attributes.md)
* [`url.full`](../attributes-registry/url.md)
<!-- endsemconv -->

Instrumentation supports [W3C Trace context](https://w3c.github.io/trace-context/) propagation and Azure legacy correlation protocols. Propagator configuration is not supported.

## Messaging SDKs

**Status**: [Experimental][DocumentStatus]

Messaging span semantics apply to Azure Event Hubs and Service Bus SDKs and follow [OpenTelemetry Messaging spans conventions v1.22.0](https://github.com/open-telemetry/semantic-conventions/blob/v1.22.0/docs/messaging/messaging-spans.md).

Azure SDK will update messaging semantic conventions as messaging specification evolves.

Messaging SDKs produce three kinds of spans:

- `PRODUCER` - describes message creation and associates unique context with the message to trace them when they are sent in batches.
- `CLIENT` - describes message (or batch) publishing.
  - It has links pointing to each message being sent.
- `CONSUMER` - describes message (or batch) processing.
  - It is created when user leverages handler APIs that wrap message or batch processing.
  - Processing span has links to each message being processed (when context is present).

### Messaging attributes

<!-- semconv azure.sdk.messaging -->
| Attribute  | Type | Description  | Examples  | Requirement Level |
|---|---|---|---|---|
| `az.namespace` | string | [Namespace](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-services-resource-providers) of Azure service request is made against. [1] | `Microsoft.Storage`; `Microsoft.KeyVault`; `Microsoft.ServiceBus` | Required |
| `az.schema_url` | string | OpenTelemetry Schema URL including schema version. Only 1.23.0 is supported. | `https://opentelemetry.io/schemas/1.23.0` | Conditionally Required: [2] |
| [`messaging.batch.message_count`](../attributes-registry/messaging.md) | int | The number of messages sent, received, or processed in the scope of the batching operation. [3] | `0`; `1`; `2` | Recommended |
| [`messaging.destination.name`](../attributes-registry/messaging.md) | string | The message destination name [4] | `MyQueue`; `MyTopic` | Recommended |
| [`messaging.message.id`](../attributes-registry/messaging.md) | string | A value used by the messaging system as an identifier for the message, represented as a string. | `452a7c7c7c7048c2f887f61572b18fc2` | Recommended |
| [`messaging.operation`](../attributes-registry/messaging.md) | string | A string identifying the kind of messaging operation. [5] | `publish` | Recommended |
| [`messaging.system`](../attributes-registry/messaging.md) | string | A string identifying the messaging system. | `eventhubs`; `servicebus` | Recommended |
| [`server.address`](../general/attributes.md) | string | Server domain name if available without reverse DNS lookup; otherwise, IP address or Unix domain socket name. [6] | `example.com`; `10.1.2.80`; `/tmp/my.sock` | Recommended |
| [`server.port`](../general/attributes.md) | int | Server port number. [7] | `80`; `8080`; `443` | Recommended |

**[1]:** This SHOULD be set as an instrumentation scope attribute when creating a `Tracer` as long as OpenTelemetry in a given language allows to do so.

**[2]:** if and only if OpenTelemetry in a given language doesn't provide a standard way to set `schema_url` (.NET)

**[3]:** Instrumentations SHOULD NOT set `messaging.batch.message_count` on spans that operate with a single message. When a messaging client library supports both batch and single-message API for the same operation, instrumentations SHOULD use `messaging.batch.message_count` for batching APIs and SHOULD NOT use it for single-message APIs.

**[4]:** Destination name SHOULD uniquely identify a specific queue, topic or other entity within the broker. If
the broker doesn't have such notion, the destination name SHOULD uniquely identify the broker.

**[5]:** If a custom value is used, it MUST be of low cardinality.

**[6]:** When observed from the client side, and when communicating through an intermediary, `server.address` SHOULD represent the server address behind any intermediaries, for example proxies, if it's available.

**[7]:** When observed from the client side, and when communicating through an intermediary, `server.port` SHOULD represent the server port behind any intermediaries, for example proxies, if it's available.

The following attributes can be important for making sampling decisions and SHOULD be provided **at span creation time** (if provided at all):

* `az.namespace`
* `az.schema_url`
* [`messaging.destination.name`](../attributes-registry/messaging.md)
* [`messaging.operation`](../attributes-registry/messaging.md)
* [`messaging.system`](../attributes-registry/messaging.md)
<!-- endsemconv -->

[DocumentStatus]: https://github.com/open-telemetry/opentelemetry-specification/tree/v1.26.0/specification/document-status.md
