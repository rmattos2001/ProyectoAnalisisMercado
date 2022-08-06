WITH select_columns_reviews as(
SELECT order_id,
        order_item_id,
        product_id,
        seller_id,
        price,
        freight_value
FROM order_items),
reviews_parsed as(
	select trim(replace("order_id", '"', '')) as order_id,
	    order_item_id,
		trim(replace("product_id", '"', '')) as product_id,
		trim(replace("seller_id", '"', '')) as seller_id,
		price,
        freight_value
	from select_columns_reviews
)

select *
from reviews_parsed;