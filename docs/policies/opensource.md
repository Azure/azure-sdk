---
title: "Policies: Open source"
permalink: policies_opensource.html
folder: policies
sidebar: general_sidebar
---

{% include requirement/MUST %} ensure that all library code is public and open-source on GitHub. Library code must be placed in the Azure SDK 'mono-repo' for its language:

* [Azure SDK for .NET](https://github.com/Azure/azure-sdk-for-net)
* [Azure SDK for Java](https://github.com/Azure/azure-sdk-for-java)
* [Azure SDK for JavaScript](https://github.com/Azure/azure-sdk-for-js)
* [Azure SDK for Python](https://github.com/Azure/azure-sdk-for-python)
* [Azure SDK for Go](https://github.com/Azure/azure-sdk-for-go)
* [Azure SDK for C++](https://github.com/Azure/azure-sdk-for-cpp)
* [Azure SDK for Embedded C](https://github.com/Azure/azure-sdk-for-c)

{% include requirement/SHOULD %} develop in the open on GitHub. Seek feedback from the community on design choices and be active in conversations with the community.

{% include requirement/MUST %} remain active in GitHub. Your client library is your primary touchpoint with the developer community, so it's important to keep up with the activity there. Issues and pull requests on GitHub must have an authoritative comment within one week of filing.

{% include requirement/MUST %} review the Microsoft Open Source Guidelines' [community section](https://docs.opensource.microsoft.com/releasing/foster-your-community.html) for more information on fostering a healthy open-source community.

{% include requirement/MUST %} use the [Microsoft CLA](https://cla.opensource.microsoft.com/). Microsoft makes significant contributions to [cla-assistant](https://cla-assistant.io/). It is the easiest way to ensure the CLA is signed by all contributors.

{% include requirement/MUST %} include a copyright header at the top of every source file (including samples). See the [Microsoft Open Source Guidelines](https://docs.opensource.microsoft.com/releasing/copyright-headers.html) for example headers in various languages.

The expected copyright header is as follows:

```fundamental
Copyright (c) Microsoft Corporation.
Licensed under the MIT license.
```

{% include important.html content="There is currently disagreement between the Microsoft Open Source Guidelines and this advice.  This advice is current as of August 2019.  Consult CELA if you are unsure as to the proper license." %}

## CONTRIBUTING.md

{% include requirement/MUST %} include a `CONTRIBUTING.md` file in your GitHub repository, using it to describe the process by which contributors can make contributions to the project.  An example `CONTRIBUTING.md` is provided by the [Microsoft Open Source Guidelines](https://docs.opensource.microsoft.com/releasing/overview.html):

```
# Contributing

This project welcomes contributions and suggestions. Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repositories using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
```

## LICENSE

{% include requirement/MUST %} include a `LICENSE` file containing your license text (which by default should be the [standard MIT license](https://docs.opensource.microsoft.com/releasing/overview.html#license-files)).

## CODEOWNERS

`CODEOWNERS` is a GitHub standard to specify who is automatically assigned pull requests to review. This helps prevent pull requests from languishing without review. GitHub can also be configured to require review from code owners before a pull request can be merged. Further reading is available from the following two URLs:

- [https://blog.github.com/2017-07-06-introducing-code-owners/](https://blog.github.com/2017-07-06-introducing-code-owners/)
- [https://help.github.com/articles/about-codeowners/](https://help.github.com/articles/about-codeowners/)

{% include requirement/MUST %} edit the root-level CODEOWNERS file to ensure that it is updated to redirect all pull requests for the directory of the client library to point to the relevant engineers of this component. If the client library will exist within its own repository, then a CODEOWNERS file must be introduced and configured appropriately.

Use the following rules to ensure that we can use CODEOWNERS for both GitHub and build failure notifications: 

* Use the `/.github/CODEOWNERS` file
* Follow the `/sdk/<service name>/` (with the leading and trailing slashes) convention to define service owners
  * When using this format, service owners will be automatically subscribed to build notification failure alerts
* Place more general rules higher in the file and more specific rules lower in the file as GitHub uses the last matching expression
* Use only GitHub person aliases for the owners (e.g. `@person`). GitHub groups, GitHub users that aren't linked to internal users, internal group aliases, and email addresses are not supported at this time.
* If you want PRs in those folders to be auto-labeled, add a comment line above the entry with the path with the content of `# PRLabel: ` followed by the `%Label` you want to apply. Note: Currently wildcards are not supported and just one label per folder works for now.
* You can also capture the information about which people have to be notified when issues are filed for a service. To do that, you have to add the `# ServiceLabel: ` followed by the `%Label` that have to be applied to an issue in order for the people specified in the path below to be mentioned by the bot. 
* If the code for a service is not inside the repo, you can use this special commented out path to allow issues to be tagged for a service: `#/<NotInRepo>/`
* For the labels that are used with the `%` character, you can use spaces. Labels are delimited by the start of the `%` character.

```gitignore
# Catch-all for SDK changes
/sdk/  @person1 @person2

# Service teams
/sdk/azconfig/   @person3 @person4

# Example for a service that needs issues to be labeled
# ServiceLabel: %KeyVault %Service Attention
/sdk/keyvault/   @person5 @person6

# Example for a service that needs PRs to be labeled
# PRLabel: %label
/sdk/servicebus/ @person7 @person8

# Example for a service that needs both issues and PRs to be labeled
# ServiceLabel: %label
# PRLabel: %label
/sdk/eventhubs/ @person7 @person8

# Example for service that does not have the code in the repo but wants issues to be labeled
# Notice the use of the moniker /<NotInRepo>/
# ServiceLabel: %label %Service Attention
#/<NotInRepo>/ @person7 @person8

```

This example `CODEOWNERS` file has a catch-all list of owners at the top of the file and drills into specific service teams. GitHub uses the *last* matching expression to assign reviewers. For example, a PR with changes in `/sdk/keyvault/` will result in `@person5` and `@person6` being added to the PR. If a new service, like batch, were added with changes under `/sdk/batch/` then `@person1` and `@person2` will be assigned.
