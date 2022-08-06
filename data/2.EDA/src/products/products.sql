WITH select_columns_products as (
    SELECT product_id,
           product_category_name
    FROM products
),
     products_parsed as (
         SELECT TRIM(REPLACE("product_id", '"', '')) as product_id,
                product_category_name
         FROM select_columns_products
         )
SELECT * FROM products_parsed