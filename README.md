# Hadoop, Pig & Hive
Use the repository:
```
https://github.com/suhothayan/hadoop-spark-pig-hive
```
From this repository, pull the image:
```shell
docker pull suhothayan/hadoop-spark-pig-hive:2.9.2
```
Run the container:
```shell
docker run -it -p 50070:50070 -p 8088:8088 -p 8080:8080 suhothayan/hadoop-spark-pig-hive:2.9.2 bash
```
Open the container:
```shell
sudo docker excec -it hadoop-spark-pig-hive-container /bin/bash/
```
To check if it works:
```
hdfs
```

```
pig
```

```
hive
```

---

# Data Loading
In bash:
```bash
sudo docker cp path/to/charlie_trace.csv <containerID>:/root/
```
To check if it was copied correctly, check inside the container:
```
ls /root
```
## HDFS Data Loading
Create the directory:
```shell
hdfs dfs -mkdir -p /user/hadoop/branch_traces
```
Copy it to a directory:
```shell
hadoop fs -put /root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv /user/hadoop/branch_traces
```
Check the file:
```
hadoop fs -ls
```

---
# Table Creation: Hive
```
hive
```
Create the table with the elements in the .csv file:
```
CREATE TABLE branch_traces (
    branch_addr STRING,
    branch_type STRING,
    taken INT,
    target STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;
```
Load data into the table:
```
LOAD DATA INPATH '/user/hive/warehouse/branch_traces/charlie_trace-1_17571657100049929577.branch_trace.940210.csv' INTO TABLE branch_traces;

```
Verify the creation:
```
SHOW TABLES;
```

```
DESCRIBE branch_traces;
```

```
SELECT * FROM branch_traces LIMIT 10;
```
---
# Data Analysis: Hive
Run the querys that are in script: hive.sql
---

# Data Analysis: Pig
If you want to make just one explanatory analysis, copy the script to the container:
```
sudo docker cp analyze.pig <containerID>:/home/
```
And run:
```
pig analyze.pig
```
If that's not the case, copy the directory to the container:
```
sudo docker cp pig <containerID>:/home/
```
Then run:
```
pig i-function.pig
```
In this case, you have to run the files that are in pig directory one by one.