#!/bin/bash

#MASTER=`head -n1 node.list`
MASTER='c4-1'
SCRIPT='run_benchmark_wikipedia.sh'
scp $SCRIPT $MASTER:mnt/store/repositories
ssh root@$MASTER "
	chown hadoop /home/cesga/jlopez/mnt/store/repositories/$SCRIPT
	su - hadoop -c '
		module load hadoop/1.0.3
		cd /home/cesga/jlopez/mnt/store/repositories/
		./$SCRIPT
	'
	"
scp $MASTER:/home/cesga/jlopez/mnt/store/repositories/${SCRIPT/.sh/.log} .
