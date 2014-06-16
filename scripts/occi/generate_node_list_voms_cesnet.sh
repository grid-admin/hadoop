#!/bin/bash

ENDPOINT=https://carach5.ics.muni.cz:11443

# ssh test13.egi.cesga.es 
rm node.list.cesnet
for node in `cat machines/pending.cesnet`;do
       occi --endpoint $ENDPOINT --auth x509 --user-cred /tmp/x509up_u509 --proxy-ca ~/.globus/usercert.pem --action describe --resource $node | grep IP | awk '{print $3}' >> node.list.cesnet
done 

