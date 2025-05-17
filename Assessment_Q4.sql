-- Q4: Customer Lifetime Value (CLV) Estimation

WITH user_transactions AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions
    FROM savings_savingsaccount
    GROUP BY owner_id
),
user_tenure AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
)
SELECT 
    ut.customer_id,
    ut.name,
    ut.tenure_months,
    ut2.total_transactions,
    ROUND((ut2.total_transactions / ut.tenure_months) * 12 * 0.001, 2) AS estimated_clv
FROM user_tenure ut
JOIN user_transactions ut2 ON ut.customer_id = ut2.owner_id
WHERE ut.tenure_months > 0
ORDER BY estimated_clv DESC;
