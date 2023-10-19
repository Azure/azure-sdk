---
title: "Distributed Tracing Conventions"
permalink: distributed_tracing_conventions.html
keywords: opentelemetry conventions
folder: general
sidebar: general_sidebar
---

Conventions are the contract between Azure SDK and tracing providers such as Azure Monitor, Jaeger and others.  They describe and standardize attributes, events and relationships for common span types: HTTP, DB, messaging and others.  Observability vendors use conventions to build visualizations and may be very sensitive to them.  Custom Azure SDK conventions are described in [tracing-conventions.yml](./distributed-tracing-conventions.yml) and include:

- Custom Azure SDK attributes
- Azure SDK HTTP conventions compatible with OpenTelemetry
- Custom messaging and DB conventions. They don't follow OpenTelemetry convention and used until OpenTelemetry conventions evolve and stabilize

When writing instrumentation in Azure SDK or Core:

{% include requirement/MUST id="general-tracing-convention-use-otel" %} use [OpenTelemetry conventions](https://opentelemetry.io/docs/specs/semconv/general/trace/) whenever possible.

{% include requirement/MUST id="general-tracing-convention-describe-attributes" %} update [distributed-tracing-conventions.yml](./distributed-tracing-conventions.yml) when adding new attributed.

{% include requirement/MUST id="general-tracing-convention-set-schema-version" %} set OpenTelemetry [Schema URL](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/schemas/README.md?plain=1) when [creating OpenTelemetry tracer](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer).

{% include requirement/SHOULD id="general-tracing-convention-set-library" %} set Azure Client Library name and version [Schema URL](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer) when [creating OpenTelemetry tracer](https://github.com/open-telemetry/opentelemetry-specification/blob/main/specification/trace/api.md#get-a-tracer).


{% include requirement/SHOULD id="general-tracing-convention-new-otel" %} contribute new conventions (or patch existing ones) to OpenTelemetry when there is no suitable one or some scenarios are missing.

{% include requirement/MAY id="general-tracing-convention-add-attributes" %} extend list of attributes on top of OpenTelemetry contentions with Azure-specific ones.

{% include requirement/MUSTNOT id="general-tracing-convention-new-custom" %} add new custom Azure SDK conventions.
