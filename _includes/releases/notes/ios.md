## Release highlights

{% include releases/notes/release_highlights.md %}

## Need help

- For reference documentation visit the [Azure SDK for iOS documentation](https://azure.github.io/azure-sdk-for-ios/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for iOS repository](https://github.com/azure/azure-sdk-for-ios/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-ios/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure+ios) or ask new ones on
 StackOverflow using the `azure` and `ios` tags.

## Latest Releases

View all the latest versions of iOS packages [here][ios-latest-releases].

## Installation Instructions

To install the latest GA and beta libraries, we recommend you use the [Swift Package Manager](https://swift.org/package-manager/). As an alternative, you may also integrate the libraries using [CocoaPods](https://cocoapods.org/).

### Xcode

To add the Azure SDK for iOS to your application, follow the instructions in [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app):

With your project open in Xcode 11 or later, select **File > Swift Packages > Add Package Dependency...** Enter the clone URL of the Swift Package Manager mirror repository for the library you wish to include (it will have the form `SwiftPM-<NAME>`, i.e.: *https://github.com/Azure/SwiftPM-AzureCore.git*) and click **Next**. For the version rule, specify the exact version or version range you wish to use with your application and click **Next**. Finally, place a checkmark next to each client library you wish to use with your application, ensure your application target is selected in the **Add to target** dropdown, and click **Finish**.

### Swift CLI

To add the Azure SDK for iOS to your application, follow the example in [Importing Dependencies](https://swift.org/package-manager/#importing-dependencies):

Open your project's `Package.swift` file and add a new package dependency to your project's `dependencies` section, specifying the clone URL of the Swift Package Manager mirror repository and the version specifier you wish to use:

{% assign allPackagesSortedByName = allPackages | where_exp: "item", "item.DisplayName != 'Communication Calling'" | sort: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
    .package(name: "{{ package.Name }}", url: "https://github.com/Azure/SwiftPM-{{ package.Name }}.git", from: "{{ package.Version }}"),
    {%- endcapture -%}
    {{"    "}}{{ install_instruction }}
{% endfor %}
{%- endcapture -%}

```swift
// swift-tools-version:5.3
dependencies: [
    ...
{{ install_instructions | rstrip }}
]
```

Next, add each client library you wish to use in a target to the target's array of `dependencies`:

{% assign allPackagesSortedByName = allPackages | where_exp: "item", "item.DisplayName != 'Communication Calling'" | sort: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
"{{ package.Name }}",
    {%- endcapture -%}
    {{"            "}}{{ install_instruction }}
{% endfor %}
{%- endcapture -%}

```swift
targets: [
    ...
    .target(
        name: "MyTarget",
        dependencies: [
{{ install_instructions | rstrip }}
            ...
        ]
    )
]
```

### Cocoapods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C and Swift projects. You can install it with the following command:

```bash
$ [sudo] gem install cocoapods
```

> CocoaPods 1.5+ is required.

To integrate one or more client libraries into your project using CocoaPods, specify them in your [Podfile](https://guides.cocoapods.org/using/the-podfile.html), providing the version specifier you wish to use. To ensure compatibility when using multiple client libraries in the same project, use the same version specifier for all Azure SDK client libraries within the project:

{% assign allPackagesSortedByName = allPackages | sort: 'Name' %}
{%- capture install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture install_instruction -%}
pod '{{ package.Name }}', '{{ package.Version }}'
    {%- endcapture -%}
    {{"    "}}{{ install_instruction }}
{% endfor %}
{%- endcapture -%}

```ruby
platform :ios, '12.0'
# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!
target 'MyTarget' do
{{ install_instructions | rstrip }}
    ...
end
```

Then, run the following command:

```bash
$ pod install
```

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-ios/issues).

{% include refs.md %}
