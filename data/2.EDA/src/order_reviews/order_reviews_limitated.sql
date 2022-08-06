WITH reviews_parsed as (
    SELECT trim(replace("order_id",'"','')) as order_id,
    review_score
    FROM order_reviews LIMIT 10)
SELECT * FROM reviews_parsed;