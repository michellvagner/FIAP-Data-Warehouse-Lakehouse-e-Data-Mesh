INSERT INTO trabalho_final_aluno.pedidos_iceberg
SELECT
    id_pedido,
    id_cliente,
    CAST(data_pedido AS DATE),
    categoria_produto,
    quantidade,
    preco_unitario,
    desconto,
    frete
FROM trabalho_final_aluno.pedidos;