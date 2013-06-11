#!/bin/bash

ENDPOINT=https://cloud.cesga.es:3202/

# ssh test13.egi.cesga.es 
rm node.list.11n
for node in `cat machines/pending.11n`;do
       occi --endpoint $ENDPOINT --auth x509 --user-cred /tmp/x509up_u509 --proxy-ca ~/.globus/usercert.pem --action describe --resource $node | grep IP | awk '{print $3}' >> node.list.11n
done 

