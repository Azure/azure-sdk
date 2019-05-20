# One pipeline per shippable

This proposal outlines an approach that I believe we should adopt to structuring the pipelines that build and release the components of our SDK to our customers.

## TL;DR;

I propose that we we adopt the practice of having one pipeline per "shippable" per language/runtime that we support. In practice this means that for the Service Bus libraries in the SDK, we would have a total of 4 pipelines. 

This pipeline would be responsible for PR validation, CI, live testing, performance testing, signing, deployment and any other work that needs to be performed to release a component with confidence.

## How does this differ from our approach today?

Today we have different pipelines for different purposes. For example we have a (collection of) pipelines for PR validation, another set of pipelines for live test execution, and another for he full release cycle. Some of these pipelines require special variables to be specified in order to scope what is being released along with other "magic" values.

The proposal above differs from this approach in that we have one pipeline per shippable component and no special configuration is required (or possible). Its a _glass tube_ from approved PR to production.

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
  - template: ../../eng/pipelines/templates/stages/archetype-sdk-client.yml
    parameters:
      ShippablePath: /sdk/servicebus/shippable.proj
```

The template referenced above would be a multi-stage template with conditions on stages that we want to omit for specific workflows (e.g. PullRequests, Nighly/Scheduled builds etc).

## Split brain approach vs. side-car pipelines

Currently the Azure SDK Engineering System makes use of a combination of public pipelines (PR validation) and private pipelines for producing release builds, signing, live & performance tests.

Our internal pipelines are a superset of the public pipelines and include access to credentials used for accessing Azure subscriptions and other resources such as package registries and signing services.

It is right that we take step steps to protect access to those sensitive parts of the engineering system. This proposal advocates for an approach where we are public and open by default and "shell out" to internal pipelines to perform these specific activities (behind manual approval and/or automated check gates).

These side-car pipelines would not seek to repeat the work that had already been done in the public pipeline, instead it would perform just the action that it was designed for (e.g. taking a binary and submitting it to our signing services, repacking a package and associating the signed package with the public pipeline run).

The same approach could be used with the various proprietary security scanning tools that we must run at Microsoft before we are allowed to sign something with our certificates before being released to customers.

Execution of live tests, and access to Azure subscriptions for testing is a special case and we should consider approaches that allow us to do this entirely within the public pipelines whilst mitigating the risks of credential leakage (primarily reputation and expense). For example live tests could be behind an approval gate which would be a second layer of protection (PR approval being the first). We could also look at rotating credentials with access to these subscription(s) more rapidly to avoid a leaked credential being used along with routine grim reaper processing on resources created within the subscription(s).

## Versioning

Today when we run a pipeline for release we use a variable at queue time to inject the version number into the pipeline. That version number is then carried with the artifacts all the way through the pipeline. I'm proposing that we continue injecting version numbers are the beginning of the pipeline, but because it is likely the CI builds that are potentially going to be released there is no opportunity to specify a version number other than picking up a configuration value that is checked into version control.

In my opinion the components of each _shippable_ should share the same version number, but version numbers can differ across _shippables_. So in the same mono-repo we might have 1.1.0 of servicebus, eventhubs and amqp, but 1.0.1 of cognitive services, core, which would be a seperate shippable might be 2.1.3.

During the PR and CI builds this version prefix would be picked up from a file checked into version control and the suffix would be generated from the pipeline itself. Packages would only be created in the first stage of the build process so this means that if we were doing a .NET build of Service Bus we might end up with the following packages being produced.

| Package Name | Version | Suffix | Produced in PR | Produced in CI | Produced in Nightly | Signed |
| - | - | - | - | - | - | - |
| ```Microsoft.Azure.ServiceBus``` | ```1.1.0``` | ```-pr.<runid>``` | Yes | No | No | No |
| ```Microsoft.Azure.ServiceBus``` | ```1.1.0``` | ```-ci.<runid>``` | No | Yes | Yes | No |
| ```Microsoft.Azure.ServiceBus``` | ```1.1.0``` | ```-preview.<auto>``` | No | Yes | Yes | Yes* |
| ```Microsoft.Azure.ServiceBus``` | ```1.1.0``` | N/A | No | Yes | Yes | Yes* |

The first package is produced only as an output of a PR and it would be published into Azure Artifacts or GitHub Package Registry (or both). The ```<runid>``` makes the package version unique so multiple iterations on the same pull request would result in a different package version. This would allow developers that are working across a binary composition boundary (e.g. Core and ServiceBus in the future) to be able to submit a PR with changes to Core and then once the PR is built reference that package version that was produced by a PR for development and debugging purposes.

Once a PR is merged, a new pipeline run starts and that pipeline has the potential to go all the way to release. In this case the build would pre-create all the package versions that are required for the rest of the pipeline. The packages themselves (with the exception of the ```-ci.<runid>``` package) are not published to any immutable feed until after appropriate levels of validation have been performed. When each package is published and where is discussed below, but its important to note that as soon as either the ```-preview.<auto>``` or non-suffixed packages are published to either Azure Artifacts or the appropriate registry then those versions are _burned_.

In the case of preview builds it is the fully qualified name that is burned (so publishing ```-preview.1``` would not preclude publishing ```-preview.2```). The pipeline would automatically increment the preview number by looking up the range of preview versions in Azure Artifacts and incrementing based on the highest number.

If a version prefix is burned (e.g. version ```1.1.0``` (no suffix) has made it all the way to a publicly accessible registry) then the entire version range is considered to be burned and the pipeline would fail fast forcing a commit to update the version number. Later stages of the release pipeline could actually be configured to create a pull request to update the patch number automatically (and create tags in the Git repo).

Once fully automated this means that developers just wouldn't need to think about version numbers since the release pipeline enforces safe practices all the way along.

## Ring-based model

I propose we use _Ring_ terminology to describe the stage that a _shippable_ is in. Each stage in the pipeline will correspond to a ring and have one or more jobs to perform various actions. The following table outlines a possible structure for a shippable's pipeline. 

| Ring/Stage | Run Type | Approvers | Job | Notes |
| - | - | - | - | - |
| Ring 0 / Build | PR & CI| (auto) | Build and Package | All package versions ```-ci.<runid>```, ```-preview.<auto>``` etc |
| | | | Run Unit Tests | Non-live tests, essential platform combos only |
| | | | Publish ```-ci.<runid>``` package | Allows for team loop integration |
| | | | Component Governance, doc-warden etc | Any compliance tools that are public |
| Ring 1 / Extended Validation | CI | Developer | Extended Unit Tests (e.g. Python Alpha) | Not automatic because of resource cost?
| | | | Security Scanning | Server task invokes and waits for a sidecar pipeline |
| Ring 2 / Live Testing | CI | Team BMOD | Live Testing | BMOD for team that owns commit approves (or eng. sys) |
| | | | Automated Smoke Testing (Round 1) | Set of jobs that validate packages install correctly and basic scenarios work |
| Ring 3 / Preview Prep | CI | Team BMOD | Code Sign ```-preview.<auto>``` package | Runs as a side-car pipeline
| | | | Publish Preview Package to AZ Artifacts | Publish package to @Local view. |
| | | | Automated Smoke Testing (Round 2) | See above. |
| | | | Promote Preview Package | Promote package to @Approved view. |
| Ring 4 / Preview Go-Live! | CI | Architect or Eng. Sys | Publish Package to Public Registry | Now installable without special settings. |
| Ring 5 / Bake | CI | (auto) | Wait for Signals | Wait for signals that the preview is being used and is functioning correctly. |
| | | | Automated Stress/Perf Testing | Any long running perf and stress tests that we need to run. |
| Ring 6 / Release Prep | CI | PM | Code Sign package (non-prefixed) | This is the final package getting code-signed.
| | | | Publish Final Package to AZ Artifacts | Publish package to @Local view. |
| | | | Automated Smoke Testing (Round 3) | See above. |
| | | | Tag source commit with version tag. |
| | | | Create PR and submit with patch revision number. | 
| | | | Promote Final Package | Promote package to @Approved view. |
| Ring 7 / Release Go-Live! | CI | PM | Publish Package to Public Registry | Now installabel without special settings. |

## Benefits

I believe that this approach has several benefits in terms of simplication, transparency, and cost control.

### Simplification

Now when working on a shippable component developers will only need to consider a single pipeline (assuming their change doesn't span multiple shippables). The pipeline that runs PR validation is the same pipleine that runs the end-to-end delivery process for the shippable to cusomters, just with additional stages and validations.

### Being Transparent

Having a single pipeline per shippable makes it easy for us to point to a single place for both internal and external stakeholders to look to see where updates are in terms of release. With the exception of pipeline jobs which we explicitly call out to side car processes for security reasons the entire process is visible end-to-end.

### Cost Control

By running as much of our pipeline as possible in public projects we maximise the benfits of free pipeline minutes/concurrency that we get from the Azure DevOps team. Private pipelines are charged back internally and with the breadth of our test suites and under the internal cost structures this can be fairly costly.

In addition, expensive test execution is behind an approval gate and would only run after a developer has approved it to go through to this round of testing. This would stop agents being consumed which would improve our overall throughput on PR validation.

## Q&A

Got questions, concerns? Raise them and we can start to explore the issues.