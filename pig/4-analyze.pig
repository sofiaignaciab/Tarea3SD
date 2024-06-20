-- Load dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- 3. Analyze the relation between branch and taken
branch_taken_relation = FOREACH (GROUP branches BY (branch_type, taken)) GENERATE FLATTEN(group) AS (branch_type, taken), COUNT(branches) AS count;
STORE branch_taken_relation INTO 'file:///home/output/relation_taken' USING PigStorage(',');