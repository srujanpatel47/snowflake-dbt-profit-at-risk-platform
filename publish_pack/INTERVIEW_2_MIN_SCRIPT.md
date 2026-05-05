
---

## 2) `publish_pack/INTERVIEW_2_MIN_SCRIPT.md`

```markdown
# 2-Minute Interview Script

I built a project called **Profit-at-Risk Command Center** using **dbt and Snowflake**.

The goal was to convert raw multi-table source data into trusted executive KPIs using a production-style data architecture. I used layered schemas — RAW, STAGING, INTERMEDIATE, and MART — to separate source landing, standardization, reusable transformations, and final reporting outputs.

In staging, I cleaned and typed source tables and applied structural tests like not_null, unique, relationships, and accepted_values. Then I built an intermediate order-level enriched model and finally a mart-level daily KPI table with metrics like total orders, gross value, payment value, cancellation rate, and on-time delivery rate.

To ensure metric trust, I implemented reconciliation tests between intermediate and mart layers for three core controls: order value, order count, and payment totals. All controls pass in full pipeline execution.

I also enabled source freshness monitoring, generated dbt docs with lineage, and added a dashboard exposure node so downstream dependencies are explicit.

The final pipeline is operationalized with a one-command script and full `dbt build` passes with zero errors, which makes the solution both interview-ready and close to production standards.