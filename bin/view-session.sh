#!/bin/bash


last_session=$(ls -tr logs| tail -1)

[ -z "$last_session" ]                  \
&& echo "No sessions found!
Maybe no ssh session established yet?"  \
|| tail -f "logs/$last_session"