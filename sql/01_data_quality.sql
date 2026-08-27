-- ============================================================================
-- SQL Module: 01_data_quality.sql
-- Purpose:
-- ============================================================================

-- Checking the number of rows
-- QUERY:
SELECT COUNT(*) AS row_count
FROM coffee_sales_raw

-- The total number of lines is 149116

-- Duplicate check
-- QUERY:
SELECT transaction_id,
    COUNT(*) AS cnt
FROM coffee_sales_raw
GROUP BY transaction_id
HAVING COUNT(*) > 1

-- No duplicates found in transaction_id.

-- Checking for NULL values
-- QUERY:
SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS null_transaction_id,
    COUNT(*) FILTER (WHERE transaction_date IS NULL) AS null_date,
    COUNT(*) FILTER (WHERE transaction_qty IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE unit_price IS NULL) AS null_price,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product
FROM coffee_sales_raw

-- Check for invalid values
-- QUERY:
SELECT *
FROM coffee_sales_raw
WHERE transaction_qty <= 0
   OR unit_price <= 0

-- There are no incorrect values ​​in the table.

-- Checking unique categories
-- QUERY: 
SELECT
    product_detail,
    COUNT(*) AS row_count
FROM coffee_sales_raw
GROUP BY product_detail
ORDER BY row_count DESC

-- The table contains nine unique product categories. The categories are recorded correctly. The "Coffee" category has the highest number of transactions.
-- Similarly, we check the store_location, product_type, and product_detail columns.
-- We check the store_location, product_type, and product_detail columns in the same way. 
-- The table has three unique store locations, twenty-nine unique product types and eighty product details.
