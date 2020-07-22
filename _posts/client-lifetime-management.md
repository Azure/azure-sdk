# Lifetime management and thread-safety guarantees of Azure SDK clients

When using Azure SDK client libraries in high throughput applications, it's important to know how to maximize performance while keeping the code correct and bug-free. 

The main rule of Azure SDK client lifetime management is: **treat clients as singletons.**

There is no need to keep more that than one instance of a client for a given set of constructor parameters or client options. This can be implemented in many ways: creating an instance once and passing it around as a parameter, storing instance in a field, or registering it as a singleton in a dependency injection container of your choice.

❌ Bad (extra allocations and initialization):
``` C#
foreach (var secretName in secretNames)
{
    var client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());
    KeyVaultSecret secret = client.GetSecret(secretName);
    Console.WriteLine(secret.Value);
}
```

✔️ Good:


``` C#
var client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());
foreach (var secretName in secretNames)
{
    KeyVaultSecret secret = client.GetSecret(secretName);
    Console.WriteLine(secret.Value);
}
```

✔️ Also good:

``` C#
public class Program
{
    internal static SecretClient Client;

    public static void Main()
    {
        Client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());
    }
}

public class OtherClass
{
    public string DoWork()
    {
        KeyVaultSecret secret = Program.Client.GetSecret(settingName);
        Console.WriteLine(secret.Value);
    }
}
```

# Thread-safe

We guarantee that all client instance methods are thread-safe and independent of each other ([guideline](https://azure.github.io/azure-sdk/dotnet_introduction.html#dotnet-service-methods-thread-safety)).  This ensures the recommendation of reusing client instances is always safe, even across threads.

``` C#
var client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());

foreach (var secretName in secretNames)
{
    // Using clients from parallel threads
    Task.Run(() => Console.WriteLine(client.GetSecret(secretName).Value));
}

```

**NOTE:** the input and output models of the client methods are non-thread-safe and can only be accessed by one thread a time.

The following sample illustrates a bug where accessing a model from multiple threads might cause an undefined behavior.

❌ Bad:
``` C#
KeyVaultSecret newSecret = client.SetSecret("secret", "value");

foreach (var tag in tags)
{
    // Don't use model type from parallel threads
    Task.Run(() => newSecret.Properties.Tags[tag] = CalculateTagValue(tag));
}

client.UpdateSecretProperties(newSecret.Properties);
```

If you really need to acces the model from different threads use a syncronization primitive.

✔️ Good:

``` C#
KeyVaultSecret newSecret = client.SetSecret("secret", "value");

foreach (var tag in tags)
{
    Task.Run(() =>
    {
        lock (newSecret)
        {
            newSecret.Properties.Tags[tag] = CalculateTagValue(tag);
        }
    );
}

client.UpdateSecretProperties(newSecret.Properties);
```


# Immutable after creation

Clients are immutable after being created which also makes them safe to share and reuse safely ([guideline](https://azure.github.io/azure-sdk/general_implementation.html#general-config-behaviour-changes)).  This means that after the client is constructed, you cannot change the endpoint it connects to, the credential, and other values passed via the client options.

``` C#
var secretClientOptions = new SecretClientOptions()
{
    Retry = 
    {
        Delay = TimeSpan.FromSeconds(5)
    }
};

var mySecretClient = new SecretClient(new Uri("<...>"), new DefaultAzureCredential(), secretClientOptions);

// This has no effect on the mySecretClient instance
secretClientOptions.Retry.Delay = TimeSpan.FromSeconds(100);
```

**NOTE:** important exception from this rule are credential type implementations that are required to support rolling the key after the client was created ([guideline](azure.github.io/azure-sdk/dotnet_introduction.html#dotnet-auth-rolling-credentials)). Examples of such types include [AzureKeyCredential](https://docs.microsoft.com/en-us/dotnet/api/azure.azurekeycredential.update?view=azure-dotnet#Azure_AzureKeyCredential_Update_System_String_), [StorageSharedKeyCredential](https://docs.microsoft.com/en-us/dotnet/api/azure.storage.storagesharedkeycredential.setaccountkey?view=azure-dotnet#Azure_Storage_StorageSharedKeyCredential_SetAccountKey_System_String_).

# Why clients are not disposable

One question that comes up often is why aren't HTTP-based Azure clients implementing `IDisposable` while internally using an `HttpClient` that is disposable?  All Azure SDK clients, by default, use a single shared `HttpClient` instance and don't create any other resources that need to be actively freed.

``` C#
// Both clients reuse the shared HttpClient and don't need to be disposed
var blobClient = new BlobClient(new Uri(sasUri));
var blobClient2 = new BlobClient(new Uri(sasUri2));
```

If you provide a custom instance of `HttpClient` to an Azure client, you become responsible for managing the `HttpClient` lifetime and disposing it at the right time.  We recommend [following `HttpClient` best practices](https://docs.microsoft.com/en-us/dotnet/api/system.net.http.httpclient?view=netcore-3.1#remarks) when customizing the transport.

``` C#
var httpClient = new HttpClient();

var clientOptions = new BlobClientOptions()
{
    Transport = new HttpClientTransport(httpClient)
}

// Both client would use the HttpClient instance provided in clientOptions
var blobClient = new BlobClient(new Uri(sasUri), clientOptions);
var blobClient2 = new BlobClient(new Uri(sasUri2), clientOptions);

//...

// some time later
httpClient.Dispose();
```

# Using ASP.NET Core

If you are using Azure SDK clients in an ASP.NET Core application, client lifetime management can be simplified with the Microsoft.Extensions.Azure package that provides seamless integration of Azure clients with the ASP.NET Core dependency injection and configuration systems.  See the [Best practices for using Azure SDK with ASP.NET Core](https://devblogs.microsoft.com/azure-sdk/best-practices-for-using-azure-sdk-with-asp-net-core/) blog post for details.
