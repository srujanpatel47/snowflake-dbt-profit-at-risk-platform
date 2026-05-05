select
    review_id,
    order_id,
    try_to_number(review_score) as review_score,
    trim(review_comment_title) as review_comment_title,
    trim(review_comment_message) as review_comment_message,
    try_to_timestamp_ntz(review_creation_date) as review_creation_ts,
    try_to_timestamp_ntz(review_answer_timestamp) as review_answer_ts
from {{ source('raw', 'RAW_REVIEWS') }}