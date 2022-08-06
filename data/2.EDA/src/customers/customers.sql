WITH select_columns_customers as (
    SELECT customer_id,
           customer_zip_code_prefix
    FROM customers
),
     customers_parsed as (
         SELECT TRIM(REPLACE("customer_id", '"', '')) as customer_id,
                TRIM(REPLACE("customer_zip_code_prefix", '"', '')) as customer_zip_code_prefix
         FROM select_columns_customers
         ),
     customers_casted as (
       SELECT customer_id,
              cast(customer_zip_code_prefix as BIGINT) as customer_zip_code_prefix
       FROM customers_parsed
     )
SELECT * FROM customers_casted