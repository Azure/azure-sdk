---
title: AsyncIterators in the Azure SDK
layout: post
date: 26 may 2020
sidebar: releases_sidebar
author_github: bterlson
repository: azure/azure-sdk
---

A common feature in cloud APIs is paging for list results. Result sets may be massive - you could have thousands of blobs in a container, for example. Getting all results at once can cause delays in transmission and excessive load on the backend, and might even be so big it won't fit into memory in your client. So services offer potentially large collections in pages and developers request one page of results at a time.

Azure SDK libraries abstract away the details of requesting pages from the service. You write a normal loop, and we take care of the rest. For example, here is the code that iterates through a list of containers in Storage:

```javascript
const containers = blobServiceClient.listContainers();
for await (const container of containers) {
  console.log(`Container: ${container.name}`);
}
```

How is this done? We use features that were added to recent editions of JavaScript; most notably async iterators. Async Iterators represent a stream of data that is loaded asynchronously. They are used across the Azure SDK to represent asynchronous streams of data such as paginated APIs like above.

Async Iterators, and the Async Generators that produce them, were added in the ES2018 edition of the JavaScript standard. They are supported natively in recent version of modern browsers, but TypeScript can compile them down to generators or even vanilla functions.

If you're already familiar with async functions, promises, generators, and iterators, feel free to skip the background below. If not, that's great, most of this blog is for you!

## Background

At a high level, a function might produce one value or a (possibly unending) sequence of values. It also might do its work synchronously or asynchronously. Considered together, these modes create four possible ways functions might be declared and consumed. Put in a table, it looks like the following:

|                  | One Value                             | Many Values                                   |
| ---------------- | ------------------------------------- | --------------------------------------------- |
| **Synchronous**  | function<br>Returns T                 | generator function<br>Returns Iterator\<T>    |
| **Asynchronous** | async function<br>Returns Promise\<T> | async generator <br>Returns AsyncIterator\<T> |

