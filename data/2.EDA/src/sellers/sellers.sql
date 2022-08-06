WITH select_columns_sellers as (
    SELECT seller_id,
           seller_zip_code_prefix
    FROM sellers
),
     sellers_parsed as (
         SELECT TRIM(REPLACE("seller_id", '"', '')) as seller_id,
                TRIM(REPLACE("seller_zip_code_prefix", '"', '')) as seller_zip_code_prefix
         FROM select_columns_sellers
         ),
     sellers_casted as(
       SELECT seller_id,
              cast(seller_zip_code_prefix as BIGINT) as seller_zip_code_prefix
       FROM sellers_parsed
     )
SELECT * FROM sellers_casted