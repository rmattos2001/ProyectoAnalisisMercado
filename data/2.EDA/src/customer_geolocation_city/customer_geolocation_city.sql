Select a.customer_id, a.customer_zip_code_prefix,b.city,b.state_name,c.geolocation_lat,c.geolocation_lng
FROM "olist_dwh"."dim_customers" a 
left join "olist_dwh"."dim_prefix" b on b.cep = a.customer_zip_code_prefix
left join "olist_dwh"."dim_geolocation" c on c.geolocation_zip_code_prefix = a.customer_zip_code_prefix;
