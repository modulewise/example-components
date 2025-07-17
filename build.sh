#!/bin/bash

set -euo pipefail

cargo component build -p calculator --target wasm32-unknown-unknown --release
cargo component build -p greeter --target wasm32-unknown-unknown --release

cp target/wasm32-unknown-unknown/release/*.wasm lib/

# rely on default greeting "Hello"
static-config -o ./lib/empty-config.wasm
wac plug ./lib/greeter.wasm --plug ./lib/empty-config.wasm -o ./lib/hello.wasm

# provide greeting value through wasi:config/store-exporting component
static-config -p greeting="Aloha" -o ./lib/aloha-config.wasm
wac plug ./lib/greeter.wasm --plug ./lib/aloha-config.wasm -o ./lib/aloha.wasm
