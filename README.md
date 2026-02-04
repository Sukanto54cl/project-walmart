![Python](https://img.shields.io/badge/Python-3.12-blue)
![Postgres](https://img.shields.io/badge/DB-PostgreSQL-blue)
![Status](https://img.shields.io/badge/status-active-success)
![License](https://img.shields.io/badge/license-MIT-green)

## Walmart Sales Analysis

Data was downloaded using the Kaggle API, requiring API token authentication and command-line setup.  

**Tools:** Python (Pandas), PostgreSQL, SQL  
**Dataset:** [Kaggle – Walmart Sales Data](https://www.kaggle.com/datasets/najir0123/walmart-10k-sales-datasets)

**Objective:**  
Analyze sales performance, revenue trends, profitability, and customer behavior across Walmart branches to extract actionable business insights.

---

### Key Insights
- Identified **top profit-generating product categories**
- Analyzed **year-over-year revenue decline (2022 → 2023)** across branches
- Determined **peak sales periods** by categorizing transactions into time-of-day shifts

---

### Skills Demonstrated
- Data cleaning and preprocessing using **Pandas**
- Advanced **SQL** (CTEs, window functions, aggregations)
- Business metrics analysis (revenue, profit, growth/decline ratios)

---

## Acknowledgements
This project was inspired by and partially adapted from an MIT-licensed repository:  
https://github.com/najirh/Walmart_SQL_Python.git

---
## Project Structure

```text
project-walmart/
├── sql_queries/
│   ├── psql1.sql
├── notebooks/
│   └── data_clean.ipynb
├── data/
│   └── walmart_sales.csv
└── README.md

