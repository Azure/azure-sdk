# Azure SDK and Connection Pooling

To build a scalable applications it's important to understand how your downlevel dependencies scale and what limitations you can hit.

The majority of Azure services expose functionality over HTTP REST APIs. Azure SDKs in turn wrap the HTTP communication into an easy-to-use set of client and model types.

Every time you call a method on a `Client` class an HTTP request is sent to the service. Sending an HTTP request requires a socket connection to be established between client and the server. Establishing a connection is an expensive operation that might sometimes take longer than processing of the request itself. To combat this, .NET maintains a pool of HTTP connections that can be reused instead of opening a new one every time.

This post details specifics of HTTP Connection pooling based on the .NET runtime you are using and ways to tune it to make sure connection limits don't negatively affect your application performance.

## .NET Framework

Connection pooling on .NET framework is controlled by the [ServicePointManager](https://docs.microsoft.com/dotnet/api/system.net.servicepointmanager) class and the most important fact to remember is that the pool, by default, is limited to **2** connections to a particular endpoint (host+port pair) in non-web applications, and to **10** connection per endpoint in ASP.NET applications. After the maximum number of connections is reached HTTP requests would be queued until one of the existing connections becomes available again.

Imagine writing a console applications that uploads files to Azure Blob Storage. To speed up the process you decided to upload using 20 parallel threads. The default connection pool limit means that even though you have 20 [BlockBlobClient.UploadAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blockblobclient.uploadasync) calls running in parallel only 2 of them would be actually uploading data and the rest would be stuck in the queue.

**NOTE:** The connection pool is centrally managed on .NET Framework. This means that every instance of HttpClient or HttpWebRequest uses the same common pool.

## Symptoms of connection pool starvation

There are 3 main symptoms of connection pool starvation:

1. Timeouts in the form of `TaskCancelledException`
2. Latency spikes under load
3. Low throughput

Every outgoing HTTP request has a timeout associated with it (typically 100 seconds) and the time waiting for a connection is counted towards the timeout. If no connection becomes available after the 100 seconds elapse the SDK call would fail with a `TaskCancelledException`.

**NOTE:** because most Azure SDKs are set up to retry intermittent connection issues they would try sending the request multiple times before surfacing the failure so it might take a multiple of default timeout to see the exception raised.

Long-running requests with larger payloads or on slow network connection are more susceptible to timeout exceptions because they typically occupy connections for a longer time.

Another less obvious symptom of a thread pool starvation is latency spikes. Let's take a web application that typically serves around 10 customers at the same time. Because most of the time the connection requirement is under or just near the limit it's operating with optimal performance. But the client count raising might causes it to hit the connection pool limit and makes parallel request compete for a limited connection pool resources increasing the response latency.

Low throughput in parallelized workloads might be another symptom. Let's take the console application we've discussed in the previous part. Considering that the local disk and network connection is fast and a single upload doesn't saturate the entire network connection adding more parallel uploads should increase network utilization and improve the overall throughput. But if application is limited by the connection pool size it won't happen.

## Avoid orphaned response streams

Another way to easily starve the connection pool is by not disposing unbuffered streams returned by some client SDK methods.

Most Azure SDK client methods would buffer and deserialize the response for you. But some methods operate on large blocks of data - that are impractical to fully load in memory - and would return an active network stream allowing data to be read and processed in chunks.

These methods would have the stream as part of the `Value` inside the `Response<T>`. One common example of such a method is the [BlockBlobClient.DownloadAsync](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.specialized.blobbaseclient.downloadasync) that returns `Response<DownloadInfo>` and [`BlobDownloadInfo`](https://docs.microsoft.com/dotnet/api/azure.storage.blobs.models.blobdownloadinfo) having a `Content` property.

Each of these streams represents a network connection rented out from the pool and they are only returned when disposed or read to the end. By not doing that you are "burning" connections forever decreasing the pool size. This can quickly lead to a situation where there are no more connections to use for sending requests and all of the requests fail with a timeout exception.

## Changing the limits

You can use app/web.config files to change the limit or do it in code. It's also possible to change the limit on per-endpoint basis.

``` C#
ServicePoint servicePoint = ServicePointManager.FindServicePoint(new Uri("http://www.contoso.com/"));
servicePoint.ConnectionLimit = 40;

ServicePointManager.DefaultConnectionLimit = 20;
```

```xml
<configuration>
  <system.net>
      <connectionManagement>
          <add address="http://www.contoso.com" maxconnection="40" />
      <add address="*" maxconnection="20" />
          </connectionManagement>
      </system.net>
  </configuration>
```

We recommend setting the limit to a maximum number of parallel request you expect to send and load testing/monitoring your application to achieve the optimal performance.

**NOTE:** Default limits are applied when the first request is issued to a particular endpoint. After that changing the global value won't have any effect on existing connections.

## .NET Core

There was a major change around connection pool management in .NET Core. Connection pooling happens on HttpClient level and the pool size is not limited by default. This means that HTTP connections would be automatically scaled to satisfy your workload and you shouldn't be affected by issues described in this post.
