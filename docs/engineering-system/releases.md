The release process for the Azure SDK accommodates the need to release different SDK packages based on the ship cycle of the underlying service. 

## Terms
The terms "SDK", "SDK Component", "library" and "package" are used throughout this doc. Definitions can be found [here](/azure-sdk/docs/design/Introduction.mdk).

## Supported Registries
We release client libraries to the following registries:
+ NuGet (.NET)
+ PyPi (Python)
+ npm (JavaScript)
+ Maven (Java)

Package managers that support these registries are the recommended way to consume the Azure SDK.

## Git Tagging

Because each language repository contains multiple packages inside of it, releases for each package are tagged in the format `<package-name>_<package-version>`.


## GitHub Releases

We use GitHub releases as a convenient place to put release notes. The change log and any additional notes will be available here. No artifacts are published to the github release. Instead, use a supported package registry.

## Release Cycle

The release cycle of each SDK Component may vary based on the needs of the underlying service. The Azure SDK team recommends:
+ Avoiding breaking changes (major releases) under most circumstances
+ Minor releases quarterly or less
+ Patch releases as soon as bug fixes are available
+ Rev a minor release for each new Azure API version

## Package Versioning
The team makes every effort to follow [SemVer](https://semver.org/) for versioning. Because different languages have slightly different conventions for numbering, the way that preview releases are designated varies. In a nutshell, SemVer is defined as `Major.Minor.Patch`, where
+ Changes to the major digit (1.X.Y to 2.X.Y) indicate that breaking changes have been introduced. 
+ Increments to the minor digit (1.1.X to 1.2.X) indicate the addition of new features. 
+ Increments to the patch number (1.1.1 to 1.1.2) indicate bug fixes

In addition to standard SemVer, the team occasionally releases a preview of a package that is not yet considered fully done to allow the community to dogfood and give feedback on new features. These packages may be released as one or both of:
+ Dev: a build containing the most up-to-date changes based on the current master branch. Expect frequent and potentially breaking change in this release.
+ Preview: a release generated to get customer feedback before a GA. Preview releases rev less often than dev - most likely every few weeks. Preview releases may have breaking changes from the previous preview, but should not have breaking changes from the last GA release.

### Python
Python version numbers follow the guidance in [PEP 440](https://www.python.org/dev/peps/pep-0440/) for versioning Python packages. This means that regular releases follow the above specified SemVer format. Preview releases follow the [PEP 440 specification for pre-releases](https://www.python.org/dev/peps/pep-0440/#pre-releases):
+ `X.YaYYYYMMDD` (dev using alpha convention)
+ `X.YbZ` (preview release using beta convention)

Python dev releases are not published to PyPi. Instead, take the Git tag to use a dev release.

### JavaScript
The JavaScript community generally follows SemVer. For preview releases, we will release with an [npm distribution tag](https://docs.npmjs.com/cli/dist-tag) in the formats:
+ `X.Y.Z-dev.YYYYMMDD`
+ `X.Y.Z-preview.N`

JavaScript dev and preview releases are published to npm with the `@dev` and `@preview` tags.

### .NET
NuGet supports designating a package as 'pre-release'. In this ecosystem, pre-release packages will have daily build numbers in the format:
+ `X.Y.Z-dev.SHORTDATE`
    + SHORTDATE is set to `yy` * 1000 + 50 * `mm` + `dd`. In year 2018 the value is in range [18051, 18631]
+ `X.Y.Z-preview.N`

Preview .NET packages will be published to NuGet with the pre-release designation. The location of dev packages is TBD.

### Java
Maven supports the [convention](https://cwiki.apache.org/confluence/display/MAVENOLD/Versioning) `MAJOR.MINOR.PATCH-QUALIFIER`. As such, for Java distributions, the preferred format for version numbers is:
+ `X.Y.Z-SNAPSHOT` (Dev build qualifier used in Maven. Snapshots overwrite with new versions on re-publish.)
+ `X.Y.Z-preview.N`

Dev and preview Java packages are published direct to the Maven registry.

## Preview Releases and GA Graduation

The Azure SDK team may choose to create a preview release for several reasons:
+ Service itself has features in preview and SDK must be updated accordingly
+ Testing and receiving feedback on new API designs
+ Stress and performance testing for new SDK features is incomplete

To create a preview, the release must:
+ Have initial API documentation
+ Have a clear README file with guidelines for how the community can submit feedback
+ Receive an initial [design review](../ReviewProcess.md) from the architecure board
+ Receive an initial design review from the service team (may be combined with architecure)
+ Ratify shipping dependencies with the service team
    + If the service must ship before the SDK can ship, establish timeline for preview and GA in the service
    + If the SDK contains customer-critical features, establish which features these are and what customer expectations exist

To graduate to GA, a preview release must:
+ Have final API documentation
+ Bake for at least one month to allow for community feedback
+ Show evidence of active consumption/usage
+ Have no known critical bugs
+ Have less than 10 other outstanding issues
+ Have an underlying service that is GA
+ Pass stress and performance testing and meet required benchmarks (TBD what benchmarks - we should make benchmarks guidance :-))
+ Receive a [final design review](../ReviewProcess.md) from architecture team
+ Receive final design sign-off from service team


## Deprecation
Deprecation cycle for released versions is TBD.