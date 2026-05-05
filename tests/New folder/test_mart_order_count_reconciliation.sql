with int_agg as (
    select
        cast(order_purchase_ts as date) as order_date,
        count(distinct order_id) as int_total_orders
    from {{ ref('int_order_value_enriched') }}
    where order_purchase_ts is not null
    group by 1
),

mart_agg as (
    select
        order_date,
        total_orders as mart_total_orders
    from {{ ref('mart_executive_daily_kpis') }}
),

joined as (
    select
        coalesce(i.order_date, m.order_date) as order_date,
        coalesce(i.int_total_orders, 0) as int_cnt,
        coalesce(m.mart_total_orders, 0) as mart_cnt,
        abs(coalesce(i.int_total_orders, 0) - coalesce(m.mart_total_orders, 0)) as abs_diff
    from int_agg i
    full outer join mart_agg m
        on i.order_date = m.order_date
)

select *
from joined
where abs_diff != 0