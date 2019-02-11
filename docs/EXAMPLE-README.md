# Client Library for Azure (Name of Service)

TODO: place a full description here matching the marketing description that is on the services main documentation site.

You can use this library to:

* TODO: Example of a common task that people would use this library to accomplish with a link to the sample that shows how to do it.
* TODO: Example of a common task that people would use this library to accomplish with a link to the sample that shows how to do it.
* TODO: Example of a common task that people would use this library to accomplish with a link to the sample that shows how to do it.

[Getting Started][getting-started-docs] | [API Reference Documentation][api-reference-docs] | [Source Code][source-code]

# Getting Started

(TODO: This section should include everything needed to create your first client connection to the service very quickly with the first thing being the command on how to get the package installed.)

## Install the package

Install the Azure SDK Cosmos DB package for Python with [pip][pip]:

```Bash
pip install (package name)
```

For details on how to configure your developement environment see the [prerequisites](#prerequisites).

## Authentication

Interaction with Cosmos DB starts with an instance of the [CosmosClient][TODO link to CosmosClient docs] class. You need an **account**, its **URI**, and one of its **account keys** to instantiate the client object.

## Get Credentials

Use the Azure CLI snippet below to populate two environment variables with the database account URI and its primary master key (you can also find these values in the Azure portal). The snippet is formatted for the Bash shell.

```Bash
RES_GROUP=<resource-group-name>
ACCT_NAME=<cosmos-db-account-name>

export ACCOUNT_URI=$(az cosmosdb show --resource-group $RES_GROUP --name $ACCT_NAME --query documentEndpoint --output tsv)
export ACCOUNT_KEY=$(az cosmosdb list-keys --resource-group $RES_GROUP --name $ACCT_NAME --query primaryMasterKey --output tsv)
```

## Create a Client Connection

Once you've populated the `ACCOUNT_URI` and `ACCOUNT_KEY` environment variables, you can create the [CosmosClient][TODO link to CosmosClient docs].

```Python
from azure.cosmos import HTTPFailure, CosmosClient, Container, Database, PartitionKey

import os
url = os.environ['ACCOUNT_URI']
key = os.environ['ACCOUNT_KEY']
client = CosmosClient(url, key)
```

## Key Concepts

(TODO: Write down definitions and links to documentation for key concepts of the API. The following are a couple examples from Cosmos)
* [Database][ref_database]: A Cosmos DB account can contain multiple databases. When you create a database, you specify the API you'd like to use when interacting with its documents: SQL, MongoDB, Gremlin, Cassandra, or Azure Table. Use the [Database][ref_database] object to manage its containers.
* [Container][ref_container]: A container is a collection of JSON documents. You create (insert), read, update, and delete items in a container by using methods on the [Container][ref_container] object.

## Examples

(TODO: Have a list of simple helloworld style code snippets that can be easily copied and pasted into an application that has already instantiated their connection. These should cover the basic scenarios outlined in the first section of this readme. This should not be an exhaustive but should cover the most common operations that will be used. The following are some examples from Cosmos for Python)
* [Create a database](#create-a-database)
* [Create a container](#create-a-container)
* [Insert data](#insert-data)
* [Query the database](#query-the-database)

### Create a database

After authenticating your [CosmosClient][ref_cosmosclient], you can work with any resource in the account. The code snippet below creates a SQL API database, which is the default when no API is specified when [create_database][ref_cosmosclient_create_database] is invoked.

```Python
database_name = 'testDatabase'
try:
    database = client.create_database(id=database_name)
except HTTPFailure as e:
    if e.status_code != 409:
        raise
    database = client.get_database(id=database_name)
```

### Create a container

This example creates a container with default settings. If a container with the same name already exists in the database (generating a `409 Conflict` error), the existing container is obtained instead.

```Python
container_name = 'products'
try:
    container = database.create_container(id=container_name, partition_key=PartitionKey(path="/productName")
except HTTPFailure as e:
    if e.status_code != 409:
        raise
    container = database.get_container(container_name)
```

The preceding snippet also handles the [HTTPFailure][ref_httpfailure] exception if the container creation failed. For more information on error handling and troubleshooting, see the [Troubleshooting](#troubleshooting) section.

### Insert data

To insert items into a container, pass a dictionary containing your data to [Container.upsert_item][ref_container_upsert_item]. Each item you add to a container must include an `id` key with a value that uniquely identifies the item within the container.

This example inserts several items into the container, each with a unique `id`:

```Python
database = client.get_database(database_name)
container = database.get_container(container_name)

for i in range(1, 10):
    container.upsert_item(dict(
        id=f'item{i}',
        productName='Widget',
        productModel=f'Model {i}'
        )
    )
```

### Query the database

A Cosmos DB SQL API database supports querying the items in a container with [Container.query_items][ref_container_query_items] using SQL-like syntax.

This example queries a container for items with a specific `id`:

```Python
database = client.get_database(database_name)
container = database.get_container(container_name)

# Enumerate the returned items
import json
for item in container.query_items(
                query='SELECT * FROM mycontainer r WHERE r.id="something"',
                enable_cross_partition_query=True):
    print(json.dumps(item, indent=True))
```

## Prerequisites

(TODO: List everything people will need in order to get started with this library as far as accounts and installs with links (DELETE THIS LINE))
* Azure subscription - [Create a free account][azure_sub]
* Install the required developer tooling, package manager and runtimes for example [Python 3.6+][add_link] or [.NET Core 2.1 SDK][add_link].

(TODO: If there are concrete commands that can be run to create accounts or install a pre-req, provide a 1 or 2 liner here)

### Configure a virtual environment (optional) TODO: This is python specific so not needed in other languages.

Although not required, you can keep your your base system and Azure SDK environments isolated from one another if you use a virtual environment. Execute the following commands to configure and then enter a virtual environment with [venv][venv]:

```Bash
python3 -m venv azure-cosmosdb-sdk-environment
source azure-cosmosdb-sdk-environment/bin/activate
```

## Troubleshooting

(TODO: provide troubleshooting instructions for common issues as well as links to any known issues in the library that are being commonly hit.)

### More sample code

There are more samples for how to use this library in the [samples][samples-folder] folder.

### Additional Documentation

For more extensive documentation on the <Service Name> service, see the [<Service Name documentation][<link>] on docs.microsoft.com.

# Contributing

## Environment

(TODO: Provide instructions on any specific requirements for being able to build and test the library for each developer operating system type after cloning)
To build this component go to this folder in the source after cloning the repo and run the following commands:

### Linux and OSX

``` ./build.sh ```

### Windows

``` build.cmd ```

(TODO: Link to the language/repo specific contribution guidelines)

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

# License

This project is licensed under the MIT License. See the [License][license] in the root of the repo.

<!-- LINKS -->
[source-code]: https://github.com/azure/azure-sdk/sdk/name-of-package
[api-reference-docs]: ???
[getting-started-docs]: ???
[samples-folder]: https://github.com/azure/azure-sdk/sdk/name-of-package/samples
[service-docs]: https://docs.microsoft.com/azure/page-for-service
[azure_sub]: https://azure.microsoft.com/free/
[license]: https://github.com/azure/azure-sdk/LICENSE.md
