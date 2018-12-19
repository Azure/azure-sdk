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
  - [8 Naming](#8-naming)
    - [8.0 Determing Group and Service Name](#80-determing-group-and-service-name)
    - [8.1 Java Package Naming](#81-java-package-naming)
  - [8 Maven Projects](#8-maven-projects)
    - [8.0 Project Initialization](#80-project-initialization)
    - [8.1 pom.xml](#81-pomxml)
      - [8.1.0 groupId](#810-groupid)
      - [8.1.1 artifactId](#811-artifactid)
      - [8.1.2 name, description, and url](#812-name-description-and-url)
      - [8.1.3 scm](#813-scm)
      - [8.1.4 author](#814-author)
  - [9 GitHub Requirements](#9-github-requirements)
    - [9.0 README.md](#90-readmemd)
    - [9.1 CONTRIBUTING.md](#91-contributingmd)
    - [9.2 LICENSE.md](#92-licensemd)
    - [9.3 CODEOWNERS](#93-codeowners)
  - [10 Dependencies](#10-dependencies)
  - [11 Coding Conventions](#11-coding-conventions)
    - [11.0 Modern & Idiomatic Java](#110-modern--idiomatic-java)
    - [11.1 Async](#111-async)
    - [11.2 Pipelines](#112-pipelines)
    - [11.3 Logging](#113-logging)
    - [11.4 Testing](#114-testing)
      - [11.4.0 Unit Tests](#1140-unit-tests)
  - [12 Documentation](#12-documentation)
    - [12.0 Quickstarts & Tutorials](#120-quickstarts--tutorials)
    - [12.1 Code Samples](#121-code-samples)
    - [12.2 API Documentation](#122-api-documentation)
      - [12.2.0 JavaDoc](#1220-javadoc)
      - [12.2.1 JavaDoc for Behavioral Contracts](#1221-javadoc-for-behavioral-contracts)
      - [12.2.2 JavaDoc Tags](#1222-javadoc-tags)
    - [12.3 Reference Overview](#123-reference-overview)

## 1 Contributing to this Specification

This specification is developed on GitHub using a consensus process. Suggestions and improvements are most welcome! Consensus among stakeholders is required for a proposal to be accepted. If you're reading this, consider yourself a stakeholder and feel free to get involved in the consensus process!

This specification is lacking detail in a number of areas. You can help - please provide pull requests to fill in important gaps! In general the organization of the specification could also be improved. Suggestions welcome!

## 2 Scope

Any SDK published to Maven Central under the `com.azure` group ID scope must follow these conventions. For other SDKs, including Azure internal SDKs, these guidelines are merely recommended.

## 3 Terminology

- **SDK**: Software Development Kit. This refers to a release of Java class, JavaDoc, and source code jar files published to Maven Central, typically as an official GA release, but it may also be used to refer to a snapshot release. These releases are performed exclusively by the Azure SDK engineering systems team.

## 4 Pre-requisites

Before an SDK can transition from preview to GA, the underlying service that the SDK represents must also be in GA, with a stable protocol. If the protocol is REST API, then a stable Swagger (not preview) must be available.

## 5 Functionality

An SDK must support 100% of the features supported by the backing services. Gaps in functionality cause confusion and frustration among developers.

## 6 Platform Support

### 6.0 Operating Systems

The SDK should never need platform-specific or native code. If any such code exists, it should be specifically called out as part of the SDK review process.

Due to its nature, a Java-based SDK should run on Windows, macOS, and Linux without the need for any changes. Whilst development can safely occur on one platform, it is expected that developers take time to test that their sample apps execute as expected on all three major platforms.

At this stage, Android support is not required and does not have to be tested for.

### 6.1 Supported Java Versions

All Azure SDKs are baselined on Java 8. This means that all SDKs should not use any language or API feature from a release of Java beyond Java 8, and that all SDKs must be tested to ensure that the compile and run as expected on Java 8.

Support for versions prior to Java 8 is not required, whereas support for LTS versions beyond Java 8 is desired.

> TODO get engineering systems to have build pipelines for JDK 11 and other LTS versions to ensure we remain compatible, even while we are baselined on JDK 8.

## 7 Versioning

Maven releases must be versioned with [semver](https://semver.org/).

When a feature is to be removed in a future release, use the `@Deprecated` annotation and the `@deprecated` JavaDoc tag to clearly explain what is being removed, and how developers should transition to new API.

SDKs in GA must not have a `SNAPSHOT` tag, or any additional versioning metadata.

SDKs under preview must have a pre-release version of the format `1.0.0-SNAPSHOT`, and must be pushed to the Maven Central snapshots repository. Snapshot releases should not have additional build metadata.

SDKs must not use a major version of 0, even for preview SDKs.

For some types of libraries and applications, semantic versioning is more of a lofty ideal than a practical specification. Also, [one person's bug might be another person's key feature](https://xkcd.com/1172/). Nonetheless, SDK authors are required to do the best they can to comply with semver in a way that is useful for their consumers.

## 8 Naming

To make understanding our SDKs simpler, it is important that we apply a consistent naming policy across all of them. There are a few aspects to this: Java package names, as well as our `groupId` and `artifactId` names for use in our Maven pom.xml file. This section will cover how to determine the group and service name to use in your SDKs name, as well as how Java packages are named, but will leave the Maven pom.xml guidance until a later section in this specification.

### 8.0 Determing Group and Service Name

> TODO refer reader to external document that details how to determine which group and service name an SDK should use.

### 8.1 Java Package Naming

All code for an SDK should reside in a package which should take the form `com.azure.<group>.<service>[.<feature>]`. Sub-packages are fine and can be named as appropriate.

Implementation code (i.e. code that does not form part of the public API) should be placed within a subpackage named `implementation`.

> TODO make a note in the docs section about observing that no implementation classes leak out of public API.

The package name must be all lowercase (no camel case is allowed), and without spaces, hyphens, or underscores. For example, Azure Key Vault would be in `com.azure.<group>.keyvault` - note that the two words 'Key' and 'Vault' are brought together to `keyvault`, instead of `keyVault`, `key_vault`, or `key-vault`.

## 8 Maven Projects

> TODO describe

### 8.0 Project Initialization

A brand new Maven project should be initialized for each SDK, using the [instructions provided at maven.apache.org](https://maven.apache.org/guides/getting-started/index.html#How_do_I_make_my_first_Maven_project), by running the following Maven archetype (refer to the section below to determine the groupId and artifactId to use):

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

SDKs are required to follow these conventions where applicable. SDKs may include other files.

### 8.1 pom.xml

The following sections describe the pom.xml file that must be included with every SDK. The default pom.xml file generated by the Maven archetype above is not sufficient for creating a valid Azure SDK. A compliant pom.xml file looks like the following:

```xml
TODO
```

Not all elements of this pom.xml will be detailed in the sections below - only those where some thought must be applied to change the defaults to be specific to the specific SDK.

> TODO reference parent pom requirements

#### 8.1.0 groupId

Your `groupId` must be `com.azure`.

#### 8.1.1 artifactId

The `artifactId` must be of the form `azure-<group>-<service>`, for example, `azure-storage-blob`. In cases where the SDK has multiple children modules, it is acceptable (but not preferred) for the root pom.xml `artifactId` to be of the form `azure-<group>-<service>-parent`.

#### 8.1.2 name, description, and url

These three elements should be human-readable texts no more than a sentence in length. The `name` element should take the form `Microsoft Azure SDK for <service name>`, `description` should be a slightly longer statement along the lines of `This package contains Microsoft Azure Key Vault SDK.`, and the `url` should point to the root of the GitHub repository containing this source code, which will be frequently (althought not always or required to be) present at `https://github.com/Azure/azure-sdk-for-java`.

#### 8.1.3 scm

The source code managament section specifies where the source code resides for the SDK. If the source code is located in the https://github.com/Azure/azure-sdk-for-java repository, then the following form should be used:

```xml
<scm>
    <url>scm:git:https://github.com/Azure/azure-sdk-for-java</url>
    <connection>scm:git:git@github.com:Azure/azure-sdk-for-java.git</connection>
    <tag>HEAD</tag>
</scm>
```

In cases where the repository storing the code for the SDK is different, substitute as necessary to ensure the correct details are provided.

#### 8.1.4 author

> TODO must be Microsoft Corporation

## 9 GitHub Requirements

Library code must be public and open source on GitHub. Library code must be either in the Azure GitHub organization or a module in the [Azure SDK for Java](https://github.com/Azure/azure-sdk-for-java) repo. If an independent repo is used then the repository name must be `azure-[service-name]-java`.

SDK authors are encouraged to develop in the open on GitHub. It is recommended to have your GitHub repo be set up and active at least a month prior to your initial release.

Your SDK's GitHub repo is your primary touch point with the developer community so it's important to keep up with the activity there. Issues and pull requests on GitHub must have an authoritative comment within 1 week of filing.

See the Microsoft Open Source Guidelines' [community section](https://docs.opensource.microsoft.com/releasing/foster-your-community.html) for more information on fostering a healthy open-source community.

### 9.0 README<span></span>.md

Your GitHub repo must include a README.md file that describes at a minimum:

- The library
- Maven dependency fragment for the most recent release
- Maven dependency fragment for snapshots
- Link to Javadoc
- Pre-requisites
- How to build
- How to run check style
- How to run tests
- How to contribute code,
- How to checkout released versions of source code (including Javadoc)
- How to migrate code to the most recent version of the library
- Links to sample code and a link back to docs.microsoft.com/java/azure (Azure for Java developers)

Additionally, your project must include a reference to the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct) and a link to the CONTRIBUTING.md file.

> TODO refer to template version of this readme.md file

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

> TODO describe what CODEOWNERS is and what should be done

## 10 Dependencies

Each dependency we add to an SDK increases its weight, and so it should be done with caution and careful consideration.

Because each SDK pom.xml file refers upwards to a parent pom for all Azure SDKs, there is a centralized location for dependencies to be detailed. In Maven, when a parent pom.xml specifies a list of dependencies, this does not imply that all such dependencies are imported into the project. In this way, the parent pom.xml dependencies can be thought of as nothing more than a mapping from `groupId:artifactId` to `version`. Because this feature exists, all pom.xml files for all SDKs should rarely specify a specific version for a dependency - this should instead be inherited from the parent pom. In doing so, we can avoid many of the pitfalls of dependency management, commonly referred to in Java parlance as 'classpath hell'.

> TODO document how to add dependencies to the parent pom, how to update versions, etc

## 11 Coding Conventions

Library APIs must be idiomatic and mst follow best practices.

> TODO Discuss cancellations

### 11.0 Modern & Idiomatic Java

As noted elsewhere, SDKs should be baselined on JDK 8. This means we can use language and API features in all releases of Java up to and including the 8 release, but we should ensure that whatever we write compiles against Java 8. Additionally, all SDKs should also be built against the latest LTS release of the JDK. If a build failure is encountered, this should be discussed as part of the SDK review, and a decision made as to when this failure should be resolved.

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

### 11.4 Testing

#### 11.4.0 Unit Tests

> TODO talk about JUnit 5 for unit tests

## 12 Documentation

Quality documentation is often the difference between a productive user experience and a frustrating user experience. There are many aspects to quality documentation, including quickstarts, longer-form tutorials, code samples, and reference documentation. We must ensure that our documentation, in all forms, is of the highest quality. The key criteria in judging our documentation quality is the ease with which a person entirely unfamiliar with our SDK can understand it and become productive - we must have developer empathy.

Documentation, depending on its form and its target audience, can live in many places, but we must strive to keep these locations consistent across all services. These will be detailed in the following sections.

### 12.0 Quickstarts & Tutorials

The SDK must have content contributed to at least one [Quickstart](https://review.docs.microsoft.com/help/contribute/contribute-how-to-mvc-quickstart?branch=master) or [tutorial](https://review.docs.microsoft.com/help/contribute/contribute-how-to-mvc-tutorial?branch=master) (or a brand new document if necessary). This content must be discoverable from the Table of Contents of [docs.microsoft.com](http://docs.microsoft.com) for [Java](http://docs.microsoft.com/azure/java).

Maven dependency statements for the SDK should be versionless, and should always link back to the central document detailing how to make use of the Azure Maven BOM for dependency versioning management.

### 12.1 Code Samples

Your SDKs GitHub documentation must link to "Code Samples" under the "Samples" section of the ToC that links to the [Azure Samples Gallery](https://azure.microsoft.com/resources/samples/) or to a curated page in your documentation set that lists the samples available for your service.

Samples must use the latest coding conventions. It is recommended to make liberal use of modern Java syntax and API such as diamond operators, etc as they remove boilerplate from your samples and let your library's API shine through better. Do not use any language feature or API of Java beyond the current Java baseline versioned employed by the SDK, currently this is JDK 8.

At all times we should consciously ensure that we link back to docs.microsoft.com whenever relevant. Sample repos provided by the service and docs team must link back to the service on docs.microsoft.com and the reference overview page for the library.

Sample code should be maintained and must use the latest major release of the library. Sample code repos should be reviewed for freshness and at least one commit should be made to a sample repo every semester.

Sample code snippets in quickstarts and tutorials should be easily grafted from the documentation into a users own application and not tied to variable declarations not covered in previous snippets in the content.

Code snippets should be optimized for ease of reading and comprehension over code compactness and efficiency unless the article context demands otherwise.

Samples must be runnable on macOS and Linux development environments and not tied to our developer toolchain.

Sample code repos should have clear names, descriptions and README files per the [samples guidance](https://review.docs.microsoft.com/help/contribute/contribute-get-started-azure-samples?branch=master) so that they make sense if accessed outside the context of docs.microsoft.com or the [Azure samples portal](https://azure.microsoft.com/resources/samples).

> TODO Samples can be run using "$ mvn clean compile exec:java" or "$ mvn clean package" (as appropriate) without any additional requirements for setup

> TODO Library samples must be discoverable from azure.microsoft.com/resources/samples/?v=17.28&platform=java

### 12.2 API Documentation

API documentation must be auto-generated from source code annotations.

It should be possible for anybody to clone the repo containing the SDK and execute `mvn javadoc:javadoc` to generate the full and complete JavaDoc output for the code, without any need for additional processing steps.

> TODO The Microsoft docs team must be notified and informed about the existence of the code repository to ensure that it reliably ingests the reference documentation...

#### 12.2.0 JavaDoc

You must annotate your source code with JavaDoc declarations.

JavaDoc should act as the specification of the API. Engineers responsible for writing API should consider it part of their job to ensure that a JavaDoc is complete, with class-level and method-level overviews, specifying the expected inputs, outputs, exceptional circumstances, and any other detail. Whilst this documentation acts as the specification, it is important that it does not become an overly detailed guide to the programmer, or discuss how the implementation works.

In an ideal world, the effort to create high quality JavaDoc would go a step further, to also include code snippets that users can copy/paste into their own software to kick start their own development. These code snippets need not be long screeds of code - it is best if they are constrained to no more than five to ten lines of code. These code snippets can be added to the JavaDoc of the relevant class or method over time, as users start to ask questions on the API.

The value of JavaDoc extends beyond offering it to other developers - it can also help us. This is because JavaDoc gives us a filtered view of our SDK by only showing API that is intended for public use. If we establish a routine of regularly generating JavaDoc we can review our API for issues such as missing JavaDoc, leaking implementation classes or external dependencies, and other things that aren't what we expect.

> TODO Must exclude Java classes and interfaces that are not part of the Java API – using the “Excluding Packages” feature in Maven Javadoc plugin

#### 12.2.1 JavaDoc for Behavioral Contracts

One underutilised aspect of JavaDoc is to use it to specify behavioral contracts. An example of a behavioral contract is the `Arrays.sort()` method, which guarantees it is 'stable' (that is, equal elements are not reordered). There is no way to easily specify this guarantee as part of the API itself (aside from making our API unwieldy, e.g. `Arrays.stableSort()`), but JavaDoc is an ideal location for this.

However, if we add behavioral contracts as part of our JavaDoc, this then becomes as much a part of our API as the API itself. We can not change this behavioral contract with the same level of consideration, as it will potentially cause downstream issues for your users.

#### 12.2.2 JavaDoc Tags

JavaDoc ships with a [number of tags](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) such as `@link`, `@param`, and `@return`, which provide more context to the JavaDoc tooling, and which therefore enables a richer experience when HTML output is generated. It is extremely useful when writing JavaDoc content to keep these in the back of your mind, to ensure that they are all used when relevant. To understand when to use each of these tags, refer to the ['Tag Comments' section](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/javadoc.html#CHDJFCCC) of the Java Platform, Standard Edition Tools Reference documentation.

### 12.3 Reference Overview

You must have a Java [reference overview page](https://review.docs.microsoft.com/help/contribute/contribute-reference-overviews?branch=master) for the client library under the Reference node in your content's ToC with a specific Java entry in that ToC. This reference overview must live in either the Java Azure SDK reference repo or in your own content set alongside the rest of your docs.

The reference overview page must have a link to the quickstart and available samples for the audience.