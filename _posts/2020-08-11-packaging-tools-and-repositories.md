---
title: Azure SDK: Packaging, tools, and repository structure
layout: post
date: 2020-08-11
sidebar: releases_sidebar
author_github: mitchdenny
repository: azure/azure-sdk
---

The capabilities and constraints of the package management tool chain used by a particular ecosystem can have a dramatic impact on how you structure your repositories and whether you ship a single monolithic package, or whether you can break it up.

We've learned on the Azure SDK team that it generally works best if you start with the end-developer in mind and figure out how to optimize the consumption experience and then balance that against other considerations such as inner-loop developer efficiency, engineering system complexity and supportability.

Back in March 2020 (seems so long ago doesn't it!) we posted about [how we structured the Azure SDK repositories](https://devblogs.microsoft.com/azure-sdk/building-the-azure-sdk-repository-structure/). We compared some of the implications of mono-repo vs. micro-repo decisions when it comes to hosting our SDKs and outlined some of the key considerations for choosing between the two.

One of the factors in the decision was the level of tool chain support for our selected approach.

For the most part we've managed to navigate the various trade-offs associated with choosing a mono-repository structure while still being able to ship various components of the SDK independently.

This is enabled in large part due to the fact that for many of our repositories (.NET, Java, JavaScript, and Python), the artifact we ship is a bundle of source/binaries which are consumed independently of where we host our source code. In short, if we can script a way to produce the artifacts we can ship them however we want!

But what about ecosystems where there is a significant relationship between the source repo and the method of consuming our SDK?

## Consuming via source

In ecosystems where there is no defacto standard for packaging, developers are left to come up with their own solutions for sharing code. In C, C++, and Objective-C codebases for example, it is not uncommon to see developers using Git sub-modules or committing entire snapshots of third party libraries.

Recently in the C++ community we've seen more efforts to formulate a standard approach to code-reuse. A good example is [vcpkg](https://github.com/Microsoft/vcpkg). In the iOS community we see solutions like [CocoaPods](https://cocoapods.org/).

The general approach that these package managers take is that they allow you to express your dependencies and then the tooling takes care of pulling the appropriate version of the source and presenting it to your chosen build system for integration into your solution.

Source-based composition of dependencies is a common feature of ecosystems that produce native binaries where there tends to be less introspection capabilities at runtime.

## Repository as package

Language/platform designers today can't ignore the importance of having a simple and streamlined code reuse experience. It isn't surprising then when we look at languages like Swift and Go that they have made early efforts to formalize what it means to create reusable code.

The difference with these ecosystems when compared to .NET, Java, JavaScript, and Python is that they've opted to strongly tie the definition of a package to the source repository that hosts it.

* Swift Package Manager looks for a ```Package.swift``` file in the root of a Git repository and versions are targeted by Git ref.

![Swift Package Structure](/images/posts/swift-package-structure.PNG)

* Go uses a ```Go.mod``` file to define a module and delcare its dependencies. Once again, the Git ref is used as the version specifier.

![Go Package Structure](/images/posts/go-package-structure.PNG)



### Repository as package has nice OSS characteristics

Source-based packages where the repository is used as a discovery and distribution mechanism makes it very easy for a consumer of your package to fork your repository on GitHub make some local changes on a branch and consume it within their own solution whilst they wait for their changes to be upstreamed (or not).

### Downsides of repository as package

Like everything though there is a downside. In Swift specifically the model for _repository as package_ is strictly one package per repository. This means that if you are tied to the monolithic repository model then you are going to have a monolithic package.

When building a set of APIs like we have in the SDK we need to carefully consider whether the requirement to ship the entire SDK at once vs. piecemeal is a blocker, and then depending on the packaging tool chain, that will have impacts on the way we structure our repositories.

In the case of our Swift SDKs we've opted to stick with the mono-repository approach to create a focal point for reporting issues and community contributions.

Go's deep linking capability allows us to operate as a mono-repository but also ship module updates independently.

This is an example of where tool chain support has major implications for how you structure your repository and at what level of granularity you can release components to customers.

## Knowing when you're fighting the tools

When it comes to building solutions I am a big proponent of the [principle of least astonishment](https://en.wikipedia.org/wiki/Principle_of_least_astonishment). Applied to the engineering systems for the Azure SDK, that means trying not the fight the tools that support the ecosystem that you are targetting.

For package managers this means understanding the relationship that package format, discovery, distribution and cardinality have on the way that you structure your repository and the surrounding build and release systems.

The table below is my quick survey of some ecosystems and how they map to package format, discovery, distribution, and cardinality (whether the one repo can host sources for multiple packages):

|Ecosystem|Package format|Package discovery|Package distribution|Package cardinality
|--|--|--|--|--|
|.NET|Binary|Registry|Registry|1:Many
|Java|Binary|Registry|Registry|1:Many
|JavaScript|Source|Registry|Registry|1:Many (1:1 by convention)
|Python|Source<sup>1</sup>|Registry<sup>1</sup>|Registry<sup>1</sup>|1:Many
|Swift|Source<sup>2</sup>|Repository|Repository|1:1<sup>3</sup>
|Go|Source|Repository|Repository|1:Many
|Rust|Source|Registry|Registry|1:Many (1:1 by convention)

> ### Notes
> 1. Python also supports binary distribution in the form of wheel packages, and source distribution can come directly from the version control system.
>
> 2. Swift Package Manager recently added support for wrapping binary frameworks (*.xcframework archives) in a package. The Swift Package meta-data in the ```Package.swift``` file still needs to be hosted in a repository, but the package itself can be a binary.
>
> 3. Whilst Swift Packager Manager only supports one package per repository, a single package can define multiple _Products_ which allow you to control which parts of the code is built.

With .NET for example, it is quite normal to have a single repository produce multiple packages because each package exists independently of the repository which contains its sources.

If we tried to do the same thing with Swift by comparison we'd frequently be fighting against the Swift tool chain.

In the JavaScript community, NPM packages are generally one package per repository, but the fact that package discovery and distribution is handled by the registry means that we can get away with breaking that convention in the interests of keeping a single place for developers to report issues and make contributions.

## Conclusions

As we build out the SDK for each language/ecosystem we are constantly striving to maintain a balance the productivity of the developers building the SDK and the experience of the developers consuming the SDK. The tool chains in each ecosystem influence much of how our engineering system works and the decisions we make about structuring and releasing the SDK.
