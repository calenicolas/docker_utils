#!/bin/bash

function get_container_ip() {
  local CONTAINER_ID="$1"
  docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CONTAINER_ID"
}