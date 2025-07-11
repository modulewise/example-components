#![no_main]

use wasi::config;
use wasi::keyvalue::{
    atomics,
    store::{self, Error},
};

wit_bindgen::generate!({
    world: "counter-world",
    path: "../wit",
    generate_all
});

const DEFAULT_BUCKET_NAME: &str = "counts";

#[derive(Debug, Clone)]
struct Counter;

impl Counter {
    fn increment(key: &str) -> Result<i64, Error> {
        let bucket_key = config::store::get("bucket")
            .unwrap_or_else(|_| Some(DEFAULT_BUCKET_NAME.to_string()))
            .unwrap_or(DEFAULT_BUCKET_NAME.to_string());
        let bucket = store::open(&bucket_key)?;
        atomics::increment(&bucket, key, 1)
    }
}

impl exports::modulewise::example_components::counter::Guest for Counter {
    fn increment(key: String) -> Result<i64, String> {
        Self::increment(&key).map_err(|e| format!("{:?}", e))
    }
}

export!(Counter);
