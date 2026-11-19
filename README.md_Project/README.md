# Indian E-commerce Business Intelligence & Performance Analytics (2023–2025)

## Project Overview

This project focuses on analyzing an Indian e-commerce business using SQL, Python, and Power BI to understand business performance and identify opportunities for improvement.

The analysis covers sales performance, customer behaviour, product profitability, delivery operations, returns, and marketing campaign performance.

The objective is to transform raw e-commerce data into meaningful business insights that can support better decision-making.

## Tools & Technologies

- SQL Server: Data querying, data analysis, and business problem-solving.
- Python: Exploratory Data Analysis (EDA), data cleaning, and visualization.
- Pandas & NumPy: Data manipulation and numerical analysis.
- Matplotlib & Seaborn: Data visualization.
- Power BI: Interactive dashboards and business performance reporting.
- Jupyter Notebook: Python analysis and documentation.
- VS Code: Development environment.

## Dataset Description

The project uses a synthetic Indian e-commerce dataset covering the period from January 2023 to December 2025.

The dataset contains nine interconnected tables:

- Customers
- Products
- Orders
- Order Items
- Payments
- Shipments
- Returns
- Customer Reviews
- Marketing Campaigns

The dataset includes information about customer purchases, product performance, payments, delivery operations, returns, customer feedback, and marketing activities.

Note: The dataset is synthetic and is used for educational and portfolio analysis purposes. It does not represent actual transactions from a real e-commerce company.

## Project Objectives

- Analyze overall sales performance and revenue trends.
- Identify top-performing products and product categories.
- Understand customer purchasing behaviour and customer segments.
- Evaluate product profitability and discount impact.
- Analyze delivery performance across shipping methods.
- Identify major product return reasons.
- Evaluate marketing campaign performance and attributed revenue.
- Generate actionable business insights and recommendations.

## SQL Analysis

SQL Server was used to perform structured business analysis across the e-commerce database.

The analysis included:

- Overall sales and order performance.
- Yearly and monthly revenue trends.
- State-wise revenue comparison.
- Customer segmentation and repeat purchase analysis.
- Top-performing products and categories.
- Product profitability and profit margins.
- Order returns and return reasons.
- Delivery performance and shipping method analysis.
- Marketing campaign performance and revenue analysis.

A total of 23 SQL queries were developed to answer key business questions.

## Python Exploratory Data Analysis (EDA)

Performed data exploration and statistical analysis using Python to uncover business patterns.

- Conducted data quality checks and examined data distributions.
- Analyzed order values, customer spending, and high-value customer contribution.
- Evaluated discount–profit relationships using correlation analysis.
- Examined delivery time patterns and visualized key findings.
- Used Pandas, NumPy, Matplotlib, and Seaborn for analysis and visualization.

## Power BI Dashboard

Built a 3-page interactive dashboard to translate business data into actionable insights.

- Executive Overview: Sales KPIs, revenue trends, order volume, and state-wise performance.
- Customer & Product: Customer distribution, top products, category revenue, and product performance.
- Operations & Marketing: Delivery efficiency, return patterns, and top campaign performance.

Used interactive visuals, KPI cards, filters, and business-focused reporting.

## Key Business Insights

- Revenue Growth: 2025 revenue increased by 74.33% compared with 2024.
- Customer Loyalty: Repeat purchase rate reached 82.87%.
- Customer Concentration: Top 10% of customers contributed 38.45% of total customer spending.
- Product Profitability: Fashion achieved the highest profit margin at 33.14%, while Electronics generated the highest revenue.
- Delivery Performance: 41.76% of shipments were classified as delayed.
- Product Returns: 9.51% of orders were returned.
- Marketing Performance: Campaigns generated ₹43.63 Cr in attributed revenue against ₹18.71 Cr in campaign costs.

## Business Recommendations

- Strengthen retention strategies for high-value and repeat customers.
- Review low-margin product categories and discount strategies.
- Investigate delivery delays across shipping methods.
- Address major return drivers to improve customer experience.
- Optimize marketing budgets based on campaign performance.

## Project Structure


E-Commerce DA project/
│
├── Dataset 1/
├── SQL/
│   └── 01_SQL_Business_Analysis.sql
├── Python/
│   └── Python_EDA.ipynb
├── Power BI/
│   └── Indian_Ecommerce_Analytics.pbix
└── README.md


## Notes & Assumptions

- The dataset is synthetic and intended for educational and portfolio analysis.
- Marketing funnel and attributed performance metrics are illustrative, not verified real-world campaign results.
- Marketing revenue-to-cost ratio represents attributed revenue per ₹1 spent, not net profit ROI.
- Revenue figures represent total order value and should not be interpreted as net revenue after refunds.