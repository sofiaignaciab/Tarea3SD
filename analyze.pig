-- Load the dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- 1. Visualize sample data
data_sample = LIMIT branches 10;
DUMP data_sample;

-- 2. Obtain basic statistics
total_records = FOREACH (GROUP branches ALL) GENERATE COUNT(branches) AS total;
STORE total_records INTO 'file:///home/output/data_total' USING PigStorage(',');

-- 3. Count the frequency of each branch type
branch_frequency = FOREACH (GROUP branches BY branch_type) GENERATE group AS branch_type, COUNT(branches) AS frequency;
STORE branch_frequency INTO 'file:///home/output/frequency' USING PigStorage(',');

-- 4. Analyze the relationship between branch types and the value of 'taken'
branch_taken_relation = FOREACH (GROUP branches BY (branch_type, taken)) GENERATE FLATTEN(group) AS (branch_type, taken), COUNT(branches) AS count;
STORE branch_taken_relation INTO 'file:///home/output/relation_taken' USING PigStorage(',');

-- 5. Calculate the proportion of records with 'taken' equal to 1 for each branch type
branch_taken_proportion = FOREACH (GROUP branches BY branch_type) GENERATE group AS branch_type, 
                         (double)SUM(branches.taken) / COUNT(branches) AS proportion;
STORE branch_taken_proportion INTO 'file:///home/output/taken_proportion' USING PigStorage(',');
