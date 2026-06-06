-- Criar tabela intermediária pedidos_delta_iceberg
CREATE TABLE trabalho_final_aluno.pedidos_delta_iceberg
WITH (
    table_type='ICEBERG',
    is_external=false,
    format='PARQUET',
    write_compression='ZSTD',
    location='s3://tf-aluno-<ACCOUNT_ID>/iceberg/pedidos_delta/'
)
AS 
SELECT
    id_pedido,
    id_cliente,
    CAST(data_pedido AS DATE) as data_pedido,
    categoria_produto,
    quantidade,
    preco_unitario,
    desconto,
    frete,
    (quantidade * preco_unitario * (1 - desconto) + frete) as valor_final
FROM trabalho_final_aluno.pedidos_delta;

SELECT * FROM trabalho_final_aluno.pedidos_delta_iceberg ORDER BY id_pedido;

-- Merge para atualizar os pedidos existentes e inserir novos pedidos
MERGE INTO trabalho_final_aluno.pedidos_iceberg t
USING trabalho_final_aluno.pedidos_delta_iceberg s
ON (t.id_pedido = s.id_pedido)
WHEN MATCHED THEN
UPDATE SET 
    desconto = s.desconto, 
    valor_final = s.valor_final
WHEN NOT MATCHED THEN
INSERT (
    id_pedido, 
    id_cliente, 
    data_pedido, 
    categoria_produto,
    quantidade, 
    preco_unitario, 
    desconto, 
    frete, 
    valor_final
)
VALUES ( 
    s.id_pedido, 
    s.id_cliente, 
    s.data_pedido,
    s.categoria_produto, 
    s.quantidade, 
    s.preco_unitario, 
    s.desconto, 
    s.frete,
    s.valor_final
);


-- 1) total deve ser 100.003 (100k + 3 inserts)
SELECT COUNT(*) FROM trabalho_final_aluno.pedidos_iceberg;

-- 2) os 2 updates devem ter desconto = 0.50 / 0.45
SELECT t.id_pedido, t.desconto, t.valor_final
FROM trabalho_final_aluno.pedidos_iceberg t
JOIN trabalho_final_aluno.pedidos_delta_iceberg s
  ON t.id_pedido = s.id_pedido
ORDER BY t.id_pedido;
-- esperado: 5 linhas, valor_final batendo com s.valor_final

-- 3) o snapshot do MERGE aparece com operation = overwrite
SELECT snapshot_id, operation, summary
FROM "trabalho_final_aluno"."pedidos_iceberg$snapshots"
ORDER BY committed_at DESC
LIMIT 5;