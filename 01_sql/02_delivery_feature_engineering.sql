WITH base AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        c.customer_state,
        r.review_score,
        CASE 
            WHEN r.review_score IS NULL THEN 0
            ELSE 1
        END AS has_review
    FROM orders AS o
    INNER JOIN customers AS c
        ON o.customer_id = c.customer_id
    LEFT JOIN order_reviews AS r
        ON o.order_id = r.order_id
    WHERE
        o.order_delivered_customer_date IS NOT NULL
        AND o.order_estimated_delivery_date IS NOT NULL
),

features AS (
    SELECT *,
        order_delivered_customer_date - order_purchase_timestamp AS delivery_time,
        order_delivered_customer_date - order_estimated_delivery_date AS delay,
        CASE
            WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'on_time'
            WHEN order_delivered_customer_date <= order_estimated_delivery_date + INTERVAL '2 days' THEN 'slightly_late'
            ELSE 'very_late'
        END AS delay_category
    FROM base
)

SELECT *
FROM features;

-- saved as "delivery_features.csv"