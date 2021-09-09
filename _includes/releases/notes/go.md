## Installation Instructions

To use the latest GA and beta libraries use the `go get` command to add the package to a go.mod file. If your project does not use Go modules, refer to the Go documentation for information about specifying dependencies.

{% assing allPackagesSortedByName = allPackages | sort: 'Name' %}

{% for package in allPackagesSortedByName %}
    ```
    go get -u github.com/Azure/azure-sdk-for-go/sdk/{{ package.GroupId }}/{{ package.Name }}@v{{ package.Version }}
    ```
{% endfor %}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-go/issues).

## Release highlights

{% include releases/notes/release_highlights.md %}

## Need help

- For reference documentation visit the [Azure SDK for Go documentation](https://azure.github.io/azure-sdk-for-go/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Go repository](https://github.com/azure/azure-sdk-for-go/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-go/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-go-sdk) or ask new ones on StackOverflow using the `azure-go-sdk` tag.

## Latest Releases

View all the latest versions of go packages [here][go-latest-releases].

{% include refs.md %}