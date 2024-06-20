# Installation
Use the repository:
```
https://github.com/suhothayan/hadoop-spark-pig-hive
```
From this repository, pull the image:
```
docker pull suhothayan/hadoop-spark-pig-hive:2.9.2
```
After running the container:
```
docker run -it -p 50070:50070 -p 8088:8088 -p 8080:8080 suhothayan/hadoop-spark-pig-hive:2.9.2 bash
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
```
sudo docker cp root/to/directory/charlie_trace-1_17571657100049929577.branch_trace.940210.csv <containerID>:/root/
```
To check if it was copied correctly, check inside the container:
```
ls /root
```
Copy it to a directory:
```
hadoop fs -put /root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv /user/hive/warehouse/branch_traces
```

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

# Data Analysis: Hive# Tarea3SD
