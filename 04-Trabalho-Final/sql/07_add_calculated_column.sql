-- Adicionar coluna valor_final do pedido
ALTER TABLE trabalho_final_aluno.pedidos_iceberg ADD COLUMNS
(valor_final DOUBLE);

-- Calcular valor_final de pedidos_iceberg
UPDATE trabalho_final_aluno.pedidos_iceberg
SET valor_final = quantidade * preco_unitario * (1 - desconto) + frete;


SELECT
    COUNT(*)                       AS total,
    COUNT(valor_final)             AS com_valor,
    ROUND(MIN(valor_final), 2)     AS min_valor,
    ROUND(MAX(valor_final), 2)     AS max_valor,
    ROUND(AVG(valor_final), 2)     AS media_valor
FROM trabalho_final_aluno.pedidos_iceberg;