---
title: Process data in real-time with Java and Azure Event Hubs
layout: post
date: 07 April 2020
sidebar: releases_sidebar
author_github: conniey
repository: azure/azure-sdk
---

In my position with the Azure SDK team, I'm fortunate to talk to a lot of customers about their needs.  Most applications can be categorized into big buckets where we can see the same design patterns repeated.  One of those categories is data processing.  Let's take an example.  A farm needs to understand the micro-climate weather patterns across the land under management.  This allows them to predict where they should water their crops more, and where the best grazing for their animals are, among other things.  To do that, they set up small weather stations at regular intervals.  The weather stations send their data to "the cloud" for processing and display.

How might this work?

![]({{ site.base_url }}/images/posts/04072020-image1.png)

Each base station has a number of feeds from the instruments, each of which could provide information at different rates.  This is all fed into an [Azure Event Hub](https://azure.microsoft.com/services/event-hubs/).  Azure Event Hubs are a scalable messaging system primarily used for data ingestion, allowing you to analyze millions of data points.  You could use the same system for analyzing marketing data coming from a mobile application, shopping data coming from the scanners at a grocery store, or security devices monitoring millions of homes.  We've learned a few things about this, and have come up with some best practices to follow.  Although you can use any of our languages for this (.NET, Python, Java, or JavaScript/TypeScript), we will be using Java for the examples today.

## Send data in batches most of the time

In a data ingestion pipeline, individual components that are sending data often have more resources available than the central receiver has, so you want to optimize the pipeline to ensure the central receiver is doing less work.  This means sending data in batches.  Data is sent to an Event Hub using [AMQP](https://en.wikipedia.org/wiki/Advanced_Message_Queuing_Protocol), which provides for batching in the protocol.

Applications using Event Hubs are split into producers (the app that sends data) and consumers (the app that receives data).  Take a look at this example:

```java
public class TemperatureSender {
  private final EventHubProducerClient sender;
  private final ObjectMapper serializer = new ObjectMapper();
  private final TemperatureDevice device;

  public TemperatureSender(String namespace, String hubName, TemperatureDevice device) {
    TokenCredential credential = new DefaultAzureCredentialBuilder().build();
    this.sender = new EventHubClientBuilder()
      .credential(namespace, hubName, credential)
      .buildProducerClient();
    this.device = device;
  }

  // Rest of the class
}
```

This is a fictitious class that will send temperature data from a connected device to the Event Hub.  You specify the Event Hub namespace and name (both obtained when provisioning the Event Hubs) to configure the connection.  The rest of the class code is below.

The `TemperatureDevice` class (not shown) is responsible for reading data from the device.  How do we send data?  Let's create a method that reads a temperature and stores it in a batch.
When the batch is full, it will send the data to the Event Hub.

```java
    private EventDataBatch currentBatch = null;

    public sendTemperatureData() {
      // Get the temperature from the device
      Temperature measure = this.device.getTemperature();
      // Serialize the temperature as a string value
      String json = this.serializer.writeValueAsString(measure);

      // Events contain an opaque series of bytes.  To understand what these bytes
      // represent, add some application properties to the event.
      EventData eventData = new EventData(json.getBytes());
      eventData.getProperties().put("measurement", "temperature");
      eventData.getProperties().put("content-type", "application/json");

      // Batch options are needed to set the partition ID
      CreateBatchOptions batchOptions = new CreateBatchOptions();

      // No batch?  Create one
      if (currentBatch == null) {
        this.currentBatch = this.sender.createBatch(batchOptions);
      }

      // Attempt to add to the batch - if the item does not fit, then the batch
      // is full, so send it, then create a new batch.
      if (!this.currentBatch.tryAdd(eventData)) {
        this.sender.send(this.currentBatch);
        this.currentBatch = this.sender.createBatch(batchOptions);

        // Add the item that didn't fit.
        this.currentBatch.tryAdd(eventData);
      }
    }

    public flushData() {
      this.sender.send(this.currentBatch);
      this.currentBatch = null;
    }
```

You can call the `sendTemperatureData()` as many times and as often as you want.  It will batch up the event data and send it to a particular partition.

Of course, you can send a single event, and there are times you want to do that.  Consider, for example, when a burglar breaks a window in a secured home.  You wouldn't want to wait for a full batch to send that data.

## Use multiple partitions

Event Hub data is stored in a specific partition. Multiple producers can write to the same partition, but there can only be one consumer listening to a partition at any given time.  You can decide on what partitioning strategy works for you - either send related data to the same partition so it can be processed by the same processor, or use round-robin to spray the data to multiple partitions such that processors get a portion of the stream of data.  Partitions allow you to process more data in parallel by providing more processors.

In our example above, the sender selects the partition to send an event batch to in a round-robin basis, thus spreading the load between all partitions.  You can select a specific partition by using `.setPartitionId()` on the `CreateBatchOptions`.  Partition IDs are strings and set by the service.  Get the list of partition Ids using `this.sender.getPartitionIds()`.

## Use the EventProcessorClient

Now that the data we want to process is in the Event Hub, it's time to look at processing it.  Let's think about what you have to think about when processing events:

1. The event processor (like all cloud-native services) can be restarted at any point, so you must build in resiliency.
2. You don't want to repeatedly process the same events by starting from the beginning of the stream each time, so you must record a checkpoint every now and then.
3. Even though data is sent in batches, the batch sizes may vary.  Your processing strategy may be different from your sending strategy.

Most of the time, you will want to use the `EventProcessorClient`.  There is a low-level client that interacts directly with the AMQP transport protocol.  However, this is not recommended unless you have a significant concern about latency and want to control when and how many event you pull from the Event Hub.

The `EventProcessorClient` is a higher-level construct wrapping the low-level client.  It does all the "boiler-plate" event management for you; for example, coordinating processing between multiple hosts, allowing other processor clients to "take over" if you need to move the processing to another host (for example, to support zero-down-time upgrades), and storing checkpoint information.

Let's look at an example.  The event processor consists of a "main" method that sets up and runs the `EventProcessorClient`, and an event processing client.  In this instance, we are going to checkpoint after we have processed 25 events.  If the `EventProcessorClient` is shut down in the middle of a batch of 25 events, some events will get reprocessed.  On the other hand, checkpointing after every event is a significant overhead.

```java
public class TemperatureProcessor {
  private final ObjectMapper serializer = new ObjectMapper();
  private final AtomicReference<EventContext> lastEvent = new AtomicReference<>();
  private long numProcessed = 0;

  public void onReceiveEvent(EventContext context) {
    byte[] body = context.getEventData().getBody();
    Temperature temperature;
    try {
      temperature = serializer.readValue(body, 0, body.length, Temperature.class);
    } catch (IOException e) {
      System.err.printf("Unable to deserialize temperature: %s%n", e);
      return;
    }

    // You can now do any processing of temperature you want.

    // Deal with checkpointing.
    lastEvent.set(context);
    numProcessed++;
    if ((numProcessed % 25) == 0) {
      context.updateCheckpoint();
    }
  }

  public void onPartitionClose(CloseContext closeContext) {
    System.out.println("Partition has been lost: " + closeContext.getCloseReason());

    // If we need to checkpoint, now is the time!
    EventContext lastContext = lastEvent.get();
    if (lastContext != null && (numProcessed % 25) != 0) {
      lastContext.updateCheckpoint();
    }

    // Persist any aggregate information if needed.
  }
}
```

As you can see from this, we aren't doing much over and above the processing of each event.  A lot of the work dealing with the Event Hub happens for us.  To set up the `EventProcessorClient`, we need to tell it how to process events and where to store checkpoints:

```java
public void runEventProcessorClient() throws Exception {
  String namespace = "fill-this-in";
  String eventHubName = "fill-this-in";

  // This is the credentials we use to connect to both Event Hubs and Storage
  TokenCredential credential = new DefaultyAzureCredentialBuilder().build();

  // This is the TemperatureProcessor
  TemperatureProcessor eventProcessor = new TemperatureProcessor();

  // Set up an Azure Storage Blob checkpoint store
  BlobContainerAsyncClient blobContainer = new BlobContainerClientBuilder()
    .credential(credential)
    .containerName("telemetry-checkpoints")
    .buildAsyncClient();
  CheckpointStore checkpointStore = new BlobCheckpointStore(blobContainer);

  // Configure the EventProcessorClient
  EventProcessorClient processor = new EventProcessorClientBuilder()
    .credential(namespace, eventHubName, credential)
    .consumerGroup("$DEFAULT")
    .checkpointStore(checkpointStore)
    .processEvent(eventContext -> {
      eventProcessor.onReceiveEvent(eventContext);
    })
    .processError(errorContext -> {
      System.err.println("EventProcessorClient Error: " + errorContext.getThrowable());
    })
    .processPartitionClose(closeContext -> {
      eventProcess.onClosePartition(closeContext);
    })
    .buildEventProcessorClient();

  // Start processing events.  This will terminate any processors that are
  // processing events on the same partition.
  processor.start();

  System.out.println("Processing telemetry. Press any key to exit.");
  System.in.read();
  System.out.println("Stopping");

  processor.stop();
}
```

In this case, we are using a shared container on Azure Blob Storage to store the checkpoint information for a partition.  You could implement your own checkpoint store to store the data in a database, Redis, or some other storage mechanism.

The `EventProcessorClient` is asynchronous, so you need to wait around while it is processing.  If you were doing this in a "real" implementation, you could set up a loop that checks an `AtomicBoolean` to see if it should stop.  Another asynchronous method could set this to signal that processing should stop.

## Run one EventProcessorClient per partition

If you don't have much data going through the Event Hub, you can have one processor handle all the data, which is what our example code above does.  However, as your system grows, you will want to scale.  A best practice is to ensure you have one `EventProcessorClient` running per partition.

Let's say you have an Event Hub with six partitions.  When you start the first `EventProcessorClient`, it will start processing data from all six partitions.  When you start the second `EventProcessorClient`, the two `EventProcessorClient` processes will attempt to load balance the partitions between them by coordinating via the checkpoint store.  In the steady state, they will each be receiving data from three partitions.

The best case for scalability is to have the same number of `EventProcessorClient` processes running as partitions.

## Further reading

Take a look at the [Event Hubs](https://docs.microsoft.com/azure/event-hubs/) documentation, and the API reference for the `EventProcessorClient` (in [.NET](https://azure.github.io/azure-sdk-for-net/eventhub.html), [Java](https://azure.github.io/azure-sdk-for-java/eventhubs.html), [JavaScript](https://azure.github.io/azure-sdk-for-js/eventhub.html), and [Python](https://azure.github.io/azure-sdk-for-python/ref/Event-Hub.html)).  The full source code for the an example project is on [GitHub](https://github.com/conniey/weather-app).

## Want to hear more?

Follow us on [Twitter at @AzureSDK](https://twitter.com/AzureSDK). We'll be covering more best
practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDKs.

Contributors to this article: _Connie Yau_.
