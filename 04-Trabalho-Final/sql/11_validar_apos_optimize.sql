SELECT COUNT(*) AS num_arquivos_depois
FROM "trabalho_final_aluno"."pedidos_iceberg$files";

-- Snapshot novo com operation = replace
SELECT snapshot_id, operation, summary
FROM "trabalho_final_aluno"."pedidos_iceberg$snapshots"
ORDER BY committed_at DESC
LIMIT 5;