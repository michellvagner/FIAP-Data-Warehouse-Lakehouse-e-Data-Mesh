-- Query executiva
SELECT
    c.id_cliente,
    c.nome || ' ' || c.sobrenome as nome_completo,
    c.cidade,
    c.estado,
    c.segmento,
    ROUND(SUM(p.valor_final), 2) as receita_total,
    COUNT(p.id_pedido) as qtd_pedidos,
    ROUND(AVG(p.valor_final), 2) as ticket_medio
FROM trabalho_final_aluno.pedidos_iceberg p
JOIN trabalho_final_aluno.clientes_iceberg c ON p.id_cliente = c.id_cliente
GROUP BY 1, 2, 3, 4, 5
ORDER BY receita_total DESC
LIMIT 5;