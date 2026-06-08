# E-commerce Data Quality Pipeline

End-to-end data quality and analytics pipeline for Brazilian e-commerce data using Python, PostgreSQL, automated tests, QA practices and BI dashboard.

## Project Overview

This project simulates a professional data workflow for an e-commerce business.

The goal is to transform raw CSV files into reliable analytical datasets, applying data ingestion, PostgreSQL modeling, data quality checks, automated tests and business intelligence visualization.

## Business Context

E-commerce companies rely on accurate data to monitor sales, customer behavior and delivery performance.

However, raw data may contain missing values, duplicates, invalid statuses or inconsistent business rules. This project aims to create a reliable data pipeline that improves confidence in analytical outputs.

## Project Goals

- Load raw CSV files into PostgreSQL.
- Create raw, staging and marts layers.
- Build analytical models for sales, customers and delivery.
- Apply data quality checks.
- Create automated tests with pytest.
- Expose business metrics through an API.
- Build a Power BI dashboard.
- Document project management and quality practices.

## Tech Stack

- Python
- Pandas
- PostgreSQL
- Docker
- SQL
- Pytest
- FastAPI
- Power BI
- GitHub Actions

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
├── .gitignore
└── README.md
```

## Data Architecture
```
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
API / Dashboard
```
## Quality and Management Practices
```
This project includes documentation and practices inspired by:

Agile project management
Scrum artifacts
OKRs
Lean thinking and continuous improvement
ISO 9001 quality management principles
QA test planning
Nonconformity records
Corrective actions
```
## Current Status

Sprint 1 — Planning and setup: in progress.

## How to Run the Database
```
docker compose up -d
```
Check running containers:
```
docker ps
```
Access PostgreSQL:
```
docker exec -it ecommerce_postgres psql -U postgres -d ecommerce_dw
```
## Author
```
Felipe Mendes
Portfolio: https://felipe-mendes-portfolio.vercel.app
GitHub: https://github.com/Felipee-M
LinkedIn: https://www.linkedin.com/in/felipemendessantos
```

