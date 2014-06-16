#!/bin/bash

# Number of slaves (the number of VM will be SIZE+1)
START=81
END=100

for i in `seq -w $START $END`; do 
	occi --endpoint https://cloud.cesga.es:3202/ --auth x509 --resource compute --action create --mixin os_tpl#hadoop --mixin resource_tpl#small --attributes title="hadoop$i" --user-cred /tmp/x509up_u509 --proxy-ca ~/.globus/usercert.pem |grep https >> machines/pending
done

