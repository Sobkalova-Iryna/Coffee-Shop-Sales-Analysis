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
SELECT
    store_location,
    SUM(revenue) AS revenue,
    ROUND(
        100.0 * SUM(revenue)
        / SUM(SUM(revenue)) OVER (),
        2
    ) AS revenue_share_pct
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue DESC

--Purpose: analysis of the month-by-month performance trends of each store.
-- QUERY:
WITH monthly_store_sales AS (
    SELECT
        TO_CHAR(transaction_date, 'MM') AS month,
        store_location,
        SUM(revenue) AS revenue
    FROM coffee_sales
    GROUP BY 1, 2
)

SELECT
    month,
    store_location,
    revenue,
    LAG(revenue) OVER (
        PARTITION BY store_location
        ORDER BY month
    ) AS previous_month_revenue,
    ROUND(
        100.0 * (
            revenue - LAG(revenue) OVER (
                PARTITION BY store_location
                ORDER BY month
            )
        ) / NULLIF(
            LAG(revenue) OVER (
                PARTITION BY store_location
                ORDER BY month
            ), 0
        ),
        2
    ) AS mom_growth_pct
FROM monthly_store_sales
ORDER BY month, store_location

-- Store Hell's Kitchen has the highest revenue. That's because store Hell's Kitchen has the highest transaction volume.
-- The "Lower Manhattan" store has the lowest revenue. Customers at the "Lower Manhattan" store spend more per transaction but have a lower transaction volume.
-- The share of total revenue is distributed among the stores almost evenly, with a difference of less than 1%.
-- All stores show a decline in revenue in February and growth from March to June. "Hell's Kitchen" leads in revenue throughout the entire period.
