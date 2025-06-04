---
title: "Policies: Releases"
permalink: policies_releases.html
folder: policies
sidebar: general_sidebar
---

The release policy for the Azure SDK accommodates the need to release different SDK packages based on the ship cycle of the underlying service.

## Exit Criteria

The following are mandatory actions required when releasing a new version of any service SDK.

### 1) Language coverage

Market data and customer engagement studies clearly indicate that a cloud provider’s support of several programming languages and great developer experiences via SDK’s & tools can heavily impact a customer’s decision in choosing a cloud provider over others. In the same way, bad experiences both in getting started scenarios as well as total cost of ownership can drive customers away. It is important that Azure provides a uniform story for language coverage in its primary languages in order to raise customer confidence that they will be able to use any of Azure’s services in their solutions if they are using one of these languages. Customers feel that their language choice limits the services that they can choose to use easily from that language. The intent is that this is not a service by service evaluation of customer demand and more of an Azure platform statement that all of Azure’s services are easily usable in these primary languages.

We’re motivated to provide high quality SDKs to deliver a great experience for Azure developers leveraging and interacting with Azure services.

At the moment we are committed to building and supporting an SDK for each of these primary languages SDKs for all azure services:

- Java
- .NET
- Python
- TS/JS

We recommended supporting additional key languages depending on the business scenarios and critical customer demand. Non primary languages depend much more heavily on contributions from outside the Azure SDK team.

### 2) Change logs & Migration Guides

Facilitating a swift transition of the SDKs' users to the new version being released requires clear clarification and documentation of the changes from the previous version. The type and granularity of the documentation depends on the type and scope of the release:

#### New standards upgrade release

This covers the case when we upgrade and existing Azure SDK to the new SDKs standards. Such a release usually contains major modifications to the structure, interfaces and behavioral aspects of the existing SDKs. Such an update requires a detailed and verbose porting guide to help the adopting users understand the benefits, changes and offerings of the new SDK version. The requirement here is to:

 {% include requirement/MUST %} Create a Migration guide for each language SDK. Use the [Migration guide template](migration-guide-template.md) as a reference.

 {% include requirement/MUST %} Include a "Benefits" section clearing explaining the advantages of migration to this version of the SDK.

 {% include requirement/MUST %} Place that guide in the SDK repository preferably in the root of the directory that contains the service.

