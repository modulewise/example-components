#!/bin/bash

set -euo pipefail

cargo component build -p calculator --target wasm32-unknown-unknown --release
cargo component build -p greeter --target wasm32-unknown-unknown --release

cp target/wasm32-unknown-unknown/release/*.wasm lib/

# rely on default greeting "Hello"
wasi-virt ./lib/greeter.wasm -o ./lib/hello.wasm

# provide greeting value through virtualized config
wasi-virt ./lib/greeter.wasm -c greeting=Aloha -o ./lib/aloha.wasm

# provide greeting value through wasi:config/store-exporting component
static-config -p greeting="Good Afternoon" -o ./lib/greeter-config.wasm
wac plug ./lib/greeter.wasm --plug ./lib/greeter-config.wasm -o ./lib/goodafternoon.wasm
