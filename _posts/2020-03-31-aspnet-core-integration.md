---
title: Best practices for using Azure SDK with ASP.NET Core
layout: post
date: 2020-03-31
sidebar: releases_sidebar
author_github: pakrym
repository: azure/azure-sdk
---

If you are developing an ASP.NET Core application, you know that there is a common way of structuring your application.  There is a central bootstrap class (`Startup`) and a number of classes that fulfill roles in the application, like controllers, view models, and so on.  The tooling within Visual Studio makes this very easy to accomplish.

As with the integration of any SDK, when you want to integrate with the Azure SDK, there are good ways and bad ways to structure your code.  In this article, I will cover the best practices that you should follow to maximize the scalability, performance, and security of your applications when using the Azure SDK in an ASP.NET Core application.

The advice comes down to three best practices:

1. Centrally configure services during app startup.
2. Store your configuration separately from code.
3. Use the [`DefaultAzureCredential`]({{ site.baseurl }}{% post_url 2020-02-25-defaultazurecredentials %}).

Let's take each of these in turn.

## Centrally configure services during app startup

Every ASP.NET Core application starts by booting up the application using the instructions provided in the `Startup` class.  This includes a `ConfigureServices()` method that is an ideal place to configure the Azure service clients.  You can then consume these Azure service clients wherever you need to by using _Dependency Injection_.

To configure the services, first add the following NuGet packages to your project:

* [Microsoft.Extensions.Azure](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Microsoft.Extensions.Azure/README.md)
* [Azure.Identity](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/README.md)
* The `Azure.*` package for the Azure service client you wish to add.

For example, let's say I want to use Key Vault secrets and Blob Storage, I could do the following:

```bash
$> dotnet add package Microsoft.Extensions.Azure
$> dotnet add package Azure.Identity
$> dotnet add package Azure.Security.KeyVault.Secrets
$> dotnet add package Azure.Storage.Blobs
```

Now I can update the `ConfigureServices()` method to register a service client for each service.

```csharp
public void ConfigureServices(IServiceCollection services)
{
  services.AddAzureClients(builder =>
  {
    // Add a KeyVault client
    builder.AddSecretClient(keyVaultUrl);

    // Add a storage account client
    builder.AddBlobServiceClient(storageUrl);

    // Use the environment credential by default
    builder.UseCredential(new EnvironmentCredential());
  });

  services.AddControllers();
}
```

In this example, you would need to explicitly specify the `keyVaultUrl` and `storageUrl`  Both variables are `Uri` types.  In addition, you would need to set up a service principal, then configure environment variables to let the application know what service principal to use.  This is done by specifying the `AZURE_TENANT_ID`, `AZURE_CLIENT_ID`, and `AZURE_CLIENT_SECRET` environment variables.

With the services configured in `Startup`, I can now use dependency injection to use the clients.  For example, I've got a Web API controller class that uses the blob storage client:

```csharp
[ApiController]
[Route("[controller]")]
public class MyApiController : ControllerBase
{
  private readonly BlobServiceClient blobServiceClient;

  public MyApiController(BlobServiceClient blobServiceClient)
  {
    this.blobServiceClient = blobServiceClient;
  }

  /// Get a list of all the blobs in the demo container
  [HttpGet]
  public async Task<IEnumerable<string>> Get()
  {
    var containerClient = this.blobServiceClient.GetBlobContainerClient("demo");
    var results = new List<string>();
    await foreach (BlobItem blob in containerClient.GetBlobsAsync()) 
    {
      results.Add(blob.Name);
    }
    return results.ToArray();
  }
}
```

## Store your configuration separately from code

