# Lifetime management and tread-safety guarantees of Azure SDK clients

When using Azure SDK client in high throughput applications it's important to know how to maximize the performance while keeping the code correct and bug-free. 

The main rule of Azure SDK client lifetime management is - treat clients as singletons.

There is no need to keep more that than one instance of a client for a given set of constructor parameters. This can be implemented in many ways: creating an instance once and passing it around as a parameter, storing instance in a field, or registering it as a singleton in a dependency injection container of your choice.

Bad:
``` C#
foreach (var secretName in secretNames)
{
    var client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());
    KeyVaultSecret secret = client.GetSecret(secretName);
    Console.WriteLine(secret.Value);
}
```

Good:


``` C#
var client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());
foreach (var secretName in secretNames)
{
    KeyVaultSecret secret = client.GetSecret(secretName);
    Console.WriteLine(secret.Value);
}
```

Also good:

``` C#
public class SecretConfigurationSource
{
    private readonly SecretClient _client;

    public SecretConfigurationSource()
    {
        _client = new SecretClient(new Uri("<secrets_endpoint>"), new DefaultAzureCredential());
    }

    public string GetConfigurationValue(string settingName)
    {
        KeyVaultSecret secret = _client.GetSecret(settingName);
        return secret.Value;
    }
}
```

# Thread-safe

Because the recommended way of using clients is by reusing the same instance we make a guarantee that all client instance methods are thread-safe and independent of each other.

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

``` C#
KeyVaultSecret newSecret = client.SetSecret("secret", "value");

foreach (var tag in tags)
{
    // Don't use model type from parallel threads
    Task.Run(() => newSecret.Properties.Tags[tag] = CalculateTagValue(tag));
}

client.UpdateSecretProperties(newSecret.Properties);
```

# Immutable after creation

The other important quality that allows reusing client instances safely is the immutability after creation. This means that after the client is constructed the endpoint it connects to, the credential or other values passed via the client options can not be changed.

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

**NOTE:** important exception from this rule are some `TokenCredential` implementations that allow rolling the key after the client was created (https://docs.microsoft.com/en-us/dotnet/api/azure.azurekeycredential.update?view=azure-dotnet#Azure_AzureKeyCredential_Update_System_String_)

# Why client are not disposable

One frequent question that comes up is why aren't HTTP-based Azure clients implementing `IDisposable` while internally using the HttpClient that is disposable. An answer to this question is that all Azure SDK clients, by default, use a single shared HttpClient instance and don't create any other resources that need to be actively freed.

``` C#
// Both clients reuse the shared HttpClient and don't need to be disposed
var blobClient = new BlobClient(new Uri(sasUri));
var blobClient2 = new BlobClient(new Uri(sasUri2));
```

If you provide a custom instance of HttpClient to Azure clients you become responsible for managing the `HttpClient` and dispose it at the right time.

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

If you are using Azure SDK clients in ASP.NET Core, client lifetime management can be simplified by using the Microsoft.Extensions.Azure package that provides a way to seamlessly integration Azure clients with ASP.NET Core dependency injection and configuration systems. See the [Best practices for using Azure SDK with ASP.NET Core](https://devblogs.microsoft.com/azure-sdk/best-practices-for-using-azure-sdk-with-asp-net-core/) blog post for details.
