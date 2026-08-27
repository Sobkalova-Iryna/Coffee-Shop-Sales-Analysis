-- ============================================================================
-- SQL Module: 03_sales_kpis.sql
-- ============================================================================

-- Basic KPIs
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

-- Revenue by month
-- QUERY:
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    SUM(revenue) AS revenue
FROM coffee_sales
GROUP BY 1
ORDER BY 1

-- Month-over-month growth
-- QUERY:
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS month,
        SUM(revenue) AS revenue
    FROM coffee_sales
    GROUP BY 1
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0),
        2
    ) AS mom_growth_pct
FROM monthly_sales
ORDER BY month
