-- ============================================================================
-- SQL Module: 02_sales_kpis.sql
-- Purpose: 
-- ============================================================================

-- QUERY:
CREATE VIEW coffee_sales AS
SELECT
    transaction_id,
    transaction_date,
    transaction_time,
    transaction_qty,
    store_id,
    store_location,
    product_id,
    unit_price,
    product_category,
    product_type,
    product_detail,
    transaction_qty * unit_price AS revenue,
    EXTRACT(YEAR FROM transaction_date) AS year,
    EXTRACT(MONTH FROM transaction_date) AS month,
    EXTRACT(DAY FROM transaction_date) AS day,
    EXTRACT(DOW FROM transaction_date) AS day_of_week,
    EXTRACT(HOUR FROM transaction_time) AS hour
FROM coffee_sales_raw
