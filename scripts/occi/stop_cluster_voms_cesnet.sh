#!/bin/bash

# Endpoint
ENDPOINT="https://carach5.ics.muni.cz:11443/"

for i in `cat machines/pending.cesnet`; do 
	occi --action delete --resource $i --endpoint $ENDPOINT --auth x509 --user-cred /tmp/x509up_u509 --proxy-ca ~/.globus/usercert.pem 
done

