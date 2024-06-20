-- Cargar el dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- 4. Calcular la proporción de registros con 'taken' igual a 1 para cada tipo de branch
branch_taken_proportion = FOREACH (GROUP branches BY branch_type) GENERATE group AS branch_type, 
                         (double)SUM(branches.taken) / COUNT(branches) AS proportion;
STORE branch_taken_proportion INTO 'file:///home/output/taken_proportion' USING PigStorage(',');