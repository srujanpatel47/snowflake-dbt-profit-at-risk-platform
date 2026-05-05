with orders as (
    select
        order_id,
        customer_id,
        order_status,
        order_purchase_ts,
        order_approved_ts,
        order_delivered_carrier_ts,
        order_delivered_customer_ts,
        order_estimated_delivery_ts
    from {{ ref('stg_orders') }}
),

item_agg as (
    select
        order_id,
        sum(price) as items_gross_value,
        sum(freight_value) as freight_value,
        count(*) as item_count
    from {{ ref('stg_order_items') }}
    group by 1
),

payment_agg as (
    select
        order_id,
        sum(payment_value) as payment_value_total,
        max(payment_sequential) as payment_event_count
    from {{ ref('stg_payments') }}
    group by 1
),

review_agg as (
    select
        order_id,
        avg(review_score) as avg_review_score,
        count(*) as review_count
    from {{ ref('stg_reviews') }}
    group by 1
)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_ts,
    o.order_approved_ts,
    o.order_delivered_carrier_ts,
    o.order_delivered_customer_ts,
    o.order_estimated_delivery_ts,

    ia.items_gross_value,
    ia.freight_value,
    ia.item_count,

    pa.payment_value_total,
    pa.payment_event_count,

    ra.avg_review_score,
    ra.review_count,

    -- Derived metrics
    coalesce(ia.items_gross_value, 0) + coalesce(ia.freight_value, 0) as order_gross_plus_freight,
    coalesce(pa.payment_value_total, 0) - (coalesce(ia.items_gross_value, 0) + coalesce(ia.freight_value, 0)) as payment_to_order_delta

from orders o
left join item_agg ia on o.order_id = ia.order_id
left join payment_agg pa on o.order_id = pa.order_id
left join review_agg ra on o.order_id = ra.order_id