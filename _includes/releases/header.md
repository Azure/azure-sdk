{% if header_included != 'true' %}

{% if include.type != "retired" %}
# Azure SDK Releases

This page contains links to all of the Azure SDK library packages, code, and documentation.  The "Client and Management Libraries" tabs contain libraries that follow the new [Azure SDK Guidelines](https://aka.ms/azsdk/guide).  The "All" tab also contains libraries that do not yet follow the new guidelines.

{% else %}
# Azure SDK Retired Releases

*This page contains the list of packages that have been support retired. Please see [support policy](https://aka.ms/azsdk/policies/support) for more information.*


**On 31 March 2023, we will be retiring support for Azure SDK libraries which do not conform to our [current Azure SDK guidelines](https://azure.github.io/azure-sdk/general_introduction.html).** The new Azure SDK libraries are updated regularly to drive consistent experiences and strengthen your security posture. Please transition to the new Azure SDK libraries to take advantage of the new capabilities and critical security updates before 31 March 2023.

Although the older libraries can still be used beyond 31 March 2023, they will no longer receive official support and updates from Microsoft. If you prefer not to transition to the new Azure SDK libraries, source code for the current Azure SDKs libraries will still be available on GitHub as open source. You can continue to use the code and apply your own fixes, as required.

**Recommended action**

•	Upgrade to the [new Azure SDK libraries](https://aka.ms/azsdk) by 31 March 2023 so that your applications continue receiving regular security and performance updates.
•	Learn more about the retirement and replacement of older Azure SDK libraries in this [blog post](https://azure.microsoft.com/en-us/blog/previewing-azure-sdks-following-new-azure-sdk-api-standards/).


{% endif %}

<small>Last updated: {{ 'now' | date: "%b %Y" }}</small>

<div class="search-group">
    <input class="form-control" id="myInput" type="text" placeholder="Search...">
    <img
        alt="Copy filter to clipboard"
        class="search-share search-share-hide"
        id="searchShare"
        title="Copy filter link to clipboard"
        src="{{ "/images/share.png" | relative_url }}"
        tabindex=0
        >
</div>

{% assign header_included = 'true' %}
{% endif %}
