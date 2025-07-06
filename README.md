# Example Components

Example Wasm Components used in Modulewise Demos

## Build

Requires a rust toolchain with the `wasm32-unknown-unknown` target as well as the following:
- [`cargo-component`](https://github.com/bytecodealliance/cargo-component)
- [`wasi-virt`](https://github.com/bytecodealliance/WASI-Virt)
- [`wac`](https://github.com/bytecodealliance/wac)
- [`static-config`](https://github.com/componentized/static-config)

```sh
./build.sh
```

## Run

Requires [`wasmtime`](https://github.com/bytecodealliance/wasmtime) version 0.33 or later.

```sh
./run.sh
```

## License

Copyright (c) 2025 Modulewise Inc and the example-components contributors.

Apache License v2.0: see [LICENSE](./LICENSE) for details.
