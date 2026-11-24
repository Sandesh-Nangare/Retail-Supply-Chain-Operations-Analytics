# Data Dictionary (observed fields)

This document records fields visible in the committed CSV samples and SQL scripts. It is intentionally conservative: it does not infer undocumented business meaning, units, currency or status definitions. Confirm every field against the imported MySQL schema before execution.

## Core sales tables

| Table / file | Fields observed | Notes |
|---|---|---|
| categories.csv | category_id, category_name | Current labels are Cat_1 through Cat_30. |
| products.csv | product_id, category_id, supplier_id, price | No product_name or unit_cost field is present in the committed CSV header. The MySQL products schema was also checked and showed these four fields. |
| orders | order_id, customer_id, store_id, order_date, promotion_id | Confirmed in the existing SQL scripts; verify against actual CSV header/schema. |
| order_items | order_item_id, order_id, product_id, qty, price | Confirmed in existing SQL scripts; verify source header/schema. |

## Customer, operations and supporting tables

| Table / file | Fields observed in SQL or CSV sample | Notes |
|---|---|---|
| customers | customer_id, first_name, last_name, city, email, signup_date | Referenced in audit and cleaning SQL; confirm exact imported schema. |
| employees.csv | employee_id, store_id, salary | These are the fields visible in the committed CSV header. Do not assume name/email fields exist in this CSV. |
| payments | payment_id, order_id, amount, payment_method | Referenced in audit and analysis SQL. Payment status was not established by inspected SQL. |
| promotions.csv | promotion_id, discount | Discount values appear numeric; confirm whether they represent percentages. |
| return_items.csv | return_id, order_item_id, refund | Refund currency and partial-return semantics are not documented. |
| shipments | shipment_id, order_id, status, shipment_date, delivery_date | Referenced in SQL cleaning and analysis. Confirm exact imported schema. |
| stores.csv | store_id, city | City values include Pune, Delhi, Mumbai and Bangalore. |
| suppliers.csv | supplier_id, country | Country values include India, USA and China. |

## Confirmed products table checks

The MySQL `DESCRIBE products` output showed:
- `product_id INT NOT NULL PRIMARY KEY`
- `category_id INT NULL`
- `supplier_id INT NULL`
- `price INT NULL`

A validation query returned 10,000 rows and zero missing IDs, missing prices, non-positive prices, orphan category references and orphan supplier references. These results apply only to the checks actually run and should be re-run if the data changes.

## Definitions still requiring confirmation

- Currency and scale of `price`, `amount` and `refund`.
- Whether `price` in order_items is transaction price or catalogue price.
- Whether payment rows can be partial, duplicated, failed or reversed.
- Whether a return record represents a returned unit, returned line or return event.
- Shipment status vocabulary and promised delivery/SLA fields.
- Whether promotions.discount is percentage points or another discount representation.
