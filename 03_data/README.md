# Data Documentation

This folder documents the final dataset used for analysis and visualization.

## Source

This project uses the **Brazilian E-Commerce Public Dataset by Olist**, available on Kaggle:
- [Olist Store Dataset (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Raw and processed CSVs are not included in this repo (Kaggle's license doesn't cover redistribution, and the full dataset is 100+ MB). To reproduce this analysis:
1. Download the dataset from the Kaggle link above.
2. Load the raw tables into PostgreSQL (or your preferred SQL engine).
3. Run the scripts in [`/01_sql`](../01_sql) in order (`01` through `07`) to build the feature-engineered tables.
4. Run the notebooks in [`/02_jupyter`](../02_jupyter) to validate and clean the exported data.
5. Load the final cleaned table into Power BI using [`/04_dashboard`](../04_dashboard).

## Dataset Overview
The final dataset contains one row per order and includes features engineered from multiple Olist tables.

## Key Fields
- `order_id` → unique identifier
- `customer_state` → geographic location
- `review_score` → customer satisfaction (1–5)
- `num_items` → number of items in the order
- `total_order_value` → total cost of the order
- `num_sellers` → number of sellers involved
- `delivery_days` → time from purchase to delivery
- `delay_days` → difference between actual and estimated delivery
- `delay_category` → on_time, slightly_late, very_late

## Feature Engineering Logic
- Delay is calculated as:
  - Negative = early delivery
  - Positive = late delivery
- Delay categories:
  - On-time
  - Slightly late (≤ 3 days)
  - Very late (> 3 days)

## Data Considerations
- Rows are filtered to include only delivered orders
- Orders without review scores were excluded from satisfaction analysis
- Duplicate rows from joins were removed
- Dataset is observational (no causal conclusions)

## Use Case
This dataset is optimized for:
- Business intelligence dashboards
- Customer experience analysis
- Operational performance insights
