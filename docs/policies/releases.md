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

- Changes to the major digit (1.X.Y to 2.X.Y) indicate that breaking changes have been introduced. 
- Increments to the minor digit (1.1.X to 1.2.X) indicate the addition of new features. 
- Increments to the patch number (1.1.1 to 1.1.2) indicate bug fixes

In addition to standard SemVer, the team occasionally releases a preview of a package to allow the community to dogfood and give feedback on new features. These packages may be released as one or both of:

- Dev: a build containing the most up-to-date changes based on the current master branch. Expect frequent and potentially breaking change in this release.
- Preview: a release generated to get customer feedback before a GA. Preview releases are revised less often than dev. Preview releases may have breaking changes from the previous preview, but should not have breaking changes from the last GA release.

### Python

Python version numbers follow the guidance in [PEP 440](https://www.python.org/dev/peps/pep-0440/) for versioning Python packages. This means that regular releases follow the above specified SemVer format. Preview releases follow the [PEP 440 specification for pre-releases](https://www.python.org/dev/peps/pep-0440/#pre-releases):

- `X.YaYYYYMMDD` (dev using alpha convention)
- `X.YbZ` (preview release using beta convention)

Python dev releases are not published to PyPi. Instead, use the git tag.

### JavaScript

The JavaScript community generally follows SemVer. For preview releases, we will release with an [npm distribution tag](https://docs.npmjs.com/cli/dist-tag) in the formats:

- `X.Y.Z-dev.YYYYMMDD`
- `X.Y.Z-preview.N`

JavaScript dev and preview releases are published to npm with the `@dev` or `@next` tags.  Use the following:

```bash
$ npm install @azure/package@next
```

### .NET

NuGet supports designating a package as 'pre-release'. In this ecosystem, pre-release packages will have daily build numbers in the format:

- `X.Y.Z-dev.YYYYMMDD.r` (`r` is based on the number of builds done in a given day) 
- `X.Y.Z-preview.N`

Preview .NET packages will be published to NuGet with the pre-release designation.

{% include draft.html content="Still TBD: Where will we store the dev .NET packages" %}

### Java

Maven supports the [convention](https://cwiki.apache.org/confluence/display/MAVENOLD/Versioning) `MAJOR.MINOR.PATCH-QUALIFIER`. The preferred format for version numbers is:

- `X.Y.Z-SNAPSHOT` (Dev build qualifier used in Maven. Snapshots overwrite with new versions on re-publish.)
- `X.Y.Z-preview.N`

Dev and preview Java packages are published direct to the Maven registry.

## Version Updates
+ Package versions should be updated immediately after publishing (both preview and GA).  It's safer to have `N+1` in `master` than `N`. 
  + For previews, only the prerelease suffix should be updated (`1.0.0-preview.1` to `1.0.0-preview.2`) 
  + For GA, follow SemVer. 
+ Dependency Specifiers
  + Previews should always be pinned, since breaking changes are allowed between previews and between preview and GA.
  + GA should always float (`^1.0.0` in JavaScript), since breaking changes should always update the major.
+ Dependency Versions
  + JS
    + Preview dependencies should be updated as soon as possible -- once it is certain the dependency will ship before the dependent.  This is to absorb breaking changes and verify against the latest dependency version.
    + GA dependencies should only need to be updated at major version bumps, since they should float (`^`).
    + Dependencies older than the latest published version can be listed by running the following commands:
      + `rush unlink`
      + `git clean -xdf`
      + `rush update --full`

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
