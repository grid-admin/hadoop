time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.2.1.jar teragen -D mapred.map.tasks=100 $((500*1000*1000*10))  /user/hadoop/terasort-input-500 | tee teragen-100-500.log 2>&1 \
&& \
time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.2.1.jar terasort -D mapred.reduce.tasks=100 -D mapred.reduce.slowstart.completed.maps=0.80 /user/hadoop/terasort-input-500 /user/hadoop/terasort-output-500 | tee terasort-100-0.80-500.log 2>&1
