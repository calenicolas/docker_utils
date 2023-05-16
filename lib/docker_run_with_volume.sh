#!/bin/bash
. /usr/local/lib/docker_utils/docker_run.sh

function docker_run_with_volume() {
  local CONTAINER_NAME="$1"
  local SERVICE_PORT="$2"
  local NETWORK="$3"
  local IMAGE_NAME="$4"
  local MOUNT_SOURCE="$5"
  local VOLUME_TARGET="$6"

  local EXTRA_OPTS="--mount type=bind,source=$MOUNT_SOURCE,target=$VOLUME_TARGET"

  docker_run "$CONTAINER_NAME" "$SERVICE_PORT" "$NETWORK" "$IMAGE_NAME" "$EXTRA_OPTS"
}