# Azure SDK

The Azure SDK delivers a platform for developers to leverage the wide variety of Azure services in their language of choice. The source for the client libraries exists for the most part in repositories for each language. This repository is meant to be a jumping off point into those language specific repositories. Issues related to a specific language should be opened in the corresponding repository but cross cutting issues can be opened in this repository.

| Language    | Design Guidelines                           | Repo                             | Documentation                    |
|:------------|:-------------------------------------------:|:--------------------------------:|:--------------------------------:|
| General     |[General Design Guidelines]                  |[azure-sdk Repository]            | [Official Azure Documentation]   |
| Android     |[Design Guidelines for Android] (Draft)      |[azure-sdk-for-android Repository]| Coming Soon                      |
| C# /.NET    |[Design Guidelines for .NET]                 |[azure-sdk-for-net Repository]    | [.NET Documentation]             |
| Go          |[Design Guidelines for Go] (Draft)           |[azure-sdk-for-go Repository]     | [Go Documentation]               |
| iOS         |[Design Guidelines for iOS] (Draft)          |[azure-sdk-for-ios Repository]    | Coming Soon                      |
| Java        |[Design Guidelines for Java]                 |[azure-sdk-for-java Repository]   | [Java Documentation]             |
| JavaScript  |[Design Guidelines for TypeScript]           |[azure-sdk-for-js Repository]     | [JavaScript Documentation]       |
| Python      |[Design Guidelines for Python]               |[azure-sdk-for-python Repository] | [Python Documentation]           |

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

[General Design Guidelines]: https://azure.github.io/azure-sdk/general_introduction.html
[Design Guidelines for Android]: https://azure.github.io/azure-sdk/android_introduction.html
[Design Guidelines for .NET]: https://azure.github.io/azure-sdk/dotnet_introduction.html
[Design Guidelines for Go]: https://azure.github.io/azure-sdk/golang_introduction.html
[Design Guidelines for iOS]: https://azure.github.io/azure-sdk/ios_introduction.html
[Design Guidelines for Java]: https://azure.github.io/azure-sdk/java_introduction.html
[Design Guidelines for TypeScript]: https://azure.github.io/azure-sdk/typescript_introduction.html
[Design Guidelines for Python]: https://azure.github.io/azure-sdk/python_introduction.html
[revproc]: https://azure.github.io/azure-sdk/policies_reviewprocess.html

[azure-sdk Repository]: https://github.com/Azure/azure-sdk
[azure-sdk-for-android Repository]: https://github.com/Azure/azure-sdk-for-android
[azure-sdk-for-net Repository]: https://github.com/Azure/azure-sdk-for-net
[azure-sdk-for-go Repository]: https://github.com/Azure/azure-sdk-for-go
[azure-sdk-for-ios Repository]: https://github.com/Azure/azure-sdk-for-ios
[azure-sdk-for-java Repository]: https://github.com/Azure/azure-sdk-for-java
[azure-sdk-for-js Repository]: https://github.com/Azure/azure-sdk-for-js
[azure-sdk-for-python Repository]: https://github.com/Azure/azure-sdk-for-python

[Official Azure Documentation]: http://aka.ms/azure-sdk-docs
[.NET Documentation]: http://aka.ms/net-docs
[Go Documentation]: http://aka.ms/go-docs
[Java Documentation]: http://aka.ms/java-docs
[JavaScript Documentation]: http://aka.ms/js-docs
[Python Documentation]: https://aka.ms/python-docs
