---
title: The AI-powered document extraction Azure SDK library.
layout: post
date: 2020-05-18
sidebar: releases_sidebar
author_github: savaity
repository: azure/azure-sdk
---

Ever wondered the evolution of computer-assisted data entry and how it slowly took away the need for manual intervention in data entry procedures?

As part of this digital transformation, the customers felt the need to have an AI solution to reduce the cost of converting paper/digital documents (invoices, receipts, business cards, etc.) into structured data for subsequent processing. The AI solution that Azure has to offer being, Azure Form Recognizer. Azure Form Recognizer is a cognitive service that uses machine learning technology to identify and extract key-value pairs and table data from form documents. It then outputs structured data that includes the relationships in the original file.
Not just assiting with data entry, but Form recognizer could offer more with optimizing the auditing needs of customer to make informed business decisions by learning from their expense trends or aiding with document matching for platforms dealing with digital records.

![]({{ site.base_url }}{% link images/posts/05182020-image1.png %})

Lets take an example to understand how a customer might want to use Form Recognizer Azure service to populate expense fields from receipt url as part of an expense maintianing data entry app.

The expense entry app user, would provide a receipt Url for which they want to recognize the relevant expense field information. The underlying Azure SDK client library then feeds this document to the [Form Recognizer](https://docs.microsoft.com/en-us/azure/cognitive-services/form-recognizer/). Although you can use any of our languages for this ([.NET](https://github.com/azure/azure-sdk-for-net), [Python](https://github.com/azure/azure-sdk-for-python), [Java](https://github.com/azure/azure-sdk-for-java), or [JavaScript/TypeScript](https://github.com/azure/azure-sdk-for-js)), we will be using Java for the examples today.

## Recognize expense fields from receipt

The Form Recognizer recognize receipt API includes a pretrained model for reading English sales receipts from the United States — the type used by restaurants, gas stations, retail. This model extracts key information such as the time and date of the transaction, merchant information, amounts of taxes and totals and more. In addition, the prebuilt receipt model is trained to recognize and return all of the text on a receipt.

```java
public class AnalyzeDataApp {
  private final FormRecognizerClient formRecognizerClient;

  public AnalyzeDataApp(String apiKey, String endpoint) {
    this.formRecognizerClient = new FormRecognizerClientBuilder()
      .credential(new AzureKeyCredential(apiKey)))
      .endpoint(endpoint)
      .buildAsyncClient();
  }
}
```
Let's create a method that exports/prints out the recognized receipt information.

```java
  public recognizeExpenseFields(String receiptUrl) {
    // Use the receiptUrl provided by the user
    SyncPoller<OperationResult, IterableStream<RecognizedReceipt>> recognizeReceiptPoller = this.formRecognizerClient.beginRecognizeReceiptsFromUrl(receiptUrl);
    // Wait for the poller to complete and get the final result
    IterableStream<RecognizedReceipt> receiptPageResults = recognizeReceiptPoller.getFinalResult();

    // Iterate over each page of the receipt
    receiptPageResults.forEach(recognizedReceipt -> {
      System.out.println("----------- Recognized Receipt -----------");
      // Get the receipt information for a US Receipt  
      USReceipt usReceipt = ReceiptExtensions.asUSReceipt(recognizedReceipt);
      System.out.printf("Merchant Name: %s, confidence: %.2f%n", usReceipt.getMerchantName().getFieldValue(), usReceipt.getMerchantName().getConfidence());
      System.out.printf("Merchant Address: %s, confidence: %.2f%n", usReceipt.getMerchantAddress().getName(), usReceipt.getMerchantAddress().getConfidence());
      // Each extracted value is returned with a confidence value, to highlight specific ones that might need more attention
      System.out.printf("Merchant Phone Number %s, confidence: %.2f%n", usReceipt.getMerchantPhoneNumber().getFieldValue(), usReceipt.getMerchantPhoneNumber().getConfidence());
      System.out.printf("Total: %s confidence: %.2f%n", usReceipt.getTotal().getName(), usReceipt.getTotal().getConfidence());
      // Get hold of the itemized data, if present
      System.out.printf("Receipt Items: %n");
      usReceipt.getReceiptItems().forEach(receiptItem -> {
        if (receiptItem.getName() != null) {
            System.out.printf("Name: %s, confidence: %.2f%n", receiptItem.getName().getFieldValue(), receiptItem.getName().getConfidence());
        }
        if (receiptItem.getQuantity() != null) {
            System.out.printf("Quantity: %s, confidence: %.2f%n", receiptItem.getQuantity().getFieldValue(), receiptItem.getQuantity().getConfidence());
        }
        if (receiptItem.getPrice() != null) {
            System.out.printf("Price: %s, confidence: %.2f%n", receiptItem.getPrice().getFieldValue(), receiptItem.getPrice().getConfidence());
        }
        if (receiptItem.getTotalPrice() != null) {
            System.out.printf("Total Price: %s, confidence: %.2f%n", receiptItem.getTotalPrice().getFieldValue(), receiptItem.getTotalPrice().getConfidence());
        }
      });
      System.out.print("-----------------------------------");
    });
  }
```

Further, to help the customers with additional manual validation steps the API could return raw bounding box information to highlight the location of the recognized expense fields. Much advanced integrated solutions could be built by using this library, to handle specific solution requirements of the customer.
Let's now look at example how a customer might want to use this library for interpreting form document data into usable structured data.

## Recognize text and layout information using the Form Recognizer

Form Recognizer can also extract text and table structure (the row and column numbers associated with the text) using high-definition optical character recognition (OCR). The resultant data contains each line of text and its corresponding bounding box placement on the form page document. It also returns the tabular data found on page with each of the cell field information with its corresponding row-column coordinate.

Let's create a method that exports/prints out the recognized layout information.

```java
  public recognizeFormTextLayout() {
    // Use the formUrl provided by the user
    SyncPoller<OperationResult, IterableStream<FormPage>> recognizeContentPoller = this.formRecognizerClient.beginRecognizeContent(formUrl);
    // Wait for the poller to complete and get the final result
    IterableStream<FormPage> contentPageResults = recognizeLayoutPoller.getFinalResult();

    // Iterate over each page of the form
    contentPageResults.forEach(formPage -> {
      // Display the page metdata
      System.out.println("----Recognizing content ----");
      System.out.printf("The form page has width: %s and height: %s, measured with unit: %s%n", 
        formPage.getWidth(),
        formPage.getHeight(),
        formPage.getUnit());
      // Display recognized table information from the form  
      formPage.getTables().forEach(formTable -> {
        System.out.printf("The recognized table has %s rows and %s columns.%n", 
          formTable.getRowCount(),
          formTable.getColumnCount());
        formTable.getCells().forEach(formTableCell -> {
          final StringBuilder boundingBoxInfo = new StringBuilder();
          if (formTableCell.getBoundingBox() != null) {
            formTableCell.getBoundingBox().getPoints().forEach(point ->
              boundingBoxInfo.append(String.format("[%.2f, %.2f]", point.getX(), point.getY())));
          }
          // Each cell text data with corresponding box information
          System.out.printf("this cell has text %s, within bounding box %s.%n", formTableCell.getText(),
            boundingBoxInfo);
        });
        System.out.println();
      });
    });
  }
```

The Form Recognizer client library, can further be extended to provide completely customized and tailored data. It allows users to train models using their own data forms and then use those trained models for recognizing customized data!
For starters, the user needs to provide a set of five input forms that should be used for training the model. 
The custom training model API's additionally provide user convenience of training the models with or without labeled data. 

## Custom model training with Labels
Custom models built using labeled data, does supervised learning to extract keys/value pairs of interest, using the labeled data information provided by the user. The process of labeling of data undergoes steps of creating tags/labels for text elements that you would want the model to recognize. The returned customized model results in better-suited model for the custom form at hand and also further can be used to produce models for more complex forms.
Let's see an example of how to train a custom model and recognize form using that model.

```java
  public recognizeFormTextLayout(String trainingFilesUrl, String analyzeFileUrl) {
    // Set to true to use labeled data when training
    boolean useTrainingLabels = true;
    SyncPoller<OperationResult, CustomFormModel> trainingPoller = client.beginTraining(trainingFilesUrl, useTrainingLabels);

    // Wait for the poller to complete and get the final result
    CustomFormModel customFormModel = trainingPoller.getFinalResult();

    // Model Info
    System.out.printf("Model Id: %s%n", customFormModel.getModelId());
    System.out.printf("Model Status: %s%n", customFormModel.getModelStatus());
    // Since the data is labeled, we are able to return the accuracy of the model
    customFormModel.getSubModels().forEach(customFormSubModel -> {
      // Improve model accuracy by labeling additional forms 
      System.out.printf("Sub-model accuracy: %.2f%n", customFormSubModel.getAccuracy());
    });
    
    // Use the above custom trained model 
    String modelId = customFormModel.getModelId();
    SyncPoller<OperationResult, IterableStream<RecognizedForm>> recognizeFormPoller = this.formRecognizerClient.beginRecognizeCustomFormsFromUrl(analyzeFileUrl,       modelId);

    // Wait for the poller to complete and get the final result
    IterableStream<RecognizedForm> recognizedForms = recognizeFormPoller.getFinalResult();

    recognizedForms.forEach(form -> {
      System.out.println("----------- Recognized Form -----------");
      form.getFields().forEach((label, formField) -> {
        // examine the confidence values for each of the applied tags in the labeling process
        System.out.printf("Field %s has value %s with confidence score of %.2f.%n", 
          label,
          formField.getFieldValue(),
          formField.getConfidence());
      });
      System.out.print("-----------------------------------");
    });
  }
```
## Custom model training without Labels
This feature allows customers to submit their input forms, without requiring labeling process steps. The underlying algorithm clusters the forms by type, discovers what keys and tables are present, and associates values to keys and entries to tables.

The API differentiates unlabeled and labeled training of models with the presence of boolean parameter `useTrainingLabels` If `useTrainingLabels = false` the `beginTraining` API performs model training without labels.

## Managing Account/ Management API?
// Should be mentioned?

## Further documentation

Take a look at the [Form Recognizer](https://docs.microsoft.com/en-us/azure/cognitive-services/form-recognizer/) documentation, and the API reference for the `FormRecognizerClient` (in [.NET](https://azure.github.io/azure-sdk-for-net/formrecognizer.html), [Java](https://azure.github.io/azure-sdk-for-java/formrecognizer.html), [JavaScript](https://azure.github.io/azure-sdk-for-js/formrecognizer.html), and [Python](https://azure.github.io/azure-sdk-for-python/ref/Form-Recognizer.html)).

## Want to hear more?

Follow us on [Twitter at @AzureSDK](https://twitter.com/AzureSDK). We'll be covering more best
practices in cloud-native development as well as providing updates on our progress in developing the next generation of Azure SDKs.
