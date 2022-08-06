from matplotlib.pyplot import table
from pyathena import connect
import pandas as pd
#from pandas_profiling import ProfileReport
from pyathena.pandas.util import as_pandas
from concurrent.futures.process import ProcessPoolExecutor
from pyathena import connect
from pyathena.pandas.util import to_sql

conn = connect(
    s3_staging_dir="s3://results-olist-bucket/results/",
    region_name="us-east-2",aws_access_key_id='AKIAVIHI23JPR2BQFWRX',
    aws_secret_access_key='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',
    schema_name="olist-database")

def create_table(query:str, table_name:str, primary_key:list[str]):
    cursor = conn.cursor()
    cursor.execute(query)
    query_df:pd.Dataframe = as_pandas(cursor)
    query_df.drop_duplicates(inplace=True)
    if primary_key is not None:
        review_s = query_df.duplicated(subset=primary_key)
        review_s = review_s[review_s != False]
        if review_s.count() > 0:
            raise ValueError(f"tabla {table_name} con registros duplicados para {primary_key}")
    #profile_df = ProfileReport(query_df)
    #profile_df.to_file(output_file=f"Profile_reports/{table_name}.html")
    to_sql(query_df, table_name, conn, f"s3://olist-data-wh/{table_name}",
    schema="olist_dwh", index=False, if_exists="replace",
    executor_class=ProcessPoolExecutor)
    print(f'Tabla {table_name} creada')


def review_table(table_name:str, primary_key:list[str]):
    cursor = conn.cursor()
    cursor.execute(f'select * from "olist_dwh"."{table_name}"')
    query_df:pd.Dataframe = as_pandas(cursor)
    review_s = query_df.duplicated(subset=primary_key)
    review_s = review_s[review_s != False]
    if review_s.count() > 0:
        raise ValueError(f"tabla {table_name} con registros duplicados para {primary_key}")
