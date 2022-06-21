#!/bin/bash

IMAGE=ubuntu-ssh

current_docker=$( docker ps | grep ubuntu-ssh | awk '{print $1}' )

[ -z "$current_docker" ]         \
|| docker kill "$current_docker"

docker run -h machine-test -p 2222:22 -d "$IMAGE"
