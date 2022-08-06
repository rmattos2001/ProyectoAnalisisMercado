WITH drop_first_reg AS (
	SELECT *
	FROM orders
	where col0 != '"order_id"' LIMIT 10
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
        cast (order_purchase_timestamp as date)as purchase_date,
        cast(order_approved_at as date )as approved_date,
        cast(order_delivered_carrier_date as date)as delivered_carrier_date,
        cast(order_delivered_customer_date as date)as delivered_customer_date,
        cast(order_estimated_delivery_date as date)as estimated_delivery_date
from orders_parsed), 
complete_approved_date as (
select  order_id,
        customer_id,
        order_status,
        purchase_date,
        case 
        when delivered_carrier_date IS NOT NULL OR delivered_customer_date IS NOT NULL
        then coalesce(approved_date, purchase_date)
        else approved_date
        end as approved_date,
        delivered_carrier_date,
        delivered_customer_date,
        estimated_delivery_date
 from obtain_dates)

select *
from complete_approved_date