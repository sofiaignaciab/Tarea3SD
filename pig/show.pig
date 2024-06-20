-- Cargar el dataset
branches = LOAD '/user/root/charlie_trace-1_17571657100049929577.branch_trace.940210.csv'
            USING PigStorage(',')
            AS (branch_addr:chararray, branch_type:chararray, taken:int, target:chararray);

-- Limitar a los primeros 10 registros
sample_data = LIMIT branches 10;

-- Mostrar los primeros 10 registros en la terminal
DUMP sample_data;

-- Almacenar los primeros 10 registros en el sistema de archivos local
STORE sample_data INTO 'file:///home/output/sample_data' USING PigStorage(',');