---
title: How to use abort signals to cancel operations in the Azure SDK for JavaScript/TypeScript
layout: post
date: 21 apr 2020
sidebar: releases_sidebar
author_github: bterlson
repository: azure/azure-sdk
---

Cancelling in-progress network operations is critical for many applications to maintain responsiveness and avoid waiting for pointless work to complete. For example, when downloading a large blob from Azure Storage, a user might want to cancel the download, and it would be nice if we could tell the Storage library that it doesn't need to download any more. Or, maybe your process got an interrupt signal because the server is no longer needed or needs to upgrade and you need to stop any in-progress operations and shut down as soon as possible.

The new Azure SDK libraries for JavaScript and TypeScript have adopted abort signals for just these purposes.

## AbortController &amp; AbortSignal

`AbortController` and `AbortSignal` are [standard features in the browser](https://developer.mozilla.org/en-US/docs/Web/API/AbortController) and are used with the [`fetch` API](https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/fetch) to abort in-progress network requests. The controller is responsible for triggering the cancellation, and signals are responsible for notifying when a cancellation has been triggered.

If you're only targeting fairly modern browsers, you can use the built-in `AbortController` and `AbortSignal` and everything will work fine. If you're targeting Node.js, or if you want to take advantage of linked signals or other features that I'll cover later in this post, you can use the implementation in the Azure SDK found in the [`@azure/abort-controller` npm package](https://www.npmjs.com/package/@azure/abort-controller).

To abort an in-progress request such as an upload or download in storage, create a new `AbortController` and pass its signal into the method you might want to cancel later:

```javascript
// Omit this line if you want to use the AbortSignal built into the browser.
import { AbortController } from "@azure/abort-controller";

// create a controller and get its signal
const controller = new AbortController();
const abortSignal = controller.signal;

// pass the abortSignal into the API you want to cancel
await blobClient.download({ abortSignal })

// then sometime later, cancel it!
controller.abort();
```

Note that cancelling using `AbortController` only affects client-side code. It does not notify the service that cancellation has happened. For example, if you are uploading a key into Key Vault and you cancel before it finishes, the key might still be created.

## Cancelling multiple operations

Often you have multiple in-flight operations that you might want to cancel all at once. To continue our Storage example, maybe you're downloading multiple files in parallel. Or, perhaps you have to fetch a secret from Azure Key Vault before using that secret in a subsequent operation. In that case, you can pass the same signal to each method, and calling abort on the controller will cancel whichever of them is in progress at that time.

```javascript
async function getShoppingList({ abortSignal }) {
    const cs = await secretClient.getSecret('storage-connection-string', { abortSignal });
    const blobClient = new BlockBlobClient(cs.value, "MyDocuments", "shopping.rtf");
    return blobClient.downloadToBuffer(undefined,undefined, { abortSignal });
}

const controller = new AbortController();
const abortSignal = controller.signal;
const list = await getShoppingList({ abortSignal });

// then sometime later, cancel everything
controller.abort();
```

In this example, we cancel fetching the connection string from Key Vault or, if we've already fetched that, cancel the download.

## Handling AbortErrors

Cancelled operations throw an `AbortError` which prevents any subsequent code from running. This ensures that we don't, for example, try to create a `BlockBlobClient` with an empty key. In the examples so far, the `AbortError` is not handled - calling `abort()` on a controller will trigger an unhandled exception which will get logged to the browser console or, sadly, cause Node.js to exit. This is generally not good practice, and we can fix it by gracefully handling the AbortError. Here's how we can add that functionality using our last example:

```javascript
async function getShoppingList({ abortSignal }) {
    const cs = await secretClient.getSecret('storage-connection-string', { abortSignal });
    const blobClient = new BlockBlobClient(cs.value, "MyDocuments", "shopping.rtf");
    return blobClient.downloadToBuffer(undefined,undefined, { abortSignal });
}

const controller = new AbortController();
const abortSignal = controller.signal;

try {
    const list = await getShoppingList({ abortSignal });
} catch (e) {
    if (e.name === 'AbortError') {
        // abort was called on our abortSignal
        console.log('Operation was aborted by the user');
    } else {
        // some other error occurred 🤷‍♂️
        console.log('Downloading the shopping list failed');
    }
}

// then sometime later, cancel everything
controller.abort();
```

## Advanced uses

`@azure/abort-controller`'s implementation of `AbortController` has a couple more tricks up its sleeve to make some common patterns easier. Please note that these APIs are not available in the browser's `AbortController`.

### Cancelling with a timeout

Frequently you want to give an operation some amount of time to return a useful result, and if it hasn't, you'd like to cancel it. You could call `abortSignal.abort()` in a `setTimeout` callback, but this pattern is so common we provide a bit of sugar:

```javascript
const list = await getShoppingList({ abortSignal: AbortController.timeout(1000) });
```

This is roughly equivalent to the following code:

```javascript
const controller = new AbortController();
const abortSignal = controller.signal;
const list = await getShoppingList({ abortSignal });
setTimeout(() => controller.abort(), 1000);
```

### Linked signals

In many real-world applications, in-progress operations often need to get cancelled for multiple reasons. For example, you might want to cancel a download after a certain amount of time has elapsed and when the user presses the cancel button. The Azure SDK's `AbortController` supports linked signals for this purpose - when a signal is aborted, any of its linked signals are also aborted.

To show how you might use this in practice, we'll modify our previous example some more by making `getShoppingList` responsible for aborting operations that are taking too long:

```javascript
async function getShoppingList({ abortSignal, timeout = 10000 }) {
    // create a signal that aborts after the specified timeout
    const timeoutSignal = AbortController.timeout(timeout);

    // create a linked signal by passing the user-provided signal and the timeout signal together
    const controller = new AbortController(abortSignal, timeoutSignal);
    // now controller.signal will abort when either abortSignal or timeoutSignal abort!

    const cs = await secretClient.getSecret('storage-connection-string', {
        // pass our fancy linked signal
        abortSignal: controller.signal
    });
    const blobClient = new BlockBlobClient(cs.value, "MyDocuments", "shopping.rtf");
    return blobClient.downloadToBuffer(undefined,undefined, {
        abortSignal: controller.signal
    });
}

const controller = new AbortController();
const abortSignal = controller.signal;
const list = await getShoppingList({ abortSignal });

// if user indicates they're done waiting
controller.abort();
```

Linked signals are also useful when an operation is divided into many sub-tasks and you want granular control over which parts of the task you cancel while also being able to cancel the entire operation all at once. The top-level task might even be the application itself. For example, if you want to handle an interrupt signal gracefully by cancelling all in-progress operations inside your application, you can create an abort controller at application startup, handle the interrupt signal by calling `abort()`, and pass that signal or linked signals to all calls into Azure SDK libraries.

## Further reading

* [@azure/abort-controller readme on npm](https://www.npmjs.com/package/@azure/abort-controller)
* [Azure SDK guidelines for network requests](https://azure.github.io/azure-sdk/general_design.html#network-requests).

## Want to hear more?

Follow us on Twitter at [@AzureSDK](https://twitter.com/AzureSDK). We'll be covering more best
practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDKs.

Contributors to this article: _[Brian Terlson](https://twitter.com/bterlson)_.
