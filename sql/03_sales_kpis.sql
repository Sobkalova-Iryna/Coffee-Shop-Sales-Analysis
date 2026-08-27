-- ============================================================================
-- SQL Module: 03_sales_kpis.sql
-- ============================================================================

-- QUERY:
SELECT SUM(revenue) AS total_revenue,
	COUNT(DISTINCT transaction_id) AS transactions,
	SUM(transaction_qty) AS units_sold,
	SUM(revenue) / COUNT(DISTINCT transaction_id) AS avg_transaction_value,
	AVG(unit_price) AS avg_unit_price
FROM coffee_sales

-- Total revenue: 698812.33
-- Transactions: 149116
-- Units sold: 214470
-- Average transaction value: 4.69
-- Average unit price: 3.38

