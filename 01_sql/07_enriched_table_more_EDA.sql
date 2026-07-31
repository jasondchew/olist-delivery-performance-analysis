DROP TABLE IF EXISTS final_delivery_enriched;

CREATE TABLE final_delivery_enriched AS
WITH order_item_summary AS(
	SELECT
		oi.order_id,
		COUNT(*) AS num_items,
		COUNT(DISTINCT oi.seller_id) AS num_sellers,
		COUNT(DISTINCT oi.product_id) AS num_products,
		COUNT(DISTINCT p.product_category_name) AS num_product_categories,
		MAX(t.product_category_name_english) AS primary_product_category,
		SUM(oi.price + oi.freight_value) AS total_order_value,
		AVG(p.product_weight_g) AS avg_product_weight_g,
		AVG(
			p.product_length_cm
			* p.product_height_cm
			* p.product_width_cm
		) AS avg_product_volume_cm3
	FROM order_items AS oi
	LEFT JOIN products AS p
	ON oi.product_id = p.product_id
	LEFT JOIN product_categories AS t
	ON p.product_category_name = t.product_category_name
	GROUP BY oi.order_id
),

payment_summary AS (
	SELECT
		order_id,
		COUNT(*) AS num_payment_records,
		MAX(payment_type) AS primary_payment_type,
		SUM(payment_installments) AS total_installments,
		SUM(payment_value) AS total_payment_value
	FROM order_payments 
	GROUP BY order_id
),

review_summary AS(
	SELECT
		order_id,
		AVG(review_score) AS review_score,
		CASE
    		WHEN AVG(review_score) IS NULL THEN 0
    		ELSE 1
		END AS has_review_flag
	FROM order_reviews 
	GROUP BY order_id
)

SELECT
	o.order_id,
	c.customer_state,
	r.review_score,
	r.has_review_flag,
	ois.num_items,
	ois.num_sellers,
	ois.num_products,
	ois.num_product_categories,
	ois.primary_product_category,
	ois.total_order_value,
	ois.avg_product_weight_g,
	ois.avg_product_volume_cm3,
	ps.primary_payment_type,
	ps.total_installments,
	ps.total_payment_value,

	DATE_PART(
		'day',
		o.order_delivered_customer_date::timestamp
		- o.order_purchase_timestamp::timestamp
	) AS delivery_days,

	DATE_PART(
		'day',
		o.order_delivered_customer_date::timestamp
		- o.order_estimated_delivery_date::timestamp
	) AS delay_days,

	CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'on_time'
        WHEN order_delivered_customer_date <= order_estimated_delivery_date + INTERVAL '3 days' THEN 'slightly_late'
        ELSE 'very_late'
    END AS delay_category,

	CASE
		WHEN DATE_PART(
			'day',
			o.order_delivered_customer_date::timestamp
			- o.order_estimated_delivery_date::timestamp
		) <= 0
			THEN 'early'

		WHEN DATE_PART(
			'day',
			o.order_delivered_customer_date::timestamp
			- o.order_estimated_delivery_date::timestamp
		) BETWEEN 1 AND 2
			THEN '1-2 days late'

		WHEN DATE_PART(
			'day',
			o.order_delivered_customer_date::timestamp
			- o.order_estimated_delivery_date::timestamp
		) BETWEEN 3 AND 7
			THEN '3-7 days late'

		ELSE '7+ days late'

	END AS delay_bucket,
			
	CASE
		WHEN ois.num_sellers = 1
			THEN 'single seller'
		ELSE 'multi seller'
	END AS seller_complexity,

	CASE
		WHEN ois.num_product_categories = 1
			THEN 'single category'
		ELSE 'multi category'
	END AS category_complexity 

FROM orders AS o
LEFT JOIN customers AS c
	ON o.customer_id = c.customer_id
LEFT JOIN review_summary AS r
	ON o.order_id = r.order_id
LEFT JOIN order_item_summary AS ois
	ON o.order_id = ois.order_id
LEFT JOIN payment_summary AS ps
	ON o.order_id = ps.order_id

WHERE
	o.order_status = 'delivered'
	AND o.order_delivered_customer_date IS NOT NULL
	AND o.order_estimated_delivery_date IS NOT NULL;

ALTER TABLE final_delivery_enriched
ADD COLUMN severe_late_flag INT,
ADD COLUMN low_review_flag INT;

UPDATE final_delivery_enriched
SET
	severe_late_flag = CASE WHEN delay_days >= 3 THEN 1 ELSE 0 END,
	low_review_flag = CASE WHEN review_score <= 2 THEN 1 ELSE 0 END;

DROP TABLE IF EXISTS final_delivery_enriched_clean;

CREATE TABLE final_delivery_enriched_clean AS

SELECT *
FROM final_delivery_enriched
WHERE review_score IS NOT NULL;
