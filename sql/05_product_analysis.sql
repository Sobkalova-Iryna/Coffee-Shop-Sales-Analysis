-- ============================================================================
-- SQL Module: 05_product_analysis.sql
-- ============================================================================

-- Purpose: identifying top products by revenue
-- QUERY:
SELECT
    product_detail,
    SUM(revenue) AS revenue,
	RANK() OVER (
        ORDER BY SUM(revenue) DESC
    ) AS revenue_rank,
	SUM(transaction_qty) AS units_sold,
		RANK() OVER (
        ORDER BY SUM(transaction_qty) DESC
    ) AS units_sold_rank
FROM coffee_sales
GROUP BY product_detail
LIMIT 10

-- Purpose: identifying the products that generate the first 80% of revenue
-- QUERY:
WITH products AS (
    SELECT
        product_detail,
        SUM(revenue) AS revenue
    FROM coffee_sales
    GROUP BY product_detail
),

ranked AS (
    SELECT
        product_detail,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue
    FROM products
)

SELECT
    product_detail,
    revenue,
    ROUND(
        100.0 * cumulative_revenue
        / SUM(revenue) OVER (),
        2
    ) AS cumulative_revenue_pct
FROM ranked
ORDER BY revenue DESC

-- Revenue is relatively distributed across the product assortment rather than being highly concentrated in a small number of products.
-- Approximately 55% of products generate 80% of total revenue. No single product dominates total revenue. 
-- The highest-revenue product accounts for only approximately 3% of total revenue.

-- QUERY:
WITH products AS (
    SELECT
        product_type,
        SUM(revenue) AS revenue
    FROM coffee_sales
    GROUP BY product_type
),

ranked AS (
    SELECT
        product_type,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue
    FROM products
)

SELECT
    product_type,
    revenue,
    ROUND(
        100.0 * cumulative_revenue
        / SUM(revenue) OVER (),
        2
    ) AS cumulative_revenue_pct
FROM ranked
ORDER BY revenue DESC

-- QUERY:
WITH products AS (
    SELECT
        product_category,
        SUM(revenue) AS revenue
    FROM coffee_sales
    GROUP BY product_category
),

ranked AS (
    SELECT
        product_category,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
        ) AS cumulative_revenue
    FROM products
)

SELECT
    product_category,
    revenue,
    ROUND(
        100.0 * cumulative_revenue
        / SUM(revenue) OVER (),
        2
    ) AS cumulative_revenue_pct
FROM ranked
ORDER BY revenue DESC

-- Coffee and Tea are the main revenue-generating categories, together accounting for 66.74% of total revenue.
-- The three largest categories — Coffee, Tea and Bakery — generate 78.52% of total revenue. 
-- The top 10 product types generate 78.96% of total revenue, with Barista Espresso being the largest contributor at 13.08%.
-- Revenue concentration varies significantly depending on the level of product aggregation. 
-- At the category level, three categories account for 78.5% of revenue, while at the product-detail level, 
-- approximately half of the assortment is required to reach 80% of revenue.
