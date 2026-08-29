-- ============================================================================
-- SQL Module: 05_time_analysis.sql
-- ============================================================================

-- Purpose:
-- QUERY:
SELECT
    EXTRACT(HOUR FROM transaction_time) AS hour,
    SUM(revenue) AS revenue,
    COUNT(DISTINCT transaction_id) AS transactions,
	ROUND(
        SUM(revenue) / COUNT(DISTINCT transaction_id),
        2
    ) AS avg_transaction_value,
	RANK() OVER (
		ORDER BY SUM(revenue) DESC 
	) AS revenue_rank,
	RANK() OVER (
        ORDER BY COUNT(DISTINCT transaction_id) DESC
    ) AS transactions_rank
FROM coffee_sales
GROUP BY 1
ORDER BY 1

-- Sales activity is strongly concentrated in the morning. Revenue and transaction volume peak at 10:00, followed by 9:00 and 8:00.
-- Hourly revenue is primarily driven by transaction volume rather than significant differences in average transaction value.
-- Revenue declines sharply after the morning peak as transaction volume decreases, 
-- while average transaction value remains relatively stable throughout the day.

-- Purpose:
-- QUERY:
SELECT
    TO_CHAR(transaction_date, 'Day') AS weekday,
	SUM(revenue) AS revenue,
    COUNT(DISTINCT transaction_id) AS transactions,
	RANK() OVER (
		ORDER BY SUM(revenue) DESC 
	) AS revenue_rank,
	RANK() OVER (
		ORDER BY COUNT(DISTINCT transaction_id) DESC 
	) AS transactions_rank
FROM coffee_sales
GROUP BY EXTRACT(DOW FROM transaction_date), TO_CHAR(transaction_date, 'Day')
ORDER BY EXTRACT(DOW FROM transaction_date)

-- Monday generated the highest daily revenue ($101.7K), while Friday had the highest transaction volume (21.7K). 
-- The similar revenue levels despite different transaction volumes indicate a slightly higher average transaction value on Monday.
-- Saturday had the lowest revenue and transaction volume, making it the weakest day in terms of overall sales activity.
  
-- Purpose:
-- QUERY:
SELECT
    TO_CHAR(transaction_date, 'FMDay') AS weekday,
    EXTRACT(HOUR FROM transaction_time) AS hour,
    SUM(revenue) AS revenue,
    COUNT(DISTINCT transaction_id) AS transactions,
    ROUND(
        SUM(revenue) / COUNT(DISTINCT transaction_id),
        2
    ) AS avg_transaction_value
FROM coffee_sales
GROUP BY 1, 2, EXTRACT(DOW FROM transaction_date), EXTRACT(HOUR FROM transaction_time)
ORDER BY
    EXTRACT(DOW FROM transaction_date),
    hour

-- The morning peak is consistent across all days of the week, indicating a stable demand pattern rather than an isolated weekday effect.
