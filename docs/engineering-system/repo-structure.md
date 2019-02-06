To help make our repos more consistent and easier to approach from our team as well as the community we should have a
consistent structure. That structure should avoid putting a lot of stuff in the root of the repo to make it appear neater
and allow folks visiting the repo to quickly see the root README.md without needing to scroll. To accomplish that every
azure-sdk language repo will put a README.md and a `sdk` folder in the root that will contain a folder for each library
package. It will be sdk, singular as opposed to plural, because we want folks to start realizing we only have one azure
sdk and not many.

To help drive a level of consistency across all our repos we would like to change the structure to look like:

```
sdk\<package name>\README.md
sdk\<package name>\*src*
sdk\<package name>\*tests*
sdk\<package name>\*samples*
```

- **`<package name>`** - Should be exact name of the shipping package. It will follow the naming guidelines set forth by the architectural board. Management plane libraries should have the term management included in package name in some form (i.e. -mgmt or .Management).
    - If there are multiple packages with the same name but different scope/org/groupid/SxS-version/etc then use that difference as a sub folder under the package name.
    - If there are long file path issues then you can use an abbreviation  of the package name to help avoid issues. For example Java tools require every part of the package/namespace to be a separate folder which can make the paths extra long and thus may need to abbreviate the package name to help alleviate the impact of long file paths on windows.
- Every package directory must contain the following:
    - A README.md in the package root folder that contains documentation for the package
    - A folder which contains the source code for the library contained in the package in whatever format is appropriate for the specific language and tools.
    - A folder which contains the test code for the library contained in the package in whatever format is appropriate for the specific language and tools.
    - A folder which contains sample code for the library contained in the package in whatever format is appropriate for the specific language and tools.

### Examples:

#### .NET Repo
```
sdk\Microsoft.Azure.Management.KeyVault\README.md
sdk\Microsoft.Azure.Management.KeyVault\src
sdk\Microsoft.Azure.Management.KeyVault\tests
sdk\Microsoft.Azure.Management.KeyVault\samples
sdk\Microsoft.Azure.KeyVault\README.md
sdk\Microsoft.Azure.KeyVault\src
sdk\Microsoft.Azure.KeyVault\tests
sdk\Microsoft.Azure.KeyVault\samples
```

#### Python Repo
```
sdk\azure-mgmt-keyvault\README.md
sdk\azure-mgmt-keyvault\azure\mgmt\keyvault\
sdk\azure-mgmt-keyvault\tests
sdk\azure-mgmt-keyvault\samples
sdk\azure-keyvault\README.md
sdk\azure-keyvault\azure\keyvault\
sdk\azure-keyvault\tests
sdk\azure-keyvault\samples
```

#### Java Repo
```
sdk\azure-mgmt-keyvault\README.md
sdk\azure-mgmt-keyvault\src\main
sdk\azure-mgmt-keyvault\src\test
sdk\azure-mgmt-keyvault\src\samples
sdk\azure-keyvault\README.md
sdk\azure-keyvault\src\main
sdk\azure-keyvault\src\test
sdk\azure-keyvault\src\samples
```

#### JS Repo
```
sdk\arm-keyvault\README.md
sdk\arm-keyvault\lib
sdk\arm-keyvault\test
sdk\arm-keyvault\samples
sdk\keyvault\README.md
sdk\keyvault\lib
sdk\keyvault\test
sdk\keyvault\samples
```