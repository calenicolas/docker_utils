#!/bin/bash

function docker_run() {
  local CONTAINER_NAME="$1"
  local SERVICE_PORT="$2"
  local NETWORK="$3"
  local IMAGE_NAME="$4"

  NETWORK_EXISTS=$(docker network ls | grep -w "$NETWORK")

  if [ ! "$NETWORK_EXISTS" ]
  then
    docker network create --opt com.docker.network.bridge.name="$NETWORK" "$NETWORK" > /dev/null 2>&1 &
  fi

  local CONTAINER_ID
  CONTAINER_ID=$(docker run -it --rm \
    --name "$CONTAINER_NAME" \
    --network "$NETWORK" \
    -d "$IMAGE_NAME")

  local CONTAINER_IP
  CONTAINER_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_ID")

  echo "$CONTAINER_IP"
}