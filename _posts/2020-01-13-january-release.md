---
title: Azure SDK Releases (January 2020)
layout: post
date: 13 Jan 2020
sidebar: releases_sidebar
repository: azure/azure-sdk
---

This month, we have promoted three of the client libraries to general availability, and expanded our service support to include a preview SDK for our first Cognitive Service: the Azure Text Analytics service.

The new generally available libraries being released this month are:

* [Azure App Configuration](https://docs.microsoft.com/azure/azure-app-configuration/)
* [Azure Key Vault Certificates](https://docs.microsoft.com/en-us/azure/key-vault/certificate-scenarios)
* [Azure Event Hubs](https://docs.microsoft.com/en-us/azure/event-hubs/)  (.NET and Java are pending final validation, but should appear soon!)

These are ready to use in your production applications.  You can find details of all released libraries on [our releases page](https://azure.github.io/azure-sdk/releases/latest/).

New preview releases:

* [Azure Storage Data Lake Files](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-introduction?toc=%2fazure%2fstorage%2fblobs%2ftoc.json)
* [Azure Text Analytics](https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/index)

We believe these are ready for your use, but not yet ready for production.  Between now and the GA release, these libraries may undergo API changes.  We'd love your feedback!  If you use these libraries and like what you see, or you want to see changes, let us know in the GitHub issues for the appropriate language. 

## Getting Started

Use the links below to get started with your language of choice.  You will notice that all the preview libraries are tagged with "preview".

* [.NET release notes]({{site.baseurl}}/releases/2020-01/dotnet.html)
* [Java release notes]({{site.baseurl}}/releases/2020-01/java.html)
* [Python release notes]({{site.baseurl}}/releases/2020-01/python.html)
* [JavaScript release notes]({{site.baseurl}}/releases/2020-01/js.html)

If you want to dive deep into the content, the release notes linked above and the change logs they point to give more details on what has changed.

## Text Analytics

The Text Analytics API is part of the Azure Cognitive Services suite of machine learning services that provides advanced natural language processing over raw text.  It can be used for sentiment analysis, language detection, key phrase extraction and entity recognition (such as PII).  

The new SDK supports [all the features](https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/overview) of the new v3.0 REST API for Text Analytics.  For example, you can detect the language that the text was written in, identify PII (personally identifiable information), extract key phrases, categorize concepts like places and people within the text, link to external sources (like Wikipedia or Bing) for disambiguation, and perform sentiment analysis.

To use the Text Analytics SDK, first create a client.  We'll use [C#](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/textanalytics/Azure.AI.TextAnalytics) for this months snippets, although the SDK is also available in [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/textanalytics/azure-ai-textanalytics), [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/textanalytics/azure-ai-textanalytics), and [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/textanalytics/ai-text-analytics).  To create a client:

```csharp
var endpoint = new Uri(myEndpoint);
var client = new TextAnalyticsClient(endpoint, new DefaultAzureCredential());
```

The `DefaultAzureCredentials()` object will use whatever credentials it can find.  If you are running the app on a local development workstation, it will use the user credentials from local development tools like Visual Studio.  If you are running the app in the Azure cloud, it will use the connected service principal.

Let's take a typical string and use the named entities API to obfuscate PII (Personally Identifiable Information) within a hypothetical logging method:

```csharp
var input = "SSN 555-55-5555, phone: 555-555-5555, some other info";

RecognizePiiEntitiesResult result = client.RecognizePiiEntities(input);
IReadOnlyCollection<NamedEntity> entities = result.NamedEntities;
var output = new StringBuilder(input);
foreach (var entity in entities) {
    var newText = new string('*', entity.Length);
    output.Replace(entity.Text, newText);
}
Console.WriteLine(output);
```

The output should be:

```text
SSN ***********, phone: ************, some other info
```

The PII has been replaced with something innocuous.  The SDK has both synchronous and asynchronous methods in all libraries, allowing you the flexibility to build your app in the way that you prefer.

Let's take a look at another use case - sentiment analysis.  Use sentiment analysis to find out what your customers think about the comments that they write in social media or other channels.  The API returns a score between 0 and 1 for each document.  This time, we will look at a Python example. As before, you need a client reference:

```python
from azure.ai.textanalytics import TextAnalyticsClient

endpoint = os.getenv("AZURE_TEXT_ANALYTICS_ENDPOINT")
api_key = os.getenv("AZURE_TEXT_ANALYTICS_KEY")
client = TextAnalyticsClient(endpoint = self.endpoint, credential=self.api_key)
```

With a reusable client, you can perform any of the text analytics operations:

```python
docs = [
    "This speaker was awesome.  The talk was very relevant to my work.",
    "How boring!  The speaker was monotone and put me to sleep!"
]

api_result = client.analyze_sentiment(docs)
results = [doc for doc in api_result if not doc.is_error]

for idx, s in enumerate(results):
  print("Sentiment = {} for doc {}".format(s.sentiment, docs[idx]))
```

This gives you an idea of how easy sentiment analysis is to implement, but there is much more power there.  For example, you can do per-sentence sentiment analysis.  

Be sure to check out all the samples for Text Analytics and let us know what you think!  You can find samples for [.NET](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/textanalytics/Azure.AI.TextAnalytics), [Java](https://github.com/Azure/azure-sdk-for-java/blob/master/sdk/textanalytics/azure-ai-textanalytics/src/samples/README.md), [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/textanalytics/ai-text-analytics/samples), and [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/textanalytics/azure-ai-textanalytics/samples).

## Working with us and giving feedback

So far, the community has filed hundreds of issues against these new SDKs with feedback randing from documentation issues to API surface area change requests to pointing out failure cases.  Please keep that coming.  We work in the open on GitHub and you can submit issues here:

* [API design guidelines](https://github.com/Azure/azure-sdk/)
* [.NET](https://github.com/Azure/azure-sdk-for-net)
* [Java](https://github.com/Azure/azure-sdk-for-java)
* [JavaScript / TypeScript](https://github.com/Azure/azure-sdk-for-js)
* [Python](https://github.com/Azure/azure-sdk-for-python)

Finally, please keep up to date with all the news about the Azure developer experience programs and let us know how we are doing by following [@azuresdk](https://twitter.com/AzureSDK).
