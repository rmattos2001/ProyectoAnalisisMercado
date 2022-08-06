WITH select_columns_customers as (
    SELECT customer_id,
           customer_zip_code_prefix
    FROM customers LIMIT 10
),
     customers_parsed as (
         SELECT TRIM(REPLACE("customer_id", '"', '')) as customer_id,
                TRIM(REPLACE("customer_zip_code_prefix", '"', '')) as customer_zip_code_prefix
         FROM select_columns_customers
         )
SELECT * FROM customers_parsed