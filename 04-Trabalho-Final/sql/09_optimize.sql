SELECT COUNT(*) AS num_arquivos_antes
FROM "trabalho_final_aluno"."pedidos_iceberg$files";

-- Compactação dos arquivos
OPTIMIZE trabalho_final_aluno.pedidos_iceberg REWRITE DATA USING BIN_PACK;


