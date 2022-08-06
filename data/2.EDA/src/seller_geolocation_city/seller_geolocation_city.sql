Select a.seller_id, a.seller_zip_code_prefix,b.city,b.state_name,c.geolocation_lat,c.geolocation_lng
FROM "olist_dwh"."dim_sellers" a 
left join "olist_dwh"."dim_prefix" b on b.cep = a.seller_zip_code_prefix
left join "olist_dwh"."dim_geolocation" c on c.geolocation_zip_code_prefix = a.seller_zip_code_prefix;