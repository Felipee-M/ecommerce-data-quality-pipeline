# Process Map

## Data Pipeline Process

```text
CSV Files
   ↓
Raw Layer - PostgreSQL
   ↓
Staging Layer - cleaned and standardized data
   ↓
Marts Layer - business metrics
   ↓
Quality Checks
   ↓
API / Dashboard / Reports
```

## Process Steps
```
| Step | Description                   | Output                |
| ---- | ----------------------------- | --------------------- |
| 1    | Extract CSV files             | DataFrames            |
| 2    | Load raw data into PostgreSQL | Raw tables            |
| 3    | Clean and standardize data    | Staging tables        |
| 4    | Create analytical models      | Marts                 |
| 5    | Apply data quality checks     | Quality report        |
| 6    | Expose metrics                | API and dashboard     |
| 7    | Review results                | Insights and evidence |
```
## Quality Control Points
```
| Control Point          | Validation                               |
| ---------------------- | ---------------------------------------- |
| CSV reading            | File exists and has expected columns     |
| Raw loading            | Row count validation                     |
| Staging transformation | Data types and null checks               |
| Marts creation         | Business metric validation               |
| Data quality           | Rule execution and nonconformity records |
| Dashboard              | KPI consistency with marts               |
```