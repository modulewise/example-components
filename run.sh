#!/bin/bash

set -euo pipefail
set -x

wasmtime --invoke 'greet("World")' target/wasm32-unknown-unknown/release/greeter.wasm

wasmtime --invoke 'add(3, 4)' target/wasm32-unknown-unknown/release/calculator.wasm
wasmtime --invoke 'subtract(10, 5)' target/wasm32-unknown-unknown/release/calculator.wasm
wasmtime --invoke 'multiply(6, 7)' target/wasm32-unknown-unknown/release/calculator.wasm
wasmtime --invoke 'divide(52, 13)' target/wasm32-unknown-unknown/release/calculator.wasm
