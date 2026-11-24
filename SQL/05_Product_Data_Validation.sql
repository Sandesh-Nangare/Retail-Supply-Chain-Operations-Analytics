/* =============================================================================
   SECTION 5: VERIFIED PRODUCT DATA QUALITY CHECKS

   Purpose:
   - Reproduce the product checks run during project review.
   - Validate required fields, positive prices and dimension references.
   - Read-only checks: this script does not modify source data.

   Verified products schema:
   product_id INT NOT NULL PRIMARY KEY
   category_id INT NULL
   supplier_id INT NULL
   price INT NULL

   Last manually observed result: 10,000 products; zero missing product/category/
   supplier IDs, zero missing prices, zero non-positive prices, and zero orphan
   category/supplier references. Re-run after every data refresh.
============================================================================= */

-- 1. Confirm row count, missing values and invalid prices.
SELECT
    COUNT(*) AS total_products,
    SUM(product_id IS NULL) AS missing_product_ids,
    SUM(category_id IS NULL) AS missing_category_ids,
    SUM(supplier_id IS NULL) AS missing_supplier_ids,
    SUM(price IS NULL) AS missing_prices,
    SUM(price <= 0) AS invalid_prices
FROM products;

-- 2. Check duplicate product identifiers separately.
SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
WHERE product_id IS NOT NULL
GROUP BY product_id
HAVING COUNT(*) > 1;

-- 3. Products referencing categories that do not exist.
SELECT COUNT(*) AS orphan_category_records
FROM products p
LEFT JOIN categories c
    ON p.category_id = c.category_id
WHERE p.category_id IS NOT NULL
  AND c.category_id IS NULL;

-- 4. Products referencing suppliers that do not exist.
SELECT COUNT(*) AS orphan_supplier_records
FROM products p
LEFT JOIN suppliers s
    ON p.supplier_id = s.supplier_id
WHERE p.supplier_id IS NOT NULL
  AND s.supplier_id IS NULL;

-- 5. Review price distribution for potential outliers.
-- This is a review output, not an automatic rule to delete records.
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,
    COUNT(*) AS priced_products
FROM products
WHERE price IS NOT NULL;