When JavaScript debuted in 1995, it supported only synchronous functions that produce only a single return value. Developers who wanted to return multiple values, or wanted to produce values asynchronously, had to rely on libraries (for example, node's Stream or promises).

### Iterators & Generators

The 6th edition of the JavaScript language, ES2015, added iterators, iterables, and the `for-of` loop. Iterables are any object with a `Symbol.iterator` method that returns an iterator. Iterators are objects with a `next()` method. Calling `next()` returns an object with `value` and `done` properties which tell you the current iteration value and whether more values are available. The `for-of` loop provides handy syntax for looping over an iterable.

Iterables and iterators aren't types but protocols. Any object which has a `Symbol.iterator` method is said to implement the `Iterable` protocol. Likewise, any object with a `next` method is said to implement the `Iterator` protocol.

Let's get an understanding of Iterables and Iterators by building them from scratch. First, let's make an `Iterator`:

```javascript
const iterator = {
  next() {
    if (this.count <= 2) {
      return { value: this.count++, done: false };
    }

    return { value: undefined, done: true };
  },

  count: 0,
};

iterator.next(); // { value: 0, done: false }
iterator.next(); // { value: 1, done: false }
iterator.next(); // { value: 2, done: false }
iterator.next(); // { value: undefined, done: true }
```

Nothing too fancy here - we've implemented the `Iterator` protocol because we have a `next()` method which returns the next value in the sequence. Note how the iterator is stateful - it keeps track of its current position in the iteration. In practice this means you also need a way to vend fresh iterators. We can accomplish this by wrapping the iterator in a function:

```typescript
function getIterator() {
  return {
    next() {
      if (this.count <= 2) {
        return { value: this.count++, done: false };
      }

      return { value: undefined, done: true };
    },

    count: 0,
  };
}

const iterator1 = getIterator();
iterator1.next(); // { value: 0, done: false }

// this iterator is a separate instance with its own internal count
const iterator2 = getIterator();
iterator2.next(); // { value: 0, done: false }
```

Now every time I call `getIterator()`, I get a fresh iterator that starts at 0.

We've actually implemented a generator function using regular functions! A generator function creates a function that return an iterator, just like `getIterator` does. When a user calls `next()` on an iterator, the generator function starts running until it hits a `yield` or `return`. If it hits a `yield`, `next()` will return the yielded value with `done: false`, otherwise `next()` will return the returned value with `done: true`. It looks like this:

```javascript
// notice the * after function - it makes this a generator function
function* getIterator() {
  for (let i = 0; i <= 2; i++) {
    yield i;
  }
}

const iterator1 = getIterator();
iterator1.next(); // { value: 0, done: false }
```

This is pretty handy on its own, but we still need a way to pass around an object that is iterable but isn't itself an iterator. An array is an example of this - you want to pass around the array and let any code iterate over it as needed. This is what the `Iterable` protocol is for - anything with a `Symbol.iterator` method is iterable. Calling the method returns a fresh iterator.

The following example shows encapsulating `getIterator` above in a `Counter` class. Note that I'm using the generator syntax, but I could have used the more verbose form we used early on - there is little difference.

```typescript
class Counter {
  constructor(max) {
    this.max = max;
  }

  // the star makes this a generator method
  *[Symbol.iterator]() {
    for (let i = 0; i < this.max; i++) {
      yield i;
    }
  }
}

const threeCounter = new Counter(3);
const iterator1 = threeCounter[Symbol.iterator]();
iterator1.next(); // { value: 0, done: true }
```

Now I know what you're thinking: this looks horrible! I have to call some weird `Symbol.iterator` method to get an iterator? Great news: in practice, it is rare to call the Symbol.iterator method yourself. In fact, it is rare to call iterator .next() methods too. Usually, you will use the `for-of` loop:

```javascript
const threeCounter = new Counter(3);
for (let i of threeCounter) {
  console.log(i);
}
// logs 0, 1, 2
```

The `for-of` loop will call the `Symbol.iterator` method on the iterable object for you. It will also call `next()` on the resulting `iterator`, passing each value into the loop, until `next()` returns `{ done: true }`. Some other syntax and built-in libraries will also do this for you, like the spread operator and the Array.of method:

```javascript
[...threeCounter]; // [0, 1, 2]
Array.from(threeCounter); // [0, 1, 2]
```

One more small point: Iterators should also Iterable. The iterators created from the generator function are iterable, so you don't have to do anything to use them with the `for-of` loop. However, If you try to use our early examples where we examples with the `for-of` loop, you'll get an error saying that the iterator isn't iterable. This can easily be fixed:

```javascript
const iterator = {
  // add the Symbol.iterator method
  [Symbol.iterator]() {
    // `this` is an iterator, so just return it
    return this;
  },
  next() {
    if (this.count <= 2) {
      return { value: this.count++, done: false };
    }

    return { value: undefined, done: true };
  },

  count: 0,
};
```

And now you know why TypeScript has three similar-sounding types for iteration: Iterable, Iterator, and IterableIterator. Iterable is an interface with a `Symbol.iterator` method, Iterator is an object with a `next()` method, and IterableIterator has both!

### Promises & Async Functions

ES2015 added Promises to the language. I won't cover the details of Promises here, but [MDN has a good overview](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise) complete with handy diagrams. Fundamentally, Promises represent a value that will be produced asynchronously.

The 8th edition of the JavaScript language, ES2017, added `async function`s which offered developers an easy way to define functions that returned Promises.

Inside of an async function, you can `await` any Promise which defers further execution of the function until the awaited Promise resolves successfully. Then you can return your final result and the Promise returned from the async function resolves.

```javascript
async function getValue() {
  await delay(100);
  return "hi!";
}

// invoke the async function
const p = getValue();
// it returns a Promise immediately, we don't have the value yet.

// but after 100ms, it will resolve with "hi!", triggering our callback:
p.then((v) => console.log(v));
```

## Async Iterators & Async Generators

So far, we've gone over three ways to define a function:

1. The regular `function`, which returns a single value synchronously.
1. The generator function, `function*`, which returns an iterator for multiple values produced synchronously, and is consumed with the `for-of` loop.
1. The `async function`, which returns a promise for a value produced asynchronously, and is consumed using `await`.

The only remaining part of the puzzle is how do we produce and consume multiple values produced asychronously? Enter the async generators, `async function*`, which return async iterators and are consumed with the `for-await-of` loop!

Async iterators are a mashup of promises and iterators. Like a regular iterator, an async iterator is just an object with a `next()` method, however it returns _a promise_ for the iteration result rather than the result itself.

Likewise, async generators are a mashup of async functions and generators - you can both await asynchronous work and yield values to consumers.

Let's write our counter example from above, except where each value is produced after a delay of 100ms:

```javascript
async function* getAsyncIterator() {
  for (i = 0; i < 3 i++) {
    await delay(100);
    yield i;
  }
}


const iterator = getAsyncIterator();
// since iterator.next() returns a promise, we await its value.
await iterator.next(); // { value: 0, done: false }
await iterator.next(); // { value: 1, done: false }
await iterator.next(); // { value: 2, done: false }
await iterator.next(); // { value: undefined, done: true }
```

Much like iterators, typically you will not consume the async iterator directly, but use it in conjunction with the `for-await-of` loop which handles all the ceremony for you:

```javascript
for await (let i of getAsyncIterator()) {
  console.log(i);
}

// logs 0, 1, 2
```

As with iterators and generators, the async iterators returned from async generators are also `AsyncIterable`. An `AsyncIterable` is an object with a `Symbol.asyncIterable` method that returns an AsyncIterator. The `for-await-of` loop calls this method to get an object's async iterator.

Hence, the three TypeScript types for async iteration: `AsyncIterator`, `AsyncIterable`, and `AsyncIterableIterator`. An AsyncIterator has a `next()` method that returns a promise for an iteration result, an `AsyncIterable` has a `Symbol.asyncIterable` method that returns an `AsyncIterator`, and an `AsyncIterableIterator` has both!

## Async Iterators in the Azure SDK for JavaScript & TypeScript

Our new SDKs use async iterators whenever there is a large collection a developer wants to iterate over. A common example is paginated APIs. Let's take an example:

```javascript
const containers = blobServiceClient.listContainers();
for await (const container of containers) {
  console.log(`Container: ${container.name}`);
}
```

`containers` is what we call a `PagedAsyncIterableIterator`. It's an async iterator with an additional method, `byPage()`, that exposes an async iterator for the underlying pages. Sometimes pages are more convenient to work with:

```javascript
const containerPages = blobServiceClient.listContainers().byPage();
// loop over each page
for await (const page of containerPages) {
  // loop over each item in the page
  for (const container of page) {
    console.log(`Container: ${container.name}`);
  }
}
```

The three major advantages of using async iterators over manual pagination or APIs that return all items in an array are that:

1. You can consume asynchronous sequences of values using a fairly standard loop syntax. The complexity of dealing with paginated APIs is completely encapsulated behind the Async Iterator interface.
2. You pull new items from the service on-demand as needed. If for whatever reason you don't need to iterate any longer, just `break` like any old loop and you won't fetch any more data.
3. We're set up for a future where async iterators, like iterators, have deep integration in the language and great support across the ecosystem.

Let's dive a bit deeper into each of these.

#### Standard loop syntax

The `for-await-of` loop makes consuming async iterators easy. No messy code dealing with promises and plumbing continuation tokens.

#### Pull items on demand

When using iterating an async iterator, you're pulling data as you need it, not all in advance. That means you don't need to fetch a potentially huge list and store it in memory. It also means you don't fetch more data than you need. To understand how this works, let's walk through the example above.

First, we call `listContainers()`, which returns an async iterator. At this point, the service hasn't even been called.

On the next line, we start the `for-await-of` loop. JavaScript calls `.next()` on the iterator and awaits the result. Our library code will fetch the next page if needed, pull out the next container in the page, and yield it back, kicking off the loop body. Once the loop body is finished executing, the process repeats.

If at any point you break out of the `for-await-of` loop, or an error is thrown, then no more data is requested from the service.

#### Language & library integration

Async iterators are a fairly recent addition to the language and thus far don't have much support other than the `for-await-of` loop. Thankfully this is a major win and more than enough to justify using async iterators today. However, the future will likely bring further support for async iterators such as methods for applying array-like operators like `map`, `filter`, and friends.

But more exciting is that Async Iterators are a standard feature and so libraries have stepped in to fill the gaps.

For example, sometimes it is really convenient to get all of your items into an array. Generally we don't offer a simple API in our libraries to do this because there's a good chance you'll pull down huge amounts of data you don't need and end up with a hefty bill. That said, sometimes you know you're dealing with a small collection and just want to do array things on it. A library like `ix` provides a function to do just this:

```javascript
import { toArray } from "ixjs/asynciterable";
let items = await toArray(client.listThings());
// now items is a regular array of items!
```

You'll find other libraries on npm for doing all sorts of things with async iterators, and in the future this support will only grow. Adopting async iterators in the Azure SDK makes sure we'll interoperate seamlessly with great libraries across our ecosystem.
