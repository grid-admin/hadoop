(time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.2.1.jar teragen -D mapred.map.tasks=100 -D dfs.relication=3 $((100*1000*1000*10))  /user/hadoop/terasort-input-100) &> teragen-100-100.log 

(time hadoop jar /opt/cesga/hadoop/hadoop-examples-1.2.1.jar terasort -D mapred.reduce.tasks=100 -D dfs.relication=1 /user/hadoop/terasort-input-100 /user/hadoop/terasort-output-100) &> terasort-100G-100.out 
