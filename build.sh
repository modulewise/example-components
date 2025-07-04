#!/bin/bash

set -euo pipefail

cargo component build -p calculator --target wasm32-unknown-unknown --release
cargo component build -p greeter --target wasm32-unknown-unknown --release
