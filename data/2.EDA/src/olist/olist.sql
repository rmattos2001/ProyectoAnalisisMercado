select	
a.order_id,
a.order_status,
a.customer_id,
a.order_purchase_timestamp,
a.purchase_date,
a.order_approved_at,
a.order_delivered_carrier_date,
a.order_delivered_customer_date,
a.delivered_customer_date,
a.order_estimated_delivery_date,
a.estimated_delivery_date,
b.order_item_id,
b.product_id,
b.seller_id,
b.price,
b.freight_value,
c.payment_sequential,
c.payment_type,
c.payment_installments,
c.payment_value,
d.review_score
from "olist_dwh"."fact_orders" a 
left join "olist_dwh"."fact_order_items" b on a.order_id=b.order_id
left join "olist_dwh"."fact_order_payments" c on a.order_id=c.order_id
left join "olist_dwh"."fact_order_reviews" d on a.order_id=d.order_id