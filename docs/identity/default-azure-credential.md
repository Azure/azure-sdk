# Default Azure Credential

DefaultAzureCredential (DAC) is described as an _opinionated_ Chained Token Credential that should work for most applications that use the Azure SDK.

A few design principles we've aligned on over the years are:

- DAC should support most hero scenarios with minimal configuration
- DAC should succeed in fetching a token if _any_ of its credentials succeed
- DAC should provide minimal configuration - advanced use-cases can be achieved using a custom `ChainedTokenCredential` rather than adding additional options in DAC

## DAC IMDS probing

DAC attempts multiple credentials sequentially, stopping when the first succeeds. One of the credentials attempted is the ManagedIdentityCredential. ManagedIdentityCredential deserves its own chapter; however, one of the optimizations DAC makes is referred to as Instance Metadata Service (IMDS) probing.

<!-- TODO: describe how DAC IMDS probing works and why its there-->

## Cross-language inconsistencies

Generally speaking, users can expect feature parity between implementations among the 4 tier-1 languages; however, one ocassion where that is not the case is via support for `ExcludeXXXCredential` configuration option.

<!-- TODO: describe the inconsistency, which languages support it, and why other languages will not add it -->