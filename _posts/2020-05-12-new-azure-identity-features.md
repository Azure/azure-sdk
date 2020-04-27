# New Azure Identity features for developers

In the Azure Identity library, `DefaultAzureCredential` is the recommended way to handle authentication across your local workstation and your deployment environment. It attempts to figure out what environment you are running in, and uses the most appropriate credential for the purpose. Its use and features are explained in our previous blog post: https://azure.github.io/azure-sdk/posts/2020-02-25/defaultazurecredentials.html.

The Azure Identity library May release contains a collection of efforts to improve the developer experience of using `DefaultAzureCredential`, including better exception handling, logging, and an addition of credentials for IDE integration. I hope you will find these new features handy in your everyday work.

## DefaultAzureCredential: New credentials

So far there are 4 credentials types `DefaultAzureCredential` supports. It attempts to use `EnvironmentCredential`, `ManagedIdentityCredential`, `SharedTokenCacheCredential`, and `AzureCliCredential`, in that order. The .NET library also supports `InteractiveBrowserCredential`. In the Azure Identity May release, we are adding more credentials that can work seamlessly in your favorite IDEs. Most of these credentials are stored in encrypted locations, eliminating the need to set up credentials in a file or environment variables, thus lowering your risk of exposing your personal identification information on your workstation.

We are adding `VisualStudioCodeCredential` to .NET, Java, Python and JavaScript libraries. For .NET we are also adding a `VisualStudioCredential`. For Java we are also adding an `IntelliJCredential`. The new list of credentials `DefaultAzureCredential` supports and attempts to authenticate with are listed below, in order:

1. `EnvironmentCredential`
1. `ManagedIdentityCredential`
1. `SharedTokenCacheCredential`
1. `VisualStudioCredential` (.NET only)
1. `IntelliJCredential` (Java only)
1. `VisualStudioCodeCredential`
1. `AzureCliCredential`
1. `InteractiveBrowserCredential` (.NET only)

I'll now walk you through the steps to configure and set up these credentials.

### VisualStudioCodeCredential

In your VS Code window, navigate to Extensions and install Azure Account (https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account). Then execute command "Azure: Sign In":

![]({{ site.baseurl }}{% link images/posts/05122020-vscode-sign-in.png %})

The browser should navigate to a page under `login.microsoftonline.com` and direct you through the login process. Once you are sucessfully logged in, you will see a web page:

![]({{ site.baseurl }}{% link images/posts/05122020-vscode-logged-in.png %})

Once you are logged in, in your application, your `DefaultAzureCredential` will be able to pick up the user account logged in:

```csharp
// .NET
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential(true));
```

```java
// Java
DefaultAzureCredential credential = new DefaultAzureCredential().build();

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
// Python
client = SecretClient(keyVaultUrl, DefaultAzureCredential())
```

