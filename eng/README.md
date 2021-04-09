## Package Information

The package information for all languages is currently stored in a csv file located [here](https://github.com/Azure/azure-sdk/blob/master/_data/releases/latest). 
We have one csv file for each language and an [automation pipeline](https://github.com/Azure/azure-sdk/blob/master/eng/pipelines/version-updater.yml) that runs daily to check for 
new releases and updates the versioning information and doc links in the csv for each package. The version information will be updated from the specific package managers for the
given package ecosystem as well as by reading release tags from our mono repos. We can update more information like repo and doc information for things coming from our mono repos.


## CSV fields

- `Package` - This is the full name for the package as it appears on the package manager. 
- `GroupId` - This is only for Java and it contains the GroupId of the package. The Package field in Java's case only contains the ArtifactId.
- `VersionGA` - This contains the latest GA version for the given package. If one does not exist, the field is empty.
- `VersionPreview` - This contains the latest preview/beta/prerelease version for the given package. The field will be empty if there isn't a preview, or the preview is older than the latest GA.
- `DisplayName` - This is a friendly name for the package that is used in the package index and other contexts to display a nicer name for the package.
- `ServiceName` - This is the name of the service that this package is related to and is used in documentation contexts to group a set of packages for a given service together. 
- `RepoPath` - This contains information to create a link to the github repo for the given package. For our standard services that ship from our mono repos this should just be name of the service directory (e.g. `/sdk/<service directory>/<package>`). It can be a full link if this package is coming from somewhere else. A value of `NA` should be present if their is no go source link. 
- `MSDocs` - This contains information to create a link to the Microsoft Docs site for the given package. For our standard services that ship from our mono repos this should just be empty if the docs are published as the links will be computed from the other data in the CSV file. If the docs are in a non-standard location, then it can contain a full link in this field. A value of `NA` should be present if the docs link is unknown or doesn't exist. 
- `GHDocs` - This contains information to create a link to our Github IO ref docs. For our standard services that ship from our mono repos this should just be empty if the docs are published as the links will be computed from the other data in the CSV file. If the docs are in a non-standard location, then it can contain a full link in this field. A value of `NA` should be present if the docs link is unknown or doesn't exist. 
- `Type` - This field contains a classification type for the given package. If a classification is unknown the field is empty. The current classifications are:
  - `client` - This is used to represent a data plane library. 
  - `mgmt` - This is used to represent a management plane library.
  - `spring` - This is a special classification only for Java that represents the spring libraries.
- `New` - This field is set to true for any of our newer libraries that now following the guidelines outlined in this repo. 
- `PlannedVersions` - This field will list a set of versions combined with estimated dates in the format of `[version1],[date1]|[version2],[date2]|[version3],[date3]` with version in the format of `X.Y.Z[bN|-beta.N]` and date in the format of `MM/dd/yyyy`. These dates are intended to be displayed on a roadmap page. 
- `FirstGADate` - This field is used to identify the date of when a new package shipped its first GA. 
- `Support` - This field is used to identify the level of support for the given package. See the [support guidelines](https://azure.github.io/azure-sdk/policies_support.html#package-lifecycle) for more details but this field should contain `active`, `maintenance`, or `community`, if the value is empty it generally implies unknown or `beta` support level. 
- `Hide` - This field will determine whether we hide this package from various places like the package index, docs, as well as automated updates. The value is either true to hide or empty to not hide. This is useful to filter older packages that are still on the package managers, but we don't want to promote or display anywhere.
- `Notes` - This is an open field that can be used to add any particular notes for a given package that will be displayed in the package index. Commonly used to call out other packages that will be replaced by it.

## Link templates

In order to produce standard links without storing them all in the csv file we use [link templates](https://github.com/Azure/azure-sdk/tree/master/_includes/releases/variables) for each language in variable md files used by our jekyll site. 
We also parse those templates in our automation so that when updating we ensure the links are valid. As an example here are the [link templates](https://raw.githubusercontent.com/Azure/azure-sdk/master/_includes/releases/variables/java.md) we currently use:

```
{% assign package_label = "maven" %}
{% assign package_trim = "azure-" %}
{% assign pre_suffix = "" %}
{% assign package_url_template = "https://search.maven.org/artifact/item.GroupId/item.Package/item.Version/jar/" %}
{% assign msdocs_url_template =  "https://docs.microsoft.com/java/api/overview/azure/item.TrimmedPackage-readme" %}
{% assign ghdocs_url_template = "https://azuresdkdocs.blob.core.windows.net/$web/java/item.Package/item.Version/index.html" %}
{% assign source_url_template = "https://github.com/Azure/azure-sdk-for-java/tree/item.Package_item.Version/sdk/item.RepoPath/item.Package/" %}
```

The values in these templates of the format `item.<property>` are replaced from the field values in the CSV files. 

## Editing the CSV files

If you need to edit the CSV files please do not use Excel as it will remove all the quoting which is required by the consumers of the CSV (i.e. Jekyll and automation). Instead if it is a small edit please just use a normal text editor. If it is a larger edit the recomendation is to use the [Edit csv](https://marketplace.visualstudio.com/items?itemName=janisdd.vscode-edit-csv) extension for VS Code. When using that extension please set the following configuration options to ensure consistency. 

```
"csv-edit.quoteAllFields": true,
"csv-edit.quoteEmptyOrNullFields": "true",
"csv-edit.readOption_hasHeader": "true",
"csv-edit.writeOption_hasHeader": "true"
```
