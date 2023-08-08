## Release highlights

{% include releases/notes/release_highlights.md %}

## Need help

- For reference documentation visit the [Azure SDK for Android documentation](https://azure.github.io/azure-sdk-for-android/).
- For tutorials, samples, quick starts and other documentation, visit the [Azure SDK for Android repository](https://github.com/azure/azure-sdk-for-android/).
- File an issue via [Github Issues](https://github.com/Azure/azure-sdk-for-android/issues/new/choose).
- Check [previous questions](https://stackoverflow.com/questions/tagged/azure-android-sdk) or ask new ones on
 StackOverflow using the `azure-android-sdk` tag.

## Latest Releases

View all the latest versions of Android packages [here][android-latest-releases].

## Installation Instructions

To use the latest GA and beta libraries, refer to the dependency information below, which may be copied into your projects Gradle `build.gradle` or Maven `pom.xml` file as appropriate. If you are using a different build tool, refer to its documentation on how to specify dependencies.

{% assign allPackagesSortedByName = allPackages | sort: 'Name' %}

{%- capture gradle_java_install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture gradle_java_install_instruction -%}
{{ "    " }}implementation '{{ package.GroupId }}:{{ package.Name }}:{{ package.Version }}'
    {%- endcapture -%}
    {{ gradle_java_install_instruction }}
{% endfor %}
{%- endcapture -%}

{%- capture gradle_kotlin_install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture gradle_kotlin_install_instruction -%}
{{ "    " }}implementation("{{ package.GroupId }}:{{ package.Name }}:{{ package.Version }}")
    {%- endcapture -%}
    {{ gradle_kotlin_install_instruction }}
{% endfor %}
{%- endcapture -%}

{%- capture maven_install_instructions -%}
{% for package in allPackagesSortedByName %}
    {%- capture maven_install_instruction -%}
<dependency>
{{ "    " }}<groupId>{{ package.GroupId }}</groupId>
{{ "    " }}<artifactId>{{ package.Name }}</artifactId>
{{ "    " }}<version>{{ package.Version }}</version>
</dependency>
    {%- endcapture -%}
    {{ maven_install_instruction }}
{% endfor %}
{%- endcapture -%}

### Gradle

#### Java
```
dependencies {
    ...
{{ gradle_java_install_instructions | rstrip }}
}
```
{: .language-groovy}

#### Kotlin
```
dependencies {
    ...
{{ gradle_kotlin_install_instructions | rstrip }}
}
```
{: .language-groovy}

#### Maven
```
{{ maven_install_instructions | rstrip }}
```
{: .language-xml}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/azure/azure-sdk-for-android/issues).

{% include refs.md %}
