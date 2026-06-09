# E-commerce Data Quality Pipeline

End-to-end data quality and analytics pipeline for Brazilian e-commerce data using Python, PostgreSQL, automated tests, QA practices and BI dashboard.

## Project Overview

This project simulates a professional data workflow for an e-commerce business.

The goal is to transform raw CSV files into reliable analytical datasets, applying data ingestion, PostgreSQL modeling, analytical transformations, data quality checks, automated validations, QA documentation and business intelligence visualization.

The project is structured using a layered data architecture:

```text
CSV Files
   ↓
Raw Layer
   ↓
Staging Layer
   ↓
Marts Layer
   ↓
Quality Checks
   ↓
API / Dashboard / Reports
```

## Business Context

E-commerce companies rely on accurate data to monitor sales performance, customer behavior and delivery efficiency.

However, raw data may contain missing values, duplicated records, invalid statuses, inconsistent dates or business rule violations. Without proper validation, dashboards and reports may lead to incorrect decisions.

This project aims to create a reliable data pipeline that improves confidence in analytical outputs.

## Project Goals

* Load raw CSV files into PostgreSQL.
* Create raw, staging and marts layers.
* Build analytical models for sales, customers and delivery performance.
* Apply data quality checks.
* Create automated tests with pytest.
* Expose business metrics through an API.
* Build a BI dashboard.
* Document project management and quality practices.

## Tech Stack

* Python
* Pandas
* SQLAlchemy
* PostgreSQL
* Docker
* SQL
* Pytest
* FastAPI
* Power BI
* GitHub Actions

## Dataset

Dataset used:

**Brazilian E-Commerce Public Dataset by Olist**

Main files used:

| Source File                             | Raw Table                          |
| --------------------------------------- | ---------------------------------- |
| `olist_customers_dataset.csv`           | `raw.customers`                    |
| `olist_orders_dataset.csv`              | `raw.orders`                       |
| `olist_order_items_dataset.csv`         | `raw.order_items`                  |
| `olist_order_payments_dataset.csv`      | `raw.payments`                     |
| `olist_products_dataset.csv`            | `raw.products`                     |
| `olist_sellers_dataset.csv`             | `raw.sellers`                      |
| `olist_order_reviews_dataset.csv`       | `raw.reviews`                      |
| `olist_geolocation_dataset.csv`         | `raw.geolocation`                  |
| `product_category_name_translation.csv` | `raw.product_category_translation` |

Raw CSV files are not versioned in this repository. They must be stored locally in:

```text
data/raw/
```

## Project Structure

```text
ecommerce-data-quality-pipeline/
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── sample/
│
├── src/
│   ├── config/
│   ├── extract/
│   ├── load/
│   ├── transform/
│   ├── quality/
│   └── api/
│
├── sql/
│   ├── raw/
│   ├── staging/
│   ├── marts/
│   └── quality_checks/
│
├── tests/
│   ├── unit/
│   ├── integration/
│   └── api/
│
├── qa/
│
├── dashboards/
│   ├── power-bi/
│   └── screenshots/
│
├── docs/
│   ├── management/
│   ├── quality-management/
│   ├── sprints/
│   └── evidence/
│
├── .github/
│   └── workflows/
│
├── docker-compose.yml
├── requirements.txt
├── .env.example
├── .gitignore
└── README.md
```

## Data Layers

## Raw Layer

The raw layer stores source data loaded from CSV files with minimal transformation.

Main objective:

* Preserve the original structure of the source files.
* Add basic traceability columns.
* Create a reproducible ingestion process.

Additional traceability columns:

| Column        | Description                        |
| ------------- | ---------------------------------- |
| `source_file` | Name of the original CSV file      |
| `loaded_at`   | Timestamp when the data was loaded |

## Staging Layer

The staging layer standardizes and prepares raw data for analytical use.

Main transformations:

* Standardize text fields.
* Convert date and timestamp columns.
* Convert numeric columns.
* Normalize naming patterns.
* Join product category translation data.

Staging models:

