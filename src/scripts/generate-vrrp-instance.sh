#!/bin/bash

NAME=${NAME}
ROUTER_ID=${ROUTER_ID}
OPTIONS=${OPTIONS:-'["nopreempt", "priority 1", "advert_int 1"]'}
VIP=${VIP}
AUTP_PASS=${AUTH_PASS:-'verysecret'}
STATE=${STATE:-backup}

TEMP_FILE="/tmp/vrrp-instance-$NAME"
PRIMARY_NIC=$(route -n | grep -E "^0.0.0.0" | awk '{print $8}')

cat <<EOF > $TEMP_FILE
vrrp_instance $NAME {
    state $STATE
    interface $PRIMARY_NIC
    virtual_router_id $ROUTER_ID
    virtual_ipaddress {
        $VIP dev $PRIMARY_NIC
    }
    track_interface {
        $PRIMARY_NIC
    }
    authentication {
        auth_type PASS
        auth_pass $AUTH_PASS
    }
}
EOF

cp $TEMP_FILE ${heat_outputs_path}.config
