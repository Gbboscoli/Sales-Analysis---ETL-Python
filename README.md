Car Sales Data Analysis — End-to-End Data Project

Overview

This project simulates a real-world data scenario for a car sales company, covering the full data workflow:

Raw data → Cleaning (ETL) → Analysis → Insights → Basic Modeling

The dataset was intentionally created with inconsistencies (missing values, duplicates, invalid entries) to replicate real business challenges.

Business Goal

Transform messy, unreliable data into structured information capable of supporting decision-making.

Data Model

The project includes core business entities:

Customers
Products (Vehicles)
Sales Transactions
Sales Representatives
Inventory

All datasets were designed to mimic a relational structure commonly found in real systems.

Data Engineering (ETL)

Key steps performed:

Removed duplicates
Handled missing values
Fixed invalid data (negative values, outliers)
Standardized formats
Validated relationships between tables
Created new features (e.g., total sales value, time-based attributes)

Result: A clean, analysis-ready dataset

Data Analysis

Main metrics explored:

Total revenue
Average ticket size
Sales distribution by product
Customer value ranking
Sales performance by representative
Time-based trends
Modeling
Linear Regression

Used to estimate sales trends over time.

Note: Limited reliability due to small dataset size.

Customer Segmentation (K-Means)

Customers segmented based on:

Total purchase value
Purchase volume

Insight:
Data volume directly impacts clustering quality.

Trend Analysis

Sales aggregated over time to identify patterns and potential growth signals.

Key Insights
Revenue is concentrated in a small set of products
A few customers drive most of the revenue
Sales performance varies significantly across representatives
Data quality issues can directly impact business decisions
Limited data reduces effectiveness of advanced models

Limitations
Small dataset (simulation purpose)
Simplified business logic
Models used for demonstration, not production

Tech Stack
Python
Pandas
NumPy
Matplotlib
Scikit-learn
Google Colab

Project Structure
project/
│
├── data/
├── notebooks/
├── outputs/
├── README.md

What This Project Demonstrates
End-to-end data workflow execution
Ability to handle messy, real-world-like data
Strong focus on data quality and validation
Business-oriented analysis
Clear communication of insights