| Model                     | Description                                       |
| ------------------------- | ------------------------------------------------- |
| `staging.stg_customers`   | Standardized customer data                        |
| `staging.stg_orders`      | Standardized order data with timestamp conversion |
| `staging.stg_order_items` | Standardized order item data                      |
| `staging.stg_payments`    | Standardized payment data                         |
| `staging.stg_products`    | Product data with translated category names       |
| `staging.stg_sellers`     | Standardized seller data                          |
| `staging.stg_reviews`     | Standardized review data                          |

## Marts Layer

The marts layer contains business-oriented analytical views designed for reporting, dashboards and metric validation.

Main marts:

| Mart                              | Business Purpose                                                    |
| --------------------------------- | ------------------------------------------------------------------- |
| `marts.mart_sales`                | Analyze revenue, orders, items, freight and payment behavior        |
| `marts.mart_customer_behavior`    | Analyze customer purchase behavior, order frequency and total spend |
| `marts.mart_delivery_performance` | Analyze delivery time, delays and delivery status                   |

## Sprint Progress

| Sprint   | Name                | Status      | Main Deliverable                                                     |
| -------- | ------------------- | ----------- | -------------------------------------------------------------------- |
| Sprint 1 | Planning and Setup  | Completed   | Project structure, Docker/PostgreSQL setup and initial documentation |
| Sprint 2 | Raw Data Ingestion  | Completed   | CSV ingestion into PostgreSQL raw tables with row count validation   |
| Sprint 3 | Analytical Modeling | Completed | Staging models, analytical marts and model validation                |

## Sprint 1 — Planning and Setup

Sprint 1 created the professional foundation of the project.

### Main Deliverables

* Repository created.
* Project folder structure created.
* Docker Compose configured with PostgreSQL.
* Initial README created.
* `.gitignore` configured.
* `requirements.txt` created.
* `.env.example` created.
* Project management documentation created.
* Quality management documentation created.

### Management Artifacts

| Document                                | Purpose                                                      |
| --------------------------------------- | ------------------------------------------------------------ |
| `docs/management/product-vision.md`     | Defines project vision, target audience and business problem |
| `docs/management/okrs.md`               | Defines measurable project objectives                        |
| `docs/management/product-backlog.md`    | Tracks backlog items by sprint                               |
| `docs/management/definition-of-done.md` | Defines completion criteria                                  |
| `docs/management/risk-matrix.md`        | Documents project risks and mitigation actions               |
| `docs/management/project-roadmap.md`    | Defines the sprint roadmap                                   |
| `docs/management/decision-log.md`       | Tracks technical and project decisions                       |

### Quality Management Artifacts

| Document                                            | Purpose                                           |
| --------------------------------------------------- | ------------------------------------------------- |
| `docs/quality-management/quality-policy.md`         | Defines quality principles applied to the project |
| `docs/quality-management/process-map.md`            | Maps the data pipeline process                    |
| `docs/quality-management/nonconformities.md`        | Tracks data or process nonconformities            |
| `docs/quality-management/corrective-actions.md`     | Tracks corrective actions                         |
| `docs/quality-management/continuous-improvement.md` | Tracks improvement opportunities                  |

## Sprint 2 — Raw Data Ingestion

Sprint 2 implemented the raw data ingestion process.

### Main Deliverables

* Raw schema created in PostgreSQL.
* CSV ingestion script created.
* Olist CSV files loaded into raw tables.
* Row count validation script created.
* Ingestion evidence documented.
* Sprint documentation updated.

### Ingestion Script

```bash
python -m src.load.load_raw_data
```

This script:

* creates the `raw` schema if it does not exist;
* reads CSV files from `data/raw/`;
* loads each file into a corresponding PostgreSQL table;
* adds traceability columns;
* prints the number of loaded rows.

### Row Count Validation

```bash
python -m src.quality.validate_raw_counts
```

This validation compares:

* number of rows in each CSV file;
* number of rows loaded into each PostgreSQL raw table.

The ingestion is considered valid when the CSV row count matches the database row count for each loaded table.

### Raw Ingestion Evidence

Evidence file:

```text
docs/evidence/raw-ingestion-report.md
```

## Sprint 3 — Analytical Modeling

