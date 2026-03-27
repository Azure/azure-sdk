{% if header_included != 'true' %}

{% if include.type != "deprecated" %}
# Azure SDK Releases

This page provides an inventory of all Azure SDK library packages, code, and documentation. The **Client Libraries** and **Management Libraries** tabs contain libraries that follow the new [Azure SDK guidelines](https://aka.ms/azsdk/guide). The **All** tab contains the aforementioned libraries and those that don't follow the new guidelines.

{% else %}
# Azure SDK Deprecated Releases

*This page contains the list of packages that have been deprecated. Please see [support policy](https://aka.ms/azsdk/policies/support) for more information.*

**The Azure SDK team is deprecating SDK libraries which do not conform to our [current Azure SDK guidelines](https://azure.github.io/azure-sdk/general_introduction.html) in multiple phases.  Support end dates begin in 2023.**

**To get specific deprecation information for the libraries you are using, search for the package name in this page and check the support end date. You can also find  migration guidance and replacement package information in the entry on the package manager.**

The new Azure SDK libraries are updated regularly to drive consistent experiences and strengthen your security posture. Please transition to the new Azure SDK libraries to take advantage of the new capabilities and critical security updates before the deprecation date.

Although the older libraries can still be used after deprecation, they will no longer receive official support and updates from Microsoft. If you prefer not to transition to the new Azure SDK libraries, source code for the current Azure SDKs libraries will still be available on GitHub as open source. You can continue to use the code and apply your own fixes, as required.

**Recommended action**

<ul>
    <li>Upgrade to the <a href="https://aka.ms/azsdk">new Azure SDK libraries</a> before the support end date so that your applications continue receiving regular security and performance updates.</li>
    <li>Learn more about the deprecation and replacement of older Azure SDK libraries in this <a href="https://azure.microsoft.com/blog/previewing-azure-sdks-following-new-azure-sdk-api-standards/" target="_blank">blog post</a>.</li>
</ul>

{% endif %}

{% include releases/header_search.md  %}

{% assign header_included = 'true' %}
{% endif %}
