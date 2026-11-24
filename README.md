# Retail Supply Chain & Operations Analytics

An end-to-end portfolio project investigating retail sales performance, customer behaviour, product/category performance, fulfilment, returns and supplier exposure using SQL, Excel and Power BI.

> **Project status: In progress.** The SQL foundation and datasets are present. Excel and Power BI deliverables, validated result tables, business recommendations and final documentation still need to be completed. This README deliberately distinguishes completed repository assets from planned work.

## Business objective

Build a reproducible analysis workflow that helps retail stakeholders answer:

1. How are revenue, order volume and average order value changing over time?
2. Which categories and products contribute most to sales, and which are weakening?
3. Which customer groups and locations contribute to sales and repeat purchasing?
4. What do shipment status and delivery timelines reveal about fulfilment?
5. Which categories and suppliers are associated with returns and refunds?
6. What actions should commercial and operations teams prioritize?

## Dataset overview

The `Datasets/` directory contains CSV files for 12 subject areas:

| Dataset | Analytical use |
|---|---|
| categories | Category-level grouping |
| customers | Customer acquisition, geography and segmentation |
| employees | Store workforce context |
| order_items | Units sold and line-item sales value |
| orders | Order volume, dates, stores and promotions |
| payments | Payment amounts and methods |
| products | Product catalogue, category and supplier mapping |
| promotions | Discount analysis |
| return_items | Returns and refund exposure |
| shipments | Fulfilment status and delivery timing |
| stores | Store and city comparisons |
| suppliers | Supplier and country comparisons |

See [Data Dictionary](docs/DATA_DICTIONARY.md) for the fields identified in the current SQL scripts and dataset checks.

## Tools

- **MySQL 8** — data inspection, quality checks, cleaning, joins, CTEs, window functions and KPI analysis.
- **Microsoft Excel** — planned spreadsheet analysis and management summary.
- **Power BI / DAX** — planned semantic model, measures and interactive reporting.
- **GitHub** — version control, documentation and reproducibility.

## Repository workflow

1. Inspect source tables and document their schemas.
2. Audit missing values, duplicate keys, invalid ranges and orphan references.
3. Apply only justified cleaning transformations and validate the result.
4. Define business metrics before calculating them.
5. Analyze sales, customers, products, categories, fulfilment and returns.
6. Reconcile SQL outputs with Excel and Power BI.
7. Convert validated findings into business recommendations.

## Current repository contents

- `SQL/01_Database_Overview.sql` — schema and sample-row inspection.
- `SQL/02_Data_Quality_Audit.sql` — table-level data-quality checks.
- `SQL/03_Data_Cleaning.sql` — validation and cleaning operations.
- `SQL/04_Data_Analysis.sql` — executive, customer, product/category and operations analyses.\n- `SQL/05_Product_Data_Validation.sql` — reproducible read-only product quality checks.
- `Images/` — visual assets and screenshots currently committed.
- `Datasets/` — source CSV files.

Excel, Power BI and Report folders are currently placeholders. Their deliverables should be added only after they are built and validated.

## Metric definitions and important caveats

- **Gross line-item sales**: `SUM(order_items.qty * order_items.price)`. This is not automatically net revenue, recognized revenue or cash collected.
- **Average order value (AOV)**: average of each order's gross line-item value. State the date range and treatment of cancelled/returned orders whenever reporting it.
- **Payment amount**: payment records must be checked for status, duplicates, refunds and partial payments before describing their sum as settled revenue.
- **Return rate**: specify whether the denominator is order lines, units or orders. These definitions are not interchangeable.
- **Product margin**: do not calculate margin unless a validated product cost field is available. The current products CSV/schema check exposes `price`, not a cost field.
- **Category labels**: the current category file uses labels such as `Cat_1`; these are identifiers, not descriptive merchandising names.
- Currency and business thresholds must be confirmed from source documentation before presenting financial amounts or customer tiers as business facts.

## Reproducing the SQL work

1. Create/load the database using the CSV files in `Datasets/`.
2. Confirm table and column names with `SQL/01_Database_Overview.sql`.
3. Run the audit queries in `SQL/02_Data_Quality_Audit.sql`.
4. Review each proposed transformation in `SQL/03_Data_Cleaning.sql`; back up source tables before executing UPDATE or ALTER statements.
5. Run analyses in `SQL/04_Data_Analysis.sql`.
6. Record query outputs, run date, row counts and validation notes. Do not treat placeholder comments as completed results.

SQL scripts may require adaptation if the database schema differs from the committed CSV headers. Always verify schema before execution.

## Quality and delivery checklist

- [ ] Document database version, import process and source-data provenance.
- [ ] Validate primary keys, foreign keys, NULLs, duplicates, date ranges and numeric domains.
- [ ] Confirm join cardinality to prevent duplicated revenue/refund totals.
- [ ] Define each KPI, its grain, filters, exclusions and currency.
- [ ] Execute every analysis query and save validated outputs.
- [ ] Reconcile key KPIs across SQL, Excel and Power BI.
- [ ] Build an Excel analysis workbook with pivots, formulas and a management summary.
- [ ] Build a Power BI model with a date table, explicit measures and report pages.
- [ ] Write evidence-backed insights and prioritized recommendations.
- [ ] Add dashboard screenshots and a concise final report.
- [ ] Test the instructions from a clean database/import.

## Limitations

This is a portfolio analysis, not a production data pipeline. The repository currently does not document a full automated refresh process, source-system lineage, formal business sign-off or production-grade orchestration. Findings should be described as associations unless the data and study design support causal conclusions.

## Project methodology

See [Project Methodology & QA Standards](docs/PROJECT_METHODOLOGY.md).
