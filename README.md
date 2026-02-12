## Marketing Campaign Performance & Attribution Modeling
 
[Marketing Campaign Performance And Attribution Modeling.pdf](https://github.com/user-attachments/files/25262678/Marketing.Campaign.Performance.And.Attribution.Modeling.pdf)

# Project Overview:

This project analyzes marketing campaign performance using Python, SQL, and Power BI to evaluate ROI, conversion effectiveness, attribution impact, and revenue growth.

The goal is to:

• Measure campaign performance across channels

• Calculate key marketing KPIs

• Build attribution-ready datasets using SQL

• Analyze trends and correlations

• Predict revenue using regression modeling

• Visualize insights in Power BI dashboards

# Tech Stack:

• Python (Pandas, NumPy, Matplotlib, Seaborn, Scikit-Learn)

• SQL (CTEs, Window Functions, Aggregations, Ranking)

• Power BI

• Jupyter Notebook


 # Python Analysis:
 
🔹 Dataset Features

• Date

•  Source (Google, Facebook, LinkedIn, Email)

•  Campaign (Spring, Summer, Winter, Brand)

• Country (USA, UK, Canada, India)

• Sessions

• Conversions

• Cost

• Revenue

# KPI Engineering:

The following KPIs were created:

conversion_rate = (conversions / sessions) * 100
cpa = cost / conversions
roas = revenue / cost
revenue_per_session = revenue / sessions

# Performance Summary:

• Total Revenue: 151,516.57

• Total Cost: 16,492.38

• Overall ROAS: 9.2

This indicates strong campaign profitability.

# Trend Analysis:

• Revenue trend over time

• 7-day rolling revenue

• Revenue growth %

• Revenue distribution histogram

• Correlation matrix analysis

# Key Insights:

• Strong positive correlation between conversions and revenue

• ROAS varies significantly across campaigns

• Rolling 7-day revenue highlights seasonality patterns

# Campaign Performance:

Top Performing Campaign (by ROAS):

• Spring Campaign

Revenue Performance by Source:

• Facebook & LinkedIn generated highest revenue

• Email had lower ROAS but strong conversion efficiency

# SQL Attribution Modeling:

The SQL script builds a complete attribution-ready dataset using:

🔹 CTE Structure

• base_sessions

• conversion_details

• conversion_counts

• daily_spend

• combined_metrics

• kpi_calculations

• rolling_metrics

• growth_metrics

• ranking_metrics

🔹 Advanced SQL Concepts Used

• Window Functions (LAG, SUM OVER, AVG OVER)

• Rolling 7-day revenue

• Revenue growth %

• Conversion rate %

• CPA calculation

• ROAS ranking

• Revenue ranking within source

This enables full multi-touch attribution-style performance tracking.

# Predictive Modeling:

A Linear Regression model was built to predict revenue.

Features Used:

• Day Number

• Sessions

• Cost

Model Evaluation:

• R² Score: -0.06

• MAE: 7,332.06

The low R² suggests additional features (channel, campaign, lag revenue) would improve performance.

# Power BI Dashboard:

The Power BI dashboard includes:

🔹 Campaign Insights

• Cost vs Revenue comparison

• Campaign acceptance rate

• Campaign response vs complaints

• Family type performance

• Campaign success %

🔹 Customer Analysis

• Age vs Expenditure

• Income by marital status

• Purchase channel breakdown

• Product category performance

# Business Insights from Dashboard:

• Revenue is 3x campaign cost

• Families without children responded better

• Higher campaign response correlates with fewer complaints

• Overall campaign success rate: 50.45%

• Campaign profit: 18K

# Key Business Takeaways:

✔ High ROAS campaigns should receive higher budget allocation
✔ Spring campaigns outperform others consistently
✔ Customer segmentation improves response targeting
✔ Rolling revenue metrics help identify performance shifts
✔ Attribution-based ranking enables smarter channel optimization

# Future Improvements:

• Implement multi-touch attribution model

• Add channel interaction effects

• Improve regression using feature engineering

• Deploy dashboard using Power BI Service

• Automate ETL pipeline

# How to Run:

1️. Python
pip install pandas numpy matplotlib seaborn scikit-learn


Run the Jupyter Notebook.

2️. SQL

Execute Market Campaign Attribution.sql in PostgreSQL / SQL Server.

3️.Power BI

Open .pbix file in Power BI Desktop.
