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
  - [8 Maven Projects](#8-maven-projects)
    - [8.0 Project Initialization](#80-project-initialization)
    - [8.1 pom.xml](#81-pomxml)
      - [8.1.0 parent](#810-parent)
      - [8.1.1 groupId](#811-groupid)
      - [8.1.2 artifactId](#812-artifactid)
      - [8.1.3 name, description, and url](#813-name-description-and-url)
      - [8.1.4 scm](#814-scm)
      - [8.1.5 developers](#815-developers)
  - [9 GitHub Requirements](#9-github-requirements)
    - [9.0 README.md](#90-readmemd)
    - [9.1 CONTRIBUTING.md](#91-contributingmd)
    - [9.2 LICENSE.md](#92-licensemd)
    - [9.3 CODEOWNERS](#93-codeowners)
  - [10 Dependencies](#10-dependencies)
    - [10.0 The 'Parent POM'](#100-the-parent-pom)
      - [10.0.0 Adding a New Dependency](#1000-adding-a-new-dependency)
      - [10.0.1 Updating Existing Dependencies](#1001-updating-existing-dependencies)
  - [11 Coding Conventions](#11-coding-conventions)
    - [11.0 Modern & Idiomatic Java](#110-modern--idiomatic-java)
    - [11.1 Async](#111-async)
    - [11.2 Pipelines](#112-pipelines)
    - [11.3 Logging](#113-logging)
    - [11.4 Tooling](#114-tooling)
      - [11.4.0 SpotBugs](#1140-spotbugs)
      - [11.4.1 CheckStyle](#1141-checkstyle)
    - [11.4 Testing](#114-testing)
      - [11.4.0 Unit Tests](#1140-unit-tests)
  - [12 Documentation](#12-documentation)
    - [12.0 General Advice](#120-general-advice)
    - [12.1 Quickstarts & Tutorials](#121-quickstarts--tutorials)
    - [12.2 Code Samples](#122-code-samples)
    - [12.3 API Documentation](#123-api-documentation)
      - [12.3.0 JavaDoc](#1230-javadoc)
      - [12.3.1 JavaDoc for Behavioral Contracts](#1231-javadoc-for-behavioral-contracts)
      - [12.3.2 JavaDoc Tags](#1232-javadoc-tags)
    - [12.4 Reference Overview](#124-reference-overview)

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

An SDK component must support 100% of the features supported by the backing services. Gaps in functionality cause confusion and frustration among developers.

## 6 Platform Support

### 6.0 Operating Systems

The SDK component should never need platform-specific or native code. If any such code exists, it should be specifically called out as part of the review process.

Due to its nature, a Java-based SDK should run on Windows, macOS, and Linux without the need for any changes. Whilst development can safely occur on one platform, it is expected that developers take time to test that their sample apps execute as expected on all three major platforms.

At this stage, Android support is not required and does not have to be tested for.

### 6.1 Supported Java Versions

All Azure SDK components are baselined on Java 8. This means that all components should not use any language or API feature from a release of Java beyond Java 8, and that all components must be tested to ensure that the compile and run as expected on Java 8.

Support for versions prior to Java 8 is not required, whereas support for LTS versions beyond Java 8 is desired.

> TODO get engineering systems to have build pipelines for JDK 11 and other LTS versions to ensure we remain compatible, even while we are baselined on JDK 8.

## 7 Versioning

Maven releases must be versioned with [semver](https://semver.org/).

SDK components must not use a major version of 0, even for preview releases.

For some types of libraries and applications, semantic versioning is more of a lofty ideal than a practical specification. Also, [one person's bug might be another person's key feature](https://xkcd.com/1172/). Nonetheless, component authors are required to do the best they can to comply with semver in a way that is useful for their consumers.

### 7.0 Snapshot Releases

SDK components under preview must have a snapshot version of the format `1.0.0-SNAPSHOT`, and must be pushed to the Maven Central snapshots repository. Snapshot releases should not have additional build metadata.

Features that are under development within a snapshot release, and which may change before GA, should be annotated with the `@Deprecated` annotation and the `@deprecated` JavaDoc tag to clearly explain that the API is experimental and may change before the next GA release. Before GA occurs, all such deprecated annotations should be removed.

### 7.1 GA Releases

When a feature is to be removed in a future major release, use the `@Deprecated` annotation and the `@deprecated` JavaDoc tag to clearly explain what is being removed, and how developers should transition to new API.

API should never be removed or changed in any release that is not a major version change.

When a major version is GA'd, it is expected that there will be no API that is marked as deprecated.

SDK components in GA must not have a `SNAPSHOT` tag, or any additional versioning metadata.

## 8 Naming

To make understanding our Azure SDK simpler, it is important that we apply a consistent naming policy across all of them. There are a few aspects to this: Java package names, as well as our `groupId` and `artifactId` names for use in our Maven pom.xml file. This section will cover how to determine the group and service name to use in your SDK components name, as well as how Java packages are named, but will leave the Maven pom.xml guidance until a later section in this specification.

### 8.0 Determing Group and Service Name

> TODO refer reader to external document that details how to determine which group and service name an SDK component should use.

### 8.1 Java Package Naming

All code for an SDK component should reside in a package which should take the form `com.azure.<group>.<service>[.<feature>]`. Sub-packages are fine and can be named as appropriate.

Implementation code (i.e. code that does not form part of the public API) should be placed within a subpackage named `implementation`.

> TODO make a note in the docs section about observing that no implementation classes leak out of public API.

The package name must be all lowercase (no camel case is allowed), and without spaces, hyphens, or underscores. For example, Azure Key Vault would be in `com.azure.<group>.keyvault` - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`.

## 8 Maven Projects

> TODO describe

### 8.0 Project Initialization

A brand new Maven project should be initialized for each SDK component, using the [instructions provided at maven.apache.org](https://maven.apache.org/guides/getting-started/index.html#How_do_I_make_my_first_Maven_project), by running the following Maven archetype (refer to the section below to determine the groupId and artifactId to use):

```shell
mvn -B archetype:generate \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DgroupId=com.mycompany.app \
  -DartifactId=my-app
```

The following is the canonical file structure of your project after Maven has initialized it:

```
my-app
|-- pom.xml
`-- src
    |-- main
    |   `-- java
    |       `-- com
    |           `-- mycompany
    |               `-- app
    |                   `-- App.java
    `-- test
        `-- java
            `-- com
                `-- mycompany
                    `-- app
                        `-- AppTest.java
```

SDK components are required to follow these conventions, however SDK components may include other files. The exception to this convention is in the case of a multi-module project.

> TODO detail multi-module projects

### 8.1 pom.xml

The following sections describe the pom.xml file that must be included with every SDK component. The default pom.xml file generated by the Maven archetype above is not sufficient for creating a valid Azure SDK component. A compliant pom.xml file looks like the following:

```xml
TODO
```

Not all elements of this pom.xml will be detailed in the sections below - only those where some thought must be applied to change the defaults to be specific to the specific SDK component.

> TODO reference parent pom requirements

#### 8.1.0 parent

All SDK components must specify that their parent pom is the Azure SDK parent pom file (as shown in the xml above). This enables centralized dependency and build tooling management.

If an SDK component is a multi-module project, the root pom.xml for that component must have as its parent the Azure SDK parent pom, but all children modules should specify their parent pom as the SDK component root pom.xml.

#### 8.1.1 groupId

Your `groupId` must be `com.azure`.

#### 8.1.2 artifactId

The `artifactId` must be of the form `azure-<group>-<service>`, for example, `azure-storage-blob`. In cases where the SDK component has multiple children modules, it is acceptable (but not preferred) for the root pom.xml `artifactId` to be of the form `azure-<group>-<service>-parent`.

#### 8.1.3 name, description, and url

These three elements should be human-readable texts no more than a sentence in length. The `name` element should take the form `Microsoft Azure SDK component for <service name>`, `description` should be a slightly longer statement along the lines of `This package contains Microsoft Azure Key Vault SDK component.`, and the `url` should point to the root of the GitHub repository containing this source code, which will be frequently (althought not always or required to be) present at `https://github.com/Azure/azure-sdk-for-java`.

#### 8.1.4 scm

The source code management section specifies where the source code resides for the SDK component. If the source code is located in the https://github.com/Azure/azure-sdk-for-java repository, then the following form should be used:

```xml
<scm>
    <url>scm:git:https://github.com/Azure/azure-sdk-for-java</url>
    <connection>scm:git:git@github.com:Azure/azure-sdk-for-java.git</connection>
    <tag>HEAD</tag>
</scm>
```

In cases where the repository storing the code for the SDK component is different, substitute as necessary to ensure the correct details are provided.

#### 8.1.5 developers

The developers section of the pom.xml file must remain unchanged - it should only list a developer id of `microsoft` and a name of `Microsoft Corporation`. There should be no additional names added to represent the developers involved in the project.

## 9 GitHub Requirements

Library code must be public and open source on GitHub. Library code must be either in the Azure GitHub organization or a module in the [Azure SDK for Java](https://github.com/Azure/azure-sdk-for-java) repo. If an independent repo is used then the repository name must be `azure-[service-name]-java`.

SDK component authors are encouraged to develop in the open on GitHub. It is recommended to have your GitHub repo be set up and active at least a month prior to your initial release.

Your SDK component's GitHub repo is your primary touch point with the developer community so it's important to keep up with the activity there. Issues and pull requests on GitHub must have an authoritative comment within 1 week of filing.

See the Microsoft Open Source Guidelines' [community section](https://docs.opensource.microsoft.com/releasing/foster-your-community.html) for more information on fostering a healthy open-source community.

### 9.0 README<span></span>.md

Your GitHub repo must include a README.md file that has the sections shown below. Rather than produce this from scratch, refer to the template readme<span></span>.md file and take that as a starting point.

> Todo linke to template version when it exists

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

### 9.1 CONTRIBUTING<span></span>.md

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

### 9.2 LICENSE<span></span>.md

This file must be present and must contain your license text. See section 6.1 for more details.

### 9.3 CODEOWNERS

CODEOWNERS is a GitHub standard to specify who is automatically assigned pull requests to review. This helps to prevent pull requests from languishing without review. GitHub can also be configured to require review from code owners before a pull request can be merged. Further reading is available from the following two URLs:

- [https://blog.github.com/2017-07-06-introducing-code-owners/](https://blog.github.com/2017-07-06-introducing-code-owners/)
- [https://help.github.com/articles/about-codeowners/](https://help.github.com/articles/about-codeowners/)

If the Azure SDK component goes into a shared repository, developers must find the root-level CODEOWNERS file and ensure that it is updated to redirect all pull requests for the directory of the SDK component to point to the relevant engineers of this component. If the SDK component will exist within its own repository, then a CODEOWNERS file must be introduced and configured appropriately.

## 10 Dependencies

Each dependency we add to an SDK component increases its weight, and so it should be done with caution and careful consideration.

We do not intend to 'lead the pack' and always update to the latest version of all dependencies. We will instead be
fast followers and keep ourselves informed of where the wider Java community stands on versioning.

### 10.0 The 'Parent POM'

Because each SDK component pom.xml file refers upwards to a parent for all Azure SDK components, there is a centralized location for dependencies to be detailed.

A parent POM lists a large number of dependencies, including their Maven `groupId`, `artifactId`, and most importantly, their `version`. When individual SDK projects depend on this parent POM, they no longer have to specify the version number for their dependencies, as these will instead be inferred from the parent POM. This means that all projects that depend on this parent POM, assuming they specify no versions in their own POM files, will be consistently using the same version. In doing so, we can avoid many of the pitfalls of dependency management, commonly referred to in Java parlance as 'classpath hell'.

It is important to note that the parent POM does have many more dependencies listed in it than any one SDK component may require to build and run. This is OK - it is designed to be the superset of all dependencies for all children project after all - and this does not mean that all dependencies are added to the project. A parent POM should be thought of as simply a map of (Maven `groupId` + Maven `artifactId`) to Maven `version` number, and nothing more.

#### 10.0.0 Adding a New Dependency

Submit a pull request to add the dependency to the parent POM. It will be swiftly reviewed by the relevant people, discussed, and a decision will then be made.

#### 10.0.1 Updating Existing Dependencies

The process for updating dependency versions is to use GitHub pull requests, and to centralise discussion within that pull request. There will be a representative from each team currently consuming the parent POM included in the CODEOWNERS file, so that all pull requests have them as code reviewers and as such notified of incoming proposals.

There will have a 3 business days time window for any dissenting opinions, after which time the pull request will be merged. If there is a disagreement, the discussion will happen in the GitHub pull request as to why, and how to proceed.

There may be rare times when a dependency in the parent POM is urgently needing to be upgraded, due to a security vulnerability being found, for example. Depending on how critical the issue is, there is a guarantee that communication will continue to happen in the standard process, however there may already be a commit and a new parent POM version ready for all SDK teams to upgrade to.

Because this new parent POM will have an updated version number, it will not impact any processes for child projects, as they will still depend on the previous release. Depending on how critical the issue is, the team responsible for maintaining this parent POM may also submit pull requests into all SDK repos to ensure they are updated to the new version.

## 11 Coding Conventions

Library APIs must be idiomatic and must follow best practices.

> TODO Discuss cancellations

### 11.0 Modern & Idiomatic Java

As noted elsewhere, SDK components should be baselined on JDK 8. This means we can use language and API features in all releases of Java up to and including the 8 release, but we should ensure that whatever we write compiles against Java 8. Additionally, all SDKs should also be built against the latest LTS release of the JDK. If a build failure is encountered, this should be discussed as part of the SDK review, and a decision made as to when this failure should be resolved.

SDKs must be built and tested against OpenJDK, rather than Oracle JDK or any other JDK build.

> TODO talk about functional interfaces, lambda expressions, etc

### 11.1 Async

Due to the nature of internet-based communication, asynchronous APIs are a must to ensure high-performance SDKs. The approach that Azure Java SDKs will take is to make use of [Project Reactor](http://projectreactor.io). There should be no other async approach taken, including `CompletableFuture` and [RxJava](https://github.com/ReactiveX/RxJava).

There should not be multiple asynchronous methods for a single REST endpoint, except if they overload to provide alternative or optional method parameters.

Async methods should return a type that contains all information to enable a developer to inspect the metadata related to the service call (e.g. for HTTP endpoints, the async method call should return a type that enables the developer to read the headers, status code, and all other useful information).

Other streaming operations are fine, but they should be built with functionality offered in the Java SDK base class library, rather than creating new streaming APIs that only apply to a specific service.

### 11.2 Pipelines

> TODO use pipelines for all queries. Cover auth, telemetry, logging, tracing, retries, etc. Refer back to general guidelines doc.

### 11.3 Logging

> TODO talk about slf4j, etc. Refer back to general guidelines doc.

### 11.4 Tooling

#### 11.4.0 SpotBugs

All projects must be running SpotBugs using the centralised Azure Java SDK SpotBugs rule set. Maven pom.xml files that specify the centrali Azure Java SDK parent pom as their parent will have this configured automatically, and the tooling should execute simply by calling `mvn spotbugs:spotbugs`.

The generated HTML report should be reviewed throughout the development process, with the expectation that at each GA release there are zero SpotBugs issues being reported.

> TODO SpotBugs may be configured to run on each build, and fail the build if it detects issues - so this may become a non-issue

#### 11.4.1 CheckStyle

>> TODO

### 11.4 Testing

#### 11.4.0 Unit Tests

> TODO talk about JUnit 5 for unit tests

## 12 Documentation

Quality documentation is often the difference between a productive user experience and a frustrating user experience. There are many aspects to quality documentation, including quickstarts, longer-form tutorials, code samples, and reference documentation. We must ensure that our documentation, in all forms, is of the highest quality. The key criteria in judging our documentation quality is the ease with which a person entirely unfamiliar with our SDK can understand it and become productive - we must have developer empathy.

Documentation, depending on its form and its target audience, can live in many places, but we must strive to keep these locations consistent across all services. These will be detailed in the following sections.

### 12.0 General Advice

Maven dependency statements, when displayed as part of documentation, should be versionless, and should always link the reader back to a central document detailing how to make use of the Azure Maven BOM for dependency versioning management.

> TODO link to central document detailing Azure SDK BOM

### 12.1 Quickstarts & Tutorials

The SDK must have content contributed to at least one [quickstart](https://review.docs.microsoft.com/help/contribute/contribute-how-to-mvc-quickstart?branch=master) or [tutorial](https://review.docs.microsoft.com/help/contribute/contribute-how-to-mvc-tutorial?branch=master) (or a brand new document if necessary). This content must be discoverable from the table of contents of [docs.microsoft.com](http://docs.microsoft.com) for [Java](http://docs.microsoft.com/azure/java), but it does not need to be directly linked to from the table of contents.

### 12.2 Code Samples

> TODO determine where samples should live. Options include: the Azure Samples Gallery, a single repo per language for all samples, within the azure-sdk-for-<language> repo (in a single 'samples' directory or under each specific data plane SDK).

Your SDKs GitHub documentation must link to "Code Samples" under the "Samples" section of the ToC that links to the [Azure Samples Gallery](https://azure.microsoft.com/resources/samples/) or to a curated page in your documentation set that lists the samples available for your service.

Code samples displayed in the GitHub README<span></span>.md file should be kept to a minimum, with preference being to link people to appropriate resources rather than to overwhelm the readme file. A minimal set of critical code samples can however be included as part of the readme file.

Samples must use the latest coding conventions. It is recommended to make liberal use of modern Java syntax and API such as diamond operators, etc as they remove boilerplate from your samples and let your library's API shine through better. Do not use any language feature or API of Java beyond the current Java baseline versioned employed by the SDK, currently this is JDK 8.

At all times we should consciously ensure that we link back to docs.microsoft.com whenever relevant. Sample repos provided by the service and docs team must link back to the service on docs.microsoft.com and the reference overview page for the library.

Sample code should be maintained and must use the latest major release of the library. Sample code repos should be reviewed for freshness and at least one commit should be made to a sample repo every semester - at least to update dependencies to the latest release and to ensure that the code continues to function as expected.

Sample code snippets in quickstarts and tutorials should be easily grafted from the documentation into a users own application and not tied to variable declarations not covered in previous snippets in the content.

Code snippets should be optimized for ease of reading and comprehension over code compactness and efficiency unless the article context demands otherwise.

Samples must be runnable on Windows, macOS, and Linux development environments and not tied to our developer toolchain.

Sample code repos should have clear names, descriptions and README files per the [samples guidance](https://review.docs.microsoft.com/help/contribute/contribute-get-started-azure-samples?branch=master) so that they make sense if accessed outside the context of docs.microsoft.com or the [Azure samples portal](https://azure.microsoft.com/resources/samples).

Wherever possible, samples must be runnable using `mvn clean compile exec:java` without any additional requirements for setup. If there are additional requirements (e.g. starting a separate Jetty server), then these must be clearly documented in the readme.md file associated with the code sample.

> TODO Library samples must be discoverable from azure.microsoft.com/resources/samples/?v=17.28&platform=java

### 12.3 API Documentation

API documentation must be able to be auto-generated from source code annotations.

It should be possible for anybody to clone the repo containing the SDK and execute `mvn javadoc:javadoc` to generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

> TODO The Microsoft docs team must be notified and informed about the existence of the code repository to ensure that it reliably ingests the reference documentation...

#### 12.3.0 JavaDoc

You must annotate your source code with JavaDoc declarations.

JavaDoc should act as the specification of the API. Engineers responsible for writing API should consider it part of their job to ensure that a JavaDoc is complete, with class-level and method-level overviews, specifying the expected inputs, outputs, exceptional circumstances, and any other detail.

The JavaDoc output must include code snippets that users can copy/paste into their own software to kick start their own development. These code snippets need not be long screeds of code - it is best if they are constrained to no more than five to ten lines of code. These code snippets can be added to the JavaDoc of the relevant class or method over time, as users start to ask questions on the API.

The value of JavaDoc extends beyond offering it to other developers - it can also help us. This is because JavaDoc gives us a filtered view of our SDK by only showing API that is intended for public use. If we establish a routine of regularly generating JavaDoc we can review our API for issues such as missing JavaDoc, leaking implementation classes or external dependencies, and other things that aren't what we expect.

> TODO Must exclude Java classes and interfaces that are not part of the Java API – using the “Excluding Packages” feature in Maven Javadoc plugin

#### 12.3.1 JavaDoc for Behavioral Contracts

One underutilised aspect of JavaDoc is to use it to specify behavioral contracts. An example of a behavioral contract is the `Arrays.sort()` method, which guarantees it is 'stable' (that is, equal elements are not reordered). There is no way to easily specify this guarantee as part of the API itself (aside from making our API unwieldy, e.g. `Arrays.stableSort()`), but JavaDoc is an ideal location for this.

However, if we add behavioral contracts as part of our JavaDoc, this then becomes as much a part of our API as the API itself. We can not change this behavioral contract with the same level of consideration, as it will potentially cause downstream issues for your users.

#### 12.3.2 JavaDoc Tags

JavaDoc ships with a [number of tags](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) such as `@link`, `@param`, and `@return`, which provide more context to the JavaDoc tooling, and which therefore enables a richer experience when HTML output is generated. It is extremely useful when writing JavaDoc content to keep these in the back of your mind, to ensure that they are all used when relevant. To understand when to use each of these tags, refer to the ['Tag Comments' section](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) of the Java Platform, Standard Edition Tools Reference documentation.

### 12.4 Reference Overview

You must have a Java [reference overview page](https://review.docs.microsoft.com/help/contribute/contribute-reference-overviews?branch=master) for the client library under the Reference node in your content's ToC with a specific Java entry in that ToC. This reference overview must live in either the Java Azure SDK reference repo or in your own content set alongside the rest of your docs.

The reference overview page must have a link to the quickstart and available samples for the audience.