# Sprint 02 Planning

## Sprint Goal

Load raw e-commerce CSV data into PostgreSQL and validate that all records were ingested correctly.

## Sprint Backlog

| ID | Task | Status |
|---|---|---|
| S2-001 | Download Olist dataset | Done |
| S2-002 | Store CSV files in `data/raw/` | Done |
| S2-003 | Create raw schema in PostgreSQL | Done |
| S2-004 | Create Python ingestion script | Done |
| S2-005 | Load CSV files into raw tables | Done |
| S2-006 | Validate row counts | Done |
| S2-007 | Document ingestion evidence | Done |
| S2-008 | Update README | Done |

## Definition of Done

This sprint will be considered done when:

- Olist CSV files are available locally.
- PostgreSQL is running through Docker.
- The `raw` schema exists.
- Raw tables are created in PostgreSQL.
- CSV files are loaded successfully.
- Row count validation passes.
- Ingestion report is documented.
- Changes are committed to GitHub.