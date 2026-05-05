with int_agg as (
    select
        cast(order_purchase_ts as date) as order_date,
        sum(order_gross_plus_freight) as int_gross_order_value
    from {{ ref('int_order_value_enriched') }}
    where order_purchase_ts is not null
    group by 1
),

mart_agg as (
    select
        order_date,
        sum(gross_order_value) as mart_gross_order_value
    from {{ ref('mart_executive_daily_kpis') }}
    group by 1
),

joined as (
    select
        coalesce(i.order_date, m.order_date) as order_date,
        coalesce(i.int_gross_order_value, 0) as int_val,
        coalesce(m.mart_gross_order_value, 0) as mart_val,
        abs(coalesce(i.int_gross_order_value, 0) - coalesce(m.mart_gross_order_value, 0)) as abs_diff
    from int_agg i
    full outer join mart_agg m
        on i.order_date = m.order_date
)

select *
from joined
where abs_diff > 0.01