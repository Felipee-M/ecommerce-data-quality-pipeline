# Risk Matrix

| ID | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| R-001 | Dataset files are too large to version in GitHub | Medium | Medium | Do not commit raw CSV files; document download source |
| R-002 | PostgreSQL port conflict with local installation | Medium | Medium | Use external port 5433 in Docker Compose |
| R-003 | Data contains unexpected null values | High | High | Create data quality checks and nonconformity records |
| R-004 | Scope becomes too large | Medium | High | Work by sprints and prioritize MVP deliverables |
| R-005 | Dashboard metrics do not match SQL results | Medium | High | Validate Power BI KPIs against marts |
| R-006 | API tests become complex too early | Low | Medium | Implement API only after marts are stable |