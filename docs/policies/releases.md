---
title: "Policies: Releases"
permalink: policies_releases.html
folder: policies
sidebar: general_sidebar
---

The release policy for the Azure SDK accommodates the need to release different SDK packages based on the ship cycle of the underlying service.

## Terms
The terms "SDK", "SDK Component", "library" and "package" are used throughout this document and are defined in the [design guidelines](/general_terminology.html).

## Supported Registries
We release client libraries to the following registries:

- NuGet (.NET)
- PyPi (Python)
- npm (TypeScript)
- Maven (Android, Java)

We recommend that you use a package manager that supports these registries.

## Git Tagging

Each language repository contains multiple packages inside of it. Releases for each package are tagged in the format `<package-name>_<package-version>`.

## GitHub Releases

We use GitHub releases as a convenient place to put release notes. The change log and any additional notes will be available here. We automatically publish release notes to a GitHub release if the changelog guidance below is followed. No artifacts are published to the GitHub release. Instead, use a supported package registry.

## ChangeLog Guidance

We recommend that every package maintain a changelog just as a matter of course. However, there is an additional benefit. Ensuring that a `changelog.md` file is both available and formatted appropriately will result in automatically formatted release notes on each GitHub release.

How?

* **.NET**: extend nuspec to include `changelog.md` in the `.nupkg.`
* **Android and Java**: add `<packageid>-changelog.md` to the existing artifact list.
    * Note that the convention here is `<packageIdentifier>.md`. This mirrors the four existing artifacts per package.
* **Python**: ensure `changelog.md` is present in the `sdist` artifact.
* **TypeScript**: ensure `changelog.md` is included in the package tarball.

A given `changelog.md` file must follow the below form:

```
# <versionSpecifier>
<content. Do not introduce another L1 header>

...

# <older versionSpecifier>
<content/changes for the older release>

... older release details trail off into history below

```

For clarity, a `change log entry` is simply the header + content up to the next release header OR EOF. During release, if there exists a changelog entry with a version specifier _matching_ that of the currently releasing package, that changelog entry will be added as the body of the GitHub release.

The [JS ServiceBus SDK](https://github.com/Azure/azure-sdk-for-js/blob/master/sdk/servicebus/service-bus/changelog.md) maintains a great changelog example. Given that changelog, this is what a [release](https://github.com/Azure/azure-sdk-for-js/releases/tag/%40azure%2Fservice-bus_1.0.0-preview.2) looks like.

## Release Cycle

The release cycle of each SDK Component may vary based on the needs of the underlying service. The Azure SDK team recommends:

- Avoiding breaking changes (major releases) under most circumstances
- Minor releases quarterly or less
- Patch releases as soon as bug fixes are available
- Rev a minor release for each new Azure API version

## Package Versioning

The team makes every effort to follow [SemVer](https://semver.org/) for versioning. Because different languages have slightly different conventions for numbering, the way that preview releases are designated varies. In a nutshell, SemVer is defined as `Major.Minor.Patch`, where

- Changes to the major digit (1.X.Y to 2.X.Y) indicate that breaking changes have been introduced. Breaking changes are exceptional and require review and approval by the architecture board.
- Increments to the minor digit (1.1.X to 1.2.X) indicate the addition of new apis or features.
- Increments to the patch number (1.1.1 to 1.1.2) indicate a set of new compatible fixes.

In addition to standard SemVer, the team occasionally releases a preview of a package to allow the community to dogfood and give feedback on new features.

- Dev: a build containing the most up-to-date changes based on the current master branch. Expect frequent and potentially breaking change in this release.
- Preview: a release generated to get customer feedback before a GA. Preview releases are revised less often than dev. Preview releases may have breaking changes from the previous preview, but should not have breaking changes from the last GA release. Once a package has released to GA, any breaking changes require an exception and approval from the architecture board.

### Incrementing after release

Immediately after a package ships the source definition of the package version should be incremented in source control. It's safer to have `N+1` in `master` than `N`.

**Preview Release:** Increment the preview number on the package (e.g. `1.0.0-preview.1` -> `1.0.0-preview.2`) appropriate to the versioning scheme for the language (see blow for language-specific version formatting). Breaking changes are allowed between preview builds.

**GA Release:** Some languages bump the minor and others bump the patch version please see specific guidelines below based on your language. Breaking changes (which might increment the major version number) are *not* allowed after a GA release without an exception and reivew by the architecture board.

**GA Hotfix Release:** Some languages bump the patch version and others have specific conventions see guidelines below based on your language. See [Hotfix Branches](repobranching.md#hotfix-branches) for branching strategy of hotfixes.

### Consistent Dependency Versions

Before release for all languages ensure that all packages which depend on another package use the same version of the package on which they depend. Consistent dependency versioning is required for both internal and external dependencies.

For example, if Packages B and C depend on Package A at `1.0.0` and then Package B upgrades to Package A at `2.0.0` and Package B is released, Package C should also be upgraded to use Package A at `2.0.0` before Package C is released. Once Package B's dependency information is changed Package C's dependency information should also change and if they cannot be changed together, an issue should be opened to track changing Package C's dependencies.

Packages should not upgrade dependencies immediately after every release. Packages should only upgrade if there is a need. That is, after a package releases (e.g. Package A), other packages which depend on that package (e.g. Package B and Package C) do not  immediately update to require the latest released version of the released package. Later, if either Package B or C needs features in a newer version of Package A then both Packages B and C should be modified to point to the same newer version of Package A.

Each language repo uses a badge for analysis of dependencies on `master` including highlights for inconsistent dependencies.

| Component | Build Status |
| -------------------- | -------------------- |
| Java | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/staging/dependencies.html) |
| JS | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-js/dependencies/dependencies.html) |
| Python | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-python/dependencies/dependencies.html) |
| .NET | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-net/dependencies/dependencies.html) |

