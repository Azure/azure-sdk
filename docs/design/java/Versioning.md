# Azure Java SDK Versioning Strategy

**Version:** 1.0.0-preview-1

**Editors:**

- Jonathan Giles - jonathan.giles@microsoft.com

Versioning is difficult - there are competing requirements that require solutions that lessen the quality of the remaining solution space. This document will outline the versioning strategy for Azure SDK components, specifically focusing on how this will be solved in the case of Java libraries.

**Note**: This is a discussion document - suggestions below can and will change!

## Contents

- [Azure Java SDK Versioning Strategy](#azure-java-sdk-versioning-strategy)
  - [Contents](#contents)
  - [1 Problem Domain](#1-problem-domain)
    - [1.0 Differing Service Versions](#10-differing-service-versions)
    - [1.0.1 Feature Lightup](#101-feature-lightup)
    - [1.1 Library Versioning](#11-library-versioning)
      - [1.1.0 Release Versioning](#110-release-versioning)
      - [1.1.1 Runtime Versioning](#111-runtime-versioning)
    - [1.2 External Dependencies](#12-external-dependencies)
  - [2 Proposed Approach](#2-proposed-approach)
    - [Versioning & Releasing](#versioning--releasing)
    - [Feature Lightup](#feature-lightup)
    - [Runtime](#runtime)
    - [Misc](#misc)
  - [2.0 Follow-up Actions](#20-follow-up-actions)

## 1 Problem Domain

### 1.0 Differing Service Versions

Ultimately, our client SDKs must connect to Azure services, but there may be multiple versions of this service:

- Public Azure
- National / Government Azure
- Azure Sphere

**Question**: Can we assume that where a service in the gov or sphere clouds lags behind the latest available in the public Azure cloud, that they are still versioned using a single versioning scheme, and that all instances of the same version are the same in terms of API across all clouds? E.g. Version 1.6.4 of table storage has the same API on public, gov, and sphere?

**Question**: Are we able to retrieve from the service endpoint a version number that is consistently applied across all clouds?

### 1.0.1 Feature Lightup

If we have a common version number across all clouds, it is possible to write client libraries that check on each API call whether the requested functionality is available in the version that the user is connecting to (this can and should be cached, obviously). If the API supports it, the function call will execute. If it does not, a runtime exception could be thrown. It is even conceivable that build-time tooling be written to check annotations on each API method against the users declared version, and to fail at build time. This, in effect, is client-side lightup - the client library has baked into it the knowledge that directly maps API to version numbers.

An alternative approach is to query the server for the features that it supports, and to dynamically enable functionality at runtime. API in the SDK components could be annotated to specify the relationship between the service functionality and the method, to make light-up more automated. The two downsides of this approach are:

- Unless service lightup is still based on the user opting into a specific service version (or being opted into the latest version at the time of the jar is released), there is no way to do compile-time tests to ensure that the version opted into and the API being called in code will execute at runtime without exception. In other words, service lightup should be done only in conjunction with version number lookup for each service.
- It requires considerably more maintenance for the service owners to ensure that they provide the correct information.

At the very least, being able to do client-side lightup is important. Querying functionality available from the service is interesting, but not anywhere near as important.

### 1.1 Library Versioning

Versioning a library is complicated. It's made even more complicated when there are multiple libraries in the picture.

#### 1.1.0 Release Versioning

The two choices for library versioning are to increment a client library for a single service only when it changes, or to increment all library versions whenever a release is made of any service client library. In other words, to allow each library to increment its version number as necessary, or to force all libraries to increment at the same time (either through being forced to by the release of a single library, or by moving all releases to a regular release cadence).

There are arguments to incrementing everything consistently:

- It makes building the 'Azure Java SDK' BOM simpler - all versions are aligned - and this BOM can have the same version number as well.
- It makes intra-library dependency management easier - all such dependencies should be aligned on the same version.
- It simplifies messaging (our latest release *of everything* is 1.5.33) - this is not a major consideration though, if we do ship an 'Azure Java SDK' BOM.
- Incrementing version numbers in lockstep can be automated with scripts.

The primary argument for consistent versioning is, therefore, 'simplicity' - primarily for the user, but only neglibly so, especially when a BOM is used. But it introduces a number of issues for release management, primarily: when are releases made? Are all services released at the same time, or are all services released whenever a single service needs to be released?

To not align version numbers is an acceptable approach too, but it makes building the unified BOM more complex. Tooling will need to be introduced to ensure that the BOM, when a new release is made, is updated to reflect the correct versions of each library (and to ensure no conflicts arise in this dependency tree).

The final consideration is simply: when are BOM releases made? What motivates that a new roll-up is made available? Will it be every time a service releases? Will we introduce a regular release cadence that draws in the latest versions? Will there be any testing to ensure these releases play together nicely (with consistent dependencies, etc)? Who will own and ensure this occurs?

#### 1.1.1 Runtime Versioning

Java does not have a good story around runtime versioning options. You cannot expect to bring in, for example, `azure-storage-1-6-0.jar` and `azure-storage-2-1-3.jar` and expect that they will work side by side with any kind of certainty (and almost certainly they will not).

Java treats all classes on the classpath the same. When a class is requested, the classloader will load the first instance of the requested class that it finds. This can cause trouble if side-by-side versioning is required.

**Question**: How important is side-by-side support? How much do we need to work to support this? For example, the workarounds I present below could also be worked around by the end-user by deploying their code using custom classloaders or other module systems like OSGi. Supporting side-by-side has negative consequence for the common case, as you shall see.

One way to enable side-by-side operation more cleanly is to avoid classpath collisions by adding versioning information into the package names (e.g. `com.azure.storage.v1` and `com.azure.storage.v2`). This is a big nuisance to developers, as it will require that they find / replace all import statements when they upgrade.

### 1.2 External Dependencies

Java is in the fortunate position of having a vibrant ecosystem of third party libraries. This has the unfortunate side effect of introducing some of the issues discussed in the runtime versioning section around classpath hell onto end users, as the transitive dependency graph can begin to pull in dependencies with differing versions of the same library. Resolution of this issue is neither automatic or easy.

There exists tooling (which I have written) to monitor the community and determine where their current dependency versions are. This will enable our SDKs to be fast followers - moving to newer versions when other critical libraries have chosen to move.

Our Java SDK specification document will detail the requirement of keeping dependencies minimal, the process around introducing new dependencies, the process around upgrading dependencies, and the concept of a parent POM that will align all dependencies across the Java SDK. I will not go into this topic any further here, because I consider this to be mostly a solved problem, and mostly specified in the other document already.

## 2 Proposed Approach

Having highlighted some of the concerns around versioning in Java, I now present a summary of the approach I currently propose for use in the Java SDK for Azure:

### Versioning & Releasing

- Semver is used for all releases (SDK Components, as well as the roll-up Maven BOM release).
- Libraries can be independently versioned, incremented as necessary, and released independently into Maven Central.
- Libraries must all depend on a common parent POM (as specified in Java spec).
- Maven BOM releases will follow a release cadence pattern, at a schedule TBD (perhaps quarterly or so). Developers will be encouraged to move from one BOM release to another, and not manage dependencies of individual SDK component libraries separately.

### Feature Lightup

- Azure services will be improved to expose an API version consistently and in all places.
- Azure services may also be improved to provide information about available functionality, to light-up based on this information.
- User specifies version that they want to use per service. If not specified, use the version baked into the release.
- All SDK component APIs will be written to lookup version number (and possibly lightup features) from service, and to react appropriately based on the given parameters and the request functionality.
- Code is written in a way that exceptions will be thrown at runtime if API is called that is not supported on the version that the user has opted into.

### Runtime

- Package namespaces do not include version numbers.
- Side-by-side support is not explicitly supported through package naming or other means. Developers wanting to enable side-by-side support will need to implement this in their applications using external mechanisms.
- Supported versions can be deprecated and removed from a release - if a user opts into a version that has been removed, they get a runtime exception at startup and told to move their dependency version of the library to a specific release. Build-time tooling may also exist to detect this.

### Misc

- Document which versions of Java library should be used in specific cases (where the latest version is not sufficient)
- Ensure multiple versions of reference documentation are kept and published - identify what the notable releases are at any particular time (e.g. 1.6.8 and 2.0.5 might both need to be documented)

## 2.0 Follow-up Actions

Assuming everything outlined as above is the way forward for Java, the following actions are necessary to kick start the process:

- Create base class library functionality for:
  - Service version lookup.
  - Service feature lightup.
  - Service version opt-in (per service)
    - Perhaps some kind of runtime annotation, e.g. `@AzureService(String serviceName, String serviceVersion)`.
    - Includes ability to check if client library supports the provided version at run time.
  - Create Java annotation and library for ensuring that each public API that maps to a service endpoint states the version range that it supports, e.g. `@AzureServiceEndpoint(String serviceName, String minVersion, String maxVersion)`.
- Create build tooling to:
  - Compare user-chosen version (as specified with `@AzureService`, or the latest version of the SDK component) against all API calls (as specified with `@AzureServiceEndpoint`) to determine if any calls are an invalid combination. Document how to use and ensure it is easily included in Maven and Gradle build scripts.
  - Ensure that the user-chosen version (specified with `@AzureService`) is supported by the client library version that the user is using.
- Create internal tooling to:
  - Create a Maven BOM and to check dependency tree to ensure no collisions.
  - Bake service numbers into a release (at the very least, a release checklist item to ensure this is done).
- Identify who owns the maintenance and release processes for Azure Java SDK BOM and parent POM.
