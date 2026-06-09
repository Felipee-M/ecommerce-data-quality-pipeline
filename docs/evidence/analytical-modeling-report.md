# Analytical Modeling Report

## Objective

Create standardized staging models and business-oriented analytical marts from the raw e-commerce data.

## Architecture

```text
raw
 ↓
staging
 ↓
marts
```
## Staging Models

| Model                   | Description                                       |
| ----------------------- | ------------------------------------------------- |
| staging.stg_customers   | Standardized customer data                        |
| staging.stg_orders      | Standardized order data with timestamp conversion |
| staging.stg_order_items | Standardized order item data                      |
| staging.stg_payments    | Standardized payment data                         |
| staging.stg_products    | Product data with translated category names       |
| staging.stg_sellers     | Standardized seller data                          |
| staging.stg_reviews     | Standardized review data                          |

## Analytical Marts

| Mart                            | Business Purpose                                             |
| ------------------------------- | ------------------------------------------------------------ |
| marts.mart_sales                | Analyze revenue, orders, items, freight and payment behavior |
| marts.mart_customer_behavior    | Analyze customer purchase behavior and total spend           |
| marts.mart_delivery_performance | Analyze delivery time, delays and delivery performance       |

## Validation Criteria

The analytical models are considered valid when:
```
-staging row counts match raw row counts for core entities;
-mart sales order count matches staging orders;
-mart sales payment total matches staging payments;
-delivery performance mart contains one row per order.
```
## Commands

Create models:
```
python -m src.transform.run_models
```
Validate models:
```
python -m src.quality.validate_models
```
## Execution Result

The analytical models were successfully created and validated.

Executed commands:

```bash
python -m src.transform.run_models
python -m src.quality.validate_models
```

## Result

All analytical model validations passed.

## Notes

The marts were designed to avoid metric duplication, especially when combining order items and payments.