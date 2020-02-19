---
title: Authentication and the Azure SDK
layout: post
date: 25 Feb 2020
sidebar: releases_sidebar
repository: azure/azure-sdk
---

How do your apps identify themselves to the cloud resources you are using?  

This is one of the most central considerations when building a cloud-native app.  Ideally, your app should run in all phases.  When you write a service, you should be able to take the same code and run it in your development environment, on a compute service in your own data center, or in any of the Azure clouds without code changes.  How do you do this?

The answer is to use the `DefaultAzureCredential` from the Azure Identity library.  This is a type that is available in [.NET](https://azuresdkdocs.blob.core.windows.net/$web/dotnet/Azure.Identity/1.1.1/api/index.html), [Java](https://azuresdkdocs.blob.core.windows.net/$web/java/azure-identity/1.1.0-beta.1/index.html), [TypeScript](https://azuresdkdocs.blob.core.windows.net/$web/javascript/azure-identity/1.0.2/index.html), and [Python](https://azuresdkdocs.blob.core.windows.net/$web/python/azure-identity/1.3.0/index.html) across all of our latest client libraries (App Config, Event Hubs, Key Vault, and Storage) and will be built into future client libraries as well.

The basics are very simple.  To create a client, use the `DefaultAzureCredential` as the credential type.  For example, to create a Key Vault Secrets client:

```text
// .NET
var client = new SecretClient(vaultUri: new Uri(keyVaultUrl), credential: new DefaultAzureCredential());

// Java
SecretClient client = new SecretClientBuilder()
        .vaultUrl(keyVaultUrl)
        .credential(new DefaultAzureCredentialBuilder().build())
        .buildClient();

// JavaScript
const client = new SecretClient(keyVaultUrl, new DefaultAzureCredential());

// Python
client = SecretClient(vault_url=keyVaultUrl, credential=DefaultAzureCredential())
```

The `DefaultAzureCredential` attempts to figure out what sort of environment you are running in, and uses the most appropriate credential for the purpose.  Internally, it is a credential chain, attempting multiple credential types in order.  Once a working credential has been found, it is used.

## The environment

The first choice is the environment.  If you have the following environment variables set, they will be used along with Azure AD to authenticate the connection.

* `AZURE_CLIENT_ID`
* `AZURE_CLIENT_SECRET`
* `AZURE_TENANT_ID`

If you need to explicitly control the authentication, set these environment variables.  These environment variables define the [service principal](https://docs.microsoft.com/en-us/azure/active-directory/develop/app-objects-and-service-principals) that will be used for authentication and authorization.  You can configure a service principal for your application using the Azure CLI as follows:

```bash
$> az ad sp create-for-rbac --name http://my-application --skip-assignment
{
    "appId": "generated app id",
    "displayName": "my-application",
    "name": "http://my-application",
    "password": "random password",
    "tenant": "tenant id"
}
```

Place the `appId`, `password`, and `tenant` into the appropriate environment variables.  In PowerShell, for example:

```bash
$> $env:AZURE_CLIENT_ID="generated app id"
$> $env:AZURE_CLIENT_SECRET="random password"
$> $env:AZURE_TENANT_ID="tenant id"
```

You will also need to give the service principal permissions to access the resource.  For example, for the Key Vault example above, you can use the following:

```bash
$> az keyvault set-policy --name my-key-vault --spn $AZURE_CLIENT_ID --secret-permissions get list
```

Now that your environment is set up, the `client` in your application will be able to communicate with the Key Vault.

## Managed identities

While the environment is a good option in every single situation, it does put a management burden on you.  You have to maintain the service credentials.  When running your service in the confines of a cloud compute instance (such as a virtual machine, container, App Service, Functions, or Service Bus), you can use [managed identities](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview).  When you establish a system-managed identity for the service, a service principal is created for you that is associated with the service.  You can also establish a user-managed identity (which is just a service principal that you associate with the service).  Your application can get authenticated easily by reaching out to an endpoint on the compute resource.  the `DefaultAzureCredential` manages this transaction for you.

For instance, let's say you are running your application in Azure App Service.  To create a suitable managed identity with permissions to access your Key Vault:

1. Go to your App Service resource within the portal.
2. Go to **Settings** > **Managed identity**.
3. Within the **System assigned** tab, switch the status to **On**, then click **Save**.
4. Make a note of the Object ID for the created service principal.

You can set the Key Vault policy as follows:

```bash
$> az keyvault set-policy --name my-key-vault --object-id <Object-ID> --secret-permissions get list
```

You can do this in one step if you are building your infrastructure using deployment tools such as Azure Resource Manager (ARM), Terraform, or Ansible.  

## Development services

The third type of credential is for developers.  If you have an appropriately configured developer workstation with [Visual Studio](https://visualstudio.com) signed in to Azure, then the Azure credentials from your tools will be used.  Other tools (such as Azure CLI, PowerShell, and Visual Studio Code) will be added in the near future. This allows you to run your service easily from the command line or via F5 within Visual Studio.

> **TODO:** What does VS Code & PowerShell do?  If I have the Azure Accounts plugin for VSCode, does it just work?

This gives you a great ability to build and run your application without any code changes.  You don't need anything else.  However, if your account does not have access to the resources necessary for the app to run, you can override the information by creating a service principal in the tenant that owns the resources, then use the environment variables that I mentioned above.

## The final stop: Interactive browser

If all of these fails, the `DefaultAzureCredential` will attempt to pop up a browser window and ask for the right credentials.  If you are not using any of the supported tools, then this will allow you to run your application on your development system by requesting a token on startup.

## Take your app from development to production with no code changes

Let's take an example.  I'm writing a backend service right now that consists of a Node API service that communicates with CosmosDB and Azure Storage.  I store the base URI for Azure Storage and the connection string for CosmosDB in Azure Key Vault secrets, and specify the Key Vault resource as an environment variables.  This allows me to run the service locally, as an App Service, or in a container.

```js
import { SecretClient } from '@azure/keyvault-secrets';
import { DefaultAzureCredential } from '@azure/identity';
import { CosmosClient } from '@azure/cosmos';

const keyVaultUrl = process.env('APP_KEY_VAULT_URI');
const credential = new DefaultAzureCredential();
let storageClient;
let cosmosClient;

async function configureClients() {
    const kvClient = new SecretClient(keyVaultUrl, credential);
    const storageUri = await client.getSecret('storageUri');
    const cosmosDbConnectionString = await client.getSecret('cosmosDb');

    cosmosClient = new CosmosClient(cosmosDbConnectonString);
    storageClient = new BlobServiceClient(storageUri, credential);
}
```

When I run my app from my development environment, it uses the credentials for my tooling.  If I don't have any appropriate tooling, the app will pop up a browser to get the credentials.  I can bypass this process by creating a service principal and ensuring the permissions are set properly.

When my development is complete, I may pass this onto an infrastructure group that deploys the service to one of the compute environments.  They are using the best practices for the cloud, explicitly using managed identities and setting permissions during the deployment phase.  My code doesn't need any changes.

Most importantly, at no time does any security information get checked into source code.  Using the `DefaultAzureCredential` helps you to avoid credential leakage, which is a major security concern.

If you are building modern cloud-native apps on Azure, the `DefaultAzureCredential` is the best and easiest way to handle identity, authentication, and authorization.

## Want to hear more?

Follow us on [Twitter](https://twitter.com/AzureSDK).  We'll be covering more best practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure client libraries.  I hope you'll join us.


