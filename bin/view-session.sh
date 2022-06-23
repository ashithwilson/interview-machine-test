#!/bin/bash

set -e 

logs_dir=logs/

echo "Waiting for session..."

while true
do
    # Check if there is an active session
    session=$( docker exec ubuntu-ssh bash -c "[ ! -f /tmp/.active_session ] ||  cat /tmp/.active_session" )
    if [ -z "$session" ]
    then
        sleep 1
    else
        clear
        tail -f "$logs_dir$session"
        break
    fi
done



