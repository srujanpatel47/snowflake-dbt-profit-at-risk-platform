with base as (
    select
        cast(order_purchase_ts as date) as order_date,
        order_id,
        customer_id,
        order_status,
        order_gross_plus_freight,
        payment_value_total,
        payment_to_order_delta,
        avg_review_score,
        case
            when order_delivered_customer_ts is not null
                 and order_estimated_delivery_ts is not null
                 and order_delivered_customer_ts <= order_estimated_delivery_ts
            then 1 else 0
        end as delivered_on_time_flag
    from {{ ref('int_order_value_enriched') }}
    where order_purchase_ts is not null
)

select
    order_date,

    count(distinct order_id) as total_orders,
    count(distinct customer_id) as total_customers,

    sum(order_gross_plus_freight) as gross_order_value,
    sum(payment_value_total) as total_payment_value,
    avg(payment_to_order_delta) as avg_payment_order_delta,

    avg(avg_review_score) as avg_review_score,

    sum(delivered_on_time_flag) as on_time_orders,
    case
        when count(distinct order_id) = 0 then 0
        else sum(delivered_on_time_flag) * 1.0 / count(distinct order_id)
    end as on_time_delivery_rate,

    sum(case when order_status = 'canceled' then 1 else 0 end) as canceled_orders,
    case
        when count(distinct order_id) = 0 then 0
        else sum(case when order_status = 'canceled' then 1 else 0 end) * 1.0 / count(distinct order_id)
    end as canceled_order_rate

from base
group by 1