---
title: "Spring Guidelines"
keywords: guidelines java spring
permalink: java_spring.html
folder: java
sidebar: general_sidebar
---

Providing the Spring ecosystem with a first-class experience is of the utmost importance. The guidelines below are in addition to the [standard Java design guidelines](https://azure.github.io/azure-sdk/java_introduction.html), overriding the guidance as appropriate.

## Namespaces

{% include requirement/MUST id="java-spring-namespaces" %} ensure all Java packages are named using the form `com.azure.spring.<group>.<service>[.<feature>]`.

{% include requirement/MUST id="java-spring-same-group" %} use the same group, service, and feature naming as is used by the underlying Java client library.

{% include requirement/MUST id="java-spring-implementation" %} put all non-public API under an `implementation` package under the root namespace.

### Maven

{% include requirement/MUST id="java-spring-maven-groupid" %} use the group ID of `com.azure`.

{% include requirement/MUST id="java-spring-maven-artifactid" %} specify the `artifactId` to be of the form `azure-spring-boot-starter-<group>-<service>[-<feature>]`, for example, `azure-spring-boot-starter-storage-blob` or `azure-spring-boot-starter-security-keyvault-secrets`.

{% include requirement/MUST id="java-spring-azure-sdk-bom" %} include a `dependencyManagement` dependency on the Azure Java SDK BOM, so that users who use Azure Spring libraries can bring in additional dependencies on other Azure Java client libraries without needing to choose versions.

## Versioning

Spring integration modules must be versioned in a way that enables the following goals:

1. Each Spring integration module must be able to release at different release cadences.
2. Each Spring integration module must have full semantic versioning for major, minor, and patch versions, in all releases. Versioning must not be tied to the Spring dependency version as in earlier iterations of the Azure Spring integration modules.
3. Allow developers to easily choose Spring integration modules which work together.

{% include requirement/MUST id="java-spring-supported-versions" %} ensure that all releases of a Spring integration module support all active versions (as of the time of release) of the corresponding Spring API.

{% include requirement/MUST id="java-spring-deps-provided" %} add Spring API dependencies as `provided` in the Spring integration module POM files, so that it is the users responsibility to provide a specific dependency in their own codebase.

{% include requirement/MUST id="java-spring-classifiers" %} add Maven classifiers to releases if a Spring integration module cannot support all active versions of the corresponding Spring API. For example, if a Spring integration module needs to support Spring Boot 2.2.x and 2.3.x, but cannot due to technical contraints, two versions of the Spring integration module must be released, with classifiers `springboot_2_2` and `springboot_2_3`.

{% include requirement/MUST id="java-spring-bom" %} provide a Spring-specific BOM for users. This BOM must contain versions of all Spring integration modules that are known to work together (and have a single set of dependency versions). It must also include appropriate references to Azure Java SDK and Spring BOMs.

{% include requirement/MUST id="java-spring-bom-naming" %} name the Spring-specific BOM specifically after the corresponding Spring version, e.g. `azure-spring-boot-2-2-bom`.

{% include requirement/MUST id="java-spring-bom-docs" %} encourage users to use the Spring-specific BOM for their chosen version of Spring rather than specific versions of each Spring integration module, such that they need not worry about Maven classifiers and other versioning issues.

## Dependencies

{% include requirement/MUSTNOT id="java-spring-dependency-approval" %} introduce dependencies on libraries, or change dependency versions, without discussion with the Java architect. Each dependency must receive explicit approval and be added to the dependency allow list before it may be used.

{% include requirement/MUSTNOT id="java-spring-dependency-conflicts" %} introduce dependencies on library versions that conflict with the transitive dependencies of Spring libraries.

{% include requirement/MUST id="java-spring-com-azure-deps" %} make use of `com.azure` client libraries only - do not mix older `com.microsoft.azure` client libraries into the dependency hierarchy.

{% include requirement/MUST id="java-spring-dependency-minimal" %} keep dependencies to the minimal required set.

## Logging

{% include requirement/MUSTNOT id="java-spring-logging" %} use the `ClientLogger` logging APIs.

## Tracing

{% include requirement/MUST id="java-spring-tracing" %} ensure that all Azure Spring libraries fully integrate with the tracing capabilities available in the Azure Java client libraries.

{% include requirement/MUST id="java-spring-tracing-sleuth" %} ensure that all Azure Spring libraries work appropriately with Spring Sleuth, and that tracing information is appropriately exported.

## Performance

{% include requirement/MUST id="java-spring-performance-baseline" %} ensure, through appropriate benchmarks (developed in conjuction with the Java SDK team) that performance of all Spring libraries is at an equivalent level to the same operation being performed directly through the Java client library.
