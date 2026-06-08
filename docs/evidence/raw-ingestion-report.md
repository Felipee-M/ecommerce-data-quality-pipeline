# Raw Data Ingestion Report

## Objective

Load raw CSV files from the Olist Brazilian E-commerce dataset into PostgreSQL using the `raw` schema.

## Dataset

Dataset: Brazilian E-Commerce Public Dataset by Olist

## Source Files

| Source File | Raw Table | Status |
|---|---|---|
| olist_customers_dataset.csv | raw.customers | Loaded |
| olist_orders_dataset.csv | raw.orders | Loaded |
| olist_order_items_dataset.csv | raw.order_items | Loaded |
| olist_order_payments_dataset.csv | raw.payments | Loaded |
| olist_products_dataset.csv | raw.products | Loaded |
| olist_sellers_dataset.csv | raw.sellers | Loaded |
| olist_order_reviews_dataset.csv | raw.reviews | Loaded |
| olist_geolocation_dataset.csv | raw.geolocation | Optional |
| product_category_name_translation.csv | raw.product_category_translation | Optional |

## Ingestion Process

1. CSV files were stored locally in `data/raw/`.
2. The PostgreSQL database was started using Docker Compose.
3. The `raw` schema was created.
4. Each CSV file was loaded into a corresponding raw table.
5. Row count validation was executed comparing CSV rows with database rows.

## Validation Criteria

The ingestion is considered successful when:

- all required files are found;
- all required raw tables are created;
- CSV row counts match database table row counts;
- no critical error occurs during the ingestion process.

## Evidence

Command used to run ingestion:

```bash
python -m src.load.load_raw_data
```

Command used to validate row counts:

```
python -m src.quality.validate_raw_counts
```
## Result

Status: Passed

## Notes

Raw tables preserve source data with minimal transformation.
Additional columns source_file and loaded_at were added for traceability.