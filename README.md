# Olist Delivery Performance & Customer Experience Analysis

Analyzed 95K+ e-commerce orders to understand how delivery delays, order complexity, and geographic hotspots impact customer satisfaction.

## Business Problem
In e-commerce, delivery performance is a key driver of customer experience. While most orders are delivered on time, a subset of delays—particularly severe delays (3+ days)—may account for the bulk of customer dissatisfaction.

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

3. **Power BI (In Progress)**
   - Executive dashboard to visualize delivery performance and customer impact

## Key Analysis Areas
- Delivery timeliness distribution (early, on-time, late)
- Impact of delay severity on customer satisfaction
- Multi-seller order complexity vs review scores
- Geographic hotspots for delivery delays

## Project Structure
- `/01_sql` → Data extraction, joins, feature engineering, and analysis queries
- `/02_jupyter` → Python data cleaning and validation
- `/03_data` → Final dataset documentation 
- `/04_dashboard` → Power BI (in progress)

## Current Status
- SQL + Python analysis complete  
- Final dataset prepared for BI  
- Power BI executive dashboard in progress  

## Tools Used
- PostgreSQL (pgAdmin)
- Python (pandas, Jupyter Notebook)
- Power BI

## Key Takeaway
Severe delivery delays and order complexity are strongly associated with lower customer satisfaction, highlighting clear opportunities for operational improvement.