Since there are other credentials in the `DefaultAzureCredential` chain, it may pick up another credential before it reaches `VisualStudioCodeCredential`. To exclude the previous credentials, see [Exclude certain credentials](#exclude-certain-credentials).

### VisualStudioCredential

For .NET developers using Visual Studio 2017 or above, we are adding another credential `VisualStudioCredential`. Applications using this credential will be able to use the same account logged in Visual Studio.

In your Visual Studio window, On the right top corner there should show your name or a "Sign in" link. Sign in or click on your name -> Account settings. Make sure your account is listed in the "All Accounts" section.

![]({{ site.baseurl }}{% link images/posts/05122020-vs-accounts.png %})

Once you are logged in, in your application, your `VisualStudioCredential` will be able to pick up the user account logged in:

```csharp
// .NET
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential(true));
```

Since there are other credentials in the `DefaultAzureCredential` chain, it may pick up another credential before it reaches `VisualStudioCredential`. To exclude the previous credentials, see [Exclude certain credentials](#exclude-certain-credentials).

### IntelliJCredential

For Java developers using IntelliJ IDEA, we are adding another credential `IntelliJCredential`. Applications using this credential will be able to use the same account logged in Azure Toolkit for IntelliJ.

In your IntelliJ window, open File -> Settings -> Plugins. Search "Azure Toolkit for IntelliJ" in the marketplace. Install and restart IDE. 

Now you should be able to find a new menu item Tools -> Azure -> Azure Sign In... 

![]({{ site.baseurl }}{% link images/posts/05122020-intellij-sign-in.png %})

Device Login will help you login as a user account. Follow the instructions to login on the login.microsoftonline.com website with the device code. IntelliJ will prompt you to select your subscriptions. You are free to choose any you want - it doesn't matter for our use case.

Once you are logged in, in your application, your `DefaultAzureCredential` will be able to pick up the user account logged in:

```java
DefaultAzureCredential credential = new DefaultAzureCredential().build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

Since there are other credentials in the `DefaultAzureCredential` chain, it may pick up another credential before it reaches `IntelliJCredential`. To exclude the previous credentials, see [Exclude certain credentials](#exclude-certain-credentials).

## DefaultAzureCredential: Fine control over which credentials are used

You may have noticed, with the increasing number of credentials in the `DefaultAzureCredential` chain and the automatic fallback to the next credential design, it's difficult to control and monitor which credential is actually being used. Therefore, we are introducing a set of new ways to fine control which exceptions to exclude, when to fail and when to fallback to the next credential in chain, and how to monitor which credential is being used.

### Exclude certain credentials

Sometimes, the environment we are running our applications in uses a credential sitting in the back of the chain. When `DefaultAzureCredential` searches for a credential to authenticate with, it will attempt a few other credentials to reach the one desired. This is not only slow, but could also pick up the wrong credential, or peeking into secure system data we'd like to avoid.
In the May release, you can now customize the chain by excluding any number of them when creating an instance of `DefaultAzureCredential`.

For example, in my development environment I use `VisualStudioCodeCredential` and my application is deployed to a virtual machine in Azure where Managed Identity is available, I can create a `DefaultAzureCredential` as follows:

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
    .excludeIntelliJCredential()
    .excludeAzureCliCredential()
    .build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

```py
// Python
credential = DefaultAzureCredential(
    exclude_environment_credential=True,
    exclude_shared_token_cache_credential=True,
    exclude_cli_credential=True
)
client = SecretClient(keyVaultUrl, credential)
```

The `SecretClient` created with the above code will only attempt authentication with `ManagedIdentityCredential` and `VisualStudioCodeCredential`. This feature is not available in JavaScript yet - similar configurations on what underlying credentials will be used to authenticate in a DefaultAzureCredential will come soon for JavaScript.

### Fail the authentication, don't try the next

Other than excluding certain credentials, another challenge we face a lot is that when a credential fails to authenticate, `DefaultAzureCredential` will automatically try the next credential, which may lead to unwanted behaviors. Your application could be authenticating with a totally different credential you anticipated for the whole time.

For example, in my development environment my application uses `EnvironmentCredential` and in Azure it uses `ManagedIdentityCredential`. So I wrote the following code:

```java
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl("https://mysecretkeyvault.vault.azure.net")
    .credential(credential)
    .buildClient();
```

However, I had a typo in my environment variable `AZURE_CLIENT_SECRET`, causing the authentication to fail. In the past, `DefaultAzureCredential` will skip past the failed `EnvironmentCredential`, and `ManagedIdentityCredential` next since this is not running in Azure. `DefaultAzureCredential` would eventually pick up the credential I'm logged in VS Code or Azure CLI, thoughout which I'm completely unaware.

In the May release, we are adding an exception type `CredentialUnavailableException`. `DefaultAzureCredential` will only attempt to authenticate with the next credential if a `CredentialUnavailableException` is thrown from the current credential. In the above example, if the environment variables are present but authentication failed, the `EnvironmentCredential` will not throw `CredentialUnavailableException`, causing `DefaultAzureCredential` to propagate the exception and stop trying other credentials.

### Monitor behaviors through improved logs

On top of all the control we are giving you, we are also adding more logs to help you monitor the authentications happening on your local workstation and in your deployment. From the log of a `DefaultAzureCredential`, you can quickly tell which underlyng credential is used to acquire a token. With the same authenticate code:

```csharp
// .NET
var client = new SecretClient(new Uri(keyVaultUrl), new DefaultAzureCredential(true));
```

```java
// Java
DefaultAzureCredential credential = new DefaultAzureCredential().build();

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
// Python
client = SecretClient(keyVaultUrl, DefaultAzureCredential())
```

On the local environment with `EnvironmentCredential` set up, Azure Identity will print the following logs:

```
Azure Identity => DefaultAzureCredential invoking NewChainedTokenCredential
Azure Identity => EnvironmentCredential invoking ClientSecretCredential
Azure Identity => GetToken() result for ClientSecretCredential: SUCCESS
Azure Identity => Scopes: [https://vault.azure.net]
```

When deployed to a virtual machine in Azure with Managed Identities, Azure Identity will print the following logs:

```
Azure Identity => DefaultAzureCredential invoking NewChainedTokenCredential
Azure Identity => ERROR in EnvironmentCredential: Missing environment variable AZURE_TENANT_ID
Azure Identity => GetToken() result for ManagedIdentityCredential: SUCCESS
Azure Identity => Scopes: [https://vault.azure.net]
Azure Identity => Managed Identity environment: IMDS
```

With this log you will be able to trace to each credential attempted by `DefaultAzureCredential` and diagnose where the issue comes from.

## Community acknowledgements
I'd like to give special thanks to Alejandro Baeza(alexbaeza) and Kiran Hegde(HankiGreed) for helping us improve the Azure Identity libraries on GitHub. Your contributions have helped many people and organizations succeed!

## What's coming next & how to help us
In the next few months we are rolling out more exciting features, including secure token cache on MacOS and Linux, more integrations with tools like CLI and PowerShell, and more credentials to improve developer experience. You can follow along in our GitHub issues under the label `Azure.Identity` in our repositories - https://github.com/Azure/azure-sdk-for-[net/java/python/js].

We also welcome issues and pull requests on bug reports / feature requests. It's been a great time building this library with you all!