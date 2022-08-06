WITH select_columns_sellers as (
    SELECT seller_id,
           seller_zip_code_prefix
    FROM sellers LIMIT 10
),
     sellers_parsed as (
         SELECT TRIM(REPLACE("seller_id", '"', '')) as seller_id,
                TRIM(REPLACE("seller_zip_code_prefix", '"', '')) as seller_zip_code_prefix
         FROM select_columns_sellers
         )
SELECT * FROM sellers_parsed