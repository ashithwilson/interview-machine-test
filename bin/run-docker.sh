#!/bin/bash

IMAGE=ubuntu-ssh

current_docker=$( docker ps | grep "$IMAGE" | awk '{print $1}' )

[ -z "$current_docker" ]         \
|| docker kill "$current_docker"


docker run -d                                                       \
-h machine-test                                                     \
-p 2222:22                                                          \
--mount type=bind,source="$(pwd)"/logs,target=/var/log/machine-test \
"$IMAGE"

# Kill ngrok session if it already exists
ngrok_old_pid=$( ps aux | grep ngrok | grep tcp | grep 2222 | grep -v grep | awk '{print $2}' )
[ -z "$ngrok_old_pid" ] || kill -9 "$ngrok_old_pid"

# Start a new ngrok session
ngrok tcp 2222 
