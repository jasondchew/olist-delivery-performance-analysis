CREATE TABLE customers (
	customer_id VARCHAR(32),
	customer_unique_id VARCHAR(32),
	customer_zip_code_prefix VARCHAR(10),
	customer_city VARCHAR(100),
	customer_state CHAR(2)
);

CREATE TABLE geolocation (
	geolocation_zip_code_prefix VARCHAR(10),
	geolocation_lat DECIMAL(10, 8),
	geolocation_lng DECIMAL(11, 8),
	geolocation_city VARCHAR(100),
	geolocation_state CHAR(2)
);

CREATE TABLE order_items (
	order_id VARCHAR(32),
	order_item_id INT,
	product_id VARCHAR(32),
	seller_id VARCHAR(32),
	shipping_limit_date TIMESTAMP,
	price DECIMAL(10, 2),
	freight_value DECIMAL(10, 2)
);

CREATE TABLE order_payments (
	order_id VARCHAR(32),
	payment_sequential INT,
	payment_type VARCHAR(20),
	payment_installments INT,
	payment_value DECIMAL(10, 2)
); 

CREATE TABLE order_reviews (
	review_id VARCHAR(32),
	order_id VARCHAR(32),
	review_score INT,
	review_comment_title VARCHAR(255),
	review_comment_message TEXT,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP
);

CREATE TABLE orders (
	order_id VARCHAR(32),
	customer_id VARCHAR(32),
	order_status VARCHAR(20),
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE products (
	product_id VARCHAR(32),
	product_category_name VARCHAR(100),
	product_name_lenght INT,
	product_description_lenght INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
); 

CREATE TABLE sellers (
	seller_id VARCHAR(32),
	seller_zip_code_prefix VARCHAR(10),
	seller_city VARCHAR(100),
	seller_state CHAR(2)
);

CREATE TABLE product_categories (
	product_category_name VARCHAR(100),
	product_category_name_english VARCHAR(100)
); 

CREATE TABLE delivery_features_staging (
    order_id TEXT,
    customer_state TEXT,
    review_score TEXT,
    num_items TEXT,
    total_order_value TEXT,
    num_sellers TEXT,
    delivery_days TEXT,
    delay_days TEXT,
    delay_category TEXT
);