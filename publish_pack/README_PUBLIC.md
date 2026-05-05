# Profit-at-Risk Command Center (dbt + Snowflake)

An end-to-end analytics engineering project that transforms raw operational data into trusted executive KPIs using dbt and Snowflake.

---

## Project Objective

Build a production-style ELT pipeline that:
- ingests raw multi-table data,
- applies layered transformations,
- enforces quality controls,
- and publishes decision-ready marts with lineage and documentation.

---

## Architecture

**Snowflake Schemas**
- `RAW`: landed source data
- `STAGING`: cleaned and typed source-aligned models
- `INTERMEDIATE`: reusable enriched models
- `MART`: final business KPI outputs

**dbt Layers**
- `models/staging/*`
- `models/intermediate/*`
- `models/marts/*`
- `tests/reconciliation/*`

---

## Key Models

- `stg_customers`, `stg_orders`, `stg_order_items`, `stg_payments`, `stg_products`, `stg_reviews`
- `int_order_value_enriched`
- `mart_executive_daily_kpis`

---

## Data Quality & Controls

Implemented:
- Generic tests: `not_null`, `unique`, `relationships`, `accepted_values`
- Source freshness checks on all RAW sources
- Exposure metadata for dashboard lineage
- Reconciliation controls (singular tests):
  1. order value reconciliation
  2. order count reconciliation
  3. payment total reconciliation

---

## Operationalization

- One-command execution script: `run_pipeline.ps1`
- docs + lineage generation via:
  - `dbt docs generate`
  - `dbt docs serve`
- repeatable full build:
  - `dbt build`

---

## Verified Build Status

Latest successful run:
- Models: 8
- Data Tests: 37
- Sources: 6
- Exposure: 1
- Full build summary: `PASS=45, WARN=0, ERROR=0, SKIP=0, NO-OP=1, TOTAL=46`

---

## Business KPIs Delivered

From `mart_executive_daily_kpis`:
- total orders
- total customers
- gross order value
- total payment value
- average payment delta
- average review score
- on-time delivery rate
- canceled order rate

---

## How to Run

```bash
dbt debug
dbt source freshness
dbt build
dbt docs generate