---
title: "Go Guidelines: Package Implementation"
keywords: guidelines golang
permalink: golang_design.html
folder: golang
sidebar: general_sidebar
---

## Packages

Go groups related types in a package.  In Go, the package should be named `<prefix><service>`, where `<prefix>` is either `arm` or `az`, and where `<service>` is the service name represented as a single word.

{% include requirement/MUST id="golang-package-prefix" %} start the package with `arm` or `az` to indicate an Azure client package.  Use `arm` for management-plane packages, and `az` for all other packages.

{% include requirement/MUST id="golang-package-name" %} construct the package name with all lowercase letters (uppercase letters, hyphens and underscores are not allowed). For example, the Azure compute management package would be named `armcompute` and the Azure blob storage package would be named `azblob`.

{% include requirement/MUST id="golang-package-registration" %} register the chosen package name with the [Architecture Board]. Open an issue to request the package name. See the [registered package list](registered_namespaces.html) for a list of the currently registered packages.

### Directory Structure

{% include requirement/MUST id="golang-pkgpath-construction" %} construct a package import path that allows the consumer to tie its packages to the service being used. The package path does **NOT** change when the branding of the product changes. Avoid the use of marketing names that may change.

{% include requirement/MUST id="golang-pkgpath-leaf" %} ensure that the package leaf directory name matches the package name declared in the source code.

{% include requirement/MUST id="golang-pkgpath-apiver" %} ensure that each service API version is in its own directory, IFF that service supports multiple API versions.

{% include requirement/MUST id="golang-pkgpath-mgmt" %} place the management (Azure Resource Manager) API in the `arm` path. Use the grouping `./sdk/arm/<group>/<api-version>/arm<service>` for the package path. Since more services require management APIs than data plane APIs, other paths may be used explicitly for management only. Data plane usage is by exception only. Additional paths that can be used for control plane SDKs include:

{% include tables/mgmt_namespaces.md %}

Many management APIs do not have a data plane because they deal with management of the Azure account. Place the management package in the `arm` path. For example, use `sdk/arm/costanalysis/...` instead of `sdk/arm/management/costanalysis`.

Here is a complete example.

Data-plane packages:

- github.com/Azure/azure-sdk-for-go/sdk/keyvault/7.0/azkeyvault
- github.com/Azure/azure-sdk-for-go/sdk/storage/blob/2019-12-19/azblob
- github.com/Azure/azure-sdk-for-go/sdk/storage/queue/2019-12-19/azqueue
- github.com/Azure/azure-sdk-for-go/sdk/storage/table/2019-12-19/aztable

Management-plane packages:

- github.com/Azure/azure-sdk-for-go/sdk/arm/keyvault/2019-09-01/armkeyvault
- github.com/Azure/azure-sdk-for-go/sdk/arm/storage/2019-01-01/armstorage
- github.com/Azure/azure-sdk-for-go/sdk/arm/storage/2019-02-01/armstorage

### Common Packages

There are occasions when common code needs to be shared between several client packages. For example, a set of cooperating client packages may wish to share a set of errors or models.

{% include requirement/MUST id="golang-commonlib-approval" %} gain [Architecture Board] approval prior to implementing a common package.

{% include requirement/MUST id="golang-commonlib-minimize-code" %} minimize the code within a common package. Code within the common package is treated the same as any other client package.

{% include requirement/MUST id="golang-commonlib-namespace" %} store the common package in the same directory as the associated client packages.

A common package will only be approved if:

* The consumer of the non-shared package will consume the objects within the common package directly, AND
* The information will be shared between multiple client package.

Let's take two examples:

1. Implementing two Cognitive Services client packages, we find a model is required that is produced by one Cognitive Services client package and consumed by another Coginitive Services client package, or the same model is produced by two client packages. The consumer is required to do the passing of the model in their code, or may need to compare the model produced by one client package vs. that produced by another client package. This is a good candidate for choosing a common package.

2. Two Cognitive Services client packages return a `BoundingBox` model to indicate where an object was detected in an image. There is no linkage between the `BoundingBox` model in each client package, and it is not passed into another client package. This is not a good candidate for creation of a common package (although you may wish to place this model in a common package if one exists for the namespace already). Instead, produce two different models - one in each client package.

### Package Versioning

{% include requirement/MUST id="golang-versioning-modules" %} release each package as a [Go module](https://blog.golang.org/using-go-modules).  Legacy dependency management tools such as `dep` and `glide` are not supported.

{% include requirement/MUST id="golang-versioning-semver" %} release versions of modules in accordance with [semver 2.0](https://semver.org/spec/v2.0.0.html).

{% include requirement/MUST id="golang-versioning-beta" %} clearly version prerelease modules.  For new modules, use a v0 major version with no suffix (v0.1.0).  For existing modules, use a `-beta` suffix (v1.1.0-beta, v2.0.0-beta).

### Dependencies

Packages should strive to avoid taking dependencies on packages outside of the standard library for the following reasons:

- **Versioning** - Exposing types defined outside the standard library (i.e. `exchange types`) can indroduce versioning complexity.  If we have an client package that exposes types from a v3 of package Foo and the consumer wants to use v5 of package Foo, then the consumer cannot use the v5 types to satisfy the v3 requirement.
- **Size** - Consumer applications must be able to deploy as fast as possible into the cloud and move in various ways across networks. Removing additional code (like dependencies) improves deployment performance.
- **Licensing** - You must be conscious of the licensing restrictions of a dependency and often provide proper attribution and notices when using them.
- **Compatibility** - Often times you do not control a dependency and it may choose to evolve in a direction that is incompatible with your original use.
- **Security** - If a security vulnerability is discovered in a dependency, it may be difficult or time consuming to get the vulnerability corrected if Microsoft does not control the dependency's code base.

{% include requirement/MUST id="golang-dependencies-exch-types" %} limit exchange types to those provided by the standard library (**NO EXCEPTIONS**).

{% include requirement/MUST id="golang-dependencies-azure-core" %} depend on the `azcore` package for functionality that is common across all client packages.  This package includes APIs for HTTP connectivity, global configuration, logging, credential handling, and more.

{% include requirement/MUST id="golang-dependencies-azure-core" %} depend on the `sdk/internal` package for functionality that is common across all client packages that should not be publicly exported.  This package includes helpers for creating errors with stack frame information, and more.

{% include requirement/MUSTNOT id="golang-dependencies-approved-list" %} be dependent on any other packages within the client package distribution package, with the exception of the following:

{% include_relative approved_dependencies.md %}

### Native Code

TODO

### Doc Comments

TODO

### Repository Guidelines

TODO

#### OSS Repos

TODO

#### Documentation Type

TODO

#### README

TODO

#### Samples

TODO
