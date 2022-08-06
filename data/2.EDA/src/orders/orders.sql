WITH drop_first_reg AS (
	SELECT *
	FROM orders
	where col0 != '"order_id"'
),
orders_rename_col as (
	SELECT col0 as order_id,
		col1 as customer_id,
		col2 as order_status,
		col3 as order_purchase_timestamp,
		col4 as order_approved_at,
		col5 as order_delivered_carrier_date,
		col6 as order_delivered_customer_date,
		col7 as order_estimated_delivery_date
	FROM drop_first_reg
),
orders_parsed as(
	select trim(replace("order_id", '"', '')) as order_id,
		trim(replace("customer_id", '"', '')) as customer_id,
		trim(lower("order_status")) as order_status,
		try(
			date_parse(trim("order_purchase_timestamp"), '%Y-%m-%d %T')
		) as order_purchase_timestamp,
		try(
			date_parse(trim("order_approved_at"), '%Y-%m-%d %T')
		) as order_approved_at,
		try(
			date_parse(
				trim("order_delivered_carrier_date"),
				'%Y-%m-%d %T'
			)
		) as order_delivered_carrier_date,
		try(
			date_parse(
				trim("order_delivered_customer_date"),
				'%Y-%m-%d %T'
			)
		) as order_delivered_customer_date,
		try(
			date_parse(
				trim("order_estimated_delivery_date"),
				'%Y-%m-%d %T'
			)
		) as order_estimated_delivery_date
	from orders_rename_col
),
obtain_dates as(
select order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        cast (order_purchase_timestamp as date)as purchase_date,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        cast(order_delivered_customer_date as date)as delivered_customer_date,
        order_estimated_delivery_date,
        cast(order_estimated_delivery_date as date)as estimated_delivery_date
from orders_parsed), 
complete_approved_date as (
select  order_id,
        customer_id,
        order_status,
        order_purchase_timestamp,
        purchase_date,
        case 
        when order_delivered_carrier_date IS NOT NULL OR order_delivered_customer_date IS NOT NULL
        then coalesce(order_approved_at, order_purchase_timestamp)
        else order_approved_at
        end as order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        delivered_customer_date,
        order_estimated_delivery_date,
        estimated_delivery_date
 from obtain_dates)

select *
from complete_approved_date
