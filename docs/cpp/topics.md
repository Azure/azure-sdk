---
title: "C++ Guidelines: API Design"
keywords: guidelines cpp
permalink: cpp_design.html
folder: cpp
sidebar: general_sidebar
---

{% include draft.html content="The C++ Language guidelines are in DRAFT status" %}

The API surface of your client library must have the most thought as it is the primary interaction that the consumer has with your service.

## Design

### Introduction

#### Design Principles

#### General Guidelines

#### Non-Http Libraries

### Azure SDK API Design

#### Service Client

##### Service Client Constructors

###### Client Configuration

###### Setting the Service Version

###### Sync and Async

###### Client Immutability

##### Service Methods

###### Naming
###### Return Types
###### Cancellation
##### Service Method Parameters

###### Options Parameters
###### Parameter Validation

##### Methods Returning Collections (Pageable)
##### Methods Invoking Long Running Operations
##### Conditional Request Methods
##### Hierarchical Clients

#### Supporting Types

##### Model Types
##### Enumerations
##### Using Azure Core Types
##### Using Primitive Types

#### Error Handling (Exceptions)

#### Authentication

#### Namesapces

#### Support for Mocking

### Azure SDK Libraries (Packages)

#### Packaging
##### Ser-specific Common Libraries
#### Versioning
#### Dependencies
#### Native Code
#### Doc Comments

### Repository Guidelines
#### Documentation Style
#### README
#### Samples

