-- Final table for continued data validation/cleaning in Python 

WITH order_agg AS (
    SELECT
        oi.order_id,
        COUNT(*) AS num_items,
        SUM(oi.price + oi.freight_value) AS total_order_value,
        COUNT(DISTINCT oi.seller_id) AS num_sellers
    FROM order_items AS oi
    GROUP BY oi.order_id
),

base AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        c.customer_state,
        r.review_score,
        oa.num_items,
        oa.total_order_value,
        oa.num_sellers
    FROM orders AS o
    INNER JOIN customers AS c
        ON o.customer_id = c.customer_id
    LEFT JOIN order_reviews AS r
        ON o.order_id = r.order_id
    LEFT JOIN order_agg AS oa
        ON o.order_id = oa.order_id
    WHERE
        o.order_delivered_customer_date IS NOT NULL
        AND o.order_estimated_delivery_date IS NOT NULL
),

features AS (
    SELECT
        order_id,
        customer_state,
        review_score,
        num_items,
        total_order_value,
        num_sellers,
        EXTRACT(DAY FROM order_delivered_customer_date - order_purchase_timestamp) AS delivery_days,
        EXTRACT(DAY FROM order_delivered_customer_date - order_estimated_delivery_date) AS delay_days,
        CASE
            WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'on_time'
            WHEN order_delivered_customer_date <= order_estimated_delivery_date + INTERVAL '3 days' THEN 'slightly_late'
            ELSE 'very_late'
        END AS delay_category
    FROM base
)

SELECT *
FROM features;