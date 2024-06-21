-- Load dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Get statics
total_records = FOREACH (GROUP branches ALL) GENERATE COUNT(branches) AS total;
STORE total_records INTO 'file:///home/output/data_total' USING PigStorage(',');