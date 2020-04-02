---
title: Real-time data processing with EventProcessorClient
layout: post
date: 07 April 2020
sidebar: releases_sidebar
author_github: conniey
repository: azure/azure-sdk
---

## Real-time data processing with EventProcessorClient

I have multiple hydroponic facilities for growing vegetables. These vegetables are very fickle and
grow under the right conditions. In my facilities, there are hundreds of IoT devices, transmitting
temperature, humidity, and carbon dioxid (CO2) information. Manually fetching the data from my
devices, aggregating it, and then analyzing it is cumbersome and time-consuming. [Azure Event
Hubs](https://azure.microsoft.com/services/event-hubs/) streamlines this process by being able to
receive and process millions of events per second.

Event Hubs enables high throughput using a partitioned consumer model. Each consumer receives data
from a single partition or a subset of the larger message stream. Because of this, there are
performance considerations for how I publish data to Event Hubs for downstream consumers. I want
different measurements to go to separate partitions so that they can be analyzed by different
receivers concurrently.

I have limited bandwidth in my facilities and am conscious of how noisy my network is. Consequently,
I decided to send my events in batches using `EventDataBatch`. Each `EventDataBatch` can contain
hundreds of events that when transmitted through the system, is a single AMQP message.

For the sake of simplicity, I extracted a sample of code that would run on my IoT devices to send
temperature information. The code for publishing Humidity and CO2 measurements are similar, but
would create batches with partition id set to "1" and "2", respectively.

```java
import com.azure.core.credential.TokenCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.messaging.eventhubs.*;
import com.azure.messaging.eventhubs.models.CreateBatchOptions;
import com.conniey.Temperature;
import com.conniey.TemperatureUnit;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Random;

private void sendTemperature(String fullyQualifiedNamespace, String eventHubName) throws Exception {
    Random random = new Random();
    ObjectMapper serializer = new ObjectMapper();
    TokenCredential credential = new DefaultAzureCredentialBuilder()
            .build();

    // Create a client that can publish messages to an Event Hub.
    EventHubProducerClient sender = new EventHubClientBuilder()
            .credential(fullyQualifiedNamespace, eventHubName, credential)
            .buildProducerClient();

    // I want all of my temperature information to go to partition "0".
    // Humidity and CO2 measurements go to partition "1" and "2", respectively.
    CreateBatchOptions batchOptions = new CreateBatchOptions()
            .setPartitionId("0");

    EventDataBatch currentBatch = sender.createBatch(batchOptions);

    // For the sake of this demo, I have a for-loop. In a IoT device, this
    // may be an event loop that runs on a timer.
    for (int i = 0; i < 100; i++) {
        double temp = random.nextDouble() * 100.00;
        Temperature measurement = new Temperature(temp, TemperatureUnit.CELSIUS);
        String json = serializer.writeValueAsString(measurement);

        // Events contain an opaque series of bytes. To understand what these
        // bytes represent in my aggregator, I add some application properties such as
        // "measurement-type" and "content-type".
        EventData eventData = new EventData(json.getBytes());
        eventData.getProperties().put("measurement-type", "temperature");
        eventData.getProperties().put("content-type", "json");

        // If the event does not fit in a batch, that means the batch is full, so
        // we send it and create another batch.
        if (!currentBatch.tryAdd(eventData)) {
            sender.send(currentBatch);
            currentBatch = sender.createBatch(batchOptions);

            // Add the one that did not fit.
            currentBatch.tryAdd(eventData);
        }
    }
}
```

Sending data to Event Hubs is one part of the equation; the second part is analyzing that data.
Luckily, Event Hubs supports streaming data to data analyzers and aggregators. Leveraging the Java
client library for Event Hubs, we can quickly analyze that data using `EventProcessorClient`.
`EventProcessorClient` is a production-ready, load balancing, data processor.

Below is an overview of how `EventProcessorClient` is instantiated. At any time, there could be
millions of events in my message stream; it would be inefficient to browse through all the messages
until I find where I left off. Also, I don't want to start processing events from the beginning when
I run my aggregator app. To solve this problem, `EventProcessorClient` supports persisting
checkpoint information through the `CheckpointStore` interface. An implementation exists using Azure
Blob Storage, but we can plug in any storage mechanism that implements that interface.

```java
import com.azure.core.credential.TokenCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.messaging.eventhubs.*;
import com.azure.messaging.eventhubs.checkpointstore.blob.BlobCheckpointStore;
import com.azure.messaging.eventhubs.models.*;
import com.azure.storage.blob.*;

public void createAndRunProcessor() throws Exception {
    String fullyQualifiedNamespace, String eventHubName = "my-event-hub-name";
    TokenCredential credential = new DefaultAzureCredentialBuilder()
            .build();

    BlobContainerAsyncClient blobContainer = new BlobContainerClientBuilder()
            .credential(credential)
            .containerName("telemetry-checkpoints")
            .buildAsyncClient();

    CheckpointStore checkpointStore = new BlobCheckpointStore(blobContainer);
    EventProcessorClient processor = new EventProcessorClientBuilder()
            .credential(fullyQualifiedNamespace, eventHubName, credential)
            .consumerGroup("$DEFAULT")
            .checkpointStore(checkpointStore)
            .processEvent(eventContext -> {
                onReceivedEvent(eventContext);
            })
            .processError(errorContext -> onError(errorContext))
            .processPartitionClose(closeContext -> onPartitionClose(closeContext))
            .buildEventProcessorClient();

    processor.start();

    System.out.println("Processing telemetry. Press any key to exit.");
    System.in.read();
    System.out.println("Stopping");

    processor.stop();
}
```

There are four callbacks I can set in `EventProcessorClientBuilder`. The most important one is
`processEvent(Consumer<EventContext>)`. This callback is invoked every time an event is received. It
contains information about the partition this `EventData` is in. More importantly, it exposes a
couple of methods you can use to persist information about what you have processed via
`EventContext.updateCheckpoint()`.

It would be very costly to checkpoint every time I receive an event. I would be making thousands of
network calls to Azure Blob Storage. To decrease my network costs and traffic, I keep a tally of how
many events I have received; I checkpoint every 50 messages and when my client loses ownership of
that partition. By saving checkpoints, it keeps me from reprocessing the same telemetry points.

```java
import com.azure.messaging.eventhubs.models.*;
import com.conniey.models.Temperature;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.concurrent.atomic.AtomicReference;

public class TemperatureProcessingSnippet {
    private final ObjectMapper serializer = new ObjectMapper();
    private final AtomicReference<EventContext> lastEvent = new AtomicReference<>();

    private Instant lastReported = Instant.EPOCH;
    private long numberProcessed = 0;

    public void onTemperatureEvent(EventContext context) {
        Instant enqueuedTime = context.getEventData().getEnqueuedTime();
        if (enqueuedTime.isAfter(lastReported)) {
            lastReported = enqueuedTime;
        }

        byte[] body = context.getEventData().getBody();
        Temperature temperature;
        try {
            temperature = serializer.readValue(body, 0, body.length, Temperature.class);
        } catch (IOException e) {
            System.err.printf("Unable to deserialize value. Error: %s%n", e);
            return;
        }

        // Extract information from Temperature like highest and lowest temp.

        lastEvent.set(context);
        long processed = numberProcessed++;
        if ((processed % 50) == 0) {
            context.updateCheckpoint();
        }
    }

    public void onPartitionClose(CloseContext closeContext) {
        System.out.println("Partition has been lost: " + closeContext.getCloseReason());

        // Check the last context and if we haven't checkpointed it, then do so.
        EventContext lastEventContext = lastEvent.get();
        if (lastEventContext != null && (numberProcessed % 50) != 0) {
            lastEventContext.updateCheckpoint();
        }

        // Persist current aggregated information so we pick up where we stopped.
        Statistics statistics = new Statistics(minTemperature, maxTemperature, lastReported);
    }
}
```

I have plans to add hundreds of IoT devices to my facilities and measure additional parameters. My
single PC running my aggregator application may not be enough to analyze all that data. By using
`EventProcessorClient` to process my data, if I bundle my app and run instances of it on different
machines, it will load-balance the Event Hub partitions between my devices!

The full source code is on [GitHub](https://github.com/conniey/weather-app).

## Want to hear more?

Follow us on [Twitter at @AzureSDK](https://twitter.com/AzureSDK). We'll be covering more best
practices in cloud-native development as well as providing updates on our progress in developing the
next generation of Azure SDK.

Contributors to this article: _Connie Yau_.
