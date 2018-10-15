# Azure Developer Platform Design Guidelines

This document will describe architectural and API design guidelines for Azure SDKs. 

Currently, the document id mainly as a list of topics that we want to cover in more detail, i.e. there is not much useful inforamtion in it yet.

## 1.0 Language Independent Guidelines

1.0.1 :warning: **NOTE** language-specific gudelines (sections 2.0 - 6.0) overrule language independent guidelines  

1.0.2 :white_check_mark: **DO** provide SDKs for the following languages: C#, Java, Python, JavaScript

1.0.3 :ballot_box_with_check: **CONSIDER** providing SDKs for the following languages:  Go, C++

<font size="2" color="gray">TODO: This will result in partial coverage for optional languages. Is that OK?</font>

1.0.4 :white_check_mark: **DO** support cancellations.

1.0.5 :white_check_mark: **DO** support retries

1.0.6 :no_entry: **DO NOT** depend on concrete logging, dependency injection, or configuration technologies. 

The SDKs will be used in applications that might be using ther logging, DI, and configuration technologies of their choice. 


## 2.0 C# Specific Guidelines

2.0.1 :white_check_mark: **DO** follow the official [Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/)

2.0.2 :warning: **NOTE** additional gudelines in this section overrule the Framework Design Guidelines  

<font size="2" color="gray">TODO: describe guidance for logging, configuration, and dependency injection</font>

## 3.0 Java Specific Guidelines

## 4.0 Python Specific Guidelines

## 5.0 JavaScript Specific Guidelines

## 6.0 Go Specific Guidelines