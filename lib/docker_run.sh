#!/bin/bash

function docker_run() {
  local CONTAINER_NAME="$1"
  local SERVICE_PORT="$2"
  local NETWORK="$3"
  local IMAGE_NAME="$4"

  if ! docker network ls | grep -w "$NETWORK"
  then
    docker network create --opt com.docker.network.bridge.name="$NETWORK" "$NETWORK"
  fi

  CONTAINER_ID=$(docker run -it --rm \
    --name "$CONTAINER_NAME" \
    -p "$SERVICE_PORT":"$SERVICE_PORT" \
    --network "$NETWORK" \
    -d "$IMAGE_NAME")
  docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_ID"
}