CREATE TABLE trabalho_final_aluno.clientes_iceberg (
  id_cliente string,
  nome string,
  sobrenome string,
  ano_nascimento int,
  cidade string,
  estado string,
  segmento string)
LOCATION 's3://tf-aluno-<ACCOUNT_ID>/iceberg/clientes'
TBLPROPERTIES (
  'table_type'='iceberg',
  'write_compression'='zstd',
  'format'='PARQUET'
);