-- ============================================================================
-- SQL Module: 04_store_analysis.sql
-- ============================================================================

-- Purpose: comparison of revenue, quantity of transactions, units, average transaction value.
-- QUERY:
SELECT
    store_location,
    SUM(revenue) AS revenue,
    COUNT(DISTINCT transaction_id) AS transactions,
    SUM(transaction_qty) AS units_sold,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT transaction_id),
        2
    ) AS avg_transaction_value
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue DESC

-- Purpose: comparison of the store's share of total revenue.
-- QUERY:
