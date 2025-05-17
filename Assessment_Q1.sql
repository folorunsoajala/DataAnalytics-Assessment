
--  High-Value Customers with Multiple Products

WITH user_plans AS (
    SELECT 
        owner_id,
        COUNT(DISTINCT CASE WHEN is_regular_savings = 1 THEN id END) AS savings_count,
        COUNT(DISTINCT CASE WHEN is_a_fund = 1 THEN id END) AS investment_count
    FROM plans_plan
    GROUP BY owner_id
),
user_deposits AS (
    SELECT owner_id, SUM(confirmed_amount) / 100 AS total_deposits
    FROM savings_savingsaccount
    GROUP BY owner_id
)
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    p.savings_count,
    p.investment_count,
    ROUND(d.total_deposits, 2) AS total_deposits
FROM users_customuser u
JOIN user_plans p ON u.id = p.owner_id
JOIN user_deposits d ON u.id = d.owner_id
WHERE p.savings_count >= 1 AND p.investment_count >= 1
ORDER BY total_deposits DESC

