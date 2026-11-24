# Project Methodology & Quality Standards

## 1. Grain before metrics

For each table, state what one row represents. Before joining tables, check key uniqueness and expected relationship cardinality. Aggregate facts to the required grain before joining independent one-to-many tables; otherwise sums can be multiplied.

## 2. Data-quality sequence

1. Inspect source headers and MySQL data types.
2. Count rows and check key uniqueness.
3. Check NULLs separately from duplicate non-NULL keys.
4. Check numeric domains (for example, non-positive quantities/prices).
5. Check date ranges and impossible event sequences.
6. Check foreign-key orphans with LEFT JOIN anti-joins.
7. Record exceptions and decisions; do not silently delete or overwrite records.

## 3. Safe cleaning

- Preserve raw source files.
- Work on a staging or cleaned copy where possible.
- Back up tables before UPDATE, DELETE or ALTER.
- Make transformations repeatable and document assumptions.
- Re-run the same quality checks after transformation.
- Do not create columns or assume fields that are absent from the verified schema.

## 4. Metric contract

Every KPI should document:
- Business name and question.
- Formula and aggregation grain.
- Included/excluded records and date range.
- Currency/unit.
- Source tables and join keys.
- Known limitations.

Examples:
- Gross line-item sales = SUM(qty * transaction_price), at order-line grain.
- AOV = average gross order value, after first aggregating line items to order grain.
- Return rate must specify whether its denominator is units, order lines or orders.
- Cash collected must be based on verified payment statuses and refund/reversal treatment.

## 5. Analysis validation

For each result:
- Compare totals with an independent query or control total.
- Check for duplicate amplification after joins.
- Test edge cases such as zero denominators and categories with no activity.
- Confirm date boundaries use a clearly defined inclusive/exclusive convention.
- Keep raw output or reproducible query evidence.
- Phrase observations as associations, not causes, unless the design supports causal claims.

## 6. Portfolio acceptance criteria

A project is ready for review when a new reader can:
1. Understand the business problem and dataset.
2. Recreate the database and run the scripts.
3. See validated results and metric definitions.
4. Explore a functioning Excel workbook and Power BI report.
5. Trace dashboard numbers back to SQL.
6. Read concise, evidence-backed recommendations.
7. Understand limitations and assumptions without needing the author to explain them live.
