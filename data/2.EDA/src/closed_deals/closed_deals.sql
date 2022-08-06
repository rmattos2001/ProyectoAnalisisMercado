WITH select_columns_closed_deals as (
    SELECT  seller_id,
            business_segment,
            business_type
    FROM closed_deals),
closed_deals_parsed as(
    SELECT trim(lower("seller_id"))as seller_id,
            case 
            WHEN length(TRIM("business_segment"))>0 then trim(lower("business_segment"))
            else 'sin_dato'
            END
            as business_segment,
            case 
            WHEN length(TRIM("business_type"))>0 then trim(lower("business_type"))
            else 'sin_dato'
            END
            as business_type
    from select_columns_closed_deals)

select * from closed_deals_parsed;