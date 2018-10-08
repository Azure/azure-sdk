# Azure SDK Design Guidelines

This document will describe architectural and API design guidelines for Azure SDKs. 

Currently, the document id mainly as a list of topics that we want to cover in more detail, i.e. there is not much useful inforamtion in it yet.

## 1.0 Language Independent Guidelines

### 1.0.0 General Guidelines

1.0.1 :warning: **NOTE** language-specific gudelines (sections 2.0 - 6.0) overrule language independent guidelines  

1.0.2 :white_check_mark: **DO** provide SDKs for the following languages: C#, Java, Python, JavaScript

1.0.3 :ballot_box_with_check: **CONSIDER** providing SDKs for the following languages:  Go, C++

<font size="2" color="gray">TODO: This will result in partial coverage for optional languages. Is that OK?</font>

1.0.4 :white_check_mark: **DO** support cancellations.

1.0.5 :white_check_mark: **DO** support retries

1.0.6 :no_entry: **DO NOT** depend on concrete logging, dependency injection, or configuration technologies. 

The SDKs will be used in applications that might be using ther logging, DI, and configuration technologies of their choice. 

## 1.1.0 Telemetry
Telemetry is used by service teams (not customers) to monitor what SDK a client is using to call into their service. Specifically, the service team can detect client OS, language, language version, and service SDK version. Some clients can prepend additional information indicating the name and version of the client application.

1.1.1 :white_check_mark: **DO** send telemetry information in the User-Agent header, with the header value in the the following format: 

[<application_id>/<SPACE\>]<sdk_name>/<sdk_version>/<SPACE\><platform_information>

* <application_id> ::= optional application-specific string. The string is supplied by the user of the SDK, e.g. "AzCopy/10.0.4-Preview"
* <sdk_name> ::= name of the SDK, e.g. "Azure-Storage-Blob"
* <sdk_version> ::= the version of the SDK. Note: this is not the version of the service
* <platform_information> ::= information about the currently-executing OS and runtime, e.g. "(NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"

For example, the following two are fully formatter User-Agent header values:

* "Azure-Storage/1.4.0 (NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"
* "AzCopy/10.0.4-Preview Azure-Storage/1.4.0 (NODE-VERSION v4.5.0; Windows_NT 10.0.14393)"

For details on the User-Agent header, see https://tools.ietf.org/html/rfc7231#section-5.5.3

NOTE: today, the <sdk_name> for all storage SDKs/packages (Blob, File, etc.) is simply "Azure-Storage". The guideline above proposes that we standardize on full SDK names, e.g. "Azure-Storage-Blob". 

TODO: provide the full list of SDK names.

TODO: provide language-specific guidelines (and possibly shared library) for generating <platform_information> 

TODO: provide shared library API for injecting telemetry information

## 2.0 C# Specific Guidelines

2.0.1 :white_check_mark: **DO** follow the official [Framework Design Guidelines](https://docs.microsoft.com/en-us/dotnet/standard/design-guidelines/)

2.0.2 :warning: **NOTE** additional gudelines in this section overrule the Framework Design Guidelines  

<font size="2" color="gray">TODO: describe guidance for logging, configuration, and dependency injection</font>

## 3.0 Java Specific Guidelines

## 4.0 Python Specific Guidelines

## 5.0 JavaScript Specific Guidelines

## 6.0 Go Specific Guidelines
