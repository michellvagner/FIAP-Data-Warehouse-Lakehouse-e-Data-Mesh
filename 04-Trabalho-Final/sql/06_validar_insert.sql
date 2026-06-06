SELECT COUNT(*) FROM trabalho_final_aluno.clientes_iceberg;

SELECT
    COUNT(*)                  AS total,
    MIN(data_pedido)          AS data_min,
    MAX(data_pedido)          AS data_max,
    COUNT(DISTINCT id_cliente) AS clientes_distintos
FROM trabalho_final_aluno.pedidos_iceberg;