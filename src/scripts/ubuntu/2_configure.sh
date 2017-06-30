#!/bin/bash

CONFIGS=${CONFIGS:-'[]'}

echo "" > /etc/keepalived/keepalived.conf

LENGTH=$(echo ${CONFIGS} | /usr/bin/jq 'length')
LAST_INDEX=$((LENGTH-1))
for I in `seq 0 $LAST_INDEX`; do
  CONFIG=$(echo $CONFIGS | /usr/bin/jq -r ".[$I]" )
  echo -e "$CONFIG\n" >> /etc/keepalived/keepalived.conf
done

service keepalived restart
