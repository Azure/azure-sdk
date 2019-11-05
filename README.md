# Azure SDK

The Azure SDK delivers a platform for developers to leverage the wide variety of Azure services in their language of choice. The source for the client libraries exists for the most part in repositories for each language. This repository is meant to be a jumping off point into those language specific repositories. Issues related to a specific language should be opened in the corresponding repository but cross cutting issues can be opened in this repository.

| Language    | Design Guidelines                                                       | Repo                                                                | Documentation
|:------------|:-----------------------------------------------------------------------:|:-------------------------------------------------------------------:|:-------------------------:|
| General   |[General Design Guidelines][general]    |[azure-sdk Repository](https://github.com/Azure/azure-sdk)      | [Official Azure Documentation](http://aka.ms/azure-sdk-docs) |
| C#  /.NET   |[Design Guidelines for .NET][dotnet]    |[azure-sdk-for-net Repository](https://github.com/Azure/azure-sdk-for-net)      | [.NET Preview Documentation](http://aka.ms/net-docs) |
| Go          |                                                                         |[azure-sdk-for-go Repository](https://github.com/Azure/azure-sdk-for-go)        | [Go Documentation](http://aka.ms/go-docs) |
| Java        |[Design Guidelines for Java][java]      |[azure-sdk-for-java Repository](https://github.com/Azure/azure-sdk-for-java)    | [Java Documentation](http://aka.ms/java-docs)   |
| JavaScript  |[Design Guidelines for JavaScript and TypeScript][typescript] |[azure-sdk-for-js Repository](https://github.com/Azure/azure-sdk-for-js)        | [JavaScript Documentation](http://aka.ms/js-docs)|
| Python      |[Design Guidelines for Python][python]    |[azure-sdk-for-python Repository](https://github.com/Azure/azure-sdk-for-python)| [Python Documentation](https://aka.ms/python-docs) |

Service teams should schedule reviews of their client libraries with the ADP Review Board.  See the [Review Process][revproc] for more information.

## Terminology

- **SDK**: Software Development Kit. This refers to the entire Azure SDK for a single language, itself broken up into numerous Azure SDK _Client Libraries_ (as defined below).

- **Client Library**. This refers to a library (and associated tools, documentation, and samples) that customers/developers use to ease working with an Azure service. There is often one client library per service and per programming language. Sometimes a single client library will contain the ability to connect to multiple services. Each client library is published separately to the appropriate language-specific package repository.  These releases are performed exclusively by the Azure SDK engineering systems team. Customers/Developers consume and use each client library separately as necessary to solve their use case.

- **Package**. This refers to a client library after it has been packaged for distribution for customer-developers to consume. Examples are:
   - A NuGet package for a .NET client library
   - A Maven package for a Java library
   - An npm package for a JavaScript library
   - A Python wheel for a Python library

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

[Internal azure-sdk DevOps Wiki](https://aka.ms/azure-sdk-devops-wiki)

[general]: https://azure.github.io/azure-sdk/general_introduction.html
[dotnet]: https://azure.github.io/azure-sdk/dotnet_introduction.html
[java]: https://azure.github.io/azure-sdk/java_introduction.html
[typescript]: https://azure.github.io/azure-sdk/typescript_introduction.html
[python]: https://azure.github.io/azure-sdk/python_introduction.html
[revproc]: https://azure.github.io/azure-sdk/policies_reviewprocess.html

