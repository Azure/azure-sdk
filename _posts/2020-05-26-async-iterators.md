---
title: AsyncIterators in the Azure SDK
layout: post
date: 26 may 2020
sidebar: releases_sidebar
author_github: bterlson
repository: azure/azure-sdk
---

Async Iterators represent a stream of data that is loaded asynchronously. They are used across the Azure SDK to represent asynchronous streams of data such as paginated APIs where data is fetched a page at a time.

Async Iterators were added fairly recently to JavaScript - the ES2018 edition of the standard. They are supported natively in recent version of modern browsers, but TypeScript can compile them down to generators or even vanilla functions.

## Background

At a high level, a function might produce one value or a (possibly unending) sequence of values. It also might do its work synchronously or asynchronously. Considered together, these modes create four possible ways functions might be declared and consumed. Put in a table, it looks like the following:

|                  | One Value                             | Many Values                                   |
| ---------------- | ------------------------------------- | --------------------------------------------- |
| **Synchronous**  | function<br>Returns T                 | generator function<br>Returns Iterator\<T>    |
| **Asynchronous** | async function<br>Returns Promise\<T> | async generator <br>Returns AsyncIterator\<T> |

When JavaScript debuted in 1995, it supported only synchronous functions that produce only a single return value. Developers who wanted to return multiple values, or wanted to produce values asynchronously, had to rely on libraries (for example, node's Stream or promises).

### Iterators & Generators

The 6th edition of the JavaScript language, ES2015, added iterators and iterables. Iterables are any object with a `Symbol.iterator` method that returns an iterator. Iterators are objects with a `next()` method. Calling `next()` returns an object with `value` and `done` properties which tell you the current iteration value and whether more values are available.

Iterables and iterators aren't types but protocols. Any object which has a `Symbol.iterator` method is said to implement the `Iterable` protocol. Likewise, any object with a `next` method is said to implement the `Iterator` protocol.

Let's get an understanding of Iterables and Iterators by building them from scratch. First, let's make an `Iterator`:

```javascript
const counter = {
  next() {
    if (this.count < 3) {
      return { value: this.count++, done: false };
    }

    return { value: this.count, done: true };
  },

  count: 0,
};

counter.next(); // { value: 0, done: false }
counter.next(); // { value: 1, done: false }
counter.next(); // { value: 2, done: false }
counter.next(); // { value: 3, done: true }
```

Nothing too fancy here - we've implemented the `Iterator` protocol because we have a `next()` method which returns the next value in the sequence. Note how the iterator is stateful - it keeps track of its current position in the iteration. In practice this means you also need a way to vend fresh iterators. We can accomplish this by wrapping the iterator above in a function:

```typescript
function counter(max) {
  return {
    next() {
      if (this.count < max) {
        return { value: this.count++, done: false };
      }

      return { value: this.count, done: true };
    },

    count: 0,
  };
}

const iterator1 = counter(3);
iterator1.next(); // { value: 0, done: false }

const iterator2 = counter(3);
iterator2.next(); // { value: 0, done: false }
```

```typescript
class Counter {
  getIterator() {
    return {
      next() {
        if (this.count < 3) {
          return { value: this.count++, done: false };
        }

        return { value: this.count, done: true };
      },

      count: 0,
    };
  }
}
function counter() {}

const iterator1 = counter();
iterator1.next(); // { value: 0, done: false }

const iterator2 = counter();
iterator2.next(); // { value: 0, done: false }
```

The getIterator function is nice, but we usually have some object which is iterable in some sense, and it would be nice to tag it in some way so a program can discover if something is iterable and iterate over it if so. This is what the `Iterable` protocol is for. We've already seen an object that can be considered iterable - the iterator itself! In this case, the implementation is simple - `Symbol.iterator` returns itself:

```javascript
function getIterator() {
  return {
    [Symbol.iterator]() {
      return this;
    },
    next() {
      if (this.count < 3) {
        return { value: this.count++, done: false };
      }

      return { value: this.count, done: true };
    },

    count: 0,
  };
}
```

```javascript
function counter() {
  return {
    [Symbol.iterator]() {
      return this;
    },
    next() {
      if (this.count < 3) {
        return { value: this.count++, done: false };
      }

      return { value: this.count, done: true };
    },

    count: 0,
  };
}
```

Usually, however, we have an object that isn't itself an iterator with all its state, but instead iterable in the sense that it can vend fresh iterators over some sequence. So we could wrap the iterator above in a function that returns a new iterator each time its called:

ES2015 also added Promises to the language, although without any syntactic support. The 8th edition of the JavaScript language, ES2017, added `async function`s which offered developers an easy way to define functions that returned promises. Additionally, developers could `await` any promise value inside the async function effectively deferring further execution of the function until the awaited promise resolves successfully. This made consuming asynchronous APIs substantially easier than dealing with promises directly - no more `then()`/`catch()` calls!
