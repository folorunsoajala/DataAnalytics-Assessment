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









