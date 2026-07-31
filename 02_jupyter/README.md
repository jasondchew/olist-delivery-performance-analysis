# Python Data Cleaning & Validation

This folder contains the Jupyter notebooks used to validate and clean the final dataset generated from SQL.

## Files
- `olist_python_cleaning_validation.ipynb` — first-pass integrity checks and validation
- `olist_python_cleaning_enriched_dataset_round_two.ipynb` — cleaning of the enriched, feature-engineered dataset

## Purpose
After building the dataset in SQL, Python was used to:
- Verify data integrity
- Identify and remove duplicates
- Handle missing values
- Prepare a clean dataset for visualization

## Key Steps
- Loaded exported SQL dataset into pandas
- Checked for duplicate rows and ensured one row per order
- Investigated missing values (e.g., review scores)
- Validated distributions of key features:
  - Delay days
  - Review scores
  - Order value
- Ensured data consistency before Power BI integration

## Tools Used
- Python
- pandas
- Jupyter Notebook

## Why Python was used
While SQL handled the heavy data transformation, Python provided:
- Flexible validation checks
- Faster iteration for data quality issues
- Additional confidence in the final dataset

## Output
The result is a clean, analysis-ready dataset used for:
- Power BI dashboard development
- Final business insights
