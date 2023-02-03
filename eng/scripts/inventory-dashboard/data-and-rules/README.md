# Inventory Dashboard Data and Rules

Explanation of rule files:

`exceptionMap.json`:

- Used to specify when a missing library should not be counted because it is not an SDK we ever plan to create.
- Types of Exceptions: _Note: the types of exceptions double as the primary keys for this JSON._

  - "language-sdk-not-need": Used when a library does not need to be implemented in the other tier 1 languages and Go. The value should be an array of objects. The objects should follow this format:

    ```json
    {
      "Service": "the service name",
      "SDK": "the display name of the sdk",
      "Plane": "the plane of the sdk",
      "Languages-Not-Needed": "An array of strings, where the strings are the programming languages where the SDK is not needed."
    }
    ```

  - "track-2-not-needed": Used when an existing track 1 library does not need a track 2 replacement library. The value should be an array of objects. The objects should follow this format:

    ```json
    {
      "Service": "the service name",
      "SDK": "the display name of the sdk",
      "Plane": "the plane of the sdk",
      "Language": "the programming language of the SDK. Options: .NET | Java | JavaScript | Python | Go | Android | C | C++ | iOS"
    }
    ```

`serviceCategories.json`:

- Used to specify categories for the services to be filtered by.
- The primary keys for this json file should be the names of the categories and the value should be an array of strings that are the Services to include in that category.
- Example:

  ```json
  {
    "Messaging": ["Service Bus", "Event Hubs"]
  }
  ```

`serviceNameMap.json`:

- Used to map directories from the Azure/azure-rest-api-specs repo, `specification` directory to service names.
- The primary key for this file should be the directory name and the value should be the service name.

`servicesToHide.json`:

- Used to hide certain services and the SDKs for them from the Inventory Dashboard.
- The primary key for this file should be the name of the Service as it shows in the Inventory Dashboard and the value should always  be true.