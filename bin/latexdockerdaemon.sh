#!/bin/sh

pushd $(dirname "${BASH_SOURCE[0]}") >/dev/null
cd ..
PARENT_DIR="$PWD"
popd >/dev/null
PARENT_NAME="$(basename "$PARENT_DIR")"
parent_name="$(echo $PARENT_NAME | tr ' [:upper:]' '_[:lower:]')"

IMAGE="$parent_name/latex:latest"
NAME="$(echo $IMAGE:daemon | tr '/:' '--')"

exec ${CONTAINER_ENGINE:-podman} run -d --rm --name "$NAME" -i --user="$(id -u):$(id -g)" --net=none -t -v $PWD:/data "$IMAGE" /bin/sh -c "sleep infinity"
