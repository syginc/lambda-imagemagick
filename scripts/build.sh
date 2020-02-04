#!/bin/bash

set -eo pipefail

USER_ID="$(id -u)"

rm -rf build dist
mkdir -p build dist

DOCKER_IMAGE="lambda-imagemagick-$$"
docker build --no-cache=true -t "$DOCKER_IMAGE" .
docker run --rm \
  -v "$(pwd):/repo" \
  -w /work \
  "$DOCKER_IMAGE" \
  /bin/bash -c "(cd /opt ; zip -r /repo/dist/imagemagick-layer.zip *)"
docker rmi "$DOCKER_IMAGE"
