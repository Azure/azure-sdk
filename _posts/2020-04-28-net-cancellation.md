---
title: How to use CancellationTokens to cancel operations in the Azure SDK for .NET
layout: post
date: 2020-04-28
sidebar: releases_sidebar
author_github: heaths
repository: azure/azure-sdk
---

The ability to cancel long-running operations is important to help keep applications responsive. Whether the network connection is slow or disconnects, or the user just wants to cancel a long operation, using a [`CancellationToken`][CancellationToken] in .NET makes it easy to cancel those long operations. Together with a [`CancellationTokenSource`][CancellationTokenSource], a developer can provide on-demand or timed cancellations of operations that accept a `CancellationToken`, like our [client methods][network-requests] in the Azure SDK for .NET.

## Using CancellationTokens

Prior to the introduction of the [`CancellationToken`][CancellationToken] structure in .NET Framework 4.0, it was common to use one or more `WaitHandle` objects to synchronize threads. This same pattern has been used in native Windows applications for decades. When the asynchronous task pattern was introduced in .NET, a new, simpler pattern for cancelling tasks was also introduced. While a `CancellationToken` can still provide a `WaitHandle` to synchronize threads, creating tokens and passing them to methods is much easier:

```csharp
CancellationTokenSource cts = new CancellationTokenSource();
KeyVaultSecret secret = await secretClient.GetSecretAsync("my-secret", cts.Token);
```

`CancellationTokenSource.Token` returns a `CancellationToken` that can be passed to other methods further down the call stack, or even on other threads. When those tokens are canceled, any methods waiting on them should throw an `OperationCanceledException`. Methods accepting a `CancellationToken` don't even have to be asynchronous. Our synchronous client methods in the Azure SDK for .NET also accept a `CancellationToken`. In both synchronous or asynchronous code, you can simply call `CancellationToken.ThrowIfCancellationRequested()` to immediately throw if the token was in a canceled state.

```csharp
public void DoWork(CancellationToken cancellationToken = default)
{
    cancellationToken.ThrowIfCancellationRequested();

    // Start long-running operation...
}
```

Notice that we didn't have to check if `cancellationToken` was null. As a value type in .NET, it cannot be null and even defined as its default value, `CancellationToken.ThrowIfCancellationRequested()` will simply do nothing.

If you don't want to throw an exception but still want to check if a token was cancelled, you can check the `CancellationToken.IsCancellationRequested` property.

## Cancelling CancellationTokens

You've seen a few ways to pass and use a [`CancellationToken`][CancellationToken], but how do you actually cancel them? That ability is supported by the [`CancellationTokenSource`][CancellationTokenSource]. A `CancellationTokenSource` can cancel tokens on demand or after a certain amount of time:

```csharp
CancellationTokenSource cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
Console.CancelKeyPress += (source, args) =>
{
    Console.Error.WriteLine("Cancelling download...");

    args.Cancel = true;
    cts.Cancel();
};

Console.WriteLine("Downloading to {0}...", path);

try
{
    using (Stream fs = File.Create(path))
    await blobClient.DownloadToAsync(fs, cts.Token);
}
catch (OperationCanceledException)
{
    Console.Error.WriteLine("Download canceled. Deleting {0}...", path);
    File.Delete(path);
}
```

We created a `CancellationTokenSource` that will cancel all its tokens after 30 seconds, and also hooked up a handler for pressing **Ctrl+C** in this sample console application. This way, we provide flexibility to the user to cancel the operation whenever they want, and also cancel the operation if it takes too long, which might indicate a network error if a suitable timeout is chosen. If the download is cancelled, we can handle the `OperationCanceledException` to delete the file in case it was partially downloaded.

## Advanced uses

Despite its simple design, a [`CancellationToken`][CancellationToken] can be used in a number of other scenarios.

### Linking CancellationTokens

!!!TODO!!!

### Doing additional work when canceled

!!!TODO!!!

### Waiting on handles

You can also use a `CancellationToken` with code that requires waiting on one or more [`WaitHandle`][WaitHandle] objects. This may be common for older applications or when interoperating with native code like with P/Invoke. The `CancellationToken.WaitHandle` can be used in calls like `WaitHandle.WaitAny`:

```csharp
AutoResetEvent evt = new AutoResetEvent(false);
ThreadPool.QueueUserWorkItem(state => DoWork(state, evt));

int which = WaitHandle.WaitAny(new WaitHandle[] { evt, cancellationToken.WaitHandle});
if (which == 1)
{
    Console.Error.WriteLine("The operation was canceled.");
}
```

Updating APIs for older applications to use newer classes like `CancellationToken` may help when upgrading to newer components.

## Further reading

* [`CancellationToken`][CancellationToken]
* [`CancellationTokenSource`][CancellationTokenSource]
* [Azure SDK guidelines for network requests][network-requests].

## Want to hear more?

Follow us on Twitter at [@AzureSDK](https://twitter.com/AzureSDK). We'll be covering more best practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDKs.

Contributors to this article: _[Heath Stewart](https://twitter.com/mrhestew)_.

[CancellationToken]: https://docs.microsoft.com/dotnet/api/system.threading.cancellationtoken
[CancellationTokenSource]: https://docs.microsoft.com/dotnet/api/system.threading.cancellationtokensource
[WaitHandle]: https://docs.microsoft.com/dotnet/api/system.threading.waithandle
[network-requests]: https://azure.github.io/azure-sdk/general_design.html#network-requests