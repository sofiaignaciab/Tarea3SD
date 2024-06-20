-- Cargar el dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- 1. Obtener estadísticas básicas
total_records = FOREACH (GROUP branches ALL) GENERATE COUNT(branches) AS total;
STORE total_records INTO 'file:///home/output/data_total' USING PigStorage(',');

-- 2. Contar la frecuencia de cada tipo de branch
branch_frequency = FOREACH (GROUP branches BY branch_type) GENERATE group AS branch_type, COUNT(branches) AS frequency;
STORE branch_frequency INTO 'file:///home/output/frequency' USING PigStorage(',');

-- 3. Analizar la relación entre los tipos de branch y el valor de 'taken'
branch_taken_relation = FOREACH (GROUP branches BY (branch_type, taken)) GENERATE FLATTEN(group) AS (branch_type, taken), COUNT(branches) AS count;
STORE branch_taken_relation INTO 'file:///home/output/relation_taken' USING PigStorage(',');

-- 4. Calcular la proporción de registros con 'taken' igual a 1 para cada tipo de branch
branch_taken_proportion = FOREACH (GROUP branches BY branch_type) GENERATE group AS branch_type, 
                         (double)SUM(branches.taken) / COUNT(branches) AS proportion;
STORE branch_taken_proportion INTO 'file:///home/output/taken_proportion' USING PigStorage(',');