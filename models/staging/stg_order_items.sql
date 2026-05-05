select
    order_id,
    try_to_number(order_item_id) as order_item_id,
    product_id,
    seller_id,
    try_to_timestamp_ntz(shipping_limit_date) as shipping_limit_ts,
    try_to_decimal(price, 12, 2) as price,
    try_to_decimal(freight_value, 12, 2) as freight_value
from {{ source('raw', 'RAW_ORDER_ITEMS') }}