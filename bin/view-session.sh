#!/bin/bash

IMAGE=ubuntu-ssh 

docker exec -it "$(docker ps | grep "$IMAGE" | awk '{print $1}' )" bash /view-session.sh