# SQL Ride-Sharing Analysis

## Project Overview

This project analyzes ride-sharing operations using SQL to uncover insights related to revenue performance, rider behavior, driver productivity, surge pricing impact, and data quality. The analysis was performed on a relational database containing trip, rider, driver, payment, review, and location data.

## Tools & Technologies

- MySQL
- SQL
- VS Code
- Relational Database Design

## SQL Skills Demonstrated

- Data Cleaning & Validation
- Joins (INNER JOIN, LEFT JOIN)
- Aggregations (COUNT, SUM, AVG)
- CASE Statements
- Window Functions
- Data Quality Checks
- Business Performance Analysis
- Trend Analysis

# Business Analysis Results

## Driver Revenue Performance

This analysis evaluates driver productivity by measuring trip volume, revenue generation, and average fare performance.

### Key Findings
- George Gray generated the highest revenue ($4,265.13) across 90 trips.
- Top-performing drivers consistently maintained average fares between $44 and $49.
- Revenue leadership was driven by both trip volume and fare efficiency.
<img width="1053" height="856" alt="top_drivers_revenue" src="https://github.com/user-attachments/assets/7fa1ad79-3129-4dd0-947a-c6a4580daa7f" />

## Rider Spending Analysis

This analysis evaluates rider engagement through trip frequency, total spending, and average fare.

### Key Findings
- Multiple riders completed over 100 trips, demonstrating strong customer retention.
- Emma Cooper generated the highest spending among active riders ($3,943.55).
- Frequent riders contribute significantly to recurring platform revenue.
<img width="1125" height="826" alt="rider_spending_analysis" src="https://github.com/user-attachments/assets/2069a3d3-0a6c-49e8-9354-f3e5f59a4e5f" />

## Revenue by City

This analysis identifies the highest-performing markets based on total ride revenue.

### Key Findings
- Houston generated the highest revenue ($224,894.41).
- Los Angeles and New York also contributed significant revenue.
- Geographic revenue analysis supports market expansion and resource allocation decisions.
<img width="953" height="631" alt="revenue_by_city" src="https://github.com/user-attachments/assets/0dabc8f7-e8ca-4269-9277-194481746c01" />

## Surge Pricing Impact Analysis

This analysis evaluates the relationship between surge pricing, trip demand, revenue generation, and fare performance.

### Key Findings
- Non-surge rides generated 60.44% of total platform revenue.
- High-surge rides generated $189,445.27 despite significantly lower trip volume.
- Average fares increased from $28.66 during normal demand periods to $71.35 during high-surge periods.
- Surge pricing serves as a major revenue optimization mechanism during peak demand.
<img width="970" height="742" alt="surge_pricing_impact" src="https://github.com/user-attachments/assets/1efe24f2-26e9-430f-a79c-15338e53c6e6" />

## Monthly Revenue Trend Analysis

This analysis tracks revenue performance over time to identify trends and seasonal demand patterns.

### Key Findings
- Monthly revenue remained relatively stable between $22K and $25K.
- October 2022 generated the highest monthly revenue ($25,521.86).
- Trend analysis supports forecasting, budgeting, and operational planning.
<img width="972" height="792" alt="monthly_revenue_trend" src="https://github.com/user-attachments/assets/e4bdf278-cc44-4975-aa31-02549fa0afcf" />

# Data Quality & Validation

## Missing Phone Number Validation

Data quality checks identified user records with missing phone information.

### Key Findings
- Multiple customer records contained missing phone numbers.
- Missing contact information can impact customer support and communication processes.
- Validation checks improve dataset reliability before analysis.
<img width="1162" height="860" alt="missing_phone_validation" src="https://github.com/user-attachments/assets/1953d516-e6ca-40ce-8978-6ca6a86a1e10" />

## Trip Status Validation

This validation was performed to confirm whether missing completion timestamps were valid based on trip status.

### Key Findings
- 16,827 trips were successfully completed.
- 2,966 trips were cancelled.
- 207 trips remained in progress.
- Status validation helped distinguish legitimate operational states from potential data quality issues.
<img width="967" height="447" alt="trip_status_validation" src="https://github.com/user-attachments/assets/62dda539-8519-40fe-bd69-04103821e598" />

# Database Schema

The database consists of the following tables:

- Users
- Riders
- Drivers
- Trips
- Payments
- Reviews
- Locations
- Cancellations
The schema supports operational, customer, financial, and location-based ride-sharing analytics.

# Key Business Insights

- Houston emerged as the highest-revenue market.
- Frequent riders represent a major source of recurring revenue.
- Surge pricing significantly increases average fare and revenue contribution.
- Driver performance varies considerably across trip volume and revenue metrics.
- Data quality validation is essential to ensure accurate business reporting and analytics.

## Conclusion

This project demonstrates end-to-end SQL analytics, including database schema design, data cleaning, data validation, business intelligence reporting, trend analysis, and operational performance evaluation using a ride-sharing dataset. The analysis provides actionable insights into revenue growth, customer behavior, driver performance, and pricing strategy.