An example porting guide can be found [here](https://github.com/Azure/azure-sdk-for-net/blob/main/sdk/servicebus/Azure.Messaging.ServiceBus/MigrationGuide.md).

(Please Note) Migration guide creation will be required to obtain sign-off from the Archboard.

#### New version release

Ensuring that a `CHANGELOG.md` file is both available and formatted appropriately is mandatory and will be used in automatically generating formatted release notes on each GitHub release.

{% include requirement/MUST %} maintain a changelog for every package.

{% include requirement/MUST %} `CHANGELOG.md` file should be added in the root folder of the library.

{% include requirement/MUST %} name changelogs with all caps except for the extension, i.e. `CHANGELOG.md`.

{% include requirement/MUST %} follow the format in the guidelines section below [Change Logs](#change-logs).

### 3) Blogs & Samples

Advertising our SDKs is key to increasing their adoption and getting their latest and greatest features to the hands of their users. the following steps should be taken once the new version is live:
- Adding a blog entry on the [Azure SDK blog site](https://devblogs.microsoft.com/azure-sdk/) by contacting the [admins](mailto:azsdkblog@microsoft.com).
- working with the Azure service team for which you're building this version of the SDK to advertise the release through their official communication channels.
- ensuring that you have Solid samples in the SDK repository demonstrating the use of this new version.

### 4) Payload Backwards Compatibility

A manual migration test should be developed to ensure that payloads and data fed into the previous version of the SDK are gracefully handled when fed to the new SDK.

### 5) Updating package manager references

Follow the best practices below to ensure that the visibility of the new release is elevated.

Identify supported legacy libraries for the SDK you are releasing as early as possible <br>
-	**Note:** we cannot deprecate GA libraries which were released less than 1 year ago per the [current Azure SLA](https://www.microsoft.com/LICENSING/PRODUCT-LICENSING/PRODUCTS)
- Note,  We should direct users to the new library only if it is covering the legacy library specs. Make sure you confirm feature and performance parity at your arch board reviews.
-	For .NET, once a library has been identified as suitable for replacement, initiate a request to have NuGet search popularity for the legacy library forwarded to the new library. The SDK team engineering team will know how to do this or who to talk to.

For each legacy package you plan to deprecate
-	Update the legacy library package README with a link to the new package.
```markdown
Please note, this package has been deprecated. A replacement package is available
[package name](https://aka.ms/azsdk) as of [date-MM/YY]. We strongly
encourage you to upgrade to continue receiving updates. 
See the [Migration Guide](https://aka.ms/azsdk) for guidance on upgrading. 
Refer to our [deprecation policy](https://azure.github.io/azure-sdk/policies_support.html) for more details.
```
For packages with the same name (e.g. Python, Java), use the following wording.
```markdown
Please note, versions of this package with version numbers [version number] and below have been deprecated
as of [date-MM-YY]. We strongly encourage you to upgrade to the latest version to continue receiving updates.
Refer to our [deprecation policy](https://azure.github.io/azure-sdk/policies_support.html) for more details.
```
-	Update the legacy Samples README with link to the new samples.
Note, you can search for sample repositories under https://docs.microsoft.com/samples/browse/?products=azure.
```markdown
Samples in this repository use deprecated packages [list legacy package here]. We recommend
that you get started using the new package here instead: [package name](https://aka.ms/azsdk).
```
-	Update the new package README with a link to the migration guides.
```markdown
This document covers [library name] [package name](https://aka.ms/azsdk).
If you're using an older package, we recommend that you upgrade your code.
See [Migration Guide](https://aka.ms/azsdk) for more details.
```
-	Update package index files to identify legacy packages replacement.
```markdown
Go to https://github.com/Azure/azure-sdk/blob/master/_data/releases/latest/ and update [language]-packages.csv.
Use Notes column to clarify what is being replaced by the new package.
```
-	In the package managers that support updates to existing packages, update the legacy packages in the package manager to include a deprecation notice. Use the following message and follow programming language instructions.
```markdown
Please note, this package has been deprecated. A replacement package is available
[package name](https://aka.ms/azsdk) as of [date-MM/YY]. We strongly
encourage you to upgrade to continue receiving updates. 
See the [Migration Guide](https://aka.ms/azsdk) for guidance on upgrading.
Refer to our [deprecation policy](https://azure.github.io/azure-sdk/policies_support.html) for more details.
```
-	If you are deprecating a package version, but staying within the same package name, update the wording above to mention a specific version.
```markdown
Please note, versions of this package with version numbers [version number] and below have been 
deprecated as of [date-MM-YY]. We strongly encourage you to upgrade to the latest version to 
continue receiving updates. 
Refer to our [deprecation policy](https://azure.github.io/azure-sdk/policies_support.html) for more details.
```

| Language | Instructions |
| ---------- | --------- |
|.Net|Follow instructions at [deprecating NuGet packages](https://docs.microsoft.com/nuget/nuget-org/deprecate-packages) to deprecate the package with the message above.<br>Select all versions of the package you are deprecating.<br>Choose deprecation reason as "Other" because "Legacy" is for packages that are no longer maintained.|
|Java | If the deprecated package is no longer in use (new version has a different name), publish an update to the deprecated package after updating the README|
|TS/JS | Run the relevant build pipeline.|
|Python | If the deprecated package is no longer in use (new version has a different name), publish an update to the deprecated package after updating the README|
|Go | Add a deprecation comment in the go.mod so that users see a warning when downloading the deprecated package. <br>See example [here](https://github.com/Azure/azure-sdk-for-go/blob/857695b0e8158bdf9b19bed23c33cf8a5333921d/sdk/to/go.mod#L1)|

#### Legacy packages support after the update

- Ensure you have the infrastructure in place to build and ship fixes for the legacy libraries for the next 3 years.<br> You will need to ship security and critical bug fixes for the first year.<br> You don’t have to proactively fix anything else, but a customer calling for support should be able to get it. Refer to our [deprecation policy](https://azure.github.io/azure-sdk/policies_support.html) for more details.
- Encourage customers to migrate to the new library when possible, from this point on.
- After one year, customers will need to provide a strong business need to justify and receive legacy library updates. Most of the customers are expected to migrate to the latest library at this point.
- Monitor the deprecated library usage. If the number of customers is small, consider working with them individually to migrate to the latest version.<br> At the point when there are no customers left, you can retire the library following the [Azure Global Retirement Policy process](https://dev.azure.com/msazure/AzureWiki/_wiki/wikis/AzureWiki.wiki/37673/Retirements-and-Breaking-Changes).



## Terms

The terms "SDK", "SDK Component", "library" and "package" are used throughout this document and are defined in the [design guidelines](general_terminology.html).

## Supported registries

We release client libraries to the following registries:

- NuGet (.NET)
- PyPi (Python)
- npm (TypeScript)
- Maven (Android, Java)

We recommend that you use a package manager that supports these registries.

## Git Tagging

For language repositories which contain multiple packages, releases for each package are tagged in the format `<package-name>_<package-version>`.

For language repositories where the repo is the primary shipping unit, the releases should be tagged in the format `<release-version>` (i.e. `1.0.0-beta.1`). If there are other secondary assets that also ship from the same repo then those assets should use an identifier for those assets and the version `<identifier-name>_<release-version>` (i.e. `tools_1.0.0-beta.1`).

## GitHub Releases

We use GitHub releases as a convenient place to put release notes. The change log and any additional notes will be available here. We automatically publish release notes to a GitHub release if the changelog guidance below is followed. No artifacts are published to the GitHub release. Instead, use a supported package registry.

## Change Logs

Every library should contain a file exactly named `CHANGELOG.md` in the folder for each library. Generally in `sdk/<service>/<package>` folder.

In order for consistency across our SDKs and to enable automation to validate and parse these changelogs the files must use the following format.

```markdown
# Release History

## <version X.Y.Z[-beta.N]> (<Unreleased|YYYY-MM-DD>)
### Features Added
- <for new features to be called out in release notes>

### Breaking Changes
- <for changes to be called out in release notes including>
- <Changed: for changes that break existing functionality>
- <Deprecated: for soon-to-be removed features>
- <Removed: for now removed features>

### Bugs Fixed
- <for important bug fixes to be called out in release notes, especially for fixes that the developer will notice or need to react to in some way>
- <Security: for any security fixes>

### Other Changes
- <for any bug fixes or other changes that are not important enough to include in release notes>

...
## <older version> (<Release Date>)
- <content/changes for the older release>

... older release details trail off into history below
```
In order to automatically pull the relevant content (see mentions of release notes above) from the change log entries to produce our release notes the formatting of the headers needs to exactly match the format above (i.e. `### Features Added`, `### Breaking Changes`, `### Bugs Fixed`). For more details on the general release notes see the [Release Notes Guidance](https://azure.github.io/azure-sdk/policies_releasenotes.html#whats-a-developer-impacting-change).

For more information on general change log guidelines see [keep a changelog](https://keepachangelog.com/en/1.0.0/).

Example change log:

```markdown
# Release History

## 12.1.0 (Unreleased)
### Features Added
- check to enforce TokenCredential is used only over HTTPS

### Breaking Changes
- Support using SAS token from connection string

### Bugs Fixed
- Issue where AccountName on BlobUriBuilder would not be populated
  for non-IP style Uris ([#8638](https://github.com/Azure/azure-sdk-for-net/issues/8638))

## 12.0.0 (2019-11-25)
### Breaking Changes
- Added support for the new low-priority node type.
- Number of operations and models to better align with other client
  libraries and the .NET Framework Design Guidelines

### Other Changes
- Parallel upload/download performance improvements
```

{% include requirement/SHOULD %} link to GitHub issues (full URL) that were fixed in that release going forward (i.e. do not backfill older issues). See example above under the `### Bugs Fixed` heading.

For clarity, a `change log entry` is simply the header + content up to the next release header OR EOF. During release, if there exists a changelog entry with a version specifier _matching_ that of the currently releasing package, that changelog entry will be added as the body of the GitHub release.

### Changelog Entries for Stable releases

When doing a switch from a beta to a stable release there are often very few changes which can be misleading to customers, as they might not think there are many changes. Instead when doing a stable release it is recommended that we either squash all the beta notes into the stable changelog entry or add a comment similar to `Includes all changes from X.Y.Z-beta.A to X.Y.Z.beta.B` so that it is clear that all those changes are included.

## Release Cycle

The release cycle of each SDK Component may vary based on the needs of the underlying service. The Azure SDK team recommends:

- Avoiding breaking changes (major releases) under most circumstances
- Minor releases quarterly or less
- Patch releases as soon as bug fixes are available
- Rev a minor release for each new Azure API version

## Package Versioning

The team makes every effort to follow [SemVer](https://semver.org/) for versioning. In a nutshell, SemVer is defined as `Major.Minor.Patch`, where:

- Changes to the major digit (1.X.Y to 2.X.Y) indicate that breaking changes have been introduced. Breaking changes are exceptional and require review and approval by the architecture board.
- Increments to the minor digit (1.1.X to 1.2.X) indicate the addition of new apis or features.
- Increments to the patch number (1.1.1 to 1.1.2) indicate a set of new compatible fixes.

In addition to the stable releases the team also has Alpha and Beta releases of a package to allow the community to try new features early and give feedback.

- Alpha releases are sometimes referred to as dev releases and use a prerelease label that contains a date stamp similar to `-alpha-YYYYMMDD.r`. This ensures the versions are unique as they will often be published daily. These are often published to an isolated registry depending on the language ecosystem. These releases are based on the latest committed code changes and should not be used for production dependencies. They are very volatile and change from version-to-version. These are mostly useful for temporarily working around an issue or testing out the latest library changes.
- Beta releases use a prerelease label like `-beta.X` and are published to the most common public registry for each language ecosystem. These releases are less volatile and released less often then alpha releases.  These are usually used before releasing a new minor or major stable release. Beta releases may have breaking changes from the previous beta but should not have breaking changes from the last stable release. Once a package has released to stable, any breaking changes require an exception and approval from the architecture board.

While all the languages follow the general versioning scheme, they each have slight differences based on their ecosystem, for those differences see the individual language sections below.

NOTE: Given that alpha releases have versions based on the day they will often times have newer changes then beta releases. This means that if you want to consume the latest changes from an alpha release you need to take care and avoid accidently consuming the latest beta release. Each language section gives an example of how to consume the latest alpha version for each language ecosystem.

### Incrementing after release

Immediately after a package ships the source definition of the package version should be incremented in source control. It's safer to have `N+1` in `main` than `N`. Package increment after release happens automatically as part of the release pipelines.

**Beta Release:** Increment the beta number on the package (e.g. `1.0.0-beta.1` -> `1.0.0-beta.2`) appropriate to the versioning scheme for the language (see below for language-specific version formatting). Breaking changes are allowed between beta versions.

**Stable Release:** Some languages bump the minor and others bump the patch version please see specific guidelines below based on your language. Breaking changes (which might increment the major version number) are *not* allowed after a stable release without an exception and review by the architecture board.

**Stable Hotfix Release:** Some languages bump the patch version and others have specific conventions see guidelines below based on your language. See [Hotfix Branches](repobranching.md#hotfix-branches) for branching strategy of hotfixes.

### Consistent Dependency Versions

Before release for all languages ensure that all packages which depend on another package use the same version of the package on which they depend. Consistent dependency versioning is required for both internal and external dependencies.

For example, if Packages B and C depend on Package A at `1.0.0` and then Package B upgrades to Package A at `2.0.0` and Package B is released, Package C should also be upgraded to use Package A at `2.0.0` before Package C is released. Once Package B's dependency information is changed Package C's dependency information should also change and if they cannot be changed together, an issue should be opened to track changing Package C's dependencies.

Packages should not upgrade dependencies immediately after every release. Packages should only upgrade if there is a need. That is, after a package releases (e.g. Package A), other packages which depend on that package (e.g. Package B and Package C) do not  immediately update to require the latest released version of the released package. Later, if either Package B or C needs features in a newer version of Package A then both Packages B and C should be modified to point to the same newer version of Package A.

Each language repo uses a badge for analysis of dependencies on `main` including highlights for inconsistent dependencies.

| Component | Build Status |
| -------------------- | -------------------- |
| Java | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-java/staging/dependencies.html) |
| JS | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-js/dependencies/dependencies.html) |
| Python | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-python/dependencies/dependencies.html) |
| .NET | [![Dependencies](https://img.shields.io/badge/dependencies-analyzed-blue.svg)](https://azuresdkartifacts.blob.core.windows.net/azure-sdk-for-net/dependencies/dependencies.html) |

Packages which depend on beta versions should pin specifically to the beta version on which they depend because beta releases may contain breaking changes.

Packages should try to avoid source level dependencies to other projects that don't ship in the same pipeline and instead rely on binary/package dependencies. This is to help avoid accidently taking dependencies on new features in other libraries and enable each library to ship independent of the others in the repo. If new dependencies are required extra care should be taken to ship the lower level dependencies before shipping the higher level libraries to make sure the entire dependency chain is shipped. To help ensure we don't end up with broken dependency versions we have enabled Min/Max testing in each repo to ensure we test the lower end and the upper end of our dependency range for the dependencies our packages say they support.

#### Dependent packages in a Unified Pipeline

In cases where packages have dependencies and are built in the same pipeline, dependency versions can track the current version of the packages on which they depend.

For example, if Package A and Package B are built in the same Unified Pipeline and Package A is at version `1.0.0-beta.2`, Package B's dependency on Package A should track Package A's version  (i.e. `1.0.0-beta.2`) such that both packages can be built and released from the same pipeline at the same time.

### Languages

#### Python

Python version numbers follow the guidance in [PEP 440](https://www.python.org/dev/peps/pep-0440/) for versioning Python packages. This means that regular releases follow the above specified SemVer format. Beta releases follow the [PEP 440 specification for pre-releases](https://www.python.org/dev/peps/pep-0440/#pre-releases):

- `X.Y.ZaYYYYMMDDrrr` (`rrr` is based on the number of builds performed on the given day and it is zero-padded with a valid range starting at 001 and ends at 999) used for daily alpha releases.
- `X.Y.ZbN` used for beta releases.

Beta packages will be published PyPi. Alpha packages will be published to the isolated [azure-sdk-for-python](https://dev.azure.com/azure-sdk/public/_packaging?_a=feed&feed=azure-sdk-for-python) DevOps feed. To consume an alpha package you should either pin to a specific version or use a version specifier like `"package-name">=X.Y.Za,<X.Y.Zb` to get the latest alpha release while avoiding any potential beta versions which might contain older changes.

##### Incrementing after release (Python)

**Beta Release:**  `1.0.0b1` -> `1.0.0b2`

**Stable Release:** `1.1.0` ->  `1.1.1`

**Stable Hotfix Release:** `1.1.0` ->  `1.1.0.1`

**Floating Stable dependencies:** Use `<X+1.0.0,>=X.0.0` to float dependencies where `X` is the major release upon which the package depends and `X+1` is the next major version.

In rare cases where a customer cannot take all the latest patch versions with all the bug fixes for a particular major/minor release, but there is a critical fix necessary, we will publish a hotfix package in the format X.Y.Z.N where N increments with each successive hotfix. In this case it is expected that the customer will pin the particular hotfix version they wish to use.

#### JavaScript

The JavaScript community generally follows [SemVer](https://semver.org/).
When publishing an npm package, [npm distribution tags](https://docs.npmjs.com/cli/dist-tag) are automatically set based on the version being published and current versions present on npm and there is no need to set tag manually when running a release pipeline.

Below are the guidelines for versions to use:

- Stable releases will follow [SemVer](https://semver.org/) and the published package will get the tag `latest`.
- Beta releases will use the format `X.Y.Z-beta.N` for version and the published package will get the tag `beta`.
- Daily alpha releases will use the format `X.Y.Z-alpha.YYYYMMDD.r` (`r` is based on the number of builds performed on the given day) and the latest published package will have the `dev` tag and published to npm. To consume a alpha package either pin to a specific version or use the `dev` tag as the version.

##### Incrementing after release (JS)

**Beta Release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.1.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.0-hotfix.1`

**Floating Stable dependencies:** Use `^X.0.0` to float dependencies where `X` is the major release upon which the package depends.

Generally, customers are expected to use caret or tilde ranges. Caret ranges (e.g. `^1.0.0`) allow them to take all non-breaking changes for a package and tilde ranges (`~1.0.0`) allow them to take all minor bugfixes for a particular major/minor release.

In rare cases where a customer does not wish to take all bugfixes for a particular major/minor release (i.e. the tilde range `~X.Y.0` is not sufficient), but there is a critical fix necessary, we will publish a hotfix package in the format `X.Y.0-hotfix.N` where `N` increments with each successive hotfix. In this case it is expected that the customer will pin the particular hotfix version they wish to use in their `package.json`.

In general, packages that have a stable release are not expected to have additional beta releases unless the underlying service releases preview functionality or the package undergoes significant churn as part of a major version change.

Packages which depend on a released package should float to the latest compatible major version (e.g. `^1.0.0`). Because we're using SemVer only breaking changes alter the major version number and all minor and patch changes should be compatible. The version number should only be updated for a major version change.

#### .NET

NuGet supports designating a package as 'pre-release'. In this ecosystem, pre-release packages will have daily build numbers in the format:

- `X.Y.Z-alpha.YYYYMMDD.r` (`r` is based on the number of builds done in a given day) for daily alpha releases.
- `X.Y.Z-beta.N` for beta releases.

Beta packages will be published to NuGet with the pre-release designation. Alpha packages will be published to the isolated [azure-sdk-for-net](https://dev.azure.com/azure-sdk/public/_packaging?_a=feed&feed=azure-sdk-for-net) DevOps feed. To consume an alpha package you should either pin to a specific version or use a version specifier like `X.Y.Z-alpha*` to get the latest alpha release while avoiding any potential beta versions which might contain older changes.

#### Incrementing after release (.NET)

**Beta Release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.2.0-beta.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.1`

**Floating Stable dependencies:** Use the exact version number to specify the lowest version of the package which contains the features upon which you depend.

#### Java

Maven supports the [convention](https://cwiki.apache.org/confluence/display/MAVENOLD/Versioning) `MAJOR.MINOR.PATCH-QUALIFIER`, which doesn't support SemVer 2 sorting for pre-releases so we have to use a special convention based on their [versioning code](https://github.com/apache/maven/blob/master/compat/maven-artifact/src/main/java/org/apache/maven/artifact/versioning/ComparableVersion.java). The preferred format for version numbers is:

- `X.Y.Z-alpha.YYYYMMDD.r` (`r` is based on the number of builds performed on the given day) for daily alpha releases.
- `X.Y.Z-beta.N` for beta releases.

Beta packages are published directly to the Maven central registry. Alpha packages will be published to the isolated [azure-sdk-for-java](https://dev.azure.com/azure-sdk/public/_packaging?_a=feed&feed=azure-sdk-for-java) DevOps feed. To consume an alpha package you should either pin to a specific version or use a version specifier like `(X.Y.Z-alpha, X.Y.Z-beta)` to get the latest alpha release while avoiding any potential beta versions which might contain older changes.

#### Incrementing after release (Java)

**Beta Release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.2.0-beta.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.1`

**Floating Stable dependencies:** Use the exact version number to specify the lowest version of the package which contains the features upon which you depend.

#### C++

C++ releases the source code of the package via releases on github. It currently does not ship packages to any package managers.

A C++ release includes a Tag and Release (e.g. [azure-core_1.14.1](https://github.com/Azure/azure-sdk-for-cpp/releases/tag/azure-core_1.14.1)) on GitHub and documentation as GitHub Pages (e.g. [azure-core_1.14.1](https://azuresdkdocs.z19.web.core.windows.net/cpp/azure-core/1.14.1/index.html)).

#### Incrementing after release (C++)

**Preview release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.2.0-beta.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.1`

#### Embedded C

C99 releases the source code of the repository in a single unit of source code. It does not ship packages to any package managers. Because the C repo ships from the `main` branch, code going into the `main` branch must be in a completed state and ready to ship.

An Embedded C release includes a Tag and Release (e.g. [1.5.0](https://github.com/Azure/azure-sdk-for-c/releases/tag/1.5.0)) on GitHub and documentation as GitHub Pages (e.g. [1.5.0](https://azuresdkdocs.z19.web.core.windows.net/c/az_core/1.5.0/index.html)).

#### Incrementing after release (Embedded C)

**Preview release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.2.0-beta.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.1`

#### Android

Maven supports the [convention](https://cwiki.apache.org/confluence/display/MAVENOLD/Versioning) `MAJOR.MINOR.PATCH-QUALIFIER`, which doesn't support SemVer 2 sorting for pre-releases so we have to use a special convention based on their [versioning code](https://github.com/apache/maven/blob/master/compat/maven-artifact/src/main/java/org/apache/maven/artifact/versioning/ComparableVersion.java). The preferred format for version numbers is:

- `X.Y.Z-alpha.YYYYMMDD.r` (`r` is based on the number of builds performed on the given day) for daily alpha releases.
- `X.Y.Z-beta.N` for beta releases.

Beta packages are published directly to the Maven central registry. Alpha packages will be published to the isolated [azure-sdk-for-android](https://dev.azure.com/azure-sdk/public/_packaging?_a=feed&feed=azure-sdk-for-android) DevOps feed. To consume an alpha package you should either pin to a specific version or use a version specifier like `(X.Y.Z-alpha, X.Y.Z-beta)` to get the latest alpha release while avoiding any potential beta versions which might contain older changes.

#### Incrementing after release (Android)

**Beta Release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.2.0-beta.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.1`

#### iOS

iOS releases the source code of the repository in a single unit of source code. It supports only the Swift Package Manager and does not ship packages to any package registry. Because the iOS repo ships from the `main` branch, code going into the `main` branch must be in a completed state and ready to ship.

An iOS release includes a Tag and Release (e.g. [1.0.0-beta.2](https://github.com/Azure/azure-sdk-for-ios/releases/tag/1.0.0-beta.2)) on GitHub and documentation as GitHub Pages.

#### Incrementing after release (iOS)

**Preview release:** `1.0.0-beta.1` -> `1.0.0-beta.2`

**Stable Release:** `1.1.0` -> `1.2.0-beta.1`

**Stable Hotfix Release:** `1.0.0` -> `1.0.1`

#### Go

Go releases the source code of the repository in a single unit of source code. It does not ship packages to any package managers. Because the Go repo ships from the `main` branch, code going into the `main` branch must be in a completed state and ready to ship.

A Go release includes a Tag and Release (e.g. [sdk/azcore/v0.13.0](https://github.com/Azure/azure-sdk-for-go/releases/tag/sdk/azcore/v0.13.0)) on GitHub and documentation in pkg.go.dev (e.g. [sdk/azcore](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azcore@v0.13.0)).

Release tags for Go are made up of a `prefix` and a `version`. The `prefix` points to the module in the repository, while the `version` is the semantic import version for release. Read more about Go tags for release [here](https://github.com/golang/go/wiki/Modules#publishing-a-release).

Initial Go package releases will be versioned will use `v0` versioning with `v0.1.0` as the initial version. See [versioning guidelines](https://azure.github.io/azure-sdk/golang_introduction.html#package-versioning) for more details. 

#### Incrementing after release (Go)

**Beta Release for Initial Release:** `v0.1.0` -> `v0.1.1`

**Beta Release:** `v2.0.0-beta.1` -> `v2.0.0-beta.2`

**Stable Release:** `v1.0.0` -> `v1.0.1`

**Stable Hotfix Release:** `v1.0.0` -> `v1.0.1`

## Beta Releases and Stable Graduation

The Azure SDK team may choose to create a beta release for several reasons (beyond what is required for APEX Launch Requirements):

- Service itself has features in preview and client library must be updated accordingly
- Testing and receiving feedback on new API designs
- Stress and performance testing for new SDK features is incomplete

To create a beta, the release must:

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

- Support for at least 2 languages.  Preferably, support one statically typed language (such as C# or Java) and one dynamically typed language (such as TypeScript or Python).

To graduate to stable, a beta release must:

- Support all four tier-1 languages (.NET, Java, Python, TypeScript) unless there is a good (and documented) reason to not include support for one of the languages.

- Have final documentation.
  - Conceptual documentation for how the service works.
  - Samples of common uses cases for the service.

- Have a beta release available for at least one month to allow for community feedback.

- Have no known critical bugs.

- Have three reference customers external to the Azure organization who have given feedback on the library.

- Rely on non-preview API versions.

- Pass stress and performance testing and have unit, functional, performance and stress tests meeting maturity stage 1 or higher.

- Receive a final [Architecture Board] review.

- Receive final design sign-off from service team.

{% include refs.md %}
