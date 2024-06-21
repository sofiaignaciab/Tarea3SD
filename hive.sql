-- Create table
CREATE TABLE branches (
    branch_addr STRING,
    branch_type STRING,
    taken INT,
    target STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


-- Load data
LOAD DATA INPATH '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv' INTO TABLE branches;

--Verify data limit 10
SELECT * FROM branches LIMIT 10;

-- Count the total number of records in the branches table
SELECT COUNT(*) FROM branches;

-- Count the frequency of each branch type
SELECT branch_type, COUNT(*) AS frequency
FROM branches
GROUP BY branch_type;

-- Analyze the relationship between branch types and the value of 'taken'
SELECT branch_type, taken, COUNT(*) AS count
FROM branches
GROUP BY branch_type, taken;

-- Calculate the proportion of records with 'taken' equal to 1 for each branch type
SELECT branch_type, 
    SUM(CASE WHEN taken = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS proportion
FROM branches
GROUP BY branch_type;

-- Create a table to store the frequency of each branch type
CREATE TABLE branch_type_frequency AS
SELECT branch_type, COUNT(*) AS frequency
FROM branches
GROUP BY branch_type;

-- Create a table to store the relationship between branch types and the value of 'taken'
CREATE TABLE branch_type_taken_relation AS
SELECT branch_type, taken, COUNT(*) AS count
FROM branches
GROUP BY branch_type, taken;

-- Create a table to store the proportion of records with 'taken' equal to 1 for each branch type
CREATE TABLE branch_type_taken_proportion AS
SELECT branch_type, 
       SUM(CASE WHEN taken = 1 THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS proportion
FROM branches
GROUP BY branch_type;