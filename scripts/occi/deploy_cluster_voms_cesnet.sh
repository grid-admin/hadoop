#!/bin/bash

# Number of slaves (the number of VM will be SIZE+1)
START=1
END=10

# Endpoint
ENDPOINT="https://carach5.ics.muni.cz:11443/"

for i in `seq -w $START $END`; do 
	occi --endpoint $ENDPOINT --auth x509 --resource compute --action create --mixin os_tpl#hadoop --mixin resource_tpl#small --attributes title="hadoop$i" --user-cred /tmp/x509up_u509 --proxy-ca ~/.globus/usercert.pem |grep https >> machines/pending.cesnet
done

