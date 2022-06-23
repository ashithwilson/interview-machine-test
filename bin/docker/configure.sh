#!/bin/bash

# Script to generate random password for user ubuntu
cat >>/usr/bin/generate_pw_ubuntu <<'generate_pw_ubuntu'
#!/bin/bash

password=$( mktemp -u XXXXXXXXXXXXXXXX )
echo "ubuntu:$password" | chpasswd
echo "
SSH Details
---
Username: ubuntu
Password: $password
"
generate_pw_ubuntu

# This script acts as a wrapper to bash to log all SSH data
cat >>/usr/bin/shell2 <<'_shell2_'
#!/bin/bash

# The format of log files is /var/log/machine-test/YYYY-MM-DD_HH-MM-SS_user
LOG_FILE="$(date '+%Y-%m-%d_%H-%M-%S')_$USER"
LOG_DIR="/var/log/machine-test/"
# Suffix the log file name with a random string
SUFFIX=$(mktemp -u _XXXX)

# Set Bash columns
COLUMNS=${COLUMNS:-$(tput cols)}
COLUMNS=${COLUMNS:-80}

# If connection is closed abruptly, this takes care of clean-up including 
# removing active session data
clean_up() 
{
  rm -f "/tmp/.active_session"
}

run_session()
{
  trap "clean_up" SIGHUP
  trap "clean_up" EXIT
  echo "$LOG_FILE$SUFFIX.data" >/tmp/.active_session
  # Script is used to log all input/ouput while bash is executed via SSH
  script -qf "$LOG_DIR$LOG_FILE$SUFFIX.data" --timing="$LOG_DIR$LOG_FILE$SUFFIX.time" --command=/bin/bash
}

# Do not allow multiple simultaneous connections
if [ -f /tmp/.active_session ]
then
  echo "Error: Multiple sessions found. Please close out all sessions and try again." >&2
  exit 128
else
  # With logging,
  run_session
fi

_shell2_


cat >>/etc/ssh/sshd_config <<'_ssh_config_'
# Use wrapper script instead of bash
Match User *
  AllowTcpForwarding no
  X11Forwarding      no
  ForceCommand       /usr/bin/shell2
_ssh_config_

chmod +x /usr/bin/shell2 /usr/bin/generate_pw_ubuntu
mkdir /var/log/machine-test
chmod 0777 /var/log/machine-test -R
