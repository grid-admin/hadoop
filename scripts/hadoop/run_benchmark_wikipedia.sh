#!/bin/bash

exec &> run_benchmark_wikipedia_64M_cesnet-51.log

module load hadoop

echo "==> Hadoop cluster status"
hadoop dfsadmin -report | grep "Datanodes available"
echo -ne "Tasktrackers available "
hadoop job -list-active-trackers|wc -l
echo "===> HDFS"
hadoop dfsadmin -report
echo "===> Task trackers"
hadoop job -list-active-trackers

#echo "==> time hadoop fs -put wikipedia ."
#for i in `seq 1 4`; do
#	echo "===> Run $i:"
#	time hadoop fs -put wikipedia .
#done
#echo "===> Run 5"
#time hadoop fs -put wikipedia .

# Just one run for wikipedia
echo "==> time hadoop fs -put wikipedia ."
time hadoop fs -Ddfs.block.size=$[64*1024*1024] -Ddfs.replication=3 -put wikipedia wikipedia-64M

# wordcount
echo "==> time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.0.3.jar wordcount wikipedia wikipedia-out"
for i in `seq 1 5`; do
	        echo "===> Run $i:"
		        time hadoop --config hadoop-conf/ jar /opt/cesga/hadoop-1.0.3/hadoop-examples-1.0.3.jar wordcount -Dmapred.reduce.tasks=48 wikipedia-64M wikipedia-64M-out-$i
		done


# Just one run for wikipedia
#echo "==> time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.0.3.jar wordcount wikipedia wikipedia-out"
#time hadoop --config hadoop-conf/ jar /opt/cesga/hadoop-1.0.3/hadoop-examples-1.0.3.jar wordcount wikipedia-64M wikipedia-64M-out


# time hadoop fs -put wikipedia .
