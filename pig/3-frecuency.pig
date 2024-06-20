-- Cargar el dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- 2. Contar la frecuencia de cada tipo de branch
branch_frequency = FOREACH (GROUP branches BY branch_type) GENERATE group AS branch_type, COUNT(branches) AS frequency;
STORE branch_frequency INTO 'file:///home/output/frequency' USING PigStorage(',');