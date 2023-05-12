#!/bin/bash
. /usr/local/lib/docker_utils/docker_run.sh

function internal_docker_run() {
  local GIT_REPO=$1
  local IMAGE_NAME=$2
  local CONTAINER_NAME=$3
  local SERVICE_PORT=$4
  local INTERNAL_NETWORK=$5

  TMP_DIR=$(mktemp -d /tmp/cd-build.XXXXXX)

  git clone "$GIT_REPO" "$TMP_DIR"
  docker build -t "$IMAGE_NAME" "$TMP_DIR"

  rm -rf "$TMP_DIR"

  docker_run "$CONTAINER_NAME" "$SERVICE_PORT" "$INTERNAL_NETWORK" "$IMAGE_NAME"
}