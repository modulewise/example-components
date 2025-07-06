#!/bin/bash

set -euo pipefail

COMPONENTS=("calculator" "hello")

for COMPONENT in "${COMPONENTS[@]}"; do
  VERSION=0.1.0
  wkg oci push \
    --annotation "org.opencontainers.image.title=${COMPONENT}" \
    --annotation "org.opencontainers.image.description=${COMPONENT} example component" \
    --annotation "org.opencontainers.image.version=${VERSION}" \
    --annotation "org.opencontainers.image.revision=$(git rev-parse HEAD)" \
    --annotation "org.opencontainers.image.source=https://github.com/modulewise/example-components" \
    --annotation "org.opencontainers.image.licenses=Apache-2.0" \
    "ghcr.io/modulewise/${COMPONENT}:${VERSION}" \
    "lib/${COMPONENT}.wasm"
done
