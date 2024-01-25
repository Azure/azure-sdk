---
title: "Rust Guidelines: Implementation"
keywords: guidelines rust
permalink: rust_guidelines.html
folder: rust
sidebar: general_sidebar
---

{% include draft.html content="The Rust Language guidelines are in DRAFT status" %}

> TODO: This section needs to be driven by code in the Core library.

## API Implementation

This section describes guidelines for implementing Azure SDK client libraries. Please note that some of these guidelines are automatically enforced by code generation tools. 

### Service Client

When configuring your client library, particular care must be taken to ensure that the consumer of your client library can properly configure the connectivity to your Azure service both globally (along with other client libraries the consumer is using) and specifically with your client library.

> TODO: add a brief mention of the approach to implementing service clients. 

#### Service Methods

> TODO: Briefly introduce that service methods are implemented via an `HttpPipeline` instance.  Mention that much of this is done for you using code generation.

##### HttpPipeline

The following example shows a typical way of using `HttpPipeline` to implement a service call method. The `HttpPipeline` will handle common HTTP requirements such as the user agent, logging, distributed tracing, retries, and proxy configuration.

> TODO: Show an example of invoking the pipeline

##### HttpPipelinePolicy/Custom Policies

The HTTP pipeline includes a number of policies that all requests pass through.  Examples of policies include setting required headers, authentication, generating a request ID, and implementing proxy authentication.  `HttpPipelinePolicy` is the base type of all policies (plugins) of the `HttpPipeline`. This section describes guidelines for designing custom policies.

> TODO: Show how to customize a pipeline

#### Service Method Parameters

> TODO: This section needs to be driven by code in the Core library.

##### Parameter Validation

In addition to [general parameter validation guidelines](introduction.md#rust-parameters):

> TODO: Briefly show common patterns for parameter validation

### Supporting Types

> TODO: This section needs to be driven by code in the Core library.

#### Serialization {#rust-usage-json}

> TODO: This section needs to be driven by code in the Core library.

##### JSON Serialization

> TODO: This section needs to be driven by code in the Core library.

#### Enumeration-like Structs

> TODO: Add section> TODO: Add section

#### Using Azure Core Types

> TODO: Add section> TODO: Add section

### SDK Feature Implementation

#### Configuration

> TODO: This section needs to be driven by code in the Core library.

#### Logging

> TODO: Add section> TODO: Add section

##### Rust Logging specific details

> TODO: Add section

#### Distributed Tracing {#rust-distributedtracing}

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Telemetry

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Testing

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

### Language-specific other

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Complexity Management

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Templates

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Macros

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Type Safety Recommendations

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Const and Reference members

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Integer sizes

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Secure functions

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Enumerations

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Physical Design

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Class Types (including `union`s and `struct`s)

{% include draft.html content="Guidance coming soon ..." %}

> TODO: Add section

#### Tooling

We use a common build and test pipeline to provide for automatic distribution of client libraries.  To support this, we use common tooling.

> TODO: Add section> TODO: Add section

## Supported platforms

{% include requirement/MUST id="rust-platform-min" %} support the following platforms and associated compilers when implementing your client library.

### Windows

> TODO: Add support matrix

### Mac

> TODO: Add support matrix

#### Linux

> TODO: Add support matrix
