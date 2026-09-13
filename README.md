# Coffee Shop Sales Analysis

## Project Overview

This project analyzes sales data from Maven Roasters, a fictional coffee shop chain operating across three locations in New York City.

The goal of the project is to analyze sales performance, identify key revenue drivers, understand customer purchasing patterns, and build an interactive Power BI report for business reporting.

The project covers the full analytical workflow:

- Data quality assessment and preparation
- SQL-based data analysis
- Exploratory Data Analysis in Python
- DAX calculations and interactive Power BI dashboards
- Business insights and recommendations


## Dashboard Preview

### Sales Overview

### Product & Sales Performance


## Business Context

Maven Roasters operates three coffee shop locations:

- Astoria
- Hell's Kitchen
- Lower Manhattan

The dataset contains transaction-level sales data for January–June 2023.

The analysis focuses on several business areas:

- Overall sales performance
- Sales trends over time
- Store performance
- Product and category performance
- Sales patterns by hour and weekday
- Transaction characteristics
- Product contribution to total revenue


## Business Questions

The analysis aims to answer the following questions:

### Sales Performance
- How much revenue was generated during the analyzed period?
- How many transactions and items were sold?
- What is the average transaction value?
- How does sales performance change over time?

### Store Performance
- Which store generates the highest revenue?
- How does transaction volume differ between stores?
- How does product category performance vary across locations?

### Product Performance
- Which product types generate the most revenue?
- Which product categories contribute most to total revenue?
- How concentrated is revenue among the top-performing products?
- Does the product mix differ between stores?

### Sales Patterns
- What are the busiest hours of the day?
- Which weekdays generate the most revenue and transactions?
- Are there noticeable differences in sales patterns across weekdays and hours?

### Transaction Analysis
- What does the distribution of transaction revenue look like?
- How do average and median transaction revenues compare?
- How does the number of items in a transaction relate to transaction revenue?
- Does average unit price change with transaction quantity?


## Tools & Technologies

- **PostgreSQL** — data validation, transformation and SQL analysis
- **Python** — exploratory data analysis
- **Pandas & NumPy** — data manipulation and analysis
- **Matplotlib** — data visualization
- **Power BI** — interactive dashboards and reporting
- **DAX** — calculated measures and time-based analysis
- **GitHub** — project documentation and version control


## Project Structure

```text
coffee-sales-analysis/
│
├── README.md
│
├── data/
│   └── coffee_sales.csv
│
├── sql/
│   └── coffee_sales_analysis.sql
│
├── python/
│   └── coffee_sales_eda.ipynb
│
└── power_bi/
    ├── coffee_sales_dashboard.pbix
    └── screenshots/
        ├── sales_overview.png
        └── product_performance.png

