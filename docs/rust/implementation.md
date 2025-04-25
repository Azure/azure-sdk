---
title: "Rust Guidelines: Implementation"
keywords: guidelines rust
permalink: rust_implementation.html
folder: rust
sidebar: general_sidebar
---

## Safety {#rust-safety}

The following guidelines are to foster secure code not only within Azure SDK for Rust, but on behalf of our customers.

### Debug Trait {#rust-safety-debug}

{% include requirement/MAY id="rust-safety-debug-derive" %} derive or implement `Debug` on types as long as you guarantee no PII may be leaked.

To elide some fields from `Debug` output, you may use `finish_non_exhaustive()` like so:

```rust
use std::fmt;

impl fmt::Debug for MyModel {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("MyModel")
            .field("id", &self.id)
            .finish_non_exhaustive()
    }
}
```

{% include requirement/SHOULD id="rust-safety-debug-safedebug" %} derive or implement `azure_core::fmt::SafeDebug` on types if you need a `Debug` implementation but cannot reasonably guarantee no PII may be leaked.

`SafeDebug` will only output the name of the type or, if information is available in TypeSpec, show only fields that have been declared safe from leaking PII.

## Service Clients {#rust-client}

Implementation details of [service clients](introduction.md#rust-client).

### Convenience Clients {#rust-client-convenience}

Most service client crates are generated from [TypeSpec](https://aka.ms/typespec). Clients that want to provide convenience methods can choose any or all of the options as appropriate:

{% include requirement/MAY id="rust-client-convenience-separate" %} implement a separate client that provides features not described in a service specification.

{% include requirement/MAY id="rust-client-convenience-wrap" %} implement a client which wraps a generated client e.g., using [newtype][rust-lang-newtype], and exposes necessary methods from the underlying client as well as any convenience methods. You might consider this approach if you want to effectively hide most generated methods and define replacements. You are responsible for transposing documentation and following all guidelines herein.

{% include requirement/MAY id="rust-client-convenience-extension" %} define [extension methods][rust-lang-extension-methods] in a trait that call existing public methods or directly on the `pipeline`, e.g.,

```rust
pub trait SecretClientExt {
    async fn deserialize_secret<T: serde::de::DeserializeOwned>(
        &self,
        name: impl AsRef<str>,
        version: Option<impl AsRef<str>>,
    ) -> Result<Response<T>>;
}

impl SecretClientExt for SecretClient {
    async fn deserialize_secret<T: serde::de::DeserializeOwned>(
        &self,
        name: impl AsRef<str>,
        version: Option<impl AsRef<str>>,
    ) -> Result<T> {
        let value = self.get_secret(name, version).await?;
        serde_json::from_str(&value).map_err(Error::from)
    }
}
```

* The trait **MUST** be exported from the crate root.
* The trait **MUST** use the name of the client it extends with an "Ext" suffix e.g., "SecretClientExt".

You might consider this approach if the generated methods are sufficient but you want to add convenience methods.

#### Convenience Client Telemetry {#rust-client-convenience-telemetry}

In all options above except if merely re-exposing public APIs without alteration:

{% include requirement/MUST id="rust-client-convenience-telemetry-telemeter" %} telemeter the convenience client methods just like any service client methods.

### Tests {#rust-client-tests}

We will implement tests [idiomatically with cargo][rust-lang-tests].

#### Unit tests {#rust-client-tests-unit}

{% include requirement/MUST id="rust-client-tests-unit-location" %} include unit tests in the module containing the subject being tested.

{% include requirement/MAY id="rust-client-tests-unit-directory" %} separate unit tests in a separate file named `tests.rs` under a separate directory with the same name as the module you're testing e.g., tests may go into `foo/tests.rs` to test module `foo`. Module `foo` would then include `$[cfg(test)] mod tests;`. This is useful if your module contains a lot of code and you have a lot of tests that make maintaining and reviewing the source file more difficult.

{% include requirement/SHOULD id="rust-client-tests-unit-module" %} put all tests into a `tests` submodule.

{% include requirement/SHOULD id="rust-client-tests-unit-prefix" %} preface tests with "test_" unless you need to disambiguate with the function being tested.

Putting these requirements together, you should have code similar to:

```rust
pub fn hello() -> String {
    todo!()
}

pub async fn read_config() -> azure_core::Result<Configuration> {
    todo!()
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_hello() {
        assert_eq!(hello(), String::from("Hello, world!"));
    }

    #[tokio::test]
    async fn reads_config() -> azure_core::Result<Configuration> {
        let config = read_config().await?;
        assert_eq!(config.id, 1234);
        assert_eq!(config.sections.len(), 3);
    }
}
```

#### Integration tests {#rust-client-tests-integration}

{% include requirement/MUST id="rust-client-tests-integration-location" %} include integration tests under the `tests/` subdirectory of your crate.

{% include requirement/SHOULD id="rust-client-tests-integration-recorded" %} write integration tests as [recorded tests][general-recorded-tests].

#### Examples {#rust-client-tests-examples}

{% include requirement/SHOULD id="rust-client-tests-examples-location" %} include examples under the `examples/` subdirectory for primary use cases. These are written as standalone executables but may include shared code modules.

## Traits {#rust-traits}

{% include requirement/MUST id="rust-traits-async" %} attribute traits and trait implementations with async functions with the `async_trait::async_trait` procedural macro to desugar the async functions. This allows requiring futures to also be `Send`. See [Azure/azure-sdk-for-rust#1796](https://github.com/Azure/azure-sdk-for-rust/issues/1796) for details.

```rust
use async_trait::async_trait;

#[cfg_attr(target_arch = "wasm32", async_trait(?Send))]
#[cfg_attr(not(target_arch = "wasm32"), async_trait)]
pub trait Policy {
    async fn send(
        &self,
        ctx: &Context,
        request: &mut Request,
        next: &[Arc<dyn Policy>],
    ) -> PolicyResult;
}

#[cfg_attr(target_arch = "wasm32", async_trait(?Send))]
#[cfg_attr(not(target_arch = "wasm32"), async_trait)]
impl Policy for TelemetryPolicy {
    async fn send(
        &self,
        ctx: &Context,
        request: &mut Request,
        next: &[Arc<dyn Policy>],
    ) -> PolicyResult {
        todo!()
    }
}
```

We loosen constrains for `wasm32` because threads are not supported.

## Directory Layout {#rust-directories}

In addition to Cargo's [project layout][rust-lang-project-layout], service clients' source files should be laid out in the following manner:

```text
Azure/azure-sdk-for-rust/
├─ .vscode/cspell.json
├─ doc/ # general documentation
├─ eng/ # engineering system pipeline, scripts, etc.
└─ sdk/
   └─ {service directory}/ # example: keyvault
      ├─ .dict.txt
      └─ {service client crate}/ # example: azure_security_keyvault_secrets
         ├─ assets.json # best location for most crates, or in {service directory} for all crates
         ├─ examples/
         │  ├─ {optional shared code}/
         │  ├─ example1.rs
         │  └─ example2.rs
         ├─ src/
         │  ├─ generated/
         │  │  ├─ clients/
         │  │  │  ├─ foo.rs
         │  │  │  └─ bar.rs
         │  │  ├─ enums.rs
         │  │  └─ models.rs
         │  ├─ lib.rs
         │  ├─ models.rs
         │  └─ {other modules}
         ├─ tests/
         │  ├─ {shared code}/
         │  ├─ integration_test1.rs
         │  └─ integration_test2.rs
         └─ Cargo.toml
```

## Module Layout {#rust-modules}

Rust modules should be defined such that:

1. All clients and their client options that the user can create are exported from the crate root e.g., `azure_security_keyvault_secrets`.
2. All subclients and their client options that can only be created from other clients should only be exported from the `clients` submodule e.g., `azure_security_keyvault_secrets::clients`.
3. All client method options are exported from the `models` module e.g., `azure_security_keyvault_secrets::models`.
4. Extension methods on clients should be exported from the same module(s) from which their associated clients are exported.
5. Extension methods on models should be exported from the same module(s) from which their associated models are exported.

Effectively, export creatable clients from the root and keep associated items together. These creatable types are often the only types that users will need to reference by name so we want them easily discoverable.
All clients will be exported from a `clients` submodule so they are easy to find, but creatable clients would be re-exported from the crate root e.g.,

```rust
// lib.rs
mod generated;
mod helpers;

pub use generated::*;
pub use helpers::*;

// generated/mod.rs
pub mod clients;
pub mod models;
pub use clients::{SecretClient, SecretClientOptions};
```

If you need to define clients or models in addition to those generated e.g., you want to wrap generated clients instead of exposing them directly,
you can create your own `clients` and `models` modules and re-export `generated::clients::*` and `generated::models::*`, respectively, from there.

```rust
// lib.rs
pub mod clients;
pub mod models;
pub use clients::{SecretClient, SecretClientOptions};

// clients/mod.rs
use crate::generated::clients::SecretClient as GeneratedSecretClient;
pub use crate::generated::SecretClientOptions;

pub struct SecretClient {
    client: GeneratedSecretClient,
} // ...

// models/mod.rs
pub use crate::generated::models::*;

#[derive(SafeDebug)]
pub struct ExtraModel {
    // ...
}
```

## Miscellaneous {#rust-miscellaneous}

### Spelling {#rust-miscellaneous-spelling}

{% include requirement/SHOULD id="rust-miscellaneous-spelling-general" %} put general words used across different services and client libraries in the `.vscode/cspell.json` file.

{% include requirement/SHOULD id="rust-miscellaneous-spelling-specific" %} put words specific to a service or otherwise limited use in a `.dict.txt` file in the `{service directory}` as shown in the [directory layout](#rust-directories).
If you're creating this file, add an entry to `.vscode/cspell.json` as shown below:

```json
{
  "dictionaryDefinitions": [
    {
      "name": "service-name",
      "path": "../sdk/service-directory/.dict.txt",
      "noSuggest": true
    }
  ],
  "overrides": [
    {
      "filename": "sdk/service-directory/**",
      "dictionaries": [
        "crates",
        "rust-custom",
        "service-name"
      ]
    }
  ]
}
```


<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