My first attempt at `ConfigureServices()` has embedded `Uri` objects.  This is a problem because I may want to run against different environments in development vs. production.  The ASP.NET Core team suggests [storing such configurations in environment dependent JSON files](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-3.1#default-configuration).  Thus, I might have an `appSettings.Development.json` file with one set of settings, and an `appSettings.Production.json` with another set of configurations.  The format of the file is:

```json
{
  "AzureDefaults": {
    "Diagnostics": {
      "IsTelemetryDisabled": false,
      "IsLoggingContentEnabled": true
    },
    "Retry": {
      "MaxRetries": 3,
      "Mode": "Exponential"
    }
  },
  "KeyVault": {
    "VaultUri": "https://mykeyvault.vault.azure.net"
  },
  "Storage": {
    "ServiceUri": "https://mydemoaccount.storage.windows.net"
  }
}
```

You can add any options from the [ClientOptions](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/core/Azure.Core/src/RetryOptions.cs) into the `AzureDefaults` section.

The `Configuration` object is injected from the host, and stored inside the `Startup` constructor.  I can now modify the `ConfigureServices()` method to use this configuration:

```csharp
public void ConfigureServices(IServiceCollection services)
{
  services.AddAzureClients(builder =>
  {
    // Add a KeyVault client
    builder.AddSecretClient(Configuration.GetSection("KeyVault"));

    // Add a storage account client
    builder.AddBlobServiceClient(Configuration.GetSection("Storage"));

    // Use the environment credential by default
    builder.UseCredential(new EnvironmentCredential());

    // Set up any default settings
    builder.ConfigureDefaults(Configuration.GetSection("AzureDefaults"));
  });

  services.AddControllers();
}
```

This is a step towards the correct usage.  However, I still have to specify the credential explicitly.

## Use DefaultAzureCredential

Fixing the credentials is probably the easiest part of this process.  Use the `DefaultAzureCredential` object for the credential handling.   The `DefaultAzureCredential` chooses the best authentication mechanism based on your environment, allowing you to move your app seamlessly from development to production with no code changes.

To enable it, just swap out the `EnvironmentCredential` with `DefaultAzureCredential`.  

Here is the final `ConfigureServices()` method:

```csharp
public void ConfigureServices(IServiceCollection services)
{
  services.AddAzureClients(builder =>
  {
    // Add a KeyVault client
    builder.AddSecretClient(Configuration.GetSection("KeyVault"));

    // Add a storage account client
    builder.AddBlobServiceClient(Configuration.GetSection("Storage"));

    // Use the environment credential by default
    builder.UseCredential(new DefaultAzureCredential());
    
    // Set up any default settings
    builder.ConfigureDefaults(Configuration.GetSection("AzureDefaults"));
  });

  services.AddControllers();
}
```

The `DefaultAzureCredential` checks several methods of authenticating your service.  First, it checks to see if you have the environment variables set.  If you have explicitly provided credentials in this manner, they are used.   Next, it checks to see if you have set up a managed identity.  The mechanism for doing this varies by hosting platform.  For virtual machines and Azure App Services, for example, there is a managed identity section in the portal.  You can also configure the managed identity using your favorite command line tool (Azure CLI, PowerShell, Azure Resource Manager, Terraform, etc.).  You must ensure you have provided the managed service principal with permissions to access the resources you are trying to use.  For more information on using managed identities, check [the documentation](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview).

## More settings

With this basic setup, you can do much more:

* Provide multiple service clients with different names.
* Configure global settings, like the retry settings.
* [Send your logs to Azure Monitor](https://docs.microsoft.com/azure/azure-monitor/learn/dotnetcore-quick-start).
* [Store your configuration within App Configuration](https://docs.microsoft.com/azure/azure-app-configuration/quickstart-aspnet-core-app?tabs=core2x).

Let's take a look at a couple of these.

### Configure multiple service clients with different names

Let's say you have two storage accounts - one for private information and one for public information.  Your application transfers data from the public to private storage account after some operation.  You need to have two storage service clients.  To set this up, in `ConfigureServices()`:

```csharp
public void ConfigureServices(IServiceCollection services)
{
  services.AddAzureClients(builder =>
  {
    builder.AddBlobServiceClient(Configuration.GetSection("PublicStorage"));
    builder.AddBlobServiceClient(Configuration.GetSection("PrivateStorage"))
      .WithName("PrivateStorage");
  });
}
```

In your controllers, you can access the named service clients using the `IAzureClientFactory`:

```csharp
public class HomeControllers : Controller
{
  private BlobServiceClient publicStorage, privateStorage;

  public HomeController(BlobServiceClient defaultClient, IAzureClientFactory<BlobServiceClient> clientFactory)
  {
    this.publicStorage = defaultClient;
    this.privateStorage = clientFactory.GetClient("PrivateStorage");
  }
}
```

The un-named service client is still available in the same way as before.  Named clients are additive to this.

### Configure a new retry policy

At some point, you will want to change the default settings for a service client.  You may want different retry settings, or to use a different service API version, for example.  You can set the retry settings globally or on a per service basis.  Let's say you have added the following to your `appSettings.json` file:

```json
{
  "AzureDefaults": {
    "Retry": {
      "maxTries": 3
    }
  },
  "KeyVault": {
    "VaultUri": "https://mykeyvault.vault.azure.net"
  },
  "Storage": {
    "ServiceUri": "https://store1.storage.windows.net"
  },
  "CustomStorage": {
    "ServiceUri": "https://store2.storage.windows.net"
  }
}
```

You could then write something like the following:


```csharp
public void ConfigureServices(IServiceCollection services)
{
  services.AddAzureClients(builder =>
  {
    // Establish the global defaults
    builder.ConfigureDefaults(Configuration.GetSection("AzureDefaults"));
    builder.UseCredential(new DefaultAzureCredential());

    // A Key Vault Secrets client using the global defaults
    builder.AddSecretClient(Configuration.GetSection("KeyVault"));

    // A Storage client with a custom retry policy
    builder.AddBlobServiceClient(Configuration.GetSection("Storage"))
      .ConfigureOptions(options => options.Retry.MaxRetries = 10);

    // A named storage client with a different custom retry policy
    builder.AddBlobServiceClient(Configuration.GetSection("CustomStorage"))
      .WithName("CustomStorage")
      .ConfigureOptions(options => {
        options.Retry.Mode = Azure.Core.RetryMode.Exponential;
        options.Retry.MaxRetries = 5;
        options.Retry.MaxDelay = TimeSpan.FromSections(120);
      });
  });
}
``` 

You can also place policy overrides in the `appSettings.json` file:

```json
{
  "KeyVault": {
    "VaultUri": "https://mykeyvault.vault.azure.net",
    "Retry": {
      "maxRetries": 10
    }
  }
}
```

## Want to hear more?

Follow us on [Twitter at @AzureSDK](https://twitter.com/AzureSDK).  We'll be covering more best practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDKs. 

Contributors to this article: _Pavel Krymets_.
