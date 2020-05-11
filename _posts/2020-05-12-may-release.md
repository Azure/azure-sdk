---
title: Azure SDK Releases (May 2020)
layout: post
date: 2020-05-12
sidebar: releases_sidebar
repository: azure/azure-sdk
author_github: jianghaolu
---

Welcome to the May release of the Azure SDK.  We have updated the following libraries:

* Event Hubs
* Storage (Python only)

These are ready to use in your production applications.  You can find details of all released libraries on [our releases page]({{site.baseurl}}{% link releases/latest/index.md %}).

New preview releases:

* Form Recognizer
* Search
* Service Bus

In addition, there is a new preview release for Azure Identity, which features improvements to the `DefaultAzureCredential` to better support common developer workflows.  See below for more details.

We believe these are ready for you to use and experiment with, but not yet ready for production.  Between now and the GA release, these libraries may undergo API changes.  We'd love your feedback!  If you use these libraries and like what you see, or you want to see changes, let us know in GitHub issues.

## Getting Started

Use the links below to get started with your language of choice.  You will notice that all the preview libraries are tagged with "preview".

* [.NET release notes]({{site.baseurl}}{% link releases/2020-05/dotnet.md %})
* [Java release notes]({{site.baseurl}}{% link releases/2020-05/java.md %})
* [Python release notes]({{site.baseurl}}{% link releases/2020-05/python.md %})
* [JavaScript release notes]({{site.baseurl}}{% link releases/2020-05/js.md %})

If you want to dive deep into the content, the release notes linked above and the change logs they point to give more details on what has changed.

## In depth: Azure Identity

In the Azure SDK, `DefaultAzureCredential` is the recommended way to handle authentication across your local workstation and your deployment environment. It attempts to figure out what environment you are running in, and uses the most appropriate credential for the purpose. Its use and features are explained in our [previous blog post](https://azure.github.io/azure-sdk/posts/2020-02-25/defaultazurecredentials.html). The latest release of the Azure Identity library contains numerous improvements to improve the developer experience around authentication, including integration with more tools and better diagnostics.

## New credential types

DefaultAzureCredential looks through four specific locations to find suitable information for authenticating to the service: environment variables, managed identity, the MSAL shared token cache (supporting tools like Visual Studio) and the Azure CLI. In .NET and Python, you can also enable an interactive browser, which asks you to log into Azure. In this release, we are adding more credentials that can work seamlessly in your favorite IDEs. Most of these credentials are stored in encrypted locations, eliminating the need to set up credentials in a file or environment variables, thus lowering your risk of exposing your personal identification information on your workstation.

In this release, we will support authentication via standard tooling: Visual Studio (for .NET), Visual Studio Code, IntelliJ (for Java), and the Azure CLI. They are slotted onto the end of the default credential chain provided in DefaultAzureCredential. The new list of credentials `DefaultAzureCredential` supports and attempts to authenticate with are listed below, in order:

1. `EnvironmentCredential`
1. `ManagedIdentityCredential`
1. `SharedTokenCacheCredential` (Windows only, with MacOS & Linux supporting coming soon)
1. `VisualStudioCredential` (.NET only)
1. `IntelliJCredential` (Java only)
1. `VisualStudioCodeCredential`
1. `AzureCliCredential`
1. `InteractiveBrowserCredential` (.NET & Python only, disabled by default)

I'll now walk you through the steps to configure and set up these credentials.

### VisualStudioCodeCredential

The Visual Studio Code authentication is handled by an integration with the Azure Account extension. To use, install the Azure Account extension, then use View->Command Palette to execute the "Azure: Sign In" command:

![]({{ site.baseurl }}{% link images/posts/05122020-vscode-sign-in.png %})

This will open a browser that allows you to sign in to Azure. Once you have completed the login process, you can close the browser as directed. Running your application (either in the debugger or anywhere on the development machine) will use the credential from your sign-in.

![]({{ site.baseurl }}{% link images/posts/05122020-vscode-logged-in.png %})

Once you are logged in, in your application, your `DefaultAzureCredential` will be able to pick up the user account logged in:

```csharp
// .NET
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential(true));
```

```java
// Java
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

```javascript
// JavaScript
const client = new SecretClient(keyVaultUrl, new DefaultAzureCredential());
```

```py
# Python
client = SecretClient(vault_url, DefaultAzureCredential())
```

### VisualStudioCredential

For .NET developers using Visual Studio 2017 or above, we are adding another credential `VisualStudioCredential`. Applications using this credential will be able to use the same account logged in Visual Studio.

In your Visual Studio window, On the right top corner there should show your name or a "Sign in" link. Sign in or click on your name -> Account settings. Make sure your account is listed in the "All Accounts" section.

![]({{ site.baseurl }}{% link images/posts/05122020-vs-accounts.png %})

Once you are logged in, in your application, your `VisualStudioCredential` will be able to pick up the user account logged in:

```csharp
// .NET
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential(true));
```

### IntelliJCredential

For Java developers using IntelliJ IDEA, we are adding another credential `IntelliJCredential`. Applications using this credential will be able to use the same account logged in Azure Toolkit for IntelliJ. You will need IntelliJ IDEA 2019.1 or above and the latest Azure Toolkit for IntelliJ plugin.

In your IntelliJ window, open File -> Settings -> Plugins. Search "Azure Toolkit for IntelliJ" in the marketplace. Install and restart IDE. 

Now you should be able to find a new menu item Tools -> Azure -> Azure Sign In... 

![]({{ site.baseurl }}{% link images/posts/05122020-intellij-sign-in.png %})

Device Login will help you login as a user account. Follow the instructions to login on the login.microsoftonline.com website with the device code. IntelliJ will prompt you to select your subscriptions. You are free to choose any you want - it doesn't matter for our use case.

Once you are logged in, in your application, your `DefaultAzureCredential` will be able to pick up the user account automatically on Mac or Linux:

```java
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

