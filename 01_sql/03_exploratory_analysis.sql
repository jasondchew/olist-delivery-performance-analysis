-- Distribution of delay categories
SELECT
    delay_category,
    COUNT(*) AS num_orders,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS pct_orders
FROM delivery_features
GROUP BY delay_category
ORDER BY pct_orders DESC;

-- Average and median delay
SELECT
	AVG(delay) AS avg_delay,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY delay) AS median_delay
FROM delivery_features

-- Average review score of delay categories 
SELECT
	delay_category,
	AVG(review_score) AS avg_review
FROM delivery_features
GROUP BY delay_category
ORDER BY avg_review DESC;

-- Delivery performance by state
SELECT
	customer_state,
	AVG(delay) AS avg_delay,
	COUNT(*) AS num_orders
FROM delivery_features
GROUP BY customer_state
HAVING COUNT(*) > 100
ORDER BY avg_delay DESC;








