---
title: "Policies: Repository Structure"
permalink: policies_repostructure.html
folder: policies
sidebar: general_sidebar
---

To help make our repos more consistent and easier to approach from our team as well as the community we should have a consistent structure. That structure should avoid putting a lot of stuff in the root of the repo to make it appear neater and allow folks visiting the repo to quickly see the root README.md without needing to scroll. The directory structure should look like:

- `common` - Will contain source code or projects that are not shipping artifacts but are shared and used by our sdk libraries. Things like common test projects or shared test or source code.
- `doc` - Contains documenation, usually in markdown files, for anything in the repo. It should also contain a README.md that states the purposes of all the folders under `doc`.  ([Example](https://github.com/Azure/azure-sdk-for-python/blob/master/doc/README.md))
  - `doc\dev` - Contains the set of documation needed for developers that are contributing to the repository.
- `eng` - Used to contain things needed by the engineering system to build, test, or perform other related tasks. It will usually contain configure files, build definitions, scripts and other tools (generally not checked in binaries).
- `sdk` - Primary directory which will contain our sdk library source code. See below for more details on its layout.


 To accomplish that every azure-sdk language repo will put a README.md and a `sdk` folder in the root that will contain a folder for each service which will then contain a folder for each package associated with the service. It will be `sdk`, singular as opposed to plural, because we want developers to realize we only have one azure sdk and not many.

### SDK directory layout

Every azure-sdk language repo will put a README.md and a `sdk` folder in the root that will contain a folder for each service which will then contain a folder for each package associated with the service. It will be `sdk`, singular as opposed to plural, because we want developers to realize we only have one azure sdk and not many.

```
sdk\<service name>\<package name>\README.md
sdk\<service name>\<package name>\*src*
sdk\<service name>\<package name>\*tests*
sdk\<service name>\<package name>\*samples*
```

- **`<service name>`** - Should be the short name for the azure service. It will be used to group all the various packages for a given service, including the management and data-plane packages, as well as any multi-api (e.g. or different profile versions (e.g AzureStack). Any shared artifacts like release notes or versions should go into this root repo. These names should match across all the different language repos and by default should be what is in the specificiation folder in the [azure-rest-api-specs](https://github.com/azure/azure-rest-api-specs) repo.
- **`<package name>`** - Should be the name of the shipping package, or an abbreviation that distinguishes the given shipping artifact for the given service. The key is that there is source for only one shipping package in this folder.
    - If there are multiple packages with the same name but different scope/org/groupid/SxS-version/etc then put them each in their own folder under the service name directory with names that match whatever distinguishes them from each other.
    - If there are long file path issues then you can use an abbreviation of the package name to help avoid issues. For example Java tools require every part of the package/namespace to be a separate folder which can make the paths extra long and thus may need to abbreviate the package name to help alleviate the impact of long file paths on windows.
    - If there are other assets that aren't shipping packages, such as shared libaries/source code or tools, they can also go in a folder under the service name directory.
- Every package directory must contain the following:
    - A README.md in the package root folder that contains documentation for the package
    - A folder which contains the source code for the library contained in the package in whatever format is appropriate for the specific language and tools.
    - A folder which contains the test code for the library contained in the package in whatever format is appropriate for the specific language and tools.
    - A folder which contains sample code for the library contained in the package in whatever format is appropriate for the specific language and tools.

### Examples:

#### .NET Repo
```
sdk\keyvault\Microsoft.Azure.Management.KeyVault\README.md
sdk\keyvault\Microsoft.Azure.Management.KeyVault\src
sdk\keyvault\Microsoft.Azure.Management.KeyVault\tests
sdk\keyvault\Microsoft.Azure.Management.KeyVault\samples
sdk\keyvault\Microsoft.Azure.KeyVault\README.md
sdk\keyvault\Microsoft.Azure.KeyVault\src
sdk\keyvault\Microsoft.Azure.KeyVault\tests
sdk\keyvault\Microsoft.Azure.KeyVault\samples
```

#### Python Repo
```
sdk\keyvault\azure-mgmt-keyvault\README.md
sdk\keyvault\azure-mgmt-keyvault\azure\mgmt\keyvault\
sdk\keyvault\azure-mgmt-keyvault\tests
sdk\keyvault\azure-mgmt-keyvault\samples
sdk\keyvault\azure-keyvault\README.md
sdk\keyvault\azure-keyvault\azure\keyvault\
sdk\keyvault\azure-keyvault\tests
sdk\keyvault\azure-keyvault\samples
```

#### Java Repo
```
sdk\keyvault\azure-mgmt-keyvault\README.md
sdk\keyvault\azure-mgmt-keyvault\src\main
sdk\keyvault\azure-mgmt-keyvault\src\test
sdk\keyvault\azure-mgmt-keyvault\src\samples
sdk\keyvault\azure-keyvault\README.md
sdk\keyvault\azure-keyvault\src\main
sdk\keyvault\azure-keyvault\src\test
sdk\keyvault\azure-keyvault\src\samples
```

#### JS Repo
```
sdk\keyvault\arm-keyvault\README.md
sdk\keyvault\arm-keyvault\src
sdk\keyvault\arm-keyvault\test
sdk\keyvault\arm-keyvault\samples
sdk\keyvault\keyvault\README.md
sdk\keyvault\keyvault\src
sdk\keyvault\keyvault\test
sdk\keyvault\keyvault\samples
```