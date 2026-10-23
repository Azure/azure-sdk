## Release highlights

{% include releases/notes/release_highlights.md %}

## Latest Releases

View all the latest versions of C packages [here][c-latest-releases].

## Installation Instructions

Clone the repository, then check out the version you want to use:

```bash
git clone https://github.com/Azure/azure-sdk-for-c
```

{% assign releaseVersions = allPackages | map: 'Version' | uniq %}
{% for version in releaseVersions %}
```bash
git -C azure-sdk-for-c checkout {{ version }}
```
{% endfor %}

## Feedback

If you have a bug or feature request for one of the libraries, please post an issue to [GitHub](https://github.com/Azure/azure-sdk-for-c/issues).

{% include refs.md %}
