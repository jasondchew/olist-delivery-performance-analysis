# Olist Delivery Performance & Customer Experience Analysis

Analyzed 95K+ e-commerce orders to understand how delivery delays, order complexity, and geographic hotspots impact customer satisfaction.

## Business Problem
In e-commerce, delivery performance is strongly associated with customer experience. While most orders are delivered on time, a subset of delays—particularly severe delays (3+ days)—may account for the bulk of customer dissatisfaction.

This project evaluates:
- How delivery delays affect review scores
- Whether order complexity (multi-seller, multi-item orders) impacts experience
- Which geographic regions exhibit the greatest delivery friction

## Approach
1. **SQL (PostgreSQL)**
   - Joined multiple Olist tables (orders, customers, reviews, order items)
   - Engineered delivery features (delivery days, delay days, delay categories)
   - Aggregated order complexity metrics (items, order value, number of sellers)

2. **Python (pandas)**
   - Validated dataset integrity
   - Cleaned and deduplicated final dataset
   - Prepared analysis-ready table for BI tools

3. **Power BI**
   - Executive dashboard to visualize delivery performance and customer impact

## Key Analysis Areas
- Delivery timeliness distribution (early, on-time, late)
- Impact of delay severity on customer satisfaction
- Multi-seller order complexity vs review scores
- Geographic hotspots for delivery delays

## Key Insights
- 91.9% of orders arrived on time
- 5.24% of orders were severely late (3+ days)
- On-time orders averaged a review score of **4.29**
- Severely late orders averaged a review score of **1.94**
- A small percentage of delayed orders generated a disproportionate share of negative customer reviews

## Project Structure
- `/01_sql` → Data extraction, joins, feature engineering, and analysis queries
- `/02_jupyter` → Python data cleaning and validation
- `/03_data` → Data source and reproduction steps (raw/processed CSVs are gitignored — see [`03_data/README.md`](03_data/README.md))
- `/04_dashboard` → Power BI template

## Tools Used
- PostgreSQL (pgAdmin)
- Python (pandas, Jupyter Notebook)
- Power BI

## Additional Resources
- [Capstone Visuals (.pdf)](Capstone%20II_Visuals%20%5BJason%20Chew%5D.pdf)

## Key Takeaway
Severe delivery delays and order complexity are strongly associated with lower customer satisfaction, highlighting clear opportunities for operational improvement.
