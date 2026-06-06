#!/usr/bin/env bash
set -Eeuo pipefail

#Tarefa 1 - Provisionamento do bucket e dataset
cd /workspaces/FIAP-Data-Warehouse-Lakehouse-e-Data-Mesh/04-Trabalho-Final
bash scripts/setup_aluno.sh

#Tarefa 2 - Catalogar no Glue com Crawler
aws s3 ls s3://tf-aluno-$(aws sts get-caller-identity --query Account --output text)/bruto/ --recursive
cd /workspaces/FIAP-Data-Warehouse-Lakehouse-e-Data-Mesh/04-Trabalho-Final && \
  bash scripts/setup_glue_crawler.sh

export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

bash scripts/run_athena_sql.sh sql/01_create_iceberg_tables_clientes.sql
bash scripts/run_athena_sql.sh sql/02_create_iceberg_tables_pedidos.sql
bash scripts/run_athena_sql.sh sql/03_show_tables.sql
bash scripts/run_athena_sql.sh sql/04_insert_data_clientes.sql
bash scripts/run_athena_sql.sh sql/05_insert_data_pedidos.sql
bash scripts/run_athena_sql.sh sql/06_validar_insert.sql
bash scripts/run_athena_sql.sh sql/07_add_calculated_column.sql
bash scripts/run_athena_sql.sh sql/08_merge_delta.sql
bash scripts/run_athena_sql.sh sql/09_optimize.sql
bash scripts/run_athena_sql.sh sql/10_vacum.sql
bash scripts/run_athena_sql.sh sql/11_validar_apos_optimize.sql
bash scripts/run_athena_sql.sh sql/12_query_executiva.sql

# Esvazia o bucket (necessario antes de deletar)
aws s3 rm "s3://tf-aluno-$(aws sts get-caller-identity --query Account --output text)" --recursive

# Apaga o bucket
aws s3 rb "s3://tf-aluno-$(aws sts get-caller-identity --query Account --output text)"