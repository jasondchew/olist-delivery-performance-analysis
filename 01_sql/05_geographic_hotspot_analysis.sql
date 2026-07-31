-- Total orders, average delay, average review score, and percentage of late (>3 days) deliveries grouped by state

SELECT
	customer_state,
	COUNT(*) AS total_orders,
	ROUND(AVG(delay_days)::NUMERIC, 2) AS avg_delay_days,
	ROUND(AVG(review_score)::NUMERIC, 2) AS avg_review_score,
	ROUND(
		SUM(CASE WHEN delay_days > 3 THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100,2
	) AS severe_late_pct
FROM delivery_features
GROUP BY customer_state
HAVING COUNT(*) >= 100
ORDER BY avg_delay_days DESC;
