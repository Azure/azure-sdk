We expect all Azure SDKs to go through rigorous APIs reviews similar to those condacted for all .NET APIs. 
It critical that the review is conducted early enough to allow time for fixes,
and sometimes significant API redesign based on the review feedback. 
If you have never not participated in Azure SDK API review, 
we recommend that you schedule a pre-review (consulting session) before you start working on the APIs. 

Note: Azure SDK Reviews are not REST API (nor swagger) reviews. We review language-specific SDK APIs.
In particular, we review .NET, Python, Java, JavaScript APIs.

## What to Prepare for a Review
To conduct a review, we need the following things from the owners of the SDK:
1. Link to the service documentation/specification.
2. Link to the sericce's REST APIs, if aplicable/avaliable
3. Several code samples showing how the SDK is meant to be used by the customers. An example of a good set of usage samples can be found [here](https://github.com/dotnet/corefx/issues/32588).
4. Listing of the APIs. See below for example and tools to generate it.
5. If the SDK is already prototyped, dlls/packages/etc with the prototype implementation

## API Listings
During API reviews, we look at API usage samples (as discussed above) and at detailed API lisiting. 
You can see an example of such listing [here](https://github.com/Azure/azure-sdk/blob/master/docs/design/APIListingExampleDotNet.md).

If you have a prototype of your APIs, depending on the language the APIs are for, you can possibly generate the API listing.

- If the API is a .NET APIs, use API Reviewer Tool at file://///fxcore//tools//docs//ApiReviewer.html
- If the API is a Python API, use TBD
- If the API is a JavaScript API, use TBD
- If the API is a Java API, use TBD

If you don't have a prototype, you surely have the design spec on papaer :-)

## See Also
1. [CoreFx API Review Process](https://github.com/dotnet/corefx/blob/master/Documentation/project-docs/api-review-process.md)
