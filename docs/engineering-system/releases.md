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

The release cycle of each SDK Component may vary based on the needs of the underlying service. The Azure SDK team recommends a release cycle around quarterly for most services. It is best practice to include a "Next Release Target Date" in the README file for each library.

## Package Versioning
The team makes every effort to follow [SemVer](https://semver.org/) for versioning. Because different languages have slightly different conventions for numbering, the way that preview releases are designated varies. In a nutshell, SemVer is defined as `Major.Minor.Patch`, where
+ Changes to the major digit (1.X.Y to 2.X.Y) indicate that breaking changes have been introduced. 
+ Increments to the minor digit (1.1.X to 1.2.X) indicate the addition of new features. 
+ Increments to the patch number (1.1.1 to 1.1.2) indicate bug fixes

In addition to standard SemVer, the team occasionally releases a preview of a package that is not yet considered fully done to allow the community to dogfood and give feedback on new features. A preview may be released as one or all of of:
+ Daily: a build containing daily changes for dogfooding purposes. Expect frequent breakage.
+ Beta: beta's rev less frequently than dailies (weekly or so), but expect to find bugs and incomplete features.
+ Release Candidate (RC): nearly complete and expected to change very little besides small tweaks. Not expected to rev, except to graduate to being the primary release.

### Python
Python version numbers follow the guidance in [PEP 440](https://www.python.org/dev/peps/pep-0440/) for versioning Python packages. This means that regular releases follow the above specified SemVer format. Preview releases follow the PEP 440 specification:
+ `X.YaYYYYMMDD` (daily using alpha convention)
+ `X.YbZ` (beta)
+ `X.YrcZ` (release candidate)

### JavaScript
The JavaScript community generally follows SemVer. For preview releases, we will release with an [NPM distribution tag](https://docs.npmjs.com/cli/dist-tag) in the formats:
+ `X.Y.Z-daily.YYYYMMDD`
+ `X.Y.Z-betaN`
+ `X.Y.Z-rcN`

### .NET
NuGet supports designating a package as 'pre-release'. In this ecosystem, pre-release packages will have daily build numbers in the format:
+ `X.Y.Z.DailyComputedTag`

### Java
Maven supports the [convention](https://cwiki.apache.org/confluence/display/MAVENOLD/Versioning) `MAJOR.MINOR.PATCH-QUALIFIER`. As such, for Java distributions, the preferred format for version numbers is:
+ `X.Y.Z-SNAPSHOT` (Daily build qualifier used in Maven. Snapshots overwrite with new versions on re-publish.)
+ `X.Y.Z-betaN`
+ `X.Y.Z-rcN`

## Deprecation
Deprecation cycle for released versions is TBD.