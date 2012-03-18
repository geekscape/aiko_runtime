#!/bin/sh
# --------------------------------------------------------------------------- #
# federation_start.sh
# ~~~~~~~~~~~~~~~~~~~
# Please do not remove the following notices.
# Copyright (c) 2012 by Geekscape Pty. Ltd.
# Documentation: http://http://geekscape.github.com/aiko_runtime
# License: AGPLv3 http://geekscape.org/static/aiko_license.html
#
# Description
# ~~~~~~~~~~~
# Loops indefinitely ...
# - Invokes federation_port_forward.sh
# - Uses mosquitto_sub to determine if port forward is functioning
# - Attempts to clean up all processes cleanly in the loop and on exit
#
# "poll_time" is chosen as a balance between responsiveness and ...
#  - Not sending too many keep_alive messages
#  - Not being too impatient when restarting after a failure
#
# Note: Public MQTT test servers ...
#   Eclipse Paho: m2m.eclipse.org:1883
#   Mosquitto:    test.mosquitto.org:1883  # http://test.mosquitto.org
#   Pachube:      api.pachube.com:1883     # http://pachube.com/docs/beta/mqtt
#
# ToDo
# ~~~~
# - Make SSH optional for non-secure sites like Paho (Eclipse) and Pachube.
# --------------------------------------------------------------------------- #

remote_host=${1:-mqtt.geekscape.org}
remote_port=1882

local_name=${2:-localhost}
local_port=1883

poll_time=60  # seconds

eval `ssh-agent`
ssh-add

trap 'ssh-agent -k >/dev/null 2>&1' EXIT
trap 'exit 2' 1 2 3 15

while (true); do
  echo `date +'%F %T'`: Restarting MQTT federation to $remote_host
  ./federation_port_forward.sh $remote_host $local_name >/dev/null &
  SHELL_PROCESS_ID=$!
  trap '(kill $SHELL_PROCESS_ID; ssh-agent -k) >/dev/null 2>&1' EXIT
  sleep 5

  mosquitto_sub -h localhost -p $remote_port -t '$SYS/broker/version' -k $poll_time
  kill $SHELL_PROCESS_ID >/dev/null 2>&1
  sleep $poll_time
done
