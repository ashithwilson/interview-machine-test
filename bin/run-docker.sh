#!/bin/bash

IMAGE=ubuntu-ssh
CONTAINER_NAME="$IMAGE"

# Make sure to remove any existing docker containers

docker rm -f "$CONTAINER_NAME" 2>/dev/null

docker run -d                                                       \
-h machine-test                                                     \
-p 2222:22                                                          \
--name "$CONTAINER_NAME"                                            \
--mount type=bind,source="$(pwd)"/logs,target=/var/log/machine-test \
"$IMAGE"

# Kill ngrok session if it already exists
ngrok_current_pid=$( ps aux | grep ngrok | grep tcp | grep 2222 | grep -v grep | awk '{print $2}' )
[ -z "$ngrok_current_pid" ] || kill -9 "$ngrok_current_pid"

# Start a new ngrok session
ngrok tcp 2222 
