CREATE TABLE trabalho_final_aluno.pedidos_iceberg (
  id_pedido string,
  id_cliente string,
  data_pedido date,
  categoria_produto string,
  quantidade int,
  preco_unitario double,
  desconto double,
  frete double)
PARTITIONED BY (month(data_pedido))
LOCATION 's3://tf-aluno-<ACCOUNT_ID>/iceberg/pedidos'
TBLPROPERTIES (
  'table_type'='iceberg',
  'write_compression'='zstd',
  'format'='PARQUET'
);
