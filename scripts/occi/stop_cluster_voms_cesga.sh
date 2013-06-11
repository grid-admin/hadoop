#!/bin/bash

# Endpoint
ENDPOINT="https://cloud.cesga.es:3202/"

for i in `cat machines/pending`; do 
	occi --action delete --resource $i --endpoint $ENDPOINT --auth x509 --user-cred /tmp/x509up_u509 --proxy-ca ~/.globus/usercert.pem 
done

