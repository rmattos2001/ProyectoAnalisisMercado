from util import create_table, review_table
from _calendar.calendar import create_calendar

list_tables = [
    {"table_name": "closed_deals", "table_type": "fact", "primary_key": ["seller_id"]},
    {"table_name": "customers", "table_type": "dim", "primary_key": ["customer_id"]},
    {
        "table_name": "order_items",
        "table_type": "fact",
        "primary_key": ["order_item_id", "order_id"],
    },
    {
        "table_name": "order_payments",
        "table_type": "fact",
        "primary_key": ["order_id", "payment_sequential"],
    },
    {
        "table_name": "order_reviews",
        "table_type": "fact",
        "primary_key": ["order_id", "review_score"],
    },
    {"table_name": "orders", "table_type": "fact", "primary_key": ["order_id"]},
    {"table_name": "products", "table_type": "dim", "primary_key": ["product_id"]},
    {"table_name": "sellers", "table_type": "dim", "primary_key": ["seller_id"]},
    {
        "table_name": "geolocation",
        "table_type": "dim",
        "primary_key": ["geolocation_zip_code_prefix"],
    }
]


"""
Construyendo tablas normalizadas
"""
def build_tables():
    #sufix = "_limitated"
    sufix = ""
    for table in list_tables:
        table_name = table["table_name"]
        table_type = table["table_type"]
        primary_key = table["primary_key"]

        with open(f"src/{table_name}/{table_name}{sufix}.sql") as file:
            query = file.read()
            create_table(query, f"{table_type}_{table_name}", primary_key)


def build_olist():
    with open("src/olist/olist.sql") as file:
        query = file.read()
        create_table(query, "olist", None)


list_geo_city_tables = [{"table_name": "customer_geolocation_city", "table_type": "table", "primary_key": None},
                        {"table_name": "seller_geolocation_city", "table_type": "table", "primary_key":None}]
def build_geo_city_tables():
     #sufix = "_limitated"
    sufix = ""
    for table in list_geo_city_tables:
        table_name = table["table_name"]
        table_type = table["table_type"]
        primary_key = table["primary_key"]

        with open(f"src/{table_name}/{table_name}{sufix}.sql") as file:
            query = file.read()
            create_table(query, f"{table_type}_{table_name}", primary_key)


create_calendar('2010-01-01','2025-12-31')
review_table(table_name="dim_prefix", primary_key=["cep"])
build_tables()    
build_olist()
build_geo_city_tables()
