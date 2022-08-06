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

def create_calendar(start, end):
    df = pd.DataFrame({"Date": pd.date_range(start, end)})
    
    df["Day"] = df.Date.dt.day_name()
    df["Week"] = df.Date.dt.weekofyear
    df["Quarter"] = df.Date.dt.quarter
    df["Year"] = df.Date.dt.year
    df["Year_half"] = (df.Quarter + 1) // 2
    df["Month"] = df.Date.dt.month_name()
    df["Date"]=df.Date.dt.date
    table_name= "calendar"
    to_sql(df, table_name, conn, f"s3://olist-data-wh/{table_name}",
    schema="olist_dwh", index=False, if_exists="replace",
    executor_class=ProcessPoolExecutor)
    print(f'Tabla {table_name} creada')
    return df
