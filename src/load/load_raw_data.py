from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text

from src.config.settings import DATABASE_URL, RAW_DATA_DIR


RAW_TABLES = {
    "olist_customers_dataset.csv": "customers",
    "olist_orders_dataset.csv": "orders",
    "olist_order_items_dataset.csv": "order_items",
    "olist_order_payments_dataset.csv": "payments",
    "olist_products_dataset.csv": "products",
    "olist_sellers_dataset.csv": "sellers",
    "olist_order_reviews_dataset.csv": "reviews",
    "olist_geolocation_dataset.csv": "geolocation",
    "product_category_name_translation.csv": "product_category_translation",
}


def create_raw_schema(engine) -> None:
    with engine.begin() as connection:
        connection.execute(text("CREATE SCHEMA IF NOT EXISTS raw;"))


def load_csv_to_postgres(file_path: Path, table_name: str, engine) -> int:
    df = pd.read_csv(file_path)

    df["source_file"] = file_path.name
    df["loaded_at"] = pd.Timestamp.now()

    df.to_sql(
        name=table_name,
        con=engine,
        schema="raw",
        if_exists="replace",
        index=False,
        method="multi",
        chunksize=5000,
    )

    return len(df)


def main() -> None:
    engine = create_engine(DATABASE_URL)

    create_raw_schema(engine)

    print("Starting raw data ingestion...\n")

    total_loaded = 0

    for file_name, table_name in RAW_TABLES.items():
        file_path = RAW_DATA_DIR / file_name

        if not file_path.exists():
            print(f"[SKIPPED] File not found: {file_name}")
            continue

        rows_loaded = load_csv_to_postgres(file_path, table_name, engine)
        total_loaded += rows_loaded

        print(f"[OK] {file_name} -> raw.{table_name} | rows: {rows_loaded}")

    print("\nRaw data ingestion completed.")
    print(f"Total rows loaded: {total_loaded}")


if __name__ == "__main__":
    main()