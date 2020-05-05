---
title: "Spring Guidelines"
keywords: guidelines java spring
permalink: java_spring.html
folder: java
sidebar: java_sidebar
---

Providing the Spring ecosystem with a first-class experience is of the utmost importance. The guidelines below are in addition to the standard Java design guidelines, overriding the guidance as appropriate.

## Namespaces

{% include requirement/MUST id="java-spring-namespaces" %} ensure all Java packages are named using the form `com.azure.spring.<group>.<service>[.<feature>]`.

{% include requirement/MUST id="java-spring-same-group" %} use the same group, service, and feature naming as is used by the underlying Java client library.

{% include requirement/MUST id="java-spring-implementation" %} put all non-public API under an `implementation` package under the root namespace.

### Maven

{% include requirement/MUST id="java-spring-maven-groupid" %} use the group ID of `com.azure`.

{% include requirement/MUST id="java-spring-maven-artifactid" %} specify the `artifactId` to be of the form `azure-spring-boot-starter-<group>-<service>[-<feature>]`, for example, `azure-spring-boot-starter-storage-blob` or `azure-spring-boot-starter-security-keyvault-secrets`.

{% include requirement/MUST id="java-spring-azure-sdk-bom" %} include a `dependencyManagement` dependency on the Azure Java SDK BOM, so that users who use Azure Spring libraries can bring in additional dependencies on other Azure Java client libraries without needing to choose versions.

## Versioning

{% include requirement/MUST id="java-spring-versioning" %} version all libraries by adopting the major and minor version numbers of the supported Spring release as the major and minor number of the library. For example, if the library has a dependency on Spring 2.3.4, then our library should be versioned as 2.3.0. If we do another release, it will be 2.3.1, then 2.3.2, and so on.

{% include requirement/MUSTNOT id="java-spring-breaking-changes" %} introduce breaking changes until the Spring dependency has moved up by at least a minor version bump. For example, in the 2.3.x case above, our library should never break. When the Spring dependency moves to 2.5.x or 3.x.y, then it it ok to introduce breaking changes in the library.

## Dependencies

{% include requirement/MUSTNOT id="java-spring-dependency-approval" %} introduce dependencies on libraries, or change dependency versions, without discussion with the Java architect. Each dependency must receive explicit approval and whitelisting before it may be used.

{% include requirement/MUSTNOT id="java-spring-dependency-conflicts" %} introduce dependencies on library versions that conflict with the transitive dependencies of Spring libraries.

{% include requirement/MUST id="java-spring-com-azure-deps" %} make use of `com.azure` client libraries only - do not mix older `com.microsoft.azure` client libraries into the dependency hierarchy.

{% include requirement/MUST id="java-spring-dependency-minimal" %} keep dependencies to the minimal required set.

## Tracing

{% include requirement/MUST id="java-spring-tracing" %} ensure that all Azure Spring libraries fully integrate with the tracing capabilities available in the Azure Java client libraries.

{% include requirement/MUST id="java-spring-tracing-sleuth" %} ensure that all Azure Spring libraries work appropriately with Spring Sleuth, and that tracing information is appropriately exported.

## Performance

{% include requirement/MUST id="java-spring-performance-baseline" %} ensure, through appropriate benchmarks (developed in conjuction with the Java SDK team) that performance of all Spring libraries is at an equivalent level to the same operation being performed directly through the Java client library.
