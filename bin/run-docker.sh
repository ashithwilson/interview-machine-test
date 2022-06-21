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
