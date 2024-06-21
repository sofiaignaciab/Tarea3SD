# Pull the image
docker pull suhothayan/hadoop-spark-pig-hive:2.9.2

# Run the container
docker run -it -p 50070:50070 -p 8088:8088 -p 8080:8080 suhothayan/hadoop-spark-pig-hive:2.9.2 bash

#Load dataset
sudo docker cp path/to/charlie_trace.csv <containerID>:/root/

# Create the directory
hdfs dfs -mkdir -p /user/hadoop/branch_traces

# Copy to a directory
hadoop fs -put /root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv /user/hadoop/branch_traces