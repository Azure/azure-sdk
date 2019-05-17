# One pipeline per shippable

This proposal outlines an approach that I believe we should adopt to structuring the pipelines that build and release the components of our SDK to our customers.

## TL;DR;

I propose that we we adopt the practice of having one pipeline per "shippable" per language/runtime that we support. In practice this means that for the Service Bus service, we would have a total of 4 pipelines. 

This pipeline would be responsible for PR validation, CI, live testing, perfromance testing, signing, deployment and any other work that needs to be performed to release a component with confidence.

## How does this differ from our approach today?

Today we have different pipelines for different purposes. For example we have a (collection of) pipelines for PR validation, another set of pipelines for live test execution, and another for he full release cycle. Some of these pipelines require special variables to be specified in order to scope what is being released along with other "magic" values.

The proposal above differs from this approach in that we have one pipeline per shippable component and no special configuration is required (or possible). Its a glass tube from approved PR to production.

## What is a "shippable" component?

The Azure SDK for any given language is composed of multiple libraries. Collectively we refer to them as the SDK, but some libraries or collections of libraries can be shipped independently (it doesn't make sense to release a major release of Service Bus just because the Cognitive Services team has released a major change to their libraries).

In this document I am using the term "shippable" to refer to an individual library, or collection of libraries which would always be released together. For example we might always release EventHubs, Service Bus and AMQP libraries together. Or we might always release the the three/four storage service libraries together (blob, queue, file, table).

These logical collections of libraries are what I am referring to as a shippable. Each shippable is likely to have a set of pipelines, one for each language repository, for example:

- ```net - storage - ci```
- ```python - storage - ci```
- ```java - storage - ci```
- ```js - storage - ci```

### What is a glass tube?

By describing the pipeline for a shippable set of components as a glass tube we are saying that once that the output that the pipeline produces is a function of the the inputs to that pipeline.

Once a set of packages/binaries are produced those packages should be unable to be tampered with except in well defined circumstances (e.g. signing) and that those processes that do modify the binaries that are produced at the earliest stage of the build are triggered as part of the flow of artifacts through the pipeline.

In short, what we ship is what we tested, and what we tested is what we built.

## What do I mean by one pipeline?

The phrase pipeline as it relates to Azure DevOps is ambiguous. The Azure Pipelines service has two concepts of a pipeline - a build pipeline and a release pipeline. However Azure Pipelines is transitioning to a unified pipeline model where a single YAML file can describe the end-to-end build and release process.

If this proposal is accepted, whether we have a single unified pipeline, or a build pipelien plus an associated release pipeline is a function of when we start the effort and what features are available in the unified pipeline model. Eventually we'll definately be using the unified pipeline model.

So when I say one pipeline consider it to mean either a build+release pipeline or a unified pipeline.

So what do I mean by one pipeline? When I say one pipeline I mean one pipeline that is responsible for performing pull request validation, CI builds and subsequent release to the various package registries we target.

When triggered as a PR the pipeline would only execute the set of steps that are appropriate for PR validation (e.g. build and unit test), but when triggered as a CI build, a variety of subsequent pipeline stages would open up which the build artifacts would transition through on the way to being released to customers (or not if the pipeline run is cancelled).

Assuming the unified pipeline model is available if/when we implement this the YAML structure (sans a lot of detail) might look something like this:

```yaml
trigger:
  branches:
    include:
      - master
      - release/*
  paths:
    include:
      - sdk/servicebus/
      - eng/

pr:
  branches:
    include:
      - master
      - release/*
  paths:
    include:
      - sdk/servicebus/
      - eng/

stages:
  - stage: build
  - stage: live_test
    condition: eq(variables['Build.Reason'], 'IndividualCI')
```

Note that the above is just a simplistic example of what a fully materialized pipeline might look like, expect the pipeline itself to look more like the ```ci.yml``` files that are currently in the repository with a few parameters and a reference to a stage template (to ensure consistency).

## Split brain approach vs. side-car pipelines

Currently the Azure SDK Engineering System makes use of a combination of public pipelines (PR validation) and private pipelines for producing release builds, signing, live & performance tests.

Our internal pipelines are a superset of the public pipelines and include access to credentials used for accessing Azure subscriptions and other resources such as package registries and signing services.

It is right that we take step steps to protect access to those sensitive parts of the engineering system. This proposal advocates for an approach where we are public and open by default and "shell out" to internal pipelines to perform these specific activities (behind manual approval and automated check gates).

These side-car pipelines would not seek to repeat the work that had already been done in the public pipeline, instead it would perform just the action that it was designed for (e.g. taking a binary and submitting it to our signing services, repacking a package and associating the signed package with the public pipeline run).

The same approach could be used with the various proprietary security scanning tools that we must run at Microsoft before we are allowed to sign something that is released to customers.

Execution of live tests, and access to Azure subscriptions for testing is a special case and we should consider approaches that allow us to do this entirely within the public pipelines whilst mitigating the risks of credential leakage (primarily reputation and expense).

## Benefits

### Being Transparent

TODO:

### Cost Control

TODO:

## Risks

### Protecting Secrets