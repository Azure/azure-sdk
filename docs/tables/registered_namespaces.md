---
title: "Registered Namespaces"
permalink: registered_namespaces.html
folder: general
sidebar: general_sidebar
---

The following are a list of registered namespaces.

| Namespace                     | Service Owner                  |
| :---------------------------- | :----------------------------- |
| `azure.ai.inkrecognizer`      | [Ink Recognizer]               |
| `azure.data.appconfiguration` | [App Configuration]            |
| `azure.cosmos`                | [Azure Cosmos DB]              |
| `azure.messaging.eventhubs`   | [Event Hubs]                   |
| `azure.search`                | [Azure Search]                 |
| `azure.security.keyvault`     | [Key Vault]                    |
| `azure.storage.blobs`         | [Azure Storage]                |
| `azure.storage.files.shares`  | [Azure Storage]                |
| `azure.storage.files.datalake`| [Azure Storage]                |
| `azure.storage.queues`        | [Azure Storage]                |

We represent the namespace in a standard form (each element is all lower case and starts with the `azure` identifier).  This standard form must be turned into the language-specific form before use.  For example, `azure.security.keyvault` is represented as:

* `com.azure.security.keyvault` in Java, and
* `Azure.Security.KeyVault` in .NET.

To register a new namespace, contact the [Architecture Board].

{% include refs.md %}

<!-- Service Links -->
[App Configuration]: https://azure.microsoft.com/en-us/services/app-configuration/
[Azure Cosmos DB]: https://azure.microsoft.com/en-us/services/cosmos-db/
[Azure Search]: https://azure.microsoft.com/en-us/services/search/
[Azure Storage]: https://azure.microsoft.com/en-us/services/storage
[Event Hubs]: https://azure.microsoft.com/en-us/services/event-hubs/
[Ink Recognizer]: https://azure.microsoft.com/en-us/services/cognitive-services/ink-recognizer/
[Key Vault]: https://azure.microsoft.com/en-us/services/key-vault/