Sprint 3 creates the analytical modeling layer of the project.

### Main Deliverables

* `staging` schema created.
* Staging views created.
* Data types standardized.
* Product category translation added.
* `marts` schema created.
* Analytical marts created.
* Model validation script created.
* Analytical modeling evidence documented.

### Run Analytical Models

```bash
python -m src.transform.run_models
```

This script executes the SQL files responsible for creating:

* staging schema;
* staging views;
* marts schema;
* analytical marts.

Expected SQL files:

```text
sql/staging/01_create_staging_schema.sql
sql/staging/02_create_staging_models.sql
sql/marts/01_create_marts_schema.sql
sql/marts/02_create_marts.sql
```

### Validate Analytical Models

```bash
python -m src.quality.validate_models
```

This validation checks if:

* staging row counts match raw row counts for core entities;
* `mart_sales` contains one row per order;
* total payment value in `mart_sales` matches staging payments;
* `mart_delivery_performance` contains one row per order.

### Analytical Modeling Evidence

Evidence file:

```text
docs/evidence/analytical-modeling-report.md
```

## How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/Felipee-M/ecommerce-data-quality-pipeline.git
cd ecommerce-data-quality-pipeline
```

### 2. Create virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Configure environment variables

Create a `.env` file based on `.env.example`:

```bash
cp .env.example .env
```

Expected variables:

```env
POSTGRES_HOST=localhost
POSTGRES_PORT=5433
POSTGRES_DB=ecommerce_dw
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
```

### 5. Start PostgreSQL with Docker

```bash
docker compose up -d
```

Check running containers:

```bash
docker ps
```

Access PostgreSQL:

```bash
docker exec -it ecommerce_postgres psql -U postgres -d ecommerce_dw
```

### 6. Run raw data ingestion

```bash
python -m src.load.load_raw_data
```

### 7. Validate raw row counts

```bash
python -m src.quality.validate_raw_counts
```

### 8. Run analytical models

```bash
python -m src.transform.run_models
```

### 9. Validate analytical models

```bash
python -m src.quality.validate_models
```

## Database Checks

List schemas:

```sql
\dn
```

List raw tables:

```sql
\dt raw.*
```

List staging views:

```sql
\dv staging.*
```

List marts views:

```sql
\dv marts.*
```

Preview a mart:

```sql
SELECT * FROM marts.mart_sales LIMIT 5;
```

## Quality and Management Practices

This project includes documentation and practices inspired by:

* Agile project management;
* Scrum artifacts;
* OKRs;
* Lean thinking and continuous improvement;
* ISO 9001 quality management principles;
* QA test planning;
* Nonconformity records;
* Corrective actions;
* Evidence-based validation.

## Quality Strategy

The quality strategy is based on prevention, traceability and validation.

Main quality controls:

| Control Point  | Validation                                              |
| -------------- | ------------------------------------------------------- |
| CSV ingestion  | Validate file existence and row counts                  |
| Raw loading    | Compare CSV rows with database rows                     |
| Staging models | Validate row count consistency and data type conversion |
| Marts          | Validate business metrics and avoid duplicated values   |
| Future tests   | Add automated test coverage with pytest                 |
| Future CI/CD   | Run validations automatically on GitHub Actions         |

## Current Status

The project currently includes:

* Professional project setup.
* Docker/PostgreSQL environment.
* Raw data ingestion.
* Raw row count validation.
* Project management documentation.
* Quality management documentation.
* Analytical modeling layer completed with staging and marts validation.

## Next Steps

Planned next steps:

* Finalize Sprint 3 analytical model validation.
* Create data dictionary.
* Create data quality rules.
* Implement not null, unique, relationship and accepted values checks.
* Create QA test plan.
* Add automated tests with pytest.
* Create FastAPI endpoints for business metrics.
* Build Power BI dashboard.
* Add GitHub Actions workflow.
* Publish case study in the visual portfolio.

## Author

# Felipe Mendes

* [Portfólio](https://felipe-mendes-portfolio.vercel.app)
* [GitHub](https://github.com/Felipee-M)
* [LinkedIn](https://www.linkedin.com/in/felipemendessantos)

