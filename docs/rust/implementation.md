---
title: "Rust Guidelines: Implementation"
keywords: guidelines rust
permalink: rust_implementation.html
folder: rust
sidebar: general_sidebar
---

## Service Clients {#rust-client}

Implementation details of [service clients](introduction.md#rust-client).

### Convenience Clients {#rust-client-convenience}

Most service client crates are generated from [TypeSpec](https://aka.ms/typespec). Clients that want to provide convenience methods can choose any or all of the options as appropriate:

{% include requirement/MAY id="rust-client-convenience-separate" %} implement a separate client that provides features not described in a service specification.

{% include requirement/MAY id="rust-client-convenience-wrap" %} implement a client which wraps a generated client e.g., using [newtype][rust-lang-newtype], and exposes necessary methods from the underlying client as well as any convenience methods. You might consider this approach if you want to effectively hide most generated methods and define replacements. You are responsible for transposing documentation and following all guidelines herein.

{% include requirement/MAY id="rust-client-convenience-extension" %} define [extension methods][rust-lang-extension-methods] in a trait that call existing public methods, e.g.,

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
* The trait **MAY** extend the [service client methods trait for mocking](introduction.md#rust-client-mocking-trait-name) e.g., `pub trait SecretClientExt: SecretClientMethods {}`.

You might consider this approach if the generated methods are sufficient but you want to add convenience methods.

#### Convenience Client Telemetry {#rust-client-convenience-telemetry}

In all options above except if merely re-exposing public APIs without alteration:

{% include requirement/MUST id="rust-client-convenience-telemetry-telemeter" %} must telemeter the convenience client methods just like any service client methods.

### Options Builders {#rust-client-options-builders}

The `azure_core` crate depends on an `azure_core_macros` crate that defines the `ClientOptions` and `ClientMethodOptions` derive macros. These intentionally have the same name as their associated traits in `azure_core` as with `std` crate macros.
These macros make it easy for code emitters and developers to create standard client options and client method options while maintaining standard builder setters by the `azure_core` developers.

Though the derive macros and traits differ in setters and use, they share similar functionality. The following implementation details will focus primarily on `ClientOptions` and `ClientOptionsBuilder`.

{% include requirement/SHOULD id="rust-client-options-builders-client-options" %} use the `ClientOptions` derive macro for client options.

{% include requirement/SHOULD id="rust-client-options-builders-client-method-options" %} use the `ClientMethodOptions` derive macro for client method options.

Client options and client method options should follow the form:

```rust
use azure_core::{ClientOptions, ClientMethodOptions};

pub struct SecretClient {
    // ...
}

#[derive(Clone, Debug, ClientOptions)]
pub struct SecretClientOptions {
    api_version: Option<String>,
    // Other client-specific options ...,
    client_options: ClientOptions,
}

impl SecretClient {
    pub fn get_secret(
        &self,
        name: impl AsRef<str>,
        options: Option<SecretClientGetSecretOptions>,
    ) -> Result<Response<KeyVaultSecret>> {
        todo!()
    }
}

#[derive(Clone, Debug, Default, ClientMethodOptions)]
pub struct SecretClientGetSecretOptions {
    // Other client method-specific options ...,
    method_options: ClientMethodOptions,
}
```

If either `client_options` or `method_options` conflicts, you can name the field whatever you want and attribute it with `#[options]` for the derive macro to discover it.

## Directory Layout {#rust-directories}

In addition to Cargo's [project layout][rust-lang-project-layout], service clients' source files should be layed out in the following manner:

* Azure/azure-sdk-for-rust/
  * sdk/
    * {service directory}/
      * {service client crate}/
        * src/
          * generated/
            * clients/
              * foo.rs
              * bar.rs
            * enums.rs
            * models.rs
          * lib.rs
          * models.rs
          * {other modules}
        * Cargo.toml

<!-- Links -->

{% include refs.md %}
{% include_relative refs.md %}
