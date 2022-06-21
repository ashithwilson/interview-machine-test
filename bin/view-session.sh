#!/bin/bash

logs_dir=logs/

last_session=$(ls -tr "$logs_dir"| tail -1)

echo "Waiting for session..."

while true
do
    last_session=$(ls -tr "$logs_dir"| tail -1)
    done_session=$( tail -1 "$logs_dir$last_session" | egrep -c "\[COMMAND_EXIT_CODE=|exit" )
    if [ "$done_session" = "0" ]
    then
        clear
        tail -f "$logs_dir$last_session"
        break
    else
        sleep 1
    fi
done



