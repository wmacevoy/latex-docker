#!/bin/bash

pushd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null
cd ..
PARENT_DIR="$PWD"
popd >/dev/null
PARENT_NAME="$(basename "$PARENT_DIR")"
parent_name="$(echo "$PARENT_NAME" | tr ' [:upper:]' '_[:lower:]')"

IMAGE="$parent_name/latex:latest"
NAME="$(echo "$IMAGE:daemon" | tr '/:' '--')"

exec "${CONTAINER_ENGINE:-podman}" exec -it "$NAME" "$@"
