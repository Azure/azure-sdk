# Azure Java SDK Specification

**Version:** 1.0.0-preview-1

**Editors:**

- Jonathan Giles - jonathan.giles@microsoft.com

The Azure Java SDK Specification (AJSS) contains guidelines for writing high-quality Java SDKs for accessing and consuming Azure services in an idiomatic, consistent, and high-quality fashion.

## Contents

- [Azure Java SDK Specification](#azure-java-sdk-specification)
  - [Contents](#contents)
  - [1 Contributing to this Specification](#1-contributing-to-this-specification)
  - [2 Scope](#2-scope)
  - [3 Terminology](#3-terminology)
  - [4 Pre-requisites](#4-pre-requisites)
  - [5 Functionality](#5-functionality)
  - [6 Platform Support](#6-platform-support)
    - [6.0 Operating Systems](#60-operating-systems)
    - [6.1 Supported Java Versions](#61-supported-java-versions)
  - [7 Versioning](#7-versioning)
    - [7.0 Snapshot Releases](#70-snapshot-releases)
    - [7.1 GA Releases](#71-ga-releases)
  - [8 Naming](#8-naming)
    - [8.0 Determing Group and Service Name](#80-determing-group-and-service-name)
    - [8.1 Java Package Naming](#81-java-package-naming)
  - [9 Maven Projects](#9-maven-projects)
    - [9.0 Project Initialization](#90-project-initialization)
    - [9.1 pom.xml](#91-pomxml)
      - [9.1.0 parent](#910-parent)
      - [9.1.1 groupId](#911-groupid)
      - [9.1.2 artifactId](#912-artifactid)
      - [9.1.3 name, description, and url](#913-name-description-and-url)
      - [9.1.4 scm](#914-scm)
      - [9.1.5 developers](#915-developers)
  - [10 GitHub Requirements](#10-github-requirements)
    - [10.0 README.md](#100-readmemd)
    - [10.1 CONTRIBUTING.md](#101-contributingmd)
    - [10.2 LICENSE.md](#102-licensemd)
    - [10.3 CODEOWNERS](#103-codeowners)
  - [11 Dependencies](#11-dependencies)
    - [11.0 The 'Parent POM'](#110-the-parent-pom)
      - [11.0.0 Adding a New Dependency](#1100-adding-a-new-dependency)
      - [11.0.1 Updating Existing Dependencies](#1101-updating-existing-dependencies)
  - [12 Coding Conventions](#12-coding-conventions)
    - [12.0 Async](#120-async)
    - [12.1 Pipelines](#121-pipelines)
    - [12.2 Logging](#122-logging)
    - [12.3 Don't Return null](#123-dont-return-null)
    - [12.4 Functional Interfaces](#124-functional-interfaces)
    - [12.5 Tooling](#125-tooling)
      - [12.5.0 IDE Configuration](#1250-ide-configuration)
      - [12.5.1 SpotBugs](#1251-spotbugs)
      - [12.5.2 CheckStyle](#1252-checkstyle)
    - [12.6 Testing](#126-testing)
      - [12.6.0 Unit Tests](#1260-unit-tests)
      - [12.6.1 Mock and Live Tests](#1261-mock-and-live-tests)
  - [13 Documentation](#13-documentation)
    - [13.0 General Advice](#130-general-advice)
    - [13.1 Quickstarts & Tutorials](#131-quickstarts--tutorials)
    - [13.2 Code Samples](#132-code-samples)
    - [13.3 JavaDoc](#133-javadoc)
      - [13.3.0 JavaDoc for Behavioral Contracts](#1330-javadoc-for-behavioral-contracts)
    - [13.4 Reference Overview](#134-reference-overview)

## 1 Contributing to this Specification

This specification is developed on GitHub using a consensus process. Suggestions and improvements are most welcome! Consensus among stakeholders is required for a proposal to be accepted. If you're reading this, consider yourself a stakeholder and feel free to get involved in the consensus process!

This specification is lacking detail in a number of areas. You can help - please provide pull requests to fill in important gaps! In general the organization of the specification could also be improved. Suggestions welcome!

## 2 Scope

Any Azure SDK component published to Maven Central under the `com.azure` group ID scope must follow these conventions. For other sdk components, including Azure internal SDKs, these guidelines are merely recommended.

## 3 Terminology

- **Azure SDK Component**: An Azure SDK component (also referred to as 'SDK component, or simply 'component') represents the software (and associated tools, documentation, samples, etc) that exists to support a single Azure service. Each Azure SDK component will be published separately to Maven Central under a common `com.azure` groupId, but with a unique `artifactId`. These releases are performed exclusively by the Azure SDK engineering systems team. Developers will be able to consume and use each component separately as necessary to solve their use case.
- **SDK**: Software Development Kit. This refers to the entire Azure SDK for Java, itself broken up into numerous Azure SDK Components as defined above.

## 4 Pre-requisites

Before an SDK component can transition from preview to GA, the underlying service that the SDK component represents must also be in GA, with a stable protocol. If the protocol is REST API, then a stable Swagger (not preview) must be available.

## 5 Functionality

An SDK component must support 100% of the features supported by the Azure service it represents. Gaps in functionality cause confusion and frustration among developers.

## 6 Platform Support

### 6.0 Operating Systems

The SDK component should not ever need platform-specific or native code. If any such code exists, it should be specifically called out as part of the review process and appropriate justification provided.

Due to its nature, a Java-based SDK should run on Windows, macOS, and Linux without the need for any changes. Whilst development can safely occur on one platform, it is expected that developers take time to test that their sample apps execute as expected on all three major platforms.

At this stage, Android support is not required and does not have to be tested for.

### 6.1 Supported Java Versions

All Azure SDK components are baselined on Java 8. This means that all components should not use any language or API feature from a release of Java beyond Java 8. All components must be tested to ensure that they compile and run as expected on Java 8.

Code must also be compiled against the latest Java long-term support release, to ensure that code continues to compile, and unit tests must also be run. It is critical that when this is performed, that the Maven build configuration is temporarily adjusted to use the Java LTS APIs only.

SDKs must be built and tested against OpenJDK, rather than Oracle JDK or any other JDK build.

## 7 Versioning

There are two varieties of SDK component release, referred to in this document as such:

- **Snapshot Release**: These are releases made to Maven Central that have a semver version number of the form `x.y.z-SNAPSHOT`. Snapshot releases go into a separate directory on Maven Central, and version numbers do not need to be incremented or changed for each snapshot release (instead, the next release version number should be used, with `-SNAPSHOT` appended). These releases can be made as frequently as desired, and can be considered preview or beta quality. They can be released automatically as part of a CI/CD process.
- **GA Releases**: Anything that is not a snapshot release should be considered an official GA release. Official releases must be done only once per version increment, and must only be done through the engineering system pipeline.

All Maven releases must be versioned using [semantic versioning](https://semver.org/).

SDK components must not use a major version of 0, even for early preview releases.

### 7.0 Snapshot Releases

Features that are under development within a snapshot release, and which may change before GA, must be annotated with the `@Deprecated` annotation and the `@deprecated` JavaDoc tag to clearly explain that the API is experimental and may change before the next GA release. Before GA occurs, all such deprecated annotations must be removed.

### 7.1 GA Releases

When a feature is to be removed in a future major release, use the `@Deprecated` annotation and the `@deprecated` JavaDoc tag to clearly explain what is being removed, and how developers should transition to new API.

API must not be removed or changed in any release that is not a major version change.

API must not be removed or changed until there has been at least one GA release that contains the deprecation notices in the code.

Before a major release can be GA'd, there must not be any API marked as deprecated.

SDK components in GA must not have a `SNAPSHOT` tag, or any additional versioning metadata.

## 8 Naming

To make understanding our Azure SDK simpler, it is important that we apply a consistent naming policy across all of them. There are a few aspects to this: Java package names, as well as our `groupId` and `artifactId` names for use in our Maven pom.xml file. This section will cover how to determine the group and service name to use in your SDK components name, as well as how Java packages are named, but will leave the Maven pom.xml guidance until a later section in this specification.

### 8.0 Determing Group and Service Name

> TODO refer reader to external document that details how to determine which group and service name an SDK component should use.

### 8.1 Java Package Naming

Package names must be all lowercase (no camel case is allowed), and without spaces, hyphens, or underscores. For example, Azure Key Vault would be in `com.azure.<group>.keyvault` - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`.

> TODO link to shared doc on group naming scheme

All code for an SDK component must reside in a package which should take the form `com.azure.<group>.<service>[.<feature>]`. Sub-packages are fine and can be named as appropriate.

Implementation code (i.e. code that does not form part of the public API) must be appropriately handled. There are two valid arrangements for implementation code, one (or both) of which must be followed:

1. Implementation classes can be placed within a subpackage named `implementation`.
2. Implementation classes can be made package-private and placed within the same package as the consuming class.

## 9 Maven Projects

The Azure SDK, and all SDK components, will be standardized on Maven as the system to handle building and dependency management. By employing a single tool across all SDK components, builds can be related to each other to enable inheritance - that is, centralized management of build configuration and dependency versioning.

### 9.0 Project Initialization

A brand new Maven project should be initialized for each SDK component, using the [instructions provided at maven.apache.org](https://maven.apache.org/guides/getting-started/index.html#How_do_I_make_my_first_Maven_project), by running the following Maven archetype (refer to the section below to determine the groupId and artifactId to use):

```shell
mvn -B archetype:generate \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DgroupId=com.azure \
  -DartifactId=my-service
```

The following is the canonical file structure of your project after Maven has initialized it with the command shown above:

```
my-app
|-- pom.xml
`-- src
    |-- main
    |   `-- java
    |       `-- com
    |           `-- azure
    |               `-- Service.java
    `-- test
        `-- java
            `-- com
                `-- azure
                    `-- ServiceTest.java
```

SDK components must follow these conventions, however SDK components may include other files in addition.

Projects that decompose into multiple submodules work by effectively introducing an intermediate parent POM that groups together all children modules, but from the root POM there remains only the one POM that it cares about. Choosing to decompose a project into multiple submodules is a decision that an SDK component can make, but it should not be done without a good justification - in most cases a single module is the best approach. If you are interested, you can [read more about multi-module projects](https://books.sonatype.com/mvnex-book/reference/multimodule.html).

### 9.1 pom.xml

The following sections describe the pom.xml file that must be included with every SDK component. The default pom.xml file generated by the Maven archetype above is not sufficient for creating a valid Azure SDK component. A compliant pom.xml file looks like the following:

```xml
TODO
```

Not all elements of this pom.xml will be detailed in the sections below - only those where some thought must be applied to change the defaults to be specific to the specific SDK component.

> TODO reference parent pom requirements (once it is specified)

#### 9.1.0 parent

All SDK components must specify that their parent pom is the Azure SDK parent pom file (as shown in the xml above). This enables centralized dependency and build tool management.

If an SDK component is a multi-module project, the root pom.xml for that component must have as its parent the Azure SDK parent pom, but all children modules must specify their parent pom as the SDK component root pom.xml.

#### 9.1.1 groupId

Your `groupId` must be `com.azure`.

#### 9.1.2 artifactId

The `artifactId` must be of the form `azure-<group>-<service>`, for example, `azure-storage-blob`. In cases where the SDK component has multiple children modules, it is acceptable (but not preferred) for the root pom.xml `artifactId` to be of the form `azure-<group>-<service>-parent`.

#### 9.1.3 name, description, and url

These three elements should be human-readable texts no more than a sentence in length. The `name` element must take the form `Microsoft Azure SDK component for <service name>`, `description` must be a slightly longer statement along the lines of `This package contains Microsoft Azure Key Vault SDK component.`, and the `url` must point to the root of the GitHub repository containing this source code, which will be frequently (although not always or required to be) present at `https://github.com/Azure/azure-sdk-for-java`.

#### 9.1.4 scm

The source code management section specifies where the source code resides for the SDK component. If the source code is located in the https://github.com/Azure/azure-sdk-for-java repository, then the following form must be used:

```xml
<scm>
    <url>scm:git:https://github.com/Azure/azure-sdk-for-java</url>
    <connection>scm:git:git@github.com:Azure/azure-sdk-for-java.git</connection>
    <tag>HEAD</tag>
</scm>
```

In cases where the repository storing the code for the SDK component is different, substitute as necessary to ensure the correct details are provided.

#### 9.1.5 developers

The developers section of the pom.xml file must remain unchanged - it must only list a developer id of `microsoft` and a name of `Microsoft Corporation`. There should be no additional names added to represent the developers involved in the project.

## 10 GitHub Requirements

Library code must be public and open source on GitHub. Library code must be either in the [Azure GitHub organization](https://github.com/Azure/) or a module in the [Azure SDK for Java](https://github.com/Azure/azure-sdk-for-java) repo. If an independent repo is used then the repository name must be `azure-[service-name]-java`.

SDK component authors are encouraged to develop in the open on GitHub. It is recommended to have your GitHub repo be set up and active at least a month prior to your initial release.

Your SDK component's GitHub repo is your primary touch point with the developer community so it's important to keep up with the activity there. Issues and pull requests on GitHub must have an authoritative comment within 1 week of filing.

See the Microsoft Open Source Guidelines' [community section](https://docs.opensource.microsoft.com/releasing/foster-your-community.html) for more information on fostering a healthy open-source community.

### 10.0 README<span></span>.md

Your GitHub repo must include a README.md file that has the sections shown below. Rather than produce this from scratch, refer to the template readme<span></span>.md file and take that as a starting point.

> Todo link to template version when it exists

- One paragraph introduction of the service
- Maven dependency fragment (with no version - link to central document for details on how to depend on Azure SDK BOM)
- Maven dependency fragment for latest snapshot release
- Documentation
  - Link to Javadoc
  - Link to relevant quick starts and tutorials
- Samples table
- Building and testing
  - Pre-requisites
  - Building
  - Running unit tests
  - Generating JavaDoc, SpotBugs, and CheckStyle reports
- Contributing
  - Must include a reference to the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct) and a link to the CONTRIBUTING.md file
  - Should encourage developers to seek support on Stack Overflow

> TODO how to display previous releases? Have a table, use the GitHub releases feature, etc?

### 10.1 CONTRIBUTING<span></span>.md

This file must be present in your GitHub repo and must describe the process by which contributors can make contributions to the project. Any relevant processes and procedures must be documented. An example CONTRIBUTING.md is provided by the [Microsoft Open Source Guidelines](https://docs.opensource.microsoft.com/releasing/overview.html):

```md
# Contributing

This project welcomes contributions and suggestions. Most contributions require you to
agree to a Contributor License Agreement (CLA) declaring that you have the right to,
and actually do, grant us the rights to use your contribution. For details, visit
https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need
to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the
instructions provided by the bot. You will only need to do this once across all repositories using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/)
or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
```

### 10.2 LICENSE<span></span>.md

This file must be present and must contain your license text.

### 10.3 CODEOWNERS

CODEOWNERS is a GitHub standard to specify who is automatically assigned pull requests to review. This helps to prevent pull requests from languishing without review. GitHub can also be configured to require review from code owners before a pull request can be merged. Further reading is available from the following two URLs:

- [https://blog.github.com/2017-07-06-introducing-code-owners/](https://blog.github.com/2017-07-06-introducing-code-owners/)
- [https://help.github.com/articles/about-codeowners/](https://help.github.com/articles/about-codeowners/)

If the Azure SDK component goes into a shared repository, developers must edit the root-level CODEOWNERS file to ensure that it is updated to redirect all pull requests for the directory of the SDK component to point to the relevant engineers of this component. If the SDK component will exist within its own repository, then a CODEOWNERS file must be introduced and configured appropriately.

## 11 Dependencies

Each dependency we add to an SDK component increases its weight, and so it should be done with caution and careful consideration. Also, for every dependency we add, we increase the risk of having classpath collisions and dependency versioning issues.

Do not introduce new dependencies on third party libraries, without first seeking permission from the Java architect.

Do not specify or change dependency versions in your SDK component pom.xml file. All dependency versioning must be
centralized through the common parent POM (see the next section).

### 11.0 The 'Parent POM'

A parent POM lists a large number of dependencies, including their Maven `groupId`, `artifactId`, and most importantly, their `version`. When individual SDK projects depend on this parent POM, they no longer have to specify the version number for their dependencies, as these will instead be inferred from the parent POM. This means that all projects that depend on this parent POM, assuming they specify no versions in their own POM files, will be consistently using the same version. In doing so, we can avoid many of the pitfalls of dependency management, commonly referred to in Java parlance as 'classpath hell'.

It is important to note that the parent POM does have many more dependencies listed in it than any one SDK component may require to build and run. This is OK - it is designed to be the superset of all dependencies for all children project after all - and this does not mean that all dependencies are added to the project. A parent POM should be thought of as simply a map of (Maven `groupId` + Maven `artifactId`) to Maven `version` number, and nothing more.

We do not intend to 'lead the pack' and always update to the latest version of all dependencies. We will instead be
fast followers by observing community preferences, keeping ourselves informed of where the wider Java community stands on versioning and keeping in step with that.

Do use the parent POM outlined earlier in this document to refer upwards to the single, common parent.

#### 11.0.0 Adding a New Dependency

Submit a pull request to add the dependency to the parent POM. It will be swiftly reviewed by the relevant people, discussed, and a decision will then be made.

#### 11.0.1 Updating Existing Dependencies

The process for updating dependency versions is to use GitHub pull requests, and to centralise discussion within that pull request. There will be a representative from each team currently consuming the parent POM included in the CODEOWNERS file, so that all pull requests have them as code reviewers and as such notified of incoming proposals.

There will have a 3 business days time window for any dissenting opinions, after which time the pull request will be merged. If there is a disagreement, the discussion will happen in the GitHub pull request as to why, and how to proceed.

There may be rare times when a dependency in the parent POM is urgently needing to be upgraded, due to a security vulnerability being found, for example. Depending on how critical the issue is, there is a guarantee that communication will continue to happen in the standard process, however there may already be a commit and a new parent POM version ready for all SDK teams to upgrade to.

Because this new parent POM will have an updated version number, it will not impact any processes for child projects, as they will still depend on the previous release. Depending on how critical the issue is, the team responsible for maintaining this parent POM may also submit pull requests into all SDK repos to ensure they are updated to the new version.

## 12 Coding Conventions

Library APIs must be idiomatic and must follow best practices.

### 12.0 Async

Due to the nature of internet-based communication, asynchronous APIs are a must to ensure efficient use of system resources (threads and their stacks). 

Do use [Project Reactor](http://projectreactor.io) to provide end-users with a high-quality async API.

Do not use any other approaches used, such as `CompletableFuture` and [RxJava](https://github.com/ReactiveX/RxJava).

Do not provide synchronous methods in addition to async methods - instead follow the policy that developers may choose to block on an asynchronous call to make it become synchronous.

Do not provide multiple asynchronous methods for a single REST endpoint, unless to provide overloaded methods to enable alternative or optional method parameters.

Async methods must return a type that contains all information to enable a developer to inspect the metadata related to the service call (e.g. for HTTP endpoints, the async method call must return a type that enables the developer to read the headers, status code, and all other useful information).

Other streaming operations are fine, but they must be built with functionality offered in the Java SDK base class library, rather than creating new streaming APIs that only apply to a specific service. Where necessary, additional functionality should be introduced into the Azure Java SDK base class library.

### 12.1 Pipelines

> TODO use pipelines for all queries. Cover auth, telemetry, logging, tracing, retries, cancellations, etc. Refer back to general guidelines doc.

### 12.2 Logging

Logging is critical to provide developers insight into why things are operating the way they are, and to help diagnose issues that are preventing their successful use of our SDK.

Do use the APIs provided by the [SLF4J](https://www.slf4j.org/) project, as this is the only logging API to be used in all Azure Java SDK components. Refer to the [SLF4J user manual](https://www.slf4j.org/manual.html) for additional guidance.

### 12.3 Don't Return null

Sir Tony Hoare called the invention of the null reference (something he created) his '[billion-dollar mistake](https://en.wikipedia.org/wiki/Tony_Hoare)'. In Java we have become so accustomed to handling error conditions by returning `null` that it is second nature to null check everything, but in many cases there are better options. Refer to the table below for some common examples:

| Return Type               | Non-null Return Value                                                             |
|---------------------------|-----------------------------------------------------------------------------------|
| String                    | `""` (An empty string)                                                            |
| List / Set Map / Iterator | Use the `Collections` class, e.g. `Collections.emptyList()`                       |
| Stream                    | `Stream.empty()`                                                                  |
| Array                     | Return an empty, zero-length array                                                |
| All other types           | Consider using `Optional` (but read the `Optional` section later in this refcard) |

In guaranteeing to return non-null values to callers of our API, our users can opt to not include the noisiness of the null check in their code base. It is important however, that should this approach be taken, that we ensure that it is applied consistently across an entire API. It is very easy to erode trust in an API if it fails to consistently apply patterns (and in failing to do so, causes the user to encounter unexpected null pointer exceptions).

### 12.4 Functional Interfaces

In Java 8 the `@FunctionalInterface` annotation was introduced, allowing API designers to designate that a particular class is intended for use in lambda expressions. It is not necessary that a class have this annotation, but by having this associated with a class, it enables the compiler to enforce that the class has exactly one abstract method, which is the requirement for supporting lambda expressions.

From a developers point of view this is beneficial as it ensures that a class intended for use in lambda expressions does not accidentally lose that ability with the introduction of additional abstract methods - because the compiler will not allow this situation to arise.

Having said this, developers should have some reticence to creating their own functional interfaces, as recent releases of the JDK ship with 43 functional interfaces baked in. These can be broken down into six categories, each outlined below:

| Interface           | Signature             |
|---------------------|-----------------------|
| `UnaryOperator<T>`  | `T apply(T t)`        |
| `BinaryOperator<T>` | `T apply(T t1, T t2)` |
| `Predicate<T>`      | `boolean test(T t)`   |
| `Function<T,R>`     | `R apply(T t)`        |
| `Supplier<T>`       | `T get()`             |
| `Consumer<T>`       | `void accept(T t)`    |

Developers can choose to use these functional interfaces in lieu of creating their own, but there are still valid reasons for creating a custom functional interface. Examples include wanting a more descriptive name for the interface (for example, `Comparator` is a very expressive name for the function it serves), and wanting to introduce additional functionality (default methods in interfaces, or non-abstract methods in classes).

### 12.5 Tooling

#### 12.5.0 IDE Configuration

As it appears most engineers reading this document have standardised on IntelliJ IDEA for their IDE choice, a repository has been made available containing code style and inspection rules. Enabling these configuration settings in IntelliJ IDEA will ensure that all engineers will be generating code that conforms to a shared style standard, with fewer bugs and improved consistency.

Do install the addons following the [instructions provided](https://github.com/JonathanGiles/java-code-styles), and ensure that any reported warnings are resolved before GA.

#### 12.5.1 SpotBugs

All projects must be running SpotBugs using the centralised Azure SDK SpotBugs rule set. As all projects must have a Maven inheritance hierarchy that includes the Azure SDK Maven pom.xml, this is configured automatically, and the tooling will execute by calling `mvn spotbugs:spotbugs`. It will also execute as part of the build process, failing the build if any SpotBugs issue is found.

Because the build is set to fail if any SpotBugs issue is found, there must never be a time when a commit is pushed to the repo that results in build failure, as builds must run to completion locally before a repo push is made.

If a build fails, a SpotBugs HTML report can be generated by calling `mvn spotbugs:spotbugs` on the command line. This report will provide context about the failure and point the developer towards fixing it.

#### 12.5.2 CheckStyle

Similarly to SpotBugs above, CheckStyle rules will be run on each build. CheckStyle failures are less critical, but all failures must be resolved prior to a GA release.

If a build fails, a CheckStyle HTML report can be generated by calling `mvn checkstyle:checkstyle` on the command line. This report will provide context about the failure and point the developer towards fixing it.

### 12.6 Testing

#### 12.6.0 Unit Tests

Do write unit tests to ensure that the code operates as expected. A test suite should be included with each SDK component to ensure code operates as specified, and to protect against regressions.

Do ensure that the unit tests cover important code paths and that all branches in these code paths are tested comprehensively.

#### 12.6.1 Mock and Live Tests

In addition to unit tests, we must have a test suite testing functionality at a higher level. These are known as mock and live tests - they are the same test, but mock tests do not require an active service account and can therefore be run by anyone. Live tests are when the mock tests are run against an active service account.

Mock and live tests can be written as long-form unit tests, or else they may be written with other testing / mocking tools, as necessary.

Do provide all necessary mock and live tests as part of the SDK component repository.

Do ensure that all mock tests execute quickly and are integrated into the main unit test suite.

Do provide instructions as part of your Readme.<span></span>md file to detail how to execute these tests (if different than calling `mvn test`), including any environment variables, running services, etc. Test that these instructions are complete by attempting to run the tests on a separate machine.

## 13 Documentation

Quality documentation is often the difference between a productive user experience and a frustrating user experience. There are many aspects to quality documentation, including quickstarts, longer-form tutorials, code samples, and reference documentation. We must ensure that our documentation, in all forms, is of the highest quality. The key criteria in judging our documentation quality is the ease with which a person entirely unfamiliar with our SDK can understand it and become productive - we must have developer empathy.

Documentation, depending on its form and its target audience, can live in many places, but we must strive to keep these locations consistent across all services. These will be detailed in the following sections.

### 13.0 General Advice

Do not include version details when specifying Maven dependency statements. Always refer the user back to a central document detailing how to use the Azure SDK for Java BOM.

> TODO link to central document detailing Azure SDK BOM

### 13.1 Quickstarts & Tutorials

The SDK must have content contributed to at least one [quickstart](https://review.docs.microsoft.com/help/contribute/contribute-how-to-mvc-quickstart?branch=master) or [tutorial](https://review.docs.microsoft.com/help/contribute/contribute-how-to-mvc-tutorial?branch=master) (or a brand new document if necessary). This content must be discoverable from the table of contents of [docs.microsoft.com](http://docs.microsoft.com) for [Java](http://docs.microsoft.com/azure/java), but it does not need to be directly linked to from the table of contents.

### 13.2 Code Samples

> TODO determine where samples should live. Options include: the Azure Samples Gallery, a single repo per language for all samples, within the azure-sdk-for-<language> repo (in a single 'samples' directory or under each specific data plane SDK).

Your SDKs GitHub documentation must link to "Code Samples" under the "Samples" section of the ToC that links to the [Azure Samples Gallery](https://azure.microsoft.com/resources/samples/) or to a curated page in your documentation set that lists the samples available for your service.

Code samples displayed in the GitHub README<span></span>.md file must be kept to a minimum, with preference being to link people to appropriate resources rather than to overwhelm the readme file. A minimal set of critical code samples should however be included as part of the readme file.

Samples must use the latest coding conventions. It is recommended to make liberal use of modern Java syntax and API such as diamond operators, etc as they remove boilerplate from your samples and let your library's API shine through better. Do not use any language feature or API of Java beyond the current Java baseline versioned employed by the SDK, currently this is JDK 8.

At all times we should consciously ensure that we link back to docs.microsoft.com whenever relevant. Sample repos provided by the service and docs team must link back to the service on docs.microsoft.com and the reference overview page for the library.

Sample code must be maintained and must use the latest major release of the library. Sample code repos must be reviewed for freshness and at least one commit must be made to a sample repo every semester - at least to update dependencies to the latest release and to ensure that the code continues to function as expected.

Sample code snippets in quickstarts and tutorials must be able to be easily grafted from the documentation into a users own application and not tied to variable declarations not covered in previous snippets in the content.

Code snippets must be optimized for ease of reading and comprehension over code compactness and efficiency unless the article context demands otherwise.

Samples must be runnable on Windows, macOS, and Linux development environments and not tied to a non-standard developer toolchain.

Wherever possible, samples must be runnable using `mvn clean compile exec:java` without any additional requirements for setup. If there are additional requirements (e.g. starting a separate Jetty server), then these must be clearly documented in the readme.md file associated with the code sample.

Library samples must be discoverable from the [Azure Code Samples](azure.microsoft.com/resources/samples/?v=17.28&platform=java) directory.

### 13.3 JavaDoc

JavaDoc ships with a [number of tags](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) such as `@link`, `@param`, and `@return`, which provide more context to the JavaDoc tooling, and which therefore enables a richer experience when HTML output is generated. It is extremely useful when writing JavaDoc content to keep these in the back of your mind, to ensure that they are all used when relevant. To understand when to use each of these tags, refer to the ['Tag Comments' section](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) of the Java Platform, Standard Edition Tools Reference documentation.

You must annotate your source code with JavaDoc declarations.

JavaDoc must act as the specification of the API. Engineers responsible for writing API must consider it part of their job to ensure that a JavaDoc is complete, with class-level and method-level overviews for all public and protected API, specifying the expected inputs, outputs, exceptional circumstances, and any other detail.

It must be possible for anybody to clone the repo containing the SDK component and execute `mvn javadoc:javadoc` to generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

The JavaDoc output must include code snippets that users can copy/paste into their own software to kick start their own development. These code snippets need not be long screeds of code - it is best if they are constrained to no more than five to ten lines of code. These code snippets can be added to the JavaDoc of the relevant class or method over time, as users start to ask questions on the API.

JavaDoc must be inspected by developers to ensure that no implementation details leak out of public API. Developers must ensure that implementation classes are not visible in any public API as method parameters or return types. Similarly, only approved external dependencies should be visible as public API. Finally, JavaDoc must be inspected for completeness and accuracy.

> TODO The Microsoft docs team must be notified and informed about the existence of the code repository to ensure that it reliably ingests the reference documentation...

#### 13.3.0 JavaDoc for Behavioral Contracts

One underutilised aspect of JavaDoc is to use it to specify behavioral contracts. An example of a behavioral contract is the `Arrays.sort()` method, which guarantees it is 'stable' (that is, equal elements are not reordered). There is no way to easily specify this guarantee as part of the API itself (aside from making our API unwieldy, e.g. `Arrays.stableSort()`), but JavaDoc is an ideal location for this.

However, if we add behavioral contracts as part of our JavaDoc, this then becomes as much a part of our API as the API itself. We can not change this behavioral contract with the same level of consideration, as it will potentially cause downstream issues for your users.

### 13.4 Reference Overview

You must have a Java [reference overview page](https://review.docs.microsoft.com/help/contribute/contribute-reference-overviews?branch=master) for the client library under the Reference node in your content's ToC with a specific Java entry in that ToC. This reference overview must live in either the Java Azure SDK reference repo or in your own content set alongside the rest of your docs.

The reference overview page must have a link to the quickstart and available samples for the audience.
