#!/bin/sh
# --------------------------------------------------------------------------- #
# federation_port_forward.sh
# ~~~~~~~~~~~~~~~~~~~~~~~~~~
# Please do not remove the following notices.
# Copyright (c) 2012 by Geekscape Pty. Ltd.
# Documentation: http://http://geekscape.github.com/aiko_runtime
# License: AGPLv3 http://geekscape.org/static/aiko_license.html
#
# Description
# ~~~~~~~~~~~
# Creates an SSH port forward for a remote MQTT server on local port 1882
# Attempts to clean up all processes cleanly on exit
# Invoked by federation_start.sh
# --------------------------------------------------------------------------- #

remote_host=${1:-mqtt.geekscape.org}
remote_port=1882

local_name=${2:-localhost}
local_port=1883

ssh -L$remote_port:$local_name:$local_port $remote_host ping -i 5 $local_name &
SSH_PROCESS_ID=$!

trap 'kill $SSH_PROCESS_ID >/dev/null 2>&1' EXIT
trap 'exit 2' 1 2 3 15

wait $SSH_PROCESS_ID
