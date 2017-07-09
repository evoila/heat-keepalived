#!/bin/bash

# Install keepalived
yum install -y keepalived

# Stop service
service keepalived stop

systemctl enable keepalived
