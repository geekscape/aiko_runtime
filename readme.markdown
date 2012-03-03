Aiko run-time environment (version 0.0 2012-03-03)
=========================

This project is part of the
[Aiko Platform](https://sites.google.com/site/aikoplatform)

Contents
--------
- [Introduction](#introduction)
- [Feedback and issues](#feedback)
- [Installation](#installation)
- [Usage](#usage)
- [Known problems](#problems)

<a name="introduction" />
Introduction
------------
This project provides an environment for running various services and
components of the Aiko Platform.  The aim is to make it simple to set-up a
new system to support and participate in a distributed network of devices.

The initial goal will be to support simple networks of Arduino embedded
controllers, using MQTT servers, application glue developed in Lua and
Android devices for user interface.  Very basic federation between
remote MQTT servers is included.

The focus will be to ensure that the infrastructure is robust (handles
failure gracefully), reasonably secure (across the WAN) and avoids major
single-points-of-failure (within the LAN).

<a name="feedback" />
Feedback and issues
-------------------
Tracking is managed via GitHub ...

- [Enhancements requests and issue tracking](https://github.com/geekscape/aiko_runtime/issues)

<a name="installation" />
Installation
------------
Initially, only Unix platforms, e.g Linux and Mac OS X will be supported.
However, all the services and protocols should be cross-platform.

Prerequisites ...

- Install [Mosquitto MQTT server](http://mosquitto.org/download)
  or any other MQTT server
- Other projects, such as
  [MQTT Lua client](https://github.com/geekscape/mqtt_lua)
  will have specific prerequisites listed in their installation documentation

Installation steps ...

- git clone git@github.com:geekscape/aiko_runtime.git
- cd aiko_runtime
- git clone git@github.com:geekscape/mqtt_lua.git

Usage 
-----
The following commands maintain an SSH port forwarding tunnel between a
local MQTT server and a remote MQTT server ...

* cd scripts
* ./federation_start.sh

<a name="problems" />
Known problems
--------------
- Not enough time to do everything !
