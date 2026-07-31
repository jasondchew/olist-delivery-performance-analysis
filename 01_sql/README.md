# SQL Analysis – Olist Delivery Performance

This folder contains all SQL scripts used to transform raw Olist data into an analysis-ready dataset and perform key exploratory analyses.

## Structure

### 01_create_base_tables.sql
Defines base tables and staging tables for importing raw CSV data.

### 02_delivery_feature_engineering.sql
Builds core delivery performance features:
- Delivery time
- Delay (early vs late)
- Delay category (on_time, slightly_late, very_late)

### 03_exploratory_analysis.sql
Initial analysis of delivery performance and customer satisfaction:
- Distribution of delivery timing
- Average and median delays
- Review score trends by delay category

### 04_order_complexity_analysis.sql
Examines how order characteristics affect outcomes:
- Order value buckets
- Number of items
- Multi-seller complexity vs review scores

### 05_geographic_hotspot_analysis.sql
Identifies high-impact regions:
- States with highest delays
- States with lowest customer satisfaction
- Severe delay rates by region

### 06_final_table_python_export.sql
Produces a clean dataset for further data validation in Python:
- One row per order
- Engineered features ready for eventual visualization

### 07_enriched_table_more_EDA.sql
Builds an enriched, round-two version of the final table with deeper product/payment/review-level features:
- Item, seller, and product-category counts per order
- Average product weight and volume
- Payment method and installment summary
- Review summary joined in at the order level

## Design Approach
The SQL workflow follows a layered structure:
1. Raw data → joins and base tables
2. Feature engineering (CTEs)
3. Final dataset creation
4. Analytical queries

## Why this matters
This structure mirrors real-world data pipelines:
- Clear separation between transformation and analysis
- Reusable, modular SQL scripts
- Clean dataset ready for Python validation and downstream BI tools
