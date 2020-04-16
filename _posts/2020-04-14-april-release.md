---
title: Azure SDK Releases (April 2020)
layout: post
date: 2020-04-14
sidebar: releases_sidebar
repository: azure/azure-sdk
---

Welcome to the April release of the Azure SDK.  We have updated the following libraries:

* App Configuration
* Event Hubs
* Key Vault
* Storage

These are ready to use in your production applications.  You can find details of all released libraries on [our releases page]({site.baseurl}}{% link releases/latest/index.md %}).

New preview releases:

* Cognitive Search
* Event Hubs
* Service Bus (New!)
* Text Analytics

In addition, there is a new preview release for Azure Identity, which features improvements to the `DefaultAzureCredential` to better support common developer workflows.

We believe these are ready for you to use and experiment with, but not yet ready for production.  Between now and the GA release, these libraries may undergo API changes.  We'd love your feedback!  If you use these libraries and like what you see, or you want to see changes, let us know in GitHub issues.

## Getting Started

Use the links below to get started with your language of choice.  You will notice that all the preview libraries are tagged with "preview".

* [.NET release notes]({{site.baseurl}}{% link releases/2020-04/dotnet.md %})
* [Java release notes]({{site.baseurl}}{% link releases/2020-04/java.md %})
* [Python release notes]({{site.baseurl}}{% link releases/2020-04/python.md %})
* [JavaScript release notes]({{site.baseurl}}{% link releases/2020-04/js.md %})

If you want to dive deep into the content, the release notes linked above and the change logs they point to give more details on what has changed.

## In depth: Where should you store secrets?

It's common to hear the advice "Don't store secrets in source code."  This is excellent advice.  Our source code is increasingly stored in source code control systems that are hosted in the cloud (like GitHub or Azure DevOps), but where is a good place to store these secrets and what form should they take?  We've got some best practices and some code snippets for you this week to get you started right.

### Pick the right authentication scheme

You should always secure each resource individually.  Most Azure compute services (for example, Virtual machines, Kubernetes Service, App Service, and Service Bus) support a [managed identity](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/overview).  This provides you with a service principal within Azure Active Directory that you can use to call other services.  The `DefaultAzureCredential` uses managed identities out of the box, so this is an excellent way to get started.  You have to specify which permissions the managed identity has within Azure Active Directory.  This is normally as simple as giving the managed identity the right roles so that they can access the resources needed.

Some services only support username/password type authentication; yet others only support API keys.  These are great for getting started, but suffer because you have to remember to rotate those keys on a regular basis.  Centralizing authentication in a place designed for it allows for policy enforcement, and ensures you know which passwords need rotating.

### Avoid connection strings

When you are developing service applications, you want them to be long-running.  If you have good password hygiene, then you are rotating the passwords to all your cloud resources on a regular basis.  At some point, the password you are using in your application is going to change.  If you use connection strings, the application will need to be restarted.  Additionally, you have to store your connection string in plain text within the environment of your application.  You should never store security credentials in plain text.  For these reasons, avoid using connection strings wherever possible.

Instead, secure your resources with Azure Active Directory, then use an appropriate credential with the Azure SDK.  The `DefaultAzureCredential` includes the `ManagedIdentityCredential`, which supports rotating keys on managed identities.  This allows you to rotate keys on a regular basis without restarting your service. For more information on the `DefaultAzureCredential`, see [our blog post]({{ site.baseurl }}{% post_url 2020-02-25-defaultazurecredentials %}).

There are places where you have to store a connection string - most notably, Azure SQL does not support Azure Active Directory at the time of writing, so you have to use connection strings.

### Store secrets in Key Vault

Key Vault has three functions - secrets, keys, and certificate storage.  If all the services you use support Azure Active Directory, your service is unlikely to require access to Key Vault for secret storage.  Managed identities and Azure Active Directory are enough to handle the requirements.  However, as we have noted, there are API keys and connection strings that may occasionally be needed.  In these cases, you should store secrets in Key Vault.

First, set up an environment variable that contains your Key Vault URI.  I generally set mine in `AZURE_KEYVAULT_URI`.  Having a standard helps.  Getting the keys out of Key Vault is simple, no matter which language you code in.  In .NET:

```csharp
var keyVaultUrl = Environment.GetEnvironmentVariable("AZURE_KEYVAULT_URI");
var client = new SecretClient(vaultUri: new Uri(keyVaultUrl), credential: new DefaultAzureCredential());

// Now get the secret you stored in Key Vault
var secretValue = client.GetSecret("AZURE_SQL_CONNECTION_STRING");
```

In Java:

```java
String keyVaultUrl = System.getenv("AZURE_KEYVAULT_URI");
SecretClient client = new SecretClientBuilder()
        .vaultUrl(<your-vault-url>)
        .credential(new DefaultAzureCredentialBuilder().build())
        .buildClient();
KeyVaultSecret secret = secretClient.getSecret("AZURE_SQL_CONNECTION_STRING");
String secretValue = secret.getValue();
```

In Python:

```python
key_vault_url = os.environ["AZURE_KEYVAULT_URI"]
credential = DefaultAzureCredential()
secret_client = SecretClient(key_vault_url, credential)
secret = secret_client.get_secret("AZURE_SQL_CONNECTION_STRING").value
```

And in JavaScript:

```javascript
const keyVaultUrl = process.env["AZURE_KEYVAULT_URI"];
const secretClient = new SecretClient(keyVaultUrl, new DefaultAzureCredential());
secret = await secretClient.getSecret("AZURE_SQL_CONNECTION_STRING");
```

As you can see, none of the code is particularly verbose and all follow a consistent pattern.

### Use service principals in development

When you are in development, you don't have access to managed identities.  It's a good idea to create a "development" service principal with the correct permissions.  You can do this easily using the following Azure CLI command:

```bash
az ad sp create-for-rbac -n "DEV-some-random-name" --skip-assignment
```

A block similar to the following will be output:

```json
{
  "appId": "__CLIENT_ID__",
  "displayName": "DEV-some-random-name",
  "name": "http://DEV-some-random-name",
  "password": "__CLIENT_SECRET__",
  "tenant": "__TENANT_ID__"
}
```

From these values, you need the client ID, client secret, and tenant ID.  Set the following environment variables on your development system:

```bash
export AZURE_CLIENT_ID="__CLIENT_ID__"
export AZURE_CLIENT_SECRET="__CLIENT_SECRET__"
export AZURE_TENANT_ID="__TENANT_ID__"
```

Give your new service principal some permissions.  For example, the following allows the service principal to read Key Vault (but not write to it):

```bash
az keyvault set-policy --name <your-key-vault-name> --spn $AZURE_CLIENT_ID --secret-permissions get list
```

This should mimic the permissions you expect your application to have later on.

### Practice good security hygiene

Finally, you need to ensure you use good security practices from the very beginning of your development.

* Use `.gitignore` files to prevent storing secrets.
* Use a security scanner on your repositories.
* Give a different service principal to each developer.
* Grant the least permissions possible to achieve the task.
* If you do accidentally check in a secret, immediately clean up the repository and rotate your keys.

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback ranging from documentation issues to API surface area change requests to pointing out failure cases.  Please keep that coming.  We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk/)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@AzureSDK](https://twitter.com/AzureSDK) on Twitter.
