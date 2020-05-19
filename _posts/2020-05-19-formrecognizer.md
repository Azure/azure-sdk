---
title: "Introducing Form Recognizer client library: AI-powered document extraction"
layout: post
date: 2020-05-19
sidebar: releases_sidebar
author_github: savaity
repository: azure/azure-sdk
---

Data entry is boring. We all hate it, but one team in Azure Cognitive Service decided we needed a better way that can take away the need to manually enter data. As part of a digital transformation, users can leverage an AI solution to automate and reduce the cost of converting documents (such as invoices and receipts) and forms into structured data for further processing.
[Azure Form Recognizer](https://aka.ms/form-recognizer/) is an Azure Cognitive Service focused on using machine learning to identify and extract text, key-value pairs and tables data from documents. Applications for Form Recognizer service can extend beyond just assisting with data entry. It could also be used in integrated solutions for optimizing the auditing needs of users, letting them make informed business decisions by learning from their expense trends or matching documents with digital records.

Let's take an example to understand how a user might want to use Azure Form Recognizer to populate expense fields from receipt as part of an expense maintaining data entry app. This could be a web or mobile app using the Form Recognizer client library internally to interact with the service.
The user of the app can provide a URL to a receipt or choose to upload file data for the document which they want to recognize expense field information. Let's use a document URL for the examples below. The underlying client library then feeds this URL to the Form Recognizer service and outputs the relevant expense related information recognized expense related on the provided document.

Let's see some code on how the app might want to use this library. Although, you can use any of our languages for this ([.NET](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/formrecognizer/Azure.AI.FormRecognizer/), [Python](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/formrecognizer/azure-ai-formrecognizer), [Java](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/formrecognizer/azure-ai-formrecognizer), or [JavaScript/TypeScript](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/formrecognizer/ai-form-recognizer)), we will be using Java for the examples today. These libraries are currently in preview and are supporting the v2.0-preview version of the Form Recognizer service.

## Recognize expense fields from receipt

The Form Recognizer prebuilt receipt API includes a pre-trained model for reading English sales receipts (e.g. receipts from restaurants or gas stations). This model has already been trained to extract expense related key information such as the time and date of the transaction, merchant information, taxes, total cost, individual line items, and more.

 You can create a Form recognizer resource by following the instructions [here](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/formrecognizer/azure-ai-formrecognizer#create-a-form-recognizer-resource) and use the generated key and endpoint to authenticate the client.

Let's create and authenticate a FormRecognizer client that will be used throughout the class.

```java
public class AnalyzeDataApp {
  // Create a FormRecognizer Client
  private final FormRecognizerClient formRecognizerClient;

  public AnalyzeDataApp(String apiKey, String endpoint) {
    // Authenticate the client with valid endpoint and API key of your created Form Recognizer resource
    this.formRecognizerClient = new FormRecognizerClientBuilder()
      .credential(new AzureKeyCredential(apiKey)))
      .endpoint(endpoint)
      .buildAsyncClient();
  }
}
```

The next step would be to use the above-created client and feed the user-provided receipt URL to the client library's recognize receipt API.

```java
  public recognizeReceipt(String receiptUrl) {
    // Use the client created above to start analyzing the receipt provided by the user
    SyncPoller<OperationResult, IterableStream<RecognizedReceipt>> recognizeReceiptPoller = this.formRecognizerClient.beginRecognizeReceiptsFromUrl(receiptUrl);
    // This is a long runnning operation, so wait for the poller to complete and get the final result
    IterableStream<RecognizedReceipt> receiptPageResults = recognizeReceiptPoller.getFinalResult();
    // Prints receipt/document information
    printReceiptDetails(receiptPageResults);
  }
```

The following code prints general information for the provided receipt:
```java
  public printReceiptDetails(IterableStream<RecognizedReceipt> receiptPageResults) {
    // The receipt document could span over multiple pages, iterate over each page of the receipt
    receiptPageResults.forEach(recognizedReceipt -> {
      System.out.println("----------- Recognized Receipt -----------");

      // Info of the current page being analyzed
      System.out.printf("Start page number: %s, End page number: %s", recognizedReceipt.getRecognizedForm().getPageRange().getStartPageNumber(), recognizedReceipt.getRecognizedForm().getPageRange().getEndPageNumber());

      // The recognized form type for the receipt
      System.out.printf("Form type: %s", recognizedReceipt.getRecognizedForm().getFormType());

      // For example sake, get US specific receipt fields
      processAsUSReceipt(recognizedReceipt)
    });
  }
```

Next, let's see how can we process the extracted receipt to provide more contextual information for a US receipt. The `asUsReceipt()` extension method below, allows users to drill into locale-specific fields information.

```java
  public processAsUSReceipt(RecognizedReceipt recognizedReceipt) {

    // Get a US receipt specific field information
    USReceipt usReceipt = ReceiptExtensions.asUSReceipt(recognizedReceipt);

    // Some commonly found fields on a US Receipt
    System.out.printf("Merchant Name: %s, confidence: %.2f%n", usReceipt.getMerchantName().getFieldValue(), usReceipt.getMerchantName().getConfidence());
    System.out.printf("Merchant Address: %s, confidence: %.2f%n", usReceipt.getMerchantAddress().getName(), usReceipt.getMerchantAddress().getConfidence());
    // Each extracted value is returned with a confidence value, to highlight specific ones that might need more attention
    System.out.printf("Merchant Phone Number %s, confidence: %.2f%n", usReceipt.getMerchantPhoneNumber().getFieldValue(), usReceipt.getMerchantPhoneNumber().getConfidence());

    // Users can also get the bounding box information for each element
    getBoundingBoxInfo(usReceipt.getTotal().getValueText())

    // Get hold of the itemized data from the receipt, if present
    printItemizedReceiptData(usReceipt.getReceiptItems());
  }
```

The bounding box information provided on each element can be used in graphical UI to draw boxes around the various elements for visual validation steps.

The below example shows how you can get the bounding information for the field `total` found in the receipt.

```java
  public getBoundingBoxInfo(FieldText fieldTextValue) {

    final StringBuilder boundingBox = new StringBuilder();
    fieldTextValue.getBoundingBox().getPoints().forEach(point -> boundingBox.append(String.format("[%.2f, %.2f]", point.getX(), point.getY())));
    // This can be used in a graphical UI to draw boxes around the various elements for visual validation steps
    System.out.printf("Field Total has value %s within bounding box %s %n", fieldTextValue, boundingBoxStr);
  }
```

Let's use the method below to print details of itemized data found on the receipt

```java
  public printItemizedReceiptData(USReceiptItem recognizedReceiptItems) {
    // Get hold of the itemized data from the receipt, if present
    System.out.printf("Receipt Items: %n");
    recognizedReceiptItems.forEach(receiptItem -> {
      // Prints the name of the item
      System.out.printf("Name: %s, confidence: %.2f%n", receiptItem.getName().getFieldValue(), receiptItem.getName().getConfidence());
      // Prints the quantity of the item
      System.out.printf("Quantity: %s, confidence: %.2f%n", receiptItem.getQuantity().getFieldValue(), receiptItem.getQuantity().getConfidence());
      // Prints the price of the item
      System.out.printf("Price: %s, confidence: %.2f%n", receiptItem.getPrice().getFieldValue(), receiptItem.getPrice().getConfidence());
      // Prints the total price of the item
      System.out.printf("Total Price: %s, confidence: %.2f%n", receiptItem.getTotalPrice().getFieldValue(), receiptItem.getTotalPrice().getConfidence());
    });
  }
```

Now, let's look at an example of how a user might want to use this library for interpreting form's tabular content and text information into usable formatted data.

## Recognize text and layout information using the Form Recognizer

Form Recognizer can also extract text and table structure (the row and column numbers associated with the text) using high-definition optical character recognition (OCR). The resultant data contains each line of text and its corresponding bounding box placement on the form page document. It also returns the tabular data found on the page, with each of the cell field information with its corresponding row-column coordinate.

First, let's use the user-provided form URL that needs to be analyzed for text and table information.

```java
  public recognizeContent(String formUrl) {
    // Use the client created above to start analyzing the form provided by the user
    SyncPoller<OperationResult, IterableStream<FormPage>> recognizeContentPoller = this.formRecognizerClient.beginRecognizeContent(formUrl);
    // This is a long runnning operation, so wait for the poller to complete and get the final result
    IterableStream<FormPage> contentPageResults = recognizeLayoutPoller.getFinalResult();
    // Prints form page metadata
    printPageMetadata(contentPageResults);
  }
```

Print page metadata information including details of the page orientation and dimension details.

```java
  public printPageMetadata(IterableStream<FormPage> contentPageResults) {
    // The provided form could span over multiple pages, iterate over each page of the form for its relevant content
    contentPageResults.forEach(formPage -> {
      System.out.println("----Recognizing content ----");

      // Display the page metdata
      System.out.printf("The form page has width: %s and height: %s, measured with unit: %s%n", formPage.getWidth(), formPage.getHeight(), formPage.getUnit());

      // Prints recognized layout/content information for the form
      printContentInformation(formPage);

    });
  }
```

Let's create a method that prints out the recognized content information.

```java
  public printContentInformation(FormPage formPage) {
    // Display recognized table information from the form
      formPage.getTables().forEach(formTable -> {
        // The row and column count for each table
        System.out.printf("The recognized table has %s rows and %s columns.%n", formTable.getRowCount(), formTable.getColumnCount());

        // Iterate over each cell in the table
        formTable.getCells().forEach(formTableCell -> {

          // Use bounding box information on each cell data for graphical UI use cases
          final StringBuilder boundingBoxInfo = new StringBuilder();
          formTableCell.getBoundingBox().getPoints().forEach(point -> boundingBoxInfo.append(String.format("[%.2f, %.2f]", point.getX(), point.getY())));

          // Print each cell text data with corresponding box information
          System.out.printf("This cell has text %s, within bounding box %s.%n", formTableCell.getText(), boundingBoxInfo);
        });
      });
  }
```

## Creating your own tailored models

The Form Recognizer client library can further be used to create customized and tailored models. It allows users to train models using their own data forms and then use those customized models for recognizing custom forms!
Custom models can be created using two approaches: Creating custom models with training labels and without training labels.

### Custom model training with training labels
Custom models built using labeled data are highly tailored models. Since they use the labeled data provided by the user, highlighting the custom information in the input forms. These custom models are trained by the service using supervised machine learning algorithms to recognize form fields of special interest to the user.
A particular application of this feature could be seen when you’re working with documents that deviate from the standard industry formats and could be more of your own business model specific format. In these cases, this custom extraction feature can help the user build a solution by training a model on their own data, based on just five documents.

Look here for more information on [setting up labeled training data](https://docs.microsoft.com/azure/cognitive-services/form-recognizer/quickstarts/label-tool#set-up-the-sample-labeling-tool).

Let's see an example of how to train a custom model using labeled data and recognize a form using that model.

First, let's create a custom model, trained using labeled data provided by the user

```java
  public trainCustomModel(String trainingFilesUrl, String formUrl) {

    // Get a FormTrainingClient from the above created FormRecognizerClient
    FormTrainingClient formTrainingClient = this.formRecognizerClient.getFormTrainingClient();

    // Set to true to use labeled data when training
    boolean useLabelFile = true;
    // Use the trainingFilesUrl, to provide the input forms that should be used for training the model
    SyncPoller<OperationResult, CustomFormModel> trainingPoller = formTrainingClient.beginTraining(trainingFilesUrl, useLabelFile);

    // This is a long-running operation, so wait for the poller to complete and get the final result
    CustomFormModel customFormModel = trainingPoller.getFinalResult();

    // Print information of the created custom model
    printModelDetails(customFormModel);

  }
```
Print custom model information and use the created model to analyze custom fields on the form.

```java
  public printModelDetails(CustomFormModel customFormModel) {
    // Prints the generate Model Id
    System.out.printf("Model Id: %s%n", customFormModel.getModelId());

    // Indicates the status of the created model if it has been successfully created or was invalid
    System.out.printf("Model Status: %s%n", customFormModel.getModelStatus());

    // Since the data is labeled, we are able to return the accuracy of the model
    customFormModel.getSubModels().forEach(customFormSubModel -> {
      // Improve model accuracy by labeling additional forms
      System.out.printf("Sub-model accuracy: %.2f%n", customFormSubModel.getAccuracy());
    });

    // Recognize custom form using this custom model
    recognizeCustomForm(customFormModel.getModelId, formUrl);
  }
```

Next, let's use the above created custom model to analyze our custom form.

```java
  public recognizeCustomForm(String modelId, String formUrl) {

    // Use the custom model's Id
    SyncPoller<OperationResult, IterableStream<RecognizedForm>> recognizeFormPoller = this.formRecognizerClient.beginRecognizeCustomFormsFromUrl(formUrl, modelId);

    // This is a long-running operation, so wait for the poller to complete and get the final result
    IterableStream<RecognizedForm> recognizedForms = recognizeFormPoller.getFinalResult();

    // The form could consist of multiple pages so iterate over each page of the form
    recognizedForms.forEach(formPage -> {
      System.out.println("----------- Recognized Form -----------");
      // Get the recognized fields on a form page
      formPage.getFields().forEach((label, formField) -> {
        // Examine the confidence values for each of the applied tags in the labeling process
        System.out.printf("Field %s has value %s with confidence score of %.2f.%n", label, formField.getFieldValue(), formField.getConfidence());
      });
    });
  }
```

### Custom model training without training labels
This approach allows the user of the library to create a custom model without requiring to go through labeling process steps and still be able to turn forms into usable data. This uses unsupervised learning to understand the layout and relationships between fields and entries in your forms. The underlying algorithm for this API clusters the forms by type, discovers what keys and tables are present, and associates values to keys and entries to tables. Since the user does not provide any labeled data, the recognize API with this model doesn't recognize specific tags/labels of special interest to the user but is still able to create a tailored model for a specific set of custom forms.

The client library differentiates between training with labels and without labels with the presence of boolean parameter `useLabelFile`. If `useLabelFile = false` the `beginTraining` API performs model training without labels.

## Further documentation

Take a look at the [Form Recognizer](https://docs.microsoft.com/azure/cognitive-services/form-recognizer/) documentation, and the API reference for the `FormRecognizerClient` in
- .NET [Reference Documentation](https://azure.github.io/azure-sdk-for-net/formrecognizer.html), [Readme](https://github.com/Azure/azure-sdk-for-net/tree/master/sdk/formrecognizer/Azure.AI.FormRecognizer#azure-cognitive-services-form-recognizer-client-library-for-net)
- Java [Reference Documentation](https://azure.github.io/azure-sdk-for-java/formrecognizer.html), [Readme](https://github.com/Azure/azure-sdk-for-java/tree/master/sdk/formrecognizer/azure-ai-formrecognizer#azure-form-recognizer-client-library-for-java)
- Javascript [Reference Documentation](https://azure.github.io/azure-sdk-for-js/formrecognizer.html), [Readme](https://github.com/Azure/azure-sdk-for-js/tree/master/sdk/formrecognizer/ai-form-recognizer#azure-form-recognizer-client-library-for-javascript)
- Python [Reference Documentation](https://azure.github.io/azure-sdk-for-python/ref/Form-Recognizer.html), [Readme](https://github.com/Azure/azure-sdk-for-python/tree/master/sdk/formrecognizer/azure-ai-formrecognizer#azure-form-recognizer-client-library-for-python)

## Want to hear more?

Follow us on [Twitter at @AzureSDK](https://twitter.com/AzureSDK). We'll be covering more best practices in cloud-native development as well as provide updates on our progress in developing the next generation of Azure SDKs.

Contributors to this article: _Sameeksha Vaity_.
