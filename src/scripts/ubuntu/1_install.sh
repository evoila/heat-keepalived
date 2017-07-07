#!/bin/bash

# Install nginx
apt-get update
apt-get install -y keepalived

# Stop service
service keepalived stop

systemctl enable keepalived
