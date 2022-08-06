WITH payments_parsed as(
	select trim(replace("order_id", '"', '')) as order_id,
	    payment_sequential,
		trim(lower("payment_type")) as payment_type,
		payment_installments,
	    payment_value
	FROM order_payments LIMIT 10)
select * from payments_parsed;