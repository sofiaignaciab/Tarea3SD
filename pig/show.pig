-- Load dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Show and save first 10 registers
sample_data = LIMIT branches 10;
DUMP sample_data;
STORE sample_data INTO 'file:///home/output/sample_data' USING PigStorage(',');