#  DataAnalytics-Assessment

## High-Value Customers with Multiple Products

# Objective 
Identify users who have at least one funded savings plan and one funded investment plan, and calculate their total confirmed deposits.

## Approach: 
- I first aggregated plan types per customer using a CTE (user_plans) to count savings and investment plans separately.
- I then used another CTE (user_deposits) to calculate total confirmed deposits from the savings_savingsaccount table, converting from Kobo to Naira.
- The final query joins users_customuser with both CTEs and filters for customers who own both types of plans.
- The result is sorted by total deposits in descending order.

## Why CTE? 
Using CTEs made the query more modular, improved performance by reducing join multiplicity, and helped avoid timeout issues in MySQL.

## Result 
![Q1 Result](https://github.com/folorunsoajala/DataAnalytics-Assessment/blob/main/Q1_Result.png)

---

# Transaction Frequency Analysis

## Objective 
Segment customers based on how often they perform transactions per month.

## Approach
- I first grouped transactions by owner_id and month using DATE_FORMAT() to get monthly transaction counts.
- Then, I averaged those counts per customer to get their overall monthly transaction frequency.
- Using a CASE expression, I categorized customers into High, Medium, and Low frequency bands.
- Finally, I aggregated the results to report total customer count and average transactions per frequency group.
![Q2_Result](https://github.com/folorunsoajala/DataAnalytics-Assessment/blob/main/Q2_Result.png)

---
# Account Inactivity Alert

## Objective
Identify savings or investment accounts with no inflow transactions in the past 365 days.

## Approach  
- First, I found the most recent inflow (`MAX(transaction_date)) per plan_id using a subquery.
- I then joined this with the `plans_plan table to classify each plan as 'Savings' or 'Investment' based on flags.
- Using `DATEDIFF(), I calculated inactivity in days.
- The final output includes only accounts inactive for more than one year.

![Q3_Result](https://github.com/folorunsoajala/DataAnalytics-Assessment/blob/main/Q3_Result.png)

---
# Customer Lifetime Value (CLV) Estimation

## Objective 
Estimate customer lifetime value using tenure and transaction volume, with a simplified profit model.

## Approach
- I first calculated each user's account tenure in months from the `date_joined column.
- Then I counted all transactions in the `savings_savingsaccount table.
- I applied the given CLV formula using a fixed profit-per-transaction of 0.1%.
- Finally, I joined these results and sorted
![Q4_Result](https://github.com/folorunsoajala/DataAnalytics-Assessment/blob/main/Q4_Result.png)














