# 1.0 Naming Gudelines

## 1.0.0 Namespace Naming

1.0.1 :white_check_mark: **DO** register all namespaces with adparch@microsoft.com, 
i.e. send email about your proposed namespaces to this address to start a discussion.  

1.0.2 :white_check_mark: **DO** adhere to the following scheme when choosing a namespace:
```Azure.<group>.<service>[.<feature>]```. For example, ```Azure.Storage.Blobs```, ```Azure.CognitiveServices.Speech.Recognition```

1.0.3 :no_entry: **DO NOT** place service API in second level namespace, e.g. ```Azure.KeyVault```

1.0.4 :ballot_box_with_check: **CONSIDER** using one of the following pre-approved namespace groups:

- Azure.Diagnostics (e.g. Azure.Diagnostics.OperationalInsights)
- Azure.Cognitive (e.g. Azure.Cognitive.FaceRecognition)
- Azure.Iot (e.g. Azure.Iot.Hub)
- Azure.Networking (e.g. Azure.Networking.EventHub)
- Azure.Runtime (e.g. Azure.Runtime.VirtualMachines)
- Azure.Security (e.g. Azure.Security.KeyVault)
- Azure.Storage (e.g. Azure.Storage.Blobs)