Packages which depend on preview versions should pin specifically to the preview version on which they depend because preview releases may contain breaking changes.

Avoid source dependencies in projects and only use binary/package dependencies. If a package under development needs to incorporate changes from a package upon which it depends then it should use the nightly dev version of that package. That is, if Project B incorporates changes to Project A then Project B should consume the _Package_ from Project A that is released in the nightly feed.

#### Dependent packages in a Unified Pipeline

In cases where packages have dependencies and are built in the same pipeline, dependency versions can track the current version of the packages on which they depend.

For example, if Package A and Package B are built in the same Unified Pipeline and Package A is at version `1.0.0-preview.2`, Package B's dependency on Package A should track Package A's version  (i.e. `1.0.0-preview.2`) such that both packages can be built and released from the same pipeline.

### Languages

#### Python

Python version numbers follow the guidance in [PEP 440](https://www.python.org/dev/peps/pep-0440/) for versioning Python packages. This means that regular releases follow the above specified SemVer format. Preview releases follow the [PEP 440 specification for pre-releases](https://www.python.org/dev/peps/pep-0440/#pre-releases):

- `X.Y.Z.devYYYYMMDDrrr` (`rrr` is based on the number of builds performed on the given day and it is zero-padded with a valid range starting at 001 and ends at 999)
- `X.Y.ZbN` (preview release using beta convention)

Preview packages will be published PyPi. Dev packages will be published to an isolated Azure DevOps feed.

##### Incrementing after release (Python)

**Preview Release:**  `1.0.0b1` -> `1.0.0b2`

**GA Release:** `1.1.0` ->  `1.1.1`

**GA Hotfix Release:** `1.1.0` ->  `1.1.0.1`

**Floating GA dependencies:** Use `<X+1.0.0,>=X.0.0` to float dependencies where `X` is the major release upon which the package depends and `X+1` is the next major version.

In rare cases where a customer cannot take all the latest patch versions with all the bugfixes for a particular major/minor release, but there is a critical fix necessary, we will publish a hotfix package in the format X.Y.Z.N where N increments with each successive hotfix. In this case it is expected that the customer will pin the particular hotfix version they wish to use.

#### JavaScript

The JavaScript community generally follows [SemVer](https://semver.org/). For preview releases, we will release with an [npm distribution tag](https://docs.npmjs.com/cli/dist-tag) in the formats:

- `X.Y.Z-dev.YYYYMMDD.r` (`r` is based on the number of builds performed on the given day)
- `X.Y.Z-preview.N`

JavaScript dev and preview releases are published to npm with the `@dev` or `@next` tags.  Use the following:

```bash
$ npm install @azure/package@next
```

##### Incrementing after release (JS)

**Preview Release:** `1.0.0-preview.1` -> `1.0.0-preview.2`

**GA Release:** `1.1.0` -> `1.1.1`

**GA Hotfix Release:** `1.0.0` -> `1.0.0-hotfix.1`

**Floating GA dependencies:** Use `^X.0.0` to float dependencies where `X` is the major release upon which the package depends.

Generally, customers are expected to use caret or tilde ranges. Caret ranges (e.g. `^1.0.0`) allow them to take all non-breaking changes for a package and tilde ranges (`~1.0.0`) allow them to take all minor bugfixes for a particular major/minor release.

In rare cases where a customer does not wish to take all bugfixes for a particular major/minor release (i.e. the tilde range `~X.Y.0` is not sufficient), but there is a critical fix necessary, we will publish a hotfix package in the format `X.Y.0-hotfix.N` where `N` increments with each successive hotfix. In this case it is expected that the customer will pin the particular hotfix version they wish to use in their `package.json`.

In general, packages that have GA'd are not expected to have additional preview releases unless the underlying service releases preview functionality or the package undergoes significant churn as part of a major version change.

Packages which depend on a released package should float to the latest compatible major version (e.g. `^1.0.0`). Because we're using SemVer only breaking changes alter the major version number and all minor and patch changes should be compatible. The version number should only be updated for a major version change.

Dependencies older than the latest published version can be listed by running the following commands:

```bash
rush unlink
git clean -xdf
rush update --full
```

#### .NET

NuGet supports designating a package as 'pre-release'. In this ecosystem, pre-release packages will have daily build numbers in the format:

- `X.Y.Z-dev.YYYYMMDD.r` (`r` is based on the number of builds done in a given day)
- `X.Y.Z-preview.N`

Preview .NET packages will be published to NuGet with the pre-release designation. Dev packages will be published to an isolated Azure DevOps feed.

#### Incrementing after release (.NET)

**Preview Release:** `1.0.0-preview.1` -> `1.0.0-preview.2`

**GA Release:** `1.1.0` -> `1.2.0-preview.1`

**GA Hotfix Release:** `1.0.0` -> `1.0.1`

**Floating GA dependencies:** Use the exact version number to specify the lowest version of the package which contains the features upon which you depend.

#### Java

Maven supports the [convention](https://cwiki.apache.org/confluence/display/MAVENOLD/Versioning) `MAJOR.MINOR.PATCH-QUALIFIER`, which doesn't support SemVer 2 sorting for pre-releases so we have to use a special convention based on their [versioning code](https://github.com/apache/maven/blob/master/maven-artifact/src/main/java/org/apache/maven/artifact/versioning/ComparableVersion.java). The preferred format for version numbers is:

- `X.Y.Z-dev.YYYYMMDD.r` (`r` is based on the number of builds performed on the given day)
- `X.Y.Z-beta.N` (preview release using beta convention)

Preview Java packages are published directly to the Maven central registry. Dev packages will be published to an isolated Azure DevOps feed. Note that that dev packages sort as [newer
then the preview as well as the GA version of the matching version](https://github.com/apache/maven/blob/master/maven-artifact/src/main/java/org/apache/maven/artifact/versioning/ComparableVersion.java#L423-L428) as such we should avoid ever publishing a dev package to maven central.

#### Incrementing after release (Java)

**Preview Release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**GA Release:** `1.1.0` -> `1.2.0-beta.1`

**GA Hotfix Release:** `1.0.0` -> `1.0.1`

**Floating GA dependencies:** Use the exact version number to specify the lowest version of the package which contains the features upon which you depend.

## Preview Releases and GA Graduation

The Azure SDK team may choose to create a preview release for several reasons:

- Service itself has features in preview and client library must be updated accordingly
- Testing and receiving feedback on new API designs
- Stress and performance testing for new SDK features is incomplete

To create a preview, the release must:

- Have initial documentation.
    - Full API documentation.
    - A quick start guide for using the SDK.
    - How to guides for champion scenarios.

- Have a clear README file with guidelines for how the community can submit feedback.

- Receive an initial [Architecture Board] review.

- Receive an initial design review from the service team (may be combined with architecture review).

- Ratify shipping dependencies with the service team.
    - If the service must ship before the SDK can ship, establish timeline for preview and GA in the service.
    - If the SDK contains customer-critical features, establish which features these are and what customer expectations exist.

- If changes are substantial, refer to internal documentation for starting a release notification process in support.

- All service features supported by the SDK must be publicly available.

To graduate to GA, a preview release must:

- Have final documentation.
    - Conceptual documentation for how the service works.
    - Samples of common uses cases for the service.

- Have a preview release available for at least one month to allow for community feedback.

- Have no known critical bugs.

- Have three reference customers external to the Azure organization who have given feedback on the library.

- Rely on non-preview API versions.

- Pass stress and performance testing and have unit, functional, performance and stress tests meeting maturity stage 1 or higher.

- Receive a fina [Architecture Board] review.

- Receive final design sign-off from service team.

{% include refs.md %}
