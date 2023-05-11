#!/bin/bash

function docker_run_with_volume() {
  local CONTAINER_NAME="$1"
  local SERVICE_PORT="$2"
  local NETWORK="$3"
  local IMAGE_NAME="$4"
  local VOLUME="$5"
  local VOLUME_TARGET="$6"

  if ! docker network ls | grep -w "$NETWORK"
  then
    docker network create --opt com.docker.network.bridge.name="$NETWORK" "$NETWORK" > /dev/null 2>&1 &
  fi

  docker volume create "$VOLUME"

  CONTAINER_ID=$(docker run -it --rm \
    --name "$CONTAINER_NAME" \
    -p "$SERVICE_PORT":"$SERVICE_PORT" \
    --network "$NETWORK" \
    --mount source="$VOLUME",target="$VOLUME_TARGET" \
    -d "$IMAGE_NAME")
  docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_ID"
}