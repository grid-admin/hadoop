#!/bin/bash

# Loop over SIZE in GB with replication 1
for SIZE in 50 100 200 300 400 500 600 800; do

hadoop fs -rmr /user/hadoop/terasort-*

(time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.2.1.jar teragen -D mapred.map.tasks=100 -D dfs.relication=1 $((${SIZE}*1000*1000*10))  /user/hadoop/terasort-input-${SIZE}) &> teragen-${SIZE}G-100-1.log

(time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.2.1.jar terasort -D mapred.reduce.tasks=100 -D dfs.relication=1 /user/hadoop/terasort-input-${SIZE} /user/hadoop/terasort-output-${SIZE}) &> terasort-${SIZE}G-100-1.log


done

