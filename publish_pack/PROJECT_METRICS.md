# Project Metrics Snapshot

## Technical Metrics
- dbt version: 1.11.8
- adapter: dbt-snowflake 1.11.4
- models: 8
- data tests: 37
- sources: 6
- exposures: 1
- macros: 524

## Pipeline Health
- `dbt debug`: pass
- `dbt source freshness`: executing for all sources
- `dbt build`: pass

Latest build summary:
`PASS=45, WARN=0, ERROR=0, SKIP=0, NO-OP=1, TOTAL=46`

## Quality Controls Implemented
- Key integrity tests (not_null, unique)
- Relationship tests across core entities
- Accepted value tests for controlled categories
- Singular reconciliation tests:
  - test_mart_value_reconciliation
  - test_mart_order_count_reconciliation
  - test_mart_payment_reconciliation

## Data Product Outputs
Primary mart:
- `mart_executive_daily_kpis`

Core delivered KPIs:
- total_orders
- total_customers
- gross_order_value
- total_payment_value
- avg_payment_order_delta
- avg_review_score
- on_time_delivery_rate
- canceled_order_rate

## Operational Assets
- `run_pipeline.ps1` one-command execution
- `dbt docs generate` artifacts
- lineage graph with source-to-mart-to-exposure path
- phase refresh documentation for auditability and revision