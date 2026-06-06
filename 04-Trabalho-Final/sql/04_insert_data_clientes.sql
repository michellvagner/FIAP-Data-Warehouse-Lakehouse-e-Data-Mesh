-- Carregar clientes_iceberg a partir de clientes
INSERT INTO trabalho_final_aluno.clientes_iceberg
SELECT 
    id_cliente, 
    nome, 
    sobrenome, 
    ano_nascimento, 
    cidade, 
    estado,
    segmento
FROM trabalho_final_aluno.clientes;