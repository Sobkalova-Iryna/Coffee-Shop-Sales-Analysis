-- ============================================================================
-- SQL Module: 07_general_analysis.sql
-- ============================================================================

-- Purpose: determining the top product types for each store
-- QUERY:
WITH product_store_sales AS (
    SELECT
        store_location,
        product_type,
        SUM(revenue) AS revenue
    FROM coffee_sales
    GROUP BY store_location, product_type
),

ranked AS (
    SELECT
        store_location,
        product_type,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY store_location
            ORDER BY revenue DESC
        ) AS rank,
		ROUND(
        100.0 * revenue
        / SUM(revenue) OVER (
            PARTITION BY store_location
        ),
        2
    ) AS store_revenue_pct
    FROM product_store_sales
)

SELECT
    store_location,
    product_type,
    revenue,
    rank,
	  store_revenue_pct
FROM ranked
WHERE rank <= 5
ORDER BY store_location, rank

-- Purpose: determining the top product types for each store
-- QUERY:
WITH category_store_sales AS (
    SELECT
        store_location,
        product_category,
        SUM(revenue) AS revenue,
		COUNT(DISTINCT transaction_id) AS transactions,
    	ROUND(
        	SUM(revenue) / COUNT(DISTINCT transaction_id),
        	2
    	) AS avg_transaction_value
    FROM coffee_sales
    GROUP BY store_location, product_category
)

SELECT
    store_location,
    product_category,
    revenue,
    ROUND(
        100.0 * revenue
        / SUM(revenue) OVER (
            PARTITION BY store_location
        ),
        2
    ) AS store_revenue_pct,
	transactions,
	avg_transaction_value
FROM category_store_sales
ORDER BY store_location, revenue DESC

-- Product mix is highly consistent across stores. Coffee represents approximately 39% of revenue in all three stores, 
-- while Tea and Bakery are the next largest categories. The same core product types also dominate revenue across locations.
-- Lower Manhattan achieves comparable revenue with fewer transactions. 
-- Its main product categories have a higher average revenue per transaction than the other stores, 
-- suggesting that higher transaction value partly offsets lower transaction volume.
-- Coffee beans are a notable exception to the otherwise similar product mix. 
-- The category contributes 7.88% of revenue in Hell's Kitchen, compared with 4.40% in Astoria and 4.88% in Lower Manhattan, 
-- making it a potential area for further investigation.