On Windows, sepcify the KeePass database path to read IntelliJ credentials. You can find the path in IntelliJ settings under File -> Settings -> Appearance & Behavior -> System Settings -> Passwords:

![]({{ site.baseurl }}{% link images/posts/05122020-intellij-keepass.png %})

And pass the database path into the `DefaultAzureCredentialBuilder`:

```java
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder()
    .intelliJKeePassDatabasePath("C:\\Users\\jianghaolu\\AppData\\Roaming\\JetBrains\\IdeaIC2020.1\\c.kdbx")
    .build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

## Adjust which credentials are used in DefaultAzureCredential

With the increasing number of credentials in the `DefaultAzureCredential` chain and the automatic fallback to the next credential design, it's difficult to control and monitor which credential is actually being used. We are introducing a set of new ways to fine control which exceptions to exclude, when to fail and when to fallback to the next credential in chain, and how to monitor which credential is being used.

### Exclude certain credentials

Sometimes, the environment we are running our applications in uses a credential sitting in the back of the chain. When `DefaultAzureCredential` searches for a credential to authenticate with, it will attempt a few other credentials to reach the one desired. This is not only slow, but could also pick up the wrong credential, or peeking into secure system data we'd like to avoid. In this release, you can now customize the chain by excluding any number of them when creating an instance of `DefaultAzureCredential`. For example, in my development environment I use `VisualStudioCodeCredential` and my application is deployed to a virtual machine in Azure where Managed Identity is available, I can create a `DefaultAzureCredential` as follows:

```csharp
// .NET
var options = new DefaultAzureCredentialOptions
{
    ExcludeEnvironmentCredential = true,
    ExcludeManagedIdentityCredential = false,
    ExcludeSharedTokenCacheCredential = true,
    ExcludeVisualStudioCredential = true,
    ExcludeVisualStudioCodeCredential = false,
    ExcludeAzureCliCredential = true,
    ExcludeInteractiveBrowserCredential = true
};

var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential(options));
```

```java
// Java
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder()
    .excludeEnvironmentCredential()
    .excludeSharedTokenCacheCredential()
    .excludeVsCodeCredential()
    .excludeIntelliJCredential()
    .build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

```py
# Python
credential = DefaultAzureCredential(
    exclude_environment_credential=True,
    exclude_shared_token_cache_credential=True,
    exclude_cli_credential=True
)
client = SecretClient(vault_url, credential)
```

The `SecretClient` created with the above code will only attempt authentication with `ManagedIdentityCredential` and `VisualStudioCodeCredential`. This feature is not available in JavaScript yet - similar configurations on what underlying credentials will be used to authenticate in a DefaultAzureCredential will come soon for JavaScript.

### Fail the authentication, don't try the next

When a credential fails to authenticate, DefaultAzureCredential automatically tries the next credential. This can cause problems when you partially configure a credential. For example, in the past, if the secret in the environment variable `AZURE_CLIENT_SECRET` expired, `DefaultAzureCredential` will try the other options. If you have accounts signed in VS Code or Azure CLI, `DefaultAzureCredential` may be using those accounts without you realizing it.

In the latest release, if the configuration is present for a credential, but authentication fails, the entire chain fails, resulting in a faster "fail". We achieve this by adding an exception type `CredentialUnavailableException`. `DefaultAzureCredential` will only attempt to authenticate with the next credential if a `CredentialUnavailableException` is thrown from the current credential. In the above example, if the environment variables are present but authentication failed, the `EnvironmentCredential` will not throw `CredentialUnavailableException`, causing `DefaultAzureCredential` to propagate the exception and stop trying other credentials.

## Community acknowledgements
I'd like to give special thanks to Alejandro Baeza(https://github.com/alexbaeza) and Kiran Hegde(https://github.com/HankiGreed) for helping us improve the Azure Identity libraries on GitHub. Your contributions have helped many people and organizations succeed!

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback ranging from documentation issues to API surface area change requests to pointing out failure cases.  Please keep that coming.  We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk/)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@AzureSDK](https://twitter.com/AzureSDK) on Twitter.