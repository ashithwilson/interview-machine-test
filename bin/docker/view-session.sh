#!/bin/bash

cd /var/log/machine-test
last_session=$(ls -tr|tail -1)

[ -z "$last_session" ]                  \
&& echo "No sessions found!
Maybe no ssh session established yet?"  \
|| tail -f "$last_session"

