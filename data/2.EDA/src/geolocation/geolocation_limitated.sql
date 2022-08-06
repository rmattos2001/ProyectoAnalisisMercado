WITH select_columns_geolocation as (
    SELECT geolocation_zip_code_prefix,
           geolocation_lat,
           geolocation_lng
    FROM geolocation LIMIT 10
),
     geolocation_parsed as (
         SELECT TRIM(REPLACE("geolocation_zip_code_prefix", '"', '')) as geolocation_zip_code_prefix,
                geolocation_lat,
                geolocation_lng
         FROM select_columns_geolocation
         ),
       cast_geolocation as (
              SELECT  cast(geolocation_zip_code_prefix as bigint) as geolocation_zip_code_prefix ,
                     geolocation_lat, 
                     geolocation_lng
              FROM geolocation_parsed
              ),
       avg_geolocation as (
              select geolocation_zip_code_prefix,
                     avg(geolocation_lat) as geolocation_lat,
                     avg(geolocation_lng) as geolocation_lng
              FROM cast_geolocation
              group by geolocation_zip_code_prefix
       )
SELECT * FROM avg_geolocation;