#!/bin/bash

cat >>/usr/bin/shell2 <<'_shell2_'

# The format of log files is /var/log/machine-test/YYYY-MM-DD_HH-MM-SS_user
LOG_FILE="$(date '+%Y-%m-%d_%H-%M-%S')_$USER"
LOG_DIR="/var/log/machine-test/"
# Suffix the log file name with a random string
SUFFIX=$(mktemp -u _XXXX)

# Set Bash columns
COLUMNS=${COLUMNS:-$(tput cols)}
COLUMNS=${COLUMNS:-80}

# Wrap an interactive shell into "script"
script -qf "$LOG_DIR$LOG_FILE$SUFFIX.data" --command=/bin/bash
_shell2_


cat >>/etc/ssh/sshd_config <<'_ssh_config_'

# Use wrapper script instead of bash
Match User *
  AllowTcpForwarding no
  X11Forwarding      no
  ForceCommand       /usr/bin/shell2
_ssh_config_

chmod +x /usr/bin/shell2
mkdir /var/log/machine-test
chmod 0777 /var/log/machine-test -R
