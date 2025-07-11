#!/bin/bash

set -euo pipefail

cargo component build -p counter --target wasm32-unknown-unknown --release

wkg oci pull -o lib/valkey-client.wasm ghcr.io/componentized/valkey/valkey-client:v0.1.1

wac plug target/wasm32-unknown-unknown/release/counter.wasm --plug lib/valkey-client.wasm -o lib/valkey-counter.wasm

static-config -o lib/empty-config.wasm

wac plug lib/valkey-counter.wasm --plug lib/empty-config.wasm -o lib/default-counter.wasm
